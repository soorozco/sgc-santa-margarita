// ─── Constancia — Primeras Jornadas Médicas ────────────────────────
// Pide el folio, obtiene el nombre registrado y genera el PDF sobre el
// formato oficial (img/constancia-jornadas.jpg). Requiere js/jornadas-fin.js.
const $ = id => document.getElementById(id)

const PLANTILLA   = 'img/constancia-jornadas.jpg'
const PAGINA      = { w: 1042.56, h: 781.92 }      // tamaño del formato original (pt)
const NOMBRE_POS  = { x: 521, base: 424, maxW: 580, size: 34, minSize: 16 }
const NOMBRE_RGB  = [3, 34, 84]                    // azul del título "CONSTANCIA"

let actual = null

document.addEventListener('DOMContentLoaded', () => {
  if (!jornadasTerminaron()) { $('lock-view').style.display = 'block'; return }
  $('form-view').style.display = 'block'
  const folio = new URLSearchParams(location.search).get('folio')
  if (folio) { $('c-folio').value = folio.toUpperCase(); buscarConstancia() }
})

async function buscarConstancia() {
  const folio = $('c-folio').value.trim().toUpperCase()
  const msg = $('c-msg')
  msg.className = 'msg err'

  if (!folio) { msg.textContent = 'Escribe el folio de tu pase (por ejemplo, JM-001).'; msg.className = 'msg err show'; return }

  const btn = $('c-btn')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Buscando…'

  const { data, error } = await db.rpc('jornadas_constancia', { p_folio: folio, p_email: null })

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-magnifying-glass"></i> Buscar mi constancia'

  if (error) { msg.textContent = 'Error: ' + error.message; msg.className = 'msg err show'; return }
  if (!data.ok) {
    msg.textContent = data.code === 'NO_DISPONIBLE'
      ? 'La constancia estará disponible al terminar las Jornadas (23 de octubre, 18:00 h).'
      : 'No encontramos un registro con ese folio. Revísalo en tu pase o en tu correo de confirmación.'
    msg.className = 'msg err show'
    return
  }

  actual = data
  $('cert-nombre').textContent = data.nombre
  $('cert-folio').textContent  = 'Folio: ' + data.folio
  $('form-view').style.display = 'none'
  $('cert-wrap').style.display = 'block'
  ajustarNombrePreview()
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

// Reduce la letra de la vista previa si el nombre no cabe (igual que en el PDF)
function ajustarNombrePreview() {
  const el = $('cert-nombre')
  el.style.fontSize = ''
  let size = parseFloat(getComputedStyle(el).fontSize)
  while (el.scrollWidth > el.clientWidth && size > 6) { size -= 0.5; el.style.fontSize = size + 'px' }
}
window.addEventListener('resize', () => { if (actual) ajustarNombrePreview() })

// Las fuentes estándar de PDF solo cubren Latin-1 (á, é, ñ, ü…);
// cualquier otro carácter se reemplaza por su versión sin acento.
function textoCompatible(font, texto) {
  return [...texto].map(ch => {
    try { font.encodeText(ch); return ch } catch (_) {}
    const base = ch.normalize('NFD').replace(/[̀-ͯ]/g, '')
    try { font.encodeText(base); return base } catch (_) { return '' }
  }).join('')
}

async function descargarPDF() {
  if (!actual) return
  const btn = $('dl-btn')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Generando…'
  try {
    const { PDFDocument, StandardFonts, rgb } = PDFLib
    const pdf  = await PDFDocument.create()
    pdf.setTitle('Constancia — Primeras Jornadas Médicas')
    pdf.setAuthor('Hospital Santa Margarita')

    const img  = await pdf.embedJpg(await (await fetch(PLANTILLA)).arrayBuffer())
    const page = pdf.addPage([PAGINA.w, PAGINA.h])
    page.drawImage(img, { x: 0, y: 0, width: PAGINA.w, height: PAGINA.h })

    const font   = await pdf.embedFont(StandardFonts.TimesRomanBold)
    const nombre = textoCompatible(font, actual.nombre.trim())
    let size = NOMBRE_POS.size
    while (size > NOMBRE_POS.minSize && font.widthOfTextAtSize(nombre, size) > NOMBRE_POS.maxW) size--
    page.drawText(nombre, {
      x: NOMBRE_POS.x - font.widthOfTextAtSize(nombre, size) / 2,
      y: PAGINA.h - NOMBRE_POS.base,
      size, font, color: rgb(...NOMBRE_RGB.map(v => v / 255))
    })

    const blob = new Blob([await pdf.save()], { type: 'application/pdf' })
    const url  = URL.createObjectURL(blob)
    const a    = document.createElement('a')
    a.href = url
    a.download = `Constancia_Jornadas_${actual.folio}.pdf`
    document.body.appendChild(a); a.click(); a.remove()
    setTimeout(() => URL.revokeObjectURL(url), 60 * 1000)
  } catch (e) {
    $('dl-msg').textContent = 'No se pudo generar el PDF: ' + e.message
    $('dl-msg').className = 'msg err show'
  }
  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-file-arrow-down"></i> Descargar constancia (PDF)'
}

function reiniciar() {
  actual = null
  $('cert-wrap').style.display = 'none'
  $('form-view').style.display = 'block'
  $('c-folio').value = ''
  $('c-msg').className = 'msg err'
  $('dl-msg').className = 'msg err'
}
