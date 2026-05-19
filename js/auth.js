// ─── Auth helpers ───────────────────────────────────────────────

async function requireAuth() {
  const { data: { session } } = await db.auth.getSession()
  if (!session) { window.location.href = 'index.html'; return null }
  const profile = await getProfile(session.user.id)
  return { user: session.user, profile }
}

async function getProfile(userId) {
  const { data, error } = await db
    .from('profiles')
    .select('*, roles(name, display_name), departments(name)')
    .eq('id', userId)
    .single()
  if (error) console.error('[SGC] getProfile error:', error.message, '| userId:', userId)
  if (data)  console.log('[SGC] perfil cargado:', data.full_name, '| rol:', data.roles?.name)
  return data
}

async function login(email, password) {
  const { data, error } = await db.auth.signInWithPassword({ email, password })
  if (error) throw error
  return data
}

async function logout() {
  await db.auth.signOut()
  window.location.href = 'index.html'
}

// ── Control de permisos por módulo ──────────────────────────────
// Roles con acceso total que nunca se restringen
const _FULL_ACCESS_ROLES = ['administrador', 'responsable_calidad']

function hasPermission(profile, module) {
  const role = profile?.roles?.name || ''
  // administrador y responsable_calidad siempre tienen acceso
  if (_FULL_ACCESS_ROLES.includes(role)) return true
  const perms = profile?.permissions
  // sin configuración → acceso completo (retrocompat)
  if (!perms || Object.keys(perms).length === 0) return true
  // clave ausente → acceso por defecto
  if (!(module in perms)) return true
  return perms[module] !== false
}

// Redirige al dashboard si el usuario no tiene permiso para el módulo actual
function requirePermission(profile, module) {
  if (!hasPermission(profile, module)) {
    window.location.href = 'dashboard.html?blocked=' + module
  }
}
