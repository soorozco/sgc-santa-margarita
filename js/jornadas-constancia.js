// ─── Constancia — Primeras Jornadas Médicas ────────────────────────
const $ = id => document.getElementById(id)

document.addEventListener('DOMContentLoaded', () => {
  const folio = new URLSearchParams(location.search).get('folio')
  if (folio) { $('c-folio').value = folio.toUpperCase(); buscarConstancia() }
})

async function buscarConstancia() {
  const folio = $('c-folio').value.trim()
  const email = $('c-email').value.trim()
  const msg = $('c-msg')
  msg.className = 'msg err'

  if (!folio && !email) { msg.textContent = 'Escribe tu folio o tu correo.'; msg.className = 'msg err show'; return }

  const btn = $('c-btn')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Buscando…'

  const { data, error } = await db.rpc('jornadas_constancia', {
    p_folio: folio || null, p_email: email || null
  })

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-file-arrow-down"></i> Generar mi constancia'

  if (error) { msg.textContent = 'Error: ' + error.message; msg.className = 'msg err show'; return }
  if (!data.ok) {
    msg.textContent = 'No encontramos un registro con esos datos. Revisa tu folio o correo.'
    msg.className = 'msg err show'
    return
  }

  $('cert-nombre').textContent = data.nombre
  $('cert-folio').textContent  = 'Folio: ' + data.folio
  $('cert-taller').textContent = data.taller
    ? `Taller: ${data.taller}. ${data.taller_nombre || ''}`
    : ''
  $('form-view').style.display = 'none'
  $('cert-wrap').style.display = 'block'
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

function reiniciar() {
  $('cert-wrap').style.display = 'none'
  $('form-view').style.display = 'block'
  $('c-folio').value = ''; $('c-email').value = ''
  $('c-msg').className = 'msg err'
}
