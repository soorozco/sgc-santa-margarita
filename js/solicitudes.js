// ─── Solicitudes de Alta y Baja de Documentos ────────────────────

let _solUser = null, _solProfile = null, _solRole = null
let _altaReqs  = []   // document_code_requests
let _bajaReqs  = []   // document_deactivation_requests
let _currentAltaId = null
let _currentBajaId = null

// ── Init ─────────────────────────────────────────────────────────
async function initSolicitudes() {
  const auth = await requireAuth()
  if (!auth) return
  _solUser    = auth.user
  _solProfile = auth.profile
  _solRole    = auth.profile?.roles?.name || 'lector'

  renderUserInfo()

  if (!['administrador','responsable_calidad'].includes(_solRole)) {
    const target = document.getElementById('infodoc-panel-solicitudes')
                 || document.getElementById('main-content')
    target.innerHTML = `
      <div style="display:flex;flex-direction:column;align-items:center;
                  justify-content:center;min-height:40vh;gap:1rem;color:#9ca3af">
        <i class="fa-solid fa-lock" style="font-size:3rem"></i>
        <p>No tienes acceso a esta sección.</p>
      </div>`
    return
  }

  const navSol = document.getElementById('nav-solicitudes')
  if (navSol) navSol.style.display = 'flex'

  setupTabs()
  await Promise.all([loadAltaReqs(), loadBajaReqs()])
}

// ── Init desde tab de Información Documentada (sin segunda auth) ─
async function initSolicitudesTab() {
  try {
    // Reutilizar contexto ya cargado por documentos.js
    const ctx = window._solCtx
    if (ctx) {
      _solUser    = ctx.user
      _solProfile = ctx.profile
      _solRole    = ctx.role
    } else {
      // fallback: auth completa si no hay contexto
      const auth = await requireAuth()
      if (!auth) return
      _solUser    = auth.user
      _solProfile = auth.profile
      _solRole    = auth.profile?.roles?.name || 'lector'
    }

    if (!['administrador','responsable_calidad'].includes(_solRole)) {
      const panel = document.getElementById('infodoc-panel-solicitudes')
      if (panel) panel.innerHTML = `
        <div style="display:flex;flex-direction:column;align-items:center;
                    justify-content:center;min-height:40vh;gap:1rem;color:#9ca3af">
          <i class="fa-solid fa-lock" style="font-size:3rem"></i>
          <p>No tienes acceso a esta sección.</p>
        </div>`
      return
    }

    setupTabs()
    await Promise.all([loadAltaReqs(), loadBajaReqs()])
  } catch (err) {
    console.error('[Solicitudes] Error en initSolicitudesTab:', err)
    _setAllSpinnersError('Error inesperado al cargar solicitudes: ' + (err.message || err))
  }
}

// ── Tabs ─────────────────────────────────────────────────────────
function setupTabs() {
  // Tabs principales (Alta / Baja)
  document.querySelectorAll('.sol-tabs-main .tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      document.querySelectorAll('.sol-tabs-main .tab-btn').forEach(b => b.classList.remove('active'))
      document.querySelectorAll('.sol-section').forEach(s => s.classList.remove('active'))
      btn.classList.add('active')
      document.getElementById('section-' + btn.dataset.section)?.classList.add('active')
    })
  })

  // Sub-tabs dentro de cada sección
  document.querySelectorAll('.sol-tabs-sub .tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const section = btn.closest('.sol-section')
      section.querySelectorAll('.sol-tabs-sub .tab-btn').forEach(b => b.classList.remove('active'))
      section.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'))
      btn.classList.add('active')
      document.getElementById(btn.dataset.tab)?.classList.add('active')
    })
  })
}

// ── helper: poner error en todos los tbody de solicitudes ─────────
function _setAllSpinnersError(msg) {
  const ids = ['tbody-alta-pending','tbody-alta-history','tbody-baja-pending','tbody-baja-history']
  const colspans = [8, 7, 6, 6]
  ids.forEach((id, i) => {
    const el = document.getElementById(id)
    if (el) el.innerHTML = `<tr><td colspan="${colspans[i]}"
      style="text-align:center;padding:2rem;color:#ef4444;font-size:.9rem">
      <i class="fa-solid fa-triangle-exclamation" style="margin-right:.4rem"></i>${esc(msg)}
    </td></tr>`
  })
}

