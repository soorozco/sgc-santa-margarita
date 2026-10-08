// ─── Primeras Jornadas Médicas — Registro público ──────────────────
// Usa el cliente `db` (anon) de js/config.js. Todo el control de cupo
// vive en funciones de Supabase (jornadas_registrar / _disponibilidad).

const BASE_URL = location.origin + location.pathname.replace(/jornadas\.html$/, '')
let _disp = null          // disponibilidad actual
let _tallerSel = ''       // '' = sin taller

const $ = id => document.getElementById(id)

document.addEventListener('DOMContentLoaded', async () => {
  await cargarDisponibilidad()
  // Si vuelve de Google OAuth con sesión, prefinaliza
  try {
    const { data } = await db.auth.getUser()
    if (data?.user) prefillDesdeGoogle(data.user)
  } catch (_) {}
})

async function cargarDisponibilidad() {
  const { data, error } = await db.rpc('jornadas_disponibilidad')
  if (error) {
    console.warn('disponibilidad', error.message)
    $('taller-list').innerHTML = '<p class="hint">No se pudo cargar la disponibilidad. Intenta recargar.</p>'
    return
  }
  _disp = data
  renderDisponibilidad()
  renderTalleres()
}

function renderDisponibilidad() {
  $('av-rest').textContent = _disp.lugares_restantes
  $('av-reg').textContent  = _disp.registrados
  $('av-tot').textContent  = _disp.cupo_total
  $('av-rest').classList.toggle('low', _disp.lugares_restantes <= 15)

  if (!_disp.registro_abierto) {
    $('closed').style.display = 'block'
    $('reg-form').style.display = 'none'
    $('btn-google').style.display = 'none'
    document.querySelector('.divider').style.display = 'none'
  }
}

function renderTalleres() {
  const cont = $('taller-list')
  const rows = (_disp.talleres || []).map(t => {
    const full = t.restantes <= 0
    const cls  = full ? 'full' : (t.restantes <= 5 ? 'low' : 'ok')
    const txt  = full ? 'Agotado' : `${t.restantes} de ${t.cupo} lugares disponibles`
    return `
      <label class="taller ${_tallerSel == t.num ? 'sel' : ''} ${full ? 'full' : ''}" data-num="${t.num}">
        <input type="radio" name="taller" value="${t.num}" ${full ? 'disabled' : ''}
               ${_tallerSel == t.num ? 'checked' : ''} onchange="selTaller('${t.num}')">
        <span class="t-num">${t.num}</span>
        <span class="t-body">
          <span class="t-name">${esc(t.nombre)}</span>
          <span class="t-coord">Coordina: ${esc(t.coordina || '')}</span>
          <span class="t-cupo ${cls}"><i class="fa-solid ${full ? 'fa-ban' : 'fa-circle-check'}"></i> ${txt}</span>
        </span>
      </label>`
  }).join('')

  const sinTaller = `
    <label class="taller ${_tallerSel === '' ? 'sel' : ''}" data-num="">
      <input type="radio" name="taller" value="" ${_tallerSel === '' ? 'checked' : ''} onchange="selTaller('')">
      <span class="t-num"><i class="fa-regular fa-circle"></i></span>
      <span class="t-body">
        <span class="t-name">Sin taller</span>
        <span class="t-coord">Asisto solo al programa general (conferencias).</span>
      </span>
    </label>`

  cont.innerHTML = rows + sinTaller
}

function selTaller(num) {
  _tallerSel = num
  document.querySelectorAll('.taller').forEach(el =>
    el.classList.toggle('sel', el.dataset.num == num))
}

