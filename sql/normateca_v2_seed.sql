-- ══════════════════════════════════════════════════════════════════
-- Normateca v2 — Documentos Externos Adicionales
-- Hospital Santa Margarita · SGC ISO 9001:2015 · Cláusula §7.5.3
--
-- PREREQUISITO: Ejecutar add_verification_columns.sql primero.
--
-- Contenido (solo documentos que NO existen ya en el sistema):
--   BLOQUE 1 → DE-LEY-008..019  (12 leyes)
--   BLOQUE 2 → DE-REG-005..010  (6 reglamentos)
--   BLOQUE 3 → DE-NOM-093..113  (21 NOMs — SSA3, SSA2, SSA1, STPS, Amb)
--   BLOQUE 4 → DE-GPC-009..039  (31 Guías de Práctica Clínica)
--   BLOQUE 5 → DE-CSG-001..011  (11 normas/estándares de referencia SGC)
--
-- Documentos ya existentes (OMITIDOS):
--   DE-LEY-001..007, DE-REG-001..004, DE-NOM-001..092, DE-GPC-001..008
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════


-- ════════════════════════════════════════════════════════════════
-- BLOQUE 1 — LEYES FEDERALES Y ESTATALES (nuevas)
-- DE-LEY-008 → DE-LEY-019
-- ════════════════════════════════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Congreso de la Unión / Congreso del Estado de Jalisco',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-LEY-008',
   'Constitución Política de los Estados Unidos Mexicanos — Artículo 4°',
   'Establece el derecho a la protección de la salud como garantía constitucional. El Estado proveerá los medios para el acceso a los servicios de salud y sanidad que satisfagan las necesidades de la población, en los términos que establezca la ley.',
   'https://www.diputados.gob.mx/LeyesBiblio/pdf/CPEUM.pdf'),

  ('DE-LEY-009',
   'Ley del Seguro Social (LSS)',
   'Regula el régimen de seguridad social del IMSS, incluyendo prestaciones médicas, hospitalarias y farmacéuticas. Establece las obligaciones patronales y los derechos de los asegurados para recibir atención médica en establecimientos del sector.',
   'https://www.diputados.gob.mx/LeyesBiblio/pdf/LSS.pdf'),

  ('DE-LEY-010',
   'Ley del Instituto del Fondo Nacional de la Vivienda para los Trabajadores (LINFONAVIT)',
   'Regula las relaciones laborales y prestaciones del INFONAVIT. Incluye disposiciones sobre créditos de vivienda, aportaciones patronales y derechos de los trabajadores que pueden afectar la gestión de recursos humanos del hospital.',
   'https://www.diputados.gob.mx/LeyesBiblio/pdf/LINFONAVIT.pdf'),

  ('DE-LEY-011',
   'Ley de Infraestructura de la Calidad (LIC)',
   'Regula la infraestructura de la calidad en México, incluyendo la normalización, acreditación, evaluación de la conformidad, metrología y los organismos que las desarrollan. Reemplaza a la Ley Federal sobre Metrología y Normalización.',
   'https://www.diputados.gob.mx/LeyesBiblio/pdf/LIC.pdf'),

  ('DE-LEY-012',
   'Ley General de Protección Civil (LGPC)',
   'Establece el Sistema Nacional de Protección Civil y las bases para la coordinación de acciones en materia de protección civil, prevención, mitigación, preparación, respuesta, recuperación y reconstrucción ante situaciones de emergencia o desastre.',
   'https://www.diputados.gob.mx/LeyesBiblio/pdf/LGPC.pdf'),

  ('DE-LEY-013',
   'Ley de Protección Civil del Estado de Jalisco',
   'Regula las acciones de protección civil en el estado de Jalisco. Establece el Sistema Estatal de Protección Civil y las obligaciones de los establecimientos, incluyendo hospitales, para la prevención y atención de emergencias.',
   NULL),

  ('DE-LEY-014',
   'Ley General para el Control del Tabaco',
   'Establece las bases para la protección de la salud de la población del consumo y la exposición al humo del tabaco. Prohíbe el consumo en establecimientos de salud y regula la venta, distribución y publicidad de productos de tabaco.',
   'https://www.diputados.gob.mx/LeyesBiblio/pdf/LGCT.pdf'),

  ('DE-LEY-015',
   'Ley General de los Derechos de Niñas, Niños y Adolescentes (LGDNNA)',
   'Reconoce los derechos de niñas, niños y adolescentes y establece las garantías para su protección, incluyendo el derecho a la salud. Establece las obligaciones de los establecimientos de salud en la atención pediátrica y la notificación de maltrato.',
   'https://www.diputados.gob.mx/LeyesBiblio/pdf/LGDNNA.pdf'),

  ('DE-LEY-016',
   'Ley General de Acceso de las Mujeres a una Vida Libre de Violencia (LGAMVLV)',
   'Establece la coordinación entre la Federación, las entidades federativas, el Distrito Federal y los municipios para prevenir, sancionar y erradicar la violencia contra las mujeres. Incluye protocolos de atención en unidades médicas.',
   'https://www.diputados.gob.mx/LeyesBiblio/pdf/LGAMVLV.pdf'),

  ('DE-LEY-017',
   'Ley General de Víctimas (LGV)',
   'Reconoce los derechos de las víctimas del delito y de violaciones a derechos humanos. Establece el acceso a servicios de salud y atención médica integral. Obliga a los establecimientos de salud a brindar atención de emergencia sin discriminación.',
   'https://www.diputados.gob.mx/LeyesBiblio/pdf/LGV.pdf'),

  ('DE-LEY-018',
   'Ley de Voluntad Anticipada del Estado de Jalisco',
   'Regula el documento de voluntad anticipada (testamento vital) para que las personas puedan expresar su voluntad de manera anticipada sobre los cuidados y tratamientos médicos que desean o no recibir en situaciones de enfermedad terminal o estado vegetativo persistente.',
   NULL),

  ('DE-LEY-019',
   'Código Penal Federal (CPF) — Delitos contra la salud y responsabilidad médica',
   'Establece las disposiciones penales aplicables a conductas relacionadas con la prestación de servicios de salud, incluyendo el ejercicio ilegal de la medicina, negligencia médica, y delitos contra la salud. Referencia para el personal del hospital.',
   'https://www.diputados.gob.mx/LeyesBiblio/pdf/CPF.pdf')

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  description       = EXCLUDED.description,
  source_url        = EXCLUDED.source_url,
  updated_at        = now();


