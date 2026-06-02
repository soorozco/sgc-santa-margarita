-- ══════════════════════════════════════════════════════════════════════
--  Documentos Externos Normativos — Hospital Santa Margarita
--  SGC ISO 9001:2015 · Cláusula §7.5.3 — Control de documentos externos
--
--  PASO 1: Agrega columna source_url a documents (idempotente)
--  PASO 2: Inserta los documentos externos (leyes, reglamentos, NOMs, GPC)
--
--  Sub-clasificación por tipo en el código:
--    DE-LEY-XXX  → Leyes federales
--    DE-REG-XXX  → Reglamentos
--    DE-NOM-XXX  → Normas Oficiales Mexicanas
--    DE-GPC-XXX  → Guías de Práctica Clínica
--
--  URLs de leyes y reglamentos verificadas HTTP 200 en diputados.gob.mx
-- ══════════════════════════════════════════════════════════════════════

-- ── PASO 1: Columna source_url ───────────────────────────────────────
ALTER TABLE public.documents
  ADD COLUMN IF NOT EXISTS source_url TEXT;

-- ── Asegurar tipo DE ─────────────────────────────────────────────────
INSERT INTO document_types (code_prefix, name, description)
VALUES (
  'DE', 'Documento Externo',
  'Documentos de procedencia externa requeridos para el SGC: leyes, reglamentos, normas, guías de práctica clínica y manuales de fabricante.'
)
ON CONFLICT (code_prefix) DO NOTHING;


-- ════════════════════════════════════════════════════════════════════
--  BLOQUE 1 — LEYES FEDERALES  (DE-LEY)
--  URLs verificadas HTTP 200 — diputados.gob.mx
-- ════════════════════════════════════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Congreso de la Unión',
  'Dra. Giselle De la Torre',
  'Responsable de Calidad',
  d.descripcion,
  d.url
FROM (VALUES
  (
    'DE-LEY-001', 'Ley General de Salud',
    'Marco normativo general de los servicios de salud en México. Base legal de los establecimientos de atención médica, los derechos de los usuarios y las obligaciones sanitarias. Aplica a toda la operación hospitalaria.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LGS.pdf'
  ),
  (
    'DE-LEY-002', 'Ley Federal del Trabajo',
    'Regula las relaciones laborales entre el hospital y sus colaboradores. Aplica en contratación, jornadas, seguridad, riesgos de trabajo, derechos y obligaciones del personal.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LFT.pdf'
  ),
  (
    'DE-LEY-003', 'Ley Federal de Protección al Consumidor',
    'Establece los derechos de los pacientes como consumidores de servicios médicos. Aplica en transparencia de precios, información de servicios, contratos de adhesión y resolución de quejas.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LFPC.pdf'
  ),
  (
    'DE-LEY-004', 'Ley Federal de Protección de Datos Personales en Posesión de Particulares',
    'Regula el tratamiento de datos personales y sensibles (datos clínicos, diagnósticos, expediente médico) de pacientes y colaboradores. Obliga a aviso de privacidad, consentimiento informado y medidas de seguridad.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LFPDPPP.pdf'
  ),
  (
    'DE-LEY-005', 'Ley General del Equilibrio Ecológico y la Protección al Ambiente',
    'Marco legal ambiental aplicable al manejo de residuos peligrosos biológico-infecciosos (RPBI), emisiones y sustancias peligrosas. Complementa la NOM-087-SEMARNAT.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LGEEPA.pdf'
  ),
  (
    'DE-LEY-006', 'Ley General para la Inclusión de las Personas con Discapacidad',
    'Establece los derechos de las personas con discapacidad a la atención médica accesible. Aplica en accesibilidad de instalaciones, trato digno y no discriminación en la atención hospitalaria.',
    'https://www.diputados.gob.mx/LeyesBiblio/pdf/LGIPD.pdf'
  )
) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;


-- ════════════════════════════════════════════════════════════════════
--  BLOQUE 2 — REGLAMENTOS  (DE-REG)
--  URLs verificadas HTTP 200 — diputados.gob.mx
-- ════════════════════════════════════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  description, source_url
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
  d.url
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
    'Establece las obligaciones patronales en materia de seguridad e higiene: comisiones mixtas, programas de prevención, registros y capacitación. Aplica a todas las áreas del hospital.',
    'https://dof.gob.mx/nota_detalle.php?codigo=5344579&fecha=13/11/2014'
  )
) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;


