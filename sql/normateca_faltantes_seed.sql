-- ============================================================
-- docs_externos_normativos_seed_v2.sql
-- Inserción de documentos normativos FALTANTES
-- Hospital Santa Margarita SGC
-- Generado: 2026-06-02
-- ============================================================

-- ── LEYES ────────────────────────────────────────────────────

INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-LEY-007',
  'Ley Estatal de Salud',
  'Establece el marco jurídico local en materia de salud pública y organización de los servicios sanitarios en el estado, aplicable a las operaciones del hospital como establecimiento de atención médica.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Congreso del Estado', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  NULL
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- ── NOMs ─────────────────────────────────────────────────────

-- DE-NOM-017: NOM-001-ECOL-1996
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-017',
  'NOM-001-ECOL-1996 — Límites de Contaminantes en Descargas de Agua Residual',
  'Establece los límites máximos permisibles de contaminantes en descargas de aguas residuales a aguas y bienes nacionales, obligando al hospital a tratar sus efluentes antes de verterlos.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'SEMARNAT', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-001-ecol-1996'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-018: NOM-001-SEDE-2012
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-018',
  'NOM-001-SEDE-2012 — Instalaciones Eléctricas (Utilización)',
  'Regula las condiciones de seguridad para instalaciones eléctricas de utilización, aplicable a toda la infraestructura eléctrica del hospital para garantizar la seguridad del personal y pacientes.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'SEDE', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-001-sede-2012'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-019: NOM-001-SSA1-2020
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-019',
  'NOM-001-SSA1-2020 — Estructura de la Farmacopea de los EUM',
  'Instituye la estructura de la Farmacopea de los Estados Unidos Mexicanos y los procedimientos para su revisión y actualización, sirviendo de referencia obligatoria para el uso de medicamentos en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-001-ssa1-2020'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-020: NOM-001-SSA3-2012
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-020',
  'NOM-001-SSA3-2012 — Organización y Funcionamiento de Residencias Médicas',
  'Establece los criterios para la organización y funcionamiento de las residencias médicas, regulando la formación de especialistas en el hospital cuando funge como sede de posgrado.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-001-ssa3-2012'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-021: NOM-001-STPS-2008
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-021',
  'NOM-001-STPS-2008 — Condiciones de Seguridad en Edificios y Áreas de Trabajo',
  'Define las condiciones de seguridad que deben cumplir los edificios, locales e instalaciones del centro de trabajo, aplicable a todas las áreas físicas del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-001-stps-2008'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-022: NOM-002-ECOL-1996
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-022',
  'NOM-002-ECOL-1996 — Límites de Contaminantes en Descargas al Alcantarillado',
  'Establece los límites máximos permisibles de contaminantes en descargas de aguas residuales al alcantarillado urbano, obligando al hospital a controlar la calidad de sus vertidos.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'SEMARNAT', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-002-ecol-1996'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-023: NOM-003-SCT/2008
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-023',
  'NOM-003-SCT/2008 — Etiquetas para Transporte de Sustancias y Residuos Peligrosos',
  'Establece las características de las etiquetas para envases y embalajes de sustancias, materiales y residuos peligrosos, relevante para el transporte de residuos biológico-infecciosos generados por el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'SCT', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-003-sct/2008'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-024: NOM-003-SEGOB-2011
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-024',
  'NOM-003-SEGOB-2011 — Señales y Avisos para Protección Civil',
  'Define los colores, formas y símbolos de las señales y avisos para protección civil, exigiendo al hospital la correcta señalización de rutas de evacuación, zonas de riesgo y puntos de reunión.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'SEGOB', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-003-segob-2011'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-025: NOM-003-SSA3-2010
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-025',
  'NOM-003-SSA3-2010 — Práctica de la Hemodiálisis',
  'Establece los criterios y requisitos mínimos para la práctica de la hemodiálisis, aplicable a la unidad de diálisis del hospital para garantizar la calidad y seguridad del paciente renal.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-003-ssa3-2010'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-026: NOM-004-STPS-1999
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-026',
  'NOM-004-STPS-1999 — Sistemas de Protección en Maquinaria y Equipo',
  'Regula los sistemas de protección y dispositivos de seguridad en maquinaria y equipo de los centros de trabajo, aplicable a los equipos médicos y de mantenimiento del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-004-stps-1999'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-027: NOM-006-SSA2-2013
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-027',
  'NOM-006-SSA2-2013 — Prevención y Control de la Tuberculosis',
  'Establece los criterios para la prevención, diagnóstico y control de la tuberculosis, orientando los protocolos de detección, aislamiento y tratamiento en el servicio de infectología del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-006-ssa2-2013'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-028: NOM-006-STPS-2000
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-028',
  'NOM-006-STPS-2000 — Manejo y Almacenamiento de Materiales',
  'Establece las condiciones y procedimientos de seguridad para el manejo y almacenamiento de materiales en centros de trabajo, aplicable a almacenes, bodegas y zonas de carga del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-006-stps-2000'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-029: NOM-007-SSA2-1993
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-029',
  'NOM-007-SSA2-1993 — Atención de la Mujer en Embarazo, Parto y Puerperio',
  'Define los criterios y procedimientos para la atención de la mujer durante el embarazo, parto y puerperio y del recién nacido, siendo referencia del servicio de ginecología y obstetricia del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-007-ssa2-1993'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-030: NOM-008-SCFU-2002
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-030',
  'NOM-008-SCFU-2002 — Sistema General de Unidades de Medida',
  'Establece el Sistema General de Unidades de Medida (SI) de aplicación obligatoria en documentos y registros institucionales, incluyendo los expedientes clínicos y reportes de laboratorio del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Economía', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-008-scfu-2002'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-031: NOM-009-SSA2-1993
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-031',
  'NOM-009-SSA2-1993 — Promoción de la Salud Escolar',
  'Establece los criterios para la promoción de la salud en el ámbito escolar, referencia para los programas de salud preventiva y educación para la salud que el hospital extiende a la comunidad.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-009-ssa2-1993'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-032: NOM-010-SSA2-2010
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-032',
  'NOM-010-SSA2-2010 — Prevención y Control de la Infección por VIH',
  'Establece los criterios para la prevención, diagnóstico, tratamiento y control de la infección por VIH, normando los protocolos de detección, consejería y manejo clínico en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-010-ssa2-2010'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-033: NOM-011-STPS-2001
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-033',
  'NOM-011-STPS-2001 — Ruido en Centros de Trabajo',
  'Establece las condiciones de seguridad e higiene en los centros de trabajo donde se genera ruido, aplicable a áreas de equipamiento hospitalario como centrales de esterilización, lavandería y mantenimiento.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-011-stps-2001'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-034: NOM-012-SSA3
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-034',
  'NOM-012-SSA3-2012 — Investigación para la Salud en Seres Humanos',
  'Establece los criterios éticos y técnicos para la ejecución de proyectos de investigación en seres humanos, norma de referencia obligatoria para el comité de ética e investigación del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-012-ssa3'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-035: NOM-012-STPS-2012
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-035',
  'NOM-012-STPS-2012 — Seguridad ante Radiaciones Ionizantes en Centros de Trabajo',
  'Establece las condiciones de seguridad y salud en centros de trabajo donde se manejan fuentes de radiación ionizante, obligatoria para los servicios de radiodiagnóstico y radioterapia del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-012-stps-2012'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-036: NOM-014-SSA2-1994
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-036',
  'NOM-014-SSA2-1994 — Prevención, Detección y Control del Cáncer Cérvico-Uterino',
  'Establece los criterios para la prevención, detección y tratamiento del cáncer cérvico-uterino, normando los programas de tamizaje con citología y colposcopía en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-014-ssa2-1994'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-037: NOM-015-SSA3-2012
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-037',
  'NOM-015-SSA3-2012 — Atención Integral a Personas con Discapacidad',
  'Establece los criterios para la atención integral a personas con discapacidad en los servicios de salud, normando la accesibilidad, trato digno y adaptaciones necesarias en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-015-ssa3-2012'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-038: NOM-016-SSA2-1994
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-038',
  'NOM-016-SSA2-1994 — Vigilancia, Prevención y Control del Cólera',
  'Establece los criterios de vigilancia epidemiológica, prevención y tratamiento del cólera, referencia para los protocolos de aislamiento y manejo de enfermedades de notificación inmediata en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-016-ssa2-1994'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-039: NOM-016-SSA2-2012
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-039',
  'NOM-016-SSA2-2012 — Vigilancia, Prevención y Control del Cólera (Actualización)',
  'Actualiza los criterios de vigilancia, prevención y control del cólera, complementando los protocolos de enfermedades transmisibles del área de epidemiología hospitalaria.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-016-ssa2-2012'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-040: NOM-017-SSA2-2012
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-040',
  'NOM-017-SSA2-2012 — Vigilancia Epidemiológica',
  'Establece los criterios y procedimientos del Sistema Nacional de Vigilancia Epidemiológica, normando la notificación obligatoria de casos y brotes detectados en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-017-ssa2-2012'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-041: NOM-018-SSA1-1993
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-041',
  'NOM-018-SSA1-1993 — Especificaciones del Reactivo Anti-RH',
  'Establece las especificaciones sanitarias del reactivo Anti-RH para identificar el antígeno D, aplicable al banco de sangre y laboratorio clínico del hospital en la tipificación de grupos sanguíneos.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-018-ssa1-1993'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-042: NOM-018-STPS-2015
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-042',
  'NOM-018-STPS-2015 — Sistema Armonizado para Identificación de Sustancias Peligrosas',
  'Establece el sistema armonizado para la identificación y comunicación de peligros por sustancias químicas en los centros de trabajo, aplicable al manejo de reactivos, desinfectantes y medicamentos peligrosos en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-018-stps-2015'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-043: NOM-019-SSA1-1993
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-043',
  'NOM-019-SSA1-1993 — Especificaciones del Reactivo Antiglobulina Humana (Coombs)',
  'Establece las especificaciones sanitarias del reactivo antiglobulina humana para la prueba de Coombs, referencia de calidad para el banco de sangre y el laboratorio de compatibilidad del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-019-ssa1-1993'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-044: NOM-020-STPS-2011
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-044',
  'NOM-020-STPS-2011 — Recipientes Sujetos a Presión y Generadores de Vapor',
  'Establece las condiciones de seguridad para recipientes a presión, recipientes criogénicos y calderas, aplicable a los autoclaves, tanques de oxígeno y equipos de vapor del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-020-stps-2011'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-045: NOM-022-STPS-2015
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-045',
  'NOM-022-STPS-2015 — Electricidad Estática en Centros de Trabajo',
  'Establece las condiciones de seguridad para controlar la electricidad estática en centros de trabajo, relevante para áreas de quirófano, laboratorio y almacenamiento de gases médicos del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-022-stps-2015'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-046: NOM-025-SSA3-2013
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-046',
  'NOM-025-SSA3-2013 — Organización y Funcionamiento de Unidades de Cuidados Intensivos',
  'Establece los requisitos mínimos de organización, infraestructura y equipamiento para las unidades de cuidados intensivos, norma de cumplimiento obligatorio para la UCI del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://dof.gob.mx/nota_detalle.php%3Fcodigo%3D5314307%26fecha%3D17/09/2013'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-047: NOM-026-STPS-2008
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-047',
  'NOM-026-STPS-2008 — Colores y Señales de Seguridad e Higiene',
  'Establece los colores y señales de seguridad e higiene e identificación de riesgos en tuberías, exigiendo al hospital la correcta señalización de redes de gases medicinales y fluidos peligrosos.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-026-stps-2008'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-048: NOM-027-SSA2-1999
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-048',
  'NOM-027-SSA2-1999 — Prevención, Control y Eliminación de la Lepra',
  'Establece los criterios para la prevención, control y eliminación de la lepra, normando la detección temprana y referencia de casos en el servicio de dermatología del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-027-ssa2-1999'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-049: NOM-027-STPS-2008
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-049',
  'NOM-027-STPS-2008 — Actividades de Soldadura y Corte',
  'Establece las condiciones de seguridad e higiene para actividades de soldadura y corte en centros de trabajo, aplicable al área de mantenimiento y obra civil del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-027-stps-2008'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-050: NOM-028-SSA3-2012
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-050',
  'NOM-028-SSA3-2012 — Práctica de la Ultrasonografía Diagnóstica',
  'Regula la práctica de la ultrasonografía diagnóstica en los servicios de salud, estableciendo los estándares de calidad y competencia para el servicio de imagenología del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-028-ssa3-2012'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-051: NOM-029-SSA2-1999
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-051',
  'NOM-029-SSA2-1999 — Vigilancia y Control de la Leptospirosis',
  'Establece los criterios de vigilancia epidemiológica, prevención y control de la leptospirosis en humanos, normando el diagnóstico y reporte de casos en el servicio de medicina interna y urgencias del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-029-ssa2-1999'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-052: NOM-029-STPS-2011
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-052',
  'NOM-029-STPS-2011 — Mantenimiento de Instalaciones Eléctricas',
  'Establece las condiciones de seguridad para el mantenimiento de instalaciones eléctricas en centros de trabajo, normando los procedimientos del área de mantenimiento eléctrico del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-029-stps-2011'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-053: NOM-030-SSA2-1999
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-053',
  'NOM-030-SSA2-1999 — Prevención, Tratamiento y Control de la Hipertensión Arterial',
  'Establece los criterios para la prevención, tratamiento y control de la hipertensión arterial, normando los protocolos clínicos de manejo de este padecimiento en consulta externa y hospitalización.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-030-ssa2-1999'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-054: NOM-030-STPS-2009
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-054',
  'NOM-030-STPS-2009 — Servicios Preventivos de Seguridad y Salud en el Trabajo',
  'Define las funciones y actividades de los servicios preventivos de seguridad y salud en el trabajo, referencia para estructurar el programa de salud ocupacional y medicina del trabajo del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-030-stps-2009'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-055: NOM-031-SSA2-1999
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-055',
  'NOM-031-SSA2-1999 — Atención a la Salud del Niño',
  'Establece los criterios de atención integral a la salud del niño en los servicios de salud, normando los programas de vigilancia nutricional, vacunación y detección temprana en pediatría.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-031-ssa2-1999'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-056: NOM-031-STPS-2011
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-056',
  'NOM-031-STPS-2011 — Construcción: Condiciones de Seguridad y Salud en el Trabajo',
  'Establece las condiciones de seguridad y salud para trabajos de construcción, aplicable a obras de remodelación, ampliación y mantenimiento de infraestructura física del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'STPS', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-031-stps-2011'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-057: NOM-032-SSA2-2002
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-057',
  'NOM-032-SSA2-2002 — Vigilancia y Control de Enfermedades Transmitidas por Vector',
  'Establece los criterios de vigilancia epidemiológica, prevención y control de enfermedades transmitidas por vector, normando la detección y notificación de casos de dengue, paludismo y otras en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-032-ssa2-2002'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-058: NOM-033-SSA2-2011
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-058',
  'NOM-033-SSA2-2011 — Vigilancia y Control de la Intoxicación por Picadura de Alacrán',
  'Establece los criterios de vigilancia, prevención y atención de la intoxicación por picadura de alacrán, guiando el manejo de urgencias toxicológicas en el servicio de urgencias del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-033-ssa2-2011'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-059: NOM-034-SSA2-2002
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-059',
  'NOM-034-SSA2-2002 — Prevención y Control de los Defectos al Nacimiento',
  'Establece los criterios de prevención, detección y control de los defectos al nacimiento, normando los programas de tamiz neonatal y seguimiento de recién nacidos de riesgo en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-034-ssa2-2002'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-060: NOM-035-SSA2-2012
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-060',
  'NOM-035-SSA2-2012 — Prevención y Control de Enfermedades en la Perimenopausia',
  'Establece los criterios de prevención y control de enfermedades en la perimenopausia y postmenopausia de la mujer, normando los programas de salud de la mujer en el servicio de ginecología del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-035-ssa2-2012'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-061: NOM-035-SSA3-2012
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-061',
  'NOM-035-SSA3-2012 — Información en Salud',
  'Establece los criterios para la generación, integración y difusión de la información en salud, normando los sistemas de registro estadístico y reportes institucionales del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-035-ssa3-2012'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-062: NOM-036-SSA2-2012
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-062',
  'NOM-036-SSA2-2012 — Aplicación de Vacunas, Toxoides e Inmunoglobulinas',
  'Establece los criterios para la aplicación de vacunas, toxoides, faboterapéuticos e inmunoglobulinas en el humano, normando el programa de inmunizaciones y la cadena de frío del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-036-ssa2-2012'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-063: NOM-037-SSA2-2002
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-063',
  'NOM-037-SSA2-2002 — Prevención, Tratamiento y Control de las Dislipidemias',
  'Establece los criterios para la prevención, tratamiento y control de las dislipidemias, normando los protocolos de manejo del riesgo cardiovascular en medicina interna y cardiología del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-037-ssa2-2002'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-064: NOM-038-SSA2-2002
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-064',
  'NOM-038-SSA2-2002 — Prevención, Tratamiento y Control de Deficiencias de Yodo',
  'Establece los criterios para la prevención, tratamiento y control de las enfermedades por deficiencia de yodo, normando los programas de nutrición y suplementación en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-038-ssa2-2002'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-065: NOM-039-SSA2-2002
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-065',
  'NOM-039-SSA2-2002 — Prevención y Control de las Infecciones de Transmisión Sexual',
  'Establece los criterios para la prevención y control de las infecciones de transmisión sexual, normando los programas de detección, consejería y tratamiento en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-039-ssa2-2002'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-066: NOM-041-SSA2-2011
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-066',
  'NOM-041-SSA2-2011 — Prevención, Diagnóstico y Control del Cáncer de Mama',
  'Establece los criterios de prevención, diagnóstico, tratamiento y vigilancia del cáncer de mama, normando el programa de detección oportuna mediante mastografía y ultrasonido en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-041-ssa2-2011'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-067: NOM-046-SSA2-2005
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-067',
  'NOM-046-SSA2-2005 — Violencia Familiar, Sexual y Contra las Mujeres',
  'Establece los criterios para la prevención y atención de la violencia familiar, sexual y contra las mujeres, normando la detección, intervención y referencia de casos en todos los servicios del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-046-ssa2-2005'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-068: NOM-048-SSA2-2017
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-068',
  'NOM-048-SSA2-2017 — Detección y Control del Crecimiento Prostático y Cáncer de Próstata',
  'Establece los criterios para la prevención, detección y tratamiento del crecimiento prostático benigno y cáncer de próstata, normando los programas de tamizaje en urología del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-048-ssa2-2017'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-069: NOM-052-SEMARNAT-2005
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-069',
  'NOM-052-SEMARNAT-2005 — Clasificación e Identificación de Residuos Peligrosos',
  'Establece las características, el procedimiento de identificación y los listados de residuos peligrosos, complementando el manejo de residuos hospitalarios de manejo especial y peligrosos.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'SEMARNAT', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-052-semarnat-2005'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-070: NOM-056-SSA1-1993
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-070',
  'NOM-056-SSA1-1993 — Requisitos Sanitarios del Equipo de Protección Personal',
  'Establece los requisitos sanitarios del equipo de protección personal, complementando los estándares de selección, uso y mantenimiento del EPP en todas las áreas del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-056-ssa1-1993'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-071: NOM-059-SSA1-2006
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-071',
  'NOM-059-SSA1-2006 — Buenas Prácticas de Fabricación Químico-Farmacéutica',
  'Establece las buenas prácticas de fabricación para la industria químico-farmacéutica, referencia de calidad para la farmacia hospitalaria en la preparación de mezclas y medicamentos oncológicos.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-059-ssa1-2006'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-072: NOM-064-SSA1-1993
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-072',
  'NOM-064-SSA1-1993 — Especificaciones Sanitarias de Equipos de Reactivos para Diagnóstico',
  'Establece las especificaciones sanitarias de los equipos de reactivos utilizados para diagnóstico, garantizando la calidad y confiabilidad de los insumos del laboratorio clínico del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-064-ssa1-1993'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-073: NOM-065-SSA1-1993
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-073',
  'NOM-065-SSA1-1993 — Especificaciones Sanitarias de los Medios de Cultivo',
  'Establece las especificaciones sanitarias de los medios de cultivo microbiológico, aplicable al control de calidad de insumos en el laboratorio de microbiología y bacteriología del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-065-ssa1-1993'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-074: NOM-077-SSA1-1994
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-074',
  'NOM-077-SSA1-1994 — Especificaciones de Materiales de Control para Laboratorios de Patología Clínica',
  'Establece las especificaciones sanitarias de los materiales de control utilizados en laboratorios de patología clínica, aplicable al programa de control de calidad interno del laboratorio del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-077-ssa1-1994'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-075: NOM-078-SSA1-1994
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-075',
  'NOM-078-SSA1-1994 — Especificaciones de Estándares de Calibración para Laboratorios de Patología Clínica',
  'Establece las especificaciones sanitarias de los estándares de calibración para laboratorios de patología clínica, garantizando la trazabilidad metrológica de los resultados del laboratorio del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-078-ssa1-1994'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-076: NOM-092-SSA1-1994
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-076',
  'NOM-092-SSA1-1994 — Método para la Cuenta de Bacterias Aerobias en Placa',
  'Establece el método para la cuenta de bacterias aerobias en placa, técnica de referencia para el control microbiológico de superficies, equipos y productos en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-092-ssa1-1994'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-077: NOM-093-SSA1-1994
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-077',
  'NOM-093-SSA1-1994 — Prácticas de Higiene y Sanidad en la Preparación de Alimentos',
  'Establece las prácticas de higiene y sanidad en la preparación de alimentos en establecimientos fijos, aplicable al servicio de nutrición y cocina del hospital para garantizar la inocuidad alimentaria.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-093-ssa1-1994'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-078: NOM-112-SSA1-1994
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-078',
  'NOM-112-SSA1-1994 — Determinación de Bacterias Coliformes (NMP)',
  'Establece la técnica del Número Más Probable para la determinación de bacterias coliformes, método de referencia del laboratorio del hospital para el control microbiológico del agua y alimentos.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-112-ssa1-1994'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-079: NOM-127-SSA1-1994
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-079',
  'NOM-127-SSA1-1994 — Salud Ambiental: Agua para Uso y Consumo Humano',
  'Establece los límites permisibles de calidad del agua para uso y consumo humano, aplicable al monitoreo y control del agua potable suministrada en todas las instalaciones del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-127-ssa1-1994'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-080: NOM-174-SSA1-1998
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-080',
  'NOM-174-SSA1-1998 — Manejo Integral de la Obesidad',
  'Establece los criterios para el manejo integral de la obesidad, normando los programas de atención nutricional, intervención médica y seguimiento de pacientes con sobrepeso y obesidad en el hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-174-ssa1-1998'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-081: NOM-178-SSA1-1998
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-081',
  'NOM-178-SSA1-1998 — Infraestructura y Equipamiento para Atención Médica Ambulatoria',
  'Establece los requisitos mínimos de infraestructura y equipamiento para establecimientos de atención médica de pacientes ambulatorios, referencia para las consultas externas y clínicas satélite del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-178-ssa1-1998'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-082: NOM-179-SSA1-1998
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-082',
  'NOM-179-SSA1-1998 — Vigilancia y Control de Calidad del Agua de Abastecimiento Público',
  'Establece los criterios de vigilancia y evaluación del control de calidad del agua distribuida por sistemas de abastecimiento público, guiando el monitoreo del agua en las instalaciones del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-179-ssa1-1998'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-083: NOM-205-SSA1-2002
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-083',
  'NOM-205-SSA1-2002 — Práctica de la Cirugía Mayor Ambulatoria',
  'Establece los criterios y requisitos para la práctica de la cirugía mayor ambulatoria, normando el funcionamiento del área de cirugía de día y unidad de cirugía ambulatoria del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-205-ssa1-2002'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-084: NOM-206-SSA1-2002
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-084',
  'NOM-206-SSA1-2002 — Criterios de Funcionamiento y Atención en Servicios de Urgencias',
  'Establece los criterios de funcionamiento y atención en los servicios de urgencias, siendo norma de referencia central para la organización y operación del área de urgencias del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-206-ssa1-2002'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-085: NOM-209-SSA1-2002
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-085',
  'NOM-209-SSA1-2002 — Cirugía Oftalmológica con Láser Excimer',
  'Establece los criterios para la práctica de la cirugía oftalmológica con láser excimer, normando los requisitos de seguridad, competencia y equipamiento del servicio de oftalmología del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-209-ssa1-2002'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-086: NOM-229-SSA1-2002
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-086',
  'NOM-229-SSA1-2002 — Requisitos Técnicos para Instalaciones de Diagnóstico Médico con Rayos X',
  'Establece los requisitos técnicos para las instalaciones de diagnóstico médico con rayos X, aplicable al diseño, blindaje y operación del servicio de radiología e imagen del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-229-ssa1-2002'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-087: NOM-233-SSA1-2003
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-087',
  'NOM-233-SSA1-2003 — Requisitos Arquitectónicos de Acceso para Personas con Discapacidad',
  'Establece los requisitos arquitectónicos para facilitar el acceso de personas con discapacidad a los establecimientos de atención médica, exigiendo al hospital la adecuación de rampas, pasillos y sanitarios.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-233-ssa1-2003'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-088: NOM-234-SSA1-2003
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-088',
  'NOM-234-SSA1-2003 — Utilización de Campos Clínicos para Ciclos Clínicos e Internado',
  'Establece los criterios para la utilización de campos clínicos para la formación de estudiantes de medicina, normando el rol del hospital como sede de enseñanza clínica de pregrado.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-234-ssa1-2003'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-089: NOM-237-SSA1-2004
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-089',
  'NOM-237-SSA1-2004 — Atención Prehospitalaria de Urgencias Médicas',
  'Regula la atención prehospitalaria de urgencias médicas, estableciendo los estándares para la recepción, triaje y continuidad del cuidado de pacientes trasladados al hospital por servicios de emergencias.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-237-ssa1-2004'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-090: NOM-251-SSA1-2009
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-090',
  'NOM-251-SSA1-2009 — Prácticas de Higiene para el Proceso de Alimentos y Suplementos',
  'Establece las prácticas de higiene para el proceso de alimentos, bebidas y suplementos alimenticios, aplicable al servicio de dietética y nutrición del hospital para asegurar la inocuidad de las dietas hospitalarias.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-251-ssa1-2009'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-091: NOM-253-SSA1-2012
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-091',
  'NOM-253-SSA1-2012 — Disposición de Sangre Humana y sus Componentes con Fines Terapéuticos',
  'Establece los criterios para la disposición de sangre humana y sus componentes con fines terapéuticos, norma central para el banco de sangre y el programa de transfusiones del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-253-ssa1-2012'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- DE-NOM-092: NOM-CCA-029
