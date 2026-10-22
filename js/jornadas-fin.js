// ─── Fin de las Jornadas: activa los enlaces a la constancia ────────
// Los elementos con el atributo data-constancia permanecen ocultos
// hasta que terminan las Jornadas (23 oct 2026, 18:00 h Guadalajara).
const JORNADAS_FIN = new Date('2026-10-23T18:00:00-06:00')
const jornadasTerminaron = () => Date.now() >= JORNADAS_FIN.getTime()

function mostrarEnlacesConstancia() {
  if (!jornadasTerminaron()) return false
  document.querySelectorAll('[data-constancia]').forEach(el => { el.hidden = false })
  return true
}

document.addEventListener('DOMContentLoaded', () => {
  if (mostrarEnlacesConstancia()) return
  // Si la página queda abierta, el enlace aparece solo al llegar la hora
  const t = setInterval(() => { if (mostrarEnlacesConstancia()) clearInterval(t) }, 60 * 1000)
})