-- ════════════════════════════════════════════════════════════════
-- BLOQUE 2 — REGLAMENTOS (nuevos)
-- DE-REG-005 → DE-REG-010
-- ════════════════════════════════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Poder Ejecutivo Federal / COFEPRIS',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-REG-005',
   'Reglamento de Insumos para la Salud',
   'Regula los procesos de fabricación, control de calidad, importación, exportación, publicidad, comercio, distribución, almacenamiento, prescripción y uso de insumos para la salud: medicamentos, dispositivos médicos y plaguicidas de uso en salud pública.',
   'https://www.dof.gob.mx/nota_detalle.php?codigo=762923&fecha=04/02/1998'),

  ('DE-REG-006',
   'Reglamento de la Ley General de Salud en Materia de Trasplantes',
   'Regula los requisitos, condiciones y procedimientos para la disposición de órganos, tejidos y células de seres humanos con fines terapéuticos. Establece los derechos de donantes y receptores y las obligaciones de los establecimientos participantes.',
   NULL),

  ('DE-REG-007',
   'Reglamento de la Ley General de Salud en Materia de Publicidad',
   'Regula la publicidad relacionada con medicamentos, equipos médicos, procedimientos médicos y servicios de salud. Establece las condiciones para la publicidad de establecimientos de salud, su contenido permitido y las sanciones por incumplimiento.',
   NULL),

  ('DE-REG-008',
   'Reglamento Interior de la Comisión Federal para la Protección contra Riesgos Sanitarios (COFEPRIS)',
   'Establece la organización y funcionamiento de la COFEPRIS como órgano desconcentrado de la SSA. Regula las atribuciones de las distintas unidades administrativas y los procedimientos de autorización y vigilancia sanitaria aplicables a establecimientos de salud.',
   NULL),

  ('DE-REG-009',
   'Reglamento de la Ley General de Salud en Materia de Control Sanitario de la Disposición de Órganos, Tejidos y Cadáveres de Seres Humanos',
   'Establece las disposiciones para el control sanitario de la obtención, análisis, conservación, preparación, suministro, utilización y destino final de órganos, tejidos y cadáveres humanos en establecimientos de salud.',
   NULL),

  ('DE-REG-010',
   'Reglamento Interior del Hospital — Normas y Reglamentos Municipales de Guadalajara',
   'Normas administrativas y reglamentos del Ayuntamiento de Guadalajara aplicables al funcionamiento del hospital, incluyendo uso de suelo, construcción, protección civil municipal, manejo de residuos y otras disposiciones de carácter local.',
   NULL)

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  description       = EXCLUDED.description,
  source_url        = EXCLUDED.source_url,
  updated_at        = now();


-- ════════════════════════════════════════════════════════════════
-- BLOQUE 3 — NORMAS OFICIALES MEXICANAS (nuevas)
-- DE-NOM-093 → DE-NOM-113
-- ════════════════════════════════════════════════════════════════

