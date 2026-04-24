// ─── Dashboard — Hospital Santa Margarita SGC ──────────────────

let _user    = null
let _profile = null

// ── Init ────────────────────────────────────────────────────────
async function initDashboard() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile

  setCurrentDate()
  renderUserInfo()
  await Promise.all([loadKPIs(), loadRecentNC(), loadUpcomingAudits(), loadRecentSurveys()])
  await loadCharts()
}

// ── Fecha actual en español ─────────────────────────────────────
function setCurrentDate() {
  const el = document.getElementById('current-date')
  if (!el) return
  el.textContent = new Date().toLocaleDateString('es-MX', {
    weekday: 'long', day: 'numeric', month: 'long', year: 'numeric'
  })
}

// ── Info del usuario en sidebar ──────────────────────────────────
function renderUserInfo() {
  const name = _profile?.full_name  || _user.email.split('@')[0]
  const role = _profile?.roles?.display_name || 'Usuario'
  const dept = _profile?.departments?.name   || ''

  setText('sb-user-name', name)
  setText('sb-user-role', role)
  const deptEl = document.getElementById('topbar-sub')
  if (deptEl) deptEl.textContent = dept || 'Sistema de Gestión de Calidad'
}

// ── KPIs ─────────────────────────────────────────────────────────
async function loadKPIs() {
  const year  = new Date().getFullYear()
  const today = new Date().toISOString().split('T')[0]

  const [
    { count: ncAbiertas },
    { count: auditorias },
    { count: docsVigentes },
    { data:  surveys },
    { count: accionesVenc },
    { count: indicadores }
  ] = await Promise.all([
    db.from('nonconformities').select('*', { count: 'exact', head: true }).eq('status', 'abierto'),
    db.from('audits').select('*', { count: 'exact', head: true })
      .gte('audit_date', `${year}-01-01`).lte('audit_date', `${year}-12-31`),
    db.from('documents').select('*', { count: 'exact', head: true }).eq('status', 'vigente'),
    db.from('satisfaction_surveys').select('q_servicio_general, would_recommend')
      .not('q_servicio_general', 'is', null)
      .gte('survey_date', `${year}-01-01`),
    db.from('action_plan_items').select('*', { count: 'exact', head: true })
      .lt('due_date', today).not('status', 'in', '("completado","cancelado")'),
    db.from('quality_indicators').select('*', { count: 'exact', head: true }).eq('is_active', true)
  ])

  // Satisfacción promedio — basado en q_servicio_general (1-5) convertido a %
  let satPct = null
  if (surveys && surveys.length > 0) {
    const avg = surveys.reduce((s, r) => s + (r.q_servicio_general || 0), 0) / surveys.length
    satPct = ((avg / 5) * 100).toFixed(1)
  }

  // NC abiertas
  setKPI('card-nc', 'kpi-nc', ncAbiertas ?? 0,
    (ncAbiertas > 0) ? 'c-red' : 'c-green',
    (ncAbiertas > 0) ? `${ncAbiertas} requieren atención` : 'Sin NC pendientes')

  // Badge del sidebar
  const badge = document.getElementById('badge-nc')
  if (badge) {
    badge.textContent = ncAbiertas ?? 0
    badge.style.display = (ncAbiertas > 0) ? 'inline' : 'none'
  }

  // Auditorías
  setKPI('card-auditorias', 'kpi-auditorias', auditorias ?? 0, 'c-blue', `Año ${year}`)

  // Documentos
  setKPI('card-docs', 'kpi-docs', docsVigentes ?? 0, 'c-green', 'En lista maestra')

  // Satisfacción
  const satColor = satPct === null ? 'c-gray'
                 : satPct >= 90   ? 'c-green'
                 : satPct >= 70   ? 'c-orange' : 'c-red'
  const recYes = surveys ? surveys.filter(s => s.would_recommend === true).length : 0
  setKPI('card-satisfaccion', 'kpi-satisfaccion',
    satPct !== null ? `${satPct}%` : '—',
    satColor,
    satPct !== null ? `${surveys.length} encuestas · ${recYes} recomendarían` : 'Sin encuestas registradas')

  // Acciones vencidas
  setKPI('card-vencidas', 'kpi-vencidas', accionesVenc ?? 0,
    (accionesVenc > 0) ? 'c-red' : 'c-green',
    (accionesVenc > 0) ? 'Planes fuera de fecha' : 'Al día')

  // Indicadores
  setKPI('card-indicadores', 'kpi-indicadores', indicadores ?? 0, 'c-cyan', 'En seguimiento')
}

function setKPI(cardId, valId, value, colorClass, sub) {
  const card = document.getElementById(cardId)
  const val  = document.getElementById(valId)
  const subEl = card?.querySelector('.kpi-sub')
  if (card) {
    // Quitar colores previos
    card.classList.remove('c-red','c-green','c-blue','c-orange','c-cyan','c-gray')
    card.classList.add(colorClass)
  }
  if (val)  val.textContent  = value
  if (subEl && sub) subEl.textContent = sub
}

