// ─── Revisión por la Dirección — Cláusula 9.3 ─────────────────

// ── State ─────────────────────────────────────────────────────
let _reviews      = []   // all loaded reviews
let _filtered     = []   // after filters
let _page         = 1
const PAGE_SIZE   = 15
let _currentRev   = null // full review object being edited

let _editAttendees = []  // [{name, position, attended}]
let _editInputs    = []  // [{key, label, rating, notes}]
let _editOutputs   = []  // [{id, type, description, responsible, due_date, status}]

let _user    = null
let _profile = null
let _role    = null

// ── ISO 9.3.2 standard input categories ───────────────────────
const ISO_INPUTS = [
  { key:'prev_actions',    label:'Estado de acciones de revisiones anteriores' },
  { key:'context_changes', label:'Cambios en cuestiones externas e internas pertinentes al SGC' },
  { key:'sat_cliente',     label:'Satisfacción del cliente y retroalimentación de partes interesadas' },
  { key:'obj_calidad',     label:'Grado en que se han logrado los objetivos de calidad' },
  { key:'proc_products',   label:'Desempeño de los procesos y conformidad de productos y servicios' },
  { key:'nc_correctivas',  label:'No conformidades y acciones correctivas' },
  { key:'seguimiento',     label:'Resultados de seguimiento y medición' },
  { key:'auditorias',      label:'Resultados de las auditorías internas' },
  { key:'proveedores',     label:'Desempeño de los proveedores externos' },
  { key:'recursos',        label:'Adecuación de los recursos' },
  { key:'riesgos',         label:'Eficacia de las acciones tomadas para riesgos y oportunidades' },
]

// ── Init ──────────────────────────────────────────────────────
async function initRD() {
  try {
    const auth = await requireAuth()
    if (!auth) return
    _user    = auth.user
    _profile = auth.profile
    _role    = auth.profile?.roles?.name || 'lector'

    setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
    setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')

    const dateEl = document.getElementById('current-date')
    if (dateEl) dateEl.textContent = new Date().toLocaleDateString('es-MX',
      { weekday:'long', day:'numeric', month:'long', year:'numeric' })

    // Show "Nueva Revisión" only to admins / responsable_calidad
    const canWrite = ['administrador','responsable_calidad'].includes(_role)
    const btn = document.getElementById('btn-new-rd')
    if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'

    await loadReviews()
  } catch (err) {
    console.error('[RD] initRD error:', err)
  }
}

// ── Load reviews from Supabase ─────────────────────────────────
async function loadReviews() {
  showTableLoading()
  const { data, error } = await db
    .from('management_reviews')
    .select('*')
    .order('review_date', { ascending: false })
    .limit(500)

  if (error) { showTableError(error.message); return }
  _reviews = data || []
  buildYearFilter()
  applyFilters()
  renderKPIs()
}

// ── Year filter builder ───────────────────────────────────────
function buildYearFilter() {
  const years = [...new Set(
    _reviews.map(r => (r.review_date || '').substring(0, 4)).filter(Boolean)
  )].sort().reverse()
  const sel = document.getElementById('f-year')
  if (!sel) return
  const cur = sel.value
  sel.innerHTML = '<option value="">Todos los años</option>' +
    years.map(y => `<option value="${y}"${y===cur?' selected':''}>${y}</option>`).join('')
}

// ── Filters ───────────────────────────────────────────────────
function applyFilters() {
  const q      = (document.getElementById('search-input')?.value || '').toLowerCase().trim()
  const status = document.getElementById('f-status')?.value || ''
  const year   = document.getElementById('f-year')?.value   || ''

  _filtered = _reviews.filter(r => {
    if (status && r.status !== status) return false
    if (year   && !(r.review_date || '').startsWith(year)) return false
    if (q) {
      const txt = [r.review_number, r.period, r.location].filter(Boolean).join(' ').toLowerCase()
      if (!txt.includes(q)) return false
    }
    return true
  })

  _page = 1
  renderTable()

  const cnt = document.getElementById('rd-count')
  if (cnt) cnt.textContent = _filtered.length + ' revisión' + (_filtered.length !== 1 ? 'es' : '') + ' encontrada' + (_filtered.length !== 1 ? 's' : '')
}

