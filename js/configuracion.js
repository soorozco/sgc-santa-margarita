// ─── Configuración del SGC ──────────────────────────────────────

let _user    = null
let _profile = null
let _role    = null

let _departments = []
let _docTypes    = []

let _editingDeptId    = null
let _editingDocTypeId = null
let _pendingDeleteDeptId    = null
let _pendingDeleteDocTypeId = null

// ── Init ────────────────────────────────────────────────────────
async function initConfig() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  renderUserInfo()

  // Mostrar pestaña de usuarios solo al administrador
  if (_role === 'administrador') {
    const tabBtn = document.getElementById('tab-btn-usuarios')
    if (tabBtn) tabBtn.style.display = ''
  }

  const allowed = ['administrador', 'responsable_calidad']
  if (!allowed.includes(_role)) {
    document.getElementById('cfg-content').innerHTML = `
      <div class="access-denied">
        <i class="fa-solid fa-lock"></i>
        <h3>Acceso restringido</h3>
        <p>Solo administradores y responsables de calidad pueden acceder a esta sección.</p>
      </div>`
    return
  }

  const tasks = [loadDepartments(), loadDocTypes()]
  if (_role === 'administrador') tasks.push(loadUsers(), loadRoles())
  await Promise.all(tasks)
  setupTabs()
}

// ── User info ───────────────────────────────────────────────────
function renderUserInfo() {
  const nameEl = document.getElementById('sb-user-name')
  const roleEl = document.getElementById('sb-user-role')
  if (nameEl) nameEl.textContent = _profile?.full_name || _user.email.split('@')[0]
  if (roleEl) roleEl.textContent = _profile?.roles?.display_name || 'Usuario'
}

// ── Tabs ─────────────────────────────────────────────────────────
function setupTabs() {
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const target = btn.dataset.tab
      document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'))
      document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'))
      btn.classList.add('active')
      document.getElementById('tab-' + target).classList.add('active')
    })
  })
}

// ═══════════════════════════════════════════════════════════════
// DEPARTAMENTOS
// ═══════════════════════════════════════════════════════════════

async function loadDepartments() {
  const { data, error } = await db
    .from('departments')
    .select('id, code, name, is_active, documents(id, status)')
    .order('name')

  if (error) {
    showToast('Error al cargar departamentos: ' + error.message, 'red')
    return
  }

  _departments = (data || []).map(d => {
    const docs      = d.documents || []
    const total     = docs.length
    const activos   = docs.filter(doc => doc.status !== 'obsoleto').length
    return { ...d, _total: total, _activos: activos }
  })

  renderDepartmentsTable()
}