INSERT INTO documents (
  code, name, description,
  document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  source_url
) VALUES (
  'DE-NOM-092',
  'NOM-CCA-029-ECOL/1993 — Límites de Contaminantes en Descargas de Aguas Residuales de Hospitales',
  'Establece los límites máximos permisibles de contaminantes en las descargas de aguas residuales a cuerpos receptores provenientes de hospitales, de aplicación directa y prioritaria al sistema de tratamiento de aguas residuales del hospital.',
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'SEMARNAT', 'Dra. Giselle De la Torre', 'Responsable de Calidad',
  'https://platiica.economia.gob.mx/normalizacion/nom-cca-029'
) ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  source_url         = EXCLUDED.source_url,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- ── LEYES FALTANTES (NOM-006-SSA2-2011 already loaded as DE-NOM-002; NOM-166-SSA1-2015 already loaded as DE-NOM-009) ──

-- ── VERIFICACIÓN ─────────────────────────────────────────────

SELECT
  COUNT(*) AS total_nuevos_registros,
  MIN(code)  AS primer_codigo,
  MAX(code)  AS ultimo_codigo
FROM documents
WHERE code IN (
  'DE-LEY-007',
  'DE-NOM-017','DE-NOM-018','DE-NOM-019','DE-NOM-020','DE-NOM-021',
  'DE-NOM-022','DE-NOM-023','DE-NOM-024','DE-NOM-025','DE-NOM-026',
  'DE-NOM-027','DE-NOM-028','DE-NOM-029','DE-NOM-030','DE-NOM-031',
  'DE-NOM-032','DE-NOM-033','DE-NOM-034','DE-NOM-035','DE-NOM-036',
  'DE-NOM-037','DE-NOM-038','DE-NOM-039','DE-NOM-040','DE-NOM-041',
  'DE-NOM-042','DE-NOM-043','DE-NOM-044','DE-NOM-045','DE-NOM-046',
  'DE-NOM-047','DE-NOM-048','DE-NOM-049','DE-NOM-050','DE-NOM-051',
  'DE-NOM-052','DE-NOM-053','DE-NOM-054','DE-NOM-055','DE-NOM-056',
  'DE-NOM-057','DE-NOM-058','DE-NOM-059','DE-NOM-060','DE-NOM-061',
  'DE-NOM-062','DE-NOM-063','DE-NOM-064','DE-NOM-065','DE-NOM-066',
  'DE-NOM-067','DE-NOM-068','DE-NOM-069','DE-NOM-070','DE-NOM-071',
  'DE-NOM-072','DE-NOM-073','DE-NOM-074','DE-NOM-075','DE-NOM-076',
  'DE-NOM-077','DE-NOM-078','DE-NOM-079','DE-NOM-080','DE-NOM-081',
  'DE-NOM-082','DE-NOM-083','DE-NOM-084','DE-NOM-085','DE-NOM-086',
  'DE-NOM-087','DE-NOM-088','DE-NOM-089','DE-NOM-090','DE-NOM-091',
  'DE-NOM-092'
);

