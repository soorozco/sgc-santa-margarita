// ─── No Conformidades — Cláusulas 8.7 / 10.2 ──────────────────

let _user    = null
let _profile = null
let _role    = null
let _allNC   = []
let _depts   = []
let _activeStatus = ''   // chip filter
let _currentNCId  = null
let _currentNC    = null
let _actions      = []

// ── Init ────────────────────────────────────────────────────────
async function initNC() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  renderUserInfo()
  setCurrentDate()
  await loadDepts()
  populateDeptFilters()
  await loadNC()
  setupFilters()
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

// ── Catálogos ───────────────────────────────────────────────────
async function loadDepts() {
  const { data } = await db.from('departments')
    .select('id,code,name').eq('is_active', true).order('name')
  _depts = data || []
}

function populateDeptFilters() {
  const opts = _depts.map(d => `<option value="${d.id}">${d.name}</option>`).join('')
  const fDept   = document.getElementById('f-dept')
  const newDept = document.getElementById('new-dept')
  if (fDept)   fDept.innerHTML   = `<option value="">Todos los departamentos</option>${opts}`
  if (newDept) newDept.innerHTML = `<option value="">— Seleccionar —</option>${opts}`
}

function applyRoleUI() {
  const canWrite = ['administrador','responsable_calidad','jefe_departamento','auditor'].includes(_role)
  const btn = document.getElementById('btn-new-nc')
  if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'
}

// ── Load NC ─────────────────────────────────────────────────────
async function loadNC() {
  showLoading()
  const { data, error } = await db
    .from('nonconformities')
    .select('*, departments(id,name)')
    .order('created_at', { ascending: false })

  if (error) { showError(error.message); return }
  _allNC = data || []
  updateCounts()
  applyFilters()
}

function updateCounts() {
  const counts = { abierto:0, en_proceso:0, pendiente_verificacion:0, cerrado:0 }
  _allNC.forEach(nc => { if (nc.status in counts) counts[nc.status]++ })
  setText('cnt-all',     _allNC.length)
  setText('cnt-abierto', counts.abierto)
  setText('cnt-proceso', counts.en_proceso)
  setText('cnt-verif',   counts.pendiente_verificacion)
  setText('cnt-cerrado', counts.cerrado)

  // Badge sidebar
  const badge = document.getElementById('badge-nc')
  if (badge) {
    const open = counts.abierto + counts.en_proceso
    badge.textContent = open
    badge.style.display = open > 0 ? 'inline' : 'none'
  }
}

// ── Filters ─────────────────────────────────────────────────────
function setupFilters() {
  ['search-input','f-dept','f-source'].forEach(id => {
    const el = document.getElementById(id)
    if (el) el.addEventListener('input', applyFilters)
  })
}

function filterByChip(el, status) {
  _activeStatus = status
  document.querySelectorAll('.chip').forEach(c => {
    c.className = 'chip'
  })
  const colorMap = {
    '': 'active-all', abierto:'active-red',
    en_proceso:'active-orange', pendiente_verificacion:'active-blue', cerrado:'active-green'
  }
  el.classList.add(colorMap[status] || 'active-all')
  applyFilters()
}

function applyFilters() {
  const q      = (document.getElementById('search-input')?.value || '').toLowerCase()
  const dept   = document.getElementById('f-dept')?.value   || ''
  const source = document.getElementById('f-source')?.value || ''

  const filtered = _allNC.filter(nc => {
    const txt = `${nc.folio || ''} ${nc.finding_description || ''} ${nc.departments?.name || ''}`.toLowerCase()
    return (!q      || txt.includes(q))
        && (!dept   || nc.department_id === dept)
        && (!source || nc.source        === source)
        && (!_activeStatus || nc.status === _activeStatus)
  })
  renderTable(filtered)
}