// ── KPIs ──────────────────────────────────────────────────────
function renderKPIs() {
  const thisYear = String(new Date().getFullYear())

  // Total
  setText('kpi-total', _reviews.length)
  setText('kpi-total-sub', 'registradas')

  // Completadas este año
  const completadasYear = _reviews.filter(r =>
    r.status === 'COMPLETADA' && (r.review_date || '').startsWith(thisYear)
  ).length
  setText('kpi-completadas', completadasYear)
  setText('kpi-year', thisYear)

  // En proceso
  const enProceso = _reviews.filter(r => r.status === 'EN_PROCESO').length
  setText('kpi-en-proceso', enProceso)

  // Acciones pendientes across all reviews
  let pending = 0
  _reviews.forEach(r => {
    const outputs = Array.isArray(r.outputs) ? r.outputs : []
    outputs.forEach(o => { if (o.status === 'PENDIENTE') pending++ })
  })
  setText('kpi-pendientes', pending)
}

// ── Table ─────────────────────────────────────────────────────
function renderTable() {
  const tbody = document.getElementById('rd-tbody')
  const start = (_page - 1) * PAGE_SIZE
  const page  = _filtered.slice(start, start + PAGE_SIZE)

  if (_filtered.length === 0) {
    tbody.innerHTML = `<tr><td colspan="8" class="table-empty">
      <i class="fa-solid fa-folder-open"></i>
      <strong>Sin revisiones</strong>Sin resultados para los filtros seleccionados.</td></tr>`
    renderPagination()
    return
  }

  tbody.innerHTML = page.map(r => {
    const attendees = Array.isArray(r.attendees) ? r.attendees : []
    const inputs    = Array.isArray(r.inputs)    ? r.inputs    : []
    const outputs   = Array.isArray(r.outputs)   ? r.outputs   : []
    const rated     = inputs.filter(i => i.rating).length
    const pendOut   = outputs.filter(o => o.status === 'PENDIENTE').length

    return `
    <tr style="cursor:pointer" onclick="openDetail('${r.id}')">
      <td>
        <div class="rd-number">${esc(r.review_number || '—')}</div>
      </td>
      <td>
        <div class="rd-period">${esc(r.period || '—')}</div>
      </td>
      <td class="center" style="white-space:nowrap">${fmtDate(r.review_date)}</td>
      <td class="center">
        <span class="mini-count">${attendees.length}</span>
      </td>
      <td class="center">${statusBadge(r.status)}</td>
      <td class="center">
        <span class="mini-count">
          <span class="rated">${rated}</span> / ${ISO_INPUTS.length}
        </span>
      </td>
      <td class="center">
        <span class="mini-count">
          ${outputs.length}
          ${pendOut > 0 ? `<span class="pending">(${pendOut} pend.)</span>` : ''}
        </span>
      </td>
      <td class="center">
        <button class="btn-action" onclick="event.stopPropagation();openDetail('${r.id}')" title="Ver / editar">
          <i class="fa-solid fa-eye"></i>
        </button>
      </td>
    </tr>`
  }).join('')

  renderPagination()
}

// ── Open new review modal ─────────────────────────────────────
function openNewReview() {
  // Auto-suggest review number: RD-YYYY-NNN
  const year      = new Date().getFullYear()
  const countYear = _reviews.filter(r => (r.review_date || '').startsWith(String(year))).length
  const num       = String(countYear + 1).padStart(3, '0')

  document.getElementById('new-number').value    = `RD-${year}-${num}`
  document.getElementById('new-period').value    = ''
  document.getElementById('new-date').value      = ''
  document.getElementById('new-next-date').value = ''
  document.getElementById('new-location').value  = 'Sala de Juntas'

  openModal('modal-new')
}

