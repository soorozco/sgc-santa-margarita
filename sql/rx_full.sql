-- ═══════════════════════════════════════════════════════════════════
-- Imagenología — Radiología e Imagen
-- 9 Procedimientos: PR-RX-01 a PR-RX-09
-- Ejecutar en Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════════

-- ──────────────────────────────────────────────────────────────────
-- 1. DOCUMENTOS
-- ──────────────────────────────────────────────────────────────────

INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-01',
  'Procesos para Toma de Estudios Contrastados de Hospitalización',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE name ILIKE '%radiolog%' OR name ILIKE '%imagen%' LIMIT 1),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-01');

INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-02',
  'Proceso de Solicitud para la Realización de Estudios Contrastados de Pacientes de Urgencias',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE name ILIKE '%radiolog%' OR name ILIKE '%imagen%' LIMIT 1),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-02');

INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-03',
  'Proceso de Solicitud para la Realización de Estudios de Radiología Simples de Pacientes Externos',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE name ILIKE '%radiolog%' OR name ILIKE '%imagen%' LIMIT 1),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-03');

INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-04',
  'Proceso de Solicitud para la Realización de Estudios de Radiografías Simples de Pacientes Hospitalizados',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE name ILIKE '%radiolog%' OR name ILIKE '%imagen%' LIMIT 1),
  '3', 'vigente', '2025-09-29',
  'Dr. Stanislawsky Vázquez Hernández', 'Dra. Giselle Ivette De la Torre García'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-04');

INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-05',
  'Proceso de Solicitud para la Realización de Estudios Contrastados en Pacientes Externos',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE name ILIKE '%radiolog%' OR name ILIKE '%imagen%' LIMIT 1),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-05');

INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-06',
  'Proceso de Solicitud para la Realización de Estudios Contrastados de Pacientes de Hospitalización con COVID',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE name ILIKE '%radiolog%' OR name ILIKE '%imagen%' LIMIT 1),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-06');

INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-07',
  'Proceso de Solicitud para la Realización de Estudios de Radiología Simples de Pacientes Externos con COVID',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE name ILIKE '%radiolog%' OR name ILIKE '%imagen%' LIMIT 1),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-07');

INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-08',
  'Proceso de Solicitud para la Realización de Estudios Contrastados en Pacientes Externos con COVID',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE name ILIKE '%radiolog%' OR name ILIKE '%imagen%' LIMIT 1),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-08');

INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-09',
  'Proceso de Solicitud para la Realización de Estudios de Radiografías Simples de Pacientes de Hospitalización con COVID',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE name ILIKE '%radiolog%' OR name ILIKE '%imagen%' LIMIT 1),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-09');


-- ──────────────────────────────────────────────────────────────────
-- 2. CONTENIDO DIGITAL
-- ──────────────────────────────────────────────────────────────────

-- ── PR-RX-01 ──────────────────────────────────────────────────────
INSERT INTO document_content (document_id, objetivo, alcance, responsabilidades, desarrollo, gestion_riesgos, referencias, control_cambios, elaborado_por, cargo_elaboro, revisado_por, cargo_reviso, autorizado_por, cargo_autorizo)
SELECT
  (SELECT id FROM documents WHERE code='PR-RX-01'),
  'Realizar estudios de rayos x utilizando medio de contraste, de acuerdo con las especificaciones escritas en la solicitud de estudios de imagen elaborada por el médico de Hospitalización del Hospital Santa Margarita.',
  'Médico de urgencias, personal del servicio de urgencias, camilleros y personal del servicio de Radiología e Imagen.',
  '[
    {"tipo":"Actualización","descripcion":"Jefe de Radiología e Imagen"},
    {"tipo":"Ejecución","descripcion":"Médico de urgencias, recepcionista, camillería, enfermería, técnico radiólogo"},
    {"tipo":"Supervisión","descripcion":"Jefe de Radiología e Imagen, Jefe de Urgencias"}
  ]'::jsonb,
  '[
    {"no":"1","responsable":"Médico de hospitalización","actividad":"Realiza la solicitud de estudios contrastados, de acuerdo con el cuadro clínico del paciente."},
    {"no":"2","responsable":"Médico de hospitalización","actividad":"Explica al paciente y/o familiar la finalidad diagnóstica del estudio contrastado solicitado."},
    {"no":"3","responsable":"Médico de hospitalización","actividad":"Entrega solicitud de estudios a enfermería en hospitalización para que coordine con Recepción de Radiología e Imagen la programación para estudio contrastado."},
    {"no":"4","responsable":"Médico de hospitalización","actividad":"Firma en el apartado destinado para nombre, firma y cédula profesional del médico tratante."},
    {"no":"5","responsable":"Recepción","actividad":"Registra y programa al paciente en la agenda de estudios contrastados de acuerdo con la disponibilidad y preparación requerida para el estudio solicitado."},
    {"no":"6","responsable":"Recepción","actividad":"Si se tiene disponibilidad al momento, bocea a camillería para que traslade al paciente de hospitalización a Radiología e Imagen."},
    {"no":"7","responsable":"Recepción","actividad":"De lo contrario, dará indicaciones a enfermería en hospitalización, quien programará con fecha y hora de acuerdo con la disponibilidad y preparación requerida."},
    {"no":"8","responsable":"Enfermería","actividad":"Recibe e identifica al paciente y corrobora el registro correcto de sus datos."},
    {"no":"9","responsable":"Enfermería","actividad":"Se cerciora que el paciente y familiar lean y firmen consentimiento informado."},
    {"no":"10","responsable":"Enfermería","actividad":"Da indicaciones al camillero para pasar al paciente a la sala de rayos x correspondiente. En caso de estudio contrastado endovenoso, corrobora vena permeable."},
    {"no":"11","responsable":"Técnico Radiólogo","actividad":"Recibe y revisa la solicitud de estudios contrastados."},
    {"no":"12","responsable":"Técnico Radiólogo","actividad":"Revisa el registro correcto del paciente."},
    {"no":"13","responsable":"Técnico Radiólogo","actividad":"Corrobora que el paciente haya leído y firmado carta de consentimiento informado."},
    {"no":"14","responsable":"Técnico Radiólogo","actividad":"Corrobora que el paciente haya realizado la preparación previa requerida para el estudio contrastado."},
    {"no":"15","responsable":"Técnico Radiólogo","actividad":"Da instrucciones al paciente para la realización del estudio contrastado solicitado. En caso de no ser candidato, notifica al médico radiólogo en turno."},
    {"no":"16","responsable":"Técnico Radiólogo","actividad":"Lee la solicitud de estudios contrastados."},
    {"no":"17","responsable":"Médico radiólogo","actividad":"Firma la carta de consentimiento informado en el apartado destinado para nombre, firma y cédula profesional."},
    {"no":"18","responsable":"Médico radiólogo","actividad":"Registra al paciente en el equipo de rayos x."},
    {"no":"19","responsable":"Técnico Radiólogo","actividad":"Realiza las proyecciones radiográficas correspondientes."},
    {"no":"20","responsable":"Técnico Radiólogo","actividad":"Revisa que el estudio esté en el sistema PACS."},
    {"no":"21","responsable":"Técnico Radiólogo","actividad":"Realiza la impresión del estudio en CD."},
    {"no":"22","responsable":"Técnico Radiólogo","actividad":"Entrega CD a recepción."},
    {"no":"23","responsable":"Camillería","actividad":"Traslada paciente a hospitalización."},
    {"no":"24","responsable":"Recepción","actividad":"Entregará los CD e impresión de estudios realizados cuando el paciente se retire con su hoja de Alta sellada por Administración."},
    {"no":"25","responsable":"Recepción","actividad":"Registrará en la bitácora de entrega de estudios al paciente."},
    {"no":"26","responsable":"Recepción","actividad":"Recaba correo electrónico para el envío de interpretación de sus radiografías simples pendientes (en el lapso de las siguientes 24-48 horas)."}
  ]'::jsonb,
  '[
    {"riesgo":"Registro erróneo del paciente en relación con su nombre correcto, edad o estudio solicitado por médico tratante.","barrera":"Corroborar los datos del paciente antes de finalizar el registro en el sistema de recepción."},
    {"riesgo":"Errores técnicos en la realización del estudio solicitado por el médico de hospitalización.","barrera":"Corroborar con el paciente el registro correcto de los datos antes de finalizar el registro en el equipo de rayos x."},
    {"riesgo":"Entrega errónea de estudios.","barrera":"Corroborar los datos antes de entregar el estudio en CD."},
    {"riesgo":"Error en el registro de correo electrónico para el envío de los estudios.","barrera":"Corroborar el correo electrónico antes de despedir al paciente."},
    {"riesgo":"Efectos secundarios al medio de contraste empleado en el estudio.","barrera":"Corroborar lectura y firma de carta de consentimiento informado por familiar y paciente."}
  ]'::jsonb,
  '[{"nombre":"No Aplica","codigo":"No aplica"}]'::jsonb,
  '[
    {"version":"01","fecha":"27/07/2022","descripcion":"Alta documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"},
    {"version":"02","fecha":"27/08/2024","descripcion":"Modificación de documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"}
  ]'::jsonb,
  'Dr. Juan Carlos Ledesma Perea', 'Jefatura de Radiología e Imagen',
  'Dr. José Gonzalo Vázquez Camacho', 'Dirección Médica',
  'Socorro Alaniz Ortiz', 'Dirección General'