-- ── SSA3: Regulación de Servicios de Salud ──────────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud (SSA)',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-NOM-093',
   'NOM-005-SSA3-2018 — Infraestructura y equipamiento de establecimientos de salud de atención ambulatoria',
   'Establece las especificaciones de infraestructura, equipamiento y condiciones sanitarias requeridas para los establecimientos para la atención médica ambulatoria. Define los estándares mínimos por servicio y nivel de atención.',
   'https://www.dof.gob.mx/nota_detalle.php?codigo=5564460&fecha=06/09/2018'),

  ('DE-NOM-094',
   'NOM-007-SSA3-2011 — Criterios para la atención médica de la mujer durante el embarazo, parto y puerperio, y del recién nacido',
   'Establece los criterios, actividades, procedimientos y recomendaciones para la atención prenatal, obstétrica y neonatal. Define los estándares para la atención del embarazo normal, parto y puerperio en establecimientos del Sistema Nacional de Salud.',
   NULL),

  ('DE-NOM-095',
   'NOM-019-SSA3-2013 — Criterios para la práctica de enfermería en el Sistema Nacional de Salud',
   'Establece las disposiciones que deben observarse para el ejercicio de la práctica de enfermería en el Sistema Nacional de Salud, incluyendo los criterios éticos, técnicos y administrativos para el cuidado de enfermería en todos los niveles de atención.',
   NULL),

  ('DE-NOM-096',
   'NOM-026-SSA3-2012 — Regulación de los Servicios de Salud. Que establece los criterios de funcionamiento para la práctica de cirugía mayor ambulatoria',
   'Establece los criterios de funcionamiento de los establecimientos donde se realiza cirugía mayor ambulatoria, incluyendo requisitos de infraestructura, personal, equipamiento, procesos de atención al paciente y criterios de alta y seguimiento postoperatorio.',
   NULL),

  ('DE-NOM-097',
   'NOM-027-SSA3-2013 — Regulación de los Servicios de Salud. Criterios de funcionamiento de los servicios de urgencias',
   'Establece los requisitos de organización, estructura, equipamiento y funcionamiento de los servicios de urgencias de los establecimientos para la atención médica. Define los procesos de triage, atención inicial y criterios de admisión y alta.',
   NULL),

  ('DE-NOM-098',
   'NOM-030-SSA3-2013 — Regulación de los Servicios de Salud. Prestación de servicios de atención médica especializada para consultorios',
   'Establece los criterios para la prestación de servicios de atención médica especializada en consultorios, incluyendo los requisitos de equipamiento, organización, personal y condiciones sanitarias para la atención ambulatoria de especialidad.',
   NULL),

  ('DE-NOM-099',
   'NOM-034-SSA3-2013 — Regulación de los Servicios de Salud. Atención médica prehospitalaria',
   'Establece las disposiciones para la prestación de servicios de atención médica prehospitalaria (paramédicos, ambulancias), incluyendo los criterios de clasificación de pacientes, técnicas de estabilización, coordinación con hospitales y registros.',
   NULL)

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name, description = EXCLUDED.description,
  source_url = EXCLUDED.source_url, updated_at = now();

-- ── SSA2: Prevención y Control de Enfermedades ──────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud (SSA)',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-NOM-100',
   'NOM-015-SSA2-2010 — Para la prevención, tratamiento y control de la diabetes mellitus',
   'Establece los criterios para la prevención, diagnóstico, tratamiento y control de la diabetes mellitus tipo 1 y tipo 2. Define los procedimientos clínicos, el manejo de complicaciones y las metas de control glucémico en unidades de salud.',
   'https://www.dof.gob.mx/nota_detalle.php?codigo=5176853&fecha=23/11/2010'),

  ('DE-NOM-101',
   'NOM-030-SSA2-2009 — Para la prevención, detección, diagnóstico, tratamiento y control de la hipertensión arterial sistémica',
   'Establece las acciones para la prevención, detección, diagnóstico, tratamiento y control de la hipertensión arterial sistémica en los servicios de atención médica. Versión actualizada de la NOM-030-SSA2-1999.',
   'https://www.dof.gob.mx/nota_detalle.php?codigo=5144642&fecha=31/05/2010'),

  ('DE-NOM-102',
   'NOM-037-SSA2-2012 — Para la prevención, tratamiento y control de las dislipidemias',
   'Establece las acciones de prevención, diagnóstico y tratamiento de las dislipidemias. Define los parámetros de diagnóstico lipídico, las metas de tratamiento farmacológico y no farmacológico, y el seguimiento de pacientes en riesgo cardiovascular. Actualiza NOM-037-SSA2-2002.',
   NULL),

  ('DE-NOM-103',
   'NOM-047-SSA2-2015 — Para la atención a la salud del Grupo Etario de 10 a 19 años de edad',
   'Establece las actividades de promoción, protección, diagnóstico, tratamiento y control para la atención integral de adolescentes (10-19 años) en unidades de salud, incluyendo salud sexual y reproductiva, salud mental y adicciones.',
   NULL),

  ('DE-NOM-104',
   'NOM-025-SSA2-2014 — Para la prestación de servicios de salud en unidades de atención integral hospitalaria médico-psiquiátrica',
   'Establece los criterios para la prestación de servicios de salud mental en hospitales psiquiátricos y servicios de psiquiatría de hospitales generales, incluyendo derechos de los usuarios, infraestructura, personal y procesos de atención.',
   NULL),

  ('DE-NOM-105',
   'NOM-028-SSA2-2009 — Para la prevención, tratamiento y control de las adicciones',
   'Establece los criterios y procedimientos para la prevención y tratamiento de las adicciones en unidades médicas del Sistema Nacional de Salud, incluyendo alcoholismo, tabaquismo y adicción a drogas. Define el perfil de las unidades especializadas.',
   NULL),

  ('DE-NOM-106',
   'NOM-008-SSA3-2017 — Para el tratamiento integral del sobrepeso y la obesidad',
   'Establece los criterios para el diagnóstico, tratamiento integral y seguimiento del sobrepeso y la obesidad en adultos y niños en unidades de salud de todos los niveles de atención, incluyendo criterios para tratamiento médico y quirúrgico.',
   NULL)

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name, description = EXCLUDED.description,
  source_url = EXCLUDED.source_url, updated_at = now();

