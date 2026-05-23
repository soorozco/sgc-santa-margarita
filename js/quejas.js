// ─── Quejas, Sugerencias y Felicitaciones — FT-CA-24 ────────────

let _user      = null
let _profile   = null
let _role      = null
let _allQJ     = []
let _filteredQJ= []
let _depts     = []
let _currentQJId = null
let _editMode  = false

// ── Init ─────────────────────────────────────────────────────────
async function initQuejas() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  renderUserInfo()
  setCurrentDate()
  await loadDepts()
  populateDeptSelect()
  await loadQuejas()
  setupFilters()
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

async function loadDepts() {
  const { data } = await db.from('departments')
    .select('id,name').eq('is_active', true).order('name')
  _depts = data || []
}

function populateDeptSelect() {
  const sel = document.getElementById('nq-departamento')
  if (!sel) return
  const opts = '<option value="">— Seleccionar —</option>' +
    _depts.map(d => `<option value="${esc(d.name)}">${esc(d.name)}</option>`).join('')
  sel.innerHTML = opts
}

function applyRoleUI() {
  const canWrite = ['administrador','responsable_calidad','jefe_departamento','recepcion'].includes(_role)
  const btn = document.getElementById('btn-new-qj')
  if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'
}

// ── Cargar registros ─────────────────────────────────────────────
async function loadQuejas() {
  showLoading()
  const { data, error } = await db
    .from('quejas')
    .select('*')
    .order('fecha', { ascending: false })

  if (error) { showError(error.message); return }
  _allQJ = data || []
  applyFilters()
  renderSummary()
}

// ── Filtros ───────────────────────────────────────────────────────
function setupFilters() {
  ['search-input','f-tipo','f-status'].forEach(id => {
    document.getElementById(id)?.addEventListener('input', applyFilters)
  })
}

function applyFilters() {
  const q      = (document.getElementById('search-input')?.value || '').toLowerCase()
  const tipo   = document.getElementById('f-tipo')?.value   || ''
  const status = document.getElementById('f-status')?.value || ''

  _filteredQJ = _allQJ.filter(r => {
    const txt = `${r.folio} ${r.nombre_paciente || ''} ${r.descripcion || ''} ${r.departamento || ''}`.toLowerCase()
    return (!q      || txt.includes(q))
        && (!tipo   || r.tipo   === tipo)
        && (!status || r.status === status)
  })
  renderTable(_filteredQJ)
}

// ── Resumen ───────────────────────────────────────────────────────
function renderSummary() {
  const summary = document.getElementById('qj-summary')
  if (!summary) return
  if (_allQJ.length === 0) { summary.style.display = 'none'; return }
  summary.style.display = 'grid'

  const cnt = (tipo) => _allQJ.filter(r => r.tipo === tipo).length
  setText('cnt-queja',       cnt('queja'))
  setText('cnt-sugerencia',  cnt('sugerencia'))
  setText('cnt-felicitacion',cnt('felicitacion'))
  setText('cnt-pendiente',   _allQJ.filter(r => r.status === 'pendiente').length)
}

// ── Render tabla ──────────────────────────────────────────────────
function renderTable(rows) {
  const tbody = document.getElementById('qj-tbody')
  const count = document.getElementById('qj-count')
  if (count) count.textContent = `${rows.length} registro${rows.length !== 1 ? 's' : ''}`
  if (!tbody) return

  if (rows.length === 0) {
    tbody.innerHTML = `
      <tr><td colspan="8" class="table-empty">
        <i class="fa-solid fa-folder-open"></i>
        <strong>Sin registros</strong>
        No hay resultados con los filtros seleccionados.
      </td></tr>`
    return
  }

  const canWrite = ['administrador','responsable_calidad','jefe_departamento','recepcion'].includes(_role)

  tbody.innerHTML = rows.map(r => `
    <tr>
      <td><span class="qj-folio qj-folio-${r.tipo}">${esc(r.folio)}</span></td>
      <td style="white-space:nowrap">${fmtDate(r.fecha)}</td>
      <td class="center">${tipoPill(r.tipo)}</td>
      <td>${esc(r.nombre_paciente || '—')}</td>
      <td>${esc(r.departamento || '—')}</td>
      <td><span class="qj-desc" title="${esc(r.descripcion || '')}">${esc(r.descripcion || '—')}</span></td>
      <td class="center">${statusPill(r.status)}</td>
      <td class="center">
        <div class="action-btns">
          <button onclick="openDetail('${r.id}')" class="btn-action" title="Ver detalle">
            <i class="fa-solid fa-eye"></i>
          </button>
          ${canWrite ? `
          <button onclick="openEditQJFromTable('${r.id}')" class="btn-action blue" title="Editar">
            <i class="fa-solid fa-pencil"></i>
          </button>` : ''}
        </div>
      </td>
    </tr>`).join('')
}