// ── Submit new review ─────────────────────────────────────────
async function submitNewReview() {
  const number   = document.getElementById('new-number').value.trim()
  const period   = document.getElementById('new-period').value.trim()
  const date     = document.getElementById('new-date').value
  const nextDate = document.getElementById('new-next-date').value || null
  const location = document.getElementById('new-location').value.trim()

  if (!number)   { showToast('El número de revisión es obligatorio.', 'red'); return }
  if (!period)   { showToast('El período es obligatorio.', 'red'); return }
  if (!date)     { showToast('La fecha de revisión es obligatoria.', 'red'); return }
  if (!location) { showToast('El lugar es obligatorio.', 'red'); return }

  const btn = document.getElementById('btn-save-new')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const { data, error } = await db.rpc('create_management_review', {
    p_review_number:   number,
    p_period:          period,
    p_review_date:     date,
    p_next_review_date: nextDate,
    p_location:        location,
    p_created_by:      _user.id
  })

  if (error) {
    showToast('Error: ' + error.message, 'red')
    btn.disabled = false
    btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Programar Revisión'
    return
  }

  showToast('Revisión programada correctamente.', 'green')
  closeModal('modal-new')
  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Programar Revisión'
  await loadReviews()
}

// ── Open detail modal ─────────────────────────────────────────
async function openDetail(id) {
  const rev = _reviews.find(r => r.id === id)
  if (!rev) return

  _currentRev = rev

  // Initialize edit state
  _editAttendees = JSON.parse(JSON.stringify(Array.isArray(rev.attendees) ? rev.attendees : []))
  _editOutputs   = JSON.parse(JSON.stringify(Array.isArray(rev.outputs)   ? rev.outputs   : []))

  // Inputs: merge ISO template with stored data, ensuring all 11 categories exist
  const storedInputs = Array.isArray(rev.inputs) ? rev.inputs : []
  _editInputs = ISO_INPUTS.map(iso => {
    const stored = storedInputs.find(s => s.key === iso.key)
    return {
      key:    iso.key,
      label:  iso.label,
      rating: stored?.rating || null,
      notes:  stored?.notes  || ''
    }
  })

  // Header
  setText('detail-number', rev.review_number || '—')
  setText('detail-period', rev.period || '—')

  // General tab
  setText('d-number',      rev.review_number || '—')
  setText('d-period',      rev.period        || '—')
  setText('d-review-date', fmtDate(rev.review_date))
  setText('d-created-by',  rev.created_by    || '—')

  const statusSel = document.getElementById('d-status-sel')
  if (statusSel) statusSel.value = rev.status || 'PLANIFICADA'

  const locEl = document.getElementById('d-location')
  if (locEl) locEl.value = rev.location || ''

  const nextEl = document.getElementById('d-next-date')
  if (nextEl) nextEl.value = rev.next_review_date || ''

  const concEl = document.getElementById('d-conclusions')
  if (concEl) concEl.value = rev.general_conclusions || ''

  // Render dynamic tabs
  renderAttendeesTab()
  renderInputsTab()
  renderOutputsTab()

  // Reset to first tab
  document.querySelectorAll('#modal-detail .tab-btn').forEach((b, i) => b.classList.toggle('active', i === 0))
  document.querySelectorAll('#modal-detail .tab-panel').forEach((p, i) => p.classList.toggle('active', i === 0))

  openModal('modal-detail')
}

// ── _collectCurrentState: read all tab forms into edit state ───
function _collectGeneralValues() {
  return {
    status:       document.getElementById('d-status-sel')?.value  || _currentRev.status,
    location:     document.getElementById('d-location')?.value    || _currentRev.location,
    next_date:    document.getElementById('d-next-date')?.value   || _currentRev.next_review_date,
    conclusions:  document.getElementById('d-conclusions')?.value || _currentRev.general_conclusions || ''
  }
}

// ── Save General tab ──────────────────────────────────────────
async function saveGeneral() {
  if (!_currentRev) return
  const g = _collectGeneralValues()

  const { error } = await db.rpc('update_management_review', {
    p_id:                  _currentRev.id,
    p_status:              g.status,
    p_location:            g.location,
    p_next_review_date:    g.next_date || null,
    p_general_conclusions: g.conclusions,
    p_attendees:           _editAttendees,
    p_inputs:              _editInputs,
    p_outputs:             _editOutputs
  })

  if (error) { showToast('Error al guardar: ' + error.message, 'red'); return }

  // Update local state
  _currentRev.status              = g.status
  _currentRev.location            = g.location
  _currentRev.next_review_date    = g.next_date || null
  _currentRev.general_conclusions = g.conclusions
  _updateLocalReview()

  showToast('Información general guardada.', 'green')
  setText('detail-number', _currentRev.review_number || '—')
  renderKPIs()
  renderTable()
}

