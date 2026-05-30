// ─── Auditorías Internas — Cláusula 9.2 ────────────────────────

const BUCKET = 'evidencias'

let _user         = null
let _profile      = null
let _role         = null
let _allAI        = []
let _currentAI    = null
let _editTeam     = []
let _editAreas    = []
let _editFindings = []
let _editChecklist  = []
let _editEvals      = []
let _editActs       = []
let _reunionFinal   = {}
let _findingsEditMode  = false
let _checklistEditMode = false

// ── Init ────────────────────────────────────────────────────────
async function initAI() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

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
  await loadAI()
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
  const btn = document.getElementById('btn-new-ai')
  if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'
}

// ── Load ─────────────────────────────────────────────────────────
async function loadAI() {
  const { data, error } = await db
    .from('auditorias_internas')
    .select('*')
    .order('audit_date_start', { ascending: false })

  if (error) {
    const tbody = document.getElementById('ai-tbody')
    if (tbody) tbody.innerHTML = `<tr><td colspan="8" class="table-empty">
      <i class="fa-solid fa-triangle-exclamation" style="font-size:1.5rem;display:block;margin-bottom:8px;color:#dc2626"></i>
      <strong>Error al cargar</strong><br>${esc(error.message)}
      ${error.message.includes('does not exist') ? '<br><span style="font-size:.786rem;margin-top:6px;display:inline-block">⚠️ Ejecuta <code>sql/auditorias_internas_setup.sql</code> en Supabase.</span>' : ''}
    </td></tr>`
    setText('ai-count', 'Error')
    return
  }
  _allAI = data || []
  renderKPIs()
  applyFilters()
}

// ── KPIs ─────────────────────────────────────────────────────────
function renderKPIs() {
  let total = _allAI.length, planificadas = 0, ejecucion = 0, completadas = 0, ncAbiertas = 0
  _allAI.forEach(ai => {
    if (ai.status === 'planificada')    planificadas++
    else if (ai.status === 'en_ejecucion') ejecucion++
    else if (ai.status === 'completada')   completadas++
    ;(ai.findings || []).forEach(f => {
      if ((f.type === 'nc_mayor' || f.type === 'nc_menor') && f.status !== 'cerrado') ncAbiertas++
    })
  })
  setText('kpi-total', total); setText('kpi-planificadas', planificadas)
  setText('kpi-ejecucion', ejecucion); setText('kpi-completadas', completadas)
  setText('kpi-nc', ncAbiertas)
}

// ── Filters ──────────────────────────────────────────────────────
function applyFilters() {
  const q      = (document.getElementById('search-input')?.value || '').toLowerCase()
  const type   = document.getElementById('f-type')?.value   || ''
  const status = document.getElementById('f-status')?.value || ''
  const filtered = _allAI.filter(ai => {
    const txt = `${ai.audit_number||''} ${ai.coordinator||''} ${ai.scope||''}`.toLowerCase()
    return (!q || txt.includes(q)) && (!type || ai.audit_type === type) && (!status || ai.status === status)
  })
  renderTable(filtered)
}

// ── Render Table ─────────────────────────────────────────────────
function renderTable(list) {
  const tbody = document.getElementById('ai-tbody')
  const count = document.getElementById('ai-count')
  if (count) count.textContent = `${list.length} auditoría${list.length !== 1 ? 's' : ''}`
  if (!tbody) return

  if (list.length === 0) {
    tbody.innerHTML = `<tr><td colspan="8" class="table-empty">
      <i class="fa-solid fa-magnifying-glass" style="font-size:1.5rem;display:block;margin-bottom:8px"></i>
      <strong>Sin auditorías registradas</strong><br>
      Usa "Nueva Auditoría" para crear el primer expediente.
    </td></tr>`
    return
  }

  tbody.innerHTML = list.map(ai => {
    const findings  = ai.findings || []
    const ncMayor   = findings.filter(f => f.type === 'nc_mayor').length
    const ncMenor   = findings.filter(f => f.type === 'nc_menor').length
    const obs       = findings.filter(f => f.type === 'observacion').length
    const op        = findings.filter(f => f.type === 'oportunidad').length
    const pf        = findings.filter(f => f.type === 'punto_fuerte').length
    const badges = [
      ncMayor ? `<span class="ftag nc_mayor">${ncMayor} NC Mayor</span>` : '',
      ncMenor ? `<span class="ftag nc_menor">${ncMenor} NC Menor</span>` : '',
      obs     ? `<span class="ftag observacion">${obs} Obs.</span>` : '',
      op      ? `<span class="ftag oportunidad">${op} Oport.</span>` : '',
      pf      ? `<span class="ftag punto_fuerte">${pf} PF</span>` : '',
    ].filter(Boolean).join('')

    return `<tr>
      <td><span class="ai-number">${esc(ai.audit_number || '—')}</span></td>
      <td>
        <div class="ai-body">${esc(ai.coordinator || '—')}</div>
        <div class="ai-type">${typeLabel(ai.audit_type)}</div>
      </td>
      <td><span class="ai-scope" title="${esc(ai.scope||'')}">${esc(ai.scope || '—')}</span></td>
      <td class="center" style="font-size:.857rem;white-space:nowrap">
        ${fmtDate(ai.audit_date_start)}${ai.audit_date_end && ai.audit_date_end !== ai.audit_date_start
          ? '<br><span style="color:var(--txt3)">→ '+fmtDate(ai.audit_date_end)+'</span>' : ''}
      </td>
      <td class="center"><div class="findings-mini">${badges || '<span style="font-size:.75rem;color:var(--txt3)">—</span>'}</div></td>
      <td class="center"><span class="pill pill-${ai.status||'planificada'}">${statusLabel(ai.status)}</span></td>
      <td class="center">${resultBadge(ai.audit_result)}</td>
      <td class="center">
        <div class="action-btns">
          <button onclick="openDetail('${ai.id}')" class="btn-action" title="Abrir expediente">
            <i class="fa-solid fa-folder-open"></i>
          </button>
        </div>
      </td>
    </tr>`
  }).join('')
}

// ── Modal: Nueva ──────────────────────────────────────────────────
function openNewAI() {
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)
  if (!canWrite) return
  const year = new Date().getFullYear()
  const prefix = `AI-${year}-`
  let max = 0
  _allAI.forEach(ai => {
    const n = (ai.audit_number || '')
    if (n.toUpperCase().startsWith(prefix)) {
      const v = parseInt(n.slice(prefix.length), 10) || 0
      if (v > max) max = v
    }
  })
  setVal('new-number',       `AI-${year}-${(max+1).toString().padStart(3,'0')}`)
  setVal('new-type',         'programada')
  setVal('new-coordinator',  '')
  setVal('new-date-start',   new Date().toISOString().split('T')[0])
  setVal('new-date-end',     '')
  setVal('new-lead-auditor', '')
  openModal('modal-new')
}

