// ─── Acciones Correctivas — Cláusula 10.2 ──────────────────────

let _user       = null
let _profile    = null
let _role       = null
let _allAC      = []
let _currentAC  = null
let _editActivities = []

// ── Init ────────────────────────────────────────────────────────
async function initAC() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  renderUserInfo()
  setCurrentDate()
  await loadAC()
  applyRoleUI()
}

function renderUserInfo() {
  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
}

function setCurrentDate() {
  const el = document.getElementById('current-date')
  if (el) el.textContent = new Date().toLocaleDateString('es-MX',
    { weekday:'long', day:'numeric', month:'long', year:'numeric' })
}

function applyRoleUI() {
  const canWrite = ['administrador','responsable_calidad','jefe_departamento','auditor'].includes(_role)
  const btn = document.getElementById('btn-new-ac')
  if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'
  const btnAdd = document.getElementById('btn-add-activity')
  if (btnAdd) btnAdd.style.display = canWrite ? 'inline-flex' : 'none'
}

// ── Load ─────────────────────────────────────────────────────────
async function loadAC() {
  const { data, error } = await db
    .from('planes_correctivos')
    .select('*')
    .order('detection_date', { ascending: false })

  if (error) {
    showToast('Error al cargar: ' + error.message, 'red')
    setText('ac-count', 'Error al cargar')
    return
  }
  _allAC = data || []
  renderKPIs()
  applyFilters()
}

// ── KPIs ─────────────────────────────────────────────────────────
function renderKPIs() {
  const today = new Date()
  let total = _allAC.length, abiertas = 0, enProceso = 0, cerradas = 0, vencidas = 0

  _allAC.forEach(ac => {
    if (ac.status === 'abierto')     abiertas++
    else if (ac.status === 'en_proceso') enProceso++
    else if (ac.status === 'cerrado')    cerradas++

    const acts = ac.activities || []
    acts.forEach(a => {
      if (a.status !== 'completado' && a.status !== 'cancelado' && a.due_date) {
        if (new Date(a.due_date) < today) vencidas++
      }
    })
  })

  setText('kpi-total',      total)
  setText('kpi-abiertas',   abiertas)
  setText('kpi-en-proceso', enProceso)
  setText('kpi-cerradas',   cerradas)
  setText('kpi-vencidas',   vencidas)
}

// ── Filters ──────────────────────────────────────────────────────
function applyFilters() {
  const q      = (document.getElementById('search-input')?.value || '').toLowerCase()
  const status = document.getElementById('f-status')?.value || ''

  const filtered = _allAC.filter(ac => {
    const txt = `${ac.number || ''} ${ac.nc_description || ''} ${ac.responsible || ''}`.toLowerCase()
    return (!q      || txt.includes(q))
        && (!status || ac.status === status)
  })
  renderTable(filtered)
}

// ── Render Table ─────────────────────────────────────────────────
function renderTable(list) {
  const tbody = document.getElementById('ac-tbody')
  const count = document.getElementById('ac-count')
  if (count) count.textContent = `${list.length} acción${list.length !== 1 ? 'es' : ''} correctiva${list.length !== 1 ? 's' : ''}`
  if (!tbody) return

  if (list.length === 0) {
    tbody.innerHTML = `<tr><td colspan="7" class="table-empty">
      <i class="fa-solid fa-circle-check"></i>
      <strong>Sin resultados</strong>
      No hay acciones correctivas que coincidan con los filtros.
    </td></tr>`
    return
  }

  const today = new Date()
  tbody.innerHTML = list.map(ac => {
    const acts = ac.activities || []
    const done = acts.filter(a => a.status === 'completado').length
    const pct  = acts.length ? Math.round(done / acts.length * 100) : 0
    const hasOverdue = acts.some(a =>
      a.status !== 'completado' && a.status !== 'cancelado' && a.due_date && new Date(a.due_date) < today
    )

    return `
    <tr>
      <td><span class="ac-number">${esc(ac.number || '—')}</span></td>
      <td>
        <span class="ac-desc" title="${esc(ac.nc_description || '')}">${esc(ac.nc_description || '—')}</span>
        <span style="font-size:.75rem;color:var(--txt3)">${esc(ac.source || '')}</span>
      </td>
      <td style="font-size:.857rem">${esc(ac.responsible || '—')}</td>
      <td class="center" style="font-size:.857rem;white-space:nowrap">${fmtDate(ac.detection_date)}</td>
      <td class="center">
        <div class="act-progress">
          <span class="act-fraction">${done}/${acts.length}</span>
          <div class="progress-bar"><div class="progress-fill" style="width:${pct}%"></div></div>
          ${hasOverdue ? '<span class="overdue-badge">VENCIDA</span>' : ''}
        </div>
      </td>
      <td class="center"><span class="${statusClass(ac.status)}">${statusLabel(ac.status)}</span></td>
      <td class="center">
        <div class="action-btns">
          <button onclick="openDetail('${ac.id}')" class="btn-action" title="Ver detalle">
            <i class="fa-solid fa-eye"></i>
          </button>
        </div>
      </td>
    </tr>`
  }).join('')
}

