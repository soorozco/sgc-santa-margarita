// ─── Libros Electrónicos — Dashboard de existencias y movimientos ─
// Lee todos los movimientos de pharmacy_ledger_entries y calcula, en el
// navegador, existencias por medicamento, salidas, entradas y tendencias.
// Todo en CAJAS, la misma unidad con la que se capturan los movimientos.

let _user = null, _profile = null, _role = null
let _entries = []
let _porMed = []      // [{med, grupo, entrada, salida, existencia, movs, ultima}]
const _charts = {}

const GRUPOS = { I: 'Grupo I', II: 'Grupo II', III: 'Grupo III' }
const EXISTENCIA_BAJA = 3   // cajas: umbral para marcar "por agotarse"

// ── Init ────────────────────────────────────────────────────────
async function initDash() {
  const auth = await requireAuth()
  if (!auth?.user) return
  _user = auth.user; _profile = auth.profile
  _role = auth.profile?.roles?.name || 'lector'

  requirePermission(_profile, 'libros_electronicos')

  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
  const dateEl = document.getElementById('current-date')
  if (dateEl) dateEl.textContent = new Date().toLocaleDateString('es-MX',
    { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })

  await cargar()
}

async function cargar() {
  const { data, error } = await db.from('pharmacy_ledger_entries')
    .select('*')
    .order('fecha', { ascending: true })

  if (error) {
    document.getElementById('dash-body').innerHTML = `
      <div class="dash-empty">
        <i class="fa-solid fa-triangle-exclamation"></i>
        <p>No se pudieron leer los movimientos: ${esc(error.message)}${
          error.message.includes('pharmacy_ledger_entries')
            ? '<br><small>Falta ejecutar la migración sql/libros_electronicos_setup.sql en Supabase.</small>' : ''}</p>
      </div>`
    return
  }

  _entries = data || []

  if (!_entries.length) {
    document.getElementById('dash-body').innerHTML = `
      <div class="dash-empty">
        <i class="fa-solid fa-book-open"></i>
        <p>Todavía no hay movimientos capturados en los libros.<br>
        <small>Registra entradas y salidas en «Libros por Medicamento» y aquí verás las estadísticas.</small></p>
      </div>`
    return
  }

  calcular()
  pintarKPIs()
  pintarTabla()
  pintarChartSalidas()
  pintarChartMes()
  pintarChartGrupo()
}

// ── Cálculo ─────────────────────────────────────────────────────
function calcular() {
  const map = new Map()
  _entries.forEach(e => {
    const med = e.medicamento
    if (!map.has(med)) {
      map.set(med, {
        med, grupo: e.grupo || grupoDeMedicamento(med) || '—',
        entrada: 0, salida: 0, movs: 0, ultima: null,
      })
    }
    const m = map.get(med)
    m.entrada += num(e.entrada)
    m.salida  += num(e.salida)
    m.movs++
    if (!m.ultima || e.fecha > m.ultima) m.ultima = e.fecha
  })

  _porMed = [...map.values()].map(m => ({ ...m, existencia: m.entrada - m.salida }))
  _porMed.sort((a, b) => a.med.localeCompare(b.med, 'es'))
}

// ── KPIs ────────────────────────────────────────────────────────
function pintarKPIs() {
  const ym = new Date().toISOString().slice(0, 7)
  let salidaMes = 0, entradaMes = 0
  _entries.forEach(e => {
    if ((e.fecha || '').slice(0, 7) === ym) {
      salidaMes += num(e.salida); entradaMes += num(e.entrada)
    }
  })

  const existenciaTotal = _porMed.reduce((s, m) => s + m.existencia, 0)
  const librosActivos   = _porMed.length
  const alertas = _porMed.filter(m => m.existencia <= EXISTENCIA_BAJA).length

  setText('kpi-existencia', fmt(existenciaTotal))
  setText('kpi-libros', librosActivos)
  setText('kpi-salidas-mes', fmt(salidaMes))
  setText('kpi-entradas-mes', fmt(entradaMes))
  setText('kpi-alertas', alertas)

  const alertCard = document.getElementById('kpi-alertas-card')
  if (alertCard) alertCard.classList.toggle('kpi-danger', alertas > 0)
}

// ── Tabla de existencias ────────────────────────────────────────
function pintarTabla() {
  const tbody = document.getElementById('exist-body')
  // Orden: primero lo más crítico (menor existencia)
  const filas = [..._porMed].sort((a, b) => a.existencia - b.existencia)

  tbody.innerHTML = filas.map(m => {
    const nivel = m.existencia <= 0 ? 'agotado'
                : m.existencia <= EXISTENCIA_BAJA ? 'bajo' : 'ok'
    const badge = { agotado: 'Agotado', bajo: 'Por agotarse', ok: 'Suficiente' }[nivel]
    return `
      <tr>
        <td>${esc(m.med)}</td>
        <td style="text-align:center">${esc(GRUPOS[m.grupo] || m.grupo)}</td>
        <td style="text-align:center;color:#0f766e;font-weight:600">${fmt(m.entrada)}</td>
        <td style="text-align:center;color:#b91c1c;font-weight:600">${fmt(m.salida)}</td>
        <td style="text-align:center;font-weight:800">${fmt(m.existencia)}</td>
        <td style="text-align:center"><span class="exist-badge b-${nivel}">${badge}</span></td>
        <td style="text-align:center;color:#64748b;font-variant-numeric:tabular-nums">${fmtFecha(m.ultima)}</td>
      </tr>`
  }).join('')

  setText('exist-count', `${filas.length} libro${filas.length !== 1 ? 's' : ''}`)
}

