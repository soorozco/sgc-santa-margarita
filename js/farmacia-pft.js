// ─── Perfil Farmacoterapéutico (PFT) — Farmacia Clínica ──────────

let _user    = null
let _profile = null
let _role    = null
let _pfts    = []
let _catalogo = []          // catálogo maestro de medicamentos
let _catByName = {}         // nombre → {atc, alto_riesgo}
let _edit    = null         // PFT en edición (objeto)
let _adminPft = null        // PFT del modal de administración

const CATEGORIAS = [
  { key: 'infusiones',   label: 'Infusiones',                 icon: 'fa-droplet',         cls: 'h-amber'  },
  { key: 'antibioticos', label: 'Antibióticos',               icon: 'fa-shield-virus',    cls: 'h-red'    },
  { key: 'analgesia',    label: 'Analgesia',                  icon: 'fa-pills',           cls: 'h-violet' },
  { key: 'conciliados',  label: 'Medicamentos conciliados',   icon: 'fa-clipboard-check', cls: 'h-teal'   },
  { key: 'suspendidos',  label: 'Medicamentos suspendidos',   icon: 'fa-ban',             cls: 'h-slate'  },
]

const VIAS = ['Intravenosa', 'Subcutánea', 'Vía oral', 'Transdérmica', 'Intramuscular']
const FRECUENCIAS = ['Cada 4hrs', 'Cada 6hrs', 'Cada 8hrs', 'Cada 12hrs', 'Cada 24hrs', 'PVM', 'PRN', 'Dosis respuesta']
const ATC = [
  ['A','Tracto alimentario y metabolismo'],['B','Sangre y órganos hematopoyéticos'],
  ['C','Sistema cardiovascular'],['D','Dermatológicos'],
  ['G','Sistema genitourinario y hormonas sexuales'],['H','Preparados hormonales sistémicos'],
  ['J','Antiinfecciosos de uso sistémico'],['L','Antineoplásicos e inmunomoduladores'],
  ['M','Sistema musculoesquelético'],['N','Sistema nervioso'],
  ['P','Antiparasitarios, insecticidas y repelentes'],['R','Sistema respiratorio'],
  ['S','Órganos de los sentidos'],['V','Varios'],['W','Cosméticos'],['X','Alimentos y dietéticos'],
]

// ── Init ────────────────────────────────────────────────────────
async function init() {
  const auth = await requireAuth()
  if (!auth?.user) return
  _user = auth.user; _profile = auth.profile
  _role = auth.profile?.roles?.name || 'lector'
  requirePermission(_profile, 'farmacia_pft')

  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
  const d = document.getElementById('current-date')
  if (d) d.textContent = new Date().toLocaleDateString('es-MX', { weekday:'long', day:'numeric', month:'long', year:'numeric' })

  await loadCatalogo()
  await loadPFTs()
}

function setText(id,v){ const e=document.getElementById(id); if(e) e.textContent=v }
function setVal(id,v){ const e=document.getElementById(id); if(e) e.value=v }
function val(id){ return document.getElementById(id)?.value ?? '' }
function esc(s){ return String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c])) }
function openM(id){ document.getElementById(id)?.classList.add('open') }
function closeM(id){ document.getElementById(id)?.classList.remove('open') }
function hoy(){ return new Date().toISOString().split('T')[0] }

// ── Catálogo ────────────────────────────────────────────────────
async function loadCatalogo() {
  const { data } = await db.from('pharmacy_med_catalog').select('*').eq('activo', true).order('nombre')
  _catalogo = data || []
  _catByName = {}
  _catalogo.forEach(m => { _catByName[m.nombre.toUpperCase()] = { atc: m.atc, alto_riesgo: m.alto_riesgo } })
  const dl = document.getElementById('dl-meds')
  if (dl) dl.innerHTML = _catalogo.map(m => `<option value="${esc(m.nombre)}">`).join('')
}

