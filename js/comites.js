// ─── Comités — COCASEP ─────────────────────────────────────────
let _user         = null
let _role         = null
let _committee    = null   // { id, code, name }
let _members      = []     // todos los integrantes activos
let _sessions     = []     // todas las sesiones
let _agreements   = []     // todos los acuerdos
let _sessionDetail = null  // sesión abierta en el modal
let _sessionAtt   = []     // asistencia de la sesión en modal
let _sessionAgr   = []     // acuerdos de la sesión en modal
let _editAgrId    = null   // id del acuerdo siendo editado
let _editMemberId = null   // id del integrante siendo editado

// ── Init ────────────────────────────────────────────────────────
async function initComites() {
  const auth = await requireAuth()
  if (!auth) return
  _user = auth.user
  _role = auth.profile?.roles?.name || 'lector'

  setText('sb-user-name', auth.profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', auth.profile?.roles?.display_name || 'Usuario')
  setCurrentDate()
  applyRoleUI()

  await loadCommittee()
  if (!_committee) {
    const { error: tblErr } = await db.from('committees').select('id').limit(1)
    if (tblErr) {
      showToast('DB Error ' + (tblErr.code || '') + ': ' + tblErr.message, 'red')
    } else {
      showToast('Tabla vacía — ejecuta sql/comites_reset.sql en Supabase.', 'red')
    }
    return
  }

  await Promise.all([loadMembers(), loadSessions(), loadAgreements()])
  renderKPIs()
  renderSessions(_sessions)
  renderAgreements(_agreements)
  renderMembers()
  populateYearFilter()
}

function setCurrentDate() {
  const el = document.getElementById('current-date')
  if (el) el.textContent = new Date().toLocaleDateString('es-MX',
    { weekday:'long', day:'numeric', month:'long', year:'numeric' })
}

function applyRoleUI() {
  const canWrite = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)
  show('btn-new-session', canWrite)
  show('btn-new-member',  canWrite)
}

// ── Cargar datos ─────────────────────────────────────────────────
async function loadCommittee() {
  const { data, error } = await db.from('committees')
    .select('*').eq('code','COCASEP').limit(1)

  if (error) {
    console.error('Error cargando comité:', error)
    showToast('Error de base de datos: ' + error.message, 'red')
    return
  }
  _committee = (data && data.length > 0) ? data[0] : null
}

async function loadMembers() {
  const { data } = await db.from('committee_members')
    .select('*').eq('committee_id', _committee.id)
    .eq('is_active', true).order('sort_order')
  _members = data || []
}

async function loadSessions() {
  const { data } = await db.from('committee_sessions')
    .select('*').eq('committee_id', _committee.id)
    .order('session_date', { ascending: false })
  _sessions = data || []
}

async function loadAgreements() {
  const { data } = await db.from('session_agreements')
    .select('*, committee_sessions(session_date, session_number, session_type)')
    .eq('committee_id', _committee.id)
    .order('created_at', { ascending: false })
  _agreements = data || []
}

// ── KPIs ─────────────────────────────────────────────────────────
function renderKPIs() {
  const year      = new Date().getFullYear()
  const thisYear  = _sessions.filter(s => s.session_year === year)
  const realized  = thisYear.filter(s => s.status === 'realizada')
  const programed = thisYear.filter(s => s.status === 'programada')
  const pending   = _agreements.filter(a => a.status === 'pendiente' || a.status === 'en_proceso')

  setText('kpi-sesiones', `${realized.length}`)
  setText('kpi-sesiones-sub', `de ${thisYear.length} programadas este año`)

  // Asistencia promedio
  if (realized.length === 0) {
    setText('kpi-asistencia', '—')
  } else {
    // Lo calculamos aproximado: necesitaríamos la attendance real
    // Mostramos — hasta que haya datos
    setText('kpi-asistencia', '—')
  }

  setText('kpi-pendientes', String(pending.length))

  // Próxima sesión
  const today   = new Date().toISOString().split('T')[0]
  const proxima = programed
    .filter(s => s.session_date >= today)
    .sort((a,b) => a.session_date.localeCompare(b.session_date))[0]

  if (proxima) {
    const diff = Math.ceil((new Date(proxima.session_date + 'T12:00:00') - new Date()) / 86400000)
    setText('kpi-proxima', diff <= 0 ? 'Hoy' : `${diff}d`)
    setText('kpi-proxima-fecha', fmtDate(proxima.session_date))
  } else {
    setText('kpi-proxima', '—')
    setText('kpi-proxima-fecha', 'Sin sesión programada')
  }
}

