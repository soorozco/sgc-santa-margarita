// ─── Catálogo compartido: Personal de Farmacia ──────────────────
// Lista única del personal que dispensa / registra / entrega / recibe /
// realiza conteos en Farmacia. Se usa en varias secciones (Dispensación
// de Controlados, Conteo de Controlados, Entrega de Turno, etc.).
//
// Para agregar, quitar o corregir un nombre: edita SOLO este arreglo y
// se actualiza en todas las páginas que lo usan.
//
// Cómo se usa en el HTML: pon un <select ... data-personal-farmacia></select>
// (sin opciones) e incluye este archivo. Se llena solo al cargar la página.

const PERSONAL_FARMACIA = [
  'Aida Araceli Ojeda Nuño',
  'Luz María García Sánchez',
  'Carlos Eduardo Sayula Arenas',
  'Daniel Ramírez Rabago',
  'Martha Patricia Quintero Navarro',
  'Patricia Montserrat Padilla González',
]

function poblarPersonalFarmacia() {
  const opts = '<option value="">— Seleccionar —</option>' +
    PERSONAL_FARMACIA.map(n => `<option value="${n}">${n}</option>`).join('')
  document.querySelectorAll('select[data-personal-farmacia]').forEach(sel => {
    const prev = sel.value           // conserva la selección si ya había
    sel.innerHTML = opts
    if (prev) sel.value = prev
  })
}

document.addEventListener('DOMContentLoaded', poblarPersonalFarmacia)