// ── Cálculos automáticos ────────────────────────────────────────
function calcEdad(fnac) {
  if (!fnac) return null
  const b = new Date(fnac + 'T00:00:00'), n = new Date()
  let e = n.getFullYear() - b.getFullYear()
  const m = n.getMonth() - b.getMonth()
  if (m < 0 || (m === 0 && n.getDate() < b.getDate())) e--
  return e >= 0 && e < 130 ? e : null
}
function calcIMC(peso, talla) {
  const p = parseFloat(peso), t = parseFloat(talla)
  if (!p || !t) return null
  return +(p / (t * t)).toFixed(1)
}
function clasifIMC(imc) {
  if (imc == null) return ''
  if (imc < 18.5) return 'Bajo peso'
  if (imc < 25)   return 'Normal'
  if (imc < 30)   return 'Sobrepeso'
  return 'Obesidad'
}
// tokens de alergia (palabras significativas)
function alergenos(txt) {
  return String(txt || '').toLowerCase()
    .split(/[,;+/]|\s+/).map(s => s.trim())
    .filter(s => s.length >= 4 && !['sodico','sódico','de','del','con'].includes(s))
}
function medConflictoAlergia(medNombre, alergiasTxt) {
  const toks = alergenos(alergiasTxt)
  if (!toks.length) return null
  const n = String(medNombre || '').toLowerCase()
  const hit = toks.find(t => n.includes(t))
  return hit || null
}

// ── Cargar PFTs ─────────────────────────────────────────────────
async function loadPFTs() {
  const { data, error } = await db.from('pharmacy_pft').select('*')
    .order('activo', { ascending: false }).order('fecha_ingreso', { ascending: false })
  const tbody = document.getElementById('censo-body')
  if (error) {
    if (tbody) tbody.innerHTML = `<tr><td colspan="9" style="text-align:center;color:#991b1b;padding:22px">
      Error: ${esc(error.message)}${error.message.includes('pharmacy_pft') ? ' — falta ejecutar la migración sql/farmacia_pft_setup.sql en Supabase' : ''}</td></tr>`
    return
  }
  _pfts = data || []
  renderCenso()
}

function renderCenso() {
  const tbody = document.getElementById('censo-body')
  if (!tbody) return
  const verEg = document.getElementById('chk-egresados')?.checked
  const lista = _pfts.filter(p => verEg ? true : p.activo !== false)
  setText('pft-count', `${_pfts.filter(p => p.activo !== false).length} activos`)

  if (!lista.length) {
    tbody.innerHTML = `<tr><td colspan="9" style="text-align:center;color:#9ca3af;padding:26px">
      Sin perfiles — usa "Nuevo perfil" para registrar el primero.</td></tr>`
    return
  }
  const canDel = ['administrador', 'responsable_calidad'].includes(_role)
  tbody.innerHTML = lista.map(p => {
    const meds = p.medicamentos || []
    const activos = meds.filter(m => m.categoria !== 'suspendidos')
    const riesgo = activos.filter(m => m.alto_riesgo).length
    const alta = p.activo === false
    const conflicto = activos.some(m => medConflictoAlergia(m.medicamento, p.alergias))
    return `<tr style="${alta ? 'opacity:.55' : ''}">
      <td><strong>${esc(p.paciente)}</strong></td>
      <td>${esc(p.folio_exp || '—')}</td>
      <td>${fmtF(p.fecha_ingreso)}</td>
      <td style="max-width:160px">${esc(p.medico_tratante || '—')}</td>
      <td style="text-align:center">${activos.length}</td>
      <td style="text-align:center">${riesgo ? `<span class="badge-riesgo">${riesgo}</span>` : '<span style="color:#9ca3af">0</span>'}</td>
      <td style="max-width:150px">${p.alergias
        ? `<span style="color:#b91c1c;font-weight:600">${esc(p.alergias)}</span>${conflicto ? ' <i class="fa-solid fa-triangle-exclamation" title="Hay un medicamento en conflicto con la alergia" style="color:#dc2626"></i>' : ''}`
        : '<span style="color:#9ca3af">—</span>'}</td>
      <td style="text-align:center">${alta ? '<span class="pill-alta">Egresado</span>' : '<span class="pill-act">Activo</span>'}</td>
      <td style="text-align:center;white-space:nowrap">
        <button class="btn-action blue" onclick="abrirAdmin('${p.id}')" title="Administración por horario"><i class="fa-solid fa-clock"></i></button>
        <button class="btn-action" onclick="editarPFT('${p.id}')" title="Editar perfil"><i class="fa-solid fa-pen"></i></button>
        ${!alta ? `<button class="btn-action" style="color:#b45309;background:#fffbeb;margin-left:6px" onclick="egresar('${p.id}')" title="Egresar"><i class="fa-solid fa-person-walking-arrow-right"></i></button>` : ''}
        ${canDel ? `<button class="btn-action del" onclick="eliminar('${p.id}')" title="Eliminar"><i class="fa-solid fa-trash"></i></button>` : ''}
      </td>
    </tr>`
  }).join('')
}

