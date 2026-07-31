// ─── Oficios — Oficina de Calidad ──────────────────────────────
// Registro de oficios (comunicaciones oficiales). El documento vive
// en Drive; aquí se guarda el enlace y los datos, y se puede vincular
// a una queja o a una no conformidad.

let _user   = null
let _profile = null
let _role   = null
let _allOF  = []
let _filteredOF = []
let _currentOFId = null
let _editMode = false

// Catálogos para los vínculos (id → etiqueta)
let _quejas = []          // {id, folio, tipo, fecha, nombre_paciente}
let _ncs    = []          // {id, folio, finding_description}
const _quejaLabel = {}
const _ncLabel    = {}

const OF_TIPOS = {
  respuesta_queja: 'Respuesta a queja',
  solicitud:       'Solicitud',
  circular:        'Circular',
  otro:            'Otro',
}
const OF_ESTADOS = {
  borrador:   'Borrador',
  enviado:    'Enviado',
  respondido: 'Respondido',
  archivado:  'Archivado',
}

// ── Init ─────────────────────────────────────────────────────────
async function initOficios() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  renderUserInfo()
  setCurrentDate()
  await loadLinks()          // quejas + no conformidades para los selectores
  await loadOficios()
  applyRoleUI()
}

function renderUserInfo() {
  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
}

function setCurrentDate() {
  const el = document.getElementById('current-date')
  if (el) el.textContent = new Date().toLocaleDateString('es-MX', {
    weekday: 'long', day: 'numeric', month: 'long', year: 'numeric'
  })
}

function applyRoleUI() {
  const canWrite = ['administrador','responsable_calidad','jefe_departamento','recepcion'].includes(_role)
  const btn = document.getElementById('btn-new-of')
  if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'
}

// ── Cargar catálogos para vincular ───────────────────────────────
async function loadLinks() {
  // Quejas
  try {
    const { data } = await db.from('quejas')
      .select('id,folio,tipo,fecha,nombre_paciente')
      .order('fecha', { ascending: false })
    _quejas = data || []
  } catch (e) { _quejas = [] }

  // No conformidades
  try {
    const { data } = await db.from('nonconformities')
      .select('id,folio,finding_description')
      .order('created_at', { ascending: false })
    _ncs = data || []
  } catch (e) { _ncs = [] }

  // Mapas de etiquetas
  _quejas.forEach(q => {
    _quejaLabel[q.id] = `${q.folio || 'Queja'} — ${tipoQuejaLabel(q.tipo)}` +
      (q.nombre_paciente ? ` (${q.nombre_paciente})` : '')
  })
  _ncs.forEach(n => {
    _ncLabel[n.id] = `${n.folio || 'NC'}` +
      (n.finding_description ? ` — ${String(n.finding_description).slice(0, 40)}` : '')
  })

  // Llenar los <select> del formulario
  const selQ = document.getElementById('of-queja')
  if (selQ) selQ.innerHTML = '<option value="">— Ninguna —</option>' +
    _quejas.map(q => `<option value="${q.id}">${esc(_quejaLabel[q.id])}</option>`).join('')

  const selN = document.getElementById('of-nc')
  if (selN) selN.innerHTML = '<option value="">— Ninguna —</option>' +
    _ncs.map(n => `<option value="${n.id}">${esc(_ncLabel[n.id])}</option>`).join('')
}

function tipoQuejaLabel(t) {
  return t === 'queja' ? 'Queja'
    : t === 'sugerencia' ? 'Sugerencia'
    : t === 'felicitacion' ? 'Felicitación' : (t || '—')
}

// ── Cargar oficios ───────────────────────────────────────────────
async function loadOficios() {
  showLoading()
  const { data, error } = await db.from('oficios').select('*').order('fecha', { ascending: false })
  if (error) { showError(error.message); return }
  _allOF = data || []
  applyFilters()
}