// ── Tabs principales ──────────────────────────────────────────────
function showTab(tab) {
  document.querySelectorAll('.tab-btn').forEach((b,i) => {
    const tabs = ['sesiones','acuerdos','integrantes']
    b.classList.toggle('active', tabs[i] === tab)
  })
  document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'))
  const panel = document.getElementById(`panel-${tab}`)
  if (panel) panel.classList.add('active')
}

function populateYearFilter() {
  const years = [...new Set(_sessions.map(s => s.session_year))].sort((a,b) => b-a)
  const sel   = document.getElementById('f-session-year')
  if (!sel) return
  const cur   = new Date().getFullYear()
  years.forEach(y => {
    const o = document.createElement('option')
    o.value = y; o.textContent = y
    if (y === cur) o.selected = true
    sel.appendChild(o)
  })
  applySessionFilters()
}

// ── SESIONES — Tabla ─────────────────────────────────────────────
function applySessionFilters() {
  const year   = document.getElementById('f-session-year')?.value
  const type   = document.getElementById('f-session-type')?.value
  const status = document.getElementById('f-session-status')?.value
  const list   = _sessions.filter(s =>
    (!year   || String(s.session_year) === year) &&
    (!type   || s.session_type === type) &&
    (!status || s.status === status)
  )
  renderSessions(list)
}

function renderSessions(list) {
  const tbody = document.getElementById('sessions-tbody')
  const count = document.getElementById('sessions-count')
  if (count) count.textContent = `${list.length} sesión${list.length !== 1 ? 'es' : ''}`
  if (!tbody) return

  if (list.length === 0) {
    tbody.innerHTML = `<tr><td colspan="9" class="table-empty">
      <i class="fa-solid fa-calendar-xmark"></i>
      <strong>Sin sesiones</strong>No hay sesiones que coincidan con los filtros.
    </td></tr>`
    return
  }

  tbody.innerHTML = list.map(s => `
    <tr>
      <td class="center"><strong>${s.session_year}-${String(s.session_number).padStart(2,'0')}</strong></td>
      <td><span class="pill pill-${s.session_type}">${s.session_type === 'ordinaria' ? 'Ordinaria' : 'Extraordinaria'}</span></td>
      <td>${fmtDate(s.session_date)}</td>
      <td>${s.session_time ? s.session_time.slice(0,5) + ' h' : '—'}</td>
      <td>${esc(s.location || '—')}</td>
      <td class="center"><span class="pill pill-${s.status}">${sLabelSession(s.status)}</span></td>
      <td class="center" id="att-cell-${s.id}">—</td>
      <td class="center" id="agr-cell-${s.id}">—</td>
      <td class="center">
        <div class="action-btns">
          <button onclick="openSessionDetail('${s.id}')" class="btn-action" title="Ver detalle">
            <i class="fa-solid fa-eye"></i>
          </button>
        </div>
      </td>
    </tr>
  `).join('')

  // Calcular y mostrar asistencia / acuerdos por sesión
  updateSessionCells(list)
}