function fmtF(f){ return f ? new Date(f+'T12:00:00').toLocaleDateString('es-MX',{day:'2-digit',month:'short',year:'numeric'}) : '—' }

// ── Editor ──────────────────────────────────────────────────────
function nuevoPFT() {
  _edit = { medicamentos: [], administraciones: {} }
  setText('editor-title', 'Nuevo perfil farmacoterapéutico')
  buildEditor()
  document.getElementById('editor').classList.add('open')
}
function editarPFT(id) {
  const p = _pfts.find(x => x.id === id)
  if (!p) return
  _edit = JSON.parse(JSON.stringify(p))
  _edit.medicamentos = _edit.medicamentos || []
  _edit.administraciones = _edit.administraciones || {}
  setText('editor-title', `Editar — ${p.paciente}`)
  buildEditor()
  document.getElementById('editor').classList.add('open')
}
function cerrarEditor() { document.getElementById('editor').classList.remove('open'); _edit = null }

function optionList(arr, sel) {
  return arr.map(o => `<option value="${esc(o)}"${o === sel ? ' selected' : ''}>${esc(o)}</option>`).join('')
}
function atcOptions(sel) {
  return `<option value="">—</option>` + ATC.map(([c,t]) =>
    `<option value="${c}"${c === sel ? ' selected' : ''}>${c} · ${esc(t)}</option>`).join('')
}

function buildEditor() {
  const p = _edit
  const box = document.getElementById('editor-body')

  const catBlocks = CATEGORIAS.map(cat => {
    const rows = (p.medicamentos || []).filter(m => m.categoria === cat.key)
    return `
    <div class="pft-card">
      <div class="pft-head ${cat.cls}"><i class="fa-solid ${cat.icon}"></i> ${cat.label}</div>
      <div class="pft-body" style="padding:0;overflow-x:auto">
        <table class="med-table" style="min-width:1040px">
          <thead><tr>
            <th style="min-width:230px">Medicamento</th><th>Dosis</th><th>Vía</th>
            <th>Inicio</th><th>Término</th><th>Frecuencia</th><th>Horario</th><th>ATC</th><th>Obs.</th><th></th>
          </tr></thead>
          <tbody id="tb-${cat.key}">${rows.map(m => medRowHtml(cat.key, m)).join('')}</tbody>
        </table>
        <div style="padding:0 12px 12px"><button class="btn-add" onclick="addMed('${cat.key}')"><i class="fa-solid fa-plus"></i> Agregar medicamento</button></div>
      </div>
    </div>`
  }).join('')

  box.innerHTML = `
    <div id="pft-alerta" class="alerta" style="display:none"></div>

    <div class="pft-card">
      <div class="pft-head h-teal"><i class="fa-solid fa-id-card"></i> Datos generales del paciente</div>
      <div class="pft-body">
        <div class="grid g4">
          <div class="fld"><label>Nombre del paciente *</label><input id="e-paciente" value="${esc(p.paciente||'')}"></div>
          <div class="fld"><label>Folio de expediente</label><input id="e-folio" value="${esc(p.folio_exp||'')}"></div>
          <div class="fld"><label>Fecha de nacimiento</label><input type="date" id="e-fnac" value="${esc(p.fecha_nacimiento||'')}" oninput="recalc()"></div>
          <div class="fld"><label>Edad</label><div class="auto" id="e-edad">—</div></div>
          <div class="fld"><label>Fecha de ingreso</label><input type="date" id="e-ingreso" value="${esc(p.fecha_ingreso||hoy())}"></div>
          <div class="fld"><label>Fecha de egreso</label><input type="date" id="e-egreso" value="${esc(p.fecha_egreso||'')}"></div>
          <div class="fld"><label>Médico tratante</label><input id="e-medico" value="${esc(p.medico_tratante||'')}" placeholder="Nombre del médico"></div>
          <div class="fld"><label>Especialidad</label><input id="e-especialidad" value="${esc(p.especialidad||'')}" placeholder="Ej. Medicina Interna"></div>
        </div>
      </div>
    </div>

    <div class="pft-card">
      <div class="pft-head h-blue"><i class="fa-solid fa-notes-medical"></i> Datos clínicos</div>
      <div class="pft-body">
        <div class="grid g4" style="margin-bottom:14px">
          <div class="fld"><label>Peso (kg)</label><input type="number" step="0.1" id="e-peso" value="${p.peso??''}" oninput="recalc()"></div>
          <div class="fld"><label>Talla (m)</label><input type="number" step="0.01" id="e-talla" value="${p.talla??''}" oninput="recalc()"></div>
          <div class="fld"><label>IMC (kg/m²)</label><div class="auto" id="e-imc">—</div></div>
          <div class="fld"><label>Alergias</label><input id="e-alergias" value="${esc(p.alergias||'')}" oninput="recalc()" placeholder="Ej. Metamizol sódico — o 'Negadas'"></div>
        </div>
        <div class="grid g2">
          <div class="fld"><label>Diagnóstico de ingreso</label><input id="e-dx" value="${esc(p.diagnostico||'')}"></div>
          <div class="fld"><label>Comorbilidades</label><input id="e-comorb" value="${esc(p.comorbilidades||'')}"></div>
        </div>
        <div class="fld" style="margin-top:14px"><label>Historia clínica relevante</label><textarea id="e-hist">${esc(p.historia_clinica||'')}</textarea></div>
      </div>
    </div>

    ${catBlocks}
  `
  recalc()
}