// ── Gráfica: top salidas ────────────────────────────────────────
function pintarChartSalidas() {
  const top = [..._porMed].filter(m => m.salida > 0)
    .sort((a, b) => b.salida - a.salida).slice(0, 8)
  const ctx = document.getElementById('chart-salidas')
  if (!ctx) return

  if (!top.length) { marcarVacio(ctx, 'Sin salidas registradas'); return }

  _charts.salidas?.destroy()
  _charts.salidas = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: top.map(m => nombreCorto(m.med)),
      datasets: [{
        label: 'Salidas (cajas)',
        data: top.map(m => m.salida),
        backgroundColor: '#0d9488', borderRadius: 6,
      }],
    },
    options: {
      indexAxis: 'y', responsive: true, maintainAspectRatio: false,
      plugins: { legend: { display: false },
        tooltip: { callbacks: { title: i => top[i[0].dataIndex].med } } },
      scales: { x: { beginAtZero: true, ticks: { precision: 0 } } },
    },
  })
}

// ── Gráfica: entradas vs salidas por mes ────────────────────────
function pintarChartMes() {
  const meses = new Map()   // 'YYYY-MM' → {entrada, salida}
  _entries.forEach(e => {
    const ym = (e.fecha || '').slice(0, 7)
    if (!ym) return
    if (!meses.has(ym)) meses.set(ym, { entrada: 0, salida: 0 })
    const o = meses.get(ym)
    o.entrada += num(e.entrada); o.salida += num(e.salida)
  })
  const orden = [...meses.keys()].sort().slice(-12)
  const ctx = document.getElementById('chart-mes')
  if (!ctx) return

  if (!orden.length) { marcarVacio(ctx, 'Sin datos por mes'); return }

  _charts.mes?.destroy()
  _charts.mes = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: orden.map(fmtMes),
      datasets: [
        { label: 'Entradas', data: orden.map(m => meses.get(m).entrada), backgroundColor: '#0d9488', borderRadius: 5 },
        { label: 'Salidas',  data: orden.map(m => meses.get(m).salida),  backgroundColor: '#dc2626', borderRadius: 5 },
      ],
    },
    options: {
      responsive: true, maintainAspectRatio: false,
      plugins: { legend: { position: 'bottom' } },
      scales: { y: { beginAtZero: true, ticks: { precision: 0 } } },
    },
  })
}

// ── Gráfica: existencia por grupo ───────────────────────────────
function pintarChartGrupo() {
  const porGrupo = { I: 0, II: 0, III: 0 }
  _porMed.forEach(m => { if (m.grupo in porGrupo) porGrupo[m.grupo] += Math.max(0, m.existencia) })
  const ctx = document.getElementById('chart-grupo')
  if (!ctx) return

  const vals = [porGrupo.I, porGrupo.II, porGrupo.III]
  if (vals.every(v => v === 0)) { marcarVacio(ctx, 'Sin existencias'); return }

  _charts.grupo?.destroy()
  _charts.grupo = new Chart(ctx, {
    type: 'doughnut',
    data: {
      labels: ['Grupo I', 'Grupo II', 'Grupo III'],
      datasets: [{ data: vals, backgroundColor: ['#0d9488', '#6366f1', '#f59e0b'], borderWidth: 0 }],
    },
    options: {
      responsive: true, maintainAspectRatio: false, cutout: '62%',
      plugins: { legend: { position: 'bottom' } },
    },
  })
}

// ── Utilidades ──────────────────────────────────────────────────
function num(v) { const n = Number(v); return Number.isFinite(n) ? n : 0 }
function fmt(n) { return num(n).toLocaleString('es-MX') }

function nombreCorto(med) {
  // "Fentanilo (Fenodid) 0.25mg/5ml caja c/6 amp" → "Fentanilo 0.25mg/5ml"
  const s = String(med).replace(/\s*\([^)]*\)\s*/, ' ').replace(/\s+/g, ' ').trim()
  return s.length > 32 ? s.slice(0, 32) + '…' : s
}

function fmtFecha(f) {
  if (!f) return '—'
  const [y, m, d] = f.split('-')
  return `${d}/${m}/${y}`
}

function fmtMes(ym) {
  const [y, m] = ym.split('-')
  const meses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic']
  return `${meses[+m - 1]} ${y.slice(2)}`
}

function marcarVacio(canvas, txt) {
  const wrap = canvas.closest('.chart-wrap')
  if (wrap) wrap.innerHTML = `<div class="chart-empty">${esc(txt)}</div>`
}

function setText(id, v) { const el = document.getElementById(id); if (el) el.textContent = v }
function esc(s) {
  return String(s ?? '').replace(/[&<>"']/g, c =>
    ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]))
}

document.addEventListener('DOMContentLoaded', initDash)