// ── Render table ─────────────────────────────────────────────────
function renderTable(ncs) {
  const tbody = document.getElementById('nc-tbody')
  const count = document.getElementById('nc-count')
  if (count) count.textContent = `${ncs.length} no conformidad${ncs.length !== 1 ? 'es' : ''}`
  if (!tbody) return

  if (ncs.length === 0) {
    tbody.innerHTML = `<tr><td colspan="8" class="table-empty">
      <i class="fa-solid fa-circle-check"></i>
      <strong>Sin resultados</strong>
      No hay no conformidades que coincidan con los filtros.
    </td></tr>`
    return
  }

  const today = new Date()
  tbody.innerHTML = ncs.map(nc => {
    const days    = nc.finding_date ? daysDiff(nc.finding_date, today) : null
    const daysBadge = days === null ? '' : daysLabel(days, nc.status)
    return `
    <tr>
      <td><span class="nc-folio">${esc(nc.folio || '—')}</span></td>
      <td><span class="nc-desc" title="${esc(nc.finding_description)}">${esc(nc.finding_description || '—')}</span></td>
      <td>${esc(nc.departments?.name || '—')}</td>
      <td><span class="pill pill-gray">${sourceLabel(nc.source)}</span></td>
      <td class="center">${fmtDate(nc.finding_date)}</td>
      <td class="center">${daysBadge}</td>
      <td class="center"><span class="pill ${sPill(nc.status)}">${sLabel(nc.status)}</span></td>
      <td>
        <div class="action-btns">
          <button onclick="openDetail('${nc.id}')" class="btn-action" title="Ver detalle">
            <i class="fa-solid fa-eye"></i>
          </button>
        </div>
      </td>
    </tr>`
  }).join('')
}

// ── Modal: Nueva NC ──────────────────────────────────────────────
function openNewNC() {
  ['new-dept','new-source','new-date','new-detected-by',
   'new-description','new-clause','new-immediate'].forEach(id => {
    const el = document.getElementById(id)
    if (el) el.value = ''
  })
  setVal('new-date', new Date().toISOString().split('T')[0])
  openModal('modal-new')
}

