// ─── Gestión de Riesgos y Oportunidades — Cláusula 6.1 ───────────────────────

let _processes   = []
let _filtered    = []
let _activeType  = 'all'
let _currentProc = null
let _editRisks   = []

let _user    = null
let _profile = null
let _role    = null

// ── Risk level calculation ────────────────────────────────────────────────────
function calcLevel(prob, impact) {
  const score = (parseInt(prob) || 1) * (parseInt(impact) || 1)
  if (score <= 4)  return { level:'bajo',    score, cls:'level-bajo',    label:'Bajo',    num:1 }
  if (score <= 9)  return { level:'medio',   score, cls:'level-medio',   label:'Medio',   num:2 }
  if (score <= 15) return { level:'alto',    score, cls:'level-alto',    label:'Alto',    num:3 }
  return                   { level:'critico', score, cls:'level-critico', label:'Crítico', num:4 }
}

const PROB_LABELS = { 1:'Raro', 2:'Poco probable', 3:'Posible', 4:'Probable', 5:'Casi seguro' }
const IMP_LABELS  = { 1:'Insignificante', 2:'Menor', 3:'Moderado', 4:'Mayor', 5:'Catastrófico' }

// ── Init ──────────────────────────────────────────────────────────────────────
async function initRiesgos() {
  try {
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

    setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
    setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')

    const dateEl = document.getElementById('current-date')
    if (dateEl) dateEl.textContent = new Date().toLocaleDateString('es-MX',
      { weekday:'long', day:'numeric', month:'long', year:'numeric' })

    const canWrite = ['administrador','responsable_calidad'].includes(_role)
    document.querySelectorAll('.write-only').forEach(el => {
      el.style.display = canWrite ? '' : 'none'
    })

    await loadProcesses()
  } catch (err) {
    console.error('[Riesgos] init error:', err)
  }
}

// ── Load processes ────────────────────────────────────────────────────────────
async function loadProcesses() {
  const grid = document.getElementById('process-grid')
  if (grid) grid.innerHTML = '<div style="grid-column:1/-1;text-align:center;padding:40px;color:var(--txt3)"><i class="fa-solid fa-spinner fa-spin fa-2x"></i></div>'

  const { data, error } = await db
    .from('risk_processes')
    .select('*')
    .eq('active', true)
    .order('sort_order')

  if (error) {
    if (grid) grid.innerHTML = `<div style="grid-column:1/-1;text-align:center;padding:40px;color:var(--red)">
      <i class="fa-solid fa-triangle-exclamation fa-2x"></i><br><br>Error al cargar: ${esc(error.message)}</div>`
    return
  }

  _processes = data || []
  applyFilters()
  renderKPIs()
}

// ── KPIs ──────────────────────────────────────────────────────────────────────
function renderKPIs() {
  let total = 0, critico = 0, alto = 0, medio = 0, bajo = 0, oport = 0, pending = 0

  _processes.forEach(p => {
    const risks = Array.isArray(p.risks) ? p.risks : []
    risks.forEach(r => {
      total++
      if (r.type === 'oportunidad') { oport++; return }
      const lv = calcLevel(r.probability, r.impact)
      if (lv.level === 'critico') critico++
      else if (lv.level === 'alto') alto++
      else if (lv.level === 'medio') medio++
      else bajo++
      if (r.status === 'identificado') pending++
    })
  })

  setText('kpi-total',    total)
  setText('kpi-critico',  critico)
  setText('kpi-alto',     alto)
  setText('kpi-medio',    medio)
  setText('kpi-bajo',     bajo)
  setText('kpi-oport',    oport)
  setText('kpi-pending',  pending)

  // Color card-critico
  const cc = document.getElementById('card-critico')
  if (cc) cc.className = 'kpi-card ' + (critico > 0 ? 'red' : 'green')
}

// ── Filters ───────────────────────────────────────────────────────────────────
function setTypeFilter(type, el) {
  _activeType = type
  document.querySelectorAll('.type-tab').forEach(t => t.classList.remove('active'))
  el.classList.add('active')
  applyFilters()
}