async function updateSessionCells(list) {
  // Acuerdos por sesión
  _agreements.forEach(a => {
    const cell = document.getElementById(`agr-cell-${a.session_id}`)
    if (!cell) return
    const n = parseInt(cell.textContent) || 0
    cell.textContent = String(n + 1)
  })

  // Asistencia — solo para sesiones realizadas
  const doneIds = list.filter(s => s.status === 'realizada').map(s => s.id)
  if (doneIds.length === 0) return

  const { data } = await db.from('session_attendance')
    .select('session_id, attended')
    .in('session_id', doneIds)

  if (!data) return
  const bySession = {}
  data.forEach(r => {
    if (!bySession[r.session_id]) bySession[r.session_id] = { total:0, present:0 }
    bySession[r.session_id].total++
    if (r.attended) bySession[r.session_id].present++
  })

  Object.entries(bySession).forEach(([sid, d]) => {
    const cell = document.getElementById(`att-cell-${sid}`)
    if (cell) cell.textContent = `${d.present}/${d.total}`
  })

  // Actualizar KPI asistencia promedio
  const totals = Object.values(bySession)
  if (totals.length > 0) {
    const avg = totals.reduce((s, d) => s + (d.present / d.total * 100), 0) / totals.length
    setText('kpi-asistencia', `${Math.round(avg)}%`)
  }
}

// ── SESIONES — Nueva ─────────────────────────────────────────────
function openNewSession() {
  const year   = new Date().getFullYear()
  const nextNum = (_sessions.filter(s => s.session_year === year).length) + 1
  setVal('ns-number', nextNum)
  setVal('ns-date',   '')
  setVal('ns-time',   '')
  setVal('ns-location', '')
  setVal('ns-agenda', '')
  openModal('modal-new-session')
}

async function submitNewSession() {
  const btn  = document.getElementById('btn-save-session')
  const date = document.getElementById('ns-date')?.value
  if (!date) { showToast('La fecha es obligatoria.', 'red'); return }

  const year = new Date(date + 'T12:00:00').getFullYear()
  const num  = parseInt(document.getElementById('ns-number')?.value) ||
               (_sessions.filter(s => s.session_year === year).length + 1)

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const { data: ses, error } = await db.from('committee_sessions').insert({
    committee_id:   _committee.id,
    session_year:   year,
    session_number: num,
    session_date:   date,
    session_time:   document.getElementById('ns-time')?.value || null,
    session_type:   document.getElementById('ns-type')?.value,
    status:         'programada',
    location:       document.getElementById('ns-location')?.value.trim() || null,
    agenda:         document.getElementById('ns-agenda')?.value.trim()   || null,
    created_by:     _user.id
  }).select().single()

  if (error) {
    showToast('Error: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-calendar-plus"></i> Programar Sesión')
    return
  }

  // Crear registros de asistencia vacíos para todos los integrantes
  if (_members.length > 0) {
    await db.from('session_attendance').insert(
      _members.map(m => ({ session_id: ses.id, member_id: m.id, attended: false }))
    )
  }

  showToast('Sesión programada correctamente.', 'green')
  closeModal('modal-new-session')
  resetBtn(btn, '<i class="fa-solid fa-calendar-plus"></i> Programar Sesión')
  await loadSessions()
  renderSessions(_sessions)
  renderKPIs()
  populateYearFilter()
}

