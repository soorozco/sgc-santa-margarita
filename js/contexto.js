// ─── Contexto del SGC — Cláusula 4 ────────────────────────────

let _user    = null
let _profile = null
let _role    = null
let _ctx     = null        // sgc_context record
let _ctxId   = null
let _foda    = null        // swot_analyses record
let _fodaId  = null
let _parties = []
let _exclusions = []       // working array
let _fodaData   = { fortalezas:[], debilidades:[], oportunidades:[], amenazas:[] }
let _editingFoda = false

// ── Init ────────────────────────────────────────────────────────
async function initContexto() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  renderUserInfo()
  setCurrentDate()
  await Promise.all([loadContext(), loadFoda(), loadParties()])
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
  const canWrite = ['administrador','responsable_calidad'].includes(_role)
  const btnScope = document.getElementById('btn-edit-scope')
  const btnFoda  = document.getElementById('btn-edit-foda')
  const btnParty = document.getElementById('btn-add-party')
  if (btnScope) btnScope.style.display = canWrite ? 'inline-flex' : 'none'
  if (btnFoda)  btnFoda.style.display  = canWrite ? 'inline-flex' : 'none'
  if (btnParty) btnParty.style.display = canWrite ? 'inline-flex' : 'none'
}

// ══════════════════════════════════════════════════════════════
// SECCIÓN 4.3 — ALCANCE Y EXCLUSIONES
// ══════════════════════════════════════════════════════════════
async function loadContext() {
  const { data, error } = await db.from('sgc_context')
    .select('id, scope_declaration, scope_justification, exclusions, updated_at, updated_by')
    .order('updated_at', { ascending: false })
    .limit(1)
    .maybeSingle()

  if (error) console.error('[SGC Context]', error.message)

  _ctx   = data || null
  _ctxId = data?.id || null
  _exclusions = Array.isArray(data?.exclusions) ? data.exclusions : []

  renderScopeView()
}

function renderScopeView() {
  const scopeEl = document.getElementById('d-scope')
  const justEl  = document.getElementById('d-scope-just')
  const listEl  = document.getElementById('exclusion-list')
  const pillEl  = document.getElementById('banner-scope-pill')
  const updEl   = document.getElementById('banner-updated')

  if (_ctx?.scope_declaration) {
    if (scopeEl) scopeEl.textContent = _ctx.scope_declaration
  } else {
    if (scopeEl) scopeEl.innerHTML =
      '<span style="color:var(--txt3);font-style:italic">Sin declaración de alcance registrada.</span>'
  }
  if (justEl) justEl.textContent = _ctx?.scope_justification || '—'

  // Exclusions list
  if (listEl) {
    if (_exclusions.length === 0) {
      listEl.innerHTML = `<li style="font-size:.857rem;color:var(--txt3);padding:10px 0;font-style:italic">
        Sin exclusiones registradas. El SGC aplica en su totalidad.</li>`
    } else {
      listEl.innerHTML = _exclusions.map(e => `
        <li class="exclusion-item">
          <span class="excl-clause">${esc(e.clause)}</span>
          <div>
            <div class="excl-text">${esc(e.clause)}</div>
            <div class="excl-just">Justificación: ${esc(e.justification)}</div>
          </div>
        </li>`).join('')
    }
  }

  if (pillEl) pillEl.textContent = _ctx?.scope_declaration
    ? `Alcance definido`
    : 'Sin alcance definido'
  if (updEl && _ctx?.updated_at)
    updEl.textContent = `Actualizado: ${fmtDate(_ctx.updated_at.split('T')[0])}`
}

function toggleEditScope() {
  const view = document.getElementById('scope-view')
  const edit = document.getElementById('scope-edit')
  const btn  = document.getElementById('btn-edit-scope')
  const isOpen = edit.classList.contains('show')

  if (isOpen) {
    edit.classList.remove('show')
    view.style.display = 'block'
    btn.classList.remove('active')
    btn.innerHTML = '<i class="fa-solid fa-pen"></i> Editar'
  } else {
    // Populate edit fields
    setVal('edit-scope',      _ctx?.scope_declaration   || '')
    setVal('edit-scope-just', _ctx?.scope_justification || '')
    renderExclusionEditList()
    edit.classList.add('show')
    view.style.display = 'none'
    btn.classList.add('active')
    btn.innerHTML = '<i class="fa-solid fa-xmark"></i> Cerrar'
  }
}