-- ── SSA1: Medicamentos, Dispositivos y Servicios Auxiliares ─────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría de Salud (SSA)',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-NOM-107',
   'NOM-220-SSA1-2016 — Instalación y operación de la farmacovigilancia',
   'Establece los requisitos para la instalación y operación del sistema de farmacovigilancia en México. Obliga a los establecimientos de salud a reportar reacciones adversas a medicamentos (RAM) y problemas relacionados con el uso de fármacos al COFEPRIS.',
   'https://www.dof.gob.mx/nota_detalle.php?codigo=5458652&fecha=01/12/2016'),

  ('DE-NOM-108',
   'NOM-240-SSA1-2012 — Instalación y operación de la tecnovigilancia',
   'Establece los requisitos para la instalación y operación del sistema de tecnovigilancia en México. Obliga a los establecimientos de salud a reportar incidentes y eventos adversos relacionados con dispositivos médicos al COFEPRIS.',
   'https://www.dof.gob.mx/nota_detalle.php?codigo=5285231&fecha=24/10/2012'),

  ('DE-NOM-109',
   'NOM-072-SSA1-2012 — Etiquetado de medicamentos y de remedios herbolarios',
   'Establece los requisitos de información que deben contener las etiquetas de los medicamentos para uso humano y de los remedios herbolarios. Define los datos obligatorios de identificación, indicaciones, contraindicaciones y advertencias de seguridad.',
   NULL),

  ('DE-NOM-110',
   'NOM-249-SSA1-2010 — Mezclas estériles: nutricionales y medicamentosas, e instalaciones para su preparación',
   'Establece las condiciones de instalación, equipamiento, personal, procesos y control de calidad requeridos para la preparación de mezclas estériles (nutrición parenteral total, mezclas oncológicas) en establecimientos de salud.',
   'https://www.dof.gob.mx/nota_detalle.php?codigo=5188386&fecha=18/01/2011'),

  ('DE-NOM-111',
   'NOM-127-SSA1-2021 — Agua para uso y consumo humano — Límites permisibles de la calidad del agua',
   'Establece los límites máximos permisibles de contaminantes físicos, químicos y microbiológicos en el agua para uso y consumo humano. Versión actualizada 2021. Aplicable al agua utilizada en procesos de esterilización, dilución de medicamentos y consumo en el hospital.',
   'https://www.dof.gob.mx/nota_detalle.php?codigo=5637574&fecha=22/06/2021')

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name, description = EXCLUDED.description,
  source_url = EXCLUDED.source_url, updated_at = now();

-- ── STPS: Seguridad e Higiene en el Trabajo (nuevas) ────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'Secretaría del Trabajo y Previsión Social (STPS)',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-NOM-112',
   'NOM-005-STPS-1998 — Condiciones de seguridad e higiene para el almacenamiento, transporte y manejo de sustancias inflamables y combustibles',
   'Establece las condiciones de seguridad e higiene para el almacenamiento, transporte y manejo de sustancias inflamables y combustibles en los centros de trabajo, aplicable al almacén de reactivos, farmacia y áreas con gases medicinales.',
   NULL),

  ('DE-NOM-113',
   'NOM-010-STPS-2014 — Agentes químicos contaminantes del ambiente laboral — Reconocimiento, evaluación y control',
   'Establece los niveles máximos permisibles de exposición de los trabajadores a agentes químicos contaminantes en centros de trabajo, y los procedimientos para su reconocimiento, evaluación y control. Aplica en laboratorio, farmacia y áreas con desinfectantes.',
   'https://www.dof.gob.mx/nota_detalle.php?codigo=5376523&fecha=28/04/2014')

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name, description = EXCLUDED.description,
  source_url = EXCLUDED.source_url, updated_at = now();


-- ════════════════════════════════════════════════════════════════
-- BLOQUE 4 — GUÍAS DE PRÁCTICA CLÍNICA (nuevas)
-- DE-GPC-009 → DE-GPC-039
-- (Ya existen: DE-GPC-001..008)
-- ════════════════════════════════════════════════════════════════

