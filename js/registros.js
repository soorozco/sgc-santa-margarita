// ─── Control de Registros (Formatos FT) ─────────────────────

let _allRegistros = []
let _filtered     = []

// ── Init ────────────────────────────────────────────────────
async function initRegistros() {
  const auth = await requireAuth()
  if (!auth) return

  setText('sb-user-name', auth.profile?.full_name || auth.user.email.split('@')[0])
  setText('sb-user-role', auth.profile?.roles?.display_name || 'Usuario')

  document.getElementById('content-area').style.display = 'block'
  await loadRegistros()
}

function setText(id, val) {
  const el = document.getElementById(id)
  if (el) el.textContent = val
}

// ── Carga datos ─────────────────────────────────────────────
async function loadRegistros() {
  const { data, error } = await db
    .from('documents')
    .select(`
      code,
      name,
      current_version,
      status,
      retention_years,
      departments ( name ),
      document_types!inner ( code_prefix )
    `)
    .eq('document_types.code_prefix', 'FT')
    .order('code')

  if (error) {
    document.getElementById('reg-tbody').innerHTML =
      `<tr><td colspan="6" class="table-error">
         <i class="fa-solid fa-circle-exclamation"></i> Error al cargar: ${error.message}
       </td></tr>`
    return
  }

  _allRegistros = (data || []).map(d => ({
    code:      d.code,
    name:      d.name,
    version:   d.current_version,
    status:    d.status,
    retention: d.retention_years,
    dept:      d.departments?.name || '—'
  }))

  _filtered = _allRegistros

  populateFilters()
  updateKPIs()
  renderTable()
}

// ── Filtros select ───────────────────────────────────────────
function populateFilters() {
  const depts = [...new Set(_allRegistros.map(r => r.dept))].sort()
  const sel = document.getElementById('select-dept')
  depts.forEach(d => {
    const opt = document.createElement('option')
    opt.value = d
    opt.textContent = cap(d)
    sel.appendChild(opt)
  })
}

// ── Aplicar filtros ──────────────────────────────────────────
function applyFilters() {
  const q    = document.getElementById('input-search').value.trim().toLowerCase()
  const dept = document.getElementById('select-dept').value
  const ret  = document.getElementById('select-ret').value

  _filtered = _allRegistros.filter(r => {
    const matchQ    = !q    || r.name.toLowerCase().includes(q) || r.code.toLowerCase().includes(q)
    const matchDept = !dept || r.dept === dept
    const matchRet  = !ret  ||
      (ret === 'sin' && r.retention == null) ||
      (ret === 'con' && r.retention != null)
    return matchQ && matchDept && matchRet
  })

  const hasFilter = q || dept || ret
  document.getElementById('btn-clear').style.display = hasFilter ? '' : 'none'

  updateKPIs()
  renderTable()
}

function clearFilters() {
  document.getElementById('input-search').value = ''
  document.getElementById('select-dept').value  = ''
  document.getElementById('select-ret').value   = ''
  document.getElementById('btn-clear').style.display = 'none'
  _filtered = _allRegistros
  updateKPIs()
  renderTable()
}

// ── KPIs ────────────────────────────────────────────────────
function updateKPIs() {
  const depts  = new Set(_allRegistros.map(r => r.dept)).size
  const sinRet = _allRegistros.filter(r => r.retention == null).length
  setText('kpi-total',    _allRegistros.length)
  setText('kpi-depts',    depts)
  setText('kpi-sin-ret',  sinRet)
  setText('kpi-filtered', _filtered.length)
}

// ── Render tabla ─────────────────────────────────────────────
function renderTable() {
  const tbody = document.getElementById('reg-tbody')
  const empty = document.getElementById('empty-state')

  if (_filtered.length === 0) {
    tbody.innerHTML = ''
    empty.style.display = 'flex'
    return
  }

  empty.style.display = 'none'

  tbody.innerHTML = _filtered.map(r => {
    const retLabel = r.retention != null
      ? `<span class="badge-ret">${r.retention} año${r.retention !== 1 ? 's' : ''}</span>`
      : `<span class="badge-ret badge-ret--sin">Sin definir</span>`

    const statusClass = r.status === 'vigente' ? 'badge-status--vigente'
      : r.status === 'obsoleto' ? 'badge-status--obsoleto'
      : 'badge-status--otro'

    return `
      <tr>
        <td class="col-codigo"><span class="badge-codigo">${r.code}</span></td>
        <td class="col-nombre">${cap(r.name)}</td>
        <td class="col-dept"><span class="badge-dept">${cap(r.dept)}</span></td>
        <td class="col-ver">${r.version}</td>
        <td class="col-ret">${retLabel}</td>
        <td class="col-estado"><span class="badge-status ${statusClass}">${cap(r.status)}</span></td>
      </tr>`
  }).join('')
}

// Capitaliza
function cap(str) {
  if (!str) return '—'
  return str.split(' ').map(w => w.charAt(0).toUpperCase() + w.slice(1).toLowerCase()).join(' ')
}

// ── Sidebar toggle ───────────────────────────────────────────
function toggleSidebar() {
  document.getElementById('sidebar').classList.toggle('open')
}

// ── Arranque ─────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', initRegistros)
