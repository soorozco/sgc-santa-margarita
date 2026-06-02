-- ═══════════════════════════════════════════════════════════════════
-- Seed: Felicitaciones 2025–2026 — Hospital Santa Margarita
-- Fuentes:
--   2025: Oficio HSMCA/23/2025 (19-nov-2025)
--   2026: Oficios HSMCA/06, 07, 10, 12, 18, 19, 25, 28, 35 /2026
-- Responsable de Calidad: Dra. Giselle Ivette de La Torre Garcia
-- Ejecutar en: Supabase SQL Editor (bypass RLS)
-- ═══════════════════════════════════════════════════════════════════
-- NOTA: CA2629 está duplicado en registros físicos (felicitación +
-- queja). La felicitación usa folio CA2629-FL para evitar conflicto.
-- ═══════════════════════════════════════════════════════════════════

INSERT INTO public.quejas (
  folio, fecha, tipo,
  nombre_paciente, habitacion,
  departamento, personal_involucrado, descripcion,
  nombre_presenta, nombre_recibe, nombre_calidad,
  status, created_by
) VALUES

-- ════════════════════════════════════════════
--  2025
-- ════════════════════════════════════════════

-- ── 2025-01 · HSMCA/23/2025 · Enfermería — Carmen, Goretti, Itzel, Israel, Jazmín
(
  'HSMCA/23/2025', '2025-11-19', 'felicitacion',
  NULL, NULL,
  'Enfermería / Hospitalización',
  'Carmen, Goretti, Itzel, Israel, Jazmín (personal de enfermería)',
  'Paciente felicita por nombre al grupo de enfermería: "FELICITACIONES AL GRUPO DE ENFERMERÍA POR SU CUIDADO, PROFESIONALISMO Y CALIDAD EN SU SERVICIO. FELICIDADES Y GRACIAS (CARMEN, GORETTI, ITZEL, ISRAEL Y JAZMIN)."',
  'Paciente (buzón digital)',
  'Lic. Juan Carlos Vanegas Reyes / Lic. Jorge Octavio Ramírez Chávez',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
),

-- ════════════════════════════════════════════
--  2026
-- ════════════════════════════════════════════

-- ── 2026-01 · CA2607 · UCI — Enfermera Chelis e Irving Solano
(
  'CA2607', '2026-01-27', 'felicitacion',
  'María Martha Cazarez Tamayo', 'UCI',
  'Unidad de Cuidados Intensivos',
  'Enfermera Chelis / Enfermero Irving Solano',
  'Familiar felicita a la enfermera "Chelis" por su trato muy amable y humano con paciente de 86 años, cariñosa, atenta y paciente con los alimentos; y al enfermero Irving Solano quien la sustituyó con igual ética y humanismo. "Mi mamá se ha sentido querida y eso la hace luchar por su vida."',
  'Familiar de paciente (buzón digital y WhatsApp)',
  'Lic. Juan Carlos Vanegas Reyes / Dr. Julio César Mijangos Méndez',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
),

-- ── 2026-02 · CA2608 · Urgencias — Chica de admisión y Dra. Yesica Ochoa
(
  'CA2608', '2026-01-27', 'felicitacion',
  NULL, 'Urgencias',
  'Urgencias',
  'Personal de admisión urgencias / Dra. Yesica Ochoa',
  'Usuario felicita a la chica de admisión de urgencias y a la Dra. Yesica Ochoa (médico de fines de semana): "excelentes personas."',
  'Usuario (buzón digital)',
  'Lic. Sonia Gabriela Figueroa Rubio / Dr. Uriel Fernando Ruezga Gutiérrez',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
),

-- ── 2026-03 · CA2609 · Urgencias — Dr. Uriel
(
  'CA2609', '2026-01-28', 'felicitacion',
  NULL, 'Urgencias',
  'Urgencias',
  'Dr. Uriel (médico de guardia)',
  'Familiar agradece al Dr. Uriel por la atención a su mamá: "El trato que le dio marca la diferencia. Gracias por sus explicaciones claras y la calidad de su atención."',
  'Familiar de paciente (buzón digital)',
  'Dr. Gonzalo Vázquez Camacho — Director Médico',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
),

-- ── 2026-04 · CA2610 · UCI — Enfermera Chely y Dr. Fidel
(
  'CA2610', '2026-02-05', 'felicitacion',
  NULL, 'UCI',
  'Unidad de Cuidados Intensivos',
  'Enfermera Chely / Dr. Fidel',
  'Familiar de paciente felicita a la enfermera Chely y al Dr. Fidel: "Felicitar a la enfermera Chely y al doctor Fidel por cuidar muy bien de nuestra abuelita."',
  'Familiar de paciente (buzón digital)',
  'Dr. Gonzalo Vázquez Camacho — Director Médico / Dr. Julio César Mijangos Méndez',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
),