async function submitNewAI() {
  const btn         = document.getElementById('btn-save-new')
  const num         = document.getElementById('new-number')?.value.trim()
  const type        = document.getElementById('new-type')?.value
  const coordinator = document.getElementById('new-coordinator')?.value.trim()
  const ds          = document.getElementById('new-date-start')?.value
  const de          = document.getElementById('new-date-end')?.value
  const lead        = document.getElementById('new-lead-auditor')?.value.trim()

  if (!num)         { showToast('Indica el número de auditoría.','red'); return }
  if (!coordinator) { showToast('Indica el responsable / coordinador.','red'); return }
  if (!ds)          { showToast('Indica la fecha de inicio.','red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Creando…'

  const { error } = await db.rpc('save_auditoria_interna', {
    p_row: {
      audit_number: num, audit_type: type, coordinator,
      audit_date_start: ds, audit_date_end: de || null, lead_auditor: lead || null,
      status: 'planificada', team: [], areas: [], findings: [],
      checklist: [], evaluaciones: [], actuaciones: [], reunion_final: {},
      created_by: _user.id
    }
  })
  if (error) {
    showToast('Error: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Crear Expediente')
    return
  }
  showToast('Expediente de auditoría creado.','green')
  closeModal('modal-new')
  resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Crear Expediente')
  await loadAI()
}

// ── Modal: Detalle ────────────────────────────────────────────────
async function openDetail(id) {
  _currentAI = _allAI.find(a => a.id === id)
  if (!_currentAI) return
  const ai = _currentAI

  setText('detail-number',   ai.audit_number || '—')
  setText('detail-subtitle', `${typeLabel(ai.audit_type)} · ${esc(ai.coordinator || '—')}`)
  setText('d-number',        ai.audit_number || '—')
  setText('d-type-lbl',      typeLabel(ai.audit_type))
  setText('d-coordinator-lbl', ai.coordinator || '—')
  setText('d-created-by',    ai.created_by_name || '—')

  setVal('d-status',       ai.status || 'planificada')
  setVal('d-coordinator',  ai.coordinator || '')
  setVal('d-date-start',   ai.audit_date_start || '')
  setVal('d-date-end',     ai.audit_date_end || '')
  setVal('d-scope',        ai.scope || '')
  setVal('d-lead-auditor', ai.lead_auditor || '')
  setVal('d-audit-result', ai.audit_result || '')
  setVal('d-next-audit',   ai.next_audit_date || '')
  setVal('d-conclusion',   ai.conclusion || '')

  _editTeam      = JSON.parse(JSON.stringify(ai.team      || []))
  _editAreas     = JSON.parse(JSON.stringify(ai.areas     || []))
  _editFindings  = JSON.parse(JSON.stringify(ai.findings  || []))
  _editChecklist = JSON.parse(JSON.stringify(ai.checklist || []))
  _editEvals     = JSON.parse(JSON.stringify(ai.evaluaciones || []))
  _editActs      = JSON.parse(JSON.stringify(ai.actuaciones  || []))
  _reunionFinal  = JSON.parse(JSON.stringify(ai.reunion_final || {}))

  // Cargar campos de reunión final
  setVal('rf-fecha-compromiso',  _reunionFinal.fecha_compromiso || '')
  setVal('rf-puntos-fuertes',    _reunionFinal.puntos_fuertes   || '')
  setVal('rf-potencial-mejora',  _reunionFinal.potencial_mejora || '')
  setVal('rf-quejas',            _reunionFinal.quejas           || '')
  setVal('rf-auditorias-previas',_reunionFinal.auditorias_previas || '')
  setVal('rf-revision-sistema',  _reunionFinal.revision_sistema || '')

  // Campo auditado en verificación
  setVal('chk-auditado', _reunionFinal.auditado || '')

  // Modos de edición siempre en vista al abrir
  _findingsEditMode  = false
  _checklistEditMode = false
  const btnFE = document.getElementById('btn-findings-edit')
  if (btnFE) { btnFE.innerHTML = '<i class="fa-solid fa-pen"></i> Editar'; btnFE.classList.remove('editing') }
  const btnCE = document.getElementById('btn-chk-edit')
  if (btnCE) { btnCE.innerHTML = '<i class="fa-solid fa-pen"></i> Editar'; btnCE.classList.remove('editing') }
  const fActions = document.getElementById('findings-actions')
  if (fActions) fActions.style.display = 'none'
  const cActions = document.getElementById('checklist-actions')
  if (cActions) cActions.style.display = 'none'

  // Permisos
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)
  const btnFEv = document.getElementById('btn-findings-edit')
  if (btnFEv) btnFEv.style.display = canWrite ? 'inline-flex' : 'none'
  const btnCEv = document.getElementById('btn-chk-edit')
  if (btnCEv) btnCEv.style.display = canWrite ? 'inline-flex' : 'none'
  const btnAEv = document.getElementById('btn-add-eval')
  if (btnAEv) btnAEv.style.display = canWrite ? 'inline-flex' : 'none'
  const evalSave = document.getElementById('eval-save-row')
  if (evalSave) evalSave.style.display = canWrite ? 'block' : 'none'
  const actsToolbar = document.getElementById('acts-toolbar')
  if (actsToolbar) actsToolbar.style.display = canWrite ? 'flex' : 'none'
  const actsThDel = document.getElementById('acts-th-del')
  if (actsThDel) actsThDel.style.display = canWrite ? '' : 'none'

  renderTeam()
  renderAreas()
  renderFindings()
  renderFindingsSummary()
  renderChecklist()
  updateChecklistBadge()
  renderEvaluaciones()
  renderActuaciones()
  renderNCSummary()
  renderReportFile()
  renderMeetingFile()
  renderReportUploadBtn()
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

async function savePlan() {
  if (!_currentAI) return
  const ai = _currentAI
  const payload = buildPayload(ai, {
    coordinator:      document.getElementById('d-coordinator')?.value.trim(),
    audit_date_start: document.getElementById('d-date-start')?.value || null,
    audit_date_end:   document.getElementById('d-date-end')?.value   || null,
    scope:            document.getElementById('d-scope')?.value.trim(),
    lead_auditor:     document.getElementById('d-lead-auditor')?.value.trim(),
    status:           document.getElementById('d-status')?.value,
    team:  _editTeam.filter(m => m.trim()),
    areas: _editAreas.filter(a => a.trim()),
  })
  const { error } = await db.rpc('save_auditoria_interna', { p_row: payload })
  if (error) { showToast('Error: ' + error.message,'red'); return }
  Object.assign(_currentAI, {
    coordinator: payload.coordinator, audit_date_start: payload.audit_date_start,
    audit_date_end: payload.audit_date_end, scope: payload.scope,
    lead_auditor: payload.lead_auditor, status: payload.status,
    team: payload.team, areas: payload.areas
  })
  syncToList()
  showToast('Plan guardado correctamente.','green')
  renderKPIs(); applyFilters()
}

// ── Verificación (FT-CA-15) ───────────────────────────────────────
function renderChecklist() {
  const el = document.getElementById('checklist-list')
  if (!el) return
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)

  if (_editChecklist.length === 0) {
    el.innerHTML = `<div class="no-findings">
      <i class="fa-solid fa-clipboard-list"></i>
      Sin criterios de verificación registrados.
      ${canWrite ? '<br><span style="font-size:.857rem">Usa "Editar" para agregar los criterios cláusula por cláusula.</span>' : ''}
    </div>`
    return
  }

  if (!_checklistEditMode) {
    // Vista de solo lectura — tabla limpia
    const fLabel = { obs:'Observación', menor:'NC Menor', mayor:'NC Mayor', om:'Oport. Mejora' }
    const fCls   = { obs:'observacion', menor:'nc_menor', mayor:'nc_mayor', om:'oportunidad' }
    el.innerHTML = `<table class="data-table" style="font-size:.857rem">
      <thead><tr>
        <th class="center" style="width:36px">#</th>
        <th class="center" style="width:90px">Cláusula</th>
        <th>Requisito / Criterio</th>
        <th class="center" style="width:72px">Cumple</th>
        <th class="center" style="width:130px">Hallazgo</th>
        <th>Descripción</th>
      </tr></thead>
      <tbody>
        ${_editChecklist.map((item, i) => {
          const cumpleCls = item.cumple === 'si' ? 'chk-si' : item.cumple === 'no' ? 'chk-no' : 'chk-na'
          const cumpleLbl = item.cumple === 'si' ? 'SI' : item.cumple === 'no' ? 'NO' : '—'
          return `<tr>
            <td class="center" style="color:var(--txt3)">${i+1}</td>
            <td class="center"><span class="chk-clause-badge">${esc(item.clause||'—')}</span></td>
            <td>${esc(item.requirement||'—')}</td>
            <td class="center"><span class="chk-badge chk-badge-${cumpleCls}">${cumpleLbl}</span></td>
            <td class="center">
              ${item.cumple === 'no' && item.finding_type
                ? `<span class="ftag ${fCls[item.finding_type]||'observacion'}">${fLabel[item.finding_type]||'—'}</span>`
                : '<span style="color:var(--txt3);font-size:.75rem">—</span>'}
            </td>
            <td style="font-size:.786rem">${esc(item.description||'—')}</td>
          </tr>`
        }).join('')}
      </tbody>
    </table>`
    return
  }

  // Modo edición
  el.innerHTML = `<table class="data-table" style="font-size:.8rem">
    <thead><tr>
      <th class="center" style="width:36px">#</th>
      <th style="width:90px">Cláusula</th>
      <th>Requisito / Criterio</th>
      <th class="center" style="width:110px">Cumple</th>
      <th style="width:130px">Tipo hallazgo</th>
      <th>Descripción del hallazgo</th>
      <th style="width:36px"></th>
    </tr></thead>
    <tbody>
      ${_editChecklist.map((item, i) => `
      <tr>
        <td class="center" style="color:var(--txt3)">${i+1}</td>
        <td><input type="text" value="${esc(item.clause||'')}" style="width:78px;font-size:.8rem"
          oninput="_editChecklist[${i}].clause=this.value" placeholder="4.1"></td>
        <td><input type="text" value="${esc(item.requirement||'')}" style="font-size:.8rem"
          oninput="_editChecklist[${i}].requirement=this.value" placeholder="Requisito auditado…"></td>
        <td class="center">
          <div class="chk-toggle">
            <button class="chk-btn ${item.cumple==='si'?'chk-si-active':''}"
              onclick="_editChecklist[${i}].cumple='si';renderChecklist()">SI</button>
            <button class="chk-btn ${item.cumple==='no'?'chk-no-active':''}"
              onclick="_editChecklist[${i}].cumple='no';renderChecklist()">NO</button>
            <button class="chk-btn ${!item.cumple?'chk-na-active':''}"
              onclick="_editChecklist[${i}].cumple=null;renderChecklist()">N/A</button>
          </div>
        </td>
        <td>
          <select style="width:120px;font-size:.8rem"
            onchange="_editChecklist[${i}].finding_type=this.value||null"
            ${item.cumple!=='no'?'disabled':''}>
            <option value="" ${!item.finding_type?'selected':''}>—</option>
            <option value="obs"   ${item.finding_type==='obs'?'selected':''}>Observación</option>
            <option value="menor" ${item.finding_type==='menor'?'selected':''}>NC Menor</option>
            <option value="mayor" ${item.finding_type==='mayor'?'selected':''}>NC Mayor</option>
            <option value="om"    ${item.finding_type==='om'?'selected':''}>Oport. Mejora</option>
          </select>
        </td>
        <td><textarea rows="1" style="width:100%;min-height:34px;resize:vertical;font-size:.8rem"
          oninput="_editChecklist[${i}].description=this.value"
          placeholder="Describir el hallazgo…">${esc(item.description||'')}</textarea></td>
        <td><button class="btn-remove" onclick="removeChecklistRow(${i})">
          <i class="fa-solid fa-xmark"></i></button></td>
      </tr>`).join('')}
    </tbody>
  </table>`
}

function addChecklistRow() {
  _editChecklist.push({ clause:'', requirement:'', cumple: null, finding_type: null, description:'' })
  renderChecklist()
  updateChecklistBadge()
  document.getElementById('checklist-list')?.querySelector('tbody')?.lastElementChild?.querySelector('input')?.focus()
}
function removeChecklistRow(i) {
  _editChecklist.splice(i, 1)
  renderChecklist()
  updateChecklistBadge()
}
function toggleChecklistEdit() {
  _checklistEditMode = !_checklistEditMode
  const btn = document.getElementById('btn-chk-edit')
  if (btn) {
    if (_checklistEditMode) { btn.innerHTML = '<i class="fa-solid fa-eye"></i> Ver'; btn.classList.add('editing') }
    else { btn.innerHTML = '<i class="fa-solid fa-pen"></i> Editar'; btn.classList.remove('editing') }
  }
  const actions = document.getElementById('checklist-actions')
  if (actions) actions.style.display = _checklistEditMode ? 'flex' : 'none'
  renderChecklist()
}
async function saveChecklist() {
  if (!_currentAI) return
  // Guardar también el campo "auditado" dentro de reunion_final
  const auditado = document.getElementById('chk-auditado')?.value.trim() || ''
  const rf = JSON.parse(JSON.stringify(_reunionFinal))
  rf.auditado = auditado

  const payload = buildPayload(_currentAI, { checklist: _editChecklist, reunion_final: rf })
  const { error } = await db.rpc('save_auditoria_interna', { p_row: payload })
  if (error) { showToast('Error: ' + error.message,'red'); return }
  _currentAI.checklist = JSON.parse(JSON.stringify(_editChecklist))
  _currentAI.reunion_final = rf
  _reunionFinal = rf
  syncToList()
  updateChecklistBadge()
  showToast('Lista de verificación guardada.','green')
}
function updateChecklistBadge() {
  const badge = document.getElementById('tab-chk-count')
  if (badge) {
    const n = _editChecklist.length
    badge.textContent = n
    badge.style.display = n ? 'inline-block' : 'none'
  }
}

// ── Hallazgos ──────────────────────────────────────────────────────
function renderFindings() {
  const el = document.getElementById('findings-list')
  if (!el) return
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)

  if (_editFindings.length === 0) {
    el.innerHTML = `<div class="no-findings">
      <i class="fa-solid fa-flag"></i> Sin hallazgos registrados aún.
      ${canWrite ? 'Usa "Editar" para registrar los hallazgos.' : ''}
    </div>`
    return
  }

  if (!_findingsEditMode) {
    const typeConf = {
      nc_mayor:    { label:'NC Mayor',             cls:'fv-nc-mayor', icon:'fa-circle-xmark' },
      nc_menor:    { label:'NC Menor',             cls:'fv-nc-menor', icon:'fa-triangle-exclamation' },
      observacion: { label:'Observación',           cls:'fv-obs',      icon:'fa-eye' },
      oportunidad: { label:'Oportunidad de Mejora', cls:'fv-oport',    icon:'fa-lightbulb' },
      punto_fuerte:{ label:'Punto Fuerte',          cls:'fv-pf',       icon:'fa-star' },
    }
    const stConf = {
      abierto:    { label:'Abierto',    cls:'fvst-abierto' },
      en_proceso: { label:'En Proceso', cls:'fvst-proceso' },
      cerrado:    { label:'Cerrado',    cls:'fvst-cerrado' },
    }
    el.innerHTML = _editFindings.map((f, i) => {
      const tc = typeConf[f.type] || typeConf.observacion
      const sc = stConf[f.status]  || stConf.abierto
      return `<div class="fv-card ${tc.cls}">
        <div class="fv-header">
          <span class="fv-num">#${String(i+1).padStart(2,'0')}</span>
          <span class="fv-type-badge ${tc.cls}"><i class="fa-solid ${tc.icon}"></i> ${tc.label}</span>
          ${f.clause  ? `<span class="fv-pill fv-clause-pill"><i class="fa-solid fa-hashtag" style="font-size:9px"></i> Cláusula ${esc(f.clause)}</span>` : ''}
          ${f.process ? `<span class="fv-pill fv-process-pill"><i class="fa-solid fa-sitemap" style="font-size:9px"></i> ${esc(f.process)}</span>` : ''}
          <span style="flex:1"></span>
          <span class="fv-status-badge ${sc.cls}">${sc.label}</span>
        </div>
        <div class="fv-body">
          ${f.description ? `<div class="fv-section"><div class="fv-label"><i class="fa-solid fa-align-left"></i> Descripción</div><div class="fv-text">${esc(f.description)}</div></div>` : ''}
          ${f.evidence   ? `<div class="fv-section"><div class="fv-label"><i class="fa-solid fa-paperclip"></i> Evidencia Objetiva</div><div class="fv-text fv-text-ev">${esc(f.evidence)}</div></div>` : ''}
        </div>
      </div>`
    }).join('')
    return
  }

  el.innerHTML = _editFindings.map((f, i) => `
    <div class="finding-card type-${f.type||'observacion'}" id="fcard-${i}">
      <div class="finding-header">
        <select class="finding-type-sel" onchange="onFindingTypeChange(${i},this.value)" ${canWrite?'':'disabled'}>
          <option value="nc_mayor"    ${f.type==='nc_mayor'    ?'selected':''}>🔴 NC Mayor</option>
          <option value="nc_menor"    ${f.type==='nc_menor'    ?'selected':''}>🟡 NC Menor</option>
          <option value="observacion" ${f.type==='observacion' ?'selected':''}>🔵 Observación</option>
          <option value="oportunidad" ${f.type==='oportunidad' ?'selected':''}>💡 Oportunidad de Mejora</option>
          <option value="punto_fuerte"${f.type==='punto_fuerte'?'selected':''}>✅ Punto Fuerte</option>
        </select>
        <input class="finding-clause" type="text" value="${esc(f.clause||'')}"
          oninput="_editFindings[${i}].clause=this.value" placeholder="Cláusula" ${canWrite?'':'readonly'}>
        <input class="finding-process" type="text" value="${esc(f.process||'')}"
          oninput="_editFindings[${i}].process=this.value" placeholder="Proceso / Área" ${canWrite?'':'readonly'}>
        <select class="finding-status-sel" onchange="_editFindings[${i}].status=this.value" ${canWrite?'':'disabled'}>
          <option value="abierto"    ${f.status==='abierto'    ?'selected':''}>Abierto</option>
          <option value="en_proceso" ${f.status==='en_proceso' ?'selected':''}>En Proceso</option>
          <option value="cerrado"    ${f.status==='cerrado'    ?'selected':''}>Cerrado</option>
        </select>
        ${canWrite ? `<button class="btn-remove" onclick="removeFinding(${i})"><i class="fa-solid fa-trash-can"></i></button>` : ''}
      </div>
      <div class="finding-body">
        <div>
          <div class="finding-label">Descripción del Hallazgo</div>
          <textarea rows="3" oninput="_editFindings[${i}].description=this.value"
            placeholder="Describe detalladamente el hallazgo…" ${canWrite?'':'readonly'}>${esc(f.description||'')}</textarea>
        </div>
        <div>
          <div class="finding-label">Evidencia Objetiva</div>
          <textarea rows="2" oninput="_editFindings[${i}].evidence=this.value"
            placeholder="Registros, documentos u observaciones que sustentan el hallazgo…" ${canWrite?'':'readonly'}>${esc(f.evidence||'')}</textarea>
        </div>
      </div>
    </div>`).join('')
}