WHERE NOT EXISTS (SELECT 1 FROM document_content WHERE document_id=(SELECT id FROM documents WHERE code='PR-RX-01'));


-- ── PR-RX-02 ──────────────────────────────────────────────────────
INSERT INTO document_content (document_id, objetivo, alcance, responsabilidades, desarrollo, gestion_riesgos, referencias, control_cambios, elaborado_por, cargo_elaboro, revisado_por, cargo_reviso, autorizado_por, cargo_autorizo)
SELECT
  (SELECT id FROM documents WHERE code='PR-RX-02'),
  'Realizar estudios de rayos x utilizando medio de contraste, de acuerdo con las especificaciones escritas en la solicitud de estudios de imagen elaborada por el médico de urgencias del Hospital Santa Margarita.',
  'Médico de urgencias, personal del servicio de urgencias, camilleros y personal del servicio de Radiología e Imagen.',
  '[
    {"tipo":"Actualización","descripcion":"Jefe de Radiología e Imagen"},
    {"tipo":"Ejecución","descripcion":"Médico de urgencias, recepcionista, camillería, enfermería, técnico radiólogo"},
    {"tipo":"Supervisión","descripcion":"Jefe de Radiología e Imagen, Jefe de Urgencias"}
  ]'::jsonb,
  '[
    {"no":"1","responsable":"Médico de urgencias","actividad":"Identifica correctamente al paciente. Realiza la solicitud de estudios contrastados de acuerdo con el cuadro clínico. Explica al paciente y/o familiar la finalidad diagnóstica del estudio."},
    {"no":"2","responsable":"Médico de urgencias","actividad":"Firma en el apartado de la solicitud destinado para nombre, firma y cédula profesional del médico tratante."},
    {"no":"3","responsable":"Médico de urgencias","actividad":"Entrega solicitud de estudios a enfermera de urgencias."},
    {"no":"4","responsable":"Enfermería","actividad":"Coordina con recepción de Urgencias y recepción de Radiología e Imagen la programación para el estudio contrastado."},
    {"no":"5","responsable":"Recepcionista de radiología e imagen","actividad":"Registra y programa al paciente con identificación correcta en la agenda de estudios contrastados de acuerdo con la disponibilidad y preparación requerida."},
    {"no":"6","responsable":"Recepcionista de radiología e imagen","actividad":"Si hay disponibilidad al momento, bocea al camillero para trasladar al paciente. De lo contrario, programará con fecha y hora y dará indicaciones a enfermería en urgencias."},
    {"no":"7","responsable":"Camillería","actividad":"Traslada paciente de urgencias a rayos x al momento de la realización del estudio (sea al momento o programada)."},
    {"no":"8","responsable":"Enfermería en radiología e imagen","actividad":"Recibe al paciente identificándolo correctamente y corrobora el registro correcto de sus datos en la solicitud."},
    {"no":"9","responsable":"Enfermería en radiología e imagen","actividad":"Se cerciora que el paciente y familiar lean y firmen consentimiento informado."},
    {"no":"10","responsable":"Enfermería en radiología e imagen","actividad":"Da indicaciones a camillería para pasar al paciente a la sala de rayos x correspondiente. En caso de estudio contrastado endovenoso, corrobora vena permeable."},
    {"no":"11","responsable":"Técnico Radiólogo","actividad":"Recibe al paciente identificándolo correctamente y corrobora el registro correcto de sus datos."},
    {"no":"12","responsable":"Técnico Radiólogo","actividad":"Confirma que el paciente, cuidador o familiar haya leído y firmado carta de consentimiento informado."},
    {"no":"13","responsable":"Técnico Radiólogo","actividad":"Corrobora que se hayan seguido las indicaciones dadas en la recepción al momento de la programación. En caso de no ser candidato, notifica al médico radiólogo en turno."},
    {"no":"14","responsable":"Médico radiólogo","actividad":"Lee la solicitud de estudios contrastados, corrobora si el paciente es candidato y, en caso afirmativo, firma la carta de consentimiento informado."},
    {"no":"15","responsable":"Técnico Radiólogo","actividad":"Registra al paciente con identificación correcta en el equipo de rayos X y realiza las proyecciones radiográficas correspondientes."},
    {"no":"16","responsable":"Técnico Radiólogo","actividad":"Revisa que el estudio esté en el sistema PACS, realiza la impresión del estudio en CD y lo entrega a recepcionista."},
    {"no":"17","responsable":"Camillería","actividad":"Traslada a paciente al área de urgencias."},
    {"no":"18","responsable":"Enfermería","actividad":"Corrobora que la sala de Rayos X y Vestidor estén en condiciones correctas para el siguiente paciente. De no ser así, solicita servicio de higiene y limpieza."},
    {"no":"19","responsable":"Recepcionista de radiología e imagen","actividad":"Entregará los CD e impresión de estudios cuando el paciente se retire con su hoja de Alta sellada. Registrará en bitácora y recabará correo electrónico para envío de interpretación (24-48 horas)."}
  ]'::jsonb,
  '[
    {"riesgo":"Registro erróneo del paciente en relación con su nombre correcto, edad o estudio solicitado.","barrera":"Corroborar los datos del paciente antes de finalizar el registro en el sistema de recepción."},
    {"riesgo":"Cobro erróneo de los estudios contrastados solicitados.","barrera":"Corroborar con el paciente el registro correcto de los datos antes de finalizar el registro en el equipo de rayos x."},
    {"riesgo":"Errores técnicos en la realización del estudio solicitado por el médico de urgencias.","barrera":"Corroborar los datos antes de entregar el estudio en CD."},
    {"riesgo":"Entrega errónea de estudios.","barrera":"Corroborar el correo electrónico antes de despedir al paciente."},
    {"riesgo":"Error en el registro de correo electrónico para el envío de los estudios.","barrera":"Corroborar lectura y firma de carta de consentimiento informado por familiar y paciente."},
    {"riesgo":"Efectos secundarios al medio de contraste empleado en el estudio.","barrera":"Verificar candidatura del paciente antes de aplicar medio de contraste."}
  ]'::jsonb,
  '[{"nombre":"No Aplica","codigo":"No aplica"}]'::jsonb,
  '[
    {"version":"01","fecha":"27/07/2022","descripcion":"Alta documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"},
    {"version":"02","fecha":"27/08/2024","descripcion":"Modificación de documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"}
  ]'::jsonb,
  'Dr. Juan Carlos Ledesma Perea', 'Jefatura de Radiología e Imagen',
  'Dr. José Gonzalo Vázquez Camacho', 'Dirección Médica',
  'Socorro Alaniz Ortiz', 'Dirección General'