function renderDepartmentsTable() {
  const tbody = document.getElementById('dept-tbody')
  const count = document.getElementById('dept-count')

  if (count) count.textContent = `${_departments.length} departamento${_departments.length !== 1 ? 's' : ''}`

  if (_departments.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="6" class="table-empty">
          <i class="fa-solid fa-building-circle-xmark"></i>
          <strong>Sin departamentos</strong>
          Agrega el primer departamento con el botón "Nuevo Departamento".
        </td>
      </tr>`
    return
  }

  tbody.innerHTML = _departments.map(d => {
    const badge  = d.is_active
      ? `<span class="badge-active">Activo</span>`
      : `<span class="badge-inactive">Inactivo</span>`
    const toggle = d.is_active
      ? `<button class="btn-toggle-active" onclick="toggleDept('${d.id}', false)" title="Desactivar departamento">
           <i class="fa-solid fa-toggle-on"></i> Activo
         </button>`
      : `<button class="btn-toggle-inactive" onclick="toggleDept('${d.id}', true)" title="Activar departamento">
           <i class="fa-solid fa-toggle-off"></i> Inactivo
         </button>`

    return `
      <tr>
        <td><span class="cfg-code">${escHtml(d.code)}</span></td>
        <td class="cfg-name">${escHtml(d.name)}</td>
        <td class="center doc-count-cell ${d._total === 0 ? 'doc-count-zero' : ''}">${d._total}</td>
        <td class="center doc-count-cell ${d._activos === 0 ? 'doc-count-zero' : ''}">${d._activos}</td>
        <td class="center">${badge}</td>
        <td class="center">
          <div class="action-btns" style="justify-content:center">
            ${toggle}
            <button class="btn-action" onclick="openEditDept('${d.id}')" title="Editar">
              <i class="fa-solid fa-pen"></i>
            </button>
            <button class="btn-action red" onclick="confirmDeleteDept('${d.id}')" title="Eliminar">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>`
  }).join('')
}

// ── Toggle activo/inactivo ──────────────────────────────────────
async function toggleDept(id, newState) {
  const { error } = await db
    .from('departments')
    .update({ is_active: newState })
    .eq('id', id)

  if (error) {
    showToast('Error al actualizar estado: ' + error.message, 'red')
    return
  }
  showToast(newState ? 'Departamento activado.' : 'Departamento desactivado.', 'green')
  await loadDepartments()
}

// ── Modal nuevo/editar departamento ────────────────────────────
function openNewDept() {
  _editingDeptId = null
  document.getElementById('dept-modal-title').textContent = 'Nuevo Departamento'
  document.getElementById('dept-code').value = ''
  document.getElementById('dept-name').value = ''
  openModal('modal-dept')
}

function openEditDept(id) {
  const dept = _departments.find(d => d.id === id)
  if (!dept) return
  _editingDeptId = id
  document.getElementById('dept-modal-title').textContent = 'Editar Departamento'
  document.getElementById('dept-code').value = dept.code
  document.getElementById('dept-name').value = dept.name
  openModal('modal-dept')
}

async function saveDept() {
  const code = document.getElementById('dept-code').value.trim().toUpperCase()
  const name = document.getElementById('dept-name').value.trim()

  if (!code || !name) {
    showToast('Completa todos los campos requeridos.', 'orange')
    return
  }

  const btn = document.getElementById('btn-save-dept')
  btn.disabled = true

  if (_editingDeptId) {
    const { error } = await db
      .from('departments')
      .update({ code, name })
      .eq('id', _editingDeptId)

    if (error) {
      showToast('Error al actualizar: ' + error.message, 'red')
      btn.disabled = false
      return
    }
    showToast('Departamento actualizado correctamente.', 'green')
  } else {
    const { error } = await db
      .from('departments')
      .insert({ code, name, is_active: true })

    if (error) {
      showToast('Error al crear departamento: ' + error.message, 'red')
      btn.disabled = false
      return
    }
    showToast('Departamento creado correctamente.', 'green')
  }

  btn.disabled = false
  closeModal('modal-dept')
  await loadDepartments()
}

// ── Eliminar departamento ───────────────────────────────────────
function confirmDeleteDept(id) {
  const dept = _departments.find(d => d.id === id)
  if (!dept) return
  _pendingDeleteDeptId = id

  if (dept._activos > 0) {
    document.getElementById('dept-warn-msg').innerHTML =
      `El departamento <strong>${escHtml(dept.name)}</strong> tiene
       <strong>${dept._activos} documento${dept._activos !== 1 ? 's' : ''} activo${dept._activos !== 1 ? 's' : ''}</strong>
       (no obsoletos). Primero márcalos como obsoletos antes de eliminar este departamento.`
    openModal('modal-dept-warn')
  } else {
    document.getElementById('dept-confirm-msg').innerHTML =
      `¿Eliminar el departamento <strong>${escHtml(dept.name)}</strong>?
       ${dept._total > 0 ? `Tiene ${dept._total} documento${dept._total !== 1 ? 's' : ''} en estado obsoleto que también pueden quedar sin departamento asignado.` : 'No tiene documentos asociados.'}`
    openModal('modal-dept-confirm')
  }
}

async function executeDeleteDept() {
  if (!_pendingDeleteDeptId) return

  const btn = document.getElementById('btn-confirm-delete-dept')
  btn.disabled = true
  const id = _pendingDeleteDeptId

  // 1) Liberar FK en quality_indicators
  const { error: e1 } = await db
    .from('quality_indicators')
    .update({ responsible_department_id: null })
    .eq('responsible_department_id', id)

  if (e1) {
    showToast('Error al limpiar indicadores: ' + e1.message, 'red')
    btn.disabled = false
    return
  }

  // 2) Liberar FK en profiles
  const { error: e2 } = await db
    .from('profiles')
    .update({ department_id: null })
    .eq('department_id', id)

  if (e2) {
    showToast('Error al limpiar perfiles: ' + e2.message, 'red')
    btn.disabled = false
    return
  }

  // 3) Borrar el departamento
  const { error: e3 } = await db
    .from('departments')
    .delete()
    .eq('id', id)

  if (e3) {
    showToast('Error al eliminar: ' + e3.message, 'red')
    btn.disabled = false
    return
  }

  showToast('Departamento eliminado.', 'green')
  btn.disabled = false
  _pendingDeleteDeptId = null
  closeModal('modal-dept-confirm')
  await loadDepartments()
}

// ═══════════════════════════════════════════════════════════════
// TIPOS DE DOCUMENTO
// ═══════════════════════════════════════════════════════════════

async function loadDocTypes() {
  const { data, error } = await db
    .from('document_types')
    .select('id, code_prefix, name, documents(id)')
    .order('code_prefix')

  if (error) {
    showToast('Error al cargar tipos de documento: ' + error.message, 'red')
    return
  }

  _docTypes = (data || []).map(t => ({
    ...t,
    _total: (t.documents || []).length
  }))

  renderDocTypesTable()
}

function renderDocTypesTable() {
  const tbody = document.getElementById('doctype-tbody')
  const count = document.getElementById('doctype-count')

  if (count) count.textContent = `${_docTypes.length} tipo${_docTypes.length !== 1 ? 's' : ''}`

  if (_docTypes.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="4" class="table-empty">
          <i class="fa-solid fa-tags"></i>
          <strong>Sin tipos de documento</strong>
          Agrega el primer tipo con el botón "Nuevo Tipo".
        </td>
      </tr>`
    return
  }

  tbody.innerHTML = _docTypes.map(t => {
    const canDelete = t._total === 0
    const deleteBtn = canDelete
      ? `<button class="btn-action red" onclick="confirmDeleteDocType('${t.id}')" title="Eliminar">
           <i class="fa-solid fa-trash"></i>
         </button>`
      : `<span class="has-tooltip">
           <button class="btn-action" disabled title="">
             <i class="fa-solid fa-trash"></i>
           </button>
           <span class="tooltip-text">Tiene ${t._total} doc${t._total !== 1 ? 's' : ''} — no se puede eliminar</span>
         </span>`

    return `
      <tr>
        <td><span class="cfg-code">${escHtml(t.code_prefix)}</span></td>
        <td class="cfg-name">${escHtml(t.name)}</td>
        <td class="center doc-count-cell ${t._total === 0 ? 'doc-count-zero' : ''}">${t._total}</td>
        <td class="center">
          <div class="action-btns" style="justify-content:center">
            <button class="btn-action" onclick="openEditDocType('${t.id}')" title="Editar">
              <i class="fa-solid fa-pen"></i>
            </button>
            ${deleteBtn}
          </div>
        </td>
      </tr>`
  }).join('')
}