// ── SOLICITUDES DE ALTA ───────────────────────────────────────────
async function loadAltaReqs() {
  try {
    const { data, error } = await db
      .from('document_code_requests')
      .select(`
        id, suggested_code, proposed_name, justification, status,
        assigned_code, review_notes, created_at,
        document_types(code_prefix, name),
        departments(name),
        requester:requested_by(full_name),
        reviewer:reviewed_by(full_name)
      `)
      .order('created_at', { ascending: false })

    if (error) {
      console.error('[Solicitudes] loadAltaReqs error:', error)
      const isNoTable = error.code === '42P01' || error.message?.includes('does not exist')
      const msg = isNoTable
        ? 'Tabla no configurada — ejecuta <code>document_code_requests_setup.sql</code> en Supabase'
        : 'Error al cargar: ' + error.message
      const el8 = document.getElementById('tbody-alta-pending')
      const el7 = document.getElementById('tbody-alta-history')
      if (el8) el8.innerHTML = `<tr><td colspan="8" style="text-align:center;padding:2rem;color:#ef4444;font-size:.9rem">
        <i class="fa-solid fa-triangle-exclamation" style="margin-right:.4rem"></i>${msg}</td></tr>`
      if (el7) el7.innerHTML = `<tr><td colspan="7" style="text-align:center;padding:2rem;color:#ef4444;font-size:.9rem">
        <i class="fa-solid fa-triangle-exclamation" style="margin-right:.4rem"></i>${msg}</td></tr>`
      return
    }

    _altaReqs = data || []
    renderAltaPending()
    renderAltaHistory()
    updateKPIs()
  } catch (err) {
    console.error('[Solicitudes] loadAltaReqs exception:', err)
    const el = document.getElementById('tbody-alta-pending')
    if (el) el.innerHTML = `<tr><td colspan="8" style="text-align:center;padding:2rem;color:#ef4444">
      Error inesperado: ${esc(err.message || String(err))}</td></tr>`
  }
}

function renderAltaPending() {
  const tbody = document.getElementById('tbody-alta-pending')
  if (!tbody) return
  const pending = _altaReqs.filter(r => r.status === 'pending')

  const badge = document.getElementById('badge-alta-pending')
  if (badge) { badge.textContent = pending.length; badge.style.display = pending.length ? 'inline-flex' : 'none' }

  if (!pending.length) {
    tbody.innerHTML = emptyRow(8, 'Sin solicitudes de alta pendientes')
    return
  }

  tbody.innerHTML = pending.map(r => `
    <tr>
      <td><span class="doc-code">${esc(r.suggested_code || '—')}</span></td>
      <td style="font-weight:500">${esc(r.proposed_name)}</td>
      <td><span class="doc-type-tag">${esc(r.document_types?.code_prefix || '—')}</span></td>
      <td>${esc(r.departments?.name || '—')}</td>
      <td>${esc(r.requester?.full_name || '—')}</td>
      <td style="white-space:nowrap">${fmtDate(r.created_at)}</td>
      <td style="max-width:200px;font-size:.82rem;color:#6b7280">${esc(r.justification || '—')}</td>
      <td class="center">
        <div class="action-btns">
          <button onclick="openAltaReview('${r.id}')" class="btn-action green"
                  title="Revisar solicitud">
            <i class="fa-solid fa-clipboard-check"></i>
          </button>
        </div>
      </td>
    </tr>`).join('')
}