function applyFilters() {
  const q = (document.getElementById('search-input')?.value || '').toLowerCase().trim()
  const level = document.getElementById('f-level')?.value || ''

  _filtered = _processes.filter(p => {
    if (_activeType !== 'all' && p.process_type !== _activeType) return false
    if (q && ![p.name, p.process_owner, p.description].filter(Boolean).join(' ').toLowerCase().includes(q)) return false
    if (level) {
      const risks = Array.isArray(p.risks) ? p.risks : []
      const hasLevel = risks.some(r => r.type !== 'oportunidad' && calcLevel(r.probability, r.impact).level === level)
      if (!hasLevel) return false
    }
    return true
  })

  const cnt = document.getElementById('proc-count')
  if (cnt) cnt.textContent = `${_filtered.length} proceso${_filtered.length !== 1 ? 's' : ''}`

  renderProcessGrid()
}

// ── Process grid ──────────────────────────────────────────────────────────────
function renderProcessGrid() {
  const grid = document.getElementById('process-grid')
  if (!grid) return

  if (_filtered.length === 0) {
    grid.innerHTML = `<div style="grid-column:1/-1;text-align:center;padding:50px;color:var(--txt3)">
      <i class="fa-solid fa-shield-halved" style="font-size:2.5rem;margin-bottom:12px;display:block;color:var(--border)"></i>
      Sin procesos para los filtros seleccionados.</div>`
    return
  }

  grid.innerHTML = _filtered.map(p => {
    const risks = Array.isArray(p.risks) ? p.risks : []
    const riesgos = risks.filter(r => r.type !== 'oportunidad')
    const oports  = risks.filter(r => r.type === 'oportunidad')

    let critico = 0, alto = 0, medio = 0, bajo = 0
    riesgos.forEach(r => {
      const lv = calcLevel(r.probability, r.impact)
      if (lv.level === 'critico') critico++
      else if (lv.level === 'alto') alto++
      else if (lv.level === 'medio') medio++
      else bajo++
    })

    const typeLabel = { estrategico:'Estratégico', misional:'Misional', apoyo:'Apoyo' }[p.process_type] || p.process_type
    const typeDot   = `type-dot-${p.process_type}`
    const typeBadge = `badge-${p.process_type}`

    const pills = [
      critico ? `<span class="risk-pill pill-critico"><i class="fa-solid fa-circle-xmark" style="font-size:9px"></i>${critico} Crítico${critico>1?'s':''}</span>` : '',
      alto    ? `<span class="risk-pill pill-alto"><i class="fa-solid fa-triangle-exclamation" style="font-size:9px"></i>${alto} Alto${alto>1?'s':''}</span>` : '',
      medio   ? `<span class="risk-pill pill-medio">${medio} Medio${medio>1?'s':''}</span>` : '',
      bajo    ? `<span class="risk-pill pill-bajo">${bajo} Bajo${bajo>1?'s':''}</span>` : '',
      oports.length ? `<span class="risk-pill pill-oport"><i class="fa-solid fa-arrow-trend-up" style="font-size:9px"></i>${oports.length} Oport.</span>` : '',
    ].filter(Boolean).join('')

    const worstLevel = critico > 0 ? 'critico' : alto > 0 ? 'alto' : medio > 0 ? 'medio' : bajo > 0 ? 'bajo' : null

    return `
    <div class="process-card" onclick="openProcess('${p.id}')">
      <div class="process-card-head">
        <div class="process-type-dot ${typeDot}"></div>
        <div style="flex:1">
          <div class="process-name">${esc(p.name)}</div>
          <div class="process-owner"><i class="fa-solid fa-user" style="font-size:10px"></i> ${esc(p.process_owner || '—')}</div>
        </div>
        <span class="process-type-badge ${typeBadge}">${typeLabel}</span>
      </div>
      <div class="process-card-body">
        <div class="process-description">${esc(p.description || '')}</div>
        <div class="risk-summary">${pills || '<span style="font-size:.75rem;color:var(--txt3)">Sin riesgos registrados</span>'}</div>
      </div>
      <div class="process-card-foot">
        <span class="process-risk-count"><strong>${risks.length}</strong> riesgo${risks.length !== 1 ? 's' : ''} / oportunidad${risks.length !== 1 ? 'es' : ''}</span>
        ${worstLevel ? `<span class="level-badge level-${worstLevel}">Nivel máx: ${calcLevel(worstLevel==='critico'?5:worstLevel==='alto'?4:worstLevel==='medio'?3:2,worstLevel==='critico'?5:worstLevel==='alto'?4:worstLevel==='medio'?3:2).label}</span>` : ''}
      </div>
    </div>`
  }).join('')
}

