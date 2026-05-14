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

  await Promise.all([loadDepartments(), loadDocTypes()])
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

  const { error } = await db
    .from('departments')
    .delete()
    .eq('id', _pendingDeleteDeptId)

  if (error) {
    showToast('Error al eliminar: ' + error.message, 'red')
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

// ── Arrancar ─────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', initConfig)