// ── Modal nuevo/editar tipo ─────────────────────────────────────
function openNewDocType() {
  _editingDocTypeId = null
  document.getElementById('doctype-modal-title').textContent = 'Nuevo Tipo de Documento'
  document.getElementById('doctype-prefix').value = ''
  document.getElementById('doctype-name').value = ''
  openModal('modal-doctype')
}

function openEditDocType(id) {
  const t = _docTypes.find(t => t.id === id)
  if (!t) return
  _editingDocTypeId = id
  document.getElementById('doctype-modal-title').textContent = 'Editar Tipo de Documento'
  document.getElementById('doctype-prefix').value = t.code_prefix
  document.getElementById('doctype-name').value = t.name
  openModal('modal-doctype')
}

async function saveDocType() {
  const prefix = document.getElementById('doctype-prefix').value.trim().toUpperCase()
  const name   = document.getElementById('doctype-name').value.trim()

  if (!prefix || !name) {
    showToast('Completa todos los campos requeridos.', 'orange')
    return
  }

  const btn = document.getElementById('btn-save-doctype')
  btn.disabled = true

  if (_editingDocTypeId) {
    const { error } = await db
      .from('document_types')
      .update({ code_prefix: prefix, name })
      .eq('id', _editingDocTypeId)

    if (error) {
      showToast('Error al actualizar: ' + error.message, 'red')
      btn.disabled = false
      return
    }
    showToast('Tipo de documento actualizado correctamente.', 'green')
  } else {
    const { error } = await db
      .from('document_types')
      .insert({ code_prefix: prefix, name })

    if (error) {
      showToast('Error al crear tipo de documento: ' + error.message, 'red')
      btn.disabled = false
      return
    }
    showToast('Tipo de documento creado correctamente.', 'green')
  }

  btn.disabled = false
  closeModal('modal-doctype')
  await loadDocTypes()
}