WHERE NOT EXISTS (SELECT 1 FROM document_content WHERE document_id=(SELECT id FROM documents WHERE code='PR-RX-02'));


-- ── PR-RX-03 ──────────────────────────────────────────────────────
INSERT INTO document_content (document_id, objetivo, alcance, responsabilidades, desarrollo, gestion_riesgos, referencias, control_cambios, elaborado_por, cargo_elaboro, revisado_por, cargo_reviso, autorizado_por, cargo_autorizo)
SELECT
  (SELECT id FROM documents WHERE code='PR-RX-03'),
  'Realizar estudios de radiografías simples, de acuerdo con las especificaciones descritas en la solicitud de estudios de imagen elaborada por el médico tratante de los pacientes externos que acuden al servicio de Radiología e Imagen del Hospital Santa Margarita.',
  'Médico tratante y personal del servicio de Radiología e Imagen.',
  '[
    {"tipo":"Actualización","descripcion":"Jefe de Radiología e Imagen"},
    {"tipo":"Ejecución","descripcion":"Recepcionista de radiología, Enfermera de radiología, Técnico Radiólogo"},
    {"tipo":"Supervisión","descripcion":"Jefe de Radiología e Imagen, Jefa de enfermeras"}
  ]'::jsonb,
  '[
    {"no":"1","responsable":"Médico tratante","actividad":"Realiza la solicitud de estudios de radiología simples, de acuerdo con el cuadro clínico del paciente."},
    {"no":"2","responsable":"Médico tratante","actividad":"Le explica al paciente y/o familiar la finalidad diagnóstica del estudio radiológico solicitado."},
    {"no":"3","responsable":"Médico tratante","actividad":"Entrega solicitud de estudios a paciente o familiar para que coordine con Recepción de Radiología e Imagen la programación."},
    {"no":"4","responsable":"Médico tratante","actividad":"Firma en el apartado destinado para nombre, firma y cédula profesional del médico tratante."},
    {"no":"5","responsable":"Recepción","actividad":"Registra y programa al paciente en la agenda de estudios radiológicos. Si hay disponibilidad al momento, genera ticket en Medisist para que el paciente pague en caja y pase a sala de espera."},
    {"no":"6","responsable":"Enfermería","actividad":"Bocea al paciente en la sala de espera."},
    {"no":"7","responsable":"Enfermería","actividad":"Recibe e identifica al paciente y corrobora el registro correcto de sus datos."},
    {"no":"8","responsable":"Enfermería","actividad":"Da indicaciones al paciente para que pase al vestidor y retire pertenencias y accesorios metálicos de su cuerpo."},
    {"no":"9","responsable":"Técnico Radiólogo","actividad":"Recibe y revisa la solicitud de estudios radiológicos."},
    {"no":"10","responsable":"Técnico Radiólogo","actividad":"Identifica al paciente."},
    {"no":"11","responsable":"Técnico Radiólogo","actividad":"Revisa el registro correcto de sus datos."},
    {"no":"12","responsable":"Técnico Radiólogo","actividad":"Corrobora que el paciente haya realizado la preparación previa requerida para el estudio radiológico."},
    {"no":"13","responsable":"Técnico Radiólogo","actividad":"Da instrucciones al paciente para la realización del estudio solicitado. En caso de no ser candidato, notifica al médico radiólogo en turno."},
    {"no":"14","responsable":"Técnico Radiólogo","actividad":"Registra al paciente en el equipo de Rayos."},
    {"no":"15","responsable":"Técnico Radiólogo","actividad":"Realiza las proyecciones radiográficas correspondientes."},
    {"no":"16","responsable":"Técnico Radiólogo","actividad":"Revisa que el estudio esté en el sistema PACS. Solo si el paciente o médico tratante lo solicitan, se realiza la impresión en CD o placa radiográfica."},
    {"no":"17","responsable":"Médico radiólogo","actividad":"Realiza la interpretación del estudio realizado."},
    {"no":"18","responsable":"Médico radiólogo","actividad":"Al término de la interpretación realizará la firma."},
    {"no":"19","responsable":"Técnico Radiólogo","actividad":"Si se solicitó CD, se entrega a recepción. Si no, se envían las imágenes por WhatsApp o correo electrónico al número indicado por el paciente o familiar."},
    {"no":"20","responsable":"Recepción","actividad":"Entregará los CD o placas radiográficas al paciente o familiar. Si acude en turno distinto, deberá presentar recibo de pago firmado y sellado por administración."},
    {"no":"21","responsable":"Recepción","actividad":"Realizará el envío de estudios vía correo electrónico y/o WhatsApp al número que el paciente o familiar indicó."}
  ]'::jsonb,
  '[
    {"riesgo":"Registro erróneo del paciente en relación con su nombre correcto, edad o estudio solicitado.","barrera":"Corroborar los datos del paciente antes de finalizar el registro en el sistema de recepción."},
    {"riesgo":"Errores técnicos en la realización del estudio solicitado por el médico tratante.","barrera":"Corroborar con el paciente el registro correcto de los datos antes de finalizar el registro en el equipo de rayos x."},
    {"riesgo":"Entrega errónea de estudios.","barrera":"Corroborar los datos antes de entregar el estudio en CD."},
    {"riesgo":"Error en el registro de correo electrónico para el envío de los estudios.","barrera":"Corroborar el correo electrónico antes de despedir al paciente."}
  ]'::jsonb,
  '[{"nombre":"No Aplica","codigo":"No aplica"}]'::jsonb,
  '[
    {"version":"01","fecha":"27/07/2022","descripcion":"Alta documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"},
    {"version":"02","fecha":"27/08/2024","descripcion":"Modificación de documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"}
  ]'::jsonb,
  'Dr. Juan Carlos Ledesma Perea', 'Jefatura de Radiología e Imagen',
  'Dr. José Gonzalo Vázquez Camacho', 'Dirección Médica',
  'Socorro Alaniz Ortiz', 'Dirección General'
WHERE NOT EXISTS (SELECT 1 FROM document_content WHERE document_id=(SELECT id FROM documents WHERE code='PR-RX-03'));


