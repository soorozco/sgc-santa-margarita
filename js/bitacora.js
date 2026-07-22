// ─── Bitácora de Cambios ─────────────────────────────────────────
// Consulta de audit_log: quién creó, modificó o eliminó cada registro.
// Solo lectura: la bitácora no se puede editar desde ningún lado.

let _user = null, _profile = null, _role = null
let _perfiles = {}        // user_id → nombre
let _pagina = 0
let _total  = 0
let _filas  = []
const POR_PAGINA = 50

const ROLES_BITACORA = ['administrador', 'responsable_calidad', 'auditor']

// Nombre legible de cada tabla. Las que no estén aquí se muestran
// con su nombre técnico (mejor eso que ocultarlas).
const TABLAS = {
  documents: 'Documentos', document_content: 'Contenido de documentos',
  document_versions: 'Versiones de documento', document_types: 'Tipos de documento',
  document_deactivation_requests: 'Solicitudes de baja',
  document_code_requests: 'Solicitudes de código',
  departments: 'Departamentos', profiles: 'Usuarios', roles: 'Roles',
  personal: 'Directorio de personal',
  clinical_incidents: 'Incidentes clínicos', quejas: 'Quejas y sugerencias',
  quejas_notas: 'Notas de quejas',
  satisfaction_surveys: 'Encuestas de satisfacción',
  quality_indicators: 'Indicadores de calidad',
  indicator_measurements: 'Mediciones de indicadores',
  risk_processes: 'Gestión de riesgos', interested_parties: 'Partes interesadas',
  auditorias_internas: 'Auditorías internas', auditorias_externas: 'Auditorías externas',
  plan_anual_auditorias: 'Plan anual de auditorías',
  planes_correctivos: 'Planes correctivos',
  committees: 'Comités', committee_members: 'Integrantes de comité',
  committee_sessions: 'Sesiones de comité', session_agreements: 'Acuerdos de sesión',
  session_attendance: 'Asistencia a sesiones',
  pharmacy_pft: 'Perfil farmacoterapéutico',
  pharmacy_med_catalog: 'Catálogo de medicamentos',
  pharmacy_interactions: 'Interacciones medicamentosas',
  pharmacy_ledger_entries: 'Libros de controlados',
  pharmacy_shift_logs: 'Bitácora entrega de turno',
  pharmacy_controlled_counts: 'Conteo de controlados',
  pharmacy_dispensing_log: 'Dispensación de controlados',
  pharmacy_clinical_patients: 'Pacientes de farmacia clínica',
  pharmacy_clinical_notes: 'Notas de farmacia clínica',
  rrhh_staff: 'Personal (RRHH)', rrhh_requests: 'Solicitudes (RRHH)',
  rrhh_shifts: 'Turnos (RRHH)', rrhh_survey_responses: 'Encuestas (RRHH)',
}

const ACCIONES = {
  INSERT: { txt: 'Creó',     cls: 'acc-ins', ico: 'fa-plus' },
  UPDATE: { txt: 'Modificó', cls: 'acc-upd', ico: 'fa-pen' },
  DELETE: { txt: 'Eliminó',  cls: 'acc-del', ico: 'fa-trash' },
}

// Campos internos que no aportan nada al leer un cambio
const OCULTOS = new Set(['id', 'created_at', 'updated_at', 'search_vector'])

// ── Init ────────────────────────────────────────────────────────
async function initBitacora() {
  const auth = await requireAuth()
  if (!auth) return
  _user = auth.user; _profile = auth.profile
  _role = auth.profile?.roles?.name || 'lector'
  renderUserInfo()

  if (!ROLES_BITACORA.includes(_role)) {
    document.getElementById('bit-content').innerHTML = `
      <div class="access-denied">
        <i class="fa-solid fa-lock"></i>
        <h3>Acceso restringido</h3>
        <p>La bitácora de cambios solo está disponible para Dirección,
           Calidad y Auditoría.</p>
      </div>`
    return
  }

  await cargarPerfiles()
  llenarFiltroTablas()
  await cargar()
}

// La bitácora guarda el id del usuario; los nombres viven en profiles.
// No hay relación directa entre ambas tablas, así que los traemos aparte.
async function cargarPerfiles() {
  const { data } = await db.from('profiles').select('id, full_name')
  const sel = document.getElementById('f-usuario')
  ;(data || [])
    .sort((a, b) => (a.full_name || '').localeCompare(b.full_name || '', 'es'))
    .forEach(p => {
      _perfiles[p.id] = p.full_name || '—'
      sel.add(new Option(p.full_name || p.id, p.id))
    })
}