-- ── Urgencias y Medicina Crítica ────────────────────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'CENETEC — Centro Nacional de Excelencia Tecnológica en Salud',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-GPC-009',
   'GPC — Triage hospitalario en los Servicios de Urgencias Adultos',
   'Guía de práctica clínica para la clasificación inicial de la gravedad y urgencia de los pacientes que acuden al servicio de urgencias. Establece el sistema de triage en cinco niveles, los criterios de clasificación y los tiempos de atención por nivel.',
   'https://www.cenetec-difusion.com/CMGPC/IMSS-594-13/ER.pdf'),

  ('DE-GPC-010',
   'GPC — Reanimación Cardiopulmonar Básica y Avanzada en el Adulto',
   'Guía de práctica clínica que establece las intervenciones basadas en evidencia para la reanimación cardiopulmonar básica y avanzada en adultos con paro cardiorrespiratorio, con base en las guías AHA/ILCOR vigentes.',
   NULL),

  ('DE-GPC-011',
   'GPC — Atención Inicial del Paciente con Traumatismo Múltiple',
   'Establece las intervenciones diagnósticas y terapéuticas para la atención inicial del paciente politraumatizado, incluyendo la valoración primaria y secundaria, manejo de la vía aérea, control de hemorragias y criterios de activación del equipo de trauma.',
   NULL),

  ('DE-GPC-012',
   'GPC — Traumatismo Craneoencefálico Grave',
   'Establece las intervenciones para la atención del traumatismo craneoencefálico grave en el adulto, incluyendo el manejo del aumento de presión intracraneal, el uso de neuro-imagen, la indicación quirúrgica y el manejo en la UCI.',
   NULL),

  ('DE-GPC-013',
   'GPC — Manejo de las Intoxicaciones Agudas en Urgencias',
   'Guía para el diagnóstico y tratamiento de las principales intoxicaciones agudas (fármacos, organofosforados, monóxido de carbono, alcohol, drogas) en los servicios de urgencias. Incluye el uso de antídotos y criterios de ingreso a UCI.',
   NULL),

  ('DE-GPC-014',
   'GPC — Infarto Agudo de Miocardio con Elevación del Segmento ST (IAMCEST)',
   'Establece las intervenciones basadas en evidencia para el diagnóstico y tratamiento del IAMCEST, incluyendo el protocolo de activación, el uso de fibrinolíticos, los criterios para angioplastia primaria y el manejo de las complicaciones mecánicas.',
   NULL),

  ('DE-GPC-015',
   'GPC — Enfermedad Vascular Cerebral Isquémica',
   'Establece los criterios diagnósticos y terapéuticos para la atención del evento vascular cerebral (EVC) isquémico, incluyendo el protocolo de activación de código-EVC, la ventana para trombolisis, la indicación de trombectomía mecánica y el manejo en la Unidad de EVC.',
   NULL),

  ('DE-GPC-016',
   'GPC — Crisis Hipertensiva: Urgencia e Hipertensión Arterial Grave',
   'Establece las intervenciones diagnósticas y terapéuticas para la clasificación, evaluación y manejo de la crisis hipertensiva (urgencia y emergencia hipertensiva), incluyendo la selección de antihipertensivos parenterales y la meta de reducción de presión arterial.',
   NULL),

  ('DE-GPC-017',
   'GPC — Cetoacidosis Diabética y Estado Hiperosmolar Hiperglucémico',
   'Establece los criterios diagnósticos y el manejo de la cetoacidosis diabética y el estado hiperosmolar hiperglucémico, incluyendo la reposición de líquidos, insulina, electrolitos y el monitoreo de las complicaciones durante el tratamiento.',
   NULL),

  ('DE-GPC-018',
   'GPC — Neumonía Adquirida en la Comunidad en el Adulto',
   'Establece las recomendaciones para el diagnóstico, estratificación del riesgo (PSI, CURB-65), tratamiento antibiótico empírico y dirigido, y criterios de hospitalización y manejo en UCI de la neumonía adquirida en la comunidad en adultos.',
   NULL)

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name, description = EXCLUDED.description,
  source_url = EXCLUDED.source_url, updated_at = now();

-- ── Medicina Interna y Nefrología ────────────────────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'CENETEC — Centro Nacional de Excelencia Tecnológica en Salud',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-GPC-019',
   'GPC — Enfermedad Pulmonar Obstructiva Crónica (EPOC) — Diagnóstico y Tratamiento',
   'Establece las recomendaciones para el diagnóstico y tratamiento de la EPOC estable y su exacerbación aguda, incluyendo el uso de espirometría, broncodilatadores, corticosteroides y oxigenoterapia domiciliaria, así como los criterios de hospitalización.',
   NULL),

  ('DE-GPC-020',
   'GPC — Enfermedad Renal Crónica — Detección y Tratamiento',
   'Establece las recomendaciones para la detección temprana, estadificación (KDIGO), manejo de complicaciones y preparación para terapia sustitutiva renal en pacientes con enfermedad renal crónica en todos los niveles de atención.',
   NULL),

  ('DE-GPC-021',
   'GPC — Dengue con y sin Signos de Alarma en el Adulto',
   'Establece los criterios para el diagnóstico clínico y de laboratorio del dengue, la clasificación de la gravedad (sin signos de alarma, con signos de alarma, grave) y el manejo hospitalario, incluyendo la hidratación intravenosa y la vigilancia de hemorragia.',
   NULL)

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name, description = EXCLUDED.description,
  source_url = EXCLUDED.source_url, updated_at = now();