// ── Open process detail ───────────────────────────────────────────────────────
function openProcess(id) {
  const proc = _processes.find(p => p.id === id)
  if (!proc) return
  _currentProc = proc
  _editRisks   = JSON.parse(JSON.stringify(Array.isArray(proc.risks) ? proc.risks : []))

  setText('modal-proc-title', proc.name)
  const typeLabel = { estrategico:'Estratégico', misional:'Misional', apoyo:'Apoyo' }[proc.process_type] || proc.process_type
  setText('modal-proc-sub', `Proceso ${typeLabel} — Cláusula 6.1 ISO 9001:2015`)

  // Info tab
  const ownerEl = document.getElementById('d-owner')
  if (ownerEl) ownerEl.value = proc.process_owner || ''
  const descEl = document.getElementById('d-description')
  if (descEl) descEl.value = proc.description || ''
  setText('d-type-badge', typeLabel)
  setText('d-risk-count', `${_editRisks.length} riesgo${_editRisks.length !== 1 ? 's' : ''} / oportunidad${_editRisks.length !== 1 ? 'es' : ''} identificados`)

  renderRisksTab()

  // Reset tabs
  document.querySelectorAll('#modal-process .tab-btn').forEach((b, i) => b.classList.toggle('active', i === 0))
  document.querySelectorAll('#modal-process .tab-panel').forEach((p, i) => p.classList.toggle('active', i === 0))

  openModal('modal-process')
}

// ── Render risks tab ──────────────────────────────────────────────────────────
function renderRisksTab() {
  const container = document.getElementById('risks-list')
  if (!container) return

  const badge = document.getElementById('tab-risks-count')
  if (badge) badge.textContent = _editRisks.length || ''

  if (_editRisks.length === 0) {
    container.innerHTML = `<div class="risks-empty">
      <i class="fa-solid fa-shield-halved"></i>
      Sin riesgos u oportunidades registrados para este proceso.<br>
      Use el botón de abajo para agregar el primero.
    </div>`
    return
  }

  container.innerHTML = _editRisks.map((r, idx) => {
    const lv  = r.type === 'oportunidad' ? null : calcLevel(r.probability, r.impact)
    const isR = r.type !== 'oportunidad'

    return `
    <div class="risk-item-card type-${r.type || 'riesgo'}" id="risk-card-${idx}">
      <div class="risk-item-head">
        <span class="risk-item-num">#${String(idx+1).padStart(2,'0')}</span>
        <select class="risk-select" id="ri-type-${idx}" onchange="onTypeChange(${idx})"
          style="width:auto;padding:4px 28px 4px 8px">
          <option value="riesgo"      ${(r.type||'riesgo')==='riesgo'      ?'selected':''}>⚠️ Riesgo</option>
          <option value="oportunidad" ${r.type==='oportunidad'?'selected':''}>🔵 Oportunidad</option>
        </select>
        ${lv ? `<span class="risk-score-badge ${lv.cls}">
          Nivel: ${lv.label} (${lv.score})
        </span>` : '<span class="risk-score-badge level-bajo" style="margin-left:auto">Oportunidad</span>'}
        <button class="btn-icon-remove write-only" onclick="removeRisk(${idx})" title="Eliminar">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>
      <div class="risk-fields">

        <div>
          <div class="risk-field-label">Descripción del riesgo / oportunidad <span style="color:var(--red)">*</span></div>
          <textarea class="risk-textarea" id="ri-desc-${idx}" rows="2"
            placeholder="Describa el riesgo u oportunidad identificado…">${esc(r.description||'')}</textarea>
        </div>

        <div class="risk-row">
          <div>
            <div class="risk-field-label">Causa potencial</div>
            <textarea class="risk-textarea" id="ri-cause-${idx}" rows="2"
              placeholder="¿Qué origina este riesgo?">${esc(r.cause||'')}</textarea>
          </div>
          <div>
            <div class="risk-field-label">Efecto / Consecuencia</div>
            <textarea class="risk-textarea" id="ri-effect-${idx}" rows="2"
              placeholder="¿Qué impacto tendría si ocurre?">${esc(r.effect||'')}</textarea>
          </div>
        </div>

        ${isR ? `
        <div class="risk-row four">
          <div>
            <div class="risk-field-label">Probabilidad (1–5)</div>
            <select class="risk-select" id="ri-prob-${idx}" onchange="updateScore(${idx})">
              ${[1,2,3,4,5].map(n => `<option value="${n}" ${(r.probability||1)==n?'selected':''}>${n} — ${PROB_LABELS[n]}</option>`).join('')}
            </select>
          </div>
          <div>
            <div class="risk-field-label">Impacto (1–5)</div>
            <select class="risk-select" id="ri-impact-${idx}" onchange="updateScore(${idx})">
              ${[1,2,3,4,5].map(n => `<option value="${n}" ${(r.impact||1)==n?'selected':''}>${n} — ${IMP_LABELS[n]}</option>`).join('')}
            </select>
          </div>
          <div>
            <div class="risk-field-label">Nivel calculado</div>
            <div class="risk-score-display level-badge ${lv.cls}" id="ri-score-${idx}">
              ${lv.label} (${lv.score})
            </div>
          </div>
          <div>
            <div class="risk-field-label">Estado</div>
            <select class="risk-select" id="ri-status-${idx}">
              <option value="identificado" ${(r.status||'identificado')==='identificado'?'selected':''}>🔍 Identificado</option>
              <option value="en_control"   ${r.status==='en_control'  ?'selected':''}>🔄 En control</option>
              <option value="aceptado"     ${r.status==='aceptado'    ?'selected':''}>✅ Aceptado</option>
              <option value="cerrado"      ${r.status==='cerrado'     ?'selected':''}>🔒 Cerrado</option>
            </select>
          </div>
        </div>` : `
        <div class="risk-row">
          <div>
            <div class="risk-field-label">Estado</div>
            <select class="risk-select" id="ri-status-${idx}">
              <option value="identificado" ${(r.status||'identificado')==='identificado'?'selected':''}>🔍 Identificado</option>
              <option value="en_control"   ${r.status==='en_control'  ?'selected':''}>🔄 En seguimiento</option>
              <option value="cerrado"      ${r.status==='cerrado'     ?'selected':''}>✅ Aprovechada</option>
            </select>
          </div>
          <div></div>
        </div>`}

        <div>
          <div class="risk-field-label">Plan de acción / Control</div>
          <textarea class="risk-textarea" id="ri-action-${idx}" rows="2"
            placeholder="Acciones para mitigar el riesgo o aprovechar la oportunidad…">${esc(r.action_plan||'')}</textarea>
        </div>

        <div class="risk-row">
          <div>
            <div class="risk-field-label">Responsable</div>
            <input type="text" class="risk-input" id="ri-resp-${idx}"
              value="${esc(r.responsible||'')}" placeholder="Nombre o cargo">
          </div>
          <div>
            <div class="risk-field-label">Fecha límite</div>
            <input type="date" class="risk-input" id="ri-due-${idx}"
              value="${esc(r.due_date||'')}">
          </div>
        </div>

      </div>
    </div>`
  }).join('')
}

