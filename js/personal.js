// ─── Personal — Directorio de empleados ─────────────────────────

let _allPersonal = []
let _filtered    = []

// ── Init ────────────────────────────────────────────────────────
async function initPersonal() {
  const auth = await requireAuth()
  if (!auth) return

  setText('sb-user-name', auth.profile?.full_name || auth.user.email.split('@')[0])
  setText('sb-user-role', auth.profile?.roles?.display_name || 'Usuario')

  // Todos los roles pueden ver el directorio
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

  populateDeptFilter()
  updateKPIs()
  renderTable()
}

// ── Poblar select de departamentos ──────────────────────────────
function populateDeptFilter() {
  const depts = [...new Set(_allPersonal.map(p => p.departamento))].sort()
  const sel   = document.getElementById('select-dept')
  depts.forEach(d => {
    const opt = document.createElement('option')
    opt.value = d
    opt.textContent = d.charAt(0) + d.slice(1).toLowerCase()
    sel.appendChild(opt)
  })
}

// ── Filtros ─────────────────────────────────────────────────────
function applyFilters() {
  const q    = document.getElementById('input-search').value.trim().toLowerCase()
  const dept = document.getElementById('select-dept').value

  _filtered = _allPersonal.filter(p => {
    const matchQ    = !q || p.nombre.toLowerCase().includes(q) || p.puesto.toLowerCase().includes(q)
    const matchDept = !dept || p.departamento === dept
    return matchQ && matchDept
  })

  const hasFilter = q || dept
  document.getElementById('btn-clear').style.display = hasFilter ? '' : 'none'

  updateKPIs()
  renderTable()
}

function clearFilters() {
  document.getElementById('input-search').value = ''
  document.getElementById('select-dept').value  = ''
  document.getElementById('btn-clear').style.display = 'none'
  _filtered = _allPersonal
  updateKPIs()
  renderTable()
}

// ── KPIs ────────────────────────────────────────────────────────
function updateKPIs() {
  const depts = new Set(_allPersonal.map(p => p.departamento)).size
  document.getElementById('kpi-total').textContent    = _allPersonal.length
  document.getElementById('kpi-depts').textContent    = depts
  document.getElementById('kpi-filtered').textContent = _filtered.length
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

  const rows = _filtered.map(p => {
    const iniciales = p.nombre.split(' ').slice(0, 2).map(n => n[0]).join('')
    const deptLabel = p.departamento.charAt(0) + p.departamento.slice(1).toLowerCase()
    return `
      <tr>
        <td class="col-codigo"><span class="badge-codigo">${p.codigo}</span></td>
        <td class="col-nombre">
          <div class="nombre-wrap">
            <div class="avatar-iniciales">${iniciales}</div>
            <span>${formatNombre(p.nombre)}</span>
          </div>
        </td>
        <td class="col-dept"><span class="badge-dept">${deptLabel}</span></td>
        <td class="col-puesto">${formatNombre(p.puesto)}</td>
      </tr>`
  })

  tbody.innerHTML = rows.join('')
}

// Capitaliza correctamente "GARCIA LOPEZ JUAN" → "Garcia Lopez Juan"
function formatNombre(str) {
  return str.split(' ').map(w => w.charAt(0) + w.slice(1).toLowerCase()).join(' ')
}

// ── Sidebar toggle ───────────────────────────────────────────────
function toggleSidebar() {
  document.getElementById('sidebar').classList.toggle('open')
}

// ── Logout ───────────────────────────────────────────────────────
async function logout() {
  await db.auth.signOut()
  window.location.href = 'index.html'
}

// ── Arranque ─────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', initPersonal)