SELECT
  code,
  name,
  status,
  elaborated_by,
  source_url
FROM documents
WHERE code IN (
  'DE-LEY-007',
  'DE-NOM-017','DE-NOM-018','DE-NOM-019','DE-NOM-020','DE-NOM-021',
  'DE-NOM-022','DE-NOM-023','DE-NOM-024','DE-NOM-025','DE-NOM-026',
  'DE-NOM-027','DE-NOM-028','DE-NOM-029','DE-NOM-030','DE-NOM-031',
  'DE-NOM-032','DE-NOM-033','DE-NOM-034','DE-NOM-035','DE-NOM-036',
  'DE-NOM-037','DE-NOM-038','DE-NOM-039','DE-NOM-040','DE-NOM-041',
  'DE-NOM-042','DE-NOM-043','DE-NOM-044','DE-NOM-045','DE-NOM-046',
  'DE-NOM-047','DE-NOM-048','DE-NOM-049','DE-NOM-050','DE-NOM-051',
  'DE-NOM-052','DE-NOM-053','DE-NOM-054','DE-NOM-055','DE-NOM-056',
  'DE-NOM-057','DE-NOM-058','DE-NOM-059','DE-NOM-060','DE-NOM-061',
  'DE-NOM-062','DE-NOM-063','DE-NOM-064','DE-NOM-065','DE-NOM-066',
  'DE-NOM-067','DE-NOM-068','DE-NOM-069','DE-NOM-070','DE-NOM-071',
  'DE-NOM-072','DE-NOM-073','DE-NOM-074','DE-NOM-075','DE-NOM-076',
  'DE-NOM-077','DE-NOM-078','DE-NOM-079','DE-NOM-080','DE-NOM-081',
  'DE-NOM-082','DE-NOM-083','DE-NOM-084','DE-NOM-085','DE-NOM-086',
  'DE-NOM-087','DE-NOM-088','DE-NOM-089','DE-NOM-090','DE-NOM-091',
  'DE-NOM-092'
)
ORDER BY code;