-- ══════════════════════════════════════════════════════════════════════
--  Documentos Externos Normativos — Hospital Santa Margarita
--  SGC ISO 9001:2015 · Cláusula §7.5.3 — Control de documentos externos
--
--  Sub-clasificación por tipo en el código:
--    DE-LEY-XXX  → Leyes federales
--    DE-REG-XXX  → Reglamentos
--    DE-NOM-XXX  → Normas Oficiales Mexicanas
--    DE-GPC-XXX  → Guías de Práctica Clínica (CENETEC)
--
--  URL de verificación (campo referencias[0].codigo):
--    Leyes y Reglamentos → www.diputados.gob.mx (URLs verificadas, HTTP 200)
--    NOMs               → www.dof.gob.mx
--
--  Idempotente: ON CONFLICT (code) DO UPDATE
-- ══════════════════════════════════════════════════════════════════════

-- ── Asegurar que el tipo DE exista ──────────────────────────────────
INSERT INTO document_types (code_prefix, name, description)
VALUES (
  'DE', 'Documento Externo',
  'Documentos de procedencia externa requeridos para el SGC: leyes, reglamentos, normas, guías de práctica clínica y manuales de fabricante.'
)
ON CONFLICT (code_prefix) DO NOTHING;

-- ── Helper: departamento Calidad como custodio genérico ──────────────
-- (ajusta 'CA' al code de tu departamento de Calidad si difiere)

-- ════════════════════════════════════════════════════════════════════
--  BLOQUE 1 — LEYES FEDERALES  (DE-LEY)
-- ════════════════════════════════════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  description, referencias
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  d.emisor,
  'Dra. Giselle De la Torre',
  'Responsable de Calidad',
  d.descripcion,
  jsonb_build_array(jsonb_build_object(
    'nombre', 'Versión vigente — Cámara de Diputados',
    'codigo', d.url
  ))
