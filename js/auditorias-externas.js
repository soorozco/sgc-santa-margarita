// ─── Auditorías Externas — Cláusula 9.2 ────────────────────────

const BUCKET = 'evidencias'

let _user         = null
let _profile      = null
let _role         = null
let _allAE        = []
let _currentAE    = null
let _editTeam     = []
let _editAreas    = []
let _editFindings = []
let _findingsEditMode = false

// ── Init ────────────────────────────────────────────────────────
async function initAE() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'
  // Mostrar nav de solicitudes solo para admin/responsable
  if (['administrador','responsable_calidad'].includes(_role)) {
    const navSol = document.getElementById('nav-solicitudes')
    if (navSol) navSol.style.display = 'flex'
    db.from('document_deactivation_requests').select('id').eq('status','pending').then(({data}) => {
      const count = data?.length || 0
      const badge = document.getElementById('badge-sol')
      if (badge && count > 0) { badge.textContent = count; badge.style.display = 'inline-flex' }
    })
  }

  renderUserInfo()
  setCurrentDate()
  await loadAE()
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
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)
  const btn = document.getElementById('btn-new-ae')
  if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'
  const btnEdit = document.getElementById('btn-findings-edit')
  if (btnEdit) btnEdit.style.display = canWrite ? 'inline-flex' : 'none'
}

// ── Load ─────────────────────────────────────────────────────────
async function loadAE() {
  const { data, error } = await db
    .from('auditorias_externas')
    .select('*')
    .order('audit_date_start', { ascending: false })

  if (error) {
    showToast('Error al cargar: ' + error.message, 'red')
    setText('ae-count', 'Error al cargar')
    return
  }
  _allAE = data || []
  renderKPIs()
  applyFilters()
}

// ── KPIs ─────────────────────────────────────────────────────────
function renderKPIs() {
  let total = _allAE.length
  let planificadas = 0, ejecucion = 0, completadas = 0, ncAbiertas = 0

  _allAE.forEach(ae => {
    if (ae.status === 'planificada')  planificadas++
    else if (ae.status === 'en_ejecucion') ejecucion++
    else if (ae.status === 'completada')   completadas++

    const findings = ae.findings || []
    findings.forEach(f => {
      if ((f.type === 'nc_mayor' || f.type === 'nc_menor') &&
          f.status !== 'cerrado') ncAbiertas++
    })
  })

  setText('kpi-total',       total)
  setText('kpi-planificadas', planificadas)
  setText('kpi-ejecucion',   ejecucion)
  setText('kpi-completadas', completadas)
  setText('kpi-nc',          ncAbiertas)
}

// ── Filters ──────────────────────────────────────────────────────
function applyFilters() {
  const q      = (document.getElementById('search-input')?.value || '').toLowerCase()
  const type   = document.getElementById('f-type')?.value   || ''
  const status = document.getElementById('f-status')?.value || ''

  const filtered = _allAE.filter(ae => {
    const txt = `${ae.audit_number||''} ${ae.certification_body||''} ${ae.scope||''}`.toLowerCase()
    return (!q      || txt.includes(q))
        && (!type   || ae.audit_type === type)
        && (!status || ae.status === status)
  })
  renderTable(filtered)
}

