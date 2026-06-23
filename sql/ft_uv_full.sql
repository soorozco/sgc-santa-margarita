-- ============================================================
--  Unidad de Vigilancia Epidemiológica — Formatos FT-UV
--  Hospital Santa Margarita · SGC ISO 9001:2015
-- ============================================================

-- ── Asegurar columnas extendidas en documents ────────────────
ALTER TABLE documents ADD COLUMN IF NOT EXISTS issue_date      date;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS elaboro_nombre  text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS elaboro_cargo   text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS reviso_nombre   text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS reviso_cargo    text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS autorizo_nombre text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS autorizo_cargo  text;

-- Asegurarse que el departamento UV exista
INSERT INTO departments (code, name, is_active)
VALUES ('UV', 'Unidad de Vigilancia Epidemiológica Hospitalaria', true)
ON CONFLICT (code) DO NOTHING;

-- ═══ REGISTRAR DOCUMENTOS ═══

-- FT-UV-01
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-01', 'Seguimiento de Pacientes y Habitaciones',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '03', 'en_revision', 'Jefatura de UVEH',
  '2023-01-04',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. María de Jesús García Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-02
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-02', 'Supervisión de RPBI',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '02', 'en_revision', 'Jefatura de UVEH',
  '2023-01-23',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. María de Jesús García Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-03
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-03', 'Supervisión Cocina y Cafetería',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '02', 'en_revision', 'Jefatura de UVEH',
  '2023-01-23',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. María de Jesús García Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-04
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-04', 'Supervisión de Hemodiálisis',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '02', 'en_revision', 'Jefatura de UVEH',
  '2023-01-23',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. María de Jesús García Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-10
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-10', 'Bitácora de Supervisión de Laboratorio',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '02', 'en_revision', 'Jefatura de UVEH',
  '2023-01-04',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. María de Jesús García Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-11
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-11', 'Encuesta de Accidentes Laborales por Riesgos Biológicos',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '02', 'en_revision', 'Jefatura de UVEH',
  '2023-01-23',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. María de Jesús García Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-12
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-12', 'Evaluación de Higiene de Manos',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '02', 'en_revision', 'Jefatura de UVEH',
  '2023-01-23',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. María de Jesús García Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-21
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-21', 'Enfermedades Infectocontagiosas',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '01', 'en_revision', 'Jefatura de UVEH',
  '2023-01-04',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. María de Jesús García Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-22
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-22', 'Supervisión de Centrales y Áreas',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '01', 'en_revision', 'Jefatura de UVEH',
  '2023-01-04',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. María de Jesús García Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-05
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-05', 'Medidas Precautorias',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '01', 'en_revision', 'Jefatura de UVEH',
  '2023-03-27',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. María de Jesús García Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-13
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-13', 'Bitácora de Laboratorio de Control de Calidad de Habitaciones y/o Cubículos',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '02', 'en_revision', 'Jefatura de UVEH',
  '2023-09-08',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Dr. José Gonzalo Vázquez Camacho',  'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-14
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-14', 'Bitácora de Supervisión Banco de Sangre',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '02', 'en_revision', 'Jefatura de UVEH',
  '2023-09-08',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Dr. José Gonzalo Vázquez Camacho',  'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-17
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-17', 'Supervisión Rayos X',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '02', 'en_revision', 'Jefatura de UVEH',
  '2023-09-08',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Dr. José Gonzalo Vázquez Camacho',  'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-16
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-16', 'Vale de Control para la Preparación de Habitaciones y/o Cubículos',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '03', 'en_revision', 'Jefatura de UVEH',
  '2024-02-08',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Dr. José Gonzalo Vázquez Camacho',  'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- FT-UV-20
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-UV-20', 'Supervisión de Higiene Personal de Intendencia',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'UV'),
  '02', 'en_revision', 'Jefatura de UVEH',
  '2024-02-09',
  'Dr. Esteban González Díaz', 'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Dr. José Gonzalo Vázquez Camacho',  'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'UV')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;

-- ═══ CARGAR CONTENIDO DIGITAL ═══