-- ── PR-RX-04 ──────────────────────────────────────────────────────
INSERT INTO document_content (document_id, objetivo, alcance, definiciones, responsabilidades, desarrollo, gestion_riesgos, referencias, control_cambios, elaborado_por, cargo_elaboro, revisado_por, cargo_reviso, autorizado_por, cargo_autorizo)
SELECT
  (SELECT id FROM documents WHERE code='PR-RX-04'),
  'Realizar estudios de radiografías simples, de acuerdo con las especificaciones escritas en la solicitud de estudios de imagen elaborada por el médico de hospitalización del Hospital Santa Margarita.',
  'Médico de hospitalización, personal de central de enfermería de hospitalización, camilleros y personal del servicio de Radiología e Imagen.',
  '[{"termino":"NA","definicion":"No aplica"}]'::jsonb,
  '[
    {"tipo":"Actualización","descripcion":"Jefe de radiología e imagen"},
    {"tipo":"Ejecución","descripcion":"Médico de Hospitalización, Recepcionista, Técnico Radiólogo, Camillero"},
    {"tipo":"Supervisión","descripcion":"Directora General"}
  ]'::jsonb,
  '[
    {"no":"5.1","responsable":"Médico de Hospitalización","actividad":"Realiza la solicitud de estudios de radiografías simples, de acuerdo con el cuadro clínico del paciente."},
    {"no":"5.2","responsable":"Médico de Hospitalización","actividad":"Explica al paciente y/o familiar la finalidad diagnóstica del estudio solicitado."},
    {"no":"5.3","responsable":"Médico de Hospitalización","actividad":"Entrega solicitud de estudios a enfermería central, para la coordinación del envío del paciente al servicio de Radiología e Imagen."},
    {"no":"5.4","responsable":"Recepcionista","actividad":"Corrobora la disponibilidad de los equipos de rayos x de acuerdo con la agenda del servicio."},
    {"no":"5.5","responsable":"Recepcionista","actividad":"Realiza el registro de datos en el sistema."},
    {"no":"5.6","responsable":"Recepcionista","actividad":"Se lleva a cabo el cobro de los estudios correspondientes."},
    {"no":"5.7","responsable":"Recepcionista","actividad":"Bocea al camillero para que traslade al paciente de hospitalización a Radiología e Imagen."},
    {"no":"5.8","responsable":"Camillero","actividad":"Traslada paciente de hospitalización a Radiología e Imagen."},
    {"no":"5.9","responsable":"Enfermera","actividad":"Recibe e identifica al paciente y corrobora el correcto registro de sus datos."},
    {"no":"5.10","responsable":"Enfermera","actividad":"Da indicaciones al camillero para pasar al paciente a la sala de rayos x correspondiente."},
    {"no":"5.11","responsable":"Técnico Radiólogo","actividad":"Recibe y revisa la solicitud de estudios de radiografías simples."},
    {"no":"5.12","responsable":"Técnico Radiólogo","actividad":"Identifica al paciente."},
    {"no":"5.13","responsable":"Técnico Radiólogo","actividad":"Corrobora el registro correcto de sus datos."},
    {"no":"5.14","responsable":"Técnico Radiólogo","actividad":"Da instrucciones al paciente para la preparación y realización del estudio solicitado."},
    {"no":"5.15","responsable":"Técnico Radiólogo","actividad":"Registra al paciente en el equipo de rayos X."},
    {"no":"5.16","responsable":"Técnico Radiólogo","actividad":"Realiza las proyecciones radiográficas correspondientes."},
    {"no":"5.17","responsable":"Técnico Radiólogo","actividad":"Revisa que el estudio esté en el sistema PACS. Solo si el paciente o médico tratante lo solicitan, se realiza la impresión en CD o placa radiográfica."},
    {"no":"5.18","responsable":"Medico Radiólogo","actividad":"Realiza la interpretación del estudio realizado."},
    {"no":"5.19","responsable":"Medico Radiólogo","actividad":"Al término de la interpretación realizará la firma."},
    {"no":"5.20","responsable":"Técnico Radiólogo","actividad":"Si se solicitó CD, se entrega a recepción para la entrega al doctor o paciente. Si no, se envían las imágenes por WhatsApp o correo electrónico."},
    {"no":"5.21","responsable":"Camillero","actividad":"Traslada paciente a hospitalización."},
    {"no":"5.22","responsable":"Recepcionista","actividad":"Entrega los CD e impresión de estudios realizados cuando el paciente se retire con su hoja de Alta sellada por Administración."},
    {"no":"5.23","responsable":"Recepcionista","actividad":"Registra en la bitácora de entrega de estudios al paciente."},
    {"no":"5.24","responsable":"Recepcionista","actividad":"Recabará su correo electrónico para el envío de interpretación de sus radiografías simples pendientes (24-48 horas) y despedirá al paciente."}
  ]'::jsonb,
  '[
    {"riesgo":"Registro erróneo del paciente en relación con su nombre correcto, edad o estudio solicitado por médico de hospitalización.","barrera":"Corroborar los datos del paciente antes de finalizar el registro en el sistema de recepción."},
    {"riesgo":"Errores técnicos en la realización del estudio solicitado por el médico de hospitalización.","barrera":"Corroborar con el paciente el registro correcto de los datos antes de finalizar el registro en el equipo de rayos x."},
    {"riesgo":"Error en la entrega y el registro de correo electrónico para el envío de los estudios de radiografías simples solicitado.","barrera":"Corroborar el correo electrónico antes de despedir al paciente."}
  ]'::jsonb,
  '[{"nombre":"NA","codigo":"No aplica"}]'::jsonb,
  '[
    {"version":"1","fecha":"27/07/2022","descripcion":"Alta del documento","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
    {"version":"2","fecha":"27/08/2024","descripcion":"Modificación del documento","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
    {"version":"3","fecha":"29/09/2025","descripcion":"Actualización del formato","realizado":"","aprobado":"Hna. María de Jesús García Castro"}
  ]'::jsonb,
  'Dr. Stanislawsky Vázquez Hernández', 'Jefe de radiología e imagen',
  'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
  'Hna. María de Jesús García Castro', 'Directora General'
WHERE NOT EXISTS (SELECT 1 FROM document_content WHERE document_id=(SELECT id FROM documents WHERE code='PR-RX-04'));


-- ── PR-RX-05 ──────────────────────────────────────────────────────
INSERT INTO document_content (document_id, objetivo, alcance, responsabilidades, desarrollo, gestion_riesgos, referencias, control_cambios, elaborado_por, cargo_elaboro, revisado_por, cargo_reviso, autorizado_por, cargo_autorizo)
SELECT
  (SELECT id FROM documents WHERE code='PR-RX-05'),
  'Realizar estudios de rayos x utilizando medio de contraste, de acuerdo con las especificaciones escritas en la solicitud de estudios de imagen elaborada por el médico tratante de los pacientes externos que acuden al servicio de Radiología e Imagen del Hospital Santa Margarita.',
  'Médico tratante y personal del servicio de Radiología e Imagen.',
  '[
    {"tipo":"Actualización","descripcion":"Jefe de Radiología e Imagen"},
    {"tipo":"Ejecución","descripcion":"Recepcionista de radiología, Enfermera de radiología, Técnico Radiólogo, Médico Radiólogo"},
    {"tipo":"Supervisión","descripcion":"Jefe de Radiología e Imagen, Jefa de enfermeras"}
  ]'::jsonb,
  '[
    {"no":"1","responsable":"Médico tratante","actividad":"Realiza la solicitud de estudios contrastados, de acuerdo con el cuadro clínico del paciente."},
    {"no":"2","responsable":"Médico tratante","actividad":"Explica al paciente y/o familiar la finalidad diagnóstica del estudio contrastado solicitado."},
    {"no":"3","responsable":"Médico tratante","actividad":"Entrega solicitud de estudios a paciente o familiar para que coordine con Recepción de Radiología e Imagen la programación para el estudio."},
    {"no":"4","responsable":"Médico tratante","actividad":"Firma en el apartado destinado para nombre, firma y cédula profesional del médico tratante."},
    {"no":"5","responsable":"Recepción","actividad":"Registra y programa al paciente en la agenda de estudios contrastados. Si hay disponibilidad, genera ticket en Medisist para que el paciente pague en caja y pase a sala de espera."},
    {"no":"6","responsable":"Enfermería","actividad":"Bocea al paciente en la sala de espera."},
    {"no":"7","responsable":"Enfermería","actividad":"Recibe e identifica al paciente."},
    {"no":"8","responsable":"Enfermería","actividad":"Corrobora el registro correcto de sus datos."},
    {"no":"9","responsable":"Enfermería","actividad":"Se cerciora que el paciente y familiar lean y firmen consentimiento informado."},
    {"no":"10","responsable":"Enfermería","actividad":"Da indicaciones al paciente para que pase al vestidor y retire pertenencias metálicas. En caso de estudio contrastado endovenoso, canaliza vena superficial y corrobora vena permeable."},
    {"no":"11","responsable":"Técnico Radiólogo","actividad":"Recibe y revisa la solicitud de estudios contrastados."},
    {"no":"12","responsable":"Técnico Radiólogo","actividad":"Identifica al paciente."},
    {"no":"13","responsable":"Técnico Radiólogo","actividad":"Corrobora que el paciente haya leído y firmado carta de consentimiento informado."},
    {"no":"14","responsable":"Técnico Radiólogo","actividad":"Revisa el registro correcto de sus datos."},
    {"no":"15","responsable":"Técnico Radiólogo","actividad":"Corrobora que el paciente haya realizado la preparación previa requerida para el estudio contrastado."},
    {"no":"16","responsable":"Técnico Radiólogo","actividad":"Da instrucciones al paciente para la realización del estudio contrastado solicitado."},
    {"no":"17","responsable":"Técnico Radiólogo","actividad":"Lee la solicitud de estudios contrastados."},
    {"no":"18","responsable":"Técnico Radiólogo","actividad":"En caso de que el paciente no sea candidato, notifica al médico radiólogo en turno."},
    {"no":"19","responsable":"Técnico Radiólogo","actividad":"Firma la carta de consentimiento informado en el apartado del médico radiólogo."},
    {"no":"20","responsable":"Técnico Radiólogo","actividad":"Registra al paciente en el equipo de Rayos x."},
    {"no":"21","responsable":"Técnico Radiólogo","actividad":"Realiza las proyecciones radiográficas correspondientes."},
    {"no":"22","responsable":"Técnico Radiólogo","actividad":"Revisa que el estudio esté en el sistema PACS. Si se solicitó, realiza impresión en CD o placa radiográfica."},
    {"no":"23","responsable":"Médico radiólogo","actividad":"Realiza y firma la interpretación del estudio realizado."},
    {"no":"24","responsable":"Técnico Radiólogo","actividad":"Si se solicitó CD, se entrega a recepción. Si no, se envían las imágenes por WhatsApp o correo electrónico."},
    {"no":"25","responsable":"Recepción","actividad":"Si el paciente acude en turno o día distinto, deberá presentar su recibo de pago firmado y sellado por la administración."},
    {"no":"26","responsable":"Recepción","actividad":"Se realizará el envío de estudios vía correo electrónico y/o WhatsApp al número que el paciente o familiar indicó."}
  ]'::jsonb,
  '[
    {"riesgo":"Registro erróneo del paciente en relación con su nombre correcto, edad o estudio solicitado.","barrera":"Corroborar los datos del paciente antes de finalizar el registro en el sistema de recepción."},
    {"riesgo":"Errores técnicos en la realización del estudio solicitado.","barrera":"Corroborar con el paciente el registro correcto de los datos antes de finalizar el registro en el equipo de rayos x."},
    {"riesgo":"Entrega errónea de estudios.","barrera":"Corroborar los datos antes de entregar el estudio en CD."},
    {"riesgo":"Error en el registro de correo electrónico para el envío de los estudios.","barrera":"Corroborar el correo electrónico antes de despedir al paciente."},
    {"riesgo":"Efectos secundarios al medio de contraste empleado en el estudio.","barrera":"Corroborar lectura y firma de carta de consentimiento informado por familiar y paciente."}
  ]'::jsonb,
  '[{"nombre":"No Aplica","codigo":"No aplica"}]'::jsonb,
  '[
    {"version":"01","fecha":"27/07/2022","descripcion":"Alta documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"},
    {"version":"02","fecha":"27/08/2024","descripcion":"Modificación de documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"}
  ]'::jsonb,
  'Dr. Juan Carlos Ledesma Perea', 'Jefatura de Radiología e Imagen',
  'Dr. José Gonzalo Vázquez Camacho', 'Dirección Médica',
  'Socorro Alaniz Ortiz', 'Dirección General'
