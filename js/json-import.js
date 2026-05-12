// ============================================================
//  JSON Import — Carga masiva de procedimientos desde archivo
//  Hospital Santa Margarita · SGC ISO 9001:2015
// ============================================================

// ── Helpers de transformación ────────────────────────────────

/** "23 Septiembre 2025" → "2025-09-23" */
function _parseFecha(str) {
  if (!str) return null
  const meses = {
    enero:'01', febrero:'02', marzo:'03', abril:'04', mayo:'05', junio:'06',
    julio:'07', agosto:'08', septiembre:'09', octubre:'10', noviembre:'11', diciembre:'12'
  }
  const m = str.trim().toLowerCase().match(/^(\d{1,2})\s+(\w+)\s+(\d{4})$/)
  if (!m) return null
  const mes = meses[m[2]]
  if (!mes) return null
  return `${m[3]}-${mes}-${m[1].padStart(2,'0')}`
}

/** "PR-CH-01" → "PR" */
function _typePrefix(code) { return code.split('-')[0] }

/** "PR-CH-01" → "CH" */
function _deptCode(code) {
  const parts = code.split('-')
  return parts.length >= 2 ? parts[1] : null
}

/** definiciones: objeto {term:def} o array [{termino,definicion}] → array estándar */
function _normDefiniciones(raw) {
  if (!raw) return []
  if (Array.isArray(raw)) return raw.map(d => ({ termino: d.termino ?? d.term ?? '', definicion: d.definicion ?? d.def ?? '' }))
  return Object.entries(raw).map(([termino, definicion]) => ({ termino, definicion }))
}

/** responsabilidades: objeto o array → [{tipo, descripcion}] */
function _normResponsabilidades(raw) {
  if (!raw) return []
  if (Array.isArray(raw)) return raw
  return [
    { tipo: '4.1 Actualización', descripcion: raw.actualizacion ?? '' },
    { tipo: '4.2 Ejecución',     descripcion: raw.ejecucion     ?? '' },
    { tipo: '4.3 Supervisión',   descripcion: raw.supervision   ?? '' }
  ].filter(r => r.descripcion)
}

/** alcance: string u objeto → string */
function _normAlcance(raw) {
  if (!raw) return null
  if (typeof raw === 'string') return raw
  return [raw.descripcion, raw.frecuencia].filter(Boolean).join('\n\n')
}

/** desarrollo_del_proceso → [{no, responsable, actividad}] */
function _normDesarrollo(raw) {
  if (!Array.isArray(raw)) return []
  return raw.map(p => ({ no: p.paso ?? p.no ?? '', responsable: p.responsable ?? '', actividad: p.actividad ?? '' }))
}

/** gestion_de_riesgos → [{riesgo, barrera}] */
function _normRiesgos(raw) {
  if (!Array.isArray(raw)) return []
  return raw.map(r => ({ riesgo: r.riesgo ?? '', barrera: r.barrera_seguridad ?? r.barrera ?? '' }))
}

/** anexos_formatos → [{nombre, codigo}] */
function _normReferencias(raw) {
  if (!Array.isArray(raw)) return []
  return raw.map(r => ({ nombre: r.nombre ?? '', codigo: r.codigo ?? '' }))
}

/** control_de_cambios → [{version, fecha, descripcion, realizado, aprobado}] */
function _normControlCambios(raw) {
  if (!Array.isArray(raw)) return []
  return raw.map(c => ({
    version:     c.version    ?? '',
    fecha:       c.fecha      ?? '',
    descripcion: c.descripcion_del_cambio ?? c.descripcion ?? '',
    realizado:   c.realizado  ?? '',
    aprobado:    c.aprobado   ?? ''
  }))
}

// ── Validación mínima ────────────────────────────────────────

function _validate(json) {
  const errors = []
  if (!json?.documento?.codigo) errors.push('Falta documento.codigo')
  if (!json?.documento?.nombre) errors.push('Falta documento.nombre')
  return errors
}

// ── Upsert de un documento ───────────────────────────────────

async function _importOne(json, catalogs) {
  const { typesMap, deptsMap } = catalogs
  const doc = json.documento
  const code = doc.codigo.trim().toUpperCase()

  // IDs de catálogos
  const typeId = typesMap[_typePrefix(code)] ?? null
  const deptId = deptsMap[_deptCode(code)]  ?? null

  const auth = json.autorizacion_final ?? {}

  // ── 1. Upsert en documents ──────────────────────────────────
  const docPayload = {
    code,
    name:               doc.nombre,
    current_version:    doc.version_vigente ?? '1.0',
    status:             'vigente',
    elaboration_date:   _parseFecha(doc.fecha_emision),
    elaborated_by:      auth.elaboro ?? null,
    reviewed_by:        auth.reviso  ?? null,
    custodian_position: null,          // no viene en JSON; no sobrescribir si ya existe
    updated_at:         new Date().toISOString(),
    ...(typeId ? { document_type_id: typeId } : {}),
    ...(deptId ? { department_id:   deptId } : {})
  }

  // Si ya existe, NO sobreescribir department_id/type_id con null
  if (!typeId) delete docPayload.document_type_id
  if (!deptId) delete docPayload.department_id

  const { data: savedDoc, error: docErr } = await db
    .from('documents')
    .upsert(docPayload, { onConflict: 'code' })
    .select('id, code')
    .single()

  if (docErr) throw new Error(`documents: ${docErr.message}`)

  // ── 2. Upsert en document_content ──────────────────────────
  const contentPayload = {
    document_id:       savedDoc.id,
    objetivo:          json.objetivo ?? null,
    alcance:           _normAlcance(json.alcance),
    definiciones:      _normDefiniciones(json.definiciones),
    responsabilidades: _normResponsabilidades(json.responsabilidades),
    desarrollo:        _normDesarrollo(json.desarrollo_del_proceso),
    gestion_riesgos:   _normRiesgos(json.gestion_de_riesgos),
    referencias:       _normReferencias(json.anexos_formatos),
    control_cambios:   _normControlCambios(json.control_de_cambios),
    elaborado_por:     auth.elaboro  ?? null,
    cargo_elaboro:     null,
    revisado_por:      auth.reviso   ?? null,
    cargo_reviso:      null,
    autorizado_por:    auth.autorizo ?? null,
    cargo_autorizo:    null,
    updated_at:        new Date().toISOString()
  }

  const { error: contentErr } = await db
    .from('document_content')
    .upsert(contentPayload, { onConflict: 'document_id' })

  if (contentErr) throw new Error(`document_content: ${contentErr.message}`)

  return savedDoc.code
}

