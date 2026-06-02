-- ═══════════════════════════════════════════════════════════════════
-- Seed: Quejas 2026 — Hospital Santa Margarita
-- Fuente: Oficios HSMCA/01/2026 al HSMCA/38/2026 (19 quejas formales)
-- Responsable de Calidad: Dra. Giselle Ivette de La Torre Garcia
-- Ejecutar en: Supabase SQL Editor (como superuser, bypass RLS)
-- ═══════════════════════════════════════════════════════════════════
-- El trigger trg_queja_folio respeta el folio si ya viene asignado.
-- ON CONFLICT (folio) DO NOTHING evita duplicados si se re-ejecuta.
-- ═══════════════════════════════════════════════════════════════════

INSERT INTO public.quejas (
  folio, fecha, tipo,
  nombre_paciente, habitacion,
  departamento, personal_involucrado, descripcion,
  nombre_presenta, nombre_recibe, nombre_calidad,
  status, created_by
) VALUES

-- ── 01 · CA2601 · Camillería (Gine 10) — Conversaciones inapropiadas ──
(
  'CA2601', '2026-01-15', 'queja',
  'Familiar de paciente hospitalizado', 'Gine 10',
  'Camillería',
  'Personal de camillería',
  'Familiar reporta conversaciones inapropiadas y uso de lenguaje indebido del personal de camillería escuchadas desde la habitación Gine 10, que colinda con el área. Se detectó bebida energética en la ventana. Se autorizó cambio de habitación con costo adicional para el hospital.',
  'Familiar de paciente (presencial)',
  'Lic. Juan Carlos Vanegas Reyes — Jefe de Enfermería',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 02 · CA2602 · Caja — Trato inapropiado "Vibeck" ──────────────────
(
  'CA2602', '2026-01-18', 'queja',
  NULL, NULL,
  'Caja',
  'Vibeck (personal de caja)',
  'Queja en encuesta de salida: personal de caja "Vibeck" descrita como altanera, grosera y con muy poco tacto. Usuario manifiesta que la actitud del personal deteriora todo lo positivo calificado al hospital.',
  'Paciente (encuesta de salida)',
  'Lic. Jorge Octavio Ramírez Chávez — Jefe de Capital Humano',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 03 · CA2605 · Facturación — Contador grosero y factura tardía 2 semanas
(
  'CA2605', '2026-01-25', 'queja',
  NULL, NULL,
  'Facturación',
  'Personal de facturación / contador',
  'Usuario reporta trato grosero del área de facturación y retraso de 2 semanas en emisión de factura requerida para trámite de seguro de gastos médicos. El contador era inaccesible por llamadas y cuando respondió fue grosero, no permitió explicar la situación.',
  'Usuario (buzón digital)',
  'Lic. Héctor Román Ramírez Ramírez — Jefe de Contabilidad',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 04 · CA2606 · UCI — Enfermera Fátima, trato inadecuado ──────────
(
  'CA2606', '2026-01-26', 'queja',
  NULL, 'UCI',
  'Unidad de Cuidados Intensivos',
  'Enfermera Fátima (turno vespertino)',
  'Familiar reporta que enfermera Fátima no alimentaba a la paciente adulta mayor, su voz era altisonante, informó que la paciente no entendía cuando la familiar la vio lúcida, y no respetó recomendaciones de comunicación adaptada para reducir ansiedad ante el ventilador.',
  'Familiar de paciente (presencial en administración)',
  'Lic. Juan Carlos Vanegas Reyes / Dr. Julio César Mijangos Méndez',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 05 · CA2611 · Enfermería — Cambio de pañal inadecuado (Enf. Pio) ─
(
  'CA2611', '2026-02-05', 'queja',
  NULL, NULL,
  'Enfermería / Hospitalización',
  'Enfermera Pio (turno matutino)',
  'Familiar reporta en encuesta de salida que enfermera del turno matutino realizó cambio de pañal sin delicadeza, dejando a la paciente sucia. Familiar tuvo que limpiarla de nuevo. Riesgo de rozaduras, infecciones e impacto en la dignidad del paciente.',
  'Familiar de paciente (encuesta de salida)',
  'Lic. Juan Carlos Vanegas Reyes — Jefe de Enfermería',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 06 · CA2612 · Quirófano — Alta sin comunicación ni educación ──────
(
  'CA2612', '2026-02-06', 'queja',
  NULL, 'Recuperación quirúrgica',
  'Quirófano',
  'Personal de enfermería de quirófano y CEyE',
  'Familiar reporta que el paciente quedó en recuperación sin información tras cirugía ambulatoria; enfermería no ejecutó el plan de alta ni brindó educación sobre sonda Foley. Se identificaron fallas en entrega-recepción de turno y comunicación con familiar. La supervisora de enfermería intervino sin investigar.',
  'Familiar de paciente (presencial)',
  'Dr. Gonzalo Vázquez Camacho / Dr. Rogelio Montoya Del Campo / Lic. Juan Carlos Vanegas Reyes',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 07 · HSMCA/14 · Cocina — Queja interna de colaboradora (turno nocturno)
(
  'HSMCA/14/2026', '2026-02-05', 'queja',
  NULL, NULL,
  'Cocina / Nutrición',
  'Personal de cocina turno matutino (María de cocina)',
  'Colaboradora del turno nocturno reporta distribución inequitativa de alimentos: el turno matutino esconde la comida preparada por el nocturno y el turno nocturno recibe solo sobras. La jefatura fue notificada previamente sin resultado. Personal del turno matutino llega tarde con pretexto de permiso.',
  'Colaboradora (queja interna)',
  'Lic. Jorge Octavio Ramírez Chávez / Dr. Julio César Mijangos Méndez',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 08 · CA2613 · Camillería — Movilización inadecuada al egreso ──────
(
  'CA2613', '2026-02-06', 'queja',
  'María Luisa García Serrano', NULL,
  'Camillería',
  'Personal de camillería',
  'Familiar reporta que camillero movilizó bruscamente a paciente de 74 años con marcapasos reciente y operada de cadera, causando dolor intenso que obligó a reingresar urgencias. Paciente no tenía registro activo en el sistema; médico de urgencias aún no había valorado. Familiar tuvo que contratar ambulancia privada.',
  'Familiar de paciente (presencial y escrito)',
  'Dr. Gonzalo Vázquez Camacho — Director Médico / Lic. Juan Carlos Vanegas Reyes',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 09 · CA2614 · UCI — Enfermera Susana, trato grosero ─────────────
(
  'CA2614', '2026-02-08', 'queja',
  NULL, 'UCI',
  'Unidad de Cuidados Intensivos',
  'Enfermera Susana',
  'Familiar reporta que enfermera Susana actuó de forma apresurada y grosera al recibir indicación de traslado del paciente a terapia intensiva, y se dirigió de forma grosera también a la supervisora de enfermería, agravando la situación emocional de la familia en un momento de crisis.',
  'Familiar de paciente',
  'Lic. Juan Carlos Vanegas Reyes — Jefe de Enfermería',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 10 · CA2624 · UCI — Comentarios inapropiados sobre pronóstico ────
(
  'CA2624', '2026-03-10', 'queja',
  NULL, 'UCI',
  'Unidad de Cuidados Intensivos',
  'Personal de enfermería turno matutino (UCI)',
  'Familiar reporta que personal de enfermería preguntó en voz alta "si tendrían candidato próximo a morir" señalando al paciente. El paciente (post-angioplastia de urgencia) solicitó alta voluntaria por sentirse asustado. El médico tratante confirmó que el paciente escuchó comentarios desafortunados del personal.',
  'Familiar de paciente (presencial)',
  'Lic. Estefany C. Guerrero Cervantes / Dr. Julio César Mijangos Méndez',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 11 · CA2625 · Higiene — Cucaracha en habitación Gine 10 ──────────
(
  'CA2625', '2026-03-12', 'queja',
  NULL, 'Gine 10',
  'Seguridad e Higiene',
  NULL,
  'Familiar reporta presencia de cucaracha en el techo de la habitación Gine 10 a la 1:30 AM. Riesgo sanitario por posible contaminación de superficies, riesgo de infecciones asociadas a la atención en salud y afectación a la percepción de calidad de la institución.',
  'Familiar de paciente (presencial)',
  'Lic. Alizbeydi Vázquez Serafin — Jefe de Seguridad e Higiene',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 12 · CA2626 · Enfermería — Falta de apoyo en movilización post-cirugía
(
  'CA2626', '2026-03-13', 'queja',
  NULL, NULL,
  'Enfermería / Hospitalización',
  'Enfermera (turno matutino, egreso)',
  'Familiar (residente en California) reporta vía telefónica que enfermera del turno matutino no ayudó a movilizar a la paciente en cama tras cirugía, obligando a la familiar a hacerlo ella misma a pesar de sus propias limitaciones físicas. Exige acción correctiva y capacitación al personal.',
  'Familiar de paciente (vía telefónica)',
  'Lic. Estefany C. Guerrero Cervantes / Lic. Juan Carlos Vanegas Reyes',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 13 · CA2628 · Hospitalización — Múltiples quejas paciente Juan Pablo II
(
  'CA2628', '2026-03-23', 'queja',
  NULL, NULL,
  'Enfermería / Hospitalización',
  'Personal de enfermería y médico de guardia',
  'Paciente reporta múltiples deficiencias: pésima comunicación en llenado de bitácoras, nadie recogía charola, comida fría y de mala calidad, falta de empatía del personal, médico de guardia que no resolvió, toma duplicada de signos vitales y negativa inicial de toma de glucosa sin indicación.',
  'Paciente (presencial)',
  'Dr. Gonzalo Vázquez Camacho — Director Médico / Lic. Juan Carlos Vanegas Reyes',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 14 · CA2629 · Ginecología — Múltiples quejas Gine 1 ──────────────
(
  'CA2629', '2026-03-31', 'queja',
  NULL, 'Gine 1',
  'Ginecología',
  'Enfermero Irving (turno nocturno) y personal de cocina',
  'Familiares reportan: lenguaje obsceno y conducta inapropiada del personal de enfermería en pasillo; violación de confidencialidad al dar información telefónica a familiar no autorizado; enfermero Irving (nocturno) sin tocar antes de entrar, sin comunicar procedimientos; personal de cocina con menú no disponible y errores en apartado de cenas.',
  'Familiares de paciente (múltiples)',
  'Dr. Gonzalo Vázquez Camacho — Director Médico / Lic. Estefany C. Guerrero Cervantes',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 15 · CA2631 · Hab. 105 — Agua, higiene, enfermería nocturna, comida
(
  'CA2631', '2026-04-05', 'queja',
  NULL, '105',
  'Enfermería / Hospitalización',
  NULL,
  'Familiar de habitación 105 reporta: dispensador de agua sin vasos y sin agua durante toda la noche; enfermería insuficiente con paciente desatendida por largas horas en turno nocturno; baño con olor putrificante; sin servicio de comida al paciente en la tarde por falta de personal.',
  'Familiar de paciente',
  'Lic. Estefany C. Guerrero Cervantes / C. José Trinidad Guzmán Bautista — Mantenimiento',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 16 · CA2632 · Cafetería — Mala actitud de cajera ─────────────────
(
  'CA2632', '2026-04-07', 'queja',
  NULL, NULL,
  'Cafetería',
  'Personal de caja de cafetería',
  'Usuario reporta que la persona que cobra en la cafetería tiene muy mala actitud y nada de empatía. Riesgo reputacional, afectación a la experiencia del usuario e incumplimiento a políticas de trato digno y humanización de la atención.',
  'Usuario',
  'Lic. Jorge Octavio Ramírez Chávez — Jefe de Capital Humano',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 17 · CA2634 · Hemodiálisis — Sin alimentos durante sesión ────────
(
  'CA2634', '2026-04-13', 'queja',
  NULL, NULL,
  'Cocina / Nutrición',
  'Personal de enfermería de hemodiálisis',
  'Paciente de hemodiálisis (lun/mié/vie, 11:00–14:30 h) reporta que nunca le dan de comer durante la sesión a pesar de que el servicio incluye alimentos. Enfermería refiere que no fueron solicitados los alimentos. Coordinación deficiente entre enfermería y Nutrición. Riesgo de hipoglucemia y descompensación metabólica.',
  'Familiar de paciente',
  'Lic. Estefany C. Guerrero Cervantes / Lic. Jorge Octavio Ramírez Chávez',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 18 · CA2637 · Seguros — Proceso tardado de egreso ────────────────
(
  'CA2637', '2026-04-27', 'queja',
  NULL, NULL,
  'Seguros',
  NULL,
  'Paciente reporta que el proceso de egreso fue muy tardado por trámites con la aseguradora, solicitando que el hospital presione para obtener mejor respuesta. Riesgo de estancias prolongadas no justificadas clínicamente, insatisfacción del usuario y riesgo financiero por gestiones tardías o incompletas.',
  'Paciente',
  'Lic. Valeria Estrada Sánchez — Coordinadora de Seguros y Convenios',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
),

-- ── 19 · CA2639 · Radiología — Técnico devolvió paciente grave ────────
(
  'CA2639', '2026-05-11', 'queja',
  NULL, NULL,
  'Imagenología / Laboratorio',
  'Técnico radiólogo (guardia del viernes)',
  'Personal médico reporta que la técnico radiólogo de guardia regresó una paciente grave del área de choque al mismo lugar porque no tenía el material preparado, sin aceptar la recomendación de colocarla en tomografía mientras preparaba el material. Incremento innecesario de traslados intrahospitalarios con riesgo para paciente en estado crítico.',
  'Personal médico (interno)',
  'Lic. Jorge Octavio Ramírez Chávez / Dr. Stanislawsky Vazquez Hernandez — Jefe de Imagenología',
  'Dra. Giselle Ivette de La Torre Garcia',
  'en_proceso', NULL
)

ON CONFLICT (folio) DO NOTHING;

-- ── Verificación ──────────────────────────────────────────────────────
SELECT
  folio,
  fecha,
  tipo,
  LEFT(descripcion, 80) || '…' AS descripcion_corta,
  departamento,
  status
FROM public.quejas
WHERE folio IN (
  'CA2601','CA2602','CA2605','CA2606','CA2611','CA2612',
  'HSMCA/14/2026','CA2613','CA2614','CA2624','CA2625',
  'CA2626','CA2628','CA2629','CA2631','CA2632',
  'CA2634','CA2637','CA2639'
)
ORDER BY fecha, folio;