async function submitNewNC() {
  const btn  = document.getElementById('btn-save-new')
  const dept = document.getElementById('new-dept')?.value
  const src  = document.getElementById('new-source')?.value
  const date = document.getElementById('new-date')?.value
  const det  = document.getElementById('new-detected-by')?.value.trim()
  const desc = document.getElementById('new-description')?.value.trim()
  const cls  = document.getElementById('new-clause')?.value.trim()
  const imm  = document.getElementById('new-immediate')?.value.trim()

  if (!dept) { showToast('Selecciona el departamento.', 'red'); return }
  if (!src)  { showToast('Selecciona la fuente de detección.', 'red'); return }
  if (!date) { showToast('Indica la fecha de detección.', 'red'); return }
  if (!det)  { showToast('Indica quién detectó la NC.', 'red'); return }
  if (!desc) { showToast('La descripción del hallazgo es obligatoria.', 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Registrando…'

  const { data, error } = await db.from('nonconformities').insert({
    department_id:       dept,
    source:              src,
    finding_date:        date,
    detected_by:         det,
    finding_description: desc,
    requirement_clause:  cls  || null,
    immediate_action:    imm  || null,
    status:              'abierto',
    created_by:          _user.id
  }).select().single()

  if (error) {
    showToast('Error al registrar: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Registrar NC')
    return
  }

  showToast(`NC registrada con folio ${data.folio || '(generando…)'}`, 'green')
  closeModal('modal-new')
  resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Registrar NC')
  await loadNC()
}

// ── Modal: Detalle NC ────────────────────────────────────────────
async function openDetail(ncId) {
  _currentNCId = ncId
  _currentNC   = _allNC.find(n => n.id === ncId)
  if (!_currentNC) return

  const nc = _currentNC
  setText('detail-folio',   nc.folio || '—')
  setText('detail-desc-ttl', trunc(nc.finding_description, 60))

  // Tab Info
  setText('d-folio',    nc.folio || '—')
  setText('d-status',   sLabel(nc.status))
  setText('d-dept',     nc.departments?.name || '—')
  setText('d-source',   sourceLabel(nc.source))
  setText('d-date',     fmtDate(nc.finding_date))
  setText('d-detected', nc.detected_by || '—')
  setText('d-clause',   nc.requirement_clause || '—')
  setText('d-closed',   nc.closed_date ? fmtDate(nc.closed_date) : 'Pendiente')
  setText('d-description', nc.finding_description || '—')
  setText('d-immediate',   nc.immediate_action    || 'Sin acción inmediata registrada')

  // Workflow
  renderWorkflow(nc.status)
  renderActionBar(nc)

  // Tab Causas
  renderIshikawaView(nc)

  // Tab Plan
  await loadActions(ncId)

  // Tab Cierre
  renderCierre(nc)

  // Reset tabs to first
  switchTab('tab-info', document.querySelector('.tab-btn'))

  openModal('modal-detail')
}

// ── Workflow bar ─────────────────────────────────────────────────
function renderWorkflow(status) {
  const steps = [
    { key:'abierto',               label:'Abierto',          icon:'fa-circle-exclamation' },
    { key:'en_proceso',            label:'En Proceso',        icon:'fa-gears' },
    { key:'pendiente_verificacion',label:'Pend. Verificación',icon:'fa-clock' },
    { key:'cerrado',               label:'Cerrado',           icon:'fa-circle-check' }
  ]
  const order  = steps.map(s => s.key)
  const curIdx = order.indexOf(status)

  const html = steps.map((s, i) => {
    const cls   = i < curIdx ? 'done' : i === curIdx ? 'current' : ''
    const arrow = i < steps.length - 1
      ? `<span class="wf-arrow"><i class="fa-solid fa-chevron-right"></i></span>` : ''
    return `<span class="wf-step ${cls}"><i class="fa-solid ${s.icon}"></i> ${s.label}</span>${arrow}`
  }).join('')

  setText('detail-workflow', '')
  const el = document.getElementById('detail-workflow')
  if (el) el.innerHTML = html
}

// ── Action bar (status transitions) ─────────────────────────────
function renderActionBar(nc) {
  const bar      = document.getElementById('detail-action-bar')
  if (!bar) return

  const canWrite   = ['administrador','responsable_calidad','jefe_departamento','auditor'].includes(_role)
  const canApprove = ['administrador','responsable_calidad'].includes(_role)

  bar.innerHTML = ''

  if (nc.status === 'abierto' && canWrite) {
    bar.innerHTML = `
      <div class="verify-bar" style="margin-bottom:16px">
        <p><i class="fa-solid fa-circle-exclamation" style="margin-right:6px"></i>
           NC abierta — registra el plan de acción y cámbiala a "En Proceso".</p>
        <div class="btns">
          <button class="btn-primary" onclick="changeStatus('en_proceso')">
            <i class="fa-solid fa-gears"></i> Iniciar Proceso
          </button>
        </div>
      </div>`
  } else if (nc.status === 'en_proceso' && canWrite) {
    bar.innerHTML = `
      <div class="verify-bar" style="margin-bottom:16px">
        <p><i class="fa-solid fa-gears" style="margin-right:6px"></i>
           Plan de acción en ejecución — cuando completes las acciones, envía a verificación.</p>
        <div class="btns">
          <button class="btn-primary" onclick="changeStatus('pendiente_verificacion')">
            <i class="fa-solid fa-clock"></i> Enviar a Verificación
          </button>
        </div>
      </div>`
  } else if (nc.status === 'pendiente_verificacion' && canApprove) {
    bar.innerHTML = `
      <div class="verify-bar" style="margin-bottom:16px">
        <p><i class="fa-solid fa-clock" style="margin-right:6px"></i>
           Pendiente de verificación de eficacia — ve a la pestaña Cierre.</p>
        <div class="btns">
          <button class="btn-secondary" style="color:var(--red);border-color:var(--red)"
                  onclick="changeStatus('en_proceso')">
            <i class="fa-solid fa-rotate-left"></i> Regresar
          </button>
          <button class="btn-success" onclick="switchTab('tab-cierre', document.querySelectorAll('.tab-btn')[3])">
            <i class="fa-solid fa-flag-checkered"></i> Ir a Cierre
          </button>
        </div>
      </div>`
  } else if (nc.status === 'cerrado') {
    bar.innerHTML = `
      <div class="verify-bar close-bar" style="margin-bottom:16px">
        <p><i class="fa-solid fa-circle-check" style="margin-right:6px"></i>
           NC cerrada y verificada correctamente.</p>
      </div>`
  }
}

async function changeStatus(newStatus) {
  if (!_currentNCId) return

  const updateData = { status: newStatus, updated_at: new Date().toISOString() }
  if (newStatus === 'cerrado') updateData.closed_date = new Date().toISOString().split('T')[0]

  const { error } = await db.from('nonconformities')
    .update(updateData).eq('id', _currentNCId)

  if (error) { showToast('Error: ' + error.message, 'red'); return }

  const labels = {
    en_proceso:'NC iniciada — en proceso de corrección',
    pendiente_verificacion:'Enviada a verificación',
    en_proceso2:'Regresada a proceso',
    cerrado:'NC cerrada y verificada ✅'
  }
  showToast(labels[newStatus] || 'Estado actualizado', 'green')
  closeModal('modal-detail')
  await loadNC()
}

// ── Ishikawa ────────────────────────────────────────────────────
const ISHI_FIELDS = [
  { key:'ishikawa_people',      label:'Personas',   icon:'fa-users' },
  { key:'ishikawa_methods',     label:'Métodos',    icon:'fa-diagram-project' },
  { key:'ishikawa_machines',    label:'Máquinas',   icon:'fa-wrench' },
  { key:'ishikawa_materials',   label:'Materiales', icon:'fa-boxes-stacked' },
  { key:'ishikawa_environment', label:'Entorno',    icon:'fa-building' },
  { key:'ishikawa_measurement', label:'Medición',   icon:'fa-ruler' }
]

function renderIshikawaView(nc) {
  const grid = document.getElementById('ishikawa-view')
  if (!grid) return

  grid.innerHTML = ISHI_FIELDS.map(f => {
    const val = nc[f.key]
    return `
    <div class="ishi-card">
      <label><i class="fa-solid ${f.icon}"></i>${f.label}</label>
      ${val
        ? `<div class="ishi-text">${esc(val)}</div>`
        : `<div class="ishi-empty">Sin causa registrada</div>`}
    </div>`
  }).join('')

  // Root cause view
  const rcView = document.getElementById('root-cause-view')
  if (rcView) rcView.textContent = nc.root_cause || 'Sin causa raíz determinada aún'

  // Show edit section for qualified users
  const canWrite = ['administrador','responsable_calidad','jefe_departamento','auditor'].includes(_role)
  const editSec = document.getElementById('causas-edit-section')
  if (editSec) editSec.style.display = canWrite ? 'block' : 'none'

  if (canWrite) buildIshikawaEdit(nc)
}

function buildIshikawaEdit(nc) {
  const grid = document.getElementById('ishikawa-edit')
  if (!grid) return
  grid.innerHTML = ISHI_FIELDS.map(f => `
    <div class="ishi-card">
      <label><i class="fa-solid ${f.icon}"></i>${f.label}</label>
      <textarea id="edit-${f.key}" placeholder="Causas en ${f.label.toLowerCase()}…">${esc(nc[f.key] || '')}</textarea>
    </div>`).join('')

  setVal('edit-root-cause', nc.root_cause || '')
}

async function saveCausas() {
  if (!_currentNCId) return

  const update = { updated_at: new Date().toISOString() }
  ISHI_FIELDS.forEach(f => {
    const el = document.getElementById(`edit-${f.key}`)
    if (el) update[f.key] = el.value.trim() || null
  })
  const rc = document.getElementById('edit-root-cause')
  if (rc) update.root_cause = rc.value.trim() || null

  const { error } = await db.from('nonconformities').update(update).eq('id', _currentNCId)
  if (error) { showToast('Error: ' + error.message, 'red'); return }

  showToast('Causas guardadas correctamente.', 'green')
  // Update local copy
  const idx = _allNC.findIndex(n => n.id === _currentNCId)
  if (idx > -1) Object.assign(_allNC[idx], update)
  _currentNC = _allNC.find(n => n.id === _currentNCId)
  renderIshikawaView(_currentNC)
}

// ── Action plan ──────────────────────────────────────────────────
async function loadActions(ncId) {
  const { data } = await db.from('corrective_actions')
    .select('*')
    .eq('nonconformity_id', ncId)
    .order('created_at', { ascending: true })

  _actions = data || []
  renderActions()
}

function renderActions() {
  const list = document.getElementById('actions-list')
  const canWrite = ['administrador','responsable_calidad','jefe_departamento','auditor'].includes(_role)

  const btnAdd = document.getElementById('btn-add-action')
  if (btnAdd) btnAdd.style.display = canWrite ? 'inline-flex' : 'none'

  if (_actions.length === 0) {
    if (list) list.innerHTML = `
      <div class="plan-empty">
        <i class="fa-solid fa-list-check"></i>
        Sin acciones correctivas registradas aún.<br>
        ${canWrite ? 'Usa el botón "Agregar Acción" para crear el plan.' : ''}
      </div>`
    updatePlanProgress()
    return
  }

  if (list) list.innerHTML = _actions.map(a => {
    const isDone = a.status === 'completado'
    const overdue = a.due_date && new Date(a.due_date) < new Date() && !isDone
    return `
    <div class="action-item ${isDone ? 'done-item' : ''}">
      <div class="action-item-desc">
        <div class="action-item-title">${esc(a.description || '—')}</div>
        <div class="action-item-meta">
          <i class="fa-solid fa-user" style="margin-right:4px;font-size:10px"></i>${esc(a.responsible_position || '—')}
          &nbsp;·&nbsp;
          <i class="fa-solid fa-calendar" style="margin-right:4px;font-size:10px"></i>
          <span ${overdue ? 'style="color:var(--red);font-weight:600"' : ''}>${fmtDate(a.due_date)}</span>
          ${overdue ? '<span style="color:var(--red);font-size:10px;margin-left:4px">VENCIDA</span>' : ''}
        </div>
      </div>
      <div class="action-item-status">
        ${canWrite ? `
        <select onchange="updateActionStatus('${a.id}', this.value)">
          <option value="pendiente"    ${a.status==='pendiente'    ?'selected':''}>Pendiente</option>
          <option value="en_proceso"   ${a.status==='en_proceso'   ?'selected':''}>En Proceso</option>
          <option value="completado"   ${a.status==='completado'   ?'selected':''}>Completado</option>
          <option value="cancelado"    ${a.status==='cancelado'    ?'selected':''}>Cancelado</option>
        </select>` : `<span class="pill ${aPill(a.status)}">${aLabel(a.status)}</span>`}
      </div>
      ${canWrite ? `
      <button class="btn-action red" onclick="deleteAction('${a.id}')" title="Eliminar">
        <i class="fa-solid fa-trash"></i>
      </button>` : ''}
    </div>`
  }).join('')

  updatePlanProgress()
}

function updatePlanProgress() {
  const wrap = document.getElementById('plan-progress-wrap')
  if (_actions.length === 0) { if (wrap) wrap.style.display = 'none'; return }
  if (wrap) wrap.style.display = 'block'

  const done = _actions.filter(a => a.status === 'completado').length
  const pct  = Math.round((done / _actions.length) * 100)
  setText('plan-pct', `${pct}%  (${done}/${_actions.length})`)
  const fill = document.getElementById('plan-fill')
  if (fill) fill.style.width = `${pct}%`
}

function toggleAddForm() {
  const form = document.getElementById('add-action-form')
  if (!form) return
  const isOpen = form.style.display !== 'none'
  form.style.display = isOpen ? 'none' : 'block'
  if (!isOpen) {
    setVal('act-desc', '')
    setVal('act-responsible', '')
    setVal('act-due', '')
  }
}

async function saveAction() {
  const desc = document.getElementById('act-desc')?.value.trim()
  const resp = document.getElementById('act-responsible')?.value.trim()
  const due  = document.getElementById('act-due')?.value

  if (!desc) { showToast('La descripción de la acción es obligatoria.', 'red'); return }
  if (!resp) { showToast('Indica el responsable de la acción.', 'red'); return }
  if (!due)  { showToast('Indica la fecha límite.', 'red'); return }

  const { error } = await db.from('corrective_actions').insert({
    nonconformity_id:    _currentNCId,
    description:         desc,
    responsible_position: resp,
    due_date:            due,
    status:              'pendiente',
    created_by:          _user.id
  })

  if (error) { showToast('Error: ' + error.message, 'red'); return }

  showToast('Acción agregada al plan.', 'green')
  toggleAddForm()
  await loadActions(_currentNCId)

  // Si la NC está abierta, cambiar a en_proceso automáticamente
  if (_currentNC?.status === 'abierto') {
    await db.from('nonconformities')
      .update({ status:'en_proceso', updated_at: new Date().toISOString() })
      .eq('id', _currentNCId)
    const idx = _allNC.findIndex(n => n.id === _currentNCId)
    if (idx > -1) _allNC[idx].status = 'en_proceso'
    _currentNC.status = 'en_proceso'
    renderWorkflow('en_proceso')
    renderActionBar(_currentNC)
    updateCounts()
  }
}

async function updateActionStatus(actionId, newStatus) {
  const update = { status: newStatus }
  if (newStatus === 'completado') update.completion_date = new Date().toISOString().split('T')[0]

  const { error } = await db.from('corrective_actions').update(update).eq('id', actionId)
  if (error) { showToast('Error: ' + error.message, 'red'); return }

  const idx = _actions.findIndex(a => a.id === actionId)
  if (idx > -1) Object.assign(_actions[idx], update)
  renderActions()
}

async function deleteAction(actionId) {
  if (!confirm('¿Eliminar esta acción del plan?')) return
  const { error } = await db.from('corrective_actions').delete().eq('id', actionId)
  if (error) { showToast('Error: ' + error.message, 'red'); return }
  _actions = _actions.filter(a => a.id !== actionId)
  renderActions()
}

// ── Cierre / Verificación ────────────────────────────────────────
function renderCierre(nc) {
  const bar       = document.getElementById('cierre-bar')
  const verifForm = document.getElementById('verif-form')
  const verifView = document.getElementById('verif-result-view')
  const cierreInfo= document.getElementById('cierre-info')
  const empty     = document.getElementById('cierre-empty')

  const canApprove = ['administrador','responsable_calidad'].includes(_role)

  if (nc.status === 'cerrado') {
    if (bar) bar.innerHTML = `
      <div class="verify-bar close-bar" style="margin-bottom:16px">
        <p><i class="fa-solid fa-circle-check" style="margin-right:6px"></i>
           NC cerrada y verificada. No se requiere más acción.</p>
      </div>`
    if (verifForm) verifForm.style.display = 'none'
    if (verifView) {
      verifView.style.display = 'block'
      setText('d-verif-text', nc.effectiveness_result || 'Sin resultado de verificación registrado')
    }
    if (cierreInfo) {
      cierreInfo.style.display = 'block'
      setText('d-close-date', nc.closed_date ? fmtDate(nc.closed_date) : '—')
      setText('d-close-by',   nc.verified_by || '—')
    }
    if (empty) empty.style.display = 'none'
  } else if (nc.status === 'pendiente_verificacion' && canApprove) {
    if (bar) bar.innerHTML = ''
    if (verifForm) verifForm.style.display = 'block'
    if (verifView) verifView.style.display = 'none'
    if (cierreInfo) cierreInfo.style.display = 'none'
    if (empty) empty.style.display = 'none'
  } else {
    if (bar) bar.innerHTML = ''
    if (verifForm) verifForm.style.display = 'none'
    if (verifView) verifView.style.display = 'none'
    if (cierreInfo) cierreInfo.style.display = 'none'
    if (empty) empty.style.display = 'block'
  }
}

async function saveVerification() {
  const result = document.getElementById('verif-result')?.value.trim()
  if (!result) { showToast('Describe el resultado de la verificación.', 'red'); return }
  if (!_currentNCId) return

  const today = new Date().toISOString().split('T')[0]
  const { error } = await db.from('nonconformities').update({
    status:              'cerrado',
    effectiveness_result: result,
    closed_date:         today,
    verified_by:         _profile?.full_name || _user.email,
    updated_at:          new Date().toISOString()
  }).eq('id', _currentNCId)

  if (error) { showToast('Error: ' + error.message, 'red'); return }

  showToast('NC verificada y cerrada exitosamente ✅', 'green')
  closeModal('modal-detail')
  await loadNC()
}

// ── Exportar CSV ─────────────────────────────────────────────────
function exportCSV() {
  if (_allNC.length === 0) { showToast('No hay datos para exportar.', 'red'); return }
  const rows = [['Folio','Departamento','Fuente','Descripción','Fecha','Estado','Cláusula']]
  _allNC.forEach(nc => rows.push([
    nc.folio || '',
    nc.departments?.name || '',
    sourceLabel(nc.source),
    nc.finding_description || '',
    nc.finding_date || '',
    sLabel(nc.status),
    nc.requirement_clause || ''
  ]))
  const csv  = rows.map(r => r.map(c => `"${String(c).replace(/"/g,'""')}"`).join(',')).join('\n')
  const blob = new Blob(['\ufeff' + csv], { type:'text/csv;charset=utf-8;' })
  const a    = document.createElement('a')
  a.href     = URL.createObjectURL(blob)
  a.download = `NoConformidades_${new Date().toISOString().split('T')[0]}.csv`
  a.click()
  showToast('CSV exportado.', 'green')
}

// ── Tabs ─────────────────────────────────────────────────────────
function switchTab(panelId, btn) {
  document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'))
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'))
  const panel = document.getElementById(panelId)
  if (panel) panel.classList.add('active')
  if (btn) btn.classList.add('active')
}

// ── Modal helpers ────────────────────────────────────────────────
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.modal-overlay').forEach(o => {
    o.addEventListener('click', e => { if (e.target === o) o.classList.remove('open') })
  })
})

