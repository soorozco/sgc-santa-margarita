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
  populateAreas()
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
        populateAreas()
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
  // Las fichas las pinta applyFilters(), que corre enseguida.
}

// Las fichas reflejan SIEMPRE lo que quedó tras aplicar los filtros,
// igual que las gráficas y la tabla.
function updateKPIs() {
  const base    = _filtered
  const total   = base.length
  const cuasi   = base.filter(r => r.incident_type === 'Cuasi Falla').length
  const adverso = base.filter(r => r.incident_type === 'Evento Adverso').length
  const leve    = base.filter(r => r.damage_level === 'Leve').length
  const moderado= base.filter(r => r.damage_level === 'Moderado').length
  const grave   = base.filter(r => r.damage_level === 'Grave').length
  const muerte  = base.filter(r => r.damage_level === 'Muerte').length
  const dano    = leve + moderado + grave + muerte

  setText('kpi-total',   total)
  setText('kpi-cuasi',   cuasi)
  setText('kpi-adverso', adverso)
  setText('kpi-dano',    dano)
  setText('kpi-grave',   grave)
  setText('kpi-muerte',  muerte)

  const pct = n => total ? ` · ${Math.round(n / total * 100)}%` : ''
  setText('kpi-cuasi-sub',   'detectadas antes de llegar al paciente' + pct(cuasi))
  setText('kpi-adverso-sub', 'sí alcanzaron al paciente' + pct(adverso))

  const sub = document.getElementById('kpi-dano-sub')
  if (sub) {
    sub.textContent = total
      ? `${leve} leve · ${moderado} moderado · ${grave} grave · ${muerte} muerte`
      : 'sin registros en el periodo'
  }
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

function populateAreas() {
  const areas = [...new Set(_all.map(r => r.location).filter(Boolean))]
    .sort((a, b) => a.localeCompare(b, 'es'))
  const sel = document.getElementById('f-area')
  if (!sel) return
  const current = sel.value
  sel.innerHTML = '<option value="">Todas</option>'
  areas.forEach(a => {
    const opt = document.createElement('option')
    opt.value = a
    opt.textContent = a
    sel.appendChild(opt)
  })
  sel.value = current
}

// ── Periodo ─────────────────────────────────────────────────────
// Los preajustes llenan Desde/Hasta; editarlos a mano cambia el
// selector a "Personalizado".
function onPeriodoChange() {
  const p = document.getElementById('f-periodo')?.value || 'todo'
  const desde = document.getElementById('f-desde')
  const hasta = document.getElementById('f-hasta')
  if (!desde || !hasta) return

  if (p === 'custom') { applyFilters(); return }
  if (p === 'todo') { desde.value = ''; hasta.value = ''; applyFilters(); return }

  const hoy = new Date()
  const y = hoy.getFullYear(), m = hoy.getMonth()
  let d1, d2

  switch (p) {
    case 'mes':    d1 = new Date(y, m, 1);      d2 = new Date(y, m + 1, 0); break
    case 'mes-1':  d1 = new Date(y, m - 1, 1);  d2 = new Date(y, m, 0);     break
    case '3m':     d1 = new Date(y, m - 2, 1);  d2 = new Date(y, m + 1, 0); break
    case '6m':     d1 = new Date(y, m - 5, 1);  d2 = new Date(y, m + 1, 0); break
    case '12m':    d1 = new Date(y, m - 11, 1); d2 = new Date(y, m + 1, 0); break
    case 'anio':   d1 = new Date(y, 0, 1);      d2 = new Date(y, 11, 31);   break
    case 'anio-1': d1 = new Date(y - 1, 0, 1);  d2 = new Date(y - 1, 11, 31); break
    default: return
  }
  desde.value = iso(d1)
  hasta.value = iso(d2)
  applyFilters()
}

function onFechaManual() {
  const sel = document.getElementById('f-periodo')
  if (sel) sel.value = 'custom'
  applyFilters()
}

function iso(d) {
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`
}

// ── Filtros ─────────────────────────────────────────────────────
function applyFilters() {
  const fType    = document.getElementById('f-type')?.value    || ''
  const fDamage  = document.getElementById('f-damage')?.value  || ''
  const fSubtype = document.getElementById('f-subtype')?.value || ''
  const fArea    = document.getElementById('f-area')?.value    || ''
  const fDesde   = document.getElementById('f-desde')?.value   || ''
  const fHasta   = document.getElementById('f-hasta')?.value   || ''
  const fSearch  = (document.getElementById('f-search')?.value || '').toLowerCase()

  _filtered = _all.filter(r => {
    const f = r.incident_date || ''
    if (fType    && r.incident_type    !== fType)    return false
    if (fDamage  && r.damage_level     !== fDamage)  return false
    if (fSubtype && r.incident_subtype !== fSubtype) return false
    if (fArea    && r.location         !== fArea)    return false
    if (fDesde   && (!f || f < fDesde)) return false
    if (fHasta   && (!f || f > fHasta)) return false
    if (fSearch) {
      const haystack = [r.patient_name, r.description, r.causes,
                        r.immediate_actions, r.incident_subtype].join(' ').toLowerCase()
      if (!haystack.includes(fSearch)) return false
    }
    return true
  })

  renderPeriodoActivo()
  updateKPIs()
  renderCharts()
  renderTable()
}

function clearFilters() {
  ;['f-type','f-damage','f-subtype','f-area','f-desde','f-hasta'].forEach(id => {
    const el = document.getElementById(id)
    if (el) el.value = ''
  })
  const s = document.getElementById('f-search')
  if (s) s.value = ''
  const p = document.getElementById('f-periodo')
  if (p) p.value = 'todo'
  applyFilters()
}

// Deja ver de un vistazo qué recorte se está mirando
function renderPeriodoActivo() {
  const el = document.getElementById('periodo-activo')
  if (!el) return
  const desde = document.getElementById('f-desde')?.value || ''
  const hasta = document.getElementById('f-hasta')?.value || ''

  const chips = []
  chips.push(desde || hasta
    ? `<span class="chip"><i class="fa-solid fa-calendar-days"></i> ${
        desde ? fmtDate(desde) : 'inicio'} — ${hasta ? fmtDate(hasta) : 'hoy'}</span>`
    : `<span class="chip"><i class="fa-solid fa-calendar-days"></i> Todo el histórico</span>`)

  const extras = [
    ['f-type', 'Tipo'], ['f-damage', 'Daño'],
    ['f-subtype', 'Categoría'], ['f-area', 'Área'],
  ]
  extras.forEach(([id, etq]) => {
    const v = document.getElementById(id)?.value
    if (v) chips.push(`<span class="chip">${etq}: ${escHtml(v)}</span>`)
  })

  chips.push(`<span>${_filtered.length} de ${_all.length} notificaciones</span>`)
  if (!_filtered.length && _all.length) {
    chips.push('<span class="chip warn"><i class="fa-solid fa-circle-info"></i> Sin registros con estos filtros</span>')
  }
  el.innerHTML = chips.join('')
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

// ══════════════════════════════════════════════════════════════════
// GRÁFICAS — todas se recalculan con lo que dejaron los filtros
// ══════════════════════════════════════════════════════════════════
const _charts = {}

// Paleta validada para daltonismo (ver css/eventos-adversos.css)
const C_AZUL = '#2a78d6', C_NARANJA = '#eb6834', C_AQUA = '#1baf7a'
const C_GRIS = '#94a3b8', C_VIOLETA = '#4a3aa7'
const C_DANO = {
  'Sin Daño': '#0ca30c', 'Leve': '#eda100', 'Moderado': '#eb6834',
  'Grave': '#d03b3b', 'Muerte': '#6b1414',
}
const ORDEN_DANO = ['Sin Daño', 'Leve', 'Moderado', 'Grave', 'Muerte']

// La opción "Barreras de comunicación (idioma, cognición)" trae una coma
// dentro. Se reconoce completa antes de partir el resto por comas.
const OPCIONES_CON_COMA = ['Barreras de comunicación (idioma, cognición)']

function partirFactores(valor) {
  let v = valor || ''
  const out = []
  OPCIONES_CON_COMA.forEach(op => {
    if (v.includes(op)) { out.push(op); v = v.replace(op, '') }
  })
  v.split(',').forEach(p => { p = p.trim().replace(/^,|,$/g, ''); if (p) out.push(p) })
  return out
}

function contar(lista, campo) {
  const c = {}
  lista.forEach(r => {
    const k = (r[campo] || '').trim()
    if (k) c[k] = (c[k] || 0) + 1
  })
  return c
}

function contarMulti(lista, campo) {
  const c = {}
  lista.forEach(r => partirFactores(r[campo]).forEach(p => { c[p] = (c[p] || 0) + 1 }))
  return c
}

// La caja se localiza por su atributo data-chart, NO por el <canvas>:
// cuando un filtro deja cero resultados el canvas se sustituye por el
// mensaje de "sin datos", y si buscáramos el canvas la gráfica ya no
// podría reconstruirse al volver a haber datos.
function cajaDe(id) { return document.querySelector(`.chart-box[data-chart="${id}"]`) }

function prepararCaja(id) {
  const caja = cajaDe(id)
  if (!caja) return null
  if (_charts[id]) { _charts[id].destroy(); delete _charts[id] }
  caja.innerHTML = `<canvas id="${id}"></canvas>`
  return document.getElementById(id)
}

function sinDatos(id, msg) {
  const caja = cajaDe(id)
  if (_charts[id]) { _charts[id].destroy(); delete _charts[id] }
  if (caja) caja.innerHTML = `<div class="chart-vacio">${msg}</div>`
}

function renderCharts() {
  if (typeof Chart === 'undefined') return
  chartTipo()
  chartDano()
  chartTendencia()
  chartBarras('ch-factores',    contarMulti(_filtered, 'contributing_factors'), C_NARANJA, 8)
  chartBarras('ch-mitigantes',  contarMulti(_filtered, 'mitigating_factors'),   C_AQUA,    8)
  chartBarras('ch-categoria',   contar(_filtered, 'incident_subtype'),          C_AZUL,    12)
  setText('ch-cat-sub', `${_filtered.length} notificaciones`)
}

// ── Distribución por tipo (dona) ────────────────────────────────
function chartTipo() {
  const c = contar(_filtered, 'incident_type')
  const etiquetas = Object.keys(c).sort((a, b) => c[b] - c[a])
  if (!etiquetas.length) { sinDatos('ch-tipo', 'Sin notificaciones en el periodo'); return }

  const total = etiquetas.reduce((s, k) => s + c[k], 0)
  const color = k => k === 'Cuasi Falla' ? C_AZUL
                   : k === 'Evento Adverso' ? C_NARANJA
                   : k === 'Consulta' ? C_VIOLETA : C_GRIS

  const cv = prepararCaja('ch-tipo')
  if (!cv) return
  _charts['ch-tipo'] = new Chart(cv, {
    type: 'doughnut',
    data: {
      labels: etiquetas.map(k => `${k} — ${c[k]} (${Math.round(c[k] / total * 100)}%)`),
      datasets: [{ data: etiquetas.map(k => c[k]),
                   backgroundColor: etiquetas.map(color), borderWidth: 2, borderColor: '#fff' }],
    },
    options: {
      responsive: true, maintainAspectRatio: false, cutout: '58%',
      plugins: { legend: { position: 'bottom', labels: { boxWidth: 12, padding: 12, font: { size: 11 } } } },
    },
  })

  const cuasi = c['Cuasi Falla'] || 0
  setText('ch-tipo-sub', total
    ? `${Math.round(cuasi / total * 100)}% se detectó antes de llegar al paciente`
    : '')
}

// ── Nivel de daño (barras) ──────────────────────────────────────
function chartDano() {
  const c = contar(_filtered, 'damage_level')
  const presentes = ORDEN_DANO.filter(k => c[k])
  if (!presentes.length) { sinDatos('ch-dano', 'Sin notificaciones en el periodo'); return }

  const total = _filtered.length
  const cv = prepararCaja('ch-dano')
  if (!cv) return
  _charts['ch-dano'] = new Chart(cv, {
    type: 'bar',
    data: {
      labels: presentes,
      datasets: [{ label: 'Notificaciones', data: presentes.map(k => c[k]),
                   backgroundColor: presentes.map(k => C_DANO[k] || C_GRIS), borderRadius: 5 }],
    },
    options: {
      indexAxis: 'y', responsive: true, maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
        tooltip: { callbacks: { label: i => ` ${i.raw} (${Math.round(i.raw / total * 100)}%)` } },
      },
      scales: { x: { beginAtZero: true, ticks: { precision: 0 } } },
    },
  })

  const conDano = total - (c['Sin Daño'] || 0)
  setText('ch-dano-sub', total
    ? `${conDano} con algún daño · ${c['Sin Daño'] || 0} sin daño`
    : '')
}

// ── Tendencia (barras por mes o por día) ────────────────────────
function chartTendencia() {
  const fechas = _filtered.map(r => r.incident_date).filter(Boolean).sort()
  if (!fechas.length) {
    sinDatos('ch-tendencia', 'Sin notificaciones en el periodo')
    setText('ch-tend-sub', '')
    const pie = document.getElementById('ch-tend-foot')
    if (pie) pie.innerHTML = ''
    return
  }

  // Si el recorte cabe en uno o dos meses, se agrupa por día
  const meses = new Set(fechas.map(f => f.slice(0, 7)))
  const porDia = meses.size <= 2
  const clave = f => porDia ? f : f.slice(0, 7)

  const cubos = {}
  fechas.forEach(f => { const k = clave(f); cubos[k] = (cubos[k] || 0) + 1 })

  // Rellena los periodos sin notificaciones para no falsear la tendencia
  const orden = rellenarPeriodos(Object.keys(cubos).sort(), porDia)
  const valores = orden.map(k => cubos[k] || 0)

  const cv = prepararCaja('ch-tendencia')
  if (!cv) return
  _charts['ch-tendencia'] = new Chart(cv, {
    type: 'bar',
    data: {
      labels: orden.map(k => porDia ? fmtDiaCorto(k) : fmtMesCorto(k)),
      datasets: [{ label: 'Notificaciones', data: valores,
                   backgroundColor: C_AZUL, borderRadius: 5 }],
    },
    options: {
      responsive: true, maintainAspectRatio: false,
      plugins: { legend: { display: false } },
      scales: { y: { beginAtZero: true, ticks: { precision: 0 } } },
    },
  })

  setText('ch-tend-sub', porDia ? 'por día' : 'por mes')
  pintarTendencia(valores, porDia)
}

// Completa los meses/días intermedios que no tuvieron notificaciones
function rellenarPeriodos(claves, porDia) {
  if (claves.length < 2) return claves
  const out = []
  if (porDia) {
    const d = new Date(claves[0] + 'T12:00:00')
    const fin = new Date(claves[claves.length - 1] + 'T12:00:00')
    while (d <= fin) { out.push(iso(d)); d.setDate(d.getDate() + 1) }
  } else {
    let [y, m] = claves[0].split('-').map(Number)
    const [fy, fm] = claves[claves.length - 1].split('-').map(Number)
    while (y < fy || (y === fy && m <= fm)) {
      out.push(`${y}-${String(m).padStart(2, '0')}`)
      m++; if (m > 12) { m = 1; y++ }
    }
  }
  return out.length > 400 ? claves : out
}

// Compara la primera mitad del periodo contra la segunda
function pintarTendencia(valores, porDia) {
  const pie = document.getElementById('ch-tend-foot')
  if (!pie) return
  const unidad = porDia ? 'día' : 'mes'

  if (valores.length < 2) {
    pie.innerHTML = `<span class="tend-badge flat">Sin comparación</span>
      Se necesita más de un ${unidad} para calcular la tendencia.`
    return
  }

  const mitad = Math.floor(valores.length / 2)
  const ini = valores.slice(0, mitad)
  const fin = valores.slice(valores.length - mitad)
  const prom = a => a.reduce((s, v) => s + v, 0) / a.length
  const a = prom(ini), b = prom(fin)
  const cambio = a === 0 ? (b > 0 ? 100 : 0) : Math.round((b - a) / a * 100)

  const [cls, ico, txt] =
      cambio > 10  ? ['up',   'fa-arrow-trend-up',   'Al alza']
    : cambio < -10 ? ['down', 'fa-arrow-trend-down', 'A la baja']
    :                ['flat', 'fa-arrows-left-right', 'Estable']

  pie.innerHTML =
    `<span class="tend-badge ${cls}"><i class="fa-solid ${ico}"></i> ${txt} ${
      cambio > 0 ? '+' : ''}${cambio}%</span> ` +
    `Promedio de ${a.toFixed(1)} a ${b.toFixed(1)} notificaciones por ${unidad}, ` +
    `comparando la primera mitad del periodo con la segunda.`
}

// ── Barras horizontales genéricas ───────────────────────────────
function chartBarras(id, conteo, color, tope) {
  const claves = Object.keys(conteo).sort((a, b) => conteo[b] - conteo[a]).slice(0, tope)
  if (!claves.length) { sinDatos(id, 'Sin datos en el periodo'); return }

  const cv = prepararCaja(id)
  if (!cv) return
  _charts[id] = new Chart(cv, {
    type: 'bar',
    data: {
      labels: claves.map(k => k.length > 38 ? k.slice(0, 38) + '…' : k),
      datasets: [{ label: 'Menciones', data: claves.map(k => conteo[k]),
                   backgroundColor: color, borderRadius: 5 }],
    },
    options: {
      indexAxis: 'y', responsive: true, maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
        tooltip: { callbacks: { title: i => claves[i[0].dataIndex] } },
      },
      scales: { x: { beginAtZero: true, ticks: { precision: 0 } },
                y: { ticks: { font: { size: 10.5 } } } },
    },
  })
}

function fmtMesCorto(ym) {
  const [y, m] = ym.split('-')
  const meses = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic']
  return `${meses[+m - 1]} ${y.slice(2)}`
}
function fmtDiaCorto(f) {
  const [, m, d] = f.split('-')
  return `${+d}/${+m}`
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