// ── Save Attendees tab ────────────────────────────────────────
async function saveAttendees() {
  if (!_currentRev) return
  _collectAttendeeValues()

  const g = _collectGeneralValues()

  const { error } = await db.rpc('update_management_review', {
    p_id:                  _currentRev.id,
    p_status:              g.status,
    p_location:            g.location,
    p_next_review_date:    g.next_date || null,
    p_general_conclusions: g.conclusions,
    p_attendees:           _editAttendees,
    p_inputs:              _editInputs,
    p_outputs:             _editOutputs
  })

  if (error) { showToast('Error al guardar: ' + error.message, 'red'); return }

  _currentRev.attendees = JSON.parse(JSON.stringify(_editAttendees))
  _updateLocalReview()
  showToast('Participantes guardados.', 'green')
  renderTable()
}

// ── Save Inputs tab ───────────────────────────────────────────
async function saveInputs() {
  if (!_currentRev) return
  _collectInputNotes()

  const g = _collectGeneralValues()

  const { error } = await db.rpc('update_management_review', {
    p_id:                  _currentRev.id,
    p_status:              g.status,
    p_location:            g.location,
    p_next_review_date:    g.next_date || null,
    p_general_conclusions: g.conclusions,
    p_attendees:           _editAttendees,
    p_inputs:              _editInputs,
    p_outputs:             _editOutputs
  })

  if (error) { showToast('Error al guardar: ' + error.message, 'red'); return }

  _currentRev.inputs = JSON.parse(JSON.stringify(_editInputs))
  _updateLocalReview()
  showToast('Entradas guardadas.', 'green')
  renderTable()
}

// ── Save Outputs tab ──────────────────────────────────────────
async function saveOutputs() {
  if (!_currentRev) return
  _saveOutputTexts()

  const g = _collectGeneralValues()

  const { error } = await db.rpc('update_management_review', {
    p_id:                  _currentRev.id,
    p_status:              g.status,
    p_location:            g.location,
    p_next_review_date:    g.next_date || null,
    p_general_conclusions: g.conclusions,
    p_attendees:           _editAttendees,
    p_inputs:              _editInputs,
    p_outputs:             _editOutputs
  })

  if (error) { showToast('Error al guardar: ' + error.message, 'red'); return }

  _currentRev.outputs = JSON.parse(JSON.stringify(_editOutputs))
  _updateLocalReview()
  showToast('Salidas guardadas.', 'green')
  renderKPIs()
  renderTable()
}

// ── Update the _reviews array with current edit state ─────────
function _updateLocalReview() {
  const idx = _reviews.findIndex(r => r.id === _currentRev.id)
  if (idx !== -1) _reviews[idx] = { ..._reviews[idx], ..._currentRev }
}

// ── Attendees tab ─────────────────────────────────────────────
function _collectAttendeeValues() {
  _editAttendees.forEach((att, idx) => {
    const nameEl  = document.getElementById(`att-name-${idx}`)
    const posEl   = document.getElementById(`att-pos-${idx}`)
    const attEl   = document.getElementById(`att-check-${idx}`)
    if (nameEl) att.name     = nameEl.value
    if (posEl)  att.position = posEl.value
    if (attEl)  att.attended = attEl.checked
  })
}

