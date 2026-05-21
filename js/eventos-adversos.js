// ─── Eventos Adversos — Incidentes Clínicos ─────────────────────

let _user      = null
let _profile   = null
let _role      = null
let _all       = []
let _filtered  = []

// ── Init ────────────────────────────────────────────────────────
async function initEA() {
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

  // Solo administrador y responsable_calidad pueden ver datos clínicos
  if (!['administrador','responsable_calidad'].includes(_role)) {
    window.location.href = 'dashboard.html'
    return
  }

  renderUserInfo()
  setCurrentDate()
  await loadIncidents()
  populateSubtypes()
  populateYears()
  applyFilters()
  subscribeRealtime()
}

// ── Realtime — auto-refresh al recibir nuevos incidentes ─────────
function subscribeRealtime() {
  db.channel('clinical_incidents_changes')
    .on('postgres_changes',
      { event: '*', schema: 'public', table: 'clinical_incidents' },
      async () => {
        await loadIncidents()
        populateSubtypes()
        populateYears()
        applyFilters()
        showRefreshBadge()
      }
    )
    .subscribe()
}

function showRefreshBadge() {
  const badge = document.getElementById('realtime-badge')
  if (!badge) return
  badge.style.display = 'inline-flex'
  setTimeout(() => { badge.style.display = 'none' }, 4000)
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

// ── Cargar datos ────────────────────────────────────────────────
async function loadIncidents() {
  const { data, error } = await db
    .from('clinical_incidents')
    .select('*')
    .order('incident_date', { ascending: false })

  if (error) {
    console.error('[EA] Error cargando incidentes:', error.message)
    document.getElementById('state-loading').innerHTML =
      `<i class="fa-solid fa-circle-exclamation"></i> Error al cargar: ${error.message}`
    return
  }

  _all = data || []
  updateKPIs()
}

function updateKPIs() {
  const total   = _all.length
  const cuasi   = _all.filter(r => r.incident_type === 'Cuasi Falla').length
  const adverso = _all.filter(r => r.incident_type === 'Evento Adverso').length
  const leve    = _all.filter(r => r.damage_level === 'Leve').length
  const moderado= _all.filter(r => r.damage_level === 'Moderado').length
  const grave   = _all.filter(r => r.damage_level === 'Grave').length
  const muerte  = _all.filter(r => r.damage_level === 'Muerte').length
  const dano    = leve + moderado + grave + muerte

  setText('kpi-total',   total)
  setText('kpi-cuasi',   cuasi)
  setText('kpi-adverso', adverso)
  setText('kpi-dano',    dano)
  setText('kpi-grave',   grave)
  setText('kpi-muerte',  muerte)

  const sub = document.getElementById('kpi-dano-sub')
  if (sub) sub.textContent = `${leve} leve · ${moderado} moderado · ${grave} grave · ${muerte} muerte`
}

function populateSubtypes() {
  const subtypes = [...new Set(_all.map(r => r.incident_subtype).filter(Boolean))].sort()
  const sel = document.getElementById('f-subtype')
  if (!sel) return
  const current = sel.value
  sel.innerHTML = '<option value="">Todos</option>'
  subtypes.forEach(s => {
    const opt = document.createElement('option')
    opt.value = s
    opt.textContent = s
    sel.appendChild(opt)
  })
  sel.value = current
}

function populateYears() {
  const years = [...new Set(_all.map(r => r.incident_date?.slice(0, 4)).filter(Boolean))].sort((a,b) => b-a)
  const sel = document.getElementById('f-year')
  if (!sel) return
  const current = sel.value
  sel.innerHTML = '<option value="">Todos</option>'
  years.forEach(y => {
    const opt = document.createElement('option')
    opt.value = y
    opt.textContent = y
    sel.appendChild(opt)
  })
  if (current) sel.value = current
}

// ── Filtros ─────────────────────────────────────────────────────
function applyFilters() {
  const fType    = document.getElementById('f-type')?.value    || ''
  const fDamage  = document.getElementById('f-damage')?.value  || ''
  const fSubtype = document.getElementById('f-subtype')?.value || ''
  const fMonth   = document.getElementById('f-month')?.value   || ''
  const fYear    = document.getElementById('f-year')?.value    || ''
  const fSearch  = (document.getElementById('f-search')?.value || '').toLowerCase()

  _filtered = _all.filter(r => {
    if (fType    && r.incident_type    !== fType)    return false
    if (fDamage  && r.damage_level     !== fDamage)  return false
    if (fSubtype && r.incident_subtype !== fSubtype) return false
    if (fYear    && r.incident_date?.slice(0, 4)     !== fYear)          return false
    if (fMonth   && String(parseInt(r.incident_date?.slice(5, 7))) !== fMonth) return false
    if (fSearch) {
      const haystack = [r.patient_name, r.description, r.causes,
                        r.immediate_actions, r.incident_subtype].join(' ').toLowerCase()
      if (!haystack.includes(fSearch)) return false
    }
    return true
  })

  renderTable()
}

function clearFilters() {
  ;['f-type','f-damage','f-subtype','f-month','f-year'].forEach(id => {
    const el = document.getElementById(id)
    if (el) el.value = ''
  })
  const s = document.getElementById('f-search')
  if (s) s.value = ''
  applyFilters()
}

// ── Render tabla ────────────────────────────────────────────────
function renderTable() {
  const loading = document.getElementById('state-loading')
  const empty   = document.getElementById('state-empty')
  const table   = document.getElementById('incidents-table')
  const body    = document.getElementById('incidents-body')
  const count   = document.getElementById('table-count')

  loading.style.display = 'none'

  if (_filtered.length === 0) {
    empty.style.display = 'flex'
    table.style.display = 'none'
    count.textContent = '0 registros'
    return
  }

  empty.style.display = 'none'
  table.style.display = 'table'
  count.textContent = `${_filtered.length} registro${_filtered.length !== 1 ? 's' : ''}`

  body.innerHTML = _filtered.map((r, i) => {
    const fecha    = fmtDate(r.incident_date)
    const reported = fmtDateTime(r.reported_at)
    const typeCls  = typeClass(r.incident_type)
    const dmgCls   = damageClass(r.damage_level)

    return `
    <tr class="row-clickable" onclick="openDetail(${_all.indexOf(r)})">
      <td>${fecha}</td>
      <td class="patient-name">${escHtml(r.patient_name || '—')}</td>
      <td><span class="badge badge-${typeCls}">${escHtml(r.incident_type || '—')}</span></td>
      <td class="subtype-cell">${escHtml(r.incident_subtype || '—')}</td>
      <td><span class="badge badge-dmg-${dmgCls}">${escHtml(r.damage_level || '—')}</span></td>
      <td>${escHtml(r.location || '—')}</td>
      <td class="date-small">${reported}</td>
      <td><button class="btn-detail" onclick="openDetail(${_all.indexOf(r)});event.stopPropagation()">
        <i class="fa-solid fa-eye"></i>
      </button></td>
    </tr>`
  }).join('')
}

// ── Modal detalle ────────────────────────────────────────────────
function openDetail(idx) {
  const r = _all[idx]
  if (!r) return

  const badge = document.getElementById('detail-type-badge')
  const body  = document.getElementById('modal-detail-body')

  badge.innerHTML = `<span class="badge badge-${typeClass(r.incident_type)}">${escHtml(r.incident_type)}</span>`

  const dob = r.patient_dob ? fmtDate(r.patient_dob) : '—'
  const attachHtml = r.attachments
    ? r.attachments.split(',').map(url => url.trim()).filter(Boolean).map((url, i) =>
        `<a href="${url}" target="_blank" rel="noopener" class="attach-link">
          <i class="fa-brands fa-google-drive"></i> Adjunto ${i+1}
        </a>`
      ).join('')
    : '—'

  body.innerHTML = `
    <div class="detail-grid">
      <div class="detail-section">
        <div class="detail-title"><i class="fa-solid fa-user"></i> Datos del Paciente</div>
        <div class="detail-row"><span>Nombre</span><strong>${escHtml(r.patient_name || '—')}</strong></div>
        <div class="detail-row"><span>Fecha de nacimiento</span><strong>${dob}</strong></div>
        <div class="detail-row"><span>Sexo</span><strong>${escHtml(r.patient_sex || '—')}</strong></div>
      </div>

      <div class="detail-section">
        <div class="detail-title"><i class="fa-solid fa-calendar-day"></i> Datos del Incidente</div>
        <div class="detail-row"><span>Fecha</span><strong>${fmtDate(r.incident_date)}</strong></div>
        <div class="detail-row"><span>Hora</span><strong>${escHtml(r.incident_time || '—')}</strong></div>
        <div class="detail-row"><span>Ubicación</span><strong>${escHtml(r.location || '—')}</strong></div>
        <div class="detail-row"><span>Tipo</span>
          <strong><span class="badge badge-${typeClass(r.incident_type)}">${escHtml(r.incident_type || '—')}</span></strong>
        </div>
        <div class="detail-row"><span>Subtipo</span><strong>${escHtml(r.incident_subtype || '—')}</strong></div>
        <div class="detail-row"><span>Nivel de daño</span>
          <strong><span class="badge badge-dmg-${damageClass(r.damage_level)}">${escHtml(r.damage_level || '—')}</span></strong>
        </div>
        <div class="detail-row"><span>Reportado el</span><strong>${fmtDateTime(r.reported_at)}</strong></div>
      </div>
    </div>

    <div class="detail-section full-width">
      <div class="detail-title"><i class="fa-solid fa-file-lines"></i> Descripción</div>
      <p class="detail-text">${escHtml(r.description || '—')}</p>
    </div>

    <div class="detail-cols">
      <div class="detail-section">
        <div class="detail-title"><i class="fa-solid fa-magnifying-glass"></i> Causas</div>
        <p class="detail-text">${escHtml(r.causes || '—')}</p>
      </div>
      <div class="detail-section">
        <div class="detail-title"><i class="fa-solid fa-list"></i> Factores Contribuyentes</div>
        <p class="detail-text">${escHtml(r.contributing_factors || '—')}</p>
      </div>
      <div class="detail-section">
        <div class="detail-title"><i class="fa-solid fa-shield"></i> Factores Mitigantes</div>
        <p class="detail-text">${escHtml(r.mitigating_factors || '—')}</p>
      </div>
      <div class="detail-section">
        <div class="detail-title"><i class="fa-solid fa-bolt"></i> Acciones Inmediatas</div>
        <p class="detail-text">${escHtml(r.immediate_actions || '—')}</p>
      </div>
    </div>

    ${r.attachments ? `
    <div class="detail-section full-width">
      <div class="detail-title"><i class="fa-solid fa-paperclip"></i> Adjuntos</div>
      <div class="attach-links">${attachHtml}</div>
    </div>` : ''}
  `

  document.getElementById('modal-detail').classList.add('open')
}

function closeModal(id) {
  document.getElementById(id).classList.remove('open')
}

function closeDetail(e) {
  if (e.target === document.getElementById('modal-detail')) closeModal('modal-detail')
}

// ── Utilidades ───────────────────────────────────────────────────
function typeClass(t) {
  if (t === 'Cuasi Falla')       return 'yellow'
  if (t === 'Evento Adverso')    return 'red'
  if (t === 'Consulta')          return 'blue'
  return 'gray'
}

function damageClass(d) {
  if (d === 'Sin Daño')  return 'none'
  if (d === 'Leve')      return 'leve'
  if (d === 'Moderado')  return 'moderado'
  if (d === 'Grave')     return 'grave'
  if (d === 'Muerte')    return 'muerte'
  return 'gray'
}

function fmtDate(s) {
  if (!s) return '—'
  const d = new Date(s + (s.includes('T') ? '' : 'T00:00:00'))
  return d.toLocaleDateString('es-MX', { day:'2-digit', month:'short', year:'numeric' })
}

function fmtDateTime(s) {
  if (!s) return '—'
  return new Date(s).toLocaleDateString('es-MX', { day:'2-digit', month:'short', year:'numeric' })
}

function escHtml(s) {
  return String(s)
    .replace(/&/g,'&amp;')
    .replace(/</g,'&lt;')
    .replace(/>/g,'&gt;')
    .replace(/"/g,'&quot;')
}

function setText(id, val) {
  const el = document.getElementById(id)
  if (el) el.textContent = val
}

function logout() {
  db.auth.signOut().then(() => { window.location.href = 'index.html' })
}

// ── Arranque ─────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', initEA)