// ── Render Table ─────────────────────────────────────────────────
function renderTable(list) {
  const tbody = document.getElementById('ae-tbody')
  const count = document.getElementById('ae-count')
  if (count) count.textContent = `${list.length} auditoría${list.length !== 1 ? 's' : ''}`
  if (!tbody) return

  if (list.length === 0) {
    tbody.innerHTML = `<tr><td colspan="8" class="table-empty">
      <i class="fa-solid fa-award" style="font-size:1.5rem;display:block;margin-bottom:8px"></i>
      <strong>Sin auditorías registradas</strong>
      Usa "Nueva Auditoría" para crear el primer expediente.
    </td></tr>`
    return
  }

  tbody.innerHTML = list.map(ae => {
    const findings  = ae.findings || []
    const ncMayor   = findings.filter(f => f.type === 'nc_mayor').length
    const ncMenor   = findings.filter(f => f.type === 'nc_menor').length
    const obs       = findings.filter(f => f.type === 'observacion').length
    const op        = findings.filter(f => f.type === 'oportunidad').length
    const pf        = findings.filter(f => f.type === 'punto_fuerte').length

    const findingsBadges = [
      ncMayor ? `<span class="ftag nc_mayor">${ncMayor} NC Mayor</span>` : '',
      ncMenor ? `<span class="ftag nc_menor">${ncMenor} NC Menor</span>` : '',
      obs     ? `<span class="ftag observacion">${obs} Obs.</span>` : '',
      op      ? `<span class="ftag oportunidad">${op} Oport.</span>` : '',
      pf      ? `<span class="ftag punto_fuerte">${pf} PF</span>` : '',
    ].filter(Boolean).join('')

    const certBadge = ae.certification_result
      ? `<span class="cert-${ae.certification_result}">${certLabel(ae.certification_result)}</span>`
      : `<span class="cert-none">—</span>`

    return `
    <tr>
      <td><span class="ae-number">${esc(ae.audit_number || '—')}</span></td>
      <td>
        <div class="ae-body">${esc(ae.certification_body || '—')}</div>
        <div class="ae-type">${typeLabel(ae.audit_type)} · ${esc(ae.standard || 'ISO 9001:2015')}</div>
      </td>
      <td><span class="ae-scope" title="${esc(ae.scope||'')}">${esc(ae.scope || '—')}</span></td>
      <td class="center" style="font-size:.857rem;white-space:nowrap">
        ${fmtDate(ae.audit_date_start)}${ae.audit_date_end && ae.audit_date_end !== ae.audit_date_start
          ? '<br><span style="color:var(--txt3)">→ ' + fmtDate(ae.audit_date_end) + '</span>'
          : ''}
      </td>
      <td class="center">
        <div class="findings-mini">
          ${findingsBadges || '<span style="font-size:.75rem;color:var(--txt3)">—</span>'}
        </div>
      </td>
      <td class="center"><span class="pill pill-${ae.status||'planificada'}">${statusLabel(ae.status)}</span></td>
      <td class="center">${certBadge}</td>
      <td class="center">
        <div class="action-btns">
          <button onclick="openDetail('${ae.id}')" class="btn-action" title="Abrir expediente">
            <i class="fa-solid fa-folder-open"></i>
          </button>
        </div>
      </td>
    </tr>`
  }).join('')
}

// ── Modal: Nueva AE ──────────────────────────────────────────────
function openNewAE() {
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)
  if (!canWrite) return

  const year = new Date().getFullYear()
  const next = (_allAE.length + 1).toString().padStart(3, '0')
  setVal('new-number',       `AE-${year}-${next}`)
  setVal('new-type',         'seguimiento')
  setVal('new-body',         '')
  setVal('new-standard',     'ISO 9001:2015')
  setVal('new-date-start',   new Date().toISOString().split('T')[0])
  setVal('new-date-end',     '')
  setVal('new-lead-auditor', '')
  openModal('modal-new')
}

