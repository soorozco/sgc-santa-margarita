// ─── Solicitudes de Baja de Documentos ──────────────────────────

let _user = null, _profile = null, _role = null
let _requests = []
let _currentReqId = null

async function initSolicitudes() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  renderUserInfo()

  if (_role !== 'administrador' && _role !== 'responsable_calidad') {
    document.getElementById('main-content').innerHTML = `
      <div style="display:flex;flex-direction:column;align-items:center;justify-content:center;min-height:40vh;gap:1rem;color:#9ca3af">
        <i class="fa-solid fa-lock" style="font-size:3rem"></i>
        <p>No tienes acceso a esta sección.</p>
      </div>`
    return
  }

  await loadRequests()
  setupTabs()

  // Mostrar nav de solicitudes (active)
  const navSol = document.getElementById('nav-solicitudes')
  if (navSol) navSol.style.display = 'flex'
}

async function loadRequests() {
  const { data, error } = await db
    .from('document_deactivation_requests')
    .select(`
      id, reason, status, created_at, reviewer_comment, reviewed_at,
      document:document_id(id, code, name, departments(name)),
      requester:requested_by(full_name),
      reviewer:reviewed_by(full_name)
    `)
    .order('created_at', { ascending: false })

  if (error) {
    console.error('[Solicitudes] error:', error)
    const msg = error.code === '42P01'
      ? 'La tabla de solicitudes no existe aún. Ejecuta el SQL en Supabase primero.'
      : 'Error al cargar solicitudes: ' + error.message
    const errRow = `<tr><td colspan="6" style="text-align:center;padding:2rem;color:#ef4444">${msg}</td></tr>`
    const tp = document.getElementById('tbody-pending')
    const th = document.getElementById('tbody-history')
    if (tp) tp.innerHTML = errRow
    if (th) th.innerHTML = errRow
    return
  }

  _requests = data || []
  renderPending()
  renderHistory()
  updateBadges()
}

function updateBadges() {
  const count = _requests.filter(r => r.status === 'pending').length
  const badge = document.getElementById('badge-pending')
  if (badge) { badge.textContent = count; badge.style.display = count ? 'inline-flex' : 'none' }
  const kpi = document.getElementById('kpi-pending-count')
  if (kpi) kpi.textContent = count

  // Actualizar badge en nav
  const navBadge = document.getElementById('badge-sol')
  if (navBadge) {
    navBadge.textContent = count
    navBadge.style.display = count > 0 ? 'inline-flex' : 'none'
  }
}

function renderPending() {
  const tbody = document.getElementById('tbody-pending')
  if (!tbody) return
  const pending = _requests.filter(r => r.status === 'pending')
  if (!pending.length) {
    tbody.innerHTML = `<tr><td colspan="6" style="text-align:center;padding:2rem;color:#9ca3af">No hay solicitudes pendientes</td></tr>`
    return
  }
  tbody.innerHTML = pending.map(req => `
    <tr>
      <td><span class="doc-code">${esc(req.document?.code || '—')}</span><br><small style="color:#6b7280">${esc(req.document?.name || '')}</small></td>
      <td>${esc(req.document?.departments?.name || '—')}</td>
      <td>${esc(req.requester?.full_name || '—')}</td>
      <td>${new Date(req.created_at).toLocaleDateString('es-MX')}</td>
      <td style="max-width:220px;white-space:pre-wrap;font-size:.82rem">${esc(req.reason || '—')}</td>
      <td>
        <div class="action-btns">
          <button onclick="approveReq('${req.id}')" class="btn-action green" title="Aprobar — dar de baja el documento"><i class="fa-solid fa-check"></i></button>
          <button onclick="openReject('${req.id}')" class="btn-action red" title="Rechazar"><i class="fa-solid fa-xmark"></i></button>
        </div>
      </td>
    </tr>
  `).join('')
}

