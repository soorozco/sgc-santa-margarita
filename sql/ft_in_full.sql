-- ============================================================
--  Intendencia — Formatos FT-IN-01 al FT-IN-12
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

-- Asegurarse que el departamento Intendencia exista
INSERT INTO departments (code, name, is_active)
VALUES ('IN', 'Intendencia', true)
ON CONFLICT (code) DO NOTHING;

-- ═══ REGISTRAR DOCUMENTOS ═══

-- FT-IN-10
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-10', 'Bitácora de Limpieza de Áreas',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '01', 'en_revision', 'Jefatura de Intendencia',
  '2022-08-01',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Enf. Claudia Filiberta Rivera Ortega',  'Jefatura de Intendencia',
  'Lic. Maria Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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
-- FT-IN-01
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-01', 'Bitácora de Aseo Baños de Quirógrafo',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '02', 'en_revision', 'Jefatura de Intendencia',
  '2023-01-09',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Enf. Claudia Filiberta Rivera Ortega',  'Jefatura de Intendencia',
  'Lic. Maria Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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
-- FT-IN-11
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-11', 'Hoja de Supervisión de Intendencia',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '01', 'en_revision', 'Jefatura de Intendencia',
  '2023-01-09',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Enf. Claudia Filiberta Rivera Ortega',  'Jefatura de Intendencia',
  'Lic. Maria Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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
-- FT-IN-02
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-02', 'Checklist de Limpieza de Habitaciones',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '02', 'en_revision', 'Jefatura de Intendencia',
  '2024-02-14',
  'Lic. Rosa Isela López Astorga', 'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate Bautista',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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
-- FT-IN-03
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-03', 'Bitácora de Entrega de Turno',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '02', 'en_revision', 'Jefatura de Intendencia',
  '2024-02-14',
  'Lic. Rosa Isela López Astorga', 'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate Bautista',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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
-- FT-IN-04
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-04', 'Bitácora de Limpieza del Área de Lockers',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '02', 'en_revision', 'Jefatura de Intendencia',
  '2024-02-14',
  'Lic. Rosa Isela López Astorga', 'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate Bautista',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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
-- FT-IN-05
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-05', 'Bitácora de Limpieza Ordinaria',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '02', 'en_revision', 'Jefatura de Intendencia',
  '2024-02-14',
  'Lic. Rosa Isela López Astorga', 'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate Bautista',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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
-- FT-IN-06
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-06', 'Cronograma de Limpieza Ordinaria',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '02', 'en_revision', 'Jefatura de Intendencia',
  '2024-02-14',
  'Lic. Rosa Isela López Astorga', 'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate Bautista',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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
-- FT-IN-07
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-07', 'Control de Pendientes en Áreas',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '02', 'en_revision', 'Jefatura de Intendencia',
  '2024-02-14',
  'Lic. Rosa Isela López Astorga', 'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate Bautista',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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
-- FT-IN-09
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-09', 'Registro de Limpieza del Área de Comedor',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '02', 'en_revision', 'Jefatura de Intendencia',
  '2024-02-14',
  'Lic. Rosa Isela López Astorga', 'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate Bautista',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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
-- FT-IN-08
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-08', 'Registro de Limpieza Rutinaria',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '03', 'en_revision', 'Jefatura de Intendencia',
  '2024-05-05',
  'Lic. Rosa Isela López Astorga', 'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate Bautista',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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
-- FT-IN-12
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-IN-12', 'Control para la Preparación de Habitaciones',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '01', 'en_revision', 'Jefatura de Intendencia',
  '2024-07-05',
  'Lic. Rosa Isela López Astorga', 'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate Bautista',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
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

-- Contenido: FT-IN-10
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Bitácora de limpieza de áreas con registro de fecha, turno, área o habitación, desinfectante utilizado, tipo de aseo (rutinaria, cultivo o desinfección de alto nivel), responsable y supervisora.', 'Bitácora de limpieza de áreas con registro de fecha, turno, área o habitación, desinfectante utilizado, tipo de aseo (rutinaria, cultivo o desinfección de alto nivel), responsable y supervisora.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-10'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-IN-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Bitácora para el registro del aseo de baños del área de quirógrafo, con control cada 2 horas de turno.', 'Bitácora para el registro del aseo de baños del área de quirógrafo, con control cada 2 horas de turno.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-01'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-IN-11
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Hoja de supervisión de intendencia con checklist por habitación (cama, colchón, closet, mesa puente, cherlon, tripié, paredes, televisión, puertas, piso, silla, ventanas) y tipo de limpieza realizada.', 'Hoja de supervisión de intendencia con checklist por habitación (cama, colchón, closet, mesa puente, cherlon, tripié, paredes, televisión, puertas, piso, silla, ventanas) y tipo de limpieza realizada.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-11'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-IN-02
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Checklist de limpieza de habitaciones por área (Planta Baja, Planta Alta, Pediatría, Juan Pablo II, Terapia Intensiva, etc.), con verificación de tipo de limpieza e insumos.', 'Checklist de limpieza de habitaciones por área (Planta Baja, Planta Alta, Pediatría, Juan Pablo II, Terapia Intensiva, etc.), con verificación de tipo de limpieza e insumos.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-02'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-IN-03
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Bitácora para el registro de la entrega de turno entre el personal de intendencia, con anotación de actividades, fecha, semana y firmas de quien realiza y supervisa.', 'Bitácora para el registro de la entrega de turno entre el personal de intendencia, con anotación de actividades, fecha, semana y firmas de quien realiza y supervisa.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-03'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-IN-04
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Bitácora para el registro de la limpieza del área de lockers del personal.', 'Bitácora para el registro de la limpieza del área de lockers del personal.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-04'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-IN-05
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Bitácora de registro de limpieza ordinaria en áreas, con columnas de fecha, semana, actividades realizadas, responsable, supervisor y observaciones.', 'Bitácora de registro de limpieza ordinaria en áreas, con columnas de fecha, semana, actividades realizadas, responsable, supervisor y observaciones.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-05'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-IN-06
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato de cronograma mensual de limpieza ordinaria, para la planeación y asignación de áreas al personal de intendencia.', 'Formato de cronograma mensual de limpieza ordinaria, para la planeación y asignación de áreas al personal de intendencia.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-06'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-IN-07
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato de control de pendientes en áreas, para el seguimiento de actividades no concluidas por parte del personal de intendencia.', 'Formato de control de pendientes en áreas, para el seguimiento de actividades no concluidas por parte del personal de intendencia.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-07'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-IN-09
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Registro de limpieza del área de comedor, con control de actividades, responsable y frecuencia.', 'Registro de limpieza del área de comedor, con control de actividades, responsable y frecuencia.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-09'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-IN-08
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Registro de limpieza rutinaria por habitación o área, con nombre del responsable, área y verificación de actividades.', 'Registro de limpieza rutinaria por habitación o área, con nombre del responsable, área y verificación de actividades.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-08'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-IN-12
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Control para la preparación de habitaciones con registro de fecha, habitación, retiro de ropa, tipo de aseo, checklist, nebulización, cultivo, cortinas, insumos, línea de teléfono, botón de emergencia, estatus y observaciones.', 'Control para la preparación de habitaciones con registro de fecha, habitación, retiro de ropa, tipo de aseo, checklist, nebulización, cultivo, cortinas, insumos, línea de teléfono, botón de emergencia, estatus y observaciones.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'FT-IN-12'
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
WHERE dp.code = 'IN'
ORDER BY d.code;