// ── Helpers ───────────────────────────────────────────────────────
function sPill(s) {
  return { abierto:'pill-red', en_proceso:'pill-orange',
           pendiente_verificacion:'pill-blue', cerrado:'pill-green',
           cancelado:'pill-gray' }[s] || 'pill-gray'
}
function sLabel(s) {
  return { abierto:'Abierto', en_proceso:'En Proceso',
           pendiente_verificacion:'Pend. Verificación',
           cerrado:'Cerrado', cancelado:'Cancelado' }[s] || s
}
function aPill(s) {
  return { pendiente:'pill-gray', en_proceso:'pill-orange',
           completado:'pill-green', cancelado:'pill-gray' }[s] || 'pill-gray'
}
function aLabel(s) {
  return { pendiente:'Pendiente', en_proceso:'En Proceso',
           completado:'Completado', cancelado:'Cancelado' }[s] || s
}
function sourceLabel(s) {
  return { auditoria_interna:'Auditoría Interna', queja_cliente:'Queja Paciente',
           supervision:'Supervisión', revision_proceso:'Rev. Proceso', otro:'Otro' }[s] || (s || '—')
}
function daysDiff(dateStr, to) {
  const from = new Date(dateStr + 'T12:00:00')
  return Math.floor((to - from) / 86400000)
}
function daysLabel(days, status) {
  if (status === 'cerrado') return `<span class="days-badge ok">Cerrada</span>`
  const cls = days > 60 ? 'overdue' : days > 30 ? 'warn' : 'ok'
  return `<span class="days-badge ${cls}">${days}d</span>`
}
function fmtDate(d) {
  if (!d) return '—'
  return new Date(d + 'T12:00:00').toLocaleDateString('es-MX',
    { day:'2-digit', month:'short', year:'numeric' })
}
function trunc(str, len) {
  if (!str) return '—'
  return str.length > len ? str.substring(0, len) + '…' : str
}
function setText(id, val) { const el = document.getElementById(id); if (el) el.textContent = val ?? '—' }
function setVal(id, val)  { const el = document.getElementById(id); if (el) el.value = val ?? '' }
function resetBtn(btn, html) { btn.disabled = false; btn.innerHTML = html }
function esc(str) {
  if (!str) return ''
  return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;')
    .replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}
