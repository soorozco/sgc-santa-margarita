// ─── Personal — Directorio de empleados ─────────────────────────

let _allPersonal = []
let _filtered    = []

// Paleta de colores para las barras
const BAR_COLORS = [
  '#2563eb','#7c3aed','#db2777','#ea580c','#16a34a',
  '#0891b2','#ca8a04','#dc2626','#9333ea','#0284c7',
  '#15803d','#b45309','#be185d','#1d4ed8','#7e22ce',
  '#c2410c','#166534','#155e75','#854d0e','#9f1239',
  '#1e40af','#6b21a8','#047857','#92400e'
]

// ── Init ────────────────────────────────────────────────────────
async function initPersonal() {
  const auth = await requireAuth()
  if (!auth) return

  setText('sb-user-name', auth.profile?.full_name || auth.user.email.split('@')[0])
  setText('sb-user-role', auth.profile?.roles?.display_name || 'Usuario')
  // Mostrar nav de solicitudes solo para admin/responsable
  {
    const _navRole = auth.profile?.roles?.name || 'lector'
    if (['administrador','responsable_calidad'].includes(_navRole)) {
      const navSol = document.getElementById('nav-solicitudes')
      if (navSol) navSol.style.display = 'flex'
      db.from('document_deactivation_requests').select('id').eq('status','pending').then(({data}) => {
        const count = data?.length || 0
        const badge = document.getElementById('badge-sol')
        if (badge && count > 0) { badge.textContent = count; badge.style.display = 'inline-flex' }
      })
    }
  }

  document.getElementById('content-area').style.display = 'block'
  await loadPersonal()
}

function setText(id, val) {
  const el = document.getElementById(id)
  if (el) el.textContent = val
}

// ── Carga datos ─────────────────────────────────────────────────
async function loadPersonal() {
  const { data, error } = await db
    .from('personal')
    .select('codigo, nombre, departamento, puesto')
    .eq('activo', true)
    .order('nombre')

  if (error) {
    document.getElementById('personal-tbody').innerHTML =
      `<tr><td colspan="4" class="table-error">
         <i class="fa-solid fa-circle-exclamation"></i> Error al cargar: ${error.message}
       </td></tr>`
    return
  }

  _allPersonal = data || []
  _filtered    = _allPersonal

  populateFilters()
  updateKPIs()
  renderDashboard()
  renderTable()
}

// ── Poblar selects ───────────────────────────────────────────────
function populateFilters() {
  const depts  = [...new Set(_allPersonal.map(p => p.departamento))].sort()
  const puestos = [...new Set(_allPersonal.map(p => p.puesto))].sort()

  const selDept = document.getElementById('select-dept')
  depts.forEach(d => {
    const opt = document.createElement('option')
    opt.value = d
    opt.textContent = cap(d)
    selDept.appendChild(opt)
  })

  const selPuesto = document.getElementById('select-puesto')
  puestos.forEach(p => {
    const opt = document.createElement('option')
    opt.value = p
    opt.textContent = cap(p)
    selPuesto.appendChild(opt)
  })
}

// ── Filtros ─────────────────────────────────────────────────────
function applyFilters() {
  const q      = document.getElementById('input-search').value.trim().toLowerCase()
  const dept   = document.getElementById('select-dept').value
  const puesto = document.getElementById('select-puesto').value

  _filtered = _allPersonal.filter(p => {
    const matchQ      = !q      || p.nombre.toLowerCase().includes(q)
    const matchDept   = !dept   || p.departamento === dept
    const matchPuesto = !puesto || p.puesto === puesto
    return matchQ && matchDept && matchPuesto
  })

  const hasFilter = q || dept || puesto
  document.getElementById('btn-clear').style.display = hasFilter ? '' : 'none'

  updateKPIs()
  renderTable()
}

function clearFilters() {
  document.getElementById('input-search').value   = ''
  document.getElementById('select-dept').value    = ''
  document.getElementById('select-puesto').value  = ''
  document.getElementById('btn-clear').style.display = 'none'
  _filtered = _allPersonal
  updateKPIs()
  renderTable()
}

// ── KPIs ────────────────────────────────────────────────────────
function updateKPIs() {
  const depts  = new Set(_allPersonal.map(p => p.departamento)).size
  const puestos = new Set(_allPersonal.map(p => p.puesto)).size
  setText('kpi-total',    _allPersonal.length)
  setText('kpi-depts',    depts)
  setText('kpi-puestos',  puestos)
  setText('kpi-filtered', _filtered.length)
}

// ── Dashboard ────────────────────────────────────────────────────
function renderDashboard() {
  renderDeptChart()
  renderTopPuestos()
}

function renderDeptChart() {
  // Contar por departamento y ordenar de mayor a menor
  const counts = {}
  _allPersonal.forEach(p => { counts[p.departamento] = (counts[p.departamento] || 0) + 1 })
  const sorted = Object.entries(counts).sort((a, b) => b[1] - a[1])
  const max    = sorted[0][1]

  const html = sorted.map(([dept, n], i) => {
    const pct   = Math.round((n / max) * 100)
    const color = BAR_COLORS[i % BAR_COLORS.length]
    return `
      <div class="bar-row">
        <div class="bar-label" title="${cap(dept)}">${cap(dept)}</div>
        <div class="bar-track">
          <div class="bar-fill" style="width:${pct}%;background:${color}"></div>
        </div>
        <div class="bar-count">${n}</div>
      </div>`
  }).join('')

  document.getElementById('dept-chart').innerHTML = html
}

function renderTopPuestos() {
  const counts = {}
  _allPersonal.forEach(p => { counts[p.puesto] = (counts[p.puesto] || 0) + 1 })
  const sorted = Object.entries(counts).sort((a, b) => b[1] - a[1]).slice(0, 10)

  const html = sorted.map(([puesto, n], i) => `
    <div class="top-row">
      <div class="top-rank">${i + 1}</div>
      <div class="top-name">${cap(puesto)}</div>
      <div class="top-badge">${n}</div>
    </div>`
  ).join('')

  document.getElementById('top-puestos').innerHTML = html
}

// ── Render tabla ─────────────────────────────────────────────────
function renderTable() {
  const tbody = document.getElementById('personal-tbody')
  const empty = document.getElementById('empty-state')

  if (_filtered.length === 0) {
    tbody.innerHTML = ''
    empty.style.display = 'flex'
    return
  }

  empty.style.display = 'none'

  tbody.innerHTML = _filtered.map(p => {
    const iniciales = p.nombre.split(' ').slice(0, 2).map(n => n[0]).join('')
    return `
      <tr>
        <td class="col-codigo"><span class="badge-codigo">${p.codigo}</span></td>
        <td class="col-nombre">
          <div class="nombre-wrap">
            <div class="avatar-iniciales">${iniciales}</div>
            <span>${cap(p.nombre)}</span>
          </div>
        </td>
        <td class="col-dept"><span class="badge-dept">${cap(p.departamento)}</span></td>
        <td class="col-puesto">${cap(p.puesto)}</td>
      </tr>`
  }).join('')
}

// Capitaliza: "GARCIA LOPEZ" → "Garcia Lopez"
function cap(str) {
  return str.split(' ').map(w => w.charAt(0).toUpperCase() + w.slice(1).toLowerCase()).join(' ')
}

// ── Sidebar toggle ───────────────────────────────────────────────
function toggleSidebar() {
  document.getElementById('sidebar').classList.toggle('open')
}

// ── Arranque ─────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', initPersonal)