async function submitNewAE() {
  const btn   = document.getElementById('btn-save-new')
  const num   = document.getElementById('new-number')?.value.trim()
  const type  = document.getElementById('new-type')?.value
  const body  = document.getElementById('new-body')?.value.trim()
  const std   = document.getElementById('new-standard')?.value.trim()
  const ds    = document.getElementById('new-date-start')?.value
  const de    = document.getElementById('new-date-end')?.value
  const lead  = document.getElementById('new-lead-auditor')?.value.trim()

  if (!num)  { showToast('Indica el número de auditoría.', 'red'); return }
  if (!body) { showToast('Indica el organismo certificador.', 'red'); return }
  if (!ds)   { showToast('Indica la fecha de inicio.', 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Creando…'

  const { error } = await db.rpc('save_auditoria_externa', {
    p_row: {
      audit_number: num, audit_type: type, certification_body: body,
      standard: std || 'ISO 9001:2015', audit_date_start: ds,
      audit_date_end: de || null, lead_auditor: lead || null,
      status: 'planificada', team: [], areas: [], findings: [],
      created_by: _user.id
    }
  })

  if (error) {
    showToast('Error: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Crear Expediente')
    return
  }

  showToast('Expediente de auditoría creado.', 'green')
  closeModal('modal-new')
  resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Crear Expediente')
  await loadAE()
}

// ── Modal: Detalle ────────────────────────────────────────────────
async function openDetail(id) {
  _currentAE = _allAE.find(a => a.id === id)
  if (!_currentAE) return
  const ae = _currentAE

  setText('detail-number',   ae.audit_number || '—')
  setText('detail-subtitle', `${typeLabel(ae.audit_type)} · ${esc(ae.certification_body || '—')}`)

  setText('d-number',   ae.audit_number || '—')
  setText('d-type-lbl', typeLabel(ae.audit_type))
  setText('d-standard', ae.standard || 'ISO 9001:2015')
  setText('d-created-by', ae.created_by_name || '—')

  setVal('d-status',        ae.status || 'planificada')
  setVal('d-body',          ae.certification_body || '')
  setVal('d-date-start',    ae.audit_date_start || '')
  setVal('d-date-end',      ae.audit_date_end || '')
  setVal('d-scope',         ae.scope || '')
  setVal('d-lead-auditor',  ae.lead_auditor || '')
  setVal('d-cert-result',   ae.certification_result || '')
  setVal('d-next-audit',    ae.next_audit_date || '')
  setVal('d-conclusion',    ae.conclusion || '')

  _editTeam     = JSON.parse(JSON.stringify(ae.team     || []))
  _editAreas    = JSON.parse(JSON.stringify(ae.areas    || []))
  _editFindings = JSON.parse(JSON.stringify(ae.findings || []))

  // Always open in view mode
  _findingsEditMode = false
  const btnEdit = document.getElementById('btn-findings-edit')
  if (btnEdit) {
    btnEdit.innerHTML = '<i class="fa-solid fa-pen"></i> Editar'
    btnEdit.classList.remove('editing')
  }
  const actions = document.getElementById('findings-actions')
  if (actions) actions.style.display = 'none'

  renderTeam()
  renderAreas()
  renderFindings()
  renderFindingsSummary()
  renderReportFile()
  renderMeetingFile()
  renderMeetingUploadBtn()
  updateFindingsBadge()

  switchTab('tab-plan', document.querySelector('.tab-btn'))
  openModal('modal-detail')
}

// ── Plan: team & areas ────────────────────────────────────────────
function renderTeam() {
  const el = document.getElementById('team-list')
  if (!el) return
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)
  if (_editTeam.length === 0) { el.innerHTML = ''; return }
  el.innerHTML = _editTeam.map((m, i) => `
    <div class="list-row">
      <input type="text" value="${esc(m)}" placeholder="Nombre del auditor"
        oninput="_editTeam[${i}]=this.value" ${canWrite ? '' : 'readonly'}>
      ${canWrite ? `<button class="btn-remove" onclick="_editTeam.splice(${i},1);renderTeam()">
        <i class="fa-solid fa-xmark"></i></button>` : ''}
    </div>`).join('')
}

function addTeamMember() {
  _editTeam.push('')
  renderTeam()
  document.getElementById('team-list')?.lastElementChild?.querySelector('input')?.focus()
}

function renderAreas() {
  const el = document.getElementById('areas-list')
  if (!el) return
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)
  if (_editAreas.length === 0) { el.innerHTML = ''; return }
  el.innerHTML = _editAreas.map((a, i) => `
    <div class="list-row">
      <input type="text" value="${esc(a)}" placeholder="Área o proceso"
        oninput="_editAreas[${i}]=this.value" ${canWrite ? '' : 'readonly'}>
      ${canWrite ? `<button class="btn-remove" onclick="_editAreas.splice(${i},1);renderAreas()">
        <i class="fa-solid fa-xmark"></i></button>` : ''}
    </div>`).join('')
}

function addArea() {
  _editAreas.push('')
  renderAreas()
  document.getElementById('areas-list')?.lastElementChild?.querySelector('input')?.focus()
}

// ── Save Plan ─────────────────────────────────────────────────────
async function savePlan() {
  if (!_currentAE) return
  const ae = _currentAE

  const payload = {
    id:                   ae.id,
    audit_number:         ae.audit_number,
    audit_type:           ae.audit_type,
    certification_body:   document.getElementById('d-body')?.value.trim(),
    standard:             ae.standard,
    audit_date_start:     document.getElementById('d-date-start')?.value || null,
    audit_date_end:       document.getElementById('d-date-end')?.value   || null,
    scope:                document.getElementById('d-scope')?.value.trim(),
    lead_auditor:         document.getElementById('d-lead-auditor')?.value.trim(),
    status:               document.getElementById('d-status')?.value,
    team:                 _editTeam.filter(m => m.trim()),
    areas:                _editAreas.filter(a => a.trim()),
    findings:             ae.findings || [],
    conclusion:           ae.conclusion || null,
    certification_result: ae.certification_result || null,
    next_audit_date:      ae.next_audit_date || null,
    report_path:          ae.report_path || null,
    report_url:           ae.report_url  || null,
    report_name:          ae.report_name || null,
    created_by:           ae.created_by
  }

  const { error } = await db.rpc('save_auditoria_externa', { p_row: payload })
  if (error) { showToast('Error: ' + error.message, 'red'); return }

  Object.assign(_currentAE, {
    certification_body: payload.certification_body,
    audit_date_start:   payload.audit_date_start,
    audit_date_end:     payload.audit_date_end,
    scope:              payload.scope,
    lead_auditor:       payload.lead_auditor,
    status:             payload.status,
    team:               payload.team,
    areas:              payload.areas
  })
  syncToList()
  showToast('Plan guardado correctamente.', 'green')
  renderKPIs()
  applyFilters()
}