async function enviarRegistro() {
  const nombre = $('f-nombre').value.trim()
  const email  = $('f-email').value.trim()
  const tel    = $('f-tel').value.trim()
  const cat    = $('f-cat').value

  const msg = $('form-msg')
  const show = (t, kind='err') => { msg.textContent = t; msg.className = 'msg show ' + kind }
  msg.className = 'msg'

  if (nombre.length < 3) return show('Escribe tu nombre completo.')
  if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) return show('Escribe un correo válido.')
  if (!cat) return show('Selecciona tu categoría.')

  const btn = $('btn-submit')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Registrando…'

  const taller = _tallerSel === '' ? null : parseInt(_tallerSel)
  const medio  = window._googleUser ? 'google' : 'correo'
  const authUid = window._googleUser?.id || null

  const { data, error } = await db.rpc('jornadas_registrar', {
    p_nombre: nombre, p_email: email, p_telefono: tel || null,
    p_categoria: cat, p_taller: taller, p_medio: medio, p_auth_uid: authUid
  })

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-check"></i> Confirmar mi registro'

  if (error) return show('Error al registrar: ' + error.message)

  if (!data.ok) {
    if (data.code === 'YA_REGISTRADO') {
      // Ya existe: le mostramos su pase con el folio que ya tenía
      show('Este correo ya estaba registrado. Te mostramos tu pase.', 'warn')
      return mostrarPase(data, true)
    }
    if (data.code === 'TALLER_LLENO') { await cargarDisponibilidad(); return show('Ese taller acaba de agotarse. Elige otro o regístrate sin taller.') }
    if (data.code === 'EVENTO_LLENO') { await cargarDisponibilidad(); return show('El cupo del evento se agotó.') }
    if (data.code === 'CORREO_INVALIDO') return show('El correo no es válido.')
    if (data.code === 'NOMBRE_INVALIDO') return show('Escribe tu nombre completo.')
    return show('No se pudo completar el registro (' + data.code + ').')
  }

  // Éxito → enviar correo (best-effort) y mostrar pase
  enviarCorreoConfirmacion(data).catch(() => {})
  mostrarPase(data, false)
  cargarDisponibilidad()
}

function mostrarPase(d, yaExistia) {
  $('form-view').style.display = 'none'
  $('avail-card').style.display = 'none'
  $('pase-view').style.display = 'block'
  if (yaExistia) {
    $('pase-title').textContent = 'Ya estabas registrado'
    $('pase-sub').textContent = 'Este es tu pase. Imprímelo o preséntalo el día del evento.'
  }
  $('pase-folio').textContent  = d.folio
  $('pase-nombre').textContent = d.nombre
  $('pase-cat').textContent    = d.categoria || '—'
  $('pase-taller').textContent = d.taller ? `${d.taller}. ${d.taller_nombre || ''}` : 'Sin taller'

  const qbox = $('pase-qr'); qbox.innerHTML = ''
  new QRCode(qbox, {
    text: BASE_URL + 'jornadas-constancia.html?folio=' + encodeURIComponent(d.folio),
    width: 170, height: 170, colorDark: '#102a5c', colorLight: '#ffffff',
    correctLevel: QRCode.CorrectLevel.M
  })
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

// ─── Correo de confirmación (best-effort vía Edge Function) ─────────
// Funciona una vez que despliegues supabase/functions/jornadas-correo
// con la API key de Resend. Mientras tanto, falla en silencio.
async function enviarCorreoConfirmacion(d) {
  try {
    await db.functions.invoke('jornadas-correo', {
      body: { folio: d.folio, nombre: d.nombre, email: d.email,
              categoria: d.categoria, taller: d.taller, taller_nombre: d.taller_nombre }
    })
  } catch (_) { /* aún no desplegado */ }
}

// ─── Google (se activa al configurar OAuth en Supabase) ─────────────
async function registrarseConGoogle() {
  try {
    const { error } = await db.auth.signInWithOAuth({
      provider: 'google',
      options: { redirectTo: BASE_URL + 'jornadas.html' }
    })
    if (error) throw error
  } catch (e) {
    const msg = $('form-msg')
    msg.textContent = 'El acceso con Google aún no está activado. Por ahora regístrate con tu correo. 👇'
    msg.className = 'msg show warn'
  }
}

function prefillDesdeGoogle(user) {
  window._googleUser = user
  const nm = user.user_metadata?.full_name || user.user_metadata?.name || ''
  if (nm) $('f-nombre').value = nm
  if (user.email) $('f-email').value = user.email
  const msg = $('form-msg')
  msg.textContent = 'Sesión de Google detectada (' + user.email + '). Completa y confirma tu registro.'
  msg.className = 'msg show warn'
}

function esc(s){ return String(s||'').replace(/[&<>"]/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c])) }