-- ── 2026-05 · CA2616 · Enfermería — Joven amable turno nocturno
(
  'CA2616', '2026-02-11', 'felicitacion',
  NULL, NULL,
  'Enfermería / Hospitalización',
  'Enfermero (turno nocturno, salida 7:30)',
  'Familiar felicita a un joven enfermero del turno nocturno: "UN JOVEN MUY AMABLE, EDUCADO, SERVICIAL, AL PENDIENTE TODO EL TIEMPO, FELICIDADES POR SU ESPÍRITU DE SERVICIO." (Turno noche, salió a las 7:30 de turno.)',
  'Familiar de paciente (buzón digital)',
  'Lic. Juan Carlos Vanegas Reyes / Dr. Julio César Mijangos Méndez',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
),

-- ── 2026-06 · CA2618 · Cafetería — Señoras de cafetería y comida deliciosa
(
  'CA2618', '2026-02-26', 'felicitacion',
  NULL, NULL,
  'Cafetería',
  'Personal de cafetería',
  'Familiar felicita a las dos señoras de cafetería: "La atención de las dos señoras, en cafetería muy amables y principalmente su comida deliciosa, muchas gracias por eso."',
  'Familiar de paciente (buzón digital)',
  'Dr. Gonzalo Vázquez Camacho — Director Médico',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
),

-- ── 2026-07 · CA2619 · Médicos — Dr. Emmanuel (guardia)
(
  'CA2619', '2026-02-26', 'felicitacion',
  NULL, NULL,
  'Urgencias',
  'Dr. Emmanuel (médico de guardia)',
  'Familiar felicita al médico de guardia: "La atención del médico de guardia Emmanuel fue muy amable y profesional, muchas gracias por la atención."',
  'Familiar de paciente (buzón digital)',
  'Dr. Gonzalo Vázquez Camacho — Director Médico',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
),

-- ── 2026-08 · CA2620 · Personal general — Enfermería, limpieza, cocina, camilleros
(
  'CA2620', '2026-02-26', 'felicitacion',
  NULL, NULL,
  'Enfermería / Hospitalización',
  'Personal general: enfermería, limpieza, cocina, camilleros',
  'Familiar felicita a todo el personal de atención durante la estancia: "Mi familia y yo queremos enviar una extensa felicitación a todos y cada uno de los miembros de enfermería, de limpieza, de la comida, a los camilleros y jóvenes que nos dieron un gran apoyo. Fue maravillosa la forma en que lo hicieron todos. Honestamente agradecidos."',
  'Familiar de paciente (buzón digital)',
  'Dr. Gonzalo Vázquez Camacho — Director Médico',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
),

-- ── 2026-09 · CA2627 · Enfermería — Karina Moreno (3er turno)
(
  'CA2627', '2026-03-14', 'felicitacion',
  NULL, NULL,
  'Enfermería / Hospitalización',
  'Karina Moreno (enfermera, 3er turno)',
  'Familiar felicita a enfermera del tercer turno: "QUEREMOS FELICITAR A LA ENFERMERA QUE NOS ATENDIÓ DURANTE EL 3ER T (13/03/26) POR SU EFICIENCIA, CALIDEZ Y PACIENCIA Y SU AFÁN DE SERVICIO, PREGUNTAMOS SU NOMBRE Y NOS DIJERON QUE ERA KARINA MORENO GRACIAS!"',
  'Familiar de paciente (buzón digital)',
  'Lic. Estefany C. Guerrero Cervantes / Dr. Julio César Mijangos Méndez',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
),

-- ── 2026-10 · CA2629-FL · Enfermería Gine 1 — Salma (turno mañana)
-- NOTA: Folio CA2629 ya asignado a queja Gine 1; se usa CA2629-FL para distinguir.
(
  'CA2629-FL', '2026-03-31', 'felicitacion',
  NULL, 'Gine 1',
  'Ginecología',
  'Enfermera Salma (turno mañana, Gine 1)',
  'Familiar felicita a enfermera del turno matutino en Gine 1: "Mi felicitación y reconocimiento a la enfermera Salma de Gine 1 del turno de la mañana. Muy dedicada, empática, profesional, simpática y atenta con mi paciente. Estuvo siempre al pendiente de lo que requería."',
  'Familiar de paciente (buzón digital)',
  'Lic. Estefany C. Guerrero Cervantes / Dr. Julio César Mijangos Méndez',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
),

-- ── 2026-11 · CA2633 · Médicos de guardia — Reconocimiento general
(
  'CA2633', '2026-04-08', 'felicitacion',
  NULL, NULL,
  'Urgencias',
  'Médicos de guardia (general)',
  'Familiar felicita al personal médico de guardia en general: "Quiero felicitar a personal de guardia (médicos) ya que siempre presentan buena actitud y tienen todo en orden, así como excelente trato con pacientes y familiares."',
  'Familiar de paciente (buzón digital)',
  'Dra. Daniela Hernández Álvarez — Encargada de médicos de guardia',
  'Dra. Giselle Ivette de La Torre Garcia',
  'cerrado', NULL
)

ON CONFLICT (folio) DO NOTHING;

-- ── Verificación ──────────────────────────────────────────────────────
SELECT
  folio,
  fecha,
  departamento,
  LEFT(descripcion, 90) || '…' AS descripcion_corta,
  personal_involucrado,
  status
FROM public.quejas
WHERE tipo = 'felicitacion'
ORDER BY fecha, folio;