function llenarFiltroTablas() {
  const sel = document.getElementById('f-tabla')
  Object.entries(TABLAS)
    .sort((a, b) => a[1].localeCompare(b[1], 'es'))
    .forEach(([k, v]) => sel.add(new Option(v, k)))
}

// ── Carga ───────────────────────────────────────────────────────
async function cargar() {
  const cuerpo = document.getElementById('bit-tbody')
  cuerpo.innerHTML = `<tr><td colspan="5" class="bit-vacio">
    <i class="fa-solid fa-spinner fa-spin"></i> Cargando…</td></tr>`

  let q = db.from('audit_log')
            .select('*', { count: 'exact' })
            .order('created_at', { ascending: false })

  const tabla  = document.getElementById('f-tabla').value
  const accion = document.getElementById('f-accion').value
  const desde  = document.getElementById('f-desde').value
  const hasta  = document.getElementById('f-hasta').value
  const quien  = document.getElementById('f-usuario').value

  if (tabla)  q = q.eq('table_name', tabla)
  if (accion) q = q.eq('action', accion)
  if (quien)  q = q.eq('user_id', quien)
  if (desde)  q = q.gte('created_at', `${desde}T00:00:00`)
  if (hasta)  q = q.lte('created_at', `${hasta}T23:59:59`)

  const desdeFila = _pagina * POR_PAGINA
  const { data, count, error } = await q.range(desdeFila, desdeFila + POR_PAGINA - 1)

  if (error) {
    cuerpo.innerHTML = `<tr><td colspan="5" class="bit-vacio">
      <i class="fa-solid fa-triangle-exclamation"></i>
      No se pudo leer la bitácora: ${error.message}</td></tr>`
    return
  }

  _filas = data || []
  _total = count || 0
  pintar()
}

function pintar() {
  const cuerpo = document.getElementById('bit-tbody')

  if (!_filas.length) {
    cuerpo.innerHTML = `<tr><td colspan="5" class="bit-vacio">
      <i class="fa-solid fa-inbox"></i>
      No hay movimientos con estos filtros.</td></tr>`
    document.getElementById('bit-paginacion').innerHTML = ''
    return
  }

  cuerpo.innerHTML = _filas.map((f, i) => {
    const a = ACCIONES[f.action] || { txt: f.action, cls: '', ico: 'fa-circle' }
    const nCambios = f.action === 'UPDATE' ? camposCambiados(f).length : null
    return `
      <tr onclick="verDetalle(${i})">
        <td class="bit-fecha">${fechaHora(f.created_at)}</td>
        <td>${escapa(quienFue(f))}</td>
        <td><span class="bit-acc ${a.cls}"><i class="fa-solid ${a.ico}"></i>${a.txt}</span></td>
        <td>${escapa(TABLAS[f.table_name] || f.table_name || '—')}</td>
        <td class="bit-resumen">${escapa(resumen(f))}${
          nCambios !== null ? ` <small>(${nCambios} campo${nCambios === 1 ? '' : 's'})</small>` : ''}</td>
      </tr>`
  }).join('')

  const paginas = Math.ceil(_total / POR_PAGINA)
  const desde = _pagina * POR_PAGINA + 1
  const hasta = Math.min((_pagina + 1) * POR_PAGINA, _total)
  document.getElementById('bit-paginacion').innerHTML = `
    <span>${desde.toLocaleString('es-MX')}–${hasta.toLocaleString('es-MX')}
          de ${_total.toLocaleString('es-MX')} movimientos</span>
    <div>
      <button class="btn-pag" ${_pagina === 0 ? 'disabled' : ''} onclick="irPagina(${_pagina - 1})">
        <i class="fa-solid fa-chevron-left"></i> Anterior</button>
      <button class="btn-pag" ${_pagina >= paginas - 1 ? 'disabled' : ''} onclick="irPagina(${_pagina + 1})">
        Siguiente <i class="fa-solid fa-chevron-right"></i></button>
    </div>`
}

function irPagina(n) { _pagina = n; cargar(); window.scrollTo(0, 0) }
function aplicarFiltros() { _pagina = 0; cargar() }
function limpiarFiltros() {
  ['f-tabla', 'f-accion', 'f-desde', 'f-hasta', 'f-usuario']
    .forEach(id => { document.getElementById(id).value = '' })
  _pagina = 0; cargar()
}

