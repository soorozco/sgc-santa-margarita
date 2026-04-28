// ─── Acciones Correctivas — Cláusula 10.2 ──────────────────────

const BUCKET = 'evidencias'

let _user           = null
let _profile        = null
let _role           = null
let _allAC          = []
let _currentAC      = null
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
    if (ac.status === 'abierto')         abiertas++
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
  if (count) count.textContent =
    `${list.length} acción${list.length !== 1 ? 'es' : ''} correctiva${list.length !== 1 ? 's' : ''}`
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
    const acts    = ac.activities || []
    const done    = acts.filter(a => a.status === 'completado').length
    const pct     = acts.length ? Math.round(done / acts.length * 100) : 0
    const evCount = acts.reduce((s, a) => s + (a.evidence?.length || 0), 0)
    const hasOverdue = acts.some(a =>
      a.status !== 'completado' && a.status !== 'cancelado' &&
      a.due_date && new Date(a.due_date) < today
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
          ${evCount ? `<span class="ev-count-badge"><i class="fa-solid fa-paperclip"></i> ${evCount}</span>` : ''}
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
      number: num, detection_date: date, source: src,
      responsible: resp, nc_description: desc,
      root_cause: root || null, status: 'abierto',
      activities: [], created_by: _user.id
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

  _editActivities = JSON.parse(JSON.stringify(ac.activities || []))
  // Ensure every activity has an evidence array
  _editActivities.forEach(a => { if (!a.evidence) a.evidence = [] })

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
  const list     = document.getElementById('activities-list')
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
    const overdue  = a.due_date && new Date(a.due_date) < today
      && a.status !== 'completado' && a.status !== 'cancelado'
    const evidence = a.evidence || []

    return `
    <div class="activity-card" id="act-card-${i}">

      <!-- Header row -->
      <div class="activity-header">
        <span class="activity-num">${i + 1}</span>
        <div class="activity-main">
          <textarea rows="2" oninput="_editActivities[${i}].description=this.value"
            placeholder="Descripción de la actividad…"
            ${canWrite ? '' : 'readonly'}>${esc(a.description || '')}</textarea>
          <div class="activity-meta">
            <input type="text" value="${esc(a.responsible || '')}"
              oninput="_editActivities[${i}].responsible=this.value"
              placeholder="Responsable"
              ${canWrite ? '' : 'readonly'}>
            <input type="date" value="${a.due_date ? a.due_date.split('T')[0] : ''}"
              onchange="_editActivities[${i}].due_date=this.value"
              ${canWrite ? '' : 'readonly'}>
            ${overdue ? '<span class="overdue-badge">VENCIDA</span>' : ''}
            <select onchange="_editActivities[${i}].status=this.value" ${canWrite ? '' : 'disabled'}>
              <option value="pendiente"  ${a.status==='pendiente' ?'selected':''}>Pendiente</option>
              <option value="en_proceso" ${a.status==='en_proceso'?'selected':''}>En Proceso</option>
              <option value="completado" ${a.status==='completado'?'selected':''}>Completado</option>
              <option value="cancelado"  ${a.status==='cancelado' ?'selected':''}>Cancelado</option>
            </select>
          </div>
        </div>
        ${canWrite ? `<button class="btn-remove" onclick="removeActivity(${i})" title="Eliminar actividad">
          <i class="fa-solid fa-trash-can"></i>
        </button>` : ''}
      </div>

      <!-- Evidence section -->
      <div class="evidence-section">
        <div class="evidence-label">
          <i class="fa-solid fa-paperclip"></i>
          Evidencias
          ${evidence.length ? `<span class="evidence-count">${evidence.length}</span>` : ''}
        </div>
        <div class="evidence-list" id="ev-list-${i}">
          ${renderEvidenceItems(evidence, i, canWrite)}
        </div>
        ${canWrite ? `
        <label class="btn-attach" title="Subir PDF o imagen">
          <i class="fa-solid fa-cloud-arrow-up"></i> Adjuntar
          <input type="file" accept=".pdf,.jpg,.jpeg,.png,.webp"
            multiple onchange="uploadEvidence(${i}, this)" style="display:none">
        </label>` : ''}
      </div>

    </div>`
  }).join('')
}

// ── Evidence rendering ───────────────────────────────────────────
function renderEvidenceItems(evidence, actIdx, canWrite) {
  if (!evidence.length) return '<span class="ev-empty">Sin archivos adjuntos</span>'

  return evidence.map((ev, evIdx) => {
    const isImage = /\.(jpg|jpeg|png|webp|gif)$/i.test(ev.name)
    const icon    = isImage
      ? `<img src="${ev.url}" class="ev-thumb" onerror="this.style.display='none'">`
      : `<i class="fa-solid fa-file-pdf ev-icon-pdf"></i>`

    return `
    <div class="evidence-item" id="ev-item-${actIdx}-${evIdx}">
      <a href="${ev.url}" target="_blank" rel="noopener" class="ev-file-link" title="${esc(ev.name)}">
        ${icon}
        <span class="ev-name">${esc(ev.name)}</span>
      </a>
      ${canWrite ? `
      <button class="ev-delete" onclick="removeEvidence(${actIdx},${evIdx})"
        title="Eliminar evidencia">
        <i class="fa-solid fa-xmark"></i>
      </button>` : ''}
    </div>`
  }).join('')
}