function onFindingTypeChange(idx, type) {
  _editFindings[idx].type = type
  const card = document.getElementById(`fcard-${idx}`)
  if (card) card.className = `finding-card type-${type}`
  renderFindingsSummary()
}
function addFinding() {
  if (!_findingsEditMode) {
    _findingsEditMode = true
    const btn = document.getElementById('btn-findings-edit')
    if (btn) { btn.innerHTML = '<i class="fa-solid fa-eye"></i> Ver hallazgos'; btn.classList.add('editing') }
    const actions = document.getElementById('findings-actions')
    if (actions) actions.style.display = 'flex'
  }
  _editFindings.push({ type:'observacion', clause:'', process:'', description:'', evidence:'', status:'abierto' })
  renderFindings(); renderFindingsSummary(); updateFindingsBadge()
  document.getElementById('findings-list')?.lastElementChild?.scrollIntoView({ behavior:'smooth', block:'nearest' })
}
function removeFinding(idx) {
  _editFindings.splice(idx, 1)
  renderFindings(); renderFindingsSummary(); updateFindingsBadge()
}
async function saveFindings() {
  if (!_currentAI) return
  const payload = buildPayload(_currentAI, { findings: _editFindings })
  const { error } = await db.rpc('save_auditoria_interna', { p_row: payload })
  if (error) { showToast('Error: ' + error.message,'red'); return }
  _currentAI.findings = JSON.parse(JSON.stringify(_editFindings))
  syncToList()
  renderFindingsSummary(); updateFindingsBadge(); renderNCSummary()
  renderKPIs(); applyFilters()
  showToast('Hallazgos guardados.','green')
}
function renderFindingsSummary() {
  const el = document.getElementById('findings-summary')
  if (!el) return
  const counts = { nc_mayor:0, nc_menor:0, observacion:0, oportunidad:0, punto_fuerte:0 }
  _editFindings.forEach(f => { if (f.type in counts) counts[f.type]++ })
  const chips = [
    counts.nc_mayor    ? `<span class="fs-chip fs-nc-mayor"><i class="fa-solid fa-circle-xmark"></i> ${counts.nc_mayor} NC Mayor</span>` : '',
    counts.nc_menor    ? `<span class="fs-chip fs-nc-menor"><i class="fa-solid fa-triangle-exclamation"></i> ${counts.nc_menor} NC Menor</span>` : '',
    counts.observacion ? `<span class="fs-chip fs-obs"><i class="fa-solid fa-eye"></i> ${counts.observacion} Observación</span>` : '',
    counts.oportunidad ? `<span class="fs-chip fs-op"><i class="fa-solid fa-lightbulb"></i> ${counts.oportunidad} Oportunidad</span>` : '',
    counts.punto_fuerte? `<span class="fs-chip fs-pf"><i class="fa-solid fa-star"></i> ${counts.punto_fuerte} Punto Fuerte</span>` : '',
  ].filter(Boolean)
  el.innerHTML = chips.length ? chips.join('') : '<span style="font-size:.786rem;color:var(--txt3)">Sin hallazgos registrados aún.</span>'
}
function updateFindingsBadge() {
  const badge = document.getElementById('tab-findings-count')
  if (badge) { const n = _editFindings.length; badge.textContent = n; badge.style.display = n ? 'inline-block' : 'none' }
}
function toggleFindingsEdit() {
  _findingsEditMode = !_findingsEditMode
  const btn = document.getElementById('btn-findings-edit')
  if (btn) {
    if (_findingsEditMode) { btn.innerHTML = '<i class="fa-solid fa-eye"></i> Ver hallazgos'; btn.classList.add('editing') }
    else { btn.innerHTML = '<i class="fa-solid fa-pen"></i> Editar'; btn.classList.remove('editing') }
  }
  const actions = document.getElementById('findings-actions')
  if (actions) actions.style.display = _findingsEditMode ? 'flex' : 'none'
  renderFindings()
}

