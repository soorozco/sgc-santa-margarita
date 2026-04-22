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