WHERE NOT EXISTS (SELECT 1 FROM document_content WHERE document_id=(SELECT id FROM documents WHERE code='PR-RX-05'));


-- ── PR-RX-06 ──────────────────────────────────────────────────────
INSERT INTO document_content (document_id, objetivo, alcance, responsabilidades, desarrollo, gestion_riesgos, referencias, control_cambios, elaborado_por, cargo_elaboro, revisado_por, cargo_reviso, autorizado_por, cargo_autorizo)
SELECT
  (SELECT id FROM documents WHERE code='PR-RX-06'),
  'Realizar estudios de rayos x utilizando medio de contraste, de acuerdo con las especificaciones escritas en la solicitud de estudios de imagen elaborada por el médico de Hospitalización del Hospital Santa Margarita.',
  'Médico de urgencias, personal del servicio de urgencias, camilleros, enfermeras de hospitalización o urgencias y personal del servicio de Radiología e Imagen.',
  '[
    {"tipo":"Actualización","descripcion":"Jefe de Radiología e Imagen"},
    {"tipo":"Ejecución","descripcion":"Médico de hospitalización o urgencias, Recepcionista de radiología, Camilleros, Enfermera de radiología, Técnico Radiólogo"},
    {"tipo":"Supervisión","descripcion":"Jefe de Radiología e Imagen, Jefe de Urgencias, Jefa de enfermeras"}
  ]'::jsonb,
  '[
    {"no":"1","responsable":"Médico de hospitalización o urgencias","actividad":"Realiza la solicitud de estudios contrastados, de acuerdo con el cuadro clínico del paciente."},
    {"no":"2","responsable":"Médico de hospitalización o urgencias","actividad":"Explica al paciente y/o familiar la finalidad diagnóstica del estudio contrastado solicitado."},
    {"no":"3","responsable":"Médico de hospitalización o urgencias","actividad":"Entrega solicitud de estudios a enfermera central de enfermería en hospitalización."},
    {"no":"4","responsable":"Médico de hospitalización o urgencias","actividad":"Avisa que el paciente tiene COVID para que coordine con Recepción de Radiología e Imagen la programación para el estudio contrastado."},
    {"no":"5","responsable":"Médico de hospitalización o urgencias","actividad":"Firma en el apartado destinado para nombre, firma y cédula profesional del médico tratante."},
    {"no":"6","responsable":"Recepción","actividad":"Se coloca el traje de protección."},
    {"no":"7","responsable":"Recepción","actividad":"Activa el código de COVID para que desalojen el área."},
    {"no":"8","responsable":"Recepción","actividad":"Pasa al paciente al área COVID para registrarlo y programarlo en la agenda de estudios contrastados."},
    {"no":"9","responsable":"Recepción","actividad":"Si hay disponibilidad al momento, genera ticket para que un familiar vaya a pagar a caja."},
    {"no":"10","responsable":"Recepción","actividad":"Recibe el ticket sellado."},
    {"no":"11","responsable":"Recepción","actividad":"Bocea al camillero para trasladar al paciente. De lo contrario, da indicaciones a enfermería y programa con fecha y hora."},
    {"no":"12","responsable":"Camillería","actividad":"Traslada al paciente de hospitalización al área de COVID en Radiología e Imagen."},
    {"no":"13","responsable":"Enfermería","actividad":"Se coloca el traje de protección."},
    {"no":"14","responsable":"Enfermería","actividad":"Recibe e identifica al paciente y corrobora el registro correcto de sus datos."},
    {"no":"15","responsable":"Enfermería","actividad":"Se cerciora que el paciente y familiar lean y firmen consentimiento informado."},
    {"no":"16","responsable":"Enfermería","actividad":"Da indicaciones al camillero para pasar al paciente a la sala de rayos x. En caso de estudio contrastado endovenoso, corrobora vena permeable."},
    {"no":"17","responsable":"Técnico Radiólogo","actividad":"Se coloca el traje de protección."},
    {"no":"18","responsable":"Técnico Radiólogo","actividad":"Recibe y revisa la solicitud de estudios contrastados."},
    {"no":"19","responsable":"Técnico Radiólogo","actividad":"Identifica al paciente."},
    {"no":"20","responsable":"Técnico Radiólogo","actividad":"Corrobora que el paciente haya leído y firmado carta de consentimiento informado."},
    {"no":"21","responsable":"Técnico Radiólogo","actividad":"Revisa el registro correcto de sus datos."},
    {"no":"22","responsable":"Técnico Radiólogo","actividad":"Corrobora que el paciente haya realizado la preparación previa requerida."},
    {"no":"23","responsable":"Técnico Radiólogo","actividad":"Da instrucciones al paciente para la realización del estudio. En caso de no ser candidato, notifica al médico radiólogo en turno."},
    {"no":"24","responsable":"Técnico Radiólogo","actividad":"Registra al paciente en el equipo de rayos x."},
    {"no":"25","responsable":"Técnico Radiólogo","actividad":"Realiza las proyecciones radiográficas correspondientes."},
    {"no":"26","responsable":"Técnico Radiólogo","actividad":"Revisa que el estudio esté en el sistema PACS. Si el médico lo solicita, imprime en CD o placa y entrega a recepción."},
    {"no":"27","responsable":"Técnico Radiólogo","actividad":"Las imágenes se envían por WhatsApp o correo electrónico al médico tratante."},
    {"no":"28","responsable":"Médico radiólogo","actividad":"Lee la solicitud de estudios contrastados."},
    {"no":"29","responsable":"Médico radiólogo","actividad":"Corrobora que el paciente es candidato para realizar el estudio contrastado."},
    {"no":"30","responsable":"Médico radiólogo","actividad":"Se coloca el traje de protección."},
    {"no":"31","responsable":"Médico radiólogo","actividad":"Firma la carta de consentimiento informado en el apartado destinado."},
    {"no":"32","responsable":"Médico radiólogo","actividad":"Realiza y firma la interpretación del estudio realizado."},
    {"no":"33","responsable":"Médico radiólogo","actividad":"Firma y envío del resultado en forma automatizada."},
    {"no":"34","responsable":"Camillería","actividad":"Traslada paciente a hospitalización."},
    {"no":"38","responsable":"Recepción","actividad":"Entregará los CD o placas radiográficas al camillero o enfermera de hospitalización o urgencias. Cuando el paciente se retire con alta sellada, enviará estudios vía correo o WhatsApp."}
  ]'::jsonb,
  '[
    {"riesgo":"Registro erróneo del paciente en relación con su nombre correcto, edad o estudio solicitado.","barrera":"Corroborar los datos del paciente antes de finalizar el registro en la recepción."},
    {"riesgo":"Errores técnicos en la realización del estudio solicitado.","barrera":"Corroborar con el paciente el registro correcto de los datos antes de finalizar el registro en el equipo de rayos x."},
    {"riesgo":"Entrega errónea de estudios.","barrera":"Corroborar los datos antes de entregar o enviar el estudio."},
    {"riesgo":"Error en el registro de correo electrónico y/o número de celular para el envío de los estudios.","barrera":"Corroborar el correo electrónico y/o número de celular antes de despedir al paciente."},
    {"riesgo":"Efectos secundarios al medio de contraste empleado en el estudio.","barrera":"Corroborar lectura y firma de carta de consentimiento informado por familiar y paciente."}
  ]'::jsonb,
  '[{"nombre":"No Aplica","codigo":"No aplica"}]'::jsonb,
  '[
    {"version":"01","fecha":"27/07/2022","descripcion":"Alta documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"},
    {"version":"02","fecha":"27/08/2024","descripcion":"Modificación de documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"}
  ]'::jsonb,
  'Dr. Juan Carlos Ledesma Perea', 'Jefatura de Radiología e Imagen',
  'Dr. José Gonzalo Vázquez Camacho', 'Dirección Médica',
  'Socorro Alaniz Ortiz', 'Dirección General'