// ── Detalle ─────────────────────────────────────────────────────
function verDetalle(i) {
  const f = _filas[i]
  if (!f) return
  const a = ACCIONES[f.action] || { txt: f.action, cls: '' }

  let cuerpo = ''
  if (f.action === 'UPDATE') {
    const cambios = camposCambiados(f)
    cuerpo = cambios.length
      ? `<table class="det-tabla">
           <thead><tr><th>Campo</th><th>Antes</th><th>Después</th></tr></thead>
           <tbody>${cambios.map(c => `
             <tr>
               <td class="det-campo">${escapa(c.campo)}</td>
               <td class="det-antes">${escapa(valor(c.antes))}</td>
               <td class="det-despues">${escapa(valor(c.despues))}</td>
             </tr>`).join('')}
           </tbody>
         </table>`
      : `<p class="bit-vacio">No se registraron diferencias visibles.</p>`
  } else {
    // Creación o eliminación: mostramos el registro completo
    const datos = f.action === 'DELETE' ? f.old_values : f.new_values
    const campos = Object.entries(datos || {}).filter(([k]) => !OCULTOS.has(k))
    cuerpo = campos.length
      ? `<table class="det-tabla">
           <thead><tr><th>Campo</th><th>Valor</th></tr></thead>
           <tbody>${campos.map(([k, v]) => `
             <tr><td class="det-campo">${escapa(k)}</td>
                 <td>${escapa(valor(v))}</td></tr>`).join('')}
           </tbody>
         </table>`
      : `<p class="bit-vacio">Sin datos.</p>`
  }

  document.getElementById('det-titulo').innerHTML =
    `<span class="bit-acc ${a.cls}">${a.txt}</span> ${escapa(TABLAS[f.table_name] || f.table_name)}`
  document.getElementById('det-meta').innerHTML = `
    <div><label>Usuario</label>${escapa(quienFue(f))}</div>
    <div><label>Fecha y hora</label>${fechaHora(f.created_at)}</div>
    <div><label>Tabla</label><code>${escapa(f.table_name || '—')}</code></div>
    <div><label>Registro</label><code>${escapa(f.record_id || '—')}</code></div>`
  document.getElementById('det-cuerpo').innerHTML = cuerpo
  document.getElementById('modal-detalle').classList.add('open')
}

function cerrarDetalle() {
  document.getElementById('modal-detalle').classList.remove('open')
}

// ── Utilidades ──────────────────────────────────────────────────

// Campos que realmente cambiaron entre el antes y el después
function camposCambiados(f) {
  const antes = f.old_values || {}, despues = f.new_values || {}
  const llaves = new Set([...Object.keys(antes), ...Object.keys(despues)])
  const out = []
  llaves.forEach(k => {
    if (OCULTOS.has(k)) return
    const a = JSON.stringify(antes[k] ?? null)
    const d = JSON.stringify(despues[k] ?? null)
    if (a !== d) out.push({ campo: k, antes: antes[k], despues: despues[k] })
  })
  return out.sort((x, y) => x.campo.localeCompare(y.campo, 'es'))
}

// Quién hizo el cambio. Sin usuario = lo hizo un proceso automático
// (una importación o el respaldo), no una persona.
function quienFue(f) {
  if (!f.user_id) return 'Proceso automático'
  return _perfiles[f.user_id] || 'Usuario dado de baja'
}

// Etiqueta corta para reconocer el registro en la lista
function resumen(f) {
  const d = f.new_values || f.old_values || {}
  for (const k of ['code', 'name', 'nombre', 'titulo', 'title',
                   'folio', 'paciente', 'full_name', 'descripcion']) {
    if (d[k]) return String(d[k]).slice(0, 70)
  }
  return '—'
}

function valor(v) {
  if (v === null || v === undefined) return '(vacío)'
  if (typeof v === 'boolean') return v ? 'Sí' : 'No'
  if (typeof v === 'object') return JSON.stringify(v)
  const s = String(v)
  return s.length > 300 ? s.slice(0, 300) + '…' : s
}

function fechaHora(iso) {
  if (!iso) return '—'
  return new Date(iso).toLocaleString('es-MX', {
    day: '2-digit', month: '2-digit', year: 'numeric',
    hour: '2-digit', minute: '2-digit',
  })
}

function escapa(s) {
  return String(s ?? '').replace(/[&<>"']/g, c =>
    ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]))
}

document.addEventListener('DOMContentLoaded', initBitacora)