-- ── Cirugía General ──────────────────────────────────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'CENETEC — Centro Nacional de Excelencia Tecnológica en Salud',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-GPC-022',
   'GPC — Diagnóstico y Tratamiento de la Apendicitis Aguda',
   'Establece los criterios clínicos, de laboratorio e imagen (escala de Alvarado, ultrasonido, TAC) para el diagnóstico de apendicitis aguda, los abordajes quirúrgicos (abierto vs. laparoscópico) y el manejo del apéndice perforado.',
   NULL),

  ('DE-GPC-023',
   'GPC — Diagnóstico y Tratamiento de la Colecistitis y Colelitiasis',
   'Establece los criterios para el diagnóstico por imagen de la colelitiasis y sus complicaciones (colecistitis aguda, coledocolitiasis) y el abordaje quirúrgico electivo y de urgencia. Incluye indicaciones para CPRE y conversión de laparoscopia.',
   NULL),

  ('DE-GPC-024',
   'GPC — Diagnóstico y Tratamiento de las Hernias de Pared Abdominal',
   'Establece las recomendaciones para el diagnóstico y tratamiento quirúrgico de las hernias inguinal, umbilical, incisional y femoral, incluyendo la selección del abordaje (abierto vs. laparoscópico), el uso de malla protésica y el manejo de la hernia complicada.',
   NULL),

  ('DE-GPC-025',
   'GPC — Diagnóstico y Tratamiento de la Oclusión Intestinal',
   'Establece los criterios diagnósticos y terapéuticos para la oclusión intestinal mecánica y funcional, incluyendo el manejo inicial conservador, las indicaciones de cirugía de urgencia y el manejo perioperatorio del paciente con abdomen agudo obstructivo.',
   NULL),

  ('DE-GPC-026',
   'GPC — Prevención de Tromboembolia Venosa en Pacientes Quirúrgicos',
   'Establece las recomendaciones para la estratificación del riesgo tromboembólico (Caprini) en pacientes quirúrgicos y el uso de profilaxis farmacológica (HBPM) y mecánica (compresión neumática) para la prevención de TVP y TEP perioperatorios.',
   NULL)

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name, description = EXCLUDED.description,
  source_url = EXCLUDED.source_url, updated_at = now();

-- ── Gineco-Obstetricia ───────────────────────────────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'CENETEC — Centro Nacional de Excelencia Tecnológica en Salud',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-GPC-027',
   'GPC — Control Prenatal con Atención Centrada en la Paciente Obstétrica',
   'Establece las recomendaciones para la atención prenatal, incluyendo el número y contenido de consultas, los estudios de laboratorio e imagen, la detección de complicaciones (diabetes gestacional, preeclampsia) y la educación materna durante el embarazo.',
   NULL),

  ('DE-GPC-028',
   'GPC — Cesárea Segura',
   'Establece las indicaciones, contraindicaciones y técnica quirúrgica para la operación cesárea segura, incluyendo el manejo anestésico, la profilaxis antibiótica, la prevención de complicaciones y el alta hospitalaria de la díada madre-hijo.',
   NULL),

  ('DE-GPC-029',
   'GPC — Preeclampsia-Eclampsia: Diagnóstico y Tratamiento',
   'Establece los criterios diagnósticos y el manejo de la preeclampsia con y sin criterios de severidad, la eclampsia y el síndrome HELLP, incluyendo el uso de sulfato de magnesio, antihipertensivos y los criterios para la interrupción del embarazo.',
   NULL),

  ('DE-GPC-030',
   'GPC — Hemorragia Obstétrica: Prevención, Diagnóstico y Tratamiento',
   'Establece las intervenciones para la prevención (manejo activo del tercer período), diagnóstico y tratamiento de la hemorragia obstétrica (placenta previa, desprendimiento placentario, atonía uterina, inversión uterina) en la sala de partos y el quirófano.',
   NULL),

  ('DE-GPC-031',
   'GPC — Aborto Espontáneo y sus Complicaciones',
   'Establece los criterios diagnósticos y el manejo del aborto espontáneo (amenaza, inevitable, incompleto, retenido, séptico), incluyendo el tratamiento médico y quirúrgico (aspiración manual endouterina, legrado), la antibioticoterapia y los cuidados postprocedimiento.',
   NULL)

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name, description = EXCLUDED.description,
  source_url = EXCLUDED.source_url, updated_at = now();