WHERE NOT EXISTS (SELECT 1 FROM document_content WHERE document_id=(SELECT id FROM documents WHERE code='PR-RX-06'));


-- ── PR-RX-07 ──────────────────────────────────────────────────────
INSERT INTO document_content (document_id, objetivo, alcance, responsabilidades, desarrollo, gestion_riesgos, referencias, control_cambios, elaborado_por, cargo_elaboro, revisado_por, cargo_reviso, autorizado_por, cargo_autorizo)
SELECT
  (SELECT id FROM documents WHERE code='PR-RX-07'),
  'Realizar estudios de radiografías simples, de acuerdo con las especificaciones descritas en la solicitud de estudios de imagen elaborada por el médico tratante de los pacientes externos que acuden al servicio de Radiología e Imagen del Hospital Santa Margarita.',
  'Médico tratante y personal del servicio de Radiología e Imagen.',
  '[
    {"tipo":"Actualización","descripcion":"Jefe de Radiología e Imagen"},
    {"tipo":"Ejecución","descripcion":"Recepcionista de radiología, Enfermera de radiología, Técnico Radiólogo"},
    {"tipo":"Supervisión","descripcion":"Jefe de Radiología e Imagen, Jefa de enfermeras"}
  ]'::jsonb,
  '[
    {"no":"1","responsable":"Médico tratante","actividad":"Realiza la solicitud de estudios de radiología simples, de acuerdo con el cuadro clínico del paciente."},
    {"no":"2","responsable":"Médico tratante","actividad":"Explica al paciente y/o familiar la finalidad diagnóstica del estudio radiológico solicitado."},
    {"no":"3","responsable":"Médico tratante","actividad":"Entrega solicitud de estudios a paciente o familiar para que coordine con Recepción de Radiología e Imagen la programación."},
    {"no":"4","responsable":"Médico tratante","actividad":"Firma en el apartado destinado para nombre, firma y cédula profesional del médico tratante."},
    {"no":"5","responsable":"Paciente","actividad":"Avisa que tiene COVID e ingresa por el área de urgencias."},
    {"no":"6","responsable":"Recepción","actividad":"Se coloca el traje de protección."},
    {"no":"7","responsable":"Recepción","actividad":"Activa el código de COVID para restringir el área de rayos x."},
    {"no":"8","responsable":"Recepción","actividad":"Registra y programa al paciente en la agenda de estudios radiológicos. Si hay disponibilidad, genera ticket en Medisist. Si no, da indicaciones a enfermería en hospitalización y programa con fecha y hora."},
    {"no":"9","responsable":"Enfermería","actividad":"Se coloca el traje de protección."},
    {"no":"10","responsable":"Enfermería","actividad":"Bocea al paciente en la sala de espera."},
    {"no":"11","responsable":"Enfermería","actividad":"Recibe e identifica al paciente."},
    {"no":"12","responsable":"Enfermería","actividad":"Corrobora el registro correcto de sus datos."},
    {"no":"13","responsable":"Enfermería","actividad":"Se cerciora que el paciente y familiar lean y firmen consentimiento informado."},
    {"no":"14","responsable":"Enfermería","actividad":"Da indicaciones al paciente para que pase al vestidor y retire pertenencias y accesorios metálicos de su cuerpo."},
    {"no":"15","responsable":"Técnico Radiólogo","actividad":"Se coloca el traje de protección para poder recibir al paciente."},
    {"no":"16","responsable":"Técnico Radiólogo","actividad":"Revisa la solicitud de estudios radiológicos."},
    {"no":"17","responsable":"Técnico Radiólogo","actividad":"Identifica al paciente."},
    {"no":"18","responsable":"Técnico Radiólogo","actividad":"En caso de que el paciente no sea candidato, notifica al médico radiólogo en turno."},
    {"no":"19","responsable":"Técnico Radiólogo","actividad":"Lee la solicitud de estudios radiológicos."},
    {"no":"20","responsable":"Técnico Radiólogo","actividad":"Registra al paciente en el equipo de rayos x."},
    {"no":"21","responsable":"Técnico Radiólogo","actividad":"Realiza las proyecciones radiográficas correspondientes."},
    {"no":"22","responsable":"Técnico Radiólogo","actividad":"Se realiza la impresión del estudio en CD o placa radiográfica."},
    {"no":"23","responsable":"Técnico Radiólogo","actividad":"Se envían las imágenes por WhatsApp o correo electrónico al número de celular que el paciente o familiar indicó."},
    {"no":"24","responsable":"Médico radiólogo","actividad":"Realiza y firma la interpretación del estudio realizado."},
    {"no":"25","responsable":"Técnico Radiólogo","actividad":"Entregará los CD o placas radiográficas a recepción."},
    {"no":"26","responsable":"Recepción","actividad":"Entregará los CD o placas radiográficas al paciente o familiar. Si acude en turno distinto, deberá presentar recibo de pago firmado y sellado por la administración."},
    {"no":"27","responsable":"Recepción","actividad":"Realizará el envío de estudios vía correo electrónico y/o WhatsApp al número que el paciente o familiar indicó."}
  ]'::jsonb,
  '[
    {"riesgo":"Registro erróneo del paciente en relación con su nombre correcto, edad o estudio solicitado.","barrera":"Corroborar los datos del paciente antes de finalizar el registro en el sistema de recepción."},
    {"riesgo":"Errores técnicos en la realización del estudio solicitado.","barrera":"Corroborar con el paciente el registro correcto de los datos antes de finalizar el registro en el equipo de rayos x."},
    {"riesgo":"Entrega errónea de estudios.","barrera":"Corroborar los datos antes de entregar el estudio en CD."},
    {"riesgo":"Error en el registro de correo electrónico para el envío de los estudios.","barrera":"Corroborar el correo electrónico antes de despedir al paciente."}
  ]'::jsonb,
  '[{"nombre":"No Aplica","codigo":"No aplica"}]'::jsonb,
  '[
    {"version":"01","fecha":"27/07/2022","descripcion":"Alta documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"},
    {"version":"02","fecha":"27/08/2024","descripcion":"Modificación de documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"}
  ]'::jsonb,
  'Dr. Juan Carlos Ledesma Perea', 'Jefatura de Radiología e Imagen',
  'Dr. José Gonzalo Vázquez Camacho', 'Dirección Médica',
  'Socorro Alaniz Ortiz', 'Dirección General'