// ── Findings ──────────────────────────────────────────────────────
function renderFindings() {
  const el = document.getElementById('findings-list')
  if (!el) return
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)

  if (_editFindings.length === 0) {
    el.innerHTML = `<div class="no-findings">
      <i class="fa-solid fa-flag"></i>
      Sin hallazgos registrados aún.
      ${canWrite ? 'Usa "Editar" para registrar los hallazgos de la auditoría.' : ''}
    </div>`
    return
  }

  if (!_findingsEditMode) {
    // ── Vista: tarjetas de solo lectura ──
    const typeConf = {
      nc_mayor:    { label:'NC Mayor',            cls:'fv-nc-mayor', icon:'fa-circle-xmark' },
      nc_menor:    { label:'NC Menor',            cls:'fv-nc-menor', icon:'fa-triangle-exclamation' },
      observacion: { label:'Observación',          cls:'fv-obs',      icon:'fa-eye' },
      oportunidad: { label:'Oportunidad de Mejora',cls:'fv-oport',   icon:'fa-lightbulb' },
      punto_fuerte:{ label:'Punto Fuerte',         cls:'fv-pf',       icon:'fa-star' },
    }
    const stConf = {
      abierto:    { label:'Abierto',    cls:'fvst-abierto' },
      en_proceso: { label:'En Proceso', cls:'fvst-proceso' },
      cerrado:    { label:'Cerrado',    cls:'fvst-cerrado' },
    }

    el.innerHTML = _editFindings.map((f, i) => {
      const tc = typeConf[f.type] || typeConf.observacion
      const sc = stConf[f.status] || stConf.abierto
      return `
      <div class="fv-card ${tc.cls}">
        <div class="fv-header">
          <span class="fv-num">#${String(i+1).padStart(2,'0')}</span>
          <span class="fv-type-badge ${tc.cls}">
            <i class="fa-solid ${tc.icon}"></i> ${tc.label}
          </span>
          ${f.clause  ? `<span class="fv-pill fv-clause-pill"><i class="fa-solid fa-hashtag" style="font-size:9px"></i> Cláusula ${esc(f.clause)}</span>` : ''}
          ${f.process ? `<span class="fv-pill fv-process-pill"><i class="fa-solid fa-sitemap" style="font-size:9px"></i> ${esc(f.process)}</span>` : ''}
          <span style="flex:1"></span>
          <span class="fv-status-badge ${sc.cls}">${sc.label}</span>
        </div>
        <div class="fv-body">
          ${f.description ? `
          <div class="fv-section">
            <div class="fv-label"><i class="fa-solid fa-align-left"></i> Descripción del Hallazgo</div>
            <div class="fv-text">${esc(f.description)}</div>
          </div>` : ''}
          ${f.evidence ? `
          <div class="fv-section">
            <div class="fv-label"><i class="fa-solid fa-paperclip"></i> Evidencia Objetiva</div>
            <div class="fv-text fv-text-ev">${esc(f.evidence)}</div>
          </div>` : ''}
        </div>
      </div>`
    }).join('')
    return
  }

  // ── Edición: formularios ──
  el.innerHTML = _editFindings.map((f, i) => `
    <div class="finding-card type-${f.type || 'observacion'}" id="fcard-${i}">
      <div class="finding-header">
        <select class="finding-type-sel" onchange="onFindingTypeChange(${i},this.value)" ${canWrite ? '' : 'disabled'}>
          <option value="nc_mayor"    ${f.type==='nc_mayor'    ?'selected':''}>🔴 NC Mayor</option>
          <option value="nc_menor"    ${f.type==='nc_menor'    ?'selected':''}>🟡 NC Menor</option>
          <option value="observacion" ${f.type==='observacion' ?'selected':''}>🔵 Observación</option>
          <option value="oportunidad" ${f.type==='oportunidad' ?'selected':''}>💡 Oportunidad de Mejora</option>
          <option value="punto_fuerte"${f.type==='punto_fuerte'?'selected':''}>✅ Punto Fuerte</option>
        </select>
        <input class="finding-clause" type="text" value="${esc(f.clause||'')}"
          oninput="_editFindings[${i}].clause=this.value"
          placeholder="Cláusula" title="Cláusula ISO (ej. 8.1)"
          ${canWrite ? '' : 'readonly'}>
        <input class="finding-process" type="text" value="${esc(f.process||'')}"
          oninput="_editFindings[${i}].process=this.value"
          placeholder="Proceso / Área auditada"
          ${canWrite ? '' : 'readonly'}>
        <select class="finding-status-sel" onchange="_editFindings[${i}].status=this.value" ${canWrite ? '' : 'disabled'}>
          <option value="abierto"    ${f.status==='abierto'    ?'selected':''}>Abierto</option>
          <option value="en_proceso" ${f.status==='en_proceso' ?'selected':''}>En Proceso</option>
          <option value="cerrado"    ${f.status==='cerrado'    ?'selected':''}>Cerrado</option>
        </select>
        ${canWrite ? `<button class="btn-remove" onclick="removeFinding(${i})" title="Eliminar hallazgo">
          <i class="fa-solid fa-trash-can"></i>
        </button>` : ''}
      </div>
      <div class="finding-body">
        <div>
          <div class="finding-label">Descripción del Hallazgo</div>
          <textarea rows="3" oninput="_editFindings[${i}].description=this.value"
            placeholder="Describa detalladamente el hallazgo identificado…"
            ${canWrite ? '' : 'readonly'}>${esc(f.description||'')}</textarea>
        </div>
        <div>
          <div class="finding-label">Evidencia Objetiva</div>
          <textarea rows="2" oninput="_editFindings[${i}].evidence=this.value"
            placeholder="Registros, documentos u observaciones que sustentan el hallazgo…"
            ${canWrite ? '' : 'readonly'}>${esc(f.evidence||'')}</textarea>
        </div>
      </div>
    </div>`).join('')
}