-- ════════════════════════════════════════════════════════════════════
--  BLOQUE 3 — NORMAS OFICIALES MEXICANAS  (DE-NOM)
-- ════════════════════════════════════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  description, source_url
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
  d.url
FROM (VALUES
  ('DE-NOM-001', 'NOM-004-SSA3-2012 — Del Expediente Clínico', 'Secretaría de Salud',
   'Establece los requisitos mínimos del expediente clínico: historia clínica, notas, consentimientos, estudios e indicaciones. Aplica a toda la documentación clínica del paciente.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5272787&fecha=15/10/2012'),
  ('DE-NOM-002', 'NOM-006-SSA3-2011 — Para la Práctica de la Anestesiología', 'Secretaría de Salud',
   'Establece criterios para la práctica de la anestesiología: evaluación preanestésica, técnicas, monitorización y recuperación. Aplica en quirófano y sala de recuperación.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5237549&fecha=19/12/2011'),
  ('DE-NOM-003', 'NOM-007-SSA2-2016 — Atención del Embarazo, Parto y Puerperio', 'Secretaría de Salud',
   'Regula la atención obstétrica durante el embarazo, parto, puerperio y del recién nacido. Aplica en ginecología, obstetricia y sala de partos.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5432289&fecha=07/04/2016'),
  ('DE-NOM-004', 'NOM-016-SSA3-2012 — Infraestructura y Equipamiento de Hospitales', 'Secretaría de Salud',
   'Establece requisitos mínimos de infraestructura, equipamiento y organización de hospitales. Aplica en gestión de instalaciones físicas y equipo biomédico.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5268224&fecha=08/10/2012'),
  ('DE-NOM-005', 'NOM-022-SSA3-2012 — Condiciones para la Terapia de Infusión', 'Secretaría de Salud',
   'Criterios técnicos y de seguridad para la preparación, administración y control de la terapia IV en hospitales. Aplica en enfermería, farmacia y UCI.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5268226&fecha=08/10/2012'),
  ('DE-NOM-006', 'NOM-024-SSA3-2012 — Sistemas de Información de Registro Electrónico para la Salud', 'Secretaría de Salud',
   'Establece requisitos para los sistemas electrónicos de información en salud, incluyendo expediente clínico electrónico.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5268227&fecha=08/10/2012'),
  ('DE-NOM-007', 'NOM-045-SSA2-2005 — Vigilancia, Prevención y Control de las IAAS', 'Secretaría de Salud',
   'Norma fundamental para la prevención de infecciones asociadas a la atención de la salud. Establece el CODECIAAS, indicadores y medidas de control.',
   'https://dof.gob.mx/nota_detalle.php?codigo=4928648&fecha=20/11/2009'),
  ('DE-NOM-008', 'NOM-087-SEMARNAT-SSA1-2002 — Residuos Peligrosos Biológico-Infecciosos (RPBI)', 'SEMARNAT / SSA',
   'Regula la clasificación, manejo, envasado, almacenamiento, transporte y disposición final de RPBI generados en establecimientos de salud. Aplica en todas las áreas clínicas.',
   'https://dof.gob.mx/nota_detalle.php?codigo=718808&fecha=17/02/2003'),
  ('DE-NOM-009', 'NOM-166-SSA1-2015 — Organización y Funcionamiento de Laboratorios Clínicos', 'Secretaría de Salud',
   'Establece requisitos de organización, personal, equipamiento, procesos analíticos y control de calidad de laboratorios clínicos.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5411329&fecha=25/09/2015'),
  ('DE-NOM-010', 'NOM-017-STPS-2008 — Equipo de Protección Personal', 'STPS',
   'Establece requisitos para la selección, uso y mantenimiento del EPP. Aplica en todas las áreas del hospital con riesgo de exposición.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5046037&fecha=04/11/2008'),
  ('DE-NOM-011', 'NOM-019-STPS-2011 — Comisiones de Seguridad e Higiene (COSHT)', 'STPS',
   'Establece la constitución, integración, organización y funcionamiento de las COSHT en los centros de trabajo.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5211522&fecha=13/04/2011'),
  ('DE-NOM-012', 'NOM-025-STPS-2008 — Condiciones de Iluminación en Centros de Trabajo', 'STPS',
   'Establece niveles mínimos de iluminación en las diferentes áreas de trabajo. Aplica en quirófanos, laboratorio, farmacia y áreas administrativas.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5046034&fecha=30/12/2008'),
  ('DE-NOM-013', 'NOM-035-STPS-2018 — Factores de Riesgo Psicosocial en el Trabajo', 'STPS',
   'Establece la identificación, análisis y prevención de factores de riesgo psicosocial. Aplica a todo el personal, especialmente en áreas de alta carga emocional.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5541828&fecha=23/10/2018'),
  ('DE-NOM-014', 'NOM-036-1-STPS-2018 — Ergonomía: Identificación y Análisis de Factores de Riesgo', 'STPS',
   'Establece las condiciones ergonómicas de seguridad. Aplica en enfermería (movilización de pacientes), quirófano, farmacia y almacén.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5541831&fecha=23/10/2018'),
  ('DE-NOM-015', 'NOM-006-STPS-2014 — Manejo y Almacenamiento de Materiales', 'STPS',
   'Condiciones de seguridad para el manejo y almacenamiento manual y mecánico de materiales. Aplica en almacén, farmacia, CEYE e intendencia.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5344580&fecha=13/11/2014'),
  ('DE-NOM-016', 'NOM-002-STPS-2010 — Prevención, Protección y Combate de Incendios', 'STPS',
   'Condiciones de seguridad para prevención y combate de incendios: extintores, señalización, rutas de evacuación y brigadas.',
   'https://dof.gob.mx/nota_detalle.php?codigo=5155092&fecha=09/12/2010')
) AS d(code, name, emisor, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  elaborated_by      = EXCLUDED.elaborated_by,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;


-- ════════════════════════════════════════════════════════════════════
--  BLOQUE 4 — GUÍAS DE PRÁCTICA CLÍNICA  (DE-GPC)
--  Fuente: CENETEC
-- ════════════════════════════════════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  description, source_url
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
  'https://www.cenetec-difusion.com/CMGPC/busqueda.action'
FROM (VALUES
  ('DE-GPC-001', 'GPC — Prevención, Diagnóstico y Tratamiento de la Sepsis y Choque Séptico en el Adulto',
   'Diagnóstico temprano, estratificación, reanimación y tratamiento antibiótico de la sepsis. Aplica en urgencias, UCI y hospitalización.'),
  ('DE-GPC-002', 'GPC — Profilaxis Antibiótica Perioperatoria en Cirugía Electiva',
   'Criterios para la selección del antibiótico profiláctico, dosis, vía y tiempo de administración en cirugía. Aplica en quirófano y farmacia.'),
  ('DE-GPC-003', 'GPC — Prevención de Caídas en el Adulto Hospitalizado',
   'Identificación del riesgo de caídas (Escala de Morse), intervenciones preventivas y registro. Aplica en hospitalización y urgencias.'),
  ('DE-GPC-004', 'GPC — Diagnóstico y Tratamiento de la Neumonía Nosocomial en Adultos',
   'Criterios diagnósticos, tratamiento empírico y dirigido de la neumonía asociada a ventilación mecánica. Aplica en UCI y hospitalización.'),
  ('DE-GPC-005', 'GPC — Prevención, Diagnóstico y Tratamiento de las Úlceras por Presión',
   'Clasificación, valoración del riesgo (Braden), medidas preventivas y tratamiento de úlceras por presión. Aplica en hospitalización y UCI.'),
  ('DE-GPC-006', 'GPC — Terapia Nutricional Enteral y Parenteral en el Adulto Hospitalizado',
   'Indicaciones, vías, fórmulas y monitoreo de terapia nutricional en el paciente crítico. Aplica en nutrición clínica, UCI y hospitalización.'),
  ('DE-GPC-007', 'GPC — Atención del Parto Normal y Cesárea',
   'Criterios para la atención del parto eutócico y la cesárea, manejo activo del tercer período. Aplica en ginecología y obstetricia.'),
  ('DE-GPC-008', 'GPC — Manejo del Paciente con Diabetes Mellitus en el Hospital',
   'Control glucémico, uso de insulina, monitoreo y manejo de hipo e hiperglucemia en el paciente hospitalizado con diabetes.')
) AS d(code, name, descripcion)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;


-- ── Verificación ─────────────────────────────────────────────────────
SELECT
  d.code,
  SPLIT_PART(d.code, '-', 2) AS subtipo,
  LEFT(d.name, 55)           AS nombre,
  d.status,
  LEFT(d.source_url, 60)     AS url
FROM public.documents d
JOIN document_types dt ON dt.id = d.document_type_id
WHERE dt.code_prefix = 'DE'
  AND d.code NOT LIKE 'DE-LA-%'
ORDER BY d.code;