function renderAltaHistory() {
  const tbody = document.getElementById('tbody-alta-history')
  if (!tbody) return
  const done = _altaReqs.filter(r => r.status !== 'pending')

  if (!done.length) {
    tbody.innerHTML = emptyRow(7, 'Sin historial')
    return
  }

  tbody.innerHTML = done.map(r => {
    const approved = r.status === 'approved'
    return `
    <tr>
      <td>${approved
        ? `<span class="doc-code">${esc(r.assigned_code || r.suggested_code || '—')}</span>`
        : `<span style="color:#9ca3af">${esc(r.suggested_code || '—')}</span>`}
      </td>
      <td>${esc(r.proposed_name)}</td>
      <td>${esc(r.departments?.name || '—')}</td>
      <td>${esc(r.requester?.full_name || '—')}</td>
      <td style="white-space:nowrap">${fmtDate(r.created_at)}</td>
      <td class="center">
        <span class="pill ${approved ? 'pill--vigente' : 'pill--obsoleto'}">
          ${approved ? 'Aprobada' : 'Rechazada'}
        </span>
      </td>
      <td style="font-size:.82rem;color:#6b7280">${esc(r.review_notes || '—')}</td>
    </tr>`
  }).join('')
}

// Abre el modal de revisión de alta
function openAltaReview(reqId) {
  _currentAltaId = reqId
  const r = _altaReqs.find(x => x.id === reqId)
  if (!r) return

  // Subtítulo
  setText('ma-subtitle', `Código sugerido: ${r.suggested_code || '—'}`)

  // Info box
  const box = document.getElementById('ma-info-box')
  if (box) box.innerHTML = `
    <div class="sol-info-row"><span class="sol-info-lbl">Solicitante</span><span>${esc(r.requester?.full_name || '—')}</span></div>
    <div class="sol-info-row"><span class="sol-info-lbl">Tipo</span><span>${esc(r.document_types?.code_prefix || '—')} — ${esc(r.document_types?.name || '—')}</span></div>
    <div class="sol-info-row"><span class="sol-info-lbl">Departamento</span><span>${esc(r.departments?.name || '—')}</span></div>
    <div class="sol-info-row"><span class="sol-info-lbl">Nombre</span><span style="font-weight:600">${esc(r.proposed_name)}</span></div>
    ${r.justification ? `<div class="sol-info-row"><span class="sol-info-lbl">Justificación</span><span style="font-style:italic">${esc(r.justification)}</span></div>` : ''}
    <div class="sol-info-row"><span class="sol-info-lbl">Fecha</span><span>${fmtDate(r.created_at)}</span></div>`

  setVal('ma-code', r.suggested_code || '')
  setVal('ma-notes', '')
  openModal('modal-approve-alta')
}

async function submitAltaReview(action) {
  const btnApprove = document.getElementById('btn-ma-approve')
  const btnReject  = document.getElementById('btn-ma-reject')
  const code  = document.getElementById('ma-code')?.value.trim().toUpperCase()
  const notes = document.getElementById('ma-notes')?.value.trim()

  if (action === 'approved' && !code) {
    showToast('Escribe el código a asignar antes de aprobar.', 'red'); return
  }

  btnApprove.disabled = true
  btnReject.disabled  = true
  btnApprove.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i>'

  const req = _altaReqs.find(x => x.id === _currentAltaId)
  let createdDocId = null

  if (action === 'approved' && req) {
    // Crear documento en borrador con el código asignado
    const { data: newDoc } = await db.from('documents').insert({
      code,
      name:              req.proposed_name,
      document_type_id:  req.document_type_id || null,
      department_id:     req.department_id    || null,
      current_version:   '1.0',
      status:            'borrador',
      created_by:        _solUser.id
    }).select().single()
    createdDocId = newDoc?.id || null
  }

  const { error } = await db.from('document_code_requests').update({
    status:              action,
    assigned_code:       action === 'approved' ? code : null,
    reviewed_by:         _solUser.id,
    reviewed_at:         new Date().toISOString(),
    review_notes:        notes || null,
    created_document_id: createdDocId,
    updated_at:          new Date().toISOString()
  }).eq('id', _currentAltaId)

  btnApprove.disabled = false
  btnReject.disabled  = false
  btnApprove.innerHTML = '<i class="fa-solid fa-check"></i> Aprobar y Crear Documento'

  if (error) { showToast('Error: ' + error.message, 'red'); return }

  const msg = action === 'approved'
    ? `Clave ${code} aprobada. Documento creado en borrador.`
    : 'Solicitud rechazada.'
  showToast(msg, action === 'approved' ? 'green' : 'red')
  closeModal('modal-approve-alta')
  await loadAltaReqs()
}