// ── Filtros de periodo ───────────────────────────────────────────
function isoFecha(d) {
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`
}

function onPeriodoChange() {
  const p = document.getElementById('f-periodo')?.value || 'todo'
  const desde = document.getElementById('f-desde')
  const hasta = document.getElementById('f-hasta')
  if (!desde || !hasta) return
  if (p === 'custom') { applyFilters(); return }
  if (p === 'todo') { desde.value = ''; hasta.value = ''; applyFilters(); return }

  const hoy = new Date(), y = hoy.getFullYear(), m = hoy.getMonth()
  let d1, d2
  switch (p) {
    case 'mes':    d1 = new Date(y, m, 1);      d2 = new Date(y, m + 1, 0); break
    case 'mes-1':  d1 = new Date(y, m - 1, 1);  d2 = new Date(y, m, 0);     break
    case '3m':     d1 = new Date(y, m - 2, 1);  d2 = new Date(y, m + 1, 0); break
    case '6m':     d1 = new Date(y, m - 5, 1);  d2 = new Date(y, m + 1, 0); break
    case '12m':    d1 = new Date(y, m - 11, 1); d2 = new Date(y, m + 1, 0); break
    case 'anio':   d1 = new Date(y, 0, 1);      d2 = new Date(y, 11, 31);   break
    case 'anio-1': d1 = new Date(y - 1, 0, 1);  d2 = new Date(y - 1, 11, 31); break
    default: return
  }
  desde.value = isoFecha(d1)
  hasta.value = isoFecha(d2)
  applyFilters()
}

function onFechaManual() {
  const sel = document.getElementById('f-periodo')
  if (sel) sel.value = 'custom'
  applyFilters()
}

function applyFilters() {
  const q       = (document.getElementById('search-input')?.value || '').toLowerCase().trim()
  const tipo    = document.getElementById('f-tipo')?.value    || ''
  const estado  = document.getElementById('f-status')?.value  || ''
  const vinculo = document.getElementById('f-vinculo')?.value || ''
  const desde   = document.getElementById('f-desde')?.value   || ''
  const hasta   = document.getElementById('f-hasta')?.value   || ''

  _filteredOF = _allOF.filter(r => {
    const f = r.fecha || ''
    if (tipo   && r.tipo   !== tipo)   return false
    if (estado && r.estado !== estado) return false
    if (vinculo === 'queja' && !r.queja_id) return false
    if (vinculo === 'nc'    && !r.nonconformity_id) return false
    if (vinculo === 'sin'   && (r.queja_id || r.nonconformity_id)) return false
    if (desde  && (!f || f < desde)) return false
    if (hasta  && (!f || f > hasta)) return false
    if (q) {
      const txt = `${r.numero || ''} ${r.asunto || ''} ${r.dirigido_a || ''} ${r.emitido_por || ''} ${r.firmado_por || ''}`.toLowerCase()
      if (!txt.includes(q)) return false
    }
    return true
  })

  renderKPIs()
  renderTable(_filteredOF)
}

function clearFilters() {
  ;['f-tipo','f-status','f-vinculo','f-desde','f-hasta','search-input']
    .forEach(id => { const el = document.getElementById(id); if (el) el.value = '' })
  const p = document.getElementById('f-periodo'); if (p) p.value = 'todo'
  applyFilters()
}

// ── KPIs ─────────────────────────────────────────────────────────
function renderKPIs() {
  const r = _filteredOF
  setText('cnt-total',      r.length)
  setText('cnt-enviado',    r.filter(x => x.estado === 'enviado').length)
  setText('cnt-respondido', r.filter(x => x.estado === 'respondido').length)
  setText('cnt-conqueja',   r.filter(x => x.queja_id).length)
  setText('cnt-connc',      r.filter(x => x.nonconformity_id).length)
}

// ── Tabla ────────────────────────────────────────────────────────
function estadoBadge(e) {
  const map = {
    borrador:   ['#6b7280', 'Borrador'],
    enviado:    ['#2563eb', 'Enviado'],
    respondido: ['#16a34a', 'Respondido'],
    archivado:  ['#9ca3af', 'Archivado'],
  }
  const [c, txt] = map[e] || ['#6b7280', e || '—']
  return `<span style="display:inline-block;padding:3px 10px;border-radius:999px;
    font-size:0.72rem;font-weight:700;color:#fff;background:${c}">${esc(txt)}</span>`
}