function showLoading() {
  const tbody = document.getElementById('nc-tbody')
  if (tbody) tbody.innerHTML = `<tr><td colspan="8" style="text-align:center;padding:48px;color:var(--txt3)">
    <i class="fa-solid fa-spinner fa-spin" style="font-size:1.5rem"></i></td></tr>`
}
function showError(msg) {
  const tbody = document.getElementById('nc-tbody')
  if (tbody) tbody.innerHTML = `<tr><td colspan="8" class="table-empty">
    <i class="fa-solid fa-circle-exclamation" style="color:var(--red)"></i>
    <strong>Error al cargar</strong>${esc(msg)}</td></tr>`
}
function showToast(msg, color='green') {
  const old = document.getElementById('sgc-toast')
  if (old) old.remove()
  const bg = color==='green' ? '#16a34a' : color==='red' ? '#dc2626' : '#2563eb'
  const t = document.createElement('div')
  t.id = 'sgc-toast'
  t.style.cssText = `position:fixed;bottom:28px;right:28px;z-index:9999;
    background:${bg};color:#fff;padding:13px 22px;border-radius:12px;
    font-size:.857rem;font-weight:600;font-family:var(--font);
    box-shadow:0 8px 28px rgba(0,0,0,.22);max-width:380px;line-height:1.4;`
  t.textContent = msg
  document.body.appendChild(t)
  setTimeout(() => t.remove(), 3800)
}

// ── Arrancar ──────────────────────────────────────────────────────
initNC()