function renderHistory() {
  const tbody = document.getElementById('tbody-history')
  if (!tbody) return
  const done = _requests.filter(r => r.status !== 'pending')
  if (!done.length) {
    tbody.innerHTML = `<tr><td colspan="6" style="text-align:center;padding:2rem;color:#9ca3af">Sin historial</td></tr>`
    return
  }
  tbody.innerHTML = done.map(req => {
    const isApproved = req.status === 'approved'
    return `
      <tr>
        <td><span class="doc-code">${esc(req.document?.code || '—')}</span><br><small style="color:#6b7280">${esc(req.document?.name || '')}</small></td>
        <td>${esc(req.document?.departments?.name || '—')}</td>
        <td>${esc(req.requester?.full_name || '—')}</td>
        <td>${new Date(req.created_at).toLocaleDateString('es-MX')}</td>
        <td><span class="pill ${isApproved ? 'pill--vigente' : 'pill--obsoleto'}">${isApproved ? 'Aprobada' : 'Rechazada'}</span></td>
        <td style="font-size:.82rem;color:#6b7280">${esc(req.reviewer_comment || '—')}</td>
      </tr>
    `
  }).join('')
}

async function approveReq(reqId) {
  if (!confirm('¿Confirmas que deseas aprobar esta solicitud? El documento pasará a estado Obsoleto.')) return
  const req = _requests.find(r => r.id === reqId)
  if (!req) return

  // 1. Cambiar doc a obsoleto
  const { error: e1 } = await db.from('documents')
    .update({ status: 'obsoleto' })
    .eq('id', req.document?.id)
  if (e1) { showToast('Error al actualizar el documento: ' + e1.message, 'red'); return }

  // 2. Marcar solicitud como aprobada
  const { error: e2 } = await db.from('document_deactivation_requests')
    .update({ status: 'approved', reviewed_by: _user.id, reviewed_at: new Date().toISOString() })
    .eq('id', reqId)
  if (e2) { showToast('Error al actualizar la solicitud: ' + e2.message, 'red'); return }

  showToast('Solicitud aprobada. Documento dado de baja.', 'green')
  await loadRequests()
}

function openReject(reqId) {
  _currentReqId = reqId
  setVal('reject-comment', '')
  openModal('modal-reject')
}

async function submitReject() {
  const comment = document.getElementById('reject-comment')?.value.trim()
  if (!comment) { showToast('Escribe el motivo del rechazo.', 'red'); return }
  const btn = document.getElementById('btn-reject-submit')
  btn.disabled = true

  const { error } = await db.from('document_deactivation_requests')
    .update({
      status:           'rejected',
      reviewed_by:      _user.id,
      reviewed_at:      new Date().toISOString(),
      reviewer_comment: comment
    })
    .eq('id', _currentReqId)

  btn.disabled = false
  if (error) { showToast('Error al rechazar.', 'red'); return }
  showToast('Solicitud rechazada.', 'green')
  closeModal('modal-reject')
  await loadRequests()
}

function setupTabs() {
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'))
      document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'))
      btn.classList.add('active')
      document.getElementById(btn.dataset.tab)?.classList.add('active')
    })
  })
}

// ── Helpers ──────────────────────────────────────────────────────
function openModal(id) { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }
function setText(id, v) { const el = document.getElementById(id); if (el) el.textContent = v }
function setVal(id, v)  { const el = document.getElementById(id); if (el) el.value = v }
function esc(s) {
  return String(s || '').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}
function renderUserInfo() {
  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
}
function showToast(msg, color = 'green') {
  const el = document.getElementById('toast')
  if (!el) return
  el.textContent = msg
  el.className = 'toast toast--' + (color === 'red' ? 'red' : 'green') + ' show'
  clearTimeout(el._t)
  el._t = setTimeout(() => el.classList.remove('show'), 3500)
}

// ── Close modals on overlay click ────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.modal-overlay').forEach(overlay => {
    overlay.addEventListener('click', e => {
      if (e.target === overlay) overlay.classList.remove('open')
    })
  })
  initSolicitudes()
})