function renderAttendeesTab() {
  const container = document.getElementById('attendees-list')
  if (!container) return

  if (_editAttendees.length === 0) {
    container.innerHTML = '<div class="attendees-empty">Sin participantes registrados. Agregue el primero con el botón de abajo.</div>'
    return
  }

  container.innerHTML = _editAttendees.map((att, idx) => `
    <div class="attendee-row" id="att-row-${idx}">
      <div class="attendee-field-name">
        <input type="text" class="attendee-input" id="att-name-${idx}"
          value="${esc(att.name || '')}" placeholder="Nombre completo">
      </div>
      <div class="attendee-field-pos">
        <input type="text" class="attendee-input" id="att-pos-${idx}"
          value="${esc(att.position || '')}" placeholder="Cargo / Área">
      </div>
      <div class="attendee-field-att">
        <input type="checkbox" id="att-check-${idx}" ${att.attended ? 'checked' : ''}>
        <label for="att-check-${idx}" style="cursor:pointer;user-select:none">Asistió</label>
      </div>
      <button class="btn-icon-remove" onclick="removeAttendee(${idx})" title="Quitar">
        <i class="fa-solid fa-xmark"></i>
      </button>
    </div>`
  ).join('')
}

function addAttendee() {
  _collectAttendeeValues()
  _editAttendees.push({ name: '', position: '', attended: true })
  renderAttendeesTab()
  // Focus the new name field
  const last = _editAttendees.length - 1
  setTimeout(() => document.getElementById(`att-name-${last}`)?.focus(), 50)
}

function removeAttendee(idx) {
  _collectAttendeeValues()
  _editAttendees.splice(idx, 1)
  renderAttendeesTab()
}

// ── Inputs tab ────────────────────────────────────────────────
function _collectInputNotes() {
  _editInputs.forEach((inp, idx) => {
    const notesEl = document.getElementById(`inp-notes-${idx}`)
    if (notesEl) inp.notes = notesEl.value
  })
}

function renderInputsTab() {
  const container = document.getElementById('inputs-list')
  if (!container) return

  container.innerHTML = _editInputs.map((inp, idx) => {
    const r = inp.rating
    const showNotes = r === 'MEJORA' || r === 'CRITICO'
    return `
    <div class="iso-input-row" id="inp-row-${idx}">
      <div class="iso-input-label">
        <div class="iso-input-num">${String(idx + 1).padStart(2, '0')}</div>
        <div class="iso-input-label-txt">${esc(inp.label)}</div>
      </div>
      <div class="iso-input-controls">
        <div class="rating-btns">
          <button type="button" class="rating-btn ${r === 'SATISFACTORIO' ? 'active-satisfactorio' : ''}"
            onclick="setInputRating('${inp.key}', 'SATISFACTORIO')">
            🟢 Satisfactorio
          </button>
          <button type="button" class="rating-btn ${r === 'MEJORA' ? 'active-mejora' : ''}"
            onclick="setInputRating('${inp.key}', 'MEJORA')">
            🟡 Requiere mejora
          </button>
          <button type="button" class="rating-btn ${r === 'CRITICO' ? 'active-critico' : ''}"
            onclick="setInputRating('${inp.key}', 'CRITICO')">
            🔴 Crítico
          </button>
        </div>
        ${showNotes ? `
        <textarea class="iso-notes" id="inp-notes-${idx}" rows="2"
          placeholder="Agregue notas u observaciones…">${esc(inp.notes || '')}</textarea>` : `
        <textarea class="iso-notes" id="inp-notes-${idx}" rows="2"
          placeholder="Notas opcionales…" style="display:none">${esc(inp.notes || '')}</textarea>`}
      </div>
    </div>`
  }).join('')
}

function setInputRating(key, rating) {
  _collectInputNotes()
  const inp = _editInputs.find(i => i.key === key)
  if (!inp) return
  // Toggle off if already selected
  inp.rating = inp.rating === rating ? null : rating
  renderInputsTab()
}

// ── Outputs tab ───────────────────────────────────────────────
function _saveOutputTexts() {
  _editOutputs.forEach((out, idx) => {
    const typeEl  = document.getElementById(`out-type-${idx}`)
    const descEl  = document.getElementById(`out-desc-${idx}`)
    const respEl  = document.getElementById(`out-resp-${idx}`)
    const dueEl   = document.getElementById(`out-due-${idx}`)
    const stEl    = document.getElementById(`out-status-${idx}`)
    if (typeEl)  out.type        = typeEl.value
    if (descEl)  out.description = descEl.value
    if (respEl)  out.responsible = respEl.value
    if (dueEl)   out.due_date    = dueEl.value || null
    if (stEl)    out.status      = stEl.value
  })
}