function onFindingTypeChange(idx, type) {
  _editFindings[idx].type = type
  const card = document.getElementById(`fcard-${idx}`)
  if (card) {
    card.className = `finding-card type-${type}`
  }
  renderFindingsSummary()
}

function addFinding() {
  // Auto-switch to edit mode if not already
  if (!_findingsEditMode) {
    _findingsEditMode = true
    const btnEdit = document.getElementById('btn-findings-edit')
    if (btnEdit) {
      btnEdit.innerHTML = '<i class="fa-solid fa-eye"></i> Ver hallazgos'
      btnEdit.classList.add('editing')
    }
    const actions = document.getElementById('findings-actions')
    if (actions) actions.style.display = 'flex'
  }
  _editFindings.push({ type:'observacion', clause:'', process:'', description:'', evidence:'', status:'abierto' })
  renderFindings()
  renderFindingsSummary()
  updateFindingsBadge()
  document.getElementById('findings-list')?.lastElementChild?.scrollIntoView({ behavior:'smooth', block:'nearest' })
}

function removeFinding(idx) {
  _editFindings.splice(idx, 1)
  renderFindings()
  renderFindingsSummary()
  updateFindingsBadge()
}

async function saveFindings() {
  if (!_currentAE) return
  const ae = _currentAE

  const payload = buildPayload(ae, { findings: _editFindings })
  const { error } = await db.rpc('save_auditoria_externa', { p_row: payload })
  if (error) { showToast('Error: ' + error.message, 'red'); return }

  _currentAE.findings = JSON.parse(JSON.stringify(_editFindings))
  syncToList()
  renderFindingsSummary()
  updateFindingsBadge()
  renderKPIs()
  applyFilters()
  showToast('Hallazgos guardados.', 'green')
}

function renderFindingsSummary() {
  const el = document.getElementById('findings-summary')
  if (!el) return
  const counts = { nc_mayor:0, nc_menor:0, observacion:0, oportunidad:0, punto_fuerte:0 }
  _editFindings.forEach(f => { if (f.type in counts) counts[f.type]++ })

  const chips = [
    counts.nc_mayor   ? `<span class="fs-chip fs-nc-mayor"><i class="fa-solid fa-circle-xmark"></i> ${counts.nc_mayor} NC Mayor</span>` : '',
    counts.nc_menor   ? `<span class="fs-chip fs-nc-menor"><i class="fa-solid fa-triangle-exclamation"></i> ${counts.nc_menor} NC Menor</span>` : '',
    counts.observacion? `<span class="fs-chip fs-obs"><i class="fa-solid fa-eye"></i> ${counts.observacion} Observación</span>` : '',
    counts.oportunidad? `<span class="fs-chip fs-op"><i class="fa-solid fa-lightbulb"></i> ${counts.oportunidad} Oportunidad</span>` : '',
    counts.punto_fuerte?`<span class="fs-chip fs-pf"><i class="fa-solid fa-star"></i> ${counts.punto_fuerte} Punto Fuerte</span>` : '',
  ].filter(Boolean)

  el.innerHTML = chips.length
    ? chips.join('')
    : '<span style="font-size:.786rem;color:var(--txt3)">Sin hallazgos registrados aún.</span>'
}