// ── Modal helpers ─────────────────────────────────────────────────
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.modal-overlay').forEach(overlay => {
    overlay.addEventListener('click', e => {
      if (e.target === overlay) overlay.classList.remove('open')
    })
  })
})

// ── Modal: NUEVO / EDITAR ─────────────────────────────────────────
async function openNewQJ() {
  _editMode    = false
  _currentQJId = null

  // Generar folio sugerido
  const { count } = await db.from('quejas').select('id', { count: 'exact', head: true })
  const year = new Date().getFullYear()
  const num  = String((count || 0) + 1).padStart(2, '0')

  const fields = ['nq-nombre','nq-habitacion','nq-telefono','nq-personal',
                  'nq-descripcion','nq-presenta','nq-recibe','nq-calidad']
  fields.forEach(id => setVal(id, ''))
  setVal('nq-tipo', '')
  setVal('nq-departamento', '')
  setVal('nq-fecha', new Date().toISOString().split('T')[0])
  setVal('nq-folio', `QJ-${year}-${num}`)

  setText('modal-new-ttl', 'Registrar Solicitud')
  document.querySelector('#modal-new-ttl small').textContent =
    'Recepción de felicitaciones, sugerencias o quejas — FT-CA-24'

  openModal('modal-new-qj')
}

function openEditQJFromTable(id) {
  _currentQJId = id
  _editMode    = true
  const r = _allQJ.find(x => x.id === id)
  if (!r) return

  setVal('nq-fecha',        r.fecha || '')
  setVal('nq-folio',        r.folio || '')
  setVal('nq-nombre',       r.nombre_paciente || '')
  setVal('nq-tipo',         r.tipo || '')
  setVal('nq-habitacion',   r.habitacion || '')
  setVal('nq-telefono',     r.telefono || '')
  setVal('nq-departamento', r.departamento || '')
  setVal('nq-personal',     r.personal_involucrado || '')
  setVal('nq-descripcion',  r.descripcion || '')
  setVal('nq-presenta',     r.nombre_presenta || '')
  setVal('nq-recibe',       r.nombre_recibe || '')
  setVal('nq-calidad',      r.nombre_calidad || '')

  setText('modal-new-ttl', `Editar — ${r.folio}`)
  document.querySelector('#modal-new-ttl small').textContent = tipoLabel(r.tipo)

  openModal('modal-new-qj')
}