FROM (VALUES
  (
    'DE-LEY-001',
    'Ley General de Salud',
    'Congreso de la Unión',
    'Marco normativo general de los servicios de salud en México. Base legal de los establecimientos de atención médica, los derechos de los usuarios y las obligaciones sanitarias. Aplica a toda la operación hospitalaria.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LGS.pdf'
  ),
  (
    'DE-LEY-002',
    'Ley Federal del Trabajo',
    'Congreso de la Unión',
    'Regula las relaciones laborales entre el hospital y sus colaboradores. Aplica en contratación, jornadas, seguridad, riesgos de trabajo, derechos y obligaciones del personal.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LFT.pdf'
  ),
  (
    'DE-LEY-003',
    'Ley Federal de Protección al Consumidor',
    'Congreso de la Unión',
    'Establece los derechos de los pacientes como consumidores de servicios médicos. Aplica en transparencia de precios, información de servicios, contratos de adhesión y resolución de quejas.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LFPC.pdf'
  ),
  (
    'DE-LEY-004',
    'Ley Federal de Protección de Datos Personales en Posesión de Particulares',
    'Congreso de la Unión',
    'Regula el tratamiento de datos personales y sensibles (datos clínicos, diagnósticos, expediente médico) de pacientes y colaboradores. Obliga a aviso de privacidad, consentimiento y medidas de seguridad.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LFPDPPP.pdf'
  ),
  (
    'DE-LEY-005',
    'Ley General del Equilibrio Ecológico y la Protección al Ambiente',
    'Congreso de la Unión',
    'Marco legal ambiental aplicable al manejo de residuos peligrosos biológico-infecciosos (RPBI), emisiones y sustancias peligrosas. Complementa la NOM-087-SEMARNAT.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LGEEPA.pdf'
  ),
  (
    'DE-LEY-006',
    'Ley General para la Inclusión de las Personas con Discapacidad',
    'Congreso de la Unión',
    'Establece los derechos de las personas con discapacidad a la atención médica accesible. Aplica en accesibilidad de instalaciones, trato digno y no discriminación en la atención hospitalaria.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LGIPD.pdf'
  )
) AS d(code, name, emisor, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  referencias        = EXCLUDED.referencias,
  status             = EXCLUDED.status,
  elaborated_by      = EXCLUDED.elaborated_by,
  custodian_position = EXCLUDED.custodian_position;


-- ════════════════════════════════════════════════════════════════════
--  BLOQUE 2 — REGLAMENTOS  (DE-REG)
--  URLs verificadas en diputados.gob.mx (HTTP 200)
-- ════════════════════════════════════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  description, referencias
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud / STPS',
  'Dra. Giselle De la Torre',
  'Responsable de Calidad',
  d.descripcion,
  jsonb_build_array(jsonb_build_object(
    'nombre', 'Versión vigente — Cámara de Diputados',
    'codigo', d.url
  ))
FROM (VALUES
  (
    'DE-REG-001',
    'Reglamento de la Ley General de Salud en Materia de Prestación de Servicios de Atención Médica',
    'Regula el funcionamiento de los establecimientos de atención médica: requisitos de habilitación, obligaciones del personal de salud, derechos de los usuarios y procedimientos de supervisión sanitaria.',
    'https://www.diputados.gob.mx/LeyesBiblio/regley/Reg_LGS_MPSAM_170718.pdf'
  ),
  (
    'DE-REG-002',
    'Reglamento de la Ley General de Salud en Materia de Investigación para la Salud',
    'Establece los requisitos éticos y técnicos para la realización de investigación en seres humanos dentro del hospital. Aplica a estudios clínicos, ensayos y protocolos de investigación.',
    'https://www.diputados.gob.mx/LeyesBiblio/regley/Reg_LGS_MIS.pdf'
  ),
  (
    'DE-REG-003',
    'Reglamento de la Ley General de Salud en Materia de Control Sanitario de Productos y Utensilios',
    'Regula el control sanitario de medicamentos, materiales y equipos de uso hospitalario. Aplica en farmacia, almacén de insumos y central de equipos y esterilización.',
    'https://www.diputados.gob.mx/LeyesBiblio/regley/Reg_LGS_MCSPIUMC_120121.pdf'
  ),
  (
    'DE-REG-004',
    'Reglamento Federal de Seguridad y Salud en el Trabajo',
    'Reglamento derivado de la Ley Federal del Trabajo. Establece las obligaciones patronales en materia de seguridad e higiene: comisiones mixtas, programas de prevención, registros y capacitación. Aplica a todas las áreas del hospital.',
    'https://www.dof.gob.mx/nota_detalle.php?codigo=5344579&fecha=13/11/2014'
  )
) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  referencias        = EXCLUDED.referencias,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;


-- ════════════════════════════════════════════════════════════════════
--  BLOQUE 3 — NORMAS OFICIALES MEXICANAS  (DE-NOM)
--  Fuente: DOF / SSA / STPS / SEMARNAT
-- ════════════════════════════════════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  description, referencias
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  d.emisor,
  'Dra. Giselle De la Torre',
  'Responsable de Calidad',
  d.descripcion,
  jsonb_build_array(jsonb_build_object(
    'nombre', d.ref_nombre,
    'codigo', d.url
  ))
FROM (VALUES
  -- ── NOMs SSA ─────────────────────────────────────────────────────
  (
    'DE-NOM-001',
    'NOM-004-SSA3-2012 — Del Expediente Clínico',
    'Secretaría de Salud',
    'Establece los requisitos mínimos del expediente clínico en establecimientos de atención médica. Aplica a toda la documentación clínica del paciente: historia clínica, notas, consentimientos informados, estudios e indicaciones.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5272787&fecha=15/10/2012'
  ),
  (
    'DE-NOM-002',
    'NOM-006-SSA3-2011 — Para la Práctica de la Anestesiología',
    'Secretaría de Salud',
    'Establece los criterios mínimos para la práctica de la anestesiología: evaluación preanestésica, técnicas, monitorización y recuperación. Aplica en quirófano, sala de recuperación y procedimientos ambulatorios.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5237549&fecha=19/12/2011'
  ),
  (
    'DE-NOM-003',
    'NOM-007-SSA2-2016 — Para la Atención de la Mujer durante el Embarazo, Parto y Puerperio',
    'Secretaría de Salud',
    'Regula la atención obstétrica durante el embarazo, parto, puerperio y del recién nacido. Aplica en ginecología, obstetricia y sala de partos.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5432289&fecha=07/04/2016'
  ),
  (
    'DE-NOM-004',
    'NOM-016-SSA3-2012 — Infraestructura y Equipamiento de Hospitales',
    'Secretaría de Salud',
    'Establece los requisitos mínimos de infraestructura, equipamiento y organización de hospitales generales y de especialidad. Aplica en la gestión de instalaciones físicas y equipo biomédico.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5268224&fecha=08/10/2012'
  ),
  (
    'DE-NOM-005',
    'NOM-022-SSA3-2012 — Condiciones para la Administración de la Terapia de Infusión',
    'Secretaría de Salud',
    'Establece los criterios técnicos y de seguridad para la preparación, administración y control de la terapia de infusión intravenosa en hospitales. Aplica en enfermería, farmacia y UCI.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5268226&fecha=08/10/2012'
  ),
  (
    'DE-NOM-006',
    'NOM-024-SSA3-2012 — Sistemas de Información de Registro Electrónico para la Salud',
    'Secretaría de Salud',
    'Establece los requisitos mínimos para los sistemas electrónicos de información en salud, incluyendo expediente clínico electrónico. Aplica en los sistemas de información hospitalarios.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5268227&fecha=08/10/2012'
  ),
  (
    'DE-NOM-007',
    'NOM-045-SSA2-2005 — Para la Vigilancia Epidemiológica, Prevención y Control de las IAAS',
    'Secretaría de Salud',
    'Norma fundamental para la prevención y control de infecciones asociadas a la atención de la salud (IAAS). Establece el Comité de Detección y Control de las Infecciones Nosocomiales (CODECIAAS), indicadores y medidas de control.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=4928648&fecha=20/11/2009'
  ),
  (
    'DE-NOM-008',
    'NOM-087-SEMARNAT-SSA1-2002 — Residuos Peligrosos Biológico-Infecciosos (RPBI)',
    'SEMARNAT / Secretaría de Salud',
    'Regula la clasificación, manejo, envasado, almacenamiento, transporte y disposición final de los residuos peligrosos biológico-infecciosos generados en establecimientos de salud. Aplica en todas las áreas clínicas.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=718808&fecha=17/02/2003'
  ),
  (
    'DE-NOM-009',
    'NOM-166-SSA1-2015 — Para la Organización y Funcionamiento de los Laboratorios Clínicos',
    'Secretaría de Salud',
    'Establece los requisitos de organización, personal, instalaciones, equipamiento, procesos analíticos y control de calidad de los laboratorios clínicos. Aplica al Laboratorio Clínico del hospital.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5411329&fecha=25/09/2015'
  ),
  -- ── NOMs STPS ────────────────────────────────────────────────────
  (
    'DE-NOM-010',
    'NOM-017-STPS-2008 — Equipo de Protección Personal',
    'STPS',
    'Establece los requisitos para la selección, adquisición, uso, supervisión y mantenimiento del equipo de protección personal (EPP) en el centro de trabajo. Aplica en todas las áreas del hospital con riesgo de exposición.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5046037&fecha=04/11/2008'
  ),
  (
    'DE-NOM-011',
    'NOM-019-STPS-2011 — Comisiones de Seguridad e Higiene',
    'STPS',
    'Establece la constitución, integración, organización y funcionamiento de las Comisiones de Seguridad e Higiene (COSHT) en los centros de trabajo. Aplica en la gestión de seguridad ocupacional del hospital.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5211522&fecha=13/04/2011'
  ),
  (
    'DE-NOM-012',
    'NOM-025-STPS-2008 — Condiciones de Iluminación en los Centros de Trabajo',
    'STPS',
    'Establece los niveles mínimos de iluminación en las diferentes áreas de trabajo. Aplica en quirófanos, laboratorio, farmacia, pasillos y áreas administrativas del hospital.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5046034&fecha=30/12/2008'
  ),
  (
    'DE-NOM-013',
    'NOM-035-STPS-2018 — Factores de Riesgo Psicosocial en el Trabajo',
    'STPS',
    'Establece la identificación, análisis y prevención de los factores de riesgo psicosocial en el trabajo, incluyendo violencia laboral. Aplica a todo el personal del hospital, especialmente en áreas de alta carga emocional.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5541828&fecha=23/10/2018'
  ),
  (
    'DE-NOM-014',
    'NOM-036-1-STPS-2018 — Ergonomía: Identificación y Análisis de Factores de Riesgo',
    'STPS',
    'Establece las condiciones de seguridad ergonómica para la identificación y análisis de los factores de riesgo ergonómico en los centros de trabajo. Aplica en enfermería (movilización de pacientes), quirófano, farmacia y almacén.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5541831&fecha=23/10/2018'
  ),
  (
    'DE-NOM-015',
    'NOM-006-STPS-2014 — Manejo y Almacenamiento de Materiales',
    'STPS',
    'Establece las condiciones de seguridad para el manejo y almacenamiento manual y mecánico de materiales. Aplica en almacén general, farmacia, CEYE e intendencia del hospital.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5344580&fecha=13/11/2014'
  ),
  (
    'DE-NOM-016',
    'NOM-002-STPS-2010 — Prevención, Protección y Combate de Incendios',
    'STPS',
    'Establece las condiciones de seguridad para la prevención y combate de incendios en los centros de trabajo: extintores, señalización, rutas de evacuación y brigadas contra incendio.',
    'Diario Oficial de la Federación',
    'https://dof.gob.mx/nota_detalle.php?codigo=5155092&fecha=09/12/2010'
  )
) AS d(code, name, emisor, descripcion, ref_nombre, url)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  referencias        = EXCLUDED.referencias,
  status             = EXCLUDED.status,
  elaborated_by      = EXCLUDED.elaborated_by,
  custodian_position = EXCLUDED.custodian_position;


-- ════════════════════════════════════════════════════════════════════
--  BLOQUE 4 — GUÍAS DE PRÁCTICA CLÍNICA  (DE-GPC)
--  Fuente: CENETEC — www.cenetec-difusion.com
-- ════════════════════════════════════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  description, referencias
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'CENETEC — Centro Nacional de Excelencia Tecnológica en Salud',
  'Dra. Giselle De la Torre',
  'Responsable de Calidad',
  d.descripcion,
  jsonb_build_array(jsonb_build_object(
    'nombre', 'Catálogo de GPC — CENETEC',
    'codigo', 'https://www.cenetec-difusion.com/CMGPC/busqueda.action'
  ))
FROM (VALUES
  (
    'DE-GPC-001',
    'GPC — Prevención, Diagnóstico y Tratamiento de la Sepsis y Choque Séptico en el Adulto',
    'Guía de práctica clínica para el diagnóstico temprano, estratificación, reanimación y tratamiento antibiótico de la sepsis y choque séptico. Aplica en urgencias, UCI y hospitalización.'
  ),
  (
    'DE-GPC-002',
    'GPC — Profilaxis Antibiótica Perioperatoria en Cirugía Electiva',
    'Establece los criterios para la selección del antibiótico profiláctico, dosis, vía y tiempo de administración en cirugía. Aplica en quirófano y farmacia hospitalaria.'
  ),
  (
    'DE-GPC-003',
    'GPC — Prevención de Caídas en el Adulto Hospitalizado',
    'Guía para la identificación del riesgo de caídas (Escala de Morse), intervenciones preventivas y registro en el expediente clínico. Aplica en hospitalización y urgencias.'
  ),
  (
    'DE-GPC-004',
    'GPC — Diagnóstico y Tratamiento de la Neumonía Nosocomial en Adultos',
    'Criterios diagnósticos, tratamiento empírico y dirigido de la neumonía asociada a ventilación mecánica y hospitalaria. Aplica en UCI y hospitalización.'
  ),
  (
    'DE-GPC-005',
    'GPC — Prevención, Diagnóstico y Tratamiento de las Úlceras por Presión en el Adulto',
    'Clasificación, valoración del riesgo (Escala de Braden), medidas preventivas y tratamiento de las úlceras por presión. Aplica en hospitalización, UCI y enfermería.'
  ),
  (
    'DE-GPC-006',
    'GPC — Terapia Nutricional Enteral y Parenteral en el Adulto Hospitalizado',
    'Indicaciones, vías, fórmulas y monitoreo de la terapia nutricional especializada en el paciente crítico y hospitalizado. Aplica en nutrición clínica, UCI y hospitalización.'
  ),
  (
    'DE-GPC-007',
    'GPC — Atención del Parto Normal y Cesárea',
    'Criterios para la atención del parto eutócico y la cesárea, incluyendo manejo activo del tercer período y prevención de complicaciones. Aplica en ginecología y obstetricia.'
  ),
  (
    'DE-GPC-008',
    'GPC — Manejo del Paciente con Diabetes Mellitus en el Hospital',
    'Control glucémico, uso de insulina, monitoreo y manejo de hipo e hiperglucemia en el paciente hospitalizado con diabetes. Aplica en hospitalización, urgencias y UCI.'
  )
) AS d(code, name, descripcion)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  referencias        = EXCLUDED.referencias,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;


-- ── Verificación final ───────────────────────────────────────────────
SELECT
  d.code,
  SPLIT_PART(d.code, '-', 2) AS subtipo,
  d.name,
  d.status,
  (d.referencias->0->>'codigo') AS url_verificacion
FROM documents d
JOIN document_types dt ON dt.id = d.document_type_id
WHERE dt.code_prefix = 'DE'
  AND d.code NOT LIKE 'DE-LA-%'   -- excluir manuales de laboratorio
ORDER BY d.code;