function updateFindingsBadge() {
  const badge = document.getElementById('tab-findings-count')
  if (badge) {
    const n = _editFindings.length
    badge.textContent = n
    badge.style.display = n ? 'inline-block' : 'none'
  }
}

function toggleFindingsEdit() {
  _findingsEditMode = !_findingsEditMode
  const btnEdit = document.getElementById('btn-findings-edit')
  if (btnEdit) {
    if (_findingsEditMode) {
      btnEdit.innerHTML = '<i class="fa-solid fa-eye"></i> Ver hallazgos'
      btnEdit.classList.add('editing')
    } else {
      btnEdit.innerHTML = '<i class="fa-solid fa-pen"></i> Editar'
      btnEdit.classList.remove('editing')
    }
  }
  const actions = document.getElementById('findings-actions')
  if (actions) actions.style.display = _findingsEditMode ? 'flex' : 'none'
  renderFindings()
}

// ── Report ────────────────────────────────────────────────────────
async function saveReport() {
  if (!_currentAE) return
  const ae = _currentAE

  const payload = buildPayload(ae, {
    conclusion:           document.getElementById('d-conclusion')?.value.trim(),
    certification_result: document.getElementById('d-cert-result')?.value || null,
    next_audit_date:      document.getElementById('d-next-audit')?.value  || null,
  })

  const { error } = await db.rpc('save_auditoria_externa', { p_row: payload })
  if (error) { showToast('Error: ' + error.message, 'red'); return }

  Object.assign(_currentAE, {
    conclusion:           payload.conclusion,
    certification_result: payload.certification_result,
    next_audit_date:      payload.next_audit_date,
  })
  syncToList()
  renderKPIs()
  applyFilters()
  showToast('Informe guardado.', 'green')
}

async function uploadReport(input) {
  const file = input.files?.[0]
  if (!file || !_currentAE) return

  if (file.size > 20 * 1024 * 1024) {
    showToast('El archivo supera 20 MB.', 'red')
    input.value = ''
    return
  }

  const wrap = document.getElementById('report-upload-wrap')
  if (wrap) wrap.innerHTML = '<div style="display:flex;align-items:center;gap:8px;font-size:.857rem;color:var(--blue)"><i class="fa-solid fa-spinner fa-spin"></i> Subiendo informe…</div>'

  const safeName = file.name.replace(/[^a-zA-Z0-9._\-]/g, '_')
  const path = `auditorias/${_currentAE.id}/informe_${Date.now()}_${safeName}`

  // Delete old report if exists
  if (_currentAE.report_path) {
    await db.storage.from(BUCKET).remove([_currentAE.report_path])
  }

  const { error } = await db.storage.from(BUCKET).upload(path, file, { upsert: true })
  if (error) {
    showToast('Error al subir el informe: ' + error.message, 'red')
    renderReportUploadBtn()
    return
  }

  const { data: urlData } = db.storage.from(BUCKET).getPublicUrl(path)
  const publicUrl = urlData?.publicUrl || ''

  // Save path & url immediately
  const payload = buildPayload(_currentAE, {
    report_path: path,
    report_url:  publicUrl,
    report_name: file.name
  })
  const { error: saveErr } = await db.rpc('save_auditoria_externa', { p_row: payload })
  if (saveErr) { showToast('Subido pero no guardado: ' + saveErr.message, 'red'); return }

  Object.assign(_currentAE, { report_path: path, report_url: publicUrl, report_name: file.name })
  syncToList()

  renderReportFile()
  renderReportUploadBtn()
  input.value = ''
  showToast('Informe subido correctamente.', 'green')
}