function medRowHtml(catKey, m) {
  m = m || {}
  const mid = m.mid || ('m' + Date.now() + Math.floor(Math.random()*1000))
  return `<tr data-mid="${mid}" data-cat="${catKey}">
    <td><input list="dl-meds" class="m-nombre" value="${esc(m.medicamento||'')}" oninput="onMedName(this)" placeholder="Buscar medicamento…">
        <span class="m-flags" style="display:block;margin-top:3px"></span></td>
    <td><input class="m-dosis" value="${esc(m.dosis||'')}" style="min-width:70px" placeholder="mg / mEq"></td>
    <td><select class="m-via"><option value="">—</option>${optionList(VIAS, m.via)}</select></td>
    <td><input type="date" class="m-inicio" value="${esc(m.inicio||'')}"></td>
    <td><input type="date" class="m-termino" value="${esc(m.termino||'')}"></td>
    <td><select class="m-frec"><option value="">—</option>${optionList(FRECUENCIAS, m.frecuencia)}</select></td>
    <td><input class="m-horario" value="${esc(m.horario||'')}" style="min-width:90px" placeholder="8, 16, 24"></td>
    <td><select class="m-atc" style="min-width:70px">${atcOptions(m.atc)}</select></td>
    <td><input class="m-obs" value="${esc(m.observaciones||'')}" style="min-width:120px"></td>
    <td><button class="btn-row-x" onclick="delMed(this)" title="Quitar"><i class="fa-solid fa-trash"></i></button></td>
  </tr>`
}

function addMed(catKey) {
  const tb = document.getElementById('tb-' + catKey)
  if (tb) { tb.insertAdjacentHTML('beforeend', medRowHtml(catKey, {})); recalc() }
}
function delMed(btn) { btn.closest('tr').remove(); recalc() }

// Autollenar ATC y alto riesgo al elegir del catálogo + chequeo de alergias
function onMedName(inp) {
  const nombre = inp.value.trim().toUpperCase()
  const info = _catByName[nombre]
  const tr = inp.closest('tr')
  if (info) {
    const atcSel = tr.querySelector('.m-atc')
    if (atcSel && info.atc && !atcSel.value) atcSel.value = info.atc
  }
  recalc()
}

function collectMeds() {
  const meds = []
  document.querySelectorAll('#editor-body tbody tr[data-mid]').forEach(tr => {
    const nombre = tr.querySelector('.m-nombre')?.value.trim()
    if (!nombre) return
    const info = _catByName[nombre.toUpperCase()] || {}
    meds.push({
      mid: tr.dataset.mid,
      categoria: tr.dataset.cat,
      medicamento: nombre,
      dosis: tr.querySelector('.m-dosis')?.value.trim() || '',
      via: tr.querySelector('.m-via')?.value || '',
      inicio: tr.querySelector('.m-inicio')?.value || '',
      termino: tr.querySelector('.m-termino')?.value || '',
      frecuencia: tr.querySelector('.m-frec')?.value || '',
      horario: tr.querySelector('.m-horario')?.value.trim() || '',
      atc: tr.querySelector('.m-atc')?.value || '',
      observaciones: tr.querySelector('.m-obs')?.value.trim() || '',
      alto_riesgo: !!info.alto_riesgo || /alto\s*riesgo/i.test(nombre),
    })
  })
  return meds
}