// ── Eliminar tipo de documento ──────────────────────────────────
function confirmDeleteDocType(id) {
  const t = _docTypes.find(t => t.id === id)
  if (!t) return
  _pendingDeleteDocTypeId = id

  document.getElementById('doctype-confirm-msg').innerHTML =
    `¿Eliminar el tipo <strong>${escHtml(t.code_prefix)} — ${escHtml(t.name)}</strong>?
     Esta acción no se puede deshacer.`
  openModal('modal-doctype-confirm')
}

async function executeDeleteDocType() {
  if (!_pendingDeleteDocTypeId) return

  const btn = document.getElementById('btn-confirm-delete-doctype')
  btn.disabled = true

  const { error } = await db
    .from('document_types')
    .delete()
    .eq('id', _pendingDeleteDocTypeId)

  if (error) {
    showToast('Error al eliminar: ' + error.message, 'red')
    btn.disabled = false
    return
  }

  showToast('Tipo de documento eliminado.', 'green')
  btn.disabled = false
  _pendingDeleteDocTypeId = null
  closeModal('modal-doctype-confirm')
  await loadDocTypes()
}

// ── Helpers ─────────────────────────────────────────────────────
function openModal(id) {
  const el = document.getElementById(id)
  if (el) el.classList.add('open')
}

function closeModal(id) {
  const el = document.getElementById(id)
  if (el) el.classList.remove('open')
}