async function submitNewQJ() {
  const btn         = document.getElementById('btn-save-qj')
  const fecha       = document.getElementById('nq-fecha')?.value
  const folio       = document.getElementById('nq-folio')?.value.trim()
  const nombre      = document.getElementById('nq-nombre')?.value.trim()
  const tipo        = document.getElementById('nq-tipo')?.value
  const habitacion  = document.getElementById('nq-habitacion')?.value.trim()
  const telefono    = document.getElementById('nq-telefono')?.value.trim()
  const departamento= document.getElementById('nq-departamento')?.value
  const personal    = document.getElementById('nq-personal')?.value.trim()
  const descripcion = document.getElementById('nq-descripcion')?.value.trim()
  const presenta    = document.getElementById('nq-presenta')?.value.trim()
  const recibe      = document.getElementById('nq-recibe')?.value.trim()
  const calidad     = document.getElementById('nq-calidad')?.value.trim()

  if (!fecha)       { showToast('La fecha es obligatoria.', 'red'); return }
  if (!tipo)        { showToast('Selecciona el tipo de solicitud.', 'red'); return }
  if (!descripcion) { showToast('La descripción es obligatoria.', 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const payload = {
    fecha, folio: folio || null,
    nombre_paciente:      nombre      || null,
    tipo,
    habitacion:           habitacion  || null,
    telefono:             telefono    || null,
    departamento:         departamento|| null,
    personal_involucrado: personal    || null,
    descripcion,
    nombre_presenta:      presenta    || null,
    nombre_recibe:        recibe      || null,
    nombre_calidad:       calidad     || null,
    updated_at:           new Date().toISOString()
  }

  let error
  if (_editMode && _currentQJId) {
    ;({ error } = await db.from('quejas').update(payload).eq('id', _currentQJId))
  } else {
    payload.status     = 'pendiente'
    payload.created_by = _user.id
    ;({ error } = await db.from('quejas').insert(payload))
  }

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar'

  if (error) { showToast('Error al guardar: ' + error.message, 'red'); return }

  showToast(_editMode ? 'Registro actualizado.' : 'Solicitud registrada correctamente.', 'green')
  closeModal('modal-new-qj')
  await loadQuejas()
}

// ── Modal: DETALLE ────────────────────────────────────────────────
async function openDetail(id) {
  _currentQJId = id
  const r = _allQJ.find(x => x.id === id)
  if (!r) return

  setText('dq-folio-ttl',    r.folio)
  setText('dq-tipo-ttl',     tipoLabel(r.tipo))
  setText('dq-folio',        r.folio)
  setText('dq-fecha',        fmtDate(r.fecha))
  setText('dq-tipo',         tipoLabel(r.tipo))
  setText('dq-status',       statusLabel(r.status))
  setText('dq-nombre',       r.nombre_paciente   || '—')
  setText('dq-habitacion',   r.habitacion        || '—')
  setText('dq-telefono',     r.telefono          || '—')
  setText('dq-departamento', r.departamento      || '—')
  setText('dq-personal',     r.personal_involucrado || '—')
  setText('dq-descripcion',  r.descripcion       || '—')
  setText('dq-presenta',     r.nombre_presenta   || '—')
  setText('dq-recibe',       r.nombre_recibe     || '—')
  setText('dq-calidad',      r.nombre_calidad    || '—')

  const canManage = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)

  // Barra de estado
  const bar = document.getElementById('dq-status-bar')
  if (bar && canManage && r.status !== 'cerrado') {
    bar.innerHTML = `
      <div class="status-action-bar">
        <p><i class="fa-solid fa-circle-dot" style="margin-right:6px"></i>
           Estado actual: <strong>${statusLabel(r.status)}</strong></p>
        <div class="btns">
          ${r.status === 'pendiente'  ? `<button class="btn-primary" onclick="quickStatus('en_proceso')"><i class="fa-solid fa-play"></i> Iniciar proceso</button>` : ''}
          ${r.status === 'en_proceso' ? `<button class="btn-primary" onclick="quickStatus('resuelto')"><i class="fa-solid fa-check"></i> Marcar resuelto</button>` : ''}
          ${r.status === 'resuelto'   ? `<button class="btn-secondary" onclick="quickStatus('cerrado')"><i class="fa-solid fa-lock"></i> Cerrar</button>` : ''}
        </div>
      </div>`
  } else if (bar) {
    bar.innerHTML = ''
  }

  // Botón editar
  const btnEdit = document.getElementById('btn-edit-qj')
  if (btnEdit) btnEdit.style.display = canManage ? 'inline-flex' : 'none'

  // Seguimiento
  await loadNotas(id)

  // Panel de nota (solo managers)
  const notaWrap = document.getElementById('dq-nota-wrap')
  if (notaWrap) notaWrap.style.display = canManage ? 'block' : 'none'
  setVal('dq-nota-text', '')
  setVal('dq-new-status', '')

  openModal('modal-detail-qj')
}

function openEditQJ() {
  closeModal('modal-detail-qj')
  openEditQJFromTable(_currentQJId)
}

async function quickStatus(newStatus) {
  if (!_currentQJId) return
  const { error } = await db.from('quejas')
    .update({ status: newStatus, updated_at: new Date().toISOString() })
    .eq('id', _currentQJId)
  if (error) { showToast('Error: ' + error.message, 'red'); return }
  showToast('Estado actualizado.', 'green')
  closeModal('modal-detail-qj')
  await loadQuejas()
}

// ── Notas de seguimiento ─────────────────────────────────────────
async function loadNotas(qjId) {
  const wrap = document.getElementById('dq-seguimiento-wrap')
  const list = document.getElementById('dq-seguimiento-list')
  if (!wrap || !list) return

  const { data } = await db
    .from('quejas_notas')
    .select('*, author:created_by(full_name)')
    .eq('queja_id', qjId)
    .order('created_at', { ascending: true })

  if (!data || data.length === 0) {
    wrap.style.display = 'none'
    return
  }

  wrap.style.display = 'block'
  list.innerHTML = data.map(n => `
    <div class="nota-item">
      <div class="nota-meta">
        <strong>${esc(n.author?.full_name || '—')}</strong> ·
        ${fmtDateTime(n.created_at)}
        ${n.status_change ? `<span class="nota-status-change"><i class="fa-solid fa-arrow-right"></i> ${statusLabel(n.status_change)}</span>` : ''}
      </div>
      <div class="nota-texto">${esc(n.nota)}</div>
    </div>
  `).join('')
}

async function submitNota() {
  const btn   = document.getElementById('btn-nota')
  const texto = document.getElementById('dq-nota-text')?.value.trim()
  const newStatus = document.getElementById('dq-new-status')?.value || null

  if (!texto) { showToast('Escribe el texto de la nota.', 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i>'

  const notaPayload = {
    queja_id:      _currentQJId,
    nota:          texto,
    status_change: newStatus || null,
    created_by:    _user.id
  }

  const { error: notaErr } = await db.from('quejas_notas').insert(notaPayload)
  if (notaErr) {
    showToast('Error al guardar nota: ' + notaErr.message, 'red')
    btn.disabled = false
    btn.innerHTML = '<i class="fa-solid fa-paper-plane"></i> Guardar nota'
    return
  }

  if (newStatus) {
    await db.from('quejas')
      .update({ status: newStatus, updated_at: new Date().toISOString() })
      .eq('id', _currentQJId)
  }

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-paper-plane"></i> Guardar nota'
  setVal('dq-nota-text', '')
  setVal('dq-new-status', '')

  showToast('Nota guardada.', 'green')
  await loadNotas(_currentQJId)
  await loadQuejas()

  // Refrescar barra de estado si cambió el status
  if (newStatus) {
    const r = _allQJ.find(x => x.id === _currentQJId)
    if (r) { r.status = newStatus; openDetail(_currentQJId) }
  }
}

// ── Exportar CSV ─────────────────────────────────────────────────
function exportCSV() {
  const rows = _filteredQJ.length > 0 ? _filteredQJ : _allQJ
  if (rows.length === 0) { showToast('No hay registros para exportar.', 'red'); return }

  const headers = ['Folio','Fecha','Tipo','Nombre','Habitación','Teléfono',
                   'Departamento','Personal','Descripción','Presentó','Recibió','Calidad','Estado']
  const csv = [headers, ...rows.map(r => [
    r.folio, r.fecha, tipoLabel(r.tipo),
    r.nombre_paciente || '', r.habitacion || '', r.telefono || '',
    r.departamento || '', r.personal_involucrado || '', r.descripcion || '',
    r.nombre_presenta || '', r.nombre_recibe || '', r.nombre_calidad || '',
    statusLabel(r.status)
  ])].map(row => row.map(c => `"${String(c).replace(/"/g,'""')}"`).join(',')).join('\n')

  const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8;' })
  const a = document.createElement('a')
  a.href = URL.createObjectURL(blob)
  a.download = `QuejasYSugerencias_${new Date().toISOString().split('T')[0]}.csv`
  a.click()
  showToast('CSV exportado.', 'green')
}

// ── Helpers ───────────────────────────────────────────────────────
function tipoPill(tipo) {
  const icons = { queja:'fa-face-angry', sugerencia:'fa-lightbulb', felicitacion:'fa-star' }
  const icon  = icons[tipo] || 'fa-comment'
  return `<span class="pill-tipo pill-${tipo}">
    <i class="fa-solid ${icon}"></i> ${tipoLabel(tipo)}
  </span>`
}

function tipoLabel(t) {
  return { queja:'Queja', sugerencia:'Sugerencia', felicitacion:'Felicitación' }[t] || t || '—'
}

function statusPill(s) {
  return `<span class="pill-status pill-${s}">${statusLabel(s)}</span>`
}

function statusLabel(s) {
  return { pendiente:'Pendiente', en_proceso:'En Proceso', resuelto:'Resuelto', cerrado:'Cerrado' }[s] || s || '—'
}

function fmtDate(d) {
  if (!d) return '—'
  return new Date(d + 'T12:00:00').toLocaleDateString('es-MX',
    { day: '2-digit', month: 'short', year: 'numeric' })
}

function fmtDateTime(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('es-MX',
    { day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' })
}

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
  const tbody = document.getElementById('qj-tbody')
  if (tbody) tbody.innerHTML = `
    <tr><td colspan="8" style="text-align:center;padding:48px;color:var(--txt3)">
      <i class="fa-solid fa-spinner fa-spin" style="font-size:1.5rem"></i>
    </td></tr>`
  setText('qj-count', 'Cargando…')
}

function showError(msg) {
  const tbody = document.getElementById('qj-tbody')
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

// ── Arrancar ──────────────────────────────────────────────────────
initQuejas()