// Recalcular edad, IMC, banderas de fila (riesgo/alergia) y alerta global
function recalc() {
  const edad = calcEdad(val('e-fnac'))
  setText('e-edad', edad != null ? edad + ' años' : '—')
  const imc = calcIMC(val('e-peso'), val('e-talla'))
  setText('e-imc', imc != null ? `${imc} · ${clasifIMC(imc)}` : '—')

  const alergias = val('e-alergias')
  let conflictos = []
  document.querySelectorAll('#editor-body tbody tr[data-mid]').forEach(tr => {
    const nombre = tr.querySelector('.m-nombre')?.value.trim() || ''
    const info = _catByName[nombre.toUpperCase()] || {}
    const riesgo = !!info.alto_riesgo || /alto\s*riesgo/i.test(nombre)
    const conf = tr.dataset.cat !== 'suspendidos' ? medConflictoAlergia(nombre, alergias) : null
    tr.classList.toggle('row-riesgo', riesgo && !conf)
    tr.classList.toggle('row-alergia', !!conf)
    const flags = tr.querySelector('.m-flags')
    if (flags) {
      let h = ''
      if (riesgo) h += '<span class="badge-riesgo">ALTO RIESGO</span> '
      if (conf) h += `<span class="badge-riesgo" style="background:#dc2626;color:#fff">⚠ ALERGIA: ${esc(conf)}</span>`
      flags.innerHTML = h
    }
    if (conf && nombre) conflictos.push(nombre)
  })

  const al = document.getElementById('pft-alerta')
  if (al) {
    if (conflictos.length) {
      al.style.display = 'flex'
      al.innerHTML = `<i class="fa-solid fa-triangle-exclamation" style="font-size:1.1rem"></i>
        <span><strong>Conflicto con alergias:</strong> hay ${conflictos.length} medicamento(s) que coinciden con lo que el paciente reporta como alergia. Revisa antes de continuar.</span>`
    } else { al.style.display = 'none' }
  }
}

async function guardarPFT() {
  const paciente = val('e-paciente').trim()
  if (!paciente) { toast('El nombre del paciente es obligatorio.', 'red'); return }

  const meds = collectMeds()
  const payload = {
    paciente,
    folio_exp: val('e-folio').trim() || null,
    fecha_nacimiento: val('e-fnac') || null,
    fecha_ingreso: val('e-ingreso') || null,
    fecha_egreso: val('e-egreso') || null,
    medico_tratante: val('e-medico').trim() || null,
    especialidad: val('e-especialidad').trim() || null,
    peso: val('e-peso') ? parseFloat(val('e-peso')) : null,
    talla: val('e-talla') ? parseFloat(val('e-talla')) : null,
    alergias: val('e-alergias').trim() || null,
    diagnostico: val('e-dx').trim() || null,
    comorbilidades: val('e-comorb').trim() || null,
    historia_clinica: val('e-hist').trim() || null,
    medicamentos: meds,
    updated_at: new Date().toISOString(),
  }

  const btn = document.getElementById('btn-guardar')
  btn.disabled = true; btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  let error
  if (_edit.id) {
    ;({ error } = await db.from('pharmacy_pft').update(payload).eq('id', _edit.id))
  } else {
    payload.activo = true
    payload.administraciones = {}
    payload.created_by = _user.id
    payload.created_by_name = _profile?.full_name || _user.email
    ;({ error } = await db.from('pharmacy_pft').insert(payload))
  }

  btn.disabled = false; btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar perfil'
  if (error) { toast('Error al guardar: ' + error.message, 'red'); return }
  toast(_edit.id ? 'Perfil actualizado.' : 'Perfil creado.', 'green')
  cerrarEditor()
  await loadPFTs()
}

