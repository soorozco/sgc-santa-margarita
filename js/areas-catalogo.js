// ─── Catálogo de Áreas / Servicios y Habitaciones ────────────────
// Hospital Santa Margarita. Mismo catálogo que usa la Encuesta de
// Satisfacción, compartido para filtrar y capturar en otros módulos.

const HSM_ROOMS_BY_AREA = {
  'Central Juan Pablo II':       ['JP01','JP02','JP03','JP04','JP05','JP06','JP07','JP08',
                                  'JP09','JP10','JP11','JP12','JP13','JP14','JP15','JP16','JP17'],
  'Central Planta Baja (PB)':    ['PB104','PB105','PB107','PB109','PB111','PB112',
                                  'PB113','PB114','PB115','PB116','PB117'],
  'Central Planta Baja (PA)':    ['PA204','PA206','PA207','PA212','PA213',
                                  'PA214','PA215','PA216','PA218'],
  'Central Planta Alta':         ['PA202'],
  'Central Ginecología':         ['GIN01','GIN02','GIN03','GIN05','GIN06','GIN07',
                                  'GIN08','GIN10','GIN11','GIN13','GIN15','GIN16','GIN17'],
  'Central Pediatría':           ['PED01','PED02','PED03','PED04','PED05'],
  'Master Suite':                ['SU01','SU02','SU03'],
  'Quirófano':                   ['QX01','QX02'],
  'Unidad de Terapia Intensiva': ['UTI01','UTI02','UTI03','UTI04'],
  'Urgencias':                   ['ACV01'],
}

const HSM_AREAS = Object.keys(HSM_ROOMS_BY_AREA)

// Todas las habitaciones (para el filtro cuando no se elige área)
const HSM_ALL_ROOMS = Object.values(HSM_ROOMS_BY_AREA).flat()

// Área a la que pertenece una habitación (por si se captura suelta)
function hsmAreaDeHabitacion(hab) {
  const h = String(hab || '').toUpperCase().trim()
  for (const [area, rooms] of Object.entries(HSM_ROOMS_BY_AREA)) {
    if (rooms.some(r => r.toUpperCase() === h)) return area
  }
  return ''
}