// ── Carga de catálogos (tipos y departamentos) ───────────────

async function _loadCatalogs() {
  const [{ data: types }, { data: depts }] = await Promise.all([
    db.from('document_types').select('id, code_prefix'),
    db.from('departments').select('id, code')
  ])
  return {
    typesMap: Object.fromEntries((types ?? []).map(t => [t.code_prefix, t.id])),
    deptsMap: Object.fromEntries((depts ?? []).map(d => [d.code,        d.id]))
  }
}

// ── Leer archivo como JSON ───────────────────────────────────

function _readFileAsJSON(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader()
    reader.onload = e => {
      try { resolve(JSON.parse(e.target.result)) }
      catch { reject(new Error(`JSON inválido en "${file.name}"`)) }
    }
    reader.onerror = () => reject(new Error(`No se pudo leer "${file.name}"`))
    reader.readAsText(file)
  })
}

// ── Punto de entrada principal ───────────────────────────────

async function importarJSONs(files) {
  const results = { insertados: [], actualizados: [], fallidos: [] }

  // Verificar si los docs ya existen (para distinguir insert vs update)
  const codes = []
  const jsons = []

  for (const file of files) {
    try {
      const json = await _readFileAsJSON(file)
      const errs = _validate(json)
      if (errs.length) {
        results.fallidos.push({ archivo: file.name, motivo: errs.join(', ') })
        continue
      }
      jsons.push({ file, json })
      codes.push(json.documento.codigo.trim().toUpperCase())
    } catch (e) {
      results.fallidos.push({ archivo: file.name, motivo: e.message })
    }
  }

  if (!jsons.length) return results

  const { data: existing } = await db
    .from('documents')
    .select('code')
    .in('code', codes)
  const existingCodes = new Set((existing ?? []).map(d => d.code))

  const catalogs = await _loadCatalogs()

  for (const { file, json } of jsons) {
    const code = json.documento.codigo.trim().toUpperCase()
    try {
      await _importOne(json, catalogs)
      if (existingCodes.has(code)) results.actualizados.push(code)
      else results.insertados.push(code)
    } catch (e) {
      results.fallidos.push({ archivo: file.name, motivo: e.message })
    }
  }

  return results
}

// ── UI: abrir selector de archivos ──────────────────────────

function openImportJSON() {
  document.getElementById('json-import-input').click()
}

async function handleImportFiles(event) {
  const files = Array.from(event.target.files)
  if (!files.length) return

  // Reset input para permitir recargar el mismo archivo
  event.target.value = ''

  // Mostrar modal con spinner
  const modal   = document.getElementById('modal-import')
  const content = document.getElementById('import-result')
  content.innerHTML = '<div class="import-spinner"><i class="fa-solid fa-spinner fa-spin"></i> Procesando...</div>'
  modal.classList.add('active')

  try {
    const res = await importarJSONs(files)

    let html = `<div class="import-summary">`
    html += `<div class="import-stat ok"><i class="fa-solid fa-circle-plus"></i> <strong>${res.insertados.length}</strong> insertado(s)</div>`
    html += `<div class="import-stat upd"><i class="fa-solid fa-rotate"></i> <strong>${res.actualizados.length}</strong> actualizado(s)</div>`
    html += `<div class="import-stat err"><i class="fa-solid fa-triangle-exclamation"></i> <strong>${res.fallidos.length}</strong> fallido(s)</div>`
    html += `</div>`

    if (res.insertados.length) {
      html += `<details open><summary>Insertados</summary><ul>${res.insertados.map(c=>`<li>${c}</li>`).join('')}</ul></details>`
    }
    if (res.actualizados.length) {
      html += `<details open><summary>Actualizados</summary><ul>${res.actualizados.map(c=>`<li>${c}</li>`).join('')}</ul></details>`
    }
    if (res.fallidos.length) {
      html += `<details open><summary>Fallidos</summary><ul>${res.fallidos.map(f=>`<li><strong>${f.archivo}</strong>: ${f.motivo}</li>`).join('')}</ul></details>`
    }

    content.innerHTML = html

    // Recargar tabla si hubo cambios
    if (res.insertados.length || res.actualizados.length) {
      if (typeof loadDocuments === 'function') loadDocuments()
    }

  } catch (e) {
    content.innerHTML = `<p class="import-error"><i class="fa-solid fa-circle-xmark"></i> Error inesperado: ${e.message}</p>`
  }
}