async function egresar(id) {
  const p = _pfts.find(x => x.id === id); if (!p) return
  if (!confirm(`¿Egresar a ${p.paciente}? Saldrá de los perfiles activos pero se conserva su historial.`)) return
  const { error } = await db.from('pharmacy_pft')
    .update({ activo: false, fecha_egreso: p.fecha_egreso || hoy(), updated_at: new Date().toISOString() }).eq('id', id)
  if (error) { toast('Error: ' + error.message, 'red'); return }
  toast('Paciente egresado.', 'green'); await loadPFTs()
}
async function eliminar(id) {
  if (!confirm('¿Eliminar este perfil? Esta acción no se puede deshacer.')) return
  const { error } = await db.from('pharmacy_pft').delete().eq('id', id)
  if (error) { toast('Error: ' + error.message, 'red'); return }
  toast('Perfil eliminado.', 'green'); await loadPFTs()
}

// ── Administración por horario ──────────────────────────────────
function abrirAdmin(id) {
  _adminPft = _pfts.find(x => x.id === id)
  if (!_adminPft) return
  setText('admin-title', `Administración — ${_adminPft.paciente}`)
  setVal('admin-fecha', hoy())
  renderSched()
  openM('modal-admin')
}

function parseHoras(horario) {
  return String(horario || '').split(/[,\s]+/).map(s => s.trim()).filter(Boolean)
}

function renderSched() {
  const wrap = document.getElementById('sched-wrap')
  if (!wrap || !_adminPft) return
  const fecha = val('admin-fecha') || hoy()
  const meds = (_adminPft.medicamentos || []).filter(m => m.categoria !== 'suspendidos' && m.horario)
  if (!meds.length) {
    wrap.innerHTML = `<div style="color:#9ca3af;font-size:.86rem;padding:10px 0">Este perfil no tiene medicamentos con horario definido.</div>`
    return
  }
  // columnas = unión de todas las horas
  const horas = [...new Set(meds.flatMap(m => parseHoras(m.horario)))]
    .sort((a,b) => (parseInt(a)||0) - (parseInt(b)||0))
  const adm = _adminPft.administraciones || {}

  wrap.innerHTML = `<table class="sched">
    <thead><tr><th style="text-align:left">Medicamento</th>${horas.map(h => `<th>${esc(h)}</th>`).join('')}</tr></thead>
    <tbody>
      ${meds.map(m => `<tr>
        <td class="med">${esc(m.medicamento)} <span style="color:#9ca3af;font-weight:400">${esc(m.dosis||'')}</span></td>
        ${horas.map(h => {
          const aplica = parseHoras(m.horario).includes(h)
          if (!aplica) return `<td style="background:#fbfbfc"></td>`
          const key = `${m.mid}|${fecha}|${h}`
          const done = !!adm[key]
          return `<td class="cell" onclick="toggleAdmin('${m.mid}','${esc(h)}')" title="${done ? 'Administrado ' + esc(adm[key].by||'') : 'Marcar administrado'}">
            <i class="fa-${done?'solid fa-circle-check dot-ok':'regular fa-circle dot-pend'}"></i></td>`
        }).join('')}
      </tr>`).join('')}
    </tbody></table>`
}

async function toggleAdmin(mid, hora) {
  const fecha = val('admin-fecha') || hoy()
  const key = `${mid}|${fecha}|${hora}`
  const adm = { ...(_adminPft.administraciones || {}) }
  if (adm[key]) delete adm[key]
  else adm[key] = { by: _profile?.full_name || _user.email, at: new Date().toISOString() }

  const { error } = await db.from('pharmacy_pft')
    .update({ administraciones: adm, updated_at: new Date().toISOString() }).eq('id', _adminPft.id)
  if (error) { toast('Error al guardar: ' + error.message, 'red'); return }
  _adminPft.administraciones = adm
  const idx = _pfts.findIndex(p => p.id === _adminPft.id)
  if (idx >= 0) _pfts[idx].administraciones = adm
  renderSched()
}

// ── Toast ───────────────────────────────────────────────────────
function toast(msg, color='green') {
  const old = document.getElementById('sgc-toast'); if (old) old.remove()
  const bg = color==='green'?'#16a34a':color==='red'?'#dc2626':'#2563eb'
  const t = document.createElement('div'); t.id='sgc-toast'
  t.style.cssText = `position:fixed;bottom:28px;right:28px;z-index:9999;background:${bg};color:#fff;padding:13px 22px;border-radius:12px;font-size:.857rem;font-weight:600;box-shadow:0 8px 28px rgba(0,0,0,.22);max-width:380px;line-height:1.4`
  t.textContent = msg; document.body.appendChild(t)
  setTimeout(() => t.remove(), 3800)
}

init()