function renderExclusionEditList() {
  const list = document.getElementById('exclusion-edit-list')
  if (!list) return
  if (_exclusions.length === 0) {
    list.innerHTML = `<li style="font-size:.786rem;color:var(--txt3);padding:8px 0;font-style:italic">
      Sin exclusiones. Agrega una si aplica.</li>`
    return
  }
  list.innerHTML = _exclusions.map((e, i) => `
    <li class="exclusion-item">
      <span class="excl-clause">${esc(e.clause)}</span>
      <div style="flex:1">
        <div class="excl-text">${esc(e.justification)}</div>
      </div>
      <button class="btn-action red" onclick="removeExclusion(${i})" title="Eliminar">
        <i class="fa-solid fa-trash"></i>
      </button>
    </li>`).join('')
}

function toggleAddExcl() {
  const form = document.getElementById('add-excl-form')
  form.classList.toggle('show')
}

function addExclusion() {
  const clause = document.getElementById('excl-clause')?.value.trim()
  const just   = document.getElementById('excl-just')?.value.trim()
  if (!clause) { showToast('Indica la cláusula a excluir.', 'red'); return }
  if (!just)   { showToast('Justifica la exclusión.', 'red'); return }
  _exclusions.push({ clause, justification: just })
  setVal('excl-clause', '')
  setVal('excl-just', '')
  toggleAddExcl()
  renderExclusionEditList()
}

function removeExclusion(idx) {
  _exclusions.splice(idx, 1)
  renderExclusionEditList()
}