// ── Charts ───────────────────────────────────────────────────────
async function loadCharts() {
  await Promise.all([chartNC(), chartDocs(), chartSatisfaccion()])
}

async function chartNC() {
  const { data } = await db.from('nonconformities').select('status')
  const counts = { abierto: 0, en_proceso: 0, pendiente_verificacion: 0, cerrado: 0 }
  if (data) data.forEach(r => { if (r.status in counts) counts[r.status]++ })

  const ctx = document.getElementById('chart-nc')?.getContext('2d')
  if (!ctx) return

  new Chart(ctx, {
    type: 'doughnut',
    data: {
      labels: ['Abierto', 'En Proceso', 'Pend. Verif.', 'Cerrado'],
      datasets: [{
        data: [counts.abierto, counts.en_proceso, counts.pendiente_verificacion, counts.cerrado],
        backgroundColor: ['#dc2626', '#d97706', '#2563eb', '#16a34a'],
        borderWidth: 0,
        hoverOffset: 6
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      cutout: '65%',
      plugins: {
        legend: { position: 'bottom', labels: { padding: 14, font: { size: 11, family: 'Inter' } } }
      }
    }
  })
}

async function chartDocs() {
  const statuses = ['borrador', 'en_revision', 'en_aprobacion', 'vigente', 'obsoleto']
  const labels   = ['Borrador', 'En Revisión', 'En Aprobación', 'Vigente', 'Obsoleto']
  const colors   = ['#94a3b8', '#d97706', '#2563eb', '#16a34a', '#dc2626']

  const counts = await Promise.all(
    statuses.map(s =>
      db.from('documents').select('*', { count: 'exact', head: true }).eq('status', s)
        .then(({ count }) => count ?? 0)
    )
  )

  const ctx = document.getElementById('chart-docs')?.getContext('2d')
  if (!ctx) return

  new Chart(ctx, {
    type: 'bar',
    data: {
      labels,
      datasets: [{
        label: 'Documentos',
        data: counts,
        backgroundColor: colors,
        borderRadius: 6,
        borderSkipped: false
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: { legend: { display: false } },
      scales: {
        y: { beginAtZero: true, ticks: { stepSize: 1 }, grid: { color: '#f1f5f9' } },
        x: { grid: { display: false } }
      }
    }
  })
}

async function chartSatisfaccion() {
  const labels    = []
  const avgScores = []

  for (let i = 5; i >= 0; i--) {
    const d     = new Date()
    d.setMonth(d.getMonth() - i)
    const y     = d.getFullYear()
    const m     = (d.getMonth() + 1).toString().padStart(2, '0')
    const last  = new Date(y, d.getMonth() + 1, 0).getDate()

    labels.push(d.toLocaleString('es-MX', { month: 'short', year: '2-digit' }))

    const { data } = await db
      .from('satisfaction_surveys')
      .select('q_servicio_general')
      .gte('survey_date', `${y}-${m}-01`)
      .lte('survey_date', `${y}-${m}-${last}`)
      .not('q_servicio_general', 'is', null)

    if (data && data.length > 0) {
      const avg = data.reduce((s, r) => s + (r.q_servicio_general || 0), 0) / data.length
      avgScores.push(Math.round((avg / 5 * 100) * 10) / 10)
    } else {
      avgScores.push(null)
    }
  }

  const ctx = document.getElementById('chart-satisfaction')?.getContext('2d')
  if (!ctx) return

  new Chart(ctx, {
    type: 'line',
    data: {
      labels,
      datasets: [
        {
          label: 'Satisfacción %',
          data: avgScores,
          borderColor: '#16a34a',
          backgroundColor: 'rgba(22,163,74,0.08)',
          tension: 0.4,
          fill: true,
          pointBackgroundColor: '#16a34a',
          pointRadius: 5,
          spanGaps: true
        },
        {
          label: 'Meta 90%',
          data: Array(6).fill(90),
          borderColor: '#dc2626',
          borderDash: [5, 4],
          borderWidth: 1.5,
          pointRadius: 0,
          fill: false
        }
      ]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { position: 'bottom', labels: { font: { size: 11, family: 'Inter' }, padding: 14 } },
        tooltip: { callbacks: { label: ctx => `${ctx.dataset.label}: ${ctx.parsed.y ?? 'N/D'}%` } }
      },
      scales: {
        y: {
          min: 0, max: 100,
          ticks: { callback: v => `${v}%` },
          grid: { color: '#f1f5f9' }
        },
        x: { grid: { display: false } }
      }
    }
  })
}

// ── NC recientes ─────────────────────────────────────────────────
async function loadRecentNC() {
  const { data } = await db
    .from('nonconformities')
    .select('folio, finding_description, status, finding_date, departments(name)')
    .order('created_at', { ascending: false })
    .limit(6)

  const el = document.getElementById('recent-nc')
  if (!el) return

  if (!data || data.length === 0) {
    el.innerHTML = emptyState('fa-circle-xmark', 'No hay no conformidades registradas aún.')
    return
  }

  el.innerHTML = data.map(nc => `
    <div class="list-item">
      <div class="list-dot ${statusDot(nc.status)}"></div>
      <div class="list-content">
        <div class="list-title">${nc.folio} — ${trunc(nc.finding_description, 70)}</div>
        <div class="list-meta">
          <span>${nc.departments?.name || 'Sin área'}</span>
          <span>·</span>
          <span>${fmtDate(nc.finding_date)}</span>
          <span class="pill ${statusPill(nc.status)}">${statusLabel(nc.status)}</span>
        </div>
      </div>
    </div>
  `).join('')
}

// ── Próximas auditorías ──────────────────────────────────────────
async function loadUpcomingAudits() {
  const today = new Date().toISOString().split('T')[0]

  const { data } = await db
    .from('audits')
    .select('audit_number, objective, audit_date, status, departments:audit_departments(departments(name))')
    .gte('audit_date', today)
    .order('audit_date', { ascending: true })
    .limit(5)

  const el = document.getElementById('upcoming-audits')
  if (!el) return

  if (!data || data.length === 0) {
    el.innerHTML = emptyState('fa-calendar-check', 'No hay auditorías próximas programadas.')
    return
  }

  el.innerHTML = data.map(a => `
    <div class="list-item">
      <div class="list-dot blue"></div>
      <div class="list-content">
        <div class="list-title">${a.audit_number} — ${trunc(a.objective, 60)}</div>
        <div class="list-meta">
          <span>${fmtDate(a.audit_date)}</span>
          <span class="pill ${statusPill(a.status)}">${auditLabel(a.status)}</span>
        </div>
      </div>
    </div>
  `).join('')
}

// ── Encuestas recientes ───────────────────────────────────────────
async function loadRecentSurveys() {
  const { data } = await db
    .from('satisfaction_surveys')
    .select('patient_name, area, survey_date, q_servicio_general, would_recommend, comment_type')
    .order('survey_date', { ascending: false })
    .limit(5)

  const el = document.getElementById('recent-surveys')
  if (!el) return

  if (!data || data.length === 0) {
    el.innerHTML = emptyState('fa-face-smile', 'No hay encuestas registradas aún.')
    return
  }

  el.innerHTML = data.map(s => {
    const score = s.q_servicio_general
    const pct   = score ? Math.round((score / 5) * 100) : null
    const color = pct === null ? 'gray' : pct >= 80 ? 'green' : pct >= 60 ? 'orange' : 'red'
    const ct    = (s.comment_type || '').toUpperCase()
    const ctBadge = ct === 'QUEJA' ? '<span class="pill pill-red">Queja</span>'
                  : ct === 'SUGERENCIA' ? '<span class="pill pill-orange">Sugerencia</span>'
                  : ct === 'FELICITACION' ? '<span class="pill pill-green">Felicitación</span>' : ''
    return `
    <div class="list-item" style="cursor:pointer" onclick="window.location='satisfaccion.html'">
      <div class="list-dot ${color}"></div>
      <div class="list-content">
        <div class="list-title">${esc(s.patient_name || 'Anónimo')} — ${esc(s.area || '—')}</div>
        <div class="list-meta">
          <span>${fmtDate(s.survey_date)}</span>
          ${pct !== null ? `<span>·</span><span style="font-weight:600;color:var(--${color === 'green' ? 'green' : color === 'orange' ? 'orange' : 'red'})">${pct}%</span>` : ''}
          ${s.would_recommend === false ? '<span class="pill pill-red">No recomendaría</span>' : ''}
          ${ctBadge}
        </div>
      </div>
    </div>`
  }).join('')
}

function esc(s) {
  if (!s) return ''
  return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}

// ── Helpers ───────────────────────────────────────────────────────
function setText(id, val) {
  const el = document.getElementById(id)
  if (el) el.textContent = val
}

function trunc(str, len) {
  if (!str) return '—'
  return str.length > len ? str.substring(0, len) + '...' : str
}

function fmtDate(d) {
  if (!d) return '—'
  return new Date(d + 'T12:00:00').toLocaleDateString('es-MX', {
    day: '2-digit', month: 'short', year: 'numeric'
  })
}

function statusDot(s) {
  return { abierto:'red', en_proceso:'orange', pendiente_verificacion:'blue',
           cerrado:'green', cancelado:'gray' }[s] || 'gray'
}

function statusPill(s) {
  return { abierto:'pill-red', en_proceso:'pill-orange', pendiente_verificacion:'pill-blue',
           cerrado:'pill-green', cancelado:'pill-gray',
           planificada:'pill-blue', en_curso:'pill-orange', completada:'pill-green' }[s] || 'pill-gray'
}

function statusLabel(s) {
  return { abierto:'Abierto', en_proceso:'En Proceso', pendiente_verificacion:'Pend. Verif.',
           cerrado:'Cerrado', cancelado:'Cancelado' }[s] || s
}

function auditLabel(s) {
  return { planificada:'Planificada', en_curso:'En Curso', completada:'Completada',
           cancelada:'Cancelada' }[s] || s
}

function emptyState(icon, msg) {
  return `<div class="empty"><i class="fa-solid ${icon}"></i>${msg}</div>`
}

// ── Arrancar ──────────────────────────────────────────────────────
initDashboard()