// ── SESIONES — Detalle ────────────────────────────────────────────
async function openSessionDetail(sessionId) {
  _sessionDetail = _sessions.find(s => s.id === sessionId)
  if (!_sessionDetail) return

  // Header
  setText('sd-title', `Sesión ${_sessionDetail.session_year}-${String(_sessionDetail.session_number).padStart(2,'0')}`)
  setText('sd-type',  _sessionDetail.session_type === 'ordinaria' ? 'Sesión Ordinaria' : 'Sesión Extraordinaria')
  setText('sd-location-txt', _sessionDetail.location || 'Lugar no especificado')

  const pill = document.getElementById('sd-status-pill')
  if (pill) pill.innerHTML = `<span class="pill pill-${_sessionDetail.status}">${sLabelSession(_sessionDetail.status)}</span>`

  const agWrap = document.getElementById('sd-agenda-wrap')
  const agTxt  = document.getElementById('sd-agenda-txt')
  if (_sessionDetail.agenda) {
    if (agWrap) agWrap.style.display = 'block'
    if (agTxt)  agTxt.textContent = _sessionDetail.agenda
  } else {
    if (agWrap) agWrap.style.display = 'none'
  }

  setText('sd-subtitle', fmtDate(_sessionDetail.session_date) +
    (_sessionDetail.session_time ? ' · ' + _sessionDetail.session_time.slice(0,5) + ' h' : ''))

  // Footer buttons
  const isProgramada = _sessionDetail.status === 'programada'
  show('btn-mark-done',    isProgramada)
  show('btn-cancel-session', isProgramada)

  // Load attendance + agreements
  await Promise.all([loadSessionAttendance(sessionId), loadSessionAgreements(sessionId)])

  showInnerTab('asistencia')
  openModal('modal-session')
}

async function loadSessionAttendance(sessionId) {
  const { data } = await db.from('session_attendance')
    .select('*, committee_members(id, full_name, role, position_title)')
    .eq('session_id', sessionId)
    .order('committee_members(sort_order)')

  _sessionAtt = data || []

  // Si no hay registros (sesión sin asistencia inicializada), crear para todos los miembros
  if (_sessionAtt.length === 0 && _members.length > 0) {
    await db.from('session_attendance').insert(
      _members.map(m => ({ session_id: sessionId, member_id: m.id, attended: false }))
    )
    const { data: d2 } = await db.from('session_attendance')
      .select('*, committee_members(id, full_name, role, position_title)')
      .eq('session_id', sessionId)
    _sessionAtt = d2 || []
  }

  renderAttendance()
}

async function loadSessionAgreements(sessionId) {
  const { data } = await db.from('session_agreements')
    .select('*').eq('session_id', sessionId).order('created_at')
  _sessionAgr = data || []
  renderSessionAgreements()
}

function renderAttendance() {
  const list    = document.getElementById('attendance-list')
  const summary = document.getElementById('att-summary')
  if (!list) return

  const canWrite  = _sessionDetail?.status === 'programada' ||
                    ['administrador','responsable_calidad'].includes(_role)
  const present   = _sessionAtt.filter(a => a.attended).length
  const total     = _sessionAtt.length
  const quorumOk  = present > total / 2

  list.innerHTML = _sessionAtt.map(a => `
    <div class="att-item ${a.attended ? 'attended' : ''}" id="att-item-${a.id}">
      <input type="checkbox" id="chk-${a.id}" ${a.attended ? 'checked' : ''}
             ${canWrite ? '' : 'disabled'}
             onchange="toggleAttendance('${a.id}', this.checked)">
      <label for="chk-${a.id}" class="att-name">${esc(a.committee_members?.full_name || '—')}</label>
      <span class="att-role"><span class="role-badge role-${a.committee_members?.role}">${rolLabel(a.committee_members?.role)}</span></span>
    </div>
  `).join('')

  if (summary) {
    const cls = quorumOk ? 'quorum-ok' : 'quorum-low'
    summary.innerHTML = `Asistencia: <strong class="${cls}">${present} de ${total}</strong> integrantes
      ${total > 0 ? `(${Math.round(present/total*100)}%)` : ''}
      — Quorum ${quorumOk ? '✓ alcanzado' : '✗ no alcanzado (mínimo ' + (Math.floor(total/2)+1) + ')'}`
  }

  const saveWrap = document.getElementById('save-att-wrap')
  if (saveWrap) saveWrap.style.display = canWrite ? 'block' : 'none'
}

function toggleAttendance(attId, checked) {
  const att = _sessionAtt.find(a => a.id === attId)
  if (att) att.attended = checked
  const item = document.getElementById(`att-item-${attId}`)
  if (item) item.classList.toggle('attended', checked)
  renderAttendanceSummary()
}