// ── Modal: Nueva AC ──────────────────────────────────────────────
function openNewAC() {
  const canWrite = ['administrador','responsable_calidad','jefe_departamento','auditor'].includes(_role)
  if (!canWrite) return

  const year = new Date().getFullYear()
  const next = (_allAC.length + 1).toString().padStart(3, '0')
  setVal('new-number',      `AC-${year}-${next}`)
  setVal('new-date',        new Date().toISOString().split('T')[0])
  setVal('new-source',      'Queja y/o sugerencia')
  setVal('new-responsible', '')
  setVal('new-description', '')
  setVal('new-rootcause',   '')
  openModal('modal-new')
}

async function submitNewAC() {
  const btn  = document.getElementById('btn-save-new')
  const num  = document.getElementById('new-number')?.value.trim()
  const date = document.getElementById('new-date')?.value
  const src  = document.getElementById('new-source')?.value
  const resp = document.getElementById('new-responsible')?.value.trim()
  const desc = document.getElementById('new-description')?.value.trim()
  const root = document.getElementById('new-rootcause')?.value.trim()

  if (!num)  { showToast('Indica el número de acción.', 'red'); return }
  if (!date) { showToast('Indica la fecha de detección.', 'red'); return }
  if (!resp) { showToast('Indica el responsable.', 'red'); return }
  if (!desc) { showToast('La descripción del hallazgo es obligatoria.', 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const { error } = await db.rpc('save_plan_correctivo', {
    p_row: {
      number:         num,
      detection_date: date,
      source:         src,
      responsible:    resp,
      nc_description: desc,
      root_cause:     root || null,
      status:         'abierto',
      activities:     [],
      created_by:     _user.id
    }
  })

  if (error) {
    showToast('Error: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Registrar')
    return
  }

  showToast('Acción correctiva registrada correctamente.', 'green')
  closeModal('modal-new')
  resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Registrar')
  await loadAC()
}

// ── Modal: Detalle ───────────────────────────────────────────────
async function openDetail(id) {
  _currentAC = _allAC.find(a => a.id === id)
  if (!_currentAC) return

  const ac = _currentAC
  setText('detail-number', ac.number || '—')
  setText('detail-source', ac.source || '—')

  // Tab Info
  setText('d-number',     ac.number || '—')
  setText('d-date',       fmtDate(ac.detection_date))
  setText('d-source',     ac.source || '—')
  setText('d-created-by', ac.created_by_name || '—')

  setVal('d-status',        ac.status || 'abierto')
  setVal('d-responsible',   ac.responsible || '')
  setVal('d-description',   ac.nc_description || '')
  setVal('d-rootcause',     ac.root_cause || '')
  setVal('d-effectiveness', ac.effectiveness_verification || '')
  setVal('d-close-date',    ac.close_date ? ac.close_date.split('T')[0] : '')

  // Tab Actividades
  _editActivities = JSON.parse(JSON.stringify(ac.activities || []))
  renderActivities()
  updateTabBadge()

  switchTab('tab-info', document.querySelector('.tab-btn'))
  openModal('modal-detail')
}

// ── Save Info ────────────────────────────────────────────────────
async function saveInfo() {
  if (!_currentAC) return
  const ac = _currentAC

  const payload = {
    id:                     ac.id,
    number:                 ac.number,
    detection_date:         ac.detection_date,
    source:                 ac.source,
    responsible:            document.getElementById('d-responsible')?.value.trim(),
    nc_description:         document.getElementById('d-description')?.value.trim(),
    root_cause:             document.getElementById('d-rootcause')?.value.trim(),
    status:                 document.getElementById('d-status')?.value,
    effectiveness_verification: document.getElementById('d-effectiveness')?.value.trim(),
    close_date:             document.getElementById('d-close-date')?.value || null,
    activities:             ac.activities || [],
    created_by:             ac.created_by
  }

  const { error } = await db.rpc('save_plan_correctivo', { p_row: payload })

  if (error) { showToast('Error: ' + error.message, 'red'); return }

  Object.assign(_currentAC, {
    responsible:            payload.responsible,
    nc_description:         payload.nc_description,
    root_cause:             payload.root_cause,
    status:                 payload.status,
    effectiveness_verification: payload.effectiveness_verification,
    close_date:             payload.close_date
  })
  const idx = _allAC.findIndex(a => a.id === ac.id)
  if (idx > -1) Object.assign(_allAC[idx], _currentAC)

  showToast('Cambios guardados.', 'green')
  renderKPIs()
  applyFilters()
}

// ── Actividades ──────────────────────────────────────────────────
function renderActivities() {
  const list = document.getElementById('activities-list')
  if (!list) return
  const canWrite = ['administrador','responsable_calidad','jefe_departamento','auditor'].includes(_role)

  if (_editActivities.length === 0) {
    list.innerHTML = `<div class="no-activities">
      <i class="fa-solid fa-list-check"></i>
      Sin actividades registradas aún.
      ${canWrite ? 'Usa "Agregar actividad" para crear el plan de acción.' : ''}
    </div>`
    return
  }

  const today = new Date()
  list.innerHTML = _editActivities.map((a, i) => {
    const overdue = a.due_date && new Date(a.due_date) < today
      && a.status !== 'completado' && a.status !== 'cancelado'
    return `
    <div class="activity-row">
      <div class="activity-num">${i + 1}</div>
      <div class="activity-main">
        <textarea rows="2" oninput="_editActivities[${i}].description=this.value"
          placeholder="Descripción de la actividad…"
          ${canWrite ? '' : 'readonly'}
        >${esc(a.description || '')}</textarea>
        <div class="activity-meta">
          <input type="text" value="${esc(a.responsible || '')}"
            oninput="_editActivities[${i}].responsible=this.value"
            placeholder="Responsable"
            ${canWrite ? '' : 'readonly'}
          >
          <input type="date" value="${a.due_date ? a.due_date.split('T')[0] : ''}"
            onchange="_editActivities[${i}].due_date=this.value"
            ${canWrite ? '' : 'readonly'}
          >
          ${overdue ? '<span class="overdue-badge">VENCIDA</span>' : ''}
          <select onchange="_editActivities[${i}].status=this.value" ${canWrite ? '' : 'disabled'}>
            <option value="pendiente"  ${a.status==='pendiente' ?'selected':''}>Pendiente</option>
            <option value="en_proceso" ${a.status==='en_proceso'?'selected':''}>En Proceso</option>
            <option value="completado" ${a.status==='completado'?'selected':''}>Completado</option>
            <option value="cancelado"  ${a.status==='cancelado' ?'selected':''}>Cancelado</option>
          </select>
        </div>
      </div>
      ${canWrite ? `<button class="btn-remove" onclick="removeActivity(${i})" title="Eliminar">
        <i class="fa-solid fa-trash-can"></i>
      </button>` : ''}
    </div>`
  }).join('')
}

function addActivity() {
  _editActivities.push({ description:'', responsible:'', due_date:'', status:'pendiente' })
  renderActivities()
  updateTabBadge()
}

function removeActivity(idx) {
  _editActivities.splice(idx, 1)
  renderActivities()
  updateTabBadge()
}

async function saveActivities() {
  if (!_currentAC) return

  const payload = {
    id:             _currentAC.id,
    number:         _currentAC.number,
    detection_date: _currentAC.detection_date,
    source:         _currentAC.source,
    responsible:    _currentAC.responsible,
    nc_description: _currentAC.nc_description,
    root_cause:     _currentAC.root_cause,
    status:         _currentAC.status,
    effectiveness_verification: _currentAC.effectiveness_verification,
    close_date:     _currentAC.close_date,
    activities:     _editActivities,
    created_by:     _currentAC.created_by
  }

  const { error } = await db.rpc('save_plan_correctivo', { p_row: payload })
  if (error) { showToast('Error: ' + error.message, 'red'); return }

  _currentAC.activities = JSON.parse(JSON.stringify(_editActivities))
  const idx = _allAC.findIndex(a => a.id === _currentAC.id)
  if (idx > -1) _allAC[idx].activities = _currentAC.activities

  showToast('Actividades guardadas.', 'green')
  updateTabBadge()
  renderKPIs()
  applyFilters()
}

function updateTabBadge() {
  const badge = document.getElementById('tab-act-count')
  if (badge) {
    badge.textContent = _editActivities.length
    badge.style.display = _editActivities.length ? 'inline-block' : 'none'
  }
}

// ── Tab switch ───────────────────────────────────────────────────
function switchTab(panelId, btn) {
  document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'))
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'))
  const panel = document.getElementById(panelId)
  if (panel) panel.classList.add('active')
  if (btn) btn.classList.add('active')
}

// ── Modal helpers ─────────────────────────────────────────────────
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }

// ── Helpers ──────────────────────────────────────────────────────
function statusClass(s) {
  const map = { abierto:'status-abierto', en_proceso:'status-en_proceso', cerrado:'status-cerrado' }
  return map[s] || 'status-abierto'
}
function statusLabel(s) {
  const map = { abierto:'Abierta', en_proceso:'En Proceso', cerrado:'Cerrada' }
  return map[s] || s || '—'
}
function fmtDate(d) {
  if (!d) return '—'
  const [y, m, day] = (d.split('T')[0]).split('-')
  const ms = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic']
  return `${parseInt(day)} ${ms[parseInt(m)-1]} ${y}`
}
function esc(s) {
  return String(s ?? '').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}
function setText(id, v) { const e = document.getElementById(id); if (e) e.textContent = v }
function setVal(id, v)  { const e = document.getElementById(id); if (e) e.value = v }
function resetBtn(btn, html) { btn.disabled = false; btn.innerHTML = html }
function showToast(msg, type='green') {
  const t = document.createElement('div')
  t.className = `toast ${type}`
  t.textContent = msg
  document.body.appendChild(t)
  setTimeout(() => t.remove(), 3500)
}

// ── Boot ──────────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', initAC)