function escHtml(str) {
  return String(str || '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
}

// ── Toast (usa la global si existe, sino implementa fallback) ───
function showToast(msg, type) {
  if (typeof window.showToast === 'function' && window.showToast !== showToast) {
    window.showToast(msg, type)
    return
  }
  const colors = { green: '#16a34a', red: '#dc2626', orange: '#d97706' }
  const color  = colors[type] || colors.green
  const el     = document.createElement('div')
  el.style.cssText = `
    position:fixed; bottom:24px; right:24px; z-index:9999;
    background:${color}; color:white; padding:12px 20px;
    border-radius:10px; font-size:0.857rem; font-weight:600;
    box-shadow:0 8px 24px rgba(0,0,0,0.18);
    animation: toastIn 0.2s ease;
  `
  el.textContent = msg
  document.body.appendChild(el)
  setTimeout(() => el.remove(), 3500)
}

// ═══════════════════════════════════════════════════════════════
// USUARIOS Y PERMISOS  (solo administrador)
// ═══════════════════════════════════════════════════════════════

const MODULES = [
  { key: 'dashboard',            label: 'Dashboard',                  icon: 'fa-gauge-high',     group: 'Principal' },
  { key: 'contexto',             label: 'Contexto del SGC',           icon: 'fa-building',        group: 'ISO 9001' },
  { key: 'documentos',           label: 'Control de Documentos',      icon: 'fa-file-lines',      group: 'ISO 9001' },
  { key: 'registros',            label: 'Control de Registros',       icon: 'fa-table-list',      group: 'ISO 9001' },
  { key: 'riesgos',              label: 'Gestión de Riesgos',         icon: 'fa-shield-halved',   group: 'ISO 9001' },
  { key: 'noconformidades',      label: 'No Conformidades',           icon: 'fa-circle-xmark',    group: 'ISO 9001' },
  { key: 'acciones_correctivas', label: 'Acciones Correctivas',       icon: 'fa-list-check',      group: 'ISO 9001' },
  { key: 'indicadores',          label: 'Indicadores',                icon: 'fa-chart-line',      group: 'ISO 9001' },
  { key: 'auditorias',           label: 'Auditorías Externas',        icon: 'fa-award',           group: 'ISO 9001' },
  { key: 'revision_direccion',   label: 'Revisión por Dirección',     icon: 'fa-clipboard-list',  group: 'ISO 9001' },
  { key: 'personal',             label: 'Personal',                   icon: 'fa-id-card',         group: 'Otros' },
  { key: 'satisfaccion',         label: 'Satisfacción y Comentarios', icon: 'fa-face-smile',      group: 'Otros' },
  { key: 'comites',              label: 'Comités',                    icon: 'fa-users',           group: 'Otros' },
  { key: 'eventos_adversos',     label: 'Eventos Adversos',           icon: 'fa-hospital-user',   group: 'Otros' },
]

// Roles con acceso total (no se pueden restringir)
const FULL_ACCESS_ROLES = ['administrador', 'responsable_calidad']

let _users = []
let _roles  = []
let _editingUserId  = null
let _editingUserPId = null   // profile id for edit modal
let _currentPerms   = {}

// ── Carga roles disponibles ─────────────────────────────────────
async function loadRoles() {
  const { data } = await db.from('roles').select('id,name,display_name').order('display_name')
  _roles = data || []
}

function rolesOpts(selectedId = '') {
  return _roles.map(r =>
    `<option value="${r.id}" ${r.id === selectedId ? 'selected' : ''}>${escHtml(r.display_name)}</option>`
  ).join('')
}

function deptsOpts(selectedId = '') {
  return _departments.map(d =>
    `<option value="${d.id}" ${d.id === selectedId ? 'selected' : ''}>${escHtml(d.name)}</option>`
  ).join('')
}

// ── Carga lista de usuarios ─────────────────────────────────────
async function loadUsers() {
  const { data, error } = await db
    .from('profiles')
    .select('id, full_name, email, role_id, permissions, departments(name)')
    .order('full_name')

  if (error) {
    showToast('Error al cargar usuarios: ' + error.message, 'red')
    return
  }

  // Cargar roles por separado (evita ambigüedad de FK en PostgREST)
  if (data && data.length > 0) {
    const roleIds = [...new Set(data.filter(u => u.role_id).map(u => u.role_id))]
    if (roleIds.length > 0) {
      const { data: rolesData } = await db
        .from('roles')
        .select('id, name, display_name')
        .in('id', roleIds)
      if (rolesData) {
        const rolesMap = Object.fromEntries(rolesData.map(r => [r.id, r]))
        data.forEach(u => { u.roles = rolesMap[u.role_id] || null })
      }
    }
  }

  _users = data || []
  renderUsersTable()
}

// ── Render tabla de usuarios ────────────────────────────────────
function renderUsersTable() {
  const tbody = document.getElementById('users-tbody')
  const count = document.getElementById('users-count')
  if (!tbody) return

  if (count) count.textContent = `${_users.length} usuario${_users.length !== 1 ? 's' : ''}`

  if (_users.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="6" class="table-empty">
          <i class="fa-solid fa-users-slash"></i>
          <strong>Sin usuarios</strong>
        </td>
      </tr>`
    return
  }

  tbody.innerHTML = _users.map(u => {
    const roleName    = u.roles?.name || ''
    const roleLabel   = u.roles?.display_name || 'Sin rol'
    const isFullAccess = FULL_ACCESS_ROLES.includes(roleName)
    const deptLabel   = u.departments?.name || '—'
    const perms       = u.permissions || {}
    const blocked     = Object.values(perms).filter(v => v === false).length
    const initial     = (u.full_name || u.email || 'U')[0].toUpperCase()

    const roleClass = roleName === 'administrador' ? 'role-admin'
                    : roleName === 'responsable_calidad' ? 'role-rq'
                    : 'role-user'

    const accessBadge = isFullAccess
      ? `<span class="perm-badge perm-full"><i class="fa-solid fa-infinity"></i> Acceso total</span>`
      : blocked > 0
        ? `<span class="perm-badge perm-restricted"><i class="fa-solid fa-ban"></i> ${blocked} bloqueada${blocked !== 1 ? 's' : ''}</span>`
        : `<span class="perm-badge perm-ok"><i class="fa-solid fa-check"></i> Todas activas</span>`

    return `
      <tr>
        <td>
          <div class="user-cell">
            <div class="user-avatar-sm">${escHtml(initial)}</div>
            <span class="user-name-cell">${escHtml(u.full_name || '—')}</span>
          </div>
        </td>
        <td class="user-email-cell">${escHtml(u.email || '—')}</td>
        <td><span class="role-badge ${roleClass}">${escHtml(roleLabel)}</span></td>
        <td>${escHtml(deptLabel)}</td>
        <td class="center">${accessBadge}</td>
        <td class="center">
          <div class="action-btns" style="justify-content:center;gap:6px">
            <button class="btn-action blue" onclick="openEditUser('${u.id}')" title="Editar rol y departamento">
              <i class="fa-solid fa-pen"></i>
            </button>
            <button class="btn-perm-edit" onclick="openPermPanel('${u.id}')" ${isFullAccess ? 'disabled title="Acceso total"' : 'title="Editar secciones"'}>
              <i class="fa-solid fa-sliders"></i>
              Secciones
            </button>
          </div>
        </td>
      </tr>`
  }).join('')
}

// ── Abrir panel de permisos ─────────────────────────────────────
function openPermPanel(userId) {
  const user = _users.find(u => u.id === userId)
  if (!user) return

  _editingUserId = userId
  _currentPerms  = { ...(user.permissions || {}) }

  const initial = (user.full_name || user.email || 'U')[0].toUpperCase()
  const roleName  = user.roles?.name || ''
  const roleLabel = user.roles?.display_name || 'Sin rol'
  const isFullAccess = FULL_ACCESS_ROLES.includes(roleName)

  document.getElementById('perm-avatar').textContent  = initial
  document.getElementById('perm-user-name').textContent = user.full_name || user.email || '—'
  document.getElementById('perm-user-meta').textContent = `${roleLabel}${user.departments?.name ? ' · ' + user.departments.name : ''}`

  const body   = document.getElementById('perm-body')
  const footer = document.getElementById('perm-footer')

  if (isFullAccess) {
    body.innerHTML = `
      <div class="perm-full-notice">
        <i class="fa-solid fa-shield-check"></i>
        <div>
          <strong>Acceso completo garantizado</strong>
          <p>Los usuarios con rol <em>${escHtml(roleLabel)}</em> siempre tienen acceso a todas las secciones. Sus permisos no se pueden restringir.</p>
        </div>
      </div>`
    footer.style.display = 'none'
  } else {
    footer.style.display = ''

    // Agrupar módulos
    const groups = {}
    MODULES.forEach(m => {
      if (!groups[m.group]) groups[m.group] = []
      groups[m.group].push(m)
    })

    const html = Object.entries(groups).map(([groupName, mods]) => `
      <div class="perm-group">
        <div class="perm-group-label">${escHtml(groupName)}</div>
        <div class="perm-module-grid">
          ${mods.map(m => {
            const isOn = _currentPerms[m.key] !== false
            return `
              <label class="perm-toggle-row" for="perm-${m.key}">
                <div class="perm-module-info">
                  <i class="fa-solid ${m.icon} perm-mod-icon"></i>
                  <span class="perm-mod-label">${escHtml(m.label)}</span>
                </div>
                <div class="toggle-wrap">
                  <input type="checkbox" id="perm-${m.key}"
                         class="toggle-input"
                         ${isOn ? 'checked' : ''}
                         onchange="togglePerm('${m.key}', this.checked)">
                  <span class="toggle-slider"></span>
                </div>
              </label>`
          }).join('')}
        </div>
      </div>`
    ).join('')

    body.innerHTML = `
      <div class="perm-actions-bar">
        <button class="btn-perm-all" onclick="setAllPerms(true)">
          <i class="fa-solid fa-check-double"></i> Activar todas
        </button>
        <button class="btn-perm-none" onclick="setAllPerms(false)">
          <i class="fa-solid fa-ban"></i> Bloquear todas
        </button>
      </div>
      ${html}`
  }

  document.getElementById('perm-panel').classList.add('open')
}

// ── Toggle individual ───────────────────────────────────────────
function togglePerm(key, value) {
  if (value) {
    // Si es true, eliminar la clave (default = acceso)
    delete _currentPerms[key]
  } else {
    _currentPerms[key] = false
  }
}

// ── Activar / bloquear todas ────────────────────────────────────
function setAllPerms(value) {
  _currentPerms = {}
  if (!value) {
    MODULES.forEach(m => { _currentPerms[m.key] = false })
  }
  // Re-renderizar los checkboxes
  MODULES.forEach(m => {
    const cb = document.getElementById('perm-' + m.key)
    if (cb) cb.checked = value
  })
}

// ── Guardar permisos ────────────────────────────────────────────
async function savePermissions() {
  if (!_editingUserId) return

  const btn = document.getElementById('btn-save-perms')
  btn.disabled = true

  const { error } = await db
    .from('profiles')
    .update({ permissions: _currentPerms })
    .eq('id', _editingUserId)

  btn.disabled = false

  if (error) {
    showToast('Error al guardar: ' + error.message, 'red')
    return
  }

  showToast('Permisos actualizados correctamente.', 'green')
  closePermPanel()
  await loadUsers()
}

// ═══════════════════════════════════════════════════════════════
// NUEVO USUARIO
// ═══════════════════════════════════════════════════════════════

function openNewUser() {
  // Reset campos
  ;['nu-email','nu-name','nu-password'].forEach(id => {
    const el = document.getElementById(id)
    if (el) el.value = ''
  })
  document.getElementById('nu-notice').style.display = 'none'

  // Poblar selects
  document.getElementById('nu-role').innerHTML =
    `<option value="">— Seleccionar —</option>${rolesOpts()}`
  document.getElementById('nu-dept').innerHTML =
    `<option value="">— Sin asignar —</option>${deptsOpts()}`

  const btn = document.getElementById('btn-save-new-user')
  if (btn) { btn.disabled = false; btn.innerHTML = '<i class="fa-solid fa-user-plus"></i> Crear Usuario' }

  openModal('modal-new-user')
}

function togglePassVis(inputId, btn) {
  const inp = document.getElementById(inputId)
  if (!inp) return
  const show = inp.type === 'password'
  inp.type = show ? 'text' : 'password'
  btn.querySelector('i').className = show ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye'
}

async function submitNewUser() {
  const email    = (document.getElementById('nu-email')?.value    || '').trim().toLowerCase()
  const name     = (document.getElementById('nu-name')?.value     || '').trim()
  const password = (document.getElementById('nu-password')?.value || '').trim()
  const roleId   = document.getElementById('nu-role')?.value  || ''
  const deptId   = document.getElementById('nu-dept')?.value  || ''

  if (!email)    { showToast('El correo electrónico es obligatorio.', 'orange'); return }
  if (!name)     { showToast('El nombre completo es obligatorio.',    'orange'); return }
  if (!password) { showToast('La contraseña temporal es obligatoria.','orange'); return }
  if (password.length < 6) { showToast('La contraseña debe tener al menos 6 caracteres.','orange'); return }
  if (!roleId)   { showToast('Selecciona un rol para el usuario.',    'orange'); return }

  const btn = document.getElementById('btn-save-new-user')
  if (btn) { btn.disabled = true; btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Creando…' }

  const resetBtn = () => {
    if (btn) { btn.disabled = false; btn.innerHTML = '<i class="fa-solid fa-user-plus"></i> Crear Usuario' }
  }

  try {
    // Llamar directamente a la API REST — sin cliente secundario,
    // sin tocar la sesión del administrador
    const resp = await fetch(`${SUPABASE_URL}/auth/v1/signup`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': SUPABASE_ANON_KEY
      },
      body: JSON.stringify({
        email,
        password,
        data: { full_name: name }
      })
    })

    const result = await resp.json()

    if (!resp.ok) {
      const msg = result.msg || result.error_description || result.message || JSON.stringify(result)
      throw new Error(msg)
    }

    // El ID puede venir en distintos lugares según la configuración de Supabase
    const userId = result.id || result.user?.id
    if (!userId) {
      throw new Error('No se obtuvo ID del usuario. ¿El correo ya está registrado?')
    }

    // Pausa para que el trigger cree el perfil en profiles
    await new Promise(r => setTimeout(r, 800))

    // Asignar rol, departamento y nombre al perfil
    const { error: profErr } = await db.from('profiles').upsert({
      id:            userId,
      email,
      full_name:     name,
      role_id:       roleId,
      department_id: deptId || null,
      permissions:   {}
    }, { onConflict: 'id' })

    if (profErr) {
      showToast('Usuario creado, pero error al asignar perfil: ' + profErr.message, 'orange')
    }

    // Aviso de éxito con credenciales
    const notice    = document.getElementById('nu-notice')
    const noticeMsg = document.getElementById('nu-notice-msg')
    if (notice && noticeMsg) {
      const tieneSession = !!(result.access_token || result.session)
      noticeMsg.textContent =
        `Correo: ${email}  ·  Contraseña temporal: ${password}.  ` +
        (tieneSession
          ? 'El usuario ya puede iniciar sesión.'
          : 'Recibirá un correo de confirmación antes de poder acceder.')
      notice.style.display = 'flex'
    }

    if (btn) { btn.disabled = false; btn.innerHTML = '<i class="fa-solid fa-check"></i> Creado' }
    showToast(`Usuario ${email} creado correctamente.`, 'green')
    await loadUsers()

  } catch (e) {
    showToast('Error al crear usuario: ' + e.message, 'red')
    resetBtn()
  }
}

// ═══════════════════════════════════════════════════════════════
// EDITAR ROL / DEPARTAMENTO DE USUARIO EXISTENTE
// ═══════════════════════════════════════════════════════════════

function openEditUser(userId) {
  const u = _users.find(u => u.id === userId)
  if (!u) return
  _editingUserPId = userId

  document.getElementById('eu-email-sub').textContent = u.email || '—'
  document.getElementById('eu-name').value = u.full_name || ''

  document.getElementById('eu-role').innerHTML =
    `<option value="">— Seleccionar —</option>${rolesOpts(u.role_id || '')}`
  document.getElementById('eu-dept').innerHTML =
    `<option value="">— Sin asignar —</option>${deptsOpts(u.departments?.id || '')}`

  const btn = document.getElementById('btn-save-edit-user')
  if (btn) { btn.disabled = false; btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar' }

  openModal('modal-edit-user')
}

async function submitEditUser() {
  if (!_editingUserPId) return

  const name   = (document.getElementById('eu-name')?.value  || '').trim()
  const roleId = document.getElementById('eu-role')?.value   || ''
  const deptId = document.getElementById('eu-dept')?.value   || ''

  if (!roleId) { showToast('Selecciona un rol.', 'orange'); return }

  const btn = document.getElementById('btn-save-edit-user')
  if (btn) { btn.disabled = true; btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…' }

  const { error } = await db.from('profiles').update({
    full_name:     name     || null,
    role_id:       roleId,
    department_id: deptId   || null
  }).eq('id', _editingUserPId)

  if (error) {
    showToast('Error al guardar: ' + error.message, 'red')
    if (btn) { btn.disabled = false; btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar' }
    return
  }

  showToast('Perfil actualizado correctamente.', 'green')
  closeModal('modal-edit-user')
  _editingUserPId = null
  await loadUsers()
}

// ── Cerrar panel ────────────────────────────────────────────────
function closePermPanel() {
  document.getElementById('perm-panel').classList.remove('open')
  _editingUserId = null
  _currentPerms  = {}
}

function closePanelOutside(e) {
  if (e.target.id === 'perm-panel') closePermPanel()
}

// ── Arrancar ─────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', initConfig)