function renderAttendanceSummary() {
  const summary  = document.getElementById('att-summary')
  const present  = _sessionAtt.filter(a => a.attended).length
  const total    = _sessionAtt.length
  const quorumOk = present > total / 2
  if (summary) {
    const cls = quorumOk ? 'quorum-ok' : 'quorum-low'
    summary.innerHTML = `Asistencia: <strong class="${cls}">${present} de ${total}</strong> integrantes
      ${total > 0 ? `(${Math.round(present/total*100)}%)` : ''}
      — Quorum ${quorumOk ? '✓ alcanzado' : '✗ no alcanzado'}`
  }
}

async function saveAttendance() {
  const updates = _sessionAtt.map(a =>
    db.from('session_attendance').update({ attended: a.attended }).eq('id', a.id)
  )
  await Promise.all(updates)
  showToast('Asistencia guardada.', 'green')
  await updateSessionCells(_sessions)
}

function showInnerTab(tab) {
  document.querySelectorAll('.inner-tab-btn').forEach((b, i) => {
    b.classList.toggle('active', ['asistencia','acuerdos'][i] === tab)
  })
  document.querySelectorAll('.inner-panel').forEach(p => p.classList.remove('active'))
  const panel = document.getElementById(`inner-${tab}`)
  if (panel) panel.classList.add('active')
}

// ── Acuerdos (dentro del modal de sesión) ────────────────────────
function renderSessionAgreements() {
  const list = document.getElementById('session-agr-list')
  if (!list) return

  if (_sessionAgr.length === 0) {
    list.innerHTML = `<div style="text-align:center;padding:24px;color:var(--txt3);font-size:.857rem">
      <i class="fa-solid fa-handshake" style="display:block;font-size:1.8rem;margin-bottom:8px;opacity:.3"></i>
      Sin acuerdos registrados para esta sesión
    </div>`
    return
  }

  list.innerHTML = _sessionAgr.map(a => `
    <div class="agr-item">
      <div class="agr-desc">${esc(a.description)}</div>
      <div class="agr-meta">
        ${a.responsible ? `<span><i class="fa-solid fa-user" style="margin-right:4px"></i>${esc(a.responsible)}</span>` : ''}
        ${a.due_date    ? `<span><i class="fa-regular fa-calendar" style="margin-right:4px"></i>${fmtDate(a.due_date)}</span>` : ''}
        <span class="pill pill-${a.status}">${sLabelAgr(a.status)}</span>
        ${['administrador','responsable_calidad','jefe_departamento'].includes(_role) ? `
          <button class="btn-action" style="width:24px;height:24px" onclick="openEditAgreement('${a.id}')" title="Editar">
            <i class="fa-solid fa-pencil" style="font-size:10px"></i>
          </button>` : ''}
      </div>
    </div>
  `).join('')
}

function showAgrForm() {
  const f = document.getElementById('new-agr-form')
  const b = document.getElementById('add-agr-btn-wrap')
  if (f) f.style.display = 'block'
  if (b) b.style.display = 'none'
  setVal('agr-desc', '')
  setVal('agr-responsible', '')
  setVal('agr-due', '')
}

function hideAgrForm() {
  const f = document.getElementById('new-agr-form')
  const b = document.getElementById('add-agr-btn-wrap')
  if (f) f.style.display = 'none'
  if (b) b.style.display = 'block'
}