-- ── Pediatría y Neonatología ─────────────────────────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'CENETEC — Centro Nacional de Excelencia Tecnológica en Salud',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-GPC-032',
   'GPC — Atención del Recién Nacido Sano en la Sala de Expulsión',
   'Establece los cuidados inmediatos del recién nacido a término sano en la sala de partos, incluyendo la valoración de Apgar, la ligadura del cordón umbilical, el contacto piel a piel, la lactancia materna precoz, la profilaxis ocular y la vacunación al nacimiento.',
   NULL),

  ('DE-GPC-033',
   'GPC — Reanimación Neonatal en el Recién Nacido',
   'Establece las intervenciones escalonadas para la reanimación del recién nacido con depresión neonatal en la sala de partos, con base en las guías NRP/ILCOR vigentes, incluyendo la ventilación a presión positiva, las compresiones torácicas y el uso de medicamentos.',
   NULL),

  ('DE-GPC-034',
   'GPC — Ictericia Neonatal en el Recién Nacido Mayor de 35 Semanas',
   'Establece los criterios para la evaluación y manejo de la ictericia neonatal por hiperbilirrubinemia no conjugada, incluyendo el uso de nomograma de Bhutani, los umbrales para fototerapia y exsanguinotransfusión, y el seguimiento ambulatorio.',
   NULL),

  ('DE-GPC-035',
   'GPC — Bronquiolitis Aguda en Menores de 2 Años',
   'Establece el diagnóstico clínico (sin necesidad de radiografía de rutina) y el tratamiento de soporte de la bronquiolitis aguda viral en menores de 2 años, incluyendo los criterios de hospitalización, el uso de oxigenoterapia de alto flujo y los criterios de alta.',
   NULL),

  ('DE-GPC-036',
   'GPC — Enfermedad Diarreica Aguda en Niños',
   'Establece los criterios para la evaluación de la deshidratación y el tratamiento de la enfermedad diarreica aguda en niños, incluyendo la terapia de rehidratación oral, la hidratación intravenosa según el plan A, B y C de la OMS, y el uso de zinc.',
   NULL),

  ('DE-GPC-037',
   'GPC — Fiebre Sin Foco Aparente en Menores de 3 Meses',
   'Establece los criterios de evaluación y manejo del lactante menor febril sin foco aparente de infección, incluyendo los criterios de Rochester y Philadelphia para la estratificación del riesgo de infección bacteriana grave y las indicaciones de hospitalización y antibioticoterapia.',
   NULL)

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name, description = EXCLUDED.description,
  source_url = EXCLUDED.source_url, updated_at = now();

