-- ══════════════════════════════════════════════════════════════════
-- Seed: 38 Formatos Laboratorio Clínico (FT-LA)
-- Retención: 6 meses → Archivo muerto
-- Ejecutar DESPUÉS de: add_retention_months_disposition.sql
-- Departamento: Laboratorio Clínico (code = 'LA')
-- Tipo documento: Formato (code_prefix = 'FT')
-- ══════════════════════════════════════════════════════════════════

WITH
  t_ft AS (SELECT id FROM document_types WHERE code_prefix = 'FT' LIMIT 1),
  t_la AS (SELECT id FROM departments     WHERE code = 'LA'        LIMIT 1)

INSERT INTO public.documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  retention_months, disposition, description
)
SELECT
  v.code, v.name, t_ft.id, t_la.id,
  '01', 'vigente', 'Químico responsable del Laboratorio',
  6, 'Archivo muerto', v.description
FROM (VALUES

  ('FT-LA-01',
   'Bitácora para el Registro de Análisis — Área de Hematología',
   'Registro diario de los análisis realizados en el área de hematología: biometría hemática, coagulación y estudios afines.'),

  ('FT-LA-03',
   'Bitácora para el Registro de Indicaciones Vía Telefónica',
   'Control de indicaciones y solicitudes de análisis recibidas por vía telefónica por personal del laboratorio.'),

  ('FT-LA-04',
   'Bitácora para el Registro de Fallas en los Equipos o Instrumentos',
   'Registro de fallas, incidencias y acciones correctivas aplicadas a equipos e instrumentos del laboratorio.'),

  ('FT-LA-05',
   'Bitácora de Mantenimiento de CL Analyzer',
   'Control de mantenimientos preventivos y correctivos del analizador de electrolitos CL Analyzer.'),

  ('FT-LA-06',
   'Bitácora de Mantenimiento de GEM Premier 3000',
   'Control de mantenimientos preventivos y correctivos del analizador de gases sanguíneos GEM Premier 3000.'),

  ('FT-LA-07',
   'Bitácora de Mantenimiento de GETEIN',
   'Control de mantenimientos preventivos y correctivos del analizador de inmunoensayo GETEIN 1100.'),

  ('FT-LA-08',
   'Bitácora de Mantenimiento de MYTHIC 22 AL',
   'Control de mantenimientos preventivos y correctivos del analizador hematológico MYTHIC 22 AL.'),

  ('FT-LA-09',
   'Registro de Incidencias en el Control de Calidad',
   'Registro de incidencias detectadas durante los controles de calidad internos y externos del laboratorio.'),

  ('FT-LA-10',
   'Bitácora de Mantenimiento de Microscopio Primostar',
   'Control de mantenimientos preventivos y correctivos del Microscopio Primostar del área de bacteriología.'),

  ('FT-LA-11',
   'Formato de Registro de Reporte de Resultados Críticos — Pacientes Hospitalizados y Urgencias',
   'Registro y confirmación de la comunicación de valores de laboratorio críticos al personal médico en hospitalización y urgencias.'),

  ('FT-LA-12',
   'Formato de Reporte de Valores Críticos Externos',
   'Registro y confirmación de la notificación de valores críticos a pacientes externos o médicos tratantes fuera del hospital.'),

  ('FT-LA-13',
   'Bitácora de Registro de Resultados de Análisis — Química Clínica',
   'Registro de los análisis realizados en el área de química clínica: glucosa, perfil lipídico, función renal y hepática, entre otros.'),

  ('FT-LA-14',
   'Bitácora de Mantenimiento de VITROS 250',
   'Control de mantenimientos preventivos y correctivos del analizador de química seca VITROS 250.'),

  ('FT-LA-15',
   'Bitácora de Mantenimiento de miniVIDAS Blue',
   'Control de mantenimientos preventivos y correctivos del analizador inmunoenzimático miniVIDAS Blue.'),

  ('FT-LA-16',
   'Bitácora de Mantenimiento de Centrífuga CK-12',
   'Control de mantenimientos preventivos y correctivos de la centrífuga CK-12 del laboratorio.'),

  ('FT-LA-17',
   'Bitácora de Pendientes',
   'Registro de solicitudes de análisis pendientes de recolección de muestra, procesamiento o entrega de resultados.'),

  ('FT-LA-19',
   'Bitácora de Mantenimiento de Microscopio MOTIC',
   'Control de mantenimientos preventivos y correctivos del Microscopio MOTIC del área de hematología.'),

  ('FT-LA-20',
   'Bitácora de Registro de Reporte de Bacterias Multirresistentes',
   'Registro y notificación de aislamientos de bacterias multirresistentes a los servicios clínicos correspondientes.'),

  ('FT-LA-21',
   'Bitácora de Registro de Resultados de Análisis — Bacteriología',
   'Registro de cultivos, antibiogramas y resultados microbiológicos del área de bacteriología.'),

  ('FT-LA-22',
   'Bitácora de Registro de Maquilas',
   'Control de muestras enviadas a laboratorios externos (maquila): folio, tipo de estudio, laboratorio receptor y resultado recibido.'),

  ('FT-LA-27',
   'Bitácora para el Registro de Entrega de Cultivos',
   'Control de la entrega de resultados de cultivos microbiológicos al personal de enfermería o médico tratante.'),

  ('FT-LA-28',
   'Formato de Control de Temperatura — Refrigerador de Reactivos y Medios de Cultivo',
   'Registro diario de temperatura del refrigerador de reactivos y medios de cultivo para garantizar la cadena de frío.'),

  ('FT-LA-29',
   'Formato de Control para Entrega de Resultados de Laboratorio',
   'Control de entrega de resultados de análisis clínicos a pacientes, familiares o personal autorizado.'),

  ('FT-LA-30',
   'Formato de Control de Temperatura del Almacén',
   'Registro diario de temperatura del almacén general del laboratorio para resguardo adecuado de insumos.'),

  ('FT-LA-31',
   'Formato de Control de Temperatura — Refrigerador de Reactivos (Modificado)',
   'Versión modificada del registro diario de temperatura del refrigerador de reactivos.'),

  ('FT-LA-32',
   'Formato de Temperatura para el Refrigerador de Muestras (Modificado)',
   'Versión modificada del registro diario de temperatura del refrigerador de almacenamiento de muestras.'),

  ('FT-LA-33',
   'Formato de Control de Temperatura de la Incubadora',
   'Registro diario de temperatura de la incubadora para bacteriología y cultivos microbiológicos.'),

  ('FT-LA-34',
   'Formato de Inventario — Almacén General Laboratorio',
   'Inventario periódico de reactivos, insumos y materiales del almacén general del laboratorio clínico.'),

  ('FT-LA-35',
   'Formato de Inventario — Área de Bacteriología',
   'Inventario periódico de medios de cultivo, reactivos y materiales del área de bacteriología.'),

  ('FT-LA-36',
   'Formato de Inventario — Hematología',
   'Inventario periódico de reactivos, calibradores y controles del área de hematología.'),

  ('FT-LA-37',
   'Formato de Inventario de Reactivos — Área de Química Clínica',
   'Inventario periódico de reactivos, calibradores y controles del área de química clínica.'),

  ('FT-LA-38',
   'Formato de Solicitud de Reactivos — Refrigerador y Congelador Área de Química Clínica',
   'Solicitud interna de reactivos almacenados en refrigerador o congelador del área de química clínica.'),

  ('FT-LA-41',
   'Cadena de Custodia para Examen Antidoping (Anverso)',
   'Formulario anverso de cadena de custodia para la toma, identificación y traslado de muestras para examen antidoping.'),

  ('FT-LA-42',
   'Formato de Consentimiento para Toma de Muestras',
   'Consentimiento informado del paciente o tutor para la toma de muestras biológicas en el laboratorio clínico.'),

  ('FT-LA-44',
   'Formato de Reporte de Punciones Accidentales — Personal Laboratorio',
   'Reporte de incidentes de punción accidental o exposición a material biológico del personal del laboratorio.'),

  ('FT-LA-45',
   'Cadena de Custodia para Examen Antidoping',
   'Formulario completo de cadena de custodia para toma, identificación, traslado y análisis de muestras antidoping.'),

  ('FT-LA-46',
   'Solicitud de Análisis Clínicos',
   'Formato de solicitud de análisis clínicos para pacientes ambulatorios u hospitalizados del laboratorio clínico.'),

  ('FT-LA-47',
   'Bitácora de Rechazo de Muestras',
   'Registro de muestras rechazadas con criterio de rechazo, área de origen, responsable y acción tomada.')

) AS v(code, name, description)
CROSS JOIN t_ft, t_la

ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  retention_months  = EXCLUDED.retention_months,
  disposition       = EXCLUDED.disposition,
  description       = EXCLUDED.description,
  updated_at        = now();

-- ── Verificación ──────────────────────────────────────────────────
SELECT
  d.code,
  d.name,
  d.retention_months,
  d.disposition,
  d.status
FROM public.documents d
WHERE d.code LIKE 'FT-LA-%'
ORDER BY d.code;