async function submitAgreement() {
  const desc = document.getElementById('agr-desc')?.value.trim()
  if (!desc) { showToast('La descripción del acuerdo es obligatoria.', 'red'); return }

  const { data, error } = await db.from('session_agreements').insert({
    session_id:   _sessionDetail.id,
    committee_id: _committee.id,
    description:  desc,
    responsible:  document.getElementById('agr-responsible')?.value.trim() || null,
    due_date:     document.getElementById('agr-due')?.value || null,
    status:       'pendiente'
  }).select().single()

  if (error) { showToast('Error: ' + error.message, 'red'); return }

  _sessionAgr.push(data)
  _agreements.unshift({ ...data, committee_sessions: {
    session_date: _sessionDetail.session_date,
    session_number: _sessionDetail.session_number,
    session_type: _sessionDetail.session_type
  }})
  renderSessionAgreements()
  renderAgreements(_agreements)
  hideAgrForm()
  showToast('Acuerdo agregado.', 'green')
  renderKPIs()
}

async function markSessionDone() {
  if (!_sessionDetail) return

  const present  = _sessionAtt.filter(a => a.attended).length
  const total    = _sessionAtt.length
  const quorumOk = present > total / 2

  if (!quorumOk && total > 0) {
    const ok = confirm(
      `⚠️ El quórum no está completo (${present}/${total} integrantes).\n` +
      `El reglamento requiere la mitad más uno (${Math.floor(total/2)+1}).\n\n` +
      `¿Deseas marcar la sesión como realizada de todas formas?`
    )
    if (!ok) return
  }

  // Guardar asistencia primero
  await saveAttendance()

  const { error } = await db.from('committee_sessions')
    .update({ status: 'realizada' }).eq('id', _sessionDetail.id)

  if (error) { showToast('Error: ' + error.message, 'red'); return }

  _sessionDetail.status = 'realizada'
  const ses = _sessions.find(s => s.id === _sessionDetail.id)
  if (ses) ses.status = 'realizada'

  showToast('Sesión marcada como realizada.', 'green')
  closeModal('modal-session')
  renderSessions(_sessions)
  renderKPIs()
}

async function doCancelSession() {
  if (!_sessionDetail) return
  if (!confirm('¿Cancelar esta sesión? Esta acción no se puede deshacer fácilmente.')) return

  const { error } = await db.from('committee_sessions')
    .update({ status: 'cancelada' }).eq('id', _sessionDetail.id)

  if (error) { showToast('Error: ' + error.message, 'red'); return }

  const ses = _sessions.find(s => s.id === _sessionDetail.id)
  if (ses) ses.status = 'cancelada'
  showToast('Sesión cancelada.', 'green')
  closeModal('modal-session')
  renderSessions(_sessions)
  renderKPIs()
}

// ── ACUERDOS — Tabla principal ────────────────────────────────────
function applyAgreementFilters() {
  const q      = (document.getElementById('search-agr')?.value || '').toLowerCase()
  const status = document.getElementById('f-agr-status')?.value || ''
  const list   = _agreements.filter(a => {
    const txt = `${a.description} ${a.responsible || ''}`.toLowerCase()
    return (!q || txt.includes(q)) && (!status || a.status === status)
  })
  renderAgreements(list)
}

function renderAgreements(list) {
  const tbody = document.getElementById('agreements-tbody')
  const count = document.getElementById('agreements-count')
  if (count) count.textContent = `${list.length} acuerdo${list.length !== 1 ? 's' : ''}`
  if (!tbody) return

  if (list.length === 0) {
    tbody.innerHTML = `<tr><td colspan="6" class="table-empty">
      <i class="fa-solid fa-handshake"></i>
      <strong>Sin acuerdos</strong>Registra acuerdos desde el detalle de cada sesión.
    </td></tr>`
    return
  }

  const canWrite = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)

  tbody.innerHTML = list.map(a => {
    const ses = a.committee_sessions
    const sesLabel = ses
      ? `${new Date(ses.session_date + 'T12:00:00').getFullYear()}-${String(ses.session_number).padStart(2,'0')}`
      : '—'
    const overdue = a.due_date && a.due_date < new Date().toISOString().split('T')[0]
      && a.status !== 'cumplido' && a.status !== 'cancelado'

    return `<tr>
      <td><span style="font-size:.714rem;font-weight:600;color:var(--txt3)">${sesLabel}</span></td>
      <td style="max-width:280px"><span style="font-size:.857rem">${esc(a.description)}</span></td>
      <td>${esc(a.responsible || '—')}</td>
      <td class="center" style="${overdue ? 'color:var(--red);font-weight:600' : ''}">
        ${a.due_date ? fmtDate(a.due_date) : '—'}
        ${overdue ? ' <i class="fa-solid fa-circle-exclamation" style="font-size:.714rem"></i>' : ''}
      </td>
      <td class="center"><span class="pill pill-${a.status}">${sLabelAgr(a.status)}</span></td>
      <td class="center">
        <div class="action-btns">
          ${canWrite ? `<button onclick="openEditAgreement('${a.id}')" class="btn-action" title="Editar">
            <i class="fa-solid fa-pencil"></i></button>` : ''}
        </div>
      </td>
    </tr>`
  }).join('')
}