-- ── GPCs Transversales ───────────────────────────────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  'CENETEC — Centro Nacional de Excelencia Tecnológica en Salud',
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-GPC-038',
   'GPC — Diagnóstico y Tratamiento del Dolor en el Paciente Hospitalizado',
   'Establece las recomendaciones para la evaluación sistemática del dolor (escalas validadas), el tratamiento farmacológico escalonado (escalera analgésica OMS) y no farmacológico, y el manejo del dolor agudo postoperatorio y del dolor crónico en pacientes hospitalizados.',
   NULL),

  ('DE-GPC-039',
   'GPC — Uso Racional de Hemocomponentes en el Paciente Adulto',
   'Establece las indicaciones, umbrales de transfusión y criterios de selección para el uso de concentrados eritrocitarios, plaquetas, plasma fresco congelado y crioprecipitados en el paciente adulto hospitalizado, con base en la medicina transfusional basada en evidencia.',
   NULL)

) AS d(code, name, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name, description = EXCLUDED.description,
  source_url = EXCLUDED.source_url, updated_at = now();


-- ════════════════════════════════════════════════════════════════
-- BLOQUE 5 — NORMAS Y ESTÁNDARES DE REFERENCIA SGC (DE-CSG)
-- DE-CSG-001 → DE-CSG-011
-- ════════════════════════════════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, custodian_position, description, source_url
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  'Vigente', 'vigente', CURRENT_DATE,
  d.autor,
  'Responsable de Calidad',
  d.descripcion, d.url
FROM (VALUES

  ('DE-CSG-001',
   'ISO 9001:2015 — Sistemas de gestión de la calidad. Requisitos',
   'ISO',
   'Norma internacional que especifica los requisitos para un sistema de gestión de la calidad orientado a demostrar la capacidad de proveer productos y servicios conformes y aumentar la satisfacción del cliente. Base normativa del SGC del Hospital Santa Margarita.',
   NULL),

  ('DE-CSG-002',
   'ISO 19011:2018 — Directrices para la auditoría de los sistemas de gestión',
   'ISO',
   'Norma internacional que proporciona orientación sobre la auditoría de sistemas de gestión, incluyendo los principios de la auditoría, la gestión de un programa de auditorías y la realización de auditorías de sistemas de gestión. Guía para las auditorías internas del SGC.',
   NULL),

  ('DE-CSG-003',
   'ISO 31000:2018 — Gestión del riesgo. Directrices',
   'ISO',
   'Norma internacional que proporciona directrices para la gestión del riesgo, incluyendo los principios, el marco de referencia y el proceso de gestión del riesgo. Base metodológica para la gestión de riesgos del SGC (Cláusula 6.1 de ISO 9001:2015).',
   NULL),

  ('DE-CSG-004',
   'Estándares de Acreditación SiNaCEAM — CCINSHAE',
   'Consejo de Salubridad General (CSG)',
   'Estándares del Sistema Nacional de Certificación de Establecimientos de Atención Médica (SiNaCEAM) para la acreditación hospitalaria en México. Define los estándares de atención centrada en el paciente, gestión de la información, seguridad del paciente y liderazgo.',
   'https://www.gob.mx/salud/acciones-y-programas/sinaceam'),

  ('DE-CSG-005',
   'Evaluación del Cumplimiento de los Estándares para Hospitales (ACESI)',
   'Consejo de Salubridad General (CSG)',
   'Metodología y herramientas de autoevaluación del Consejo de Salubridad General para verificar el cumplimiento de los estándares de acreditación hospitalaria. Incluye las listas de verificación y el sistema de puntuación para la certificación.',
   'https://www.gob.mx/salud/acciones-y-programas/sinaceam'),

  ('DE-CSG-006',
   'Manual de Indicadores de Salud Poblacional (MISP) — SSA',
   'Secretaría de Salud (SSA)',
   'Define y operacionaliza los indicadores clave para la evaluación del desempeño hospitalario y la salud poblacional en México, incluyendo indicadores de cobertura, calidad, seguridad del paciente, y gestión de servicios hospitalarios.',
   NULL),

  ('DE-CSG-007',
   'Cuadro Básico de Medicamentos y Catálogo de Insumos del Sector Salud',
   'Consejo de Salubridad General (CSG)',
   'Catálogo oficial de los medicamentos e insumos para la salud que se utilizan en los establecimientos del Sistema Nacional de Salud en México. Referencia para la gestión del suministro farmacéutico y la selección de medicamentos del cuadro básico del hospital.',
   'https://www.csg.gob.mx/contenidos/CB_INSUMOS/medicamentos_cuadro_basico.html'),

  ('DE-CSG-008',
   'Lineamientos para el Establecimiento de Hospitales Reconvertidos y Reactivación de Servicios — COFEPRIS',
   'COFEPRIS / Secretaría de Salud',
   'Lineamientos técnicos y administrativos para la apertura, reconversión, ampliación y reactivación de servicios hospitalarios, incluyendo los requisitos de licencia sanitaria, verificación y cumplimiento de normas para establecimientos de atención médica.',
   NULL),

  ('DE-CSG-009',
   'Manuales Técnicos de Fabricante de Equipos Médicos Críticos',
   'Fabricantes de equipos',
   'Conjunto de manuales técnicos de operación, mantenimiento preventivo y correctivo de los equipos médicos críticos del hospital (ventiladores, monitores, desfibriladores, bombas de infusión, etc.). Cada equipo requiere su manual específico del fabricante.',
   NULL),

  ('DE-CSG-010',
   'Hojas de Datos de Seguridad (HDS/SDS) — Productos Químicos y Desinfectantes',
   'Fabricantes/Proveedores',
   'Fichas de datos de seguridad de los productos químicos, desinfectantes, antisépticos y reactivos utilizados en el hospital, conforme a la norma GHS/HAZCOM. Contienen información sobre composición, riesgos para la salud, EPP requerido y procedimientos de emergencia.',
   NULL),

  ('DE-CSG-011',
   'Contratos de Servicios Médicos con Aseguradoras — Tarifas y Condiciones',
   'Despacho Jurídico / Dirección Administrativa',
   'Contratos vigentes con las principales aseguradoras de gastos médicos mayores y organismos pagadores (IMSS subrogado, ISSSTE, seguros privados) que operen en el hospital. Incluyen tarifas autorizadas, procedimientos de facturación, requisitos de documentación y cláusulas de auditoria.',
   NULL)

) AS d(code, name, autor, descripcion, url)
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  elaborated_by     = EXCLUDED.elaborated_by,
  description       = EXCLUDED.description,
  source_url        = EXCLUDED.source_url,
  updated_at        = now();


-- ════════════════════════════════════════════════════════════════
-- VERIFICACIÓN FINAL
-- ════════════════════════════════════════════════════════════════
SELECT
  LEFT(d.code, 10)              AS codigo,
  LEFT(d.name, 60)              AS nombre,
  d.status,
  d.last_verified_at IS NOT NULL AS tiene_verificacion
FROM documents d
WHERE d.code LIKE 'DE-LEY-0%'
   OR d.code LIKE 'DE-REG-0%'
   OR d.code LIKE 'DE-NOM-09%'
   OR d.code LIKE 'DE-NOM-1%'
   OR d.code LIKE 'DE-GPC-0%'
   OR d.code LIKE 'DE-CSG-%'
ORDER BY d.code
LIMIT 120;