function vinculoCell(r) {
  const parts = []
  if (r.queja_id) parts.push(
    `<span title="${esc(_quejaLabel[r.queja_id] || 'Queja')}" style="display:inline-block;padding:2px 8px;border-radius:6px;font-size:0.72rem;font-weight:600;background:#dbeafe;color:#1e40af;margin:1px 0">
      <i class="fa-solid fa-comment-dots"></i> ${esc(folioDeQueja(r.queja_id))}</span>`)
  if (r.nonconformity_id) parts.push(
    `<span title="${esc(_ncLabel[r.nonconformity_id] || 'No conformidad')}" style="display:inline-block;padding:2px 8px;border-radius:6px;font-size:0.72rem;font-weight:600;background:#fee2e2;color:#991b1b;margin:1px 0">
      <i class="fa-solid fa-circle-xmark"></i> ${esc(folioDeNC(r.nonconformity_id))}</span>`)
  return parts.join(' ') || '<span style="color:var(--txt3)">—</span>'
}

function folioDeQueja(id) {
  const q = _quejas.find(x => x.id === id)
  return q?.folio || 'Queja'
}
function folioDeNC(id) {
  const n = _ncs.find(x => x.id === id)
  return n?.folio || 'NC'
}

function renderTable(rows) {
  const tbody = document.getElementById('of-tbody')
  if (!tbody) return
  setText('of-count', `${rows.length} oficio${rows.length === 1 ? '' : 's'}`)

  if (!rows.length) {
    tbody.innerHTML = `<tr><td colspan="8" class="table-empty">
      <i class="fa-solid fa-inbox"></i><strong>Sin oficios</strong>
      No hay registros con los filtros actuales.</td></tr>`
    return
  }

  tbody.innerHTML = rows.map(r => `
    <tr>
      <td><strong>${esc(r.numero || '—')}</strong></td>
      <td>${esc(r.fecha || '—')}</td>
      <td class="center">${esc(OF_TIPOS[r.tipo] || '—')}</td>
      <td>${esc(r.asunto || '—')}</td>
      <td>${esc(r.dirigido_a || '—')}</td>
      <td>${vinculoCell(r)}</td>
      <td class="center">${estadoBadge(r.estado)}</td>
      <td class="center">
        <button onclick="openDetailOF('${r.id}')" class="btn-action" title="Ver detalle">
          <i class="fa-solid fa-eye"></i>
        </button>
      </td>
    </tr>`).join('')
}

// ── Nuevo / Editar ───────────────────────────────────────────────
function openNewOF() {
  _editMode = false
  _currentOFId = null
  ;['of-numero','of-asunto','of-dirigido','of-emitido','of-firmado','of-url','of-notas']
    .forEach(id => setVal(id, ''))
  setVal('of-tipo', '')
  setVal('of-estado', 'enviado')
  setVal('of-queja', '')
  setVal('of-nc', '')
  setVal('of-fecha', new Date().toISOString().split('T')[0])
  const ttl = document.getElementById('modal-new-ttl')
  if (ttl) ttl.innerHTML = 'Registrar oficio <small>Oficina de Calidad</small>'
  openModal('modal-new-of')
}

function editOFFromDetail() {
  const r = _allOF.find(x => x.id === _currentOFId)
  if (!r) return
  _editMode = true
  setVal('of-numero',   r.numero || '')
  setVal('of-fecha',    r.fecha || '')
  setVal('of-tipo',     r.tipo || '')
  setVal('of-estado',   r.estado || 'enviado')
  setVal('of-asunto',   r.asunto || '')
  setVal('of-dirigido', r.dirigido_a || '')
  setVal('of-emitido',  r.emitido_por || '')
  setVal('of-firmado',  r.firmado_por || '')
  setVal('of-queja',    r.queja_id || '')
  setVal('of-nc',       r.nonconformity_id || '')
  setVal('of-url',      r.documento_url || '')
  setVal('of-notas',    r.notas || '')
  const ttl = document.getElementById('modal-new-ttl')
  if (ttl) ttl.innerHTML = `Editar — ${esc(r.numero || 'oficio')} <small>Oficina de Calidad</small>`
  closeModal('modal-detail-of')
  openModal('modal-new-of')
}