// ── SOLICITUDES DE BAJA ───────────────────────────────────────────
async function loadBajaReqs() {
  try {
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
      console.error('[Solicitudes] loadBajaReqs error:', error)
      const isNoTable = error.code === '42P01' || error.message?.includes('does not exist')
      const msg = isNoTable
        ? 'Tabla no configurada — ejecuta el SQL de configuración en Supabase'
        : 'Error al cargar: ' + error.message
      const el1 = document.getElementById('tbody-baja-pending')
      const el2 = document.getElementById('tbody-baja-history')
      if (el1) el1.innerHTML = `<tr><td colspan="6" style="text-align:center;padding:2rem;color:#ef4444;font-size:.9rem">
        <i class="fa-solid fa-triangle-exclamation" style="margin-right:.4rem"></i>${msg}</td></tr>`
      if (el2) el2.innerHTML = `<tr><td colspan="6" style="text-align:center;padding:2rem;color:#ef4444;font-size:.9rem">
        <i class="fa-solid fa-triangle-exclamation" style="margin-right:.4rem"></i>${msg}</td></tr>`
      return
    }

    _bajaReqs = data || []
    renderBajaPending()
    renderBajaHistory()
    updateKPIs()
  } catch (err) {
    console.error('[Solicitudes] loadBajaReqs exception:', err)
    const el = document.getElementById('tbody-baja-pending')
    if (el) el.innerHTML = `<tr><td colspan="6" style="text-align:center;padding:2rem;color:#ef4444">
      Error inesperado: ${esc(err.message || String(err))}</td></tr>`
  }
}

function renderBajaPending() {
  const tbody = document.getElementById('tbody-baja-pending')
  if (!tbody) return
  const pending = _bajaReqs.filter(r => r.status === 'pending')

  const badge = document.getElementById('badge-baja-pending')
  if (badge) { badge.textContent = pending.length; badge.style.display = pending.length ? 'inline-flex' : 'none' }

  if (!pending.length) {
    tbody.innerHTML = emptyRow(6, 'Sin solicitudes de baja pendientes')
    return
  }

  tbody.innerHTML = pending.map(req => `
    <tr>
      <td>
        <span class="doc-code">${esc(req.document?.code || '—')}</span><br>
        <small style="color:#6b7280">${esc(req.document?.name || '')}</small>
      </td>
      <td>${esc(req.document?.departments?.name || '—')}</td>
      <td>${esc(req.requester?.full_name || '—')}</td>
      <td style="white-space:nowrap">${fmtDate(req.created_at)}</td>
      <td style="max-width:220px;white-space:pre-wrap;font-size:.82rem">${esc(req.reason || '—')}</td>
      <td class="center">
        <div class="action-btns">
          <button onclick="approveBaja('${req.id}')" class="btn-action green"
                  title="Aprobar — dar de baja"><i class="fa-solid fa-check"></i></button>
          <button onclick="openRejectBaja('${req.id}')" class="btn-action red"
                  title="Rechazar"><i class="fa-solid fa-xmark"></i></button>
        </div>
      </td>
    </tr>`).join('')
}

function renderBajaHistory() {
  const tbody = document.getElementById('tbody-baja-history')
  if (!tbody) return
  const done = _bajaReqs.filter(r => r.status !== 'pending')

  if (!done.length) {
    tbody.innerHTML = emptyRow(6, 'Sin historial')
    return
  }

  tbody.innerHTML = done.map(req => {
    const approved = req.status === 'approved'
    return `
    <tr>
      <td>
        <span class="doc-code">${esc(req.document?.code || '—')}</span><br>
        <small style="color:#6b7280">${esc(req.document?.name || '')}</small>
      </td>
      <td>${esc(req.document?.departments?.name || '—')}</td>
      <td>${esc(req.requester?.full_name || '—')}</td>
      <td style="white-space:nowrap">${fmtDate(req.created_at)}</td>
      <td class="center">
        <span class="pill ${approved ? 'pill--vigente' : 'pill--obsoleto'}">
          ${approved ? 'Aprobada' : 'Rechazada'}
        </span>
      </td>
      <td style="font-size:.82rem;color:#6b7280">${esc(req.reviewer_comment || '—')}</td>
    </tr>`
  }).join('')
}