function renderReportFile() {
  const el = document.getElementById('report-file-area')
  if (!el) return
  const ae = _currentAE
  if (!ae?.report_url) { el.innerHTML = ''; return }

  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)
  el.innerHTML = `
  <div class="report-file-card">
    <i class="fa-solid fa-file-pdf report-file-icon"></i>
    <div class="report-file-info">
      <div class="report-file-name">${esc(ae.report_name || 'Informe de auditoría')}</div>
      <div class="report-file-meta">Informe oficial adjunto</div>
    </div>
    <div class="report-file-actions">
      <a href="${ae.report_url}" target="_blank" rel="noopener" class="btn-secondary" style="text-decoration:none">
        <i class="fa-solid fa-eye"></i> Ver
      </a>
      <a href="${ae.report_url}" download class="btn-secondary" style="text-decoration:none">
        <i class="fa-solid fa-download"></i>
      </a>
      ${canWrite ? `<button class="btn-remove" onclick="deleteReport()" title="Eliminar informe">
        <i class="fa-solid fa-trash-can"></i>
      </button>` : ''}
    </div>
  </div>`
}

function renderReportUploadBtn() {
  const wrap = document.getElementById('report-upload-wrap')
  if (!wrap) return
  const ae = _currentAE
  const label = ae?.report_url ? 'Reemplazar informe PDF' : 'Subir informe PDF'
  wrap.innerHTML = `
  <label class="btn-attach-report">
    <i class="fa-solid fa-cloud-arrow-up"></i> ${label}
    <input type="file" id="report-file-input" accept=".pdf"
      onchange="uploadReport(this)" style="display:none">
  </label>
  <span class="upload-hint">Solo PDF · máx. 20 MB</span>`
}

async function deleteReport() {
  if (!_currentAE?.report_path) return
  if (!confirm('¿Eliminar el informe adjunto? Esta acción no se puede deshacer.')) return

  await db.storage.from(BUCKET).remove([_currentAE.report_path])

  const payload = buildPayload(_currentAE, { report_path: null, report_url: null, report_name: null })
  await db.rpc('save_auditoria_externa', { p_row: payload })

  Object.assign(_currentAE, { report_path: null, report_url: null, report_name: null })
  syncToList()
  renderReportFile()
  renderReportUploadBtn()
  showToast('Informe eliminado.', 'green')
}

// ── Meeting record ─────────────────────────────────────────────
async function uploadMeetingRecord(input) {
  const file = input.files?.[0]
  if (!file || !_currentAE) return

  if (file.size > 20 * 1024 * 1024) {
    showToast('El archivo supera 20 MB.', 'red')
    input.value = ''
    return
  }

  const wrap = document.getElementById('meeting-upload-wrap')
  if (wrap) wrap.innerHTML = '<div style="display:flex;align-items:center;gap:8px;font-size:.857rem;color:var(--blue)"><i class="fa-solid fa-spinner fa-spin"></i> Subiendo registro…</div>'

  const safeName = file.name.replace(/[^a-zA-Z0-9._\-]/g, '_')
  const path = `auditorias/${_currentAE.id}/reunion_${Date.now()}_${safeName}`

  if (_currentAE.meeting_path) {
    await db.storage.from(BUCKET).remove([_currentAE.meeting_path])
  }

  const { error } = await db.storage.from(BUCKET).upload(path, file, { upsert: true })
  if (error) {
    showToast('Error al subir el registro: ' + error.message, 'red')
    renderMeetingUploadBtn()
    return
  }

  const { data: urlData } = db.storage.from(BUCKET).getPublicUrl(path)
  const publicUrl = urlData?.publicUrl || ''

  const payload = buildPayload(_currentAE, {
    meeting_path: path,
    meeting_url:  publicUrl,
    meeting_name: file.name
  })
  const { error: saveErr } = await db.rpc('save_auditoria_externa', { p_row: payload })
  if (saveErr) { showToast('Subido pero no guardado: ' + saveErr.message, 'red'); return }

  Object.assign(_currentAE, { meeting_path: path, meeting_url: publicUrl, meeting_name: file.name })
  syncToList()

  renderMeetingFile()
  renderMeetingUploadBtn()
  input.value = ''
  showToast('Registro de reunión subido correctamente.', 'green')
}