async function submitNewOF() {
  const btn    = document.getElementById('btn-save-of')
  const numero = document.getElementById('of-numero')?.value.trim()
  const fecha  = document.getElementById('of-fecha')?.value
  const asunto = document.getElementById('of-asunto')?.value.trim()

  if (!numero) { showToast('El número de oficio es obligatorio.', 'red'); return }
  if (!fecha)  { showToast('La fecha es obligatoria.', 'red'); return }
  if (!asunto) { showToast('El asunto es obligatorio.', 'red'); return }

  const payload = {
    numero,
    fecha,
    tipo:             document.getElementById('of-tipo')?.value || null,
    estado:           document.getElementById('of-estado')?.value || 'enviado',
    asunto,
    dirigido_a:       document.getElementById('of-dirigido')?.value.trim() || null,
    emitido_por:      document.getElementById('of-emitido')?.value.trim() || null,
    firmado_por:      document.getElementById('of-firmado')?.value.trim() || null,
    queja_id:         document.getElementById('of-queja')?.value || null,
    nonconformity_id: document.getElementById('of-nc')?.value || null,
    documento_url:    document.getElementById('of-url')?.value.trim() || null,
    notas:            document.getElementById('of-notas')?.value.trim() || null,
    updated_at:       new Date().toISOString(),
  }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  let error
  if (_editMode && _currentOFId) {
    ;({ error } = await db.from('oficios').update(payload).eq('id', _currentOFId))
  } else {
    payload.created_by = _user.id
    ;({ error } = await db.from('oficios').insert(payload))
  }

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar'

  if (error) { showToast('Error al guardar: ' + error.message, 'red'); return }
  showToast(_editMode ? 'Oficio actualizado.' : 'Oficio registrado.', 'green')
  closeModal('modal-new-of')
  await loadOficios()
}

// ── Detalle ──────────────────────────────────────────────────────
function openDetailOF(id) {
  _currentOFId = id
  const r = _allOF.find(x => x.id === id)
  if (!r) return

  setText('dof-numero-ttl', r.numero || '—')
  setText('dof-tipo-ttl',   OF_TIPOS[r.tipo] || '—')
  setText('dof-numero',   r.numero || '—')
  setText('dof-fecha',    r.fecha || '—')
  setText('dof-tipo',     OF_TIPOS[r.tipo] || '—')
  setText('dof-estado',   OF_ESTADOS[r.estado] || r.estado || '—')
  setText('dof-dirigido', r.dirigido_a || '—')
  setText('dof-emitido',  r.emitido_por || '—')
  setText('dof-firmado',  r.firmado_por || '—')
  setText('dof-asunto',   r.asunto || '—')
  setText('dof-notas',    r.notas || '—')

  const urlEl = document.getElementById('dof-url')
  if (urlEl) {
    urlEl.innerHTML = r.documento_url
      ? `<a href="${esc(r.documento_url)}" target="_blank" rel="noopener" style="color:#2563eb;font-weight:600">
           <i class="fa-solid fa-up-right-from-square"></i> Abrir documento</a>`
      : '—'
  }
  const qEl = document.getElementById('dof-queja')
  if (qEl) qEl.textContent = r.queja_id ? (_quejaLabel[r.queja_id] || 'Queja ligada') : '—'
  const nEl = document.getElementById('dof-nc')
  if (nEl) nEl.textContent = r.nonconformity_id ? (_ncLabel[r.nonconformity_id] || 'NC ligada') : '—'

  const canWrite = ['administrador','responsable_calidad','jefe_departamento','recepcion'].includes(_role)
  const canDelete = ['administrador','responsable_calidad'].includes(_role)
  const be = document.getElementById('btn-edit-of'); if (be) be.style.display = canWrite ? 'inline-flex' : 'none'
  const bd = document.getElementById('btn-del-of');  if (bd) bd.style.display = canDelete ? 'inline-flex' : 'none'

  openModal('modal-detail-of')
}