async function approveBaja(reqId) {
  if (!confirm('¿Confirmas aprobar esta solicitud? El documento pasará a estado Obsoleto.')) return
  const req = _bajaReqs.find(r => r.id === reqId)
  if (!req) return

  const { error: e1 } = await db.from('documents')
    .update({ status: 'obsoleto' }).eq('id', req.document?.id)
  if (e1) { showToast('Error al actualizar el documento.', 'red'); return }

  const { error: e2 } = await db.from('document_deactivation_requests')
    .update({ status: 'approved', reviewed_by: _solUser.id, reviewed_at: new Date().toISOString() })
    .eq('id', reqId)
  if (e2) { showToast('Error al actualizar la solicitud.', 'red'); return }

  showToast('Solicitud aprobada. Documento dado de baja.', 'green')
  await loadBajaReqs()
}

function openRejectBaja(reqId) {
  _currentBajaId = reqId
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
      reviewed_by:      _solUser.id,
      reviewed_at:      new Date().toISOString(),
      reviewer_comment: comment
    }).eq('id', _currentBajaId)

  btn.disabled = false
  if (error) { showToast('Error al rechazar.', 'red'); return }
  showToast('Solicitud rechazada.', 'green')
  closeModal('modal-reject')
  await loadBajaReqs()
}

// ── KPIs y badges ─────────────────────────────────────────────────
function updateKPIs() {
  const pendingAlta = _altaReqs.filter(r => r.status === 'pending').length
  const pendingBaja = _bajaReqs.filter(r => r.status === 'pending').length

  setText('kpi-alta-count', pendingAlta)
  setText('kpi-baja-count', pendingBaja)

  const badgeAlta = document.getElementById('badge-alta')
  if (badgeAlta) { badgeAlta.textContent = pendingAlta; badgeAlta.style.display = pendingAlta ? 'inline-flex' : 'none' }

  const badgeBaja = document.getElementById('badge-baja')
  if (badgeBaja) { badgeBaja.textContent = pendingBaja; badgeBaja.style.display = pendingBaja ? 'inline-flex' : 'none' }

  // Badge en el nav sidebar
  const total = pendingAlta + pendingBaja
  const navBadge = document.getElementById('badge-sol')
  if (navBadge) { navBadge.textContent = total; navBadge.style.display = total > 0 ? 'inline-flex' : 'none' }
}

// ── Helpers ───────────────────────────────────────────────────────
function emptyRow(cols, msg) {
  return `<tr><td colspan="${cols}" style="text-align:center;padding:2rem;color:#9ca3af">${msg}</td></tr>`
}

function fmtDate(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('es-MX', { day:'2-digit', month:'short', year:'numeric' })
}

function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }
function setText(id, v) { const el = document.getElementById(id); if (el) el.textContent = v }
function setVal(id, v)  { const el = document.getElementById(id); if (el) el.value = v }
function esc(s) {
  return String(s || '')
    .replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}
function renderUserInfo() {
  setText('sb-user-name', _solProfile?.full_name || _solUser.email.split('@')[0])
  setText('sb-user-role', _solProfile?.roles?.display_name || 'Usuario')
}
function showToast(msg, color = 'green') {
  const el = document.getElementById('toast')
  if (!el) return
  el.textContent = msg
  el.className = 'toast toast--' + (color === 'red' ? 'red' : 'green') + ' show'
  clearTimeout(el._t)
  el._t = setTimeout(() => el.classList.remove('show'), 3500)
}

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.modal-overlay').forEach(overlay => {
    overlay.addEventListener('click', e => {
      if (e.target === overlay) overlay.classList.remove('open')
    })
  })
  // En infodoc la inicialización es lazy (al hacer click en el tab)
  if (document.body.dataset.page === 'infodoc') return
  initSolicitudes()
})