WHERE NOT EXISTS (SELECT 1 FROM document_content WHERE document_id=(SELECT id FROM documents WHERE code='PR-RX-07'));


-- ── PR-RX-08 ──────────────────────────────────────────────────────
INSERT INTO document_content (document_id, objetivo, alcance, responsabilidades, desarrollo, gestion_riesgos, referencias, control_cambios, elaborado_por, cargo_elaboro, revisado_por, cargo_reviso, autorizado_por, cargo_autorizo)
SELECT
  (SELECT id FROM documents WHERE code='PR-RX-08'),
  'Realizar estudios de rayos x utilizando medio de contraste, de acuerdo con las especificaciones escritas en la solicitud de estudios de imagen elaborada por el médico tratante de los pacientes externos que acuden al servicio de Radiología e Imagen del Hospital Santa Margarita.',
  'Médico tratante y personal del servicio de Radiología e Imagen.',
  '[
    {"tipo":"Actualización","descripcion":"Jefe de Radiología e Imagen"},
    {"tipo":"Ejecución","descripcion":"Recepcionista de radiología, Enfermera de radiología, Técnico Radiólogo, Médico Radiólogo"},
    {"tipo":"Supervisión","descripcion":"Jefe de Radiología e Imagen, Jefa de enfermeras"}
  ]'::jsonb,
  '[
    {"no":"1","responsable":"Médico tratante","actividad":"Realiza la solicitud de estudios contrastados, de acuerdo con el cuadro clínico del paciente."},
    {"no":"2","responsable":"Médico tratante","actividad":"Explica al paciente y/o familiar la finalidad diagnóstica del estudio contrastado solicitado."},
    {"no":"3","responsable":"Médico tratante","actividad":"Entrega solicitud de estudios a paciente o familiar para que coordine con Recepción de Radiología e Imagen la programación."},
    {"no":"4","responsable":"Médico tratante","actividad":"Firma en el apartado destinado para nombre, firma y cédula profesional del médico tratante."},
    {"no":"5","responsable":"Paciente","actividad":"Avisa que tiene COVID e ingresa por el área de urgencias."},
    {"no":"6","responsable":"Recepción","actividad":"Se coloca el traje de protección."},
    {"no":"7","responsable":"Recepción","actividad":"Activa el código COVID para que desalojen el área."},
    {"no":"8","responsable":"Recepción","actividad":"Pasa al paciente al área de COVID para registrarlo y programarlo en la agenda. Si hay disponibilidad, genera ticket en Medisist para que el paciente pague en caja."},
    {"no":"9","responsable":"Enfermería","actividad":"Se coloca el traje de protección."},
    {"no":"10","responsable":"Enfermería","actividad":"Bocea al paciente en el área COVID."},
    {"no":"11","responsable":"Enfermería","actividad":"Recibe e identifica al paciente."},
    {"no":"12","responsable":"Enfermería","actividad":"Corrobora el registro correcto de sus datos."},
    {"no":"13","responsable":"Enfermería","actividad":"Se cerciora que el paciente y familiar lean y firmen consentimiento informado."},
    {"no":"14","responsable":"Enfermería","actividad":"Da indicaciones al paciente para que pase al vestidor y retire pertenencias metálicas. En caso de estudio contrastado endovenoso, canaliza vena superficial y corrobora vena permeable."},
    {"no":"15","responsable":"Técnico Radiólogo","actividad":"Se coloca el traje de protección."},
    {"no":"16","responsable":"Técnico Radiólogo","actividad":"Recibe y revisa la solicitud de estudios contrastados."},
    {"no":"17","responsable":"Técnico Radiólogo","actividad":"Identifica al paciente."},
    {"no":"18","responsable":"Técnico Radiólogo","actividad":"Corrobora que el paciente haya leído y firmado carta de consentimiento informado."},
    {"no":"19","responsable":"Técnico Radiólogo","actividad":"Revisa el registro correcto de sus datos."},
    {"no":"20","responsable":"Técnico Radiólogo","actividad":"Corrobora que el paciente haya realizado la preparación previa requerida para el estudio contrastado."},
    {"no":"21","responsable":"Técnico Radiólogo","actividad":"Da instrucciones al paciente para la realización del estudio contrastado solicitado."},
    {"no":"22","responsable":"Técnico Radiólogo","actividad":"Lee la solicitud de estudios contrastados."},
    {"no":"23","responsable":"Técnico Radiólogo","actividad":"En caso de que el paciente no sea candidato, notifica al médico radiólogo en turno."},
    {"no":"24","responsable":"Técnico Radiólogo","actividad":"Registra al paciente en el equipo de Rayos x."},
    {"no":"25","responsable":"Técnico Radiólogo","actividad":"Realiza las proyecciones radiográficas correspondientes."},
    {"no":"26","responsable":"Técnico Radiólogo","actividad":"Revisa que el estudio esté en el sistema PACS. Si se solicitó, realiza impresión en CD o placa radiográfica."},
    {"no":"27","responsable":"Médico radiólogo","actividad":"Firma la carta de consentimiento informado en el apartado destinado para nombre, firma y cédula profesional del médico radiólogo."},
    {"no":"28","responsable":"Médico radiólogo","actividad":"Realiza y firma la interpretación del estudio realizado."},
    {"no":"29","responsable":"Médico radiólogo","actividad":"Firma y envío del resultado en forma automatizada."},
    {"no":"30","responsable":"Técnico Radiólogo","actividad":"Si se solicitó CD, se entrega a recepción. Si no, se envían las imágenes por WhatsApp o correo electrónico."},
    {"no":"31","responsable":"Recepción","actividad":"Si el paciente acude en turno o día distinto, deberá presentar su recibo de pago firmado y sellado por la administración."},
    {"no":"32","responsable":"Recepción","actividad":"Se realizará el envío de estudios vía correo electrónico y/o WhatsApp al número que el paciente o familiar indicó."}
  ]'::jsonb,
  '[
    {"riesgo":"Registro erróneo del paciente en relación con su nombre correcto, edad o estudio solicitado.","barrera":"Corroborar los datos del paciente antes de finalizar el registro en el sistema de recepción."},
    {"riesgo":"Errores técnicos en la realización del estudio solicitado.","barrera":"Corroborar con el paciente el registro correcto de los datos antes de finalizar el registro en el equipo de rayos x."},
    {"riesgo":"Entrega errónea de estudios.","barrera":"Corroborar los datos antes de entregar el estudio en CD."},
    {"riesgo":"Error en el registro de correo electrónico para el envío de los estudios.","barrera":"Corroborar el correo electrónico antes de despedir al paciente."},
    {"riesgo":"Efectos secundarios al medio de contraste empleado en el estudio.","barrera":"Corroborar lectura y firma de carta de consentimiento informado por familiar y paciente."}
  ]'::jsonb,
  '[{"nombre":"No Aplica","codigo":"No aplica"}]'::jsonb,
  '[
    {"version":"01","fecha":"27/07/2022","descripcion":"Alta documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"},
    {"version":"02","fecha":"27/08/2024","descripcion":"Modificación de documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"}
  ]'::jsonb,
  'Dr. Juan Carlos Ledesma Perea', 'Jefatura de Radiología e Imagen',
  'Dr. José Gonzalo Vázquez Camacho', 'Dirección Médica',
  'Socorro Alaniz Ortiz', 'Dirección General'