function renderOutputsTab() {
  const container = document.getElementById('outputs-list')
  if (!container) return

  if (_editOutputs.length === 0) {
    container.innerHTML = `<div class="outputs-empty">
      <i class="fa-solid fa-inbox"></i>
      Sin acciones registradas. Use el botón de abajo para agregar una.
    </div>`
    return
  }

  container.innerHTML = _editOutputs.map((out, idx) => `
    <div class="output-card" id="out-card-${idx}">
      <div class="output-card-head">
        <span class="output-card-num"><i class="fa-solid fa-arrow-right-from-bracket"></i> Acción ${idx + 1}</span>
        <button class="btn-icon-remove" onclick="removeOutput(${idx})" title="Quitar acción">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>
      <div class="output-fields">
        <div class="output-row">
          <div>
            <div class="output-field-label">Tipo</div>
            <select class="output-select" id="out-type-${idx}">
              <option value="MEJORA"      ${out.type==='MEJORA'      ?'selected':''}>Oportunidad de mejora</option>
              <option value="CAMBIO_SGC"  ${out.type==='CAMBIO_SGC'  ?'selected':''}>Cambio en SGC</option>
              <option value="RECURSOS"    ${out.type==='RECURSOS'    ?'selected':''}>Necesidad de recursos</option>
            </select>
          </div>
          <div>
            <div class="output-field-label">Estado</div>
            <select class="output-select" id="out-status-${idx}">
              <option value="PENDIENTE"  ${out.status==='PENDIENTE'  ?'selected':''}>Pendiente</option>
              <option value="EN_PROCESO" ${out.status==='EN_PROCESO' ?'selected':''}>En proceso</option>
              <option value="COMPLETADO" ${out.status==='COMPLETADO' ?'selected':''}>Completado</option>
            </select>
          </div>
        </div>
        <div>
          <div class="output-field-label">Descripción / Decisión</div>
          <textarea class="output-textarea" id="out-desc-${idx}" rows="2"
            placeholder="Describa la acción, mejora o necesidad de recurso…">${esc(out.description || '')}</textarea>
        </div>
        <div class="output-row">
          <div>
            <div class="output-field-label">Responsable</div>
            <input type="text" class="output-input" id="out-resp-${idx}"
              value="${esc(out.responsible || '')}" placeholder="Nombre o cargo responsable">
          </div>
          <div>
            <div class="output-field-label">Fecha límite</div>
            <input type="date" class="output-input" id="out-due-${idx}"
              value="${esc(out.due_date || '')}">
          </div>
        </div>
      </div>
    </div>`
  ).join('')
}

function addOutput() {
  _saveOutputTexts()
  _editOutputs.push({
    id:          Math.random().toString(36).substring(2, 10),
    type:        'MEJORA',
    description: '',
    responsible: '',
    due_date:    null,
    status:      'PENDIENTE'
  })
  renderOutputsTab()
  // Scroll to new card
  setTimeout(() => {
    const last = document.getElementById(`out-card-${_editOutputs.length - 1}`)
    last?.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
    document.getElementById(`out-desc-${_editOutputs.length - 1}`)?.focus()
  }, 50)
}

function removeOutput(idx) {
  _saveOutputTexts()
  _editOutputs.splice(idx, 1)
  renderOutputsTab()
}

function setOutputStatus(idx, status) {
  _saveOutputTexts()
  if (_editOutputs[idx]) _editOutputs[idx].status = status
  renderOutputsTab()
}