// ── Live score update ─────────────────────────────────────────────────────────
function updateScore(idx) {
  const prob   = document.getElementById(`ri-prob-${idx}`)?.value   || 1
  const impact = document.getElementById(`ri-impact-${idx}`)?.value || 1
  const lv     = calcLevel(prob, impact)
  const scoreEl = document.getElementById(`ri-score-${idx}`)
  if (scoreEl) {
    scoreEl.className = `risk-score-display level-badge ${lv.cls}`
    scoreEl.textContent = `${lv.label} (${lv.score})`
  }
  // Also update card header badge
  const headerBadge = document.querySelector(`#risk-card-${idx} .risk-score-badge`)
  if (headerBadge && _editRisks[idx]?.type !== 'oportunidad') {
    headerBadge.className = `risk-score-badge ${lv.cls}`
    headerBadge.textContent = `Nivel: ${lv.label} (${lv.score})`
  }
}

function onTypeChange(idx) {
  _collectRiskValues()
  renderRisksTab()
}

// ── Add / remove risk ─────────────────────────────────────────────────────────
function addRisk() {
  _collectRiskValues()
  _editRisks.push({
    id: 'r' + Date.now(),
    type: 'riesgo', description: '', cause: '', effect: '',
    probability: 1, impact: 1, action_plan: '', responsible: '',
    due_date: '', status: 'identificado'
  })
  renderRisksTab()
  setTimeout(() => {
    const last = document.getElementById(`risk-card-${_editRisks.length - 1}`)
    last?.scrollIntoView({ behavior:'smooth', block:'nearest' })
    document.getElementById(`ri-desc-${_editRisks.length - 1}`)?.focus()
  }, 50)
}

function addOpportunity() {
  _collectRiskValues()
  _editRisks.push({
    id: 'o' + Date.now(),
    type: 'oportunidad', description: '', cause: '', effect: '',
    action_plan: '', responsible: '', due_date: '', status: 'identificado'
  })
  renderRisksTab()
  setTimeout(() => {
    const last = document.getElementById(`risk-card-${_editRisks.length - 1}`)
    last?.scrollIntoView({ behavior:'smooth', block:'nearest' })
    document.getElementById(`ri-desc-${_editRisks.length - 1}`)?.focus()
  }, 50)
}