async function deleteOF() {
  if (!_currentOFId) return
  if (!confirm('¿Eliminar este oficio? Esta acción no se puede deshacer.')) return
  const { error } = await db.from('oficios').delete().eq('id', _currentOFId)
  if (error) { showToast('Error al eliminar: ' + error.message, 'red'); return }
  showToast('Oficio eliminado.', 'green')
  closeModal('modal-detail-of')
  await loadOficios()
}

// ── Exportar CSV ─────────────────────────────────────────────────
function exportCSV() {
  const rows = _filteredOF
  if (!rows.length) { showToast('No hay oficios para exportar.', 'blue'); return }
  const head = ['Número','Fecha','Tipo','Asunto','Dirigido a','Emitido por','Firmado por',
                'Estado','Queja','No conformidad','Documento','Notas']
  const esc2 = v => `"${String(v ?? '').replace(/"/g, '""')}"`
  const lines = [head.map(esc2).join(',')]
  rows.forEach(r => lines.push([
    r.numero, r.fecha, OF_TIPOS[r.tipo] || '', r.asunto, r.dirigido_a, r.emitido_por,
    r.firmado_por, OF_ESTADOS[r.estado] || r.estado,
    r.queja_id ? folioDeQueja(r.queja_id) : '',
    r.nonconformity_id ? folioDeNC(r.nonconformity_id) : '',
    r.documento_url, r.notas,
  ].map(esc2).join(',')))
  const blob = new Blob(['﻿' + lines.join('\r\n')], { type: 'text/csv;charset=utf-8' })
  const a = document.createElement('a')
  a.href = URL.createObjectURL(blob)
  a.download = `oficios_${isoFecha(new Date())}.csv`
  a.click()
  URL.revokeObjectURL(a.href)
}

// ── Helpers de UI (locales, iguales a los de quejas.js) ──────────
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }

function setText(id, val) {
  const el = document.getElementById(id)
  if (el) el.textContent = val ?? '—'
}
function setVal(id, val) {
  const el = document.getElementById(id)
  if (el) el.value = val ?? ''
}
function esc(str) {
  if (!str) return ''
  return String(str)
    .replace(/&/g,'&amp;').replace(/</g,'&lt;')
    .replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}
function showLoading() {
  const tbody = document.getElementById('of-tbody')
  if (tbody) tbody.innerHTML = `
    <tr><td colspan="8" style="text-align:center;padding:48px;color:var(--txt3)">
      <i class="fa-solid fa-spinner fa-spin" style="font-size:1.5rem"></i>
    </td></tr>`
  setText('of-count', 'Cargando…')
}
function showError(msg) {
  const tbody = document.getElementById('of-tbody')
  if (tbody) tbody.innerHTML = `
    <tr><td colspan="8" class="table-empty">
      <i class="fa-solid fa-circle-exclamation" style="color:var(--red)"></i>
      <strong>Error al cargar</strong>${esc(msg)}
    </td></tr>`
}
function showToast(msg, color = 'green') {
  const old = document.getElementById('sgc-toast')
  if (old) old.remove()
  const bg = color === 'green' ? '#16a34a' : color === 'red' ? '#dc2626' : '#2563eb'
  const t = document.createElement('div')
  t.id = 'sgc-toast'
  t.style.cssText = `position:fixed;bottom:28px;right:28px;z-index:9999;
    background:${bg};color:#fff;padding:13px 22px;border-radius:12px;
    font-size:0.857rem;font-weight:600;font-family:var(--font);
    box-shadow:0 8px 28px rgba(0,0,0,.22);max-width:380px;line-height:1.4;`
  t.textContent = msg
  document.body.appendChild(t)
  setTimeout(() => t.remove(), 3800)
}

// ── Arrancar ─────────────────────────────────────────────────────
initOficios()