function renderMeetingFile() {
  const el = document.getElementById('meeting-file-area')
  if (!el) return
  const ae = _currentAE
  if (!ae?.meeting_url) { el.innerHTML = ''; return }

  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)
  const isImage  = /\.(jpg|jpeg|png|webp)$/i.test(ae.meeting_name || '')
  const icon     = isImage
    ? `<i class="fa-solid fa-file-image report-file-icon" style="color:#0369a1"></i>`
    : `<i class="fa-solid fa-file-pdf report-file-icon"></i>`

  el.innerHTML = `
  <div class="report-file-card">
    ${icon}
    <div class="report-file-info">
      <div class="report-file-name">${esc(ae.meeting_name || 'Registro de reunión final')}</div>
      <div class="report-file-meta">Registro de reunión final de auditoría</div>
    </div>
    <div class="report-file-actions">
      <a href="${ae.meeting_url}" target="_blank" rel="noopener" class="btn-secondary" style="text-decoration:none">
        <i class="fa-solid fa-eye"></i> Ver
      </a>
      <a href="${ae.meeting_url}" download class="btn-secondary" style="text-decoration:none">
        <i class="fa-solid fa-download"></i>
      </a>
      ${canWrite ? `<button class="btn-remove" onclick="deleteMeetingRecord()" title="Eliminar">
        <i class="fa-solid fa-trash-can"></i>
      </button>` : ''}
    </div>
  </div>`
}

function renderMeetingUploadBtn() {
  const wrap = document.getElementById('meeting-upload-wrap')
  if (!wrap) return
  const ae    = _currentAE
  const label = ae?.meeting_url ? 'Reemplazar registro' : 'Subir registro de reunión'
  wrap.innerHTML = `
  <label class="btn-attach-report">
    <i class="fa-solid fa-cloud-arrow-up"></i> ${label}
    <input type="file" id="meeting-file-input" accept=".pdf,.jpg,.jpeg,.png"
      onchange="uploadMeetingRecord(this)" style="display:none">
  </label>
  <span class="upload-hint">PDF o imagen · máx. 20 MB</span>`
}

async function deleteMeetingRecord() {
  if (!_currentAE?.meeting_path) return
  if (!confirm('¿Eliminar el registro de reunión? Esta acción no se puede deshacer.')) return

  await db.storage.from(BUCKET).remove([_currentAE.meeting_path])

  const payload = buildPayload(_currentAE, { meeting_path: null, meeting_url: null, meeting_name: null })
  await db.rpc('save_auditoria_externa', { p_row: payload })

  Object.assign(_currentAE, { meeting_path: null, meeting_url: null, meeting_name: null })
  syncToList()
  renderMeetingFile()
  renderMeetingUploadBtn()
  showToast('Registro eliminado.', 'green')
}

// ── Helpers ───────────────────────────────────────────────────────
function buildPayload(ae, overrides = {}) {
  return {
    id:                   ae.id,
    audit_number:         ae.audit_number,
    audit_type:           ae.audit_type,
    certification_body:   ae.certification_body,
    standard:             ae.standard,
    audit_date_start:     ae.audit_date_start,
    audit_date_end:       ae.audit_date_end,
    scope:                ae.scope,
    lead_auditor:         ae.lead_auditor,
    status:               ae.status,
    team:                 ae.team     || [],
    areas:                ae.areas    || [],
    findings:             ae.findings || [],
    conclusion:           ae.conclusion           || null,
    certification_result: ae.certification_result || null,
    next_audit_date:      ae.next_audit_date      || null,
    report_path:          ae.report_path          || null,
    report_url:           ae.report_url           || null,
    report_name:          ae.report_name          || null,
    meeting_path:         ae.meeting_path         || null,
    meeting_url:          ae.meeting_url          || null,
    meeting_name:         ae.meeting_name         || null,
    created_by:           ae.created_by,
    ...overrides
  }
}

function syncToList() {
  const idx = _allAE.findIndex(a => a.id === _currentAE.id)
  if (idx > -1) _allAE[idx] = JSON.parse(JSON.stringify(_currentAE))
}

function typeLabel(t) {
  const m = { certificacion:'Certificación', seguimiento:'Seguimiento',
              recertificacion:'Recertificación', extraordinaria:'Extraordinaria' }
  return m[t] || t || '—'
}
function statusLabel(s) {
  const m = { planificada:'Planificada', en_ejecucion:'En Ejecución',
              completada:'Completada', cancelada:'Cancelada' }
  return m[s] || s || '—'
}
function certLabel(r) {
  const m = { otorgada:'Cert. Otorgada', mantenida:'Cert. Mantenida',
              suspendida:'Cert. Suspendida', retirada:'Cert. Retirada' }
  return m[r] || r || '—'
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
function showToast(msg, type = 'green') {
  const t = document.createElement('div')
  t.className = `toast ${type}`
  t.textContent = msg
  document.body.appendChild(t)
  setTimeout(() => t.remove(), 3500)
}
function switchTab(panelId, btn) {
  document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'))
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'))
  const panel = document.getElementById(panelId)
  if (panel) panel.classList.add('active')
  if (btn) btn.classList.add('active')
}
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }

// ── Boot ──────────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', initAE)