// ── Pagination ────────────────────────────────────────────────
function renderPagination() {
  const pag   = document.getElementById('pagination')
  if (!pag) return
  const pages = Math.ceil(_filtered.length / PAGE_SIZE)
  if (pages <= 1) { pag.innerHTML = ''; return }

  let html = ''
  if (_page > 1)
    html += `<button class="page-btn" onclick="goPage(${_page - 1})"><i class="fa-solid fa-chevron-left"></i></button>`

  const start = Math.max(1, _page - 2)
  const end   = Math.min(pages, _page + 2)

  if (start > 1)
    html += `<button class="page-btn" onclick="goPage(1)">1</button>${start > 2 ? '<span style="padding:0 4px;color:var(--txt3)">…</span>' : ''}`

  for (let i = start; i <= end; i++)
    html += `<button class="page-btn${i === _page ? ' active' : ''}" onclick="goPage(${i})">${i}</button>`

  if (end < pages)
    html += `${end < pages - 1 ? '<span style="padding:0 4px;color:var(--txt3)">…</span>' : ''}<button class="page-btn" onclick="goPage(${pages})">${pages}</button>`

  if (_page < pages)
    html += `<button class="page-btn" onclick="goPage(${_page + 1})"><i class="fa-solid fa-chevron-right"></i></button>`

  pag.innerHTML = html
}

function goPage(p) {
  _page = p
  renderTable()
  window.scrollTo(0, 0)
}

// ── Badge helpers ─────────────────────────────────────────────
function statusBadge(status) {
  if (!status) return '<span style="color:var(--txt3)">—</span>'
  const map = {
    PLANIFICADA: { cls: 'status-planificada', icon: 'fa-calendar', label: 'Planificada' },
    EN_PROCESO:  { cls: 'status-en_proceso',  icon: 'fa-gears',    label: 'En Proceso' },
    COMPLETADA:  { cls: 'status-completada',  icon: 'fa-check',    label: 'Completada' },
  }
  const m = map[status] || { cls: '', icon: 'fa-circle', label: status }
  return `<span class="status-badge ${m.cls}"><i class="fa-solid ${m.icon}"></i>${m.label}</span>`
}

function fmtPeriod(status) {
  return statusBadge(status)
}

// ── Loading / error states ────────────────────────────────────
function showTableLoading() {
  const tbody = document.getElementById('rd-tbody')
  if (tbody) tbody.innerHTML = `<tr><td colspan="8" class="table-empty">
    <i class="fa-solid fa-spinner fa-spin"></i>
    <strong>Cargando…</strong>
  </td></tr>`
}

function showTableError(msg) {
  const tbody = document.getElementById('rd-tbody')
  if (tbody) tbody.innerHTML = `<tr><td colspan="8" class="table-empty">
    <i class="fa-solid fa-triangle-exclamation"></i>
    <strong>Error al cargar</strong>${esc(msg)}
  </td></tr>`
}

// ── Shared helpers (same pattern as satisfaccion.js) ──────────
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }

function switchTab(panelId, btn) {
  const modal = btn.closest('.modal, .layout')
  modal.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'))
  modal.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'))
  btn.classList.add('active')
  document.getElementById(panelId)?.classList.add('active')
}

function fmtDate(d) {
  if (!d) return '—'
  return new Date(d + 'T12:00:00').toLocaleDateString('es-MX',
    { day: '2-digit', month: 'short', year: 'numeric' })
}

function setText(id, val) {
  const el = document.getElementById(id)
  if (el) el.textContent = val ?? '—'
}

function esc(s) {
  if (!s) return ''
  return String(s)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
}

function showToast(msg, color = 'green') {
  const old = document.getElementById('sgc-toast')
  if (old) old.remove()
  const bg = color === 'green' ? '#16a34a' : color === 'red' ? '#dc2626' : '#2563eb'
  const t  = document.createElement('div')
  t.id = 'sgc-toast'
  t.style.cssText = `position:fixed;bottom:28px;right:28px;z-index:9999;background:${bg};color:#fff;
    padding:13px 22px;border-radius:12px;font-size:.857rem;font-weight:600;font-family:var(--font);
    box-shadow:0 8px 28px rgba(0,0,0,.22);max-width:380px;line-height:1.4;`
  t.textContent = msg
  document.body.appendChild(t)
  setTimeout(() => t.remove(), 3800)
}

// Close modals on overlay click
document.querySelectorAll('.modal-overlay').forEach(overlay => {
  overlay.addEventListener('click', e => {
    if (e.target === overlay) overlay.classList.remove('open')
  })
})

// ── Bootstrap ─────────────────────────────────────────────────
initRD()