// ── Editar acuerdo ────────────────────────────────────────────────
function openEditAgreement(agrId) {
  const a = _agreements.find(x => x.id === agrId) ||
            _sessionAgr.find(x => x.id === agrId)
  if (!a) return
  _editAgrId = agrId

  const ses = a.committee_sessions
  const sesLabel = ses
    ? `Sesión ${new Date(ses.session_date + 'T12:00:00').getFullYear()}-${String(ses.session_number).padStart(2,'0')}`
    : ''
  setText('ea-session-label', sesLabel)
  setVal('ea-desc',        a.description)
  setVal('ea-responsible', a.responsible || '')
  setVal('ea-due',         a.due_date    || '')
  setVal('ea-status',      a.status)
  setVal('ea-notes',       a.follow_up_notes || '')
  openModal('modal-edit-agr')
}

async function submitEditAgreement() {
  const btn  = document.getElementById('btn-save-agr')
  const desc = document.getElementById('ea-desc')?.value.trim()
  if (!desc) { showToast('La descripción es obligatoria.', 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const payload = {
    description:     desc,
    responsible:     document.getElementById('ea-responsible')?.value.trim() || null,
    due_date:        document.getElementById('ea-due')?.value || null,
    status:          document.getElementById('ea-status')?.value,
    follow_up_notes: document.getElementById('ea-notes')?.value.trim() || null
  }

  const { error } = await db.from('session_agreements')
    .update(payload).eq('id', _editAgrId)

  if (error) {
    showToast('Error: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar')
    return
  }

  // Update local arrays
  const updateArr = (arr) => {
    const idx = arr.findIndex(x => x.id === _editAgrId)
    if (idx >= 0) arr[idx] = { ...arr[idx], ...payload }
  }
  updateArr(_agreements)
  updateArr(_sessionAgr)

  showToast('Acuerdo actualizado.', 'green')
  closeModal('modal-edit-agr')
  resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar')
  renderAgreements(_agreements)
  renderSessionAgreements()
  renderKPIs()
}

// ── INTEGRANTES ───────────────────────────────────────────────────
function renderMembers() {
  const grid = document.getElementById('members-grid')
  if (!grid) return

  if (_members.length === 0) {
    grid.innerHTML = `<div style="grid-column:1/-1;text-align:center;padding:48px;color:var(--txt3)">
      Sin integrantes registrados.
    </div>`
    return
  }

  const canWrite = ['administrador','responsable_calidad'].includes(_role)
  const initial  = name => (name || '?').split(' ').slice(0,2).map(w => w[0]).join('').toUpperCase()

  grid.innerHTML = _members.map(m => {
    const cls = m.role === 'presidenta' ? 'pres' : m.role === 'secretaria' ? 'sec' : 'voc'
    return `
      <div class="member-card ${cls}">
        <div class="member-avatar">${initial(m.full_name)}</div>
        <div class="member-info">
          <div class="member-name">${esc(m.full_name)}</div>
          <div class="member-position">${esc(m.position_title || m.role)}</div>
          <div class="member-dept">
            <span class="role-badge role-${m.role}">${rolLabel(m.role)}</span>
            ${m.department ? `· ${esc(m.department)}` : ''}
          </div>
        </div>
        ${canWrite ? `
        <button class="btn-action" style="align-self:flex-start;flex-shrink:0"
                onclick="openEditMember('${m.id}')" title="Editar">
          <i class="fa-solid fa-pencil" style="font-size:10px"></i>
        </button>` : ''}
      </div>`
  }).join('')
}

function openNewMember() {
  _editMemberId = null
  setText('member-modal-title', 'Agregar Integrante')
  setVal('mb-name',     '')
  setVal('mb-role',     'vocal')
  setVal('mb-dept',     '')
  setVal('mb-position', '')
  openModal('modal-member')
}

function openEditMember(memberId) {
  const m = _members.find(x => x.id === memberId)
  if (!m) return
  _editMemberId = memberId
  setText('member-modal-title', 'Editar Integrante')
  setVal('mb-name',     m.full_name)
  setVal('mb-role',     m.role)
  setVal('mb-dept',     m.department || '')
  setVal('mb-position', m.position_title || '')
  openModal('modal-member')
}

async function submitMember() {
  const btn  = document.getElementById('btn-save-member')
  const name = document.getElementById('mb-name')?.value.trim()
  if (!name) { showToast('El nombre es obligatorio.', 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const payload = {
    full_name:     name,
    role:          document.getElementById('mb-role')?.value,
    department:    document.getElementById('mb-dept')?.value.trim() || null,
    position_title:document.getElementById('mb-position')?.value.trim() || null
  }

  let error
  if (_editMemberId) {
    ;({ error } = await db.from('committee_members').update(payload).eq('id', _editMemberId))
  } else {
    ;({ error } = await db.from('committee_members').insert({
      ...payload, committee_id: _committee.id, is_active: true
    }))
  }

  if (error) {
    showToast('Error: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar')
    return
  }

  showToast(_editMemberId ? 'Integrante actualizado.' : 'Integrante agregado.', 'green')
  closeModal('modal-member')
  resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar')
  await loadMembers()
  renderMembers()
}

// ── Modal helpers ─────────────────────────────────────────────────
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.modal-overlay').forEach(o => {
    o.addEventListener('click', e => { if (e.target === o) o.classList.remove('open') })
  })
})