WHERE NOT EXISTS (SELECT 1 FROM document_content WHERE document_id=(SELECT id FROM documents WHERE code='PR-RX-08'));


-- ── PR-RX-09 ──────────────────────────────────────────────────────
INSERT INTO document_content (document_id, objetivo, alcance, responsabilidades, desarrollo, gestion_riesgos, referencias, control_cambios, elaborado_por, cargo_elaboro, revisado_por, cargo_reviso, autorizado_por, cargo_autorizo)
SELECT
  (SELECT id FROM documents WHERE code='PR-RX-09'),
  'Realizar estudios de radiografías simples de acuerdo con las especificaciones escritas en la solicitud de estudios de imagen elaborada por el médico de hospitalización o urgencias del Hospital Santa Margarita.',
  'Médico de urgencias, personal del servicio de urgencias, camilleros y personal del servicio de Radiología e Imagen.',
  '[
    {"tipo":"Actualización","descripcion":"Jefe de Radiología e Imagen"},
    {"tipo":"Ejecución","descripcion":"Médico de urgencias, Recepcionista de radiología, Camilleros, Enfermera de radiología, Técnico Radiólogo, Seguridad"},
    {"tipo":"Supervisión","descripcion":"Jefe de Radiología e Imagen, Jefe de Urgencias, Jefa de enfermeras, Coordinador de seguridad"}
  ]'::jsonb,
  '[
    {"no":"1","responsable":"Urgencias","actividad":"Realiza la solicitud de estudios de radiología simple de acuerdo con el cuadro clínico, dando a conocer que el paciente presenta síntomas sospechosos o corroborados de SARS-CoV2."},
    {"no":"2","responsable":"Urgencias","actividad":"Entrega solicitud de estudios a enfermera central de enfermería en hospitalización para que coordine con Recepción de Radiología e Imagen la programación."},
    {"no":"3","responsable":"Urgencias","actividad":"Explica al paciente y/o familiar la finalidad diagnóstica del estudio simple solicitado."},
    {"no":"4","responsable":"Urgencias","actividad":"Firma en el apartado destinado para nombre, firma y cédula profesional del médico tratante."},
    {"no":"5","responsable":"Recepción","actividad":"Si hay disponibilidad al momento, genera ticket en Medisist. De lo contrario, da indicaciones a la enfermera de hospitalización y programa con fecha y hora."},
    {"no":"6","responsable":"Recepción","actividad":"Solicita a seguridad que active código COVID: se cierran y desaloja el área de ruta COVID. Bocea a camillero."},
    {"no":"7","responsable":"Camillería","actividad":"Traslada al paciente de hospitalización al área de COVID en Radiología e Imagen."},
    {"no":"8","responsable":"Enfermería","actividad":"Se coloca el traje de protección para poder recibir e identificar al paciente."},
    {"no":"9","responsable":"Enfermería","actividad":"Corrobora el registro correcto de sus datos."},
    {"no":"10","responsable":"Enfermería","actividad":"Se cerciora que el paciente y familiar lean y firmen consentimiento informado."},
    {"no":"11","responsable":"Enfermería","actividad":"Da indicaciones al camillero para pasar al paciente a la sala de rayos x correspondiente."},
    {"no":"12","responsable":"Técnico Radiólogo","actividad":"Se coloca el traje de protección."},
    {"no":"13","responsable":"Técnico Radiólogo","actividad":"Recibe y revisa la solicitud de estudios radiológicos simples."},
    {"no":"14","responsable":"Técnico Radiólogo","actividad":"Identifica al paciente."},
    {"no":"15","responsable":"Técnico Radiólogo","actividad":"Corrobora que el paciente haya leído y firmado carta de consentimiento informado."},
    {"no":"16","responsable":"Técnico Radiólogo","actividad":"Lee la solicitud de estudios radiológicos simples."},
    {"no":"17","responsable":"Técnico Radiólogo","actividad":"En caso de que el paciente no sea candidato, notifica al médico radiólogo en turno."},
    {"no":"18","responsable":"Médico radiólogo","actividad":"Firma la carta de consentimiento informado en el apartado destinado para nombre, firma y cédula profesional del médico radiólogo."},
    {"no":"19","responsable":"Técnico Radiólogo","actividad":"Registra al paciente en el equipo de rayos X."},
    {"no":"21","responsable":"Técnico Radiólogo","actividad":"Realiza las proyecciones radiográficas correspondientes."},
    {"no":"22","responsable":"Técnico Radiólogo","actividad":"Revisa que el estudio esté en el sistema PACS. Si el médico lo solicita, imprime en CD o placa radiográfica y envía imágenes por WhatsApp o correo al médico tratante."},
    {"no":"22b","responsable":"Médico radiólogo","actividad":"Realiza y firma la interpretación del estudio realizado."},
    {"no":"23","responsable":"Técnico Radiólogo","actividad":"Entrega estudio en CD o placa radiográfica a recepción."},
    {"no":"24","responsable":"Camillería","actividad":"Traslada paciente a hospitalización."},
    {"no":"25","responsable":"Recepción","actividad":"Entregará los CD o placas radiográficas a urgencias. Cuando el paciente se retire con alta sellada por Administración, enviará estudios vía correo electrónico y/o WhatsApp al número que el paciente o tutor indicó."}
  ]'::jsonb,
  '[
    {"riesgo":"Registro erróneo del paciente en relación con su nombre correcto, edad o estudio solicitado por médico de urgencias.","barrera":"Corroborar los datos del paciente antes de finalizar el registro en el sistema de recepción."},
    {"riesgo":"Errores técnicos en la realización del estudio solicitado por el médico de urgencias.","barrera":"Corroborar con el paciente el registro correcto de los datos antes de finalizar el registro en el equipo de rayos x."},
    {"riesgo":"Error en la entrega y el registro de correo electrónico para el envío de los estudios de radiografías simples.","barrera":"Corroborar los datos antes de entregar el estudio en CD e interpretaciones. Corroborar el correo electrónico antes de despedir al paciente."}
  ]'::jsonb,
  '[{"nombre":"No Aplica","codigo":"No aplica"}]'::jsonb,
  '[
    {"version":"01","fecha":"27/07/2022","descripcion":"Alta documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"},
    {"version":"02","fecha":"22/08/2024","descripcion":"Modificación de documentos","realizado":"Dr. Juan Carlos Ledesma Perea","aprobado":"Mtra. Ana Cecilia Zarate"}
  ]'::jsonb,
  'Dr. Juan Carlos Ledesma Perea', 'Jefatura de Radiología e Imagen',
  'Dr. José Gonzalo Vázquez Camacho', 'Dirección Médica',
  'Socorro Alaniz Ortiz', 'Dirección General'
WHERE NOT EXISTS (SELECT 1 FROM document_content WHERE document_id=(SELECT id FROM documents WHERE code='PR-RX-09'));


-- ──────────────────────────────────────────────────────────────────
-- Verificación
-- ──────────────────────────────────────────────────────────────────
SELECT d.code, d.name, d.current_version, d.status,
       CASE WHEN dc.id IS NOT NULL THEN 'Con contenido' ELSE 'Sin contenido' END AS contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code IN ('PR-RX-01','PR-RX-02','PR-RX-03','PR-RX-04','PR-RX-05',
                 'PR-RX-06','PR-RX-07','PR-RX-08','PR-RX-09')
ORDER BY d.code;