// ── Evaluaciones (FT-CA-26) ────────────────────────────────────────
const TRAINING_TOPICS = [
  { key:'iso9001',   label:'Conocimiento de la Norma ISO 9001 versión vigente' },
  { key:'sgc_hsm',   label:'Conocimiento del SGC del Hospital Santa Margarita' },
  { key:'iso19011',  label:'Curso de Auditor Interno ISO 19011 versión vigente' },
  { key:'otros',     label:'Otros cursos' },
]
const ATTITUDE_CRITERIA = [
  { key:'horario',   label:'Cumplimiento del horario conforme al plan de auditoría' },
  { key:'preguntas', label:'Claridad de las preguntas durante la entrevista' },
  { key:'respeto',   label:'Respeto en el trato con los auditados' },
  { key:'manejo',    label:'Manejo de la Norma ISO 9001 durante la auditoría' },
  { key:'claridad',  label:'Claridad en la explicación de hallazgos y conclusiones' },
]
const SCALE  = ['e','mb','b','r','m']
const SCALE_L = { e:'E', mb:'MB', b:'B', r:'R', m:'M' }
const SCALE_T = { e:'Excelente', mb:'Muy Bien', b:'Bien', r:'Regular', m:'Mal' }
const SCALE_C = { e:'#16a34a', mb:'#2563eb', b:'#0891b2', r:'#d97706', m:'#dc2626' }

