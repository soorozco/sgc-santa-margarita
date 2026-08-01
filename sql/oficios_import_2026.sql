-- ══════════════════════════════════════════════════════════════════
-- Importación de Oficios 2026 — Hospital Santa Margarita
-- Generado desde la carpeta local 'OFICIOS 2026' (79 archivos .docx).
--
-- Se toma el número del nombre del archivo (tu codificación HSMxx/NN/AAAA),
-- la fecha de la firma del oficio, el asunto, a quién va dirigido y quién
-- firma. Cuando el oficio menciona el folio de una queja (CA26xx), se
-- vincula automáticamente con esa queja SI ya existe en la base.
--
-- Es RE-EJECUTABLE: no duplica (omite los números que ya existan).
-- No pone enlace al documento (los .docx están en tu equipo, no en Drive);
-- puedes pegar el enlace de Drive en cada oficio después, o lo hacemos
-- juntos si compartes la carpeta.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/01/2026', '2026-01-16', 'queja', 'Seguimiento a queja', 'Lic. en Enfría. Juan Carlos Vanegas Reyes / Jefe de Enfermería / QFB Gloria Elisa Pérez Jauregui / Jefa de Farmacia', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2601' LIMIT 1), 'Queja ref: CA2601'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/01/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMDG/01/2026', '2026-07-31', 'otro', '(sin asunto)', NULL, 'Hna. María de Jesús García Castro', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMDG/01/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/02/2026', '2026-01-19', 'queja', 'Seguimiento a queja', 'Lic. Jorge Octavio Ramírez Chávez / Jefe de Capital Humano / QFB Gloria Elisa Pérez Jauregui / Jefa de Farmacia', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2602' LIMIT 1), 'Queja ref: CA2602'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/02/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/03/2026', '2026-01-23', 'otro', 'Seguimiento a acuerdos del COCASEP', 'LNYG Michelle Alejandra G Valdivia Martín / Encargada de cocina / QFB Gloria Elisa Pérez Jauregui / Jefa de Farmacia', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/03/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/04/2026', '2026-01-27', 'queja', 'Seguimiento a queja', 'Lic. Héctor Román Ramírez Ramírez / Jefe de Contabilidad / QFB Gloria Elisa Pérez Jauregui / Jefa de Farmacia', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2605' LIMIT 1), 'Queja ref: CA2605'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/04/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/05/2026', '2026-01-27', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Juan Carlos Vanegas Reyes / Jefe de Enfermería / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2606' LIMIT 1), 'Queja ref: CA2606'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/05/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/06/2026', '2026-01-27', 'felicitacion', 'Felicitación al personal de UCI', 'Lic. Enfría. Juan Carlos Vanegas Reyes / Jefe de Enfermería / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2607' LIMIT 1), 'Queja ref: CA2607'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/06/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/07/2026', '2026-01-27', 'felicitacion', 'Felicitación al personal de Urgencias', 'Lic. Sonia Gabriela Figueroa Rubio / Jefa de Atención Continua / Dr. Uriel Fernando Ruezga Gutiérrez / Jefe de la Urgencias', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2608' LIMIT 1), 'Queja ref: CA2608'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/07/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/08/2026', '2026-01-29', 'otro', 'Proveedora de CEyE', 'Dr. Gonzalo Vázquez Camacho. / Director Médico / Dr. Uriel Fernando Ruezga Gutiérrez / Jefe de la Urgencias', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/08/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/09/2026', '2026-01-30', 'otro', 'Actividades de conmutador e informes', 'Lic. Sonia Gabriela Figueroa Rubio. / Coordinación de atención continua. / Dr. Uriel Fernando Ruezga Gutiérrez / Jefe de la Urgencias', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/09/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/10/2026', '2026-02-04', 'felicitacion', 'Felicitación al personal de Urgencias', 'Dr. Gonzalo Vázquez Camacho / Director médico / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2609' LIMIT 1), 'Queja ref: CA2609'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/10/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/11/2026', '2026-02-06', 'queja', 'Seguimiento a queja del personal de enfermería', 'Lic. Enfría. Juan Carlos Vanegas Reyes / Jefe de Enfermería / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2611' LIMIT 1), 'Queja ref: CA2611'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/11/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/12/2026', '2026-02-06', 'felicitacion', 'Felicitación al personal', 'Dr. Gonzalo Vázquez Camacho / Director médico / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2610' LIMIT 1), 'Queja ref: CA2610'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/12/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/13/2026', '2026-02-06', 'queja', 'Seguimiento a queja del personal de enfermería', 'Dr. Gonzalo Vázquez Camacho / Director Médico / Dr. Rogelio Montoya Del Campo / Jefe de Quirófano', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2612' LIMIT 1), 'Queja ref: CA2612'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/13/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/14/2026', '2026-02-09', 'queja', 'Seguimiento a queja de colaborador', 'Lic. Jorge Octavio Ramírez Chávez / Jefe de Capital Humano / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/14/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/15/2026', '2026-02-06', 'queja', 'Seguimiento a queja', 'Dr. Gonzalo Vázquez Camacho / Director Médico / Lic. Enfría. Juan Carlos Vanegas Reyes / Jefe de Enfermería', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2613' LIMIT 1), 'Queja ref: CA2613'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/15/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/16/2026', '2026-02-09', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Juan Carlos Vanegas Reyes / Jefe de Enfermería / Lic. Enfría. Juan Carlos Vanegas Reyes / Jefe de Enfermería', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2614' LIMIT 1), 'Queja ref: CA2614'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/16/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/17/2026', '2026-02-16', 'otro', 'Procedimiento de encuestas de satisfacción', 'Hna. María de Jesús García Castro / Directora General / Hna. María de Jesús Gómez Flores / Directora Administrativa', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/17/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/18/2026', '2026-02-17', 'felicitacion', 'Felicitación al personal', 'Lic. Enfría. Juan Carlos Vanegas Reyes / Jefe de Enfermería / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2616' LIMIT 1), 'Queja ref: CA2616'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/18/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/19/2026', '2026-02-27', 'felicitacion', 'Felicitación al personal', 'Dr. Gonzalo Vázquez Camcho / Director médico / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2618' LIMIT 1), 'Queja ref: CA2618'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/19/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/20/2026', '2026-03-05', 'evento_adverso', 'Incidente clínico', 'Dr. Gonzalo Vázquez Camcho / Director médico / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2623' LIMIT 1), 'Queja ref: CA2623'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/20/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/21/2026', '2026-03-06', 'evento_adverso', 'Incidente clínico', 'Dr. Gonzalo Vázquez Camacho / Director médico / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/21/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/22/2026', '2026-03-10', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefe de Enfermería / Dr. Julio Cesar Mijangos Mendez / Jefe de la Unidad de Cuidado Intensivos', 'Dra. Giselle Ivette De la Torre García', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2624' LIMIT 1), 'Queja ref: CA2624'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/22/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/23/2026', '2026-03-12', 'queja', 'Seguimiento a queja', 'Lic. Alizbeydi Vázquez Serafin / Jefe de Seguridad e higiene. / Dr. Julio Cesar Mijangos Mendez / Jefe de la Unidad de Cuidado Intensivos', 'Dra. Giselle Ivette De la Torre García', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2625' LIMIT 1), 'Queja ref: CA2625'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/23/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/24/2026', '2026-03-17', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefa de Enfermería / Lic. Enfría. Juan Carlos Vanegas Reyes / Jefe de Enfermería', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2626' LIMIT 1), 'Queja ref: CA2626'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/24/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/25/2026', '2026-03-17', 'felicitacion', 'Felicitación al personal', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefa de Enfermería / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2627' LIMIT 1), 'Queja ref: CA2627; fecha estimada (revisar)'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/25/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/26/2026', '2026-03-24', 'queja', 'Seguimiento a queja', 'Dr. Gonzalo Vázquez Camacho. / Director médico / Lic. Enfría. Juan Carlos Vanegas Reyes / Jefe de Enfermería', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2628' LIMIT 1), 'Queja ref: CA2628'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/26/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/27/2026', '2026-03-24', 'queja', 'Seguimiento a queja', 'Dr. Gonzalo Vázquez Camacho. / Director médico / Lic. Enfría. Estefany C. Guerrero Cervantes / Jefa de Enfermería', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2629' LIMIT 1), 'Queja ref: CA2629; fecha estimada (revisar)'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/27/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/28/2026', '2026-03-24', 'felicitacion', 'Felicitación al personal', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefa de Enfermería / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2629' LIMIT 1), 'Queja ref: CA2629; fecha estimada (revisar)'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/28/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/29/2026', '2026-03-23', 'evento_adverso', 'Apego a procesos institucionales', 'Dr. Gonzalo Vázquez Camacho. / Director médico / Lic. Jorge Octavio Ramírez Chávez / Jefe de Capital Humano.', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/29/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/30/2026', '2026-04-03', 'evento_adverso', 'Seguimiento de queja', 'Dr. Gonzalo Vázquez Camacho. / Director médico / Lic. Enfría. Estefany C Guerrero Cervantes / Jefa de Enfermería', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2630' LIMIT 1), 'Queja ref: CA2630'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/30/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/31/2026', '2026-04-05', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Estefany C Guerrero Cervantes / Jefa de Enfermería / C. José Trinidad Guzmán Bautista / Encargado de mantenimiento.', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2631' LIMIT 1), 'Queja ref: CA2631'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/31/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/32/2026', '2026-04-08', 'queja', 'Seguimiento a queja', 'Lic. Jorge Octavio Ramírez Chávez / Jefe de Capital Humano / C. José Trinidad Guzmán Bautista / Encargado de mantenimiento.', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2632' LIMIT 1), 'Queja ref: CA2632'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/32/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/33/2026', '2026-04-08', 'otro', 'Seguimiento a producto no conforme', 'QFB Gloria Elisa Pérez Jauregui / Jefa de Farmacia / QFB Verónica López Eugenio / Farmacia.', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/33/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/34/2026', '2026-04-08', 'otro', 'Comité de Farmacia y terapéutica, Comité de Farmacovigilancia y Comité de Tecnovigilancia', 'QFB Gloria Elisa Pérez Jauregui / Jefa de Farmacia / QFB Verónica López Eugenio / Farmacia.', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/34/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/35/2026', '2026-04-14', 'felicitacion', 'Felicitación al personal', 'Dra. Daniela Hernández Álvarez / Encargada de médicos de guardia. / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2633' LIMIT 1), 'Queja ref: CA2633'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/35/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/36/2026', '2026-04-14', 'queja', 'Seguimiento a queja', 'Lic. Jorge Octavio Ramírez Chávez / Jefe de Capital Humano / Lic. Enfría. Estefany C Guerrero Cervantes / Jefa de Enfermería', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2634' LIMIT 1), 'Queja ref: CA2634'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/36/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/37/2026', '2026-04-27', 'queja', 'Seguimiento a queja', 'Lic. Valeria Estrada Sánchez / Coordinadora de Seguros y convenios. / Lic. Enfría. Estefany C Guerrero Cervantes / Jefa de Enfermería', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2637' LIMIT 1), 'Queja ref: CA2637'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/37/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/38/2026', '2026-05-11', 'queja', 'Seguimiento a queja', 'Lic. Jorge Octavio Ramírez Chávez / Jefe de Capital Humano / Dr. Stanislawsky Vazquez Hernandez / Jefe de Imagenología', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2639' LIMIT 1), 'Queja ref: CA2639'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/38/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/39/2026', '2026-06-05', 'queja', 'Seguimiento a queja', 'Dra. Daniela Hernández Álvarez. / Encargada de médicos de guardia. / Dr. Stanislawsky Vazquez Hernandez / Jefe de Imagenología', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/39/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/40/2026', '2026-06-05', 'sugerencia', 'Sugerencia de alimentos', 'LN Alondra Sofia Gonzalez Villareal / Encargada de cocina. / Lic. Andrea Wendolyn Gutierrez Gutierrez / Nutrióloga', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/40/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/41/2026', '2026-06-05', 'queja', 'Queja cafetería', 'C. Lorena Guardado Castellanos. / Encargada de cafetería / Lic. Andrea Wendolyn Gutierrez Gutierrez / Nutrióloga', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/41/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/42/2026', '2026-06-05', 'queja', 'Seguimiento a queja', 'LN Alondra Sofia Gonzalez Villareal / Encargada de cocina. / Lic. Enfría. Estefany C Guerrero Cervantes / Jefa de enfermería', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2643' LIMIT 1), 'Queja ref: CA2643'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/42/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/43/2026', '2026-06-05', 'queja', 'Seguimiento a queja medicamentos', 'Lic. Enfría. Estefany Guerrero Cervantes / Jefa de enfermería / Lic. Andrea Wendolyn Gutierrez Gutierrez / Nutrióloga', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2644' LIMIT 1), 'Queja ref: CA2644'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/43/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/44/2026', '2026-06-09', 'no_conformidad', 'Solicitud de acción correctiva de No Conformidad', 'Hna. María de Jesús García Castro / Directora General / Hna. María de Jesús Gómez Flores / Directora Administrativa', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: NC 01'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/44/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/45/2026', '2026-06-10', 'no_conformidad', 'Solicitud de acción correctiva de No Conformidad', 'Hna. María de Jesús García Castro / Directora General / Hna. María de Jesús Gómez Flores / Directora Administrativa', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: NC 03'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/45/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/46/2026', '2026-06-10', 'no_conformidad', 'Solicitud de acción correctiva de No Conformidad', 'Lic. Diana Laura Vega Bravo / Seguridad e Higiene / Hna. María de Jesús Gómez Flores / Directora Administrativa', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: NC 03'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/46/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/47/2026', '2026-06-10', 'no_conformidad', 'Solicitud de acción correctiva de No Conformidad', 'Lic. Vanessa Geraldine Ochoa González. / Encargada de Compras / Hna. María de Jesús Gómez Flores / Directora Administrativa', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: NC 04'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/47/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/48/2026', '2026-06-10', 'no_conformidad', 'Solicitud de acción correctiva de No Conformidad', 'Dr. Gonzalo Vázquez Camacho / Director Médico / Hna. María de Jesús Gómez Flores / Directora Administrativa', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: NC 05'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/48/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/49/2026', '2026-06-10', 'no_conformidad', 'Solicitud de acción correctiva de No Conformidad', 'QFB María del Refugio Valadez Rivas / Encargada del Laboratorio / Hna. María de Jesús Gómez Flores / Directora Administrativa', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: NC 05'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/49/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/50/2026', '2026-06-10', 'desviacion', 'Solicitud de acción correctiva de Desviación', 'Valeria Estrada Sánchez / Encargada de Seguros y Convenios / Hna. María de Jesús Gómez Flores / Directora Administrativa', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: DV 04'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/50/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/51/2026', '2026-06-10', 'desviacion', 'Solicitud de acción correctiva de Desviación', 'Lic. Vanessa Geraldine Ochoa González. / Encargada de Compras / Lic. Diana Laura Vega Bravo / Seguridad e Higiene', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: DV 05'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/51/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/52/2026', '2026-06-10', 'desviacion', 'Solicitud de acción correctiva de Desviación', 'Ing. Ángel Josué Gutiérrez Garrido / Ingeniería biomédica / Lic. Diana Laura Vega Bravo / Seguridad e Higiene', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: DV 06'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/52/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/53/2026', '2026-06-10', 'desviacion', 'Solicitud de acción correctiva de Desviación', 'QFB María del Refugio Valadez Rivas / Encargada del laboratorio / Lic. Diana Laura Vega Bravo / Seguridad e Higiene', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: DV 09'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/53/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/54/2026', '2026-06-10', 'desviacion', 'Solicitud de acción correctiva de Desviación', 'Lic. Alondra Sofía Gónzalez Villareal / Encargada de cocina / Lic. Diana Laura Vega Bravo / Seguridad e Higiene', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: DV 11'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/54/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/55/2026', '2026-06-10', 'desviacion', 'Solicitud de acción correctiva de Desviación', 'Valeria Estrada Sánchez / Encargada de Seguros y Convenios / Lic. Diana Laura Vega Bravo / Seguridad e Higiene', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: DV 12'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/55/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/56/2026', '2026-06-10', 'oportunidad_mejora', 'Solicitud de atención a Oportunidad de Mejora', 'Lic. Jorge Octavio Ramírez Chávez / Jefe de Capital Humano / Lic. Diana Laura Vega Bravo / Seguridad e Higiene', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: OM 03'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/56/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/57/2026', '2026-06-10', 'oportunidad_mejora', 'Solicitud de atención a Oportunidad de Mejora', 'Lic. Diana Laura Vega Bravo / Seguridad e Higiene / Lic. Diana Laura Vega Bravo / Seguridad e Higiene', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: OM 04'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/57/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/58/2026', '2026-06-10', 'oportunidad_mejora', 'Solicitud de atención a Oportunidad de Mejora', 'Dra. Fernanda Toro Sashida / Encargada de Rehabilitación / Lic. Diana Laura Vega Bravo / Seguridad e Higiene', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, 'Ref: OM 08'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/58/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/59/2026', '2026-06-18', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Estefany C Guerrero Cervantes / Jefa de enfermería / TRR Elia Elizabeth Patiño Moreno / Encargada de inhaloterapia', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2641' LIMIT 1), 'Queja ref: CA2641'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/59/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/60/2026', '2026-06-19', 'queja', 'Queja cafetería', 'C. Lorena Guardado Castellanos. / Encargada de cafetería / Lic. Andrea Wendolyn Gutierrez Gutierrez / Nutrióloga', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2642' LIMIT 1), 'Queja ref: CA2642'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/60/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/61/2026', '2026-06-19', 'felicitacion', 'Felicitación al personal', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefa de Enfermería / Dr. Julio César Mijangos Méndez / Jefe de la Unidad de Terapia Intensiva', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2643' LIMIT 1), 'Queja ref: CA2643; fecha estimada (revisar)'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/61/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/62/2026', '2026-06-19', 'queja', 'Queja vigilancia', 'Lic. Diana Laura Vega Bravo / Encargada de seguridad e higiene / Lic. Andrea Wendolyn Gutierrez Gutierrez / Nutrióloga', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2644' LIMIT 1), 'Queja ref: CA2644'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/62/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/63/2026', '2026-06-26', 'evento_adverso', 'Evento adverso', 'Lic. Enfría. Estefany Guerrero Cervantes / Jefa de Enfermería / QFB Cesar David López Rea / Jefe de Farmacia', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/63/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/64/2026', '2026-06-27', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefa de Enfermería', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2646' LIMIT 1), 'Queja ref: CA2646'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/64/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/65/2026', '2026-07-06', 'otro', 'Ingreso de medicamentos', 'Dr. Gonzalo Vázquez Camacho / Director médico / QFB Cesar David López Rea / Jefe de Farmacia', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/65/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/66/2026', '2026-07-06', 'otro', 'Ingreso de medicamentos', 'Dr. Gonzalo Vázquez Camacho / Director médico / QFB Cesar David López Rea / Jefe de Farmacia', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/66/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/67/2026', '2026-07-06', 'otro', 'Ingreso de medicamentos', 'Dr. Gonzalo Vázquez Camacho / Director médico / QFB Cesar David López Rea / Jefe de Farmacia', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/67/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/68/2026', '2026-07-10', 'otro', 'Registros en el expediente clínico', 'Hna. María de Jesús García Castro / Directora General / QFB Cesar David López Rea / Jefe de Farmacia', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/68/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/69/2026', '2026-07-10', 'otro', 'Registros en el expediente clínico', 'Hna. María de Jesús García Castro / Directora General / QFB Cesar David López Rea / Jefe de Farmacia', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/69/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/70/2026', '2026-07-10', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefa de Enfermería / Lic. Diana Laura Vega Bravo / Encargada de seguridad e higiene', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2647' LIMIT 1), 'Queja ref: CA2647'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/70/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/71/2026', '2026-07-14', 'otro', 'Ingreso de medicamentos', 'Hna. María de Jesús García Castro / Directora General / QFB Cesar David López Rea / Jefe de Farmacia', 'Dra. Giselle Ivette De la Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/71/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/72/2026', '2026-07-14', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefa de Enfermería / Anteponiendo un cordial saludo, por medio del presente me permito informar a usted que el día 13 de julio del año en curso se recibió queja con número de folio CA2648, relacionada con la atención otorgada por el personal de enfermería durante el turno vespertino, respecto a presunta omisión en los cuidados de', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2648' LIMIT 1), 'Queja ref: CA2648'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/72/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/73/2026', '2026-07-14', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefa de Enfermería / Anteponiendo un cordial saludo, por medio del presente me permito informar a usted que el día 13 de julio del año en curso se recibió queja con número de folio CA2649, relacionada con la atención otorgada por personal de enfermería, respecto a la presunta omisión en los cuidados de higiene y baño del paciente', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2649' LIMIT 1), 'Queja ref: CA2649'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/73/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/74/2026', '2026-07-23', 'otro', 'Insumos caducado', 'Hna. María de Jesús García Castro / Directora General / Anteponiendo un cordial saludo, por medio del presente me permito informar que durante las revisiones de las áreas por parte de la jefatura de calidad se encontraron insumos caducados en específico tubos para la toma de muestras en las áreas de atención a pacientes. / El objetivo del presente es documentar los tubos para toma de m', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/74/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/75/2026', '2026-07-23', 'otro', 'Proceso de medicación', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefa de enfermería', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/75/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/76/2026', '2026-07-24', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefa de Enfermería / Luis Fernando Toro Chávez / Chef', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2650' LIMIT 1), 'Queja ref: CA2650'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/76/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/77/2026', '2026-07-24', 'queja', 'Seguimiento a queja', 'Lic. Enfría. Estefany Concepción Guerrero Cervantes / Jefa de Enfermería / Lic. Diana Laura Vega Bravo / Encargada de seguridad e higiene', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       (SELECT id FROM public.quejas WHERE folio='CA2651' LIMIT 1), 'Queja ref: CA2651'
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/77/2026');
INSERT INTO public.oficios (numero, fecha, tipo, asunto, dirigido_a, firmado_por, estado, queja_id, notas)
SELECT 'HSMCA/78/2026', '2026-07-31', 'otro', 'Plan de acciones correctivas', 'IVAC / Organismo de Certificación', 'Dra. Giselle Ivette de La Torre Garcia', 'enviado',
       NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM public.oficios WHERE numero='HSMCA/78/2026');

-- Verificación: cuántos oficios quedaron y cuántos con queja vinculada
SELECT count(*) AS total, count(queja_id) AS con_queja_vinculada FROM public.oficios;