// ── Helpers ───────────────────────────────────────────────────────
function sLabelSession(s) {
  return { programada:'Programada', realizada:'Realizada', cancelada:'Cancelada' }[s] || s
}
function sLabelAgr(s) {
  return { pendiente:'Pendiente', en_proceso:'En Proceso', cumplido:'Cumplido', cancelado:'Cancelado' }[s] || s
}
function rolLabel(r) {
  return { presidenta:'Presidenta', secretaria:'Secretaria', vocal:'Vocal', invitado:'Invitado' }[r] || r
}
function fmtDate(d) {
  if (!d) return '—'
  return new Date(d + 'T12:00:00').toLocaleDateString('es-MX',
    { day:'2-digit', month:'short', year:'numeric' })
}
function esc(str) {
  if (!str) return ''
  return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;')
    .replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}
function setText(id, val) { const el=document.getElementById(id); if(el) el.textContent = val ?? '—' }
function setVal(id, val)  { const el=document.getElementById(id); if(el) el.value = val ?? '' }
function show(id, visible) { const el=document.getElementById(id); if(el) el.style.display = visible ? 'inline-flex' : 'none' }
function resetBtn(btn, html) { btn.disabled=false; btn.innerHTML=html }

function showToast(msg, color='green') {
  const old = document.getElementById('sgc-toast')
  if (old) old.remove()
  const bg = color==='green'?'#16a34a':color==='red'?'#dc2626':'#2563eb'
  const t  = document.createElement('div')
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
initComites()