function renderEvaluaciones() {
  const el = document.getElementById('evaluaciones-list')
  if (!el) return
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)

  if (_editEvals.length === 0) {
    el.innerHTML = `<div class="no-findings">
      <i class="fa-solid fa-user-slash"></i>
      Sin evaluaciones de auditor registradas.
      ${canWrite ? '<br><span style="font-size:.857rem">Agrega una evaluación por cada miembro del equipo auditor.</span>' : ''}
    </div>`
    return
  }

  el.innerHTML = _editEvals.map((ev, i) => {
    const training = ev.training || TRAINING_TOPICS.map(t => ({ key: t.key, provider:'', date:'' }))
    const attitude = ev.attitude || {}

    const trainingRows = TRAINING_TOPICS.map((t, ti) => {
      const row = training.find(r => r.key === t.key) || { provider:'', date:'' }
      return `<tr>
        <td style="font-size:.8rem">${esc(t.label)}</td>
        <td><input type="text" value="${esc(row.provider||'')}" placeholder="Proveedor"
          style="width:100%;font-size:.8rem"
          oninput="setEvalTraining(${i},'${t.key}','provider',this.value)"
          ${canWrite?'':'readonly'}></td>
        <td><input type="date" value="${esc(row.date||'')}" style="font-size:.8rem"
          oninput="setEvalTraining(${i},'${t.key}','date',this.value)"
          ${canWrite?'':'readonly'}></td>
      </tr>`
    }).join('')

    const attitudeCols = ATTITUDE_CRITERIA.map(a => {
      const current = attitude[a.key] || null
      const btns = SCALE.map(s => {
        const active = current === s
        return `<button class="scale-btn ${active ? 'scale-active' : ''}"
          style="${active ? `background:${SCALE_C[s]};color:#fff;border-color:${SCALE_C[s]}` : ''}"
          title="${SCALE_T[s]}"
          onclick="setEvalAttitude(${i},'${a.key}','${s}')"
          ${canWrite?'':'disabled'}>${SCALE_L[s]}</button>`
      }).join('')
      return `<tr>
        <td style="font-size:.8rem">${esc(a.label)}</td>
        <td><div class="scale-group">${btns}</div></td>
      </tr>`
    }).join('')

    const qualOpts = [
      { v:'en_entrenamiento', l:'Auditor en Entrenamiento' },
      { v:'auditor_interno',  l:'Auditor Interno' },
      { v:'auditor_lider',    l:'Auditor Líder' },
    ]

    return `<div class="eval-card">
      <div class="eval-card-header">
        <i class="fa-solid fa-user-tie" style="color:#4f46e5"></i>
        <strong>${esc(ev.name || 'Auditor ' + (i+1))}</strong>
        ${canWrite ? `<button class="btn-remove" style="margin-left:auto" onclick="_editEvals.splice(${i},1);renderEvaluaciones()">
          <i class="fa-solid fa-trash-can"></i></button>` : ''}
      </div>
      <div class="eval-section">
        <div class="eval-section-title">1. Datos Generales</div>
        <div class="form-row">
          <div class="field">
            <label>Nombre completo</label>
            <input type="text" value="${esc(ev.name||'')}" placeholder="Nombre del auditor"
              oninput="_editEvals[${i}].name=this.value" ${canWrite?'':'readonly'}>
          </div>
          <div class="field">
            <label>Número de empleado</label>
            <input type="text" value="${esc(ev.employee_number||'')}" placeholder="N° empleado"
              oninput="_editEvals[${i}].employee_number=this.value" ${canWrite?'':'readonly'}>
          </div>
        </div>
      </div>
      <div class="eval-section">
        <div class="eval-section-title">2. Entrenamiento</div>
        <table class="data-table" style="font-size:.857rem">
          <thead><tr><th>Curso</th><th style="width:180px">Nombre del proveedor</th><th style="width:130px">Fecha del curso</th></tr></thead>
          <tbody>${trainingRows}</tbody>
        </table>
      </div>
      <div class="eval-section">
        <div class="eval-section-title">3. Evaluación de Actitud y Aptitud <span style="font-size:.75rem;color:var(--txt3)">(E) Excelente · (MB) Muy Bien · (B) Bien · (R) Regular · (M) Mal</span></div>
        <table class="data-table" style="font-size:.857rem">
          <thead><tr><th>Criterio</th><th style="width:200px">Calificación</th></tr></thead>
          <tbody>${attitudeCols}</tbody>
        </table>
      </div>
      <div class="eval-section">
        <div class="eval-section-title">4. Experiencia y Habilidades</div>
        <div class="form-row">
          <div class="field">
            <label>Cantidad de auditorías previas</label>
            <input type="number" min="0" value="${ev.prev_audits||0}"
              oninput="_editEvals[${i}].prev_audits=parseInt(this.value)||0"
              style="width:100px" ${canWrite?'':'readonly'}>
          </div>
          <div class="field">
            <label>Está calificado como</label>
            <select onchange="_editEvals[${i}].qualification=this.value" ${canWrite?'':'disabled'}>
              ${qualOpts.map(o => `<option value="${o.v}" ${ev.qualification===o.v?'selected':''}>${o.l}</option>`).join('')}
            </select>
          </div>
        </div>
      </div>
      <div class="eval-section">
        <div class="eval-section-title">Resultado Final</div>
        <div class="eval-result-row">
          <label class="eval-result-opt ${ev.result==='competente'?'eval-result-ok':''}">
            <input type="radio" name="result-${i}" value="competente"
              ${ev.result==='competente'?'checked':''} ${canWrite?'':'disabled'}
              onchange="_editEvals[${i}].result='competente';renderEvaluaciones()">
            <i class="fa-solid fa-circle-check"></i> COMPETENTE
          </label>
          <label class="eval-result-opt ${ev.result==='no_competente'?'eval-result-fail':''}">
            <input type="radio" name="result-${i}" value="no_competente"
              ${ev.result==='no_competente'?'checked':''} ${canWrite?'':'disabled'}
              onchange="_editEvals[${i}].result='no_competente';renderEvaluaciones()">
            <i class="fa-solid fa-circle-xmark"></i> NO COMPETENTE
          </label>
        </div>
        <div class="field" style="margin-top:10px">
          <label>Observaciones</label>
          <textarea rows="2" placeholder="Observaciones adicionales…"
            oninput="_editEvals[${i}].observations=this.value"
            ${canWrite?'':'readonly'}>${esc(ev.observations||'')}</textarea>
        </div>
      </div>
    </div>`
  }).join('')
}

function setEvalTraining(evalIdx, topicKey, field, value) {
  if (!_editEvals[evalIdx].training) {
    _editEvals[evalIdx].training = TRAINING_TOPICS.map(t => ({ key: t.key, provider:'', date:'' }))
  }
  const row = _editEvals[evalIdx].training.find(r => r.key === topicKey)
  if (row) row[field] = value
  else _editEvals[evalIdx].training.push({ key: topicKey, [field]: value })
}
function setEvalAttitude(evalIdx, criterionKey, value) {
  if (!_editEvals[evalIdx].attitude) _editEvals[evalIdx].attitude = {}
  _editEvals[evalIdx].attitude[criterionKey] = value
  renderEvaluaciones()
}
function addEvaluacion() {
  _editEvals.push({
    name:'', employee_number:'',
    training: TRAINING_TOPICS.map(t => ({ key: t.key, provider:'', date:'' })),
    attitude: {}, prev_audits: 0, qualification: 'auditor_interno',
    result: 'competente', observations: ''
  })
  renderEvaluaciones()
}
async function saveEvaluaciones() {
  if (!_currentAI) return
  const payload = buildPayload(_currentAI, { evaluaciones: _editEvals })
  const { error } = await db.rpc('save_auditoria_interna', { p_row: payload })
  if (error) { showToast('Error: ' + error.message,'red'); return }
  _currentAI.evaluaciones = JSON.parse(JSON.stringify(_editEvals))
  syncToList()
  showToast('Evaluaciones guardadas.','green')
}

// ── Actuaciones (Informe) ──────────────────────────────────────────
function renderActuaciones() {
  const tbody = document.getElementById('acts-tbody')
  if (!tbody) return
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)

  if (_editActs.length === 0) {
    tbody.innerHTML = `<tr><td colspan="${canWrite?6:5}" style="text-align:center;color:var(--txt3);font-size:.857rem;padding:12px">
      Sin actividades registradas. ${canWrite ? 'Usa "Agregar actividad" para registrar el cronograma de la auditoría.' : ''}
    </td></tr>`
    return
  }

  tbody.innerHTML = _editActs.map((a, i) => `
    <tr>
      <td><input type="date" value="${esc(a.fecha||'')}" style="font-size:.8rem"
        oninput="_editActs[${i}].fecha=this.value" ${canWrite?'':'readonly'}></td>
      <td><input type="time" value="${esc(a.hora||'')}" style="font-size:.8rem;width:72px"
        oninput="_editActs[${i}].hora=this.value" ${canWrite?'':'readonly'}></td>
      <td><input type="text" value="${esc(a.equipo||'')}" placeholder="Nombre del auditor"
        style="font-size:.8rem" oninput="_editActs[${i}].equipo=this.value" ${canWrite?'':'readonly'}></td>
      <td><input type="text" value="${esc(a.area||'')}" placeholder="Área o proceso"
        style="font-size:.8rem" oninput="_editActs[${i}].area=this.value" ${canWrite?'':'readonly'}></td>
      <td><input type="text" value="${esc(a.requisito||'')}" placeholder="Ej. 7.1"
        style="font-size:.8rem;width:90px" oninput="_editActs[${i}].requisito=this.value" ${canWrite?'':'readonly'}></td>
      ${canWrite ? `<td><button class="btn-remove" onclick="removeActuacion(${i})">
        <i class="fa-solid fa-xmark"></i></button></td>` : ''}
    </tr>`).join('')
}
function addActuacion() {
  _editActs.push({ fecha:'', hora:'', equipo:'', area:'', requisito:'' })
  renderActuaciones()
}
function removeActuacion(i) {
  _editActs.splice(i, 1)
  renderActuaciones()
}
async function saveActuaciones() {
  if (!_currentAI) return
  const payload = buildPayload(_currentAI, { actuaciones: _editActs })
  const { error } = await db.rpc('save_auditoria_interna', { p_row: payload })
  if (error) { showToast('Error: ' + error.message,'red'); return }
  _currentAI.actuaciones = JSON.parse(JSON.stringify(_editActs))
  syncToList()
  showToast('Actuaciones guardadas.','green')
}

// ── NC Resumen por cláusula ISO 9001:2015 ─────────────────────────
const ISO_CLAUSES = [
  { num:'4', title:'Contexto de la Organización', subs:['4.1 Comprensión de la organización','4.2 Partes interesadas','4.3 Alcance del SGC','4.4 Procesos del SGC'] },
  { num:'5', title:'Liderazgo',                   subs:['5.1 Liderazgo y compromiso','5.2 Política de calidad','5.3 Roles, responsabilidades y autoridades'] },
  { num:'6', title:'Planificación',               subs:['6.1 Riesgos y oportunidades','6.2 Objetivos de calidad','6.3 Planificación de cambios'] },
  { num:'7', title:'Apoyo',                       subs:['7.1 Recursos','7.2 Competencia','7.3 Toma de conciencia','7.4 Comunicación','7.5 Información documentada'] },
  { num:'8', title:'Operación',                   subs:['8.1 Planificación y control','8.2 Requisitos del servicio','8.3 Diseño y desarrollo','8.4 Proveedores externos','8.5 Producción/prestación','8.6 Liberación del servicio','8.7 Control de salidas no conformes'] },
  { num:'9', title:'Evaluación del Desempeño',    subs:['9.1 Seguimiento y medición','9.2 Auditoría interna','9.3 Revisión por la dirección'] },
  { num:'10', title:'Mejora',                     subs:['10.1 Generalidades','10.2 No conformidad y acción correctiva','10.3 Mejora continua'] },
]

function renderNCSummary() {
  const wrap = document.getElementById('nc-summary-wrap')
  if (!wrap) return
  const findings = _currentAI?.findings || []
  const ncMayor = findings.filter(f => f.type === 'nc_mayor')
  const ncMenor = findings.filter(f => f.type === 'nc_menor')

  if (ncMayor.length === 0 && ncMenor.length === 0) {
    wrap.innerHTML = '<div style="font-size:.857rem;color:var(--txt3);padding:10px 0">No hay NC registradas en la pestaña Hallazgos.</div>'
    return
  }

  const rows = ISO_CLAUSES.map(sec => {
    // Contar NC de esta sección (por número de cláusula)
    const matchMayor = ncMayor.filter(f => (f.clause||'').startsWith(sec.num+'.')||f.clause===sec.num)
    const matchMenor = ncMenor.filter(f => (f.clause||'').startsWith(sec.num+'.')||f.clause===sec.num)
    const subRows = sec.subs.map(s => {
      const clauseNum = s.split(' ')[0]
      const mM = ncMayor.filter(f => (f.clause||'').startsWith(clauseNum)).length
      const mN = ncMenor.filter(f => (f.clause||'').startsWith(clauseNum)).length
      return `<tr>
        <td style="padding-left:24px;font-size:.8rem;color:var(--txt2)">${esc(s)}</td>
        <td class="center">${mM ? `<span class="ftag nc_mayor">${mM}</span>` : '<span style="color:var(--txt3)">—</span>'}</td>
        <td class="center">${mN ? `<span class="ftag nc_menor">${mN}</span>` : '<span style="color:var(--txt3)">—</span>'}</td>
      </tr>`
    }).join('')

    return `<tr style="background:var(--bg2)">
      <td><strong style="font-size:.857rem">${sec.num}. ${esc(sec.title)}</strong></td>
      <td class="center"><strong>${matchMayor.length || '—'}</strong></td>
      <td class="center"><strong>${matchMenor.length || '—'}</strong></td>
    </tr>${subRows}`
  }).join('')

  const totalM = ncMayor.length, totalN = ncMenor.length
  wrap.innerHTML = `<table class="data-table" style="font-size:.857rem">
    <thead><tr>
      <th>Cláusula ISO 9001:2015</th>
      <th class="center" style="width:110px">NC Mayores</th>
      <th class="center" style="width:110px">NC Menores</th>
    </tr></thead>
    <tbody>${rows}</tbody>
    <tfoot><tr style="border-top:2px solid var(--border)">
      <td><strong>Total de No Conformidades</strong></td>
      <td class="center"><span class="ftag nc_mayor" style="font-size:.857rem">${totalM}</span></td>
      <td class="center"><span class="ftag nc_menor" style="font-size:.857rem">${totalN}</span></td>
    </tr></tfoot>
  </table>`
}

// ── Informe: saveReport (incluye reunión final) ────────────────────
async function saveReport() {
  if (!_currentAI) return
  const ai = _currentAI

  const rf = {
    auditado:           document.getElementById('chk-auditado')?.value.trim()          || _reunionFinal.auditado || '',
    fecha_compromiso:   document.getElementById('rf-fecha-compromiso')?.value           || '',
    puntos_fuertes:     document.getElementById('rf-puntos-fuertes')?.value.trim()      || '',
    potencial_mejora:   document.getElementById('rf-potencial-mejora')?.value.trim()    || '',
    quejas:             document.getElementById('rf-quejas')?.value.trim()              || '',
    auditorias_previas: document.getElementById('rf-auditorias-previas')?.value.trim()  || '',
    revision_sistema:   document.getElementById('rf-revision-sistema')?.value.trim()    || '',
  }

  const payload = buildPayload(ai, {
    conclusion:      document.getElementById('d-conclusion')?.value.trim(),
    audit_result:    document.getElementById('d-audit-result')?.value || null,
    next_audit_date: document.getElementById('d-next-audit')?.value   || null,
    reunion_final:   rf,
  })

  const { error } = await db.rpc('save_auditoria_interna', { p_row: payload })
  if (error) { showToast('Error: ' + error.message,'red'); return }

  Object.assign(_currentAI, {
    conclusion: payload.conclusion, audit_result: payload.audit_result,
    next_audit_date: payload.next_audit_date, reunion_final: rf
  })
  _reunionFinal = rf
  syncToList(); renderKPIs(); applyFilters()
  showToast('Informe y reunión final guardados.','green')
}

// ── Report files ───────────────────────────────────────────────────
async function uploadReport(input) {
  const file = input.files?.[0]
  if (!file || !_currentAI) return
  if (file.size > 20*1024*1024) { showToast('El archivo supera 20 MB.','red'); input.value=''; return }

  const wrap = document.getElementById('report-upload-wrap')
  if (wrap) wrap.innerHTML = '<div style="display:flex;align-items:center;gap:8px;font-size:.857rem;color:var(--blue)"><i class="fa-solid fa-spinner fa-spin"></i> Subiendo informe…</div>'

  const safeName = file.name.replace(/[^a-zA-Z0-9._\-]/g,'_')
  const path = `auditorias/${_currentAI.id}/informe_${Date.now()}_${safeName}`
  if (_currentAI.report_path) await db.storage.from(BUCKET).remove([_currentAI.report_path])

  const { error } = await db.storage.from(BUCKET).upload(path, file, { upsert:true })
  if (error) { showToast('Error al subir: '+error.message,'red'); renderReportUploadBtn(); return }

  const { data:urlData } = db.storage.from(BUCKET).getPublicUrl(path)
  const publicUrl = urlData?.publicUrl || ''

  const payload = buildPayload(_currentAI, { report_path:path, report_url:publicUrl, report_name:file.name })
  const { error:saveErr } = await db.rpc('save_auditoria_interna', { p_row: payload })
  if (saveErr) { showToast('Subido pero no guardado: '+saveErr.message,'red'); return }

  Object.assign(_currentAI, { report_path:path, report_url:publicUrl, report_name:file.name })
  syncToList(); renderReportFile(); renderReportUploadBtn(); input.value=''
  showToast('Informe subido correctamente.','green')
}

function renderReportFile() {
  const el = document.getElementById('report-file-area')
  if (!el) return
  const ai = _currentAI
  if (!ai?.report_url) { el.innerHTML=''; return }
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)
  el.innerHTML = `<div class="report-file-card">
    <i class="fa-solid fa-file-pdf report-file-icon"></i>
    <div class="report-file-info">
      <div class="report-file-name">${esc(ai.report_name||'Informe de auditoría')}</div>
      <div class="report-file-meta">Informe oficial adjunto</div>
    </div>
    <div class="report-file-actions">
      <a href="${ai.report_url}" target="_blank" rel="noopener" class="btn-secondary" style="text-decoration:none">
        <i class="fa-solid fa-eye"></i> Ver</a>
      <a href="${ai.report_url}" download class="btn-secondary" style="text-decoration:none">
        <i class="fa-solid fa-download"></i></a>
      ${canWrite ? `<button class="btn-remove" onclick="deleteReport()"><i class="fa-solid fa-trash-can"></i></button>` : ''}
    </div>
  </div>`
}
function renderReportUploadBtn() {
  const wrap = document.getElementById('report-upload-wrap')
  if (!wrap) return
  const label = _currentAI?.report_url ? 'Reemplazar informe PDF' : 'Subir informe PDF'
  wrap.innerHTML = `<label class="btn-attach-report">
    <i class="fa-solid fa-cloud-arrow-up"></i> ${label}
    <input type="file" accept=".pdf" onchange="uploadReport(this)" style="display:none">
  </label><span class="upload-hint">Solo PDF · máx. 20 MB</span>`
}
async function deleteReport() {
  if (!_currentAI?.report_path) return
  if (!confirm('¿Eliminar el informe adjunto?')) return
  await db.storage.from(BUCKET).remove([_currentAI.report_path])
  const payload = buildPayload(_currentAI, { report_path:null, report_url:null, report_name:null })
  await db.rpc('save_auditoria_interna', { p_row:payload })
  Object.assign(_currentAI, { report_path:null, report_url:null, report_name:null })
  syncToList(); renderReportFile(); renderReportUploadBtn()
  showToast('Informe eliminado.','green')
}

async function uploadMeetingRecord(input) {
  const file = input.files?.[0]
  if (!file || !_currentAI) return
  if (file.size > 20*1024*1024) { showToast('El archivo supera 20 MB.','red'); input.value=''; return }

  const wrap = document.getElementById('meeting-upload-wrap')
  if (wrap) wrap.innerHTML = '<div style="display:flex;align-items:center;gap:8px;font-size:.857rem;color:var(--blue)"><i class="fa-solid fa-spinner fa-spin"></i> Subiendo registro…</div>'

  const safeName = file.name.replace(/[^a-zA-Z0-9._\-]/g,'_')
  const path = `auditorias/${_currentAI.id}/reunion_${Date.now()}_${safeName}`
  if (_currentAI.meeting_path) await db.storage.from(BUCKET).remove([_currentAI.meeting_path])

  const { error } = await db.storage.from(BUCKET).upload(path, file, { upsert:true })
  if (error) { showToast('Error: '+error.message,'red'); renderMeetingUploadBtn(); return }

  const { data:urlData } = db.storage.from(BUCKET).getPublicUrl(path)
  const publicUrl = urlData?.publicUrl || ''

  const payload = buildPayload(_currentAI, { meeting_path:path, meeting_url:publicUrl, meeting_name:file.name })
  const { error:saveErr } = await db.rpc('save_auditoria_interna', { p_row: payload })
  if (saveErr) { showToast('Subido pero no guardado: '+saveErr.message,'red'); return }

  Object.assign(_currentAI, { meeting_path:path, meeting_url:publicUrl, meeting_name:file.name })
  syncToList(); renderMeetingFile(); renderMeetingUploadBtn(); input.value=''
  showToast('Registro de reunión subido correctamente.','green')
}
function renderMeetingFile() {
  const el = document.getElementById('meeting-file-area')
  if (!el) return
  const ai = _currentAI
  if (!ai?.meeting_url) { el.innerHTML=''; return }
  const canWrite = ['administrador','responsable_calidad','auditor'].includes(_role)
  const isImage = /\.(jpg|jpeg|png|webp)$/i.test(ai.meeting_name||'')
  const icon = isImage
    ? `<i class="fa-solid fa-file-image report-file-icon" style="color:#0369a1"></i>`
    : `<i class="fa-solid fa-file-pdf report-file-icon"></i>`
  el.innerHTML = `<div class="report-file-card">
    ${icon}
    <div class="report-file-info">
      <div class="report-file-name">${esc(ai.meeting_name||'Registro de reunión final')}</div>
      <div class="report-file-meta">Registro de reunión final de auditoría</div>
    </div>
    <div class="report-file-actions">
      <a href="${ai.meeting_url}" target="_blank" rel="noopener" class="btn-secondary" style="text-decoration:none">
        <i class="fa-solid fa-eye"></i> Ver</a>
      <a href="${ai.meeting_url}" download class="btn-secondary" style="text-decoration:none">
        <i class="fa-solid fa-download"></i></a>
      ${canWrite ? `<button class="btn-remove" onclick="deleteMeetingRecord()"><i class="fa-solid fa-trash-can"></i></button>` : ''}
    </div>
  </div>`
}
function renderMeetingUploadBtn() {
  const wrap = document.getElementById('meeting-upload-wrap')
  if (!wrap) return
  const label = _currentAI?.meeting_url ? 'Reemplazar registro' : 'Subir registro de reunión'
  wrap.innerHTML = `<label class="btn-attach-report">
    <i class="fa-solid fa-cloud-arrow-up"></i> ${label}
    <input type="file" accept=".pdf,.jpg,.jpeg,.png" onchange="uploadMeetingRecord(this)" style="display:none">
  </label><span class="upload-hint">PDF o imagen · máx. 20 MB</span>`
}
async function deleteMeetingRecord() {
  if (!_currentAI?.meeting_path) return
  if (!confirm('¿Eliminar el registro de reunión?')) return
  await db.storage.from(BUCKET).remove([_currentAI.meeting_path])
  const payload = buildPayload(_currentAI, { meeting_path:null, meeting_url:null, meeting_name:null })
  await db.rpc('save_auditoria_interna', { p_row:payload })
  Object.assign(_currentAI, { meeting_path:null, meeting_url:null, meeting_name:null })
  syncToList(); renderMeetingFile(); renderMeetingUploadBtn()
  showToast('Registro eliminado.','green')
}

// ── Helpers ───────────────────────────────────────────────────────
function buildPayload(ai, overrides = {}) {
  return {
    id: ai.id, audit_number: ai.audit_number, audit_type: ai.audit_type,
    coordinator: ai.coordinator, audit_date_start: ai.audit_date_start,
    audit_date_end: ai.audit_date_end, scope: ai.scope, lead_auditor: ai.lead_auditor,
    status: ai.status, team: ai.team||[], areas: ai.areas||[], findings: ai.findings||[],
    conclusion: ai.conclusion||null, audit_result: ai.audit_result||null,
    next_audit_date: ai.next_audit_date||null,
    report_path: ai.report_path||null, report_url: ai.report_url||null, report_name: ai.report_name||null,
    meeting_path: ai.meeting_path||null, meeting_url: ai.meeting_url||null, meeting_name: ai.meeting_name||null,
    checklist: ai.checklist||[], evaluaciones: ai.evaluaciones||[],
    actuaciones: ai.actuaciones||[], reunion_final: ai.reunion_final||{},
    created_by: ai.created_by,
    ...overrides
  }
}
function syncToList() {
  const idx = _allAI.findIndex(a => a.id === _currentAI.id)
  if (idx > -1) _allAI[idx] = JSON.parse(JSON.stringify(_currentAI))
}
function typeLabel(t) {
  return { programada:'Programada', seguimiento:'Seguimiento', extraordinaria:'Extraordinaria' }[t] || t || '—'
}
function statusLabel(s) {
  return { planificada:'Planificada', en_ejecucion:'En Ejecución', completada:'Completada', cancelada:'Cancelada' }[s] || s || '—'
}
function resultLabel(r) {
  return { sin_hallazgos:'Sin Hallazgos', hallazgos_menores:'Hallazgos Menores', hallazgos_mayores:'Hallazgos Mayores' }[r] || r || '—'
}
function resultBadge(r) {
  if (!r) return '<span class="result-none">—</span>'
  return `<span class="result-${r}">${resultLabel(r)}</span>`
}
function fmtDate(d) {
  if (!d) return '—'
  const [y,m,day] = (d.split('T')[0]).split('-')
  const ms = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic']
  return `${parseInt(day)} ${ms[parseInt(m)-1]} ${y}`
}
function esc(s) {
  return String(s??'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}
function setText(id,v) { const e=document.getElementById(id); if(e) e.textContent=v }
function setVal(id,v)  { const e=document.getElementById(id); if(e) e.value=v }
function resetBtn(btn,html) { btn.disabled=false; btn.innerHTML=html }
function showToast(msg,type='green') {
  const t=document.createElement('div'); t.className=`toast ${type}`; t.textContent=msg
  document.body.appendChild(t); setTimeout(()=>t.remove(),3500)
}
function switchTab(panelId,btn) {
  document.querySelectorAll('.tab-panel').forEach(p=>p.classList.remove('active'))
  document.querySelectorAll('.tab-btn').forEach(b=>b.classList.remove('active'))
  const panel=document.getElementById(panelId)
  if(panel) panel.classList.add('active')
  if(btn) btn.classList.add('active')
}
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }

// ── Boot ──────────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', initAI)