async function saveScope() {
  const btn   = document.getElementById('btn-save-scope')
  const scope = document.getElementById('edit-scope')?.value.trim()
  const just  = document.getElementById('edit-scope-just')?.value.trim()

  if (!scope) { showToast('La declaración del alcance es obligatoria.', 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const payload = {
    scope_declaration:   scope,
    scope_justification: just  || null,
    exclusions:          _exclusions,
    updated_by:          _user.id,
    updated_at:          new Date().toISOString()
  }

  let error
  if (_ctxId) {
    ({ error } = await db.from('sgc_context').update(payload).eq('id', _ctxId))
  } else {
    const res = await db.from('sgc_context')
      .insert({ ...payload, created_by: _user.id })
      .select('id, scope_declaration, scope_justification, exclusions, updated_at')
      .single()
    error  = res.error
    _ctx   = res.data
    _ctxId = res.data?.id
  }

  if (error) {
    showToast('Error al guardar: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar Alcance')
    return
  }

  if (_ctxId) Object.assign(_ctx || {}, payload)
  showToast('Alcance guardado correctamente.', 'green')
  resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar Alcance')
  toggleEditScope()
  await loadContext()
}

// ══════════════════════════════════════════════════════════════
// SECCIÓN 4.1 — FODA
// ══════════════════════════════════════════════════════════════
const FODA_CONFIG = [
  { key:'fortalezas',   label:'Fortalezas',    sub:'Factores internos positivos',   icon:'fa-star',                cls:'fortalezas',   icoClr:'fa-circle-dot' },
  { key:'debilidades',  label:'Debilidades',   sub:'Factores internos a mejorar',   icon:'fa-triangle-exclamation',cls:'debilidades',  icoClr:'fa-circle-minus' },
  { key:'oportunidades',label:'Oportunidades', sub:'Factores externos favorables',  icon:'fa-arrow-trend-up',      cls:'oportunidades',icoClr:'fa-circle-arrow-up' },
  { key:'amenazas',     label:'Amenazas',      sub:'Factores externos de riesgo',   icon:'fa-shield-halved',       cls:'amenazas',     icoClr:'fa-circle-xmark' }
]

async function loadFoda() {
  const { data, error } = await db.from('swot_analyses')
    .select('id, strengths, weaknesses, opportunities, threats, analysis_date, updated_at, created_at')
    .order('created_at', { ascending: false })
    .limit(1)
    .maybeSingle()

  if (error) console.error('[SGC FODA]', error.message)

  _foda   = data || null
  _fodaId = data?.id || null

  if (data) {
    _fodaData = {
      fortalezas:    parseItems(data.strengths),
      debilidades:   parseItems(data.weaknesses),
      oportunidades: parseItems(data.opportunities),
      amenazas:      parseItems(data.threats)
    }
    const updEl  = document.getElementById('foda-updated')
    const dateRef = data.analysis_date || data.updated_at || data.created_at
    if (updEl && dateRef)
      updEl.textContent = `Actualizado: ${fmtDate(String(dateRef).split('T')[0])}`
  }

  renderFodaGrid()
}

function parseItems(val) {
  if (!val) return []
  if (Array.isArray(val)) return val
  try { return JSON.parse(val) } catch { return String(val).split('\n').filter(Boolean) }
}

function renderFodaGrid() {
  const grid = document.getElementById('foda-grid')
  if (!grid) return

  grid.innerHTML = FODA_CONFIG.map(q => {
    const items = _fodaData[q.key] || []
    return `
    <div class="foda-quad ${q.cls}">
      <div class="foda-quad-title">
        <i class="fa-solid ${q.icon}"></i>
        ${q.label}
        <span class="foda-label">${q.sub}</span>
      </div>
      <ul class="foda-items" id="foda-items-${q.key}">
        ${items.length === 0
          ? `<li class="foda-empty">Sin elementos registrados</li>`
          : items.map((item, i) => `
            <li class="foda-item">
              <i class="fa-solid ${q.icoClr}"></i>
              <span>${esc(item)}</span>
              ${_editingFoda ? `<span class="del-item" onclick="removeItem('${q.key}',${i})">✕</span>` : ''}
            </li>`).join('')
        }
      </ul>
      ${_editingFoda ? `
      <div class="foda-add">
        <input type="text" id="foda-input-${q.key}"
               placeholder="Agregar ${q.label.toLowerCase()}…"
               onkeydown="if(event.key==='Enter') addItem('${q.key}')">
        <button onclick="addItem('${q.key}')"><i class="fa-solid fa-plus"></i></button>
      </div>` : ''}
    </div>`
  }).join('')
}

function toggleEditFoda() {
  const btn = document.getElementById('btn-edit-foda')
  _editingFoda = !_editingFoda
  renderFodaGrid()
  if (_editingFoda) {
    btn.classList.add('active')
    btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar FODA'
    btn.onclick   = saveFoda
  } else {
    btn.classList.remove('active')
    btn.innerHTML = '<i class="fa-solid fa-pen"></i> Editar'
    btn.onclick   = toggleEditFoda
  }
}

function addItem(quadrant) {
  const inp = document.getElementById(`foda-input-${quadrant}`)
  if (!inp) return
  const val = inp.value.trim()
  if (!val) return
  if (!_fodaData[quadrant]) _fodaData[quadrant] = []
  _fodaData[quadrant].push(val)
  inp.value = ''
  renderFodaGrid()
  // Restore focus
  const newInp = document.getElementById(`foda-input-${quadrant}`)
  if (newInp) newInp.focus()
}

function removeItem(quadrant, idx) {
  _fodaData[quadrant].splice(idx, 1)
  renderFodaGrid()
}

async function saveFoda() {
  const btn = document.getElementById('btn-edit-foda')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const today = new Date().toISOString().split('T')[0]
  const payload = {
    strengths:     JSON.stringify(_fodaData.fortalezas),
    weaknesses:    JSON.stringify(_fodaData.debilidades),
    opportunities: JSON.stringify(_fodaData.oportunidades),
    threats:       JSON.stringify(_fodaData.amenazas),
    analysis_date: today,
    is_current:    true,
    updated_at:    new Date().toISOString()
  }

  let error
  if (_fodaId) {
    ({ error } = await db.from('swot_analyses').update(payload).eq('id', _fodaId))
  } else {
    // Insert requires: title, period, status + content
    const insertPayload = {
      ...payload,
      title:      'Análisis FODA — Hospital Santa Margarita',
      period:     today.substring(0, 7), // YYYY-MM
      status:     'activo',
      created_by: _user.id
    }
    const res = await db.from('swot_analyses').insert(insertPayload).select().single()
    error   = res.error
    _foda   = res.data
    _fodaId = res.data?.id
  }

  if (error) {
    showToast('Error al guardar FODA: ' + error.message, 'red')
    btn.disabled = false
    btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar FODA'
    return
  }

  _editingFoda = false
  renderFodaGrid()
  showToast('Análisis FODA guardado correctamente.', 'green')

  btn.disabled = false
  btn.classList.remove('active')
  btn.innerHTML = '<i class="fa-solid fa-pen"></i> Editar'
  btn.onclick   = toggleEditFoda

  const updEl = document.getElementById('foda-updated')
  if (updEl) updEl.textContent = `Actualizado: ${fmtDate(new Date().toISOString().split('T')[0])}`
}

// ══════════════════════════════════════════════════════════════
// SECCIÓN 4.2 — PARTES INTERESADAS
// ══════════════════════════════════════════════════════════════
async function loadParties() {
  const { data, error } = await db.from('interested_parties')
    .select('*').eq('is_active', true).order('type').order('name')

  _parties = data || []
  renderPartiesTable()
}

function renderPartiesTable() {
  const tbody = document.getElementById('parties-tbody')
  if (!tbody) return
  const canWrite = ['administrador','responsable_calidad'].includes(_role)

  if (_parties.length === 0) {
    tbody.innerHTML = `<tr><td colspan="6" class="parties-empty">
      <i class="fa-solid fa-people-group"></i>
      Sin partes interesadas registradas aún.
    </td></tr>`
    return
  }

  tbody.innerHTML = _parties.map(p => `
    <tr>
      <td><div class="party-name">${esc(p.name)}</div></td>
      <td><span class="party-type ${p.type}">${p.type === 'interno' ? 'Interno' : 'Externo'}</span></td>
      <td style="font-size:.857rem;color:var(--txt2);max-width:180px">${esc(p.needs || '—')}</td>
      <td style="font-size:.857rem;color:var(--txt2);max-width:180px">${esc(p.expectations || '—')}</td>
      <td style="font-size:.786rem;color:var(--txt3)">${esc(p.monitoring_method || '—')}</td>
      <td class="center">
        ${canWrite ? `<button class="btn-action red" onclick="deleteParty('${p.id}')" title="Eliminar">
          <i class="fa-solid fa-trash"></i></button>` : ''}
      </td>
    </tr>`).join('')
}

function toggleAddParty() {
  const form = document.getElementById('add-party-form')
  const isOpen = form.classList.contains('show')
  form.classList.toggle('show')
  if (!isOpen) {
    ['p-name','p-needs','p-expectations','p-monitoring'].forEach(id => setVal(id,''))
    setVal('p-type','externo')
  }
}

async function saveParty() {
  const name = document.getElementById('p-name')?.value.trim()
  if (!name) { showToast('El nombre de la parte interesada es obligatorio.', 'red'); return }

  const { error } = await db.from('interested_parties').insert({
    name,
    type:              document.getElementById('p-type')?.value || 'externo',
    needs:             document.getElementById('p-needs')?.value.trim()        || null,
    expectations:      document.getElementById('p-expectations')?.value.trim() || null,
    monitoring_method: document.getElementById('p-monitoring')?.value.trim()   || null,
    is_active:         true,
    created_by:        _user.id
  })

  if (error) { showToast('Error: ' + error.message, 'red'); return }

  showToast(`"${name}" agregada correctamente.`, 'green')
  toggleAddParty()
  await loadParties()
}

async function deleteParty(id) {
  if (!confirm('¿Eliminar esta parte interesada?')) return
  const { error } = await db.from('interested_parties')
    .update({ is_active: false }).eq('id', id)
  if (error) { showToast('Error: ' + error.message, 'red'); return }
  _parties = _parties.filter(p => p.id !== id)
  renderPartiesTable()
  showToast('Parte interesada eliminada.', 'green')
}

// ── Helpers ───────────────────────────────────────────────────────
function fmtDate(d) {
  if (!d) return '—'
  return new Date(d + 'T12:00:00').toLocaleDateString('es-MX',
    { day:'2-digit', month:'short', year:'numeric' })
}
function setText(id, val) { const el=document.getElementById(id); if(el) el.textContent = val??'—' }
function setVal(id, val)  { const el=document.getElementById(id); if(el) el.value = val??'' }
function resetBtn(btn, html) { btn.disabled=false; btn.innerHTML=html }
function esc(str) {
  if (!str) return ''
  return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;')
    .replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}
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
initContexto()