// ── Upload evidence ──────────────────────────────────────────────
async function uploadEvidence(actIdx, input) {
  const files = Array.from(input.files)
  if (!files.length || !_currentAC) return

  const MAX_MB = 10
  for (const file of files) {
    if (file.size > MAX_MB * 1024 * 1024) {
      showToast(`"${file.name}" supera ${MAX_MB} MB.`, 'red')
      input.value = ''
      return
    }
  }

  // Show spinner on the card
  const card = document.getElementById(`act-card-${actIdx}`)
  const spinner = document.createElement('div')
  spinner.className = 'ev-uploading'
  spinner.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Subiendo…'
  card?.querySelector('.evidence-section')?.appendChild(spinner)

  const planId = _currentAC.id

  for (const file of files) {
    const safeName = file.name.replace(/[^a-zA-Z0-9._\-]/g, '_')
    const path     = `ac/${planId}/${actIdx}_${Date.now()}_${safeName}`

    const { data, error } = await db.storage
      .from(BUCKET)
      .upload(path, file, { upsert: false })

    if (error) {
      showToast(`Error al subir "${file.name}": ${error.message}`, 'red')
      continue
    }

    const { data: urlData } = db.storage.from(BUCKET).getPublicUrl(path)
    const publicUrl = urlData?.publicUrl || ''

    if (!_editActivities[actIdx].evidence) _editActivities[actIdx].evidence = []
    _editActivities[actIdx].evidence.push({
      name: file.name,
      path,
      url:  publicUrl,
      type: file.type
    })
  }

  spinner.remove()
  input.value = ''

  // Re-render only the evidence section of this card
  const evList = document.getElementById(`ev-list-${actIdx}`)
  const canWrite = ['administrador','responsable_calidad','jefe_departamento','auditor'].includes(_role)
  if (evList) {
    evList.innerHTML = renderEvidenceItems(_editActivities[actIdx].evidence || [], actIdx, canWrite)
  }
  // Update label count
  const evLabel = card?.querySelector('.evidence-label')
  const cnt = _editActivities[actIdx].evidence?.length || 0
  if (evLabel) {
    const badge = evLabel.querySelector('.evidence-count')
    if (cnt) {
      if (badge) badge.textContent = cnt
      else evLabel.insertAdjacentHTML('beforeend', `<span class="evidence-count">${cnt}</span>`)
    } else if (badge) badge.remove()
  }

  showToast(`${files.length > 1 ? files.length + ' archivos subidos' : 'Archivo subido'}. Guarda para confirmar.`, 'green')
}

// ── Remove evidence ──────────────────────────────────────────────
async function removeEvidence(actIdx, evIdx) {
  const ev = _editActivities[actIdx]?.evidence?.[evIdx]
  if (!ev) return

  if (!confirm(`¿Eliminar "${ev.name}"? Esta acción no se puede deshacer.`)) return

  // Delete from storage
  const { error } = await db.storage.from(BUCKET).remove([ev.path])
  if (error) {
    showToast('No se pudo eliminar el archivo: ' + error.message, 'red')
    return
  }

  _editActivities[actIdx].evidence.splice(evIdx, 1)

  const evList = document.getElementById(`ev-list-${actIdx}`)
  const canWrite = ['administrador','responsable_calidad','jefe_departamento','auditor'].includes(_role)
  if (evList) {
    evList.innerHTML = renderEvidenceItems(_editActivities[actIdx].evidence || [], actIdx, canWrite)
  }

  // Update count badge
  const card = document.getElementById(`act-card-${actIdx}`)
  const evLabel = card?.querySelector('.evidence-label')
  const cnt = _editActivities[actIdx].evidence?.length || 0
  if (evLabel) {
    const badge = evLabel.querySelector('.evidence-count')
    if (cnt && badge)      badge.textContent = cnt
    else if (!cnt && badge) badge.remove()
  }

  showToast('Evidencia eliminada.', 'green')
}

// ── Add / Remove activity ────────────────────────────────────────
function addActivity() {
  _editActivities.push({ description:'', responsible:'', due_date:'', status:'pendiente', evidence:[] })
  renderActivities()
  updateTabBadge()
  // Scroll to new card
  const list = document.getElementById('activities-list')
  if (list) list.lastElementChild?.scrollIntoView({ behavior:'smooth', block:'nearest' })
}

function removeActivity(idx) {
  _editActivities.splice(idx, 1)
  renderActivities()
  updateTabBadge()
}

// ── Save Activities ──────────────────────────────────────────────
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

  showToast('Actividades y evidencias guardadas.', 'green')
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
  const m = { abierto:'status-abierto', en_proceso:'status-en_proceso', cerrado:'status-cerrado' }
  return m[s] || 'status-abierto'
}
function statusLabel(s) {
  const m = { abierto:'Abierta', en_proceso:'En Proceso', cerrado:'Cerrada' }
  return m[s] || s || '—'
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