-- Contenido: FT-UV-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato de seguimiento de pacientes y habitaciones con verificación de aislamientos, medidas precautorias, equipo de bioseguridad y restricción de personas al área.', 'Formato de seguimiento de pacientes y habitaciones con verificación de aislamientos, medidas precautorias, equipo de bioseguridad y restricción de personas al área.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-01'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-02
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato de supervisión del manejo de Residuos Peligrosos Biológicos Infecciosos (RPBI): ruta, contenedores, bitácora por área y cumplimiento de porcentaje de llenado.', 'Formato de supervisión del manejo de Residuos Peligrosos Biológicos Infecciosos (RPBI): ruta, contenedores, bitácora por área y cumplimiento de porcentaje de llenado.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-02'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-03
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato de supervisión de cocina y cafetería: temperaturas, niveles de cloro residual libre, mantenimiento de equipos, limpieza de instalaciones y refrigeradores.', 'Formato de supervisión de cocina y cafetería: temperaturas, niveles de cloro residual libre, mantenimiento de equipos, limpieza de instalaciones y refrigeradores.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-03'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-04
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato de supervisión del área de hemodiálisis: clasificación de contenedores, insumos para higiene de manos (jabón, toallas desechables, gel antibacterial) y observaciones.', 'Formato de supervisión del área de hemodiálisis: clasificación de contenedores, insumos para higiene de manos (jabón, toallas desechables, gel antibacterial) y observaciones.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-04'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-10
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Bitácora de supervisión de laboratorio con verificación de temperatura, limpieza, higiene personal (uñas, cabello recogido) y firma del supervisor.', 'Bitácora de supervisión de laboratorio con verificación de temperatura, limpieza, higiene personal (uñas, cabello recogido) y firma del supervisor.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-10'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-11
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Encuesta de accidentes laborales por riesgos biológicos: fecha del accidente, datos del trabajador, tipo de accidente, seguimiento de laboratorio y derivación.', 'Encuesta de accidentes laborales por riesgos biológicos: fecha del accidente, datos del trabajador, tipo de accidente, seguimiento de laboratorio y derivación.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-11'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-12
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato de evaluación de la técnica de higiene de manos del personal, con verificación de efectividad y registro de pasos omitidos.', 'Formato de evaluación de la técnica de higiene de manos del personal, con verificación de efectividad y registro de pasos omitidos.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-12'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-21
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Tabla de enfermedades infectocontagiosas de notificación y seguimiento epidemiológico en el hospital.', 'Tabla de enfermedades infectocontagiosas de notificación y seguimiento epidemiológico en el hospital.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-21'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-22
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato de supervisión de centrales y áreas del hospital con verificación de condiciones de limpieza, seguridad e higiene.', 'Formato de supervisión de centrales y áreas del hospital con verificación de condiciones de limpieza, seguridad e higiene.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-22'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-05
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Tabla de medidas precautorias por tipo de aislamiento (contacto, gotículas, aéreo, protector) con listado de enfermedades infectocontagiosas aplicables.', 'Tabla de medidas precautorias por tipo de aislamiento (contacto, gotículas, aéreo, protector) con listado de enfermedades infectocontagiosas aplicables.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-05'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-13
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Bitácora de laboratorio para el control de calidad de habitaciones y/o cubículos con registro de resultados a 72 horas y resultado final, con notificación a UVEH.', 'Bitácora de laboratorio para el control de calidad de habitaciones y/o cubículos con registro de resultados a 72 horas y resultado final, con notificación a UVEH.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-13'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-14
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato de supervisión del banco de sangre: almacenamiento de instrumentos, equipos de refrigeración con termómetros, firma del supervisor y turno.', 'Formato de supervisión del banco de sangre: almacenamiento de instrumentos, equipos de refrigeración con termómetros, firma del supervisor y turno.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-14'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-17
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato de supervisión del área de Rayos X: uso de equipo de protección, limpieza de baños, almacenamiento del equipo de intendencia y estado de los equipos.', 'Formato de supervisión del área de Rayos X: uso de equipo de protección, limpieza de baños, almacenamiento del equipo de intendencia y estado de los equipos.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-17'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-16
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Vale de control para la preparación de habitaciones y/o cubículos con datos del paciente, admisión, firmas de UVEH e intendencia, y registro de recepción.', 'Vale de control para la preparación de habitaciones y/o cubículos con datos del paciente, admisión, firmas de UVEH e intendencia, y registro de recepción.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-16'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-UV-20
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato de supervisión de higiene personal del personal de intendencia: uniforme, limpieza, turno, cubrebocas, calzado y criterios de evaluación por colaboradora.', 'Formato de supervisión de higiene personal del personal de intendencia: uniforme, limpieza, turno, cubrebocas, calzado y criterios de evaluación por colaboradora.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-UV-20'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;

-- ── Verificación ─────────────────────────────────────────────
SELECT d.code, d.name, d.current_version AS ver,
       dp.code AS dept, d.status
FROM documents d
JOIN document_types dt ON dt.id = d.document_type_id
JOIN departments    dp ON dp.id = d.department_id
WHERE dp.code = 'UV' AND dt.code_prefix = 'FT'
ORDER BY d.code;