function removeRisk(idx) {
  _collectRiskValues()
  _editRisks.splice(idx, 1)
  renderRisksTab()
}

// ── Collect risk values from DOM ──────────────────────────────────────────────
function _collectRiskValues() {
  _editRisks.forEach((r, idx) => {
    r.type        = document.getElementById(`ri-type-${idx}`)?.value   || r.type
    r.description = document.getElementById(`ri-desc-${idx}`)?.value   || ''
    r.cause       = document.getElementById(`ri-cause-${idx}`)?.value  || ''
    r.effect      = document.getElementById(`ri-effect-${idx}`)?.value || ''
    r.action_plan = document.getElementById(`ri-action-${idx}`)?.value || ''
    r.responsible = document.getElementById(`ri-resp-${idx}`)?.value   || ''
    r.due_date    = document.getElementById(`ri-due-${idx}`)?.value    || null
    r.status      = document.getElementById(`ri-status-${idx}`)?.value || 'identificado'
    if (r.type !== 'oportunidad') {
      r.probability = parseInt(document.getElementById(`ri-prob-${idx}`)?.value)   || 1
      r.impact      = parseInt(document.getElementById(`ri-impact-${idx}`)?.value) || 1
    }
  })
}

// ── Save ──────────────────────────────────────────────────────────────────────
async function saveInfo() {
  if (!_currentProc) return
  const owner = document.getElementById('d-owner')?.value || ''
  const desc  = document.getElementById('d-description')?.value || ''

  const { error } = await db.rpc('save_process_risks', {
    p_data: {
      id: _currentProc.id,
      process_owner: owner,
      description:   desc,
      risks: _editRisks
    }
  })
  if (error) { showToast('Error al guardar: ' + error.message, 'red'); return }

  _currentProc.process_owner = owner
  _currentProc.description   = desc
  _currentProc.risks         = JSON.parse(JSON.stringify(_editRisks))
  _updateLocal()
  showToast('Información guardada.', 'green')
}

async function saveRisks() {
  if (!_currentProc) return
  _collectRiskValues()

  const { error } = await db.rpc('save_process_risks', {
    p_data: {
      id: _currentProc.id,
      process_owner: _currentProc.process_owner,
      description:   _currentProc.description,
      risks: _editRisks
    }
  })
  if (error) { showToast('Error al guardar: ' + error.message, 'red'); return }

  _currentProc.risks = JSON.parse(JSON.stringify(_editRisks))
  _updateLocal()
  showToast('Riesgos guardados correctamente.', 'green')
  renderKPIs()
  applyFilters()
}

function _updateLocal() {
  const idx = _processes.findIndex(p => p.id === _currentProc.id)
  if (idx !== -1) _processes[idx] = { ..._processes[idx], ..._currentProc }
}

// ── Shared helpers ────────────────────────────────────────────────────────────
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }

function switchTab(panelId, btn) {
  const modal = btn.closest('.modal, .layout')
  modal.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'))
  modal.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'))
  btn.classList.add('active')
  document.getElementById(panelId)?.classList.add('active')
}

function setText(id, val) {
  const el = document.getElementById(id)
  if (el) el.textContent = val ?? '—'
}

function esc(s) {
  if (!s) return ''
  return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}

function showToast(msg, color = 'green') {
  const old = document.getElementById('sgc-toast')
  if (old) old.remove()
  const bg = color==='green' ? '#16a34a' : color==='red' ? '#dc2626' : '#2563eb'
  const t  = document.createElement('div')
  t.id = 'sgc-toast'
  t.style.cssText = `position:fixed;bottom:28px;right:28px;z-index:9999;background:${bg};color:#fff;
    padding:13px 22px;border-radius:12px;font-size:.857rem;font-weight:600;font-family:var(--font);
    box-shadow:0 8px 28px rgba(0,0,0,.22);max-width:380px;line-height:1.4;`
  t.textContent = msg
  document.body.appendChild(t)
  setTimeout(() => t.remove(), 3800)
}

document.querySelectorAll('.modal-overlay').forEach(overlay => {
  overlay.addEventListener('click', e => {
    if (e.target === overlay) overlay.classList.remove('open')
  })
})

// ── Bootstrap ──────────────────────────────────────────────────────────────────
initRiesgos()
