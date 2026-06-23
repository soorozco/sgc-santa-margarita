-- ============================================================
--  Ropería — Registro y contenido digital de documentos RO
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

-- Asegurarse que el departamento Ropería exista
INSERT INTO departments (code, name, is_active)
VALUES ('RO', 'Ropería', true)
ON CONFLICT (code) DO NOTHING;

-- ═══ REGISTRAR DOCUMENTOS ═══

-- FT-RO-01
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-RO-01', 'Control de Ropa Sucia Recolectada (Externa)',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'RO'),
  '02', 'en_revision', 'Jefatura de Ropería',
  '2024-02-26',
  'Claudia Filiberta Rivera Ortega', 'Jefatura de Ropería',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'RO')
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
-- FT-RO-02
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-RO-02', 'Vale de Entrega de Ropería Extraordinaria',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'RO'),
  '02', 'en_revision', 'Jefatura de Ropería',
  '2024-02-26',
  'Claudia Filiberta Rivera Ortega', 'Jefatura de Ropería',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'RO')
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
-- FT-RO-03
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-RO-03', 'Vale de Entrega de Ropa',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'RO'),
  '02', 'en_revision', 'Jefatura de Ropería',
  '2024-02-26',
  'Claudia Filiberta Rivera Ortega', 'Jefatura de Ropería',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'RO')
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
-- FT-RO-04
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-RO-04', 'Horarios y Ruta de Distribución de Ropa Hospitalaria',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'RO'),
  '02', 'en_revision', 'Jefatura de Ropería',
  '2024-02-26',
  'Claudia Filiberta Rivera Ortega', 'Jefatura de Ropería',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'RO')
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
-- FT-RO-05
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-RO-05', 'Bitácora de Control de Entrega y Salida de Ropa Hospitalaria (Externa)',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'RO'),
  '02', 'en_revision', 'Jefatura de Ropería',
  '2024-02-26',
  'Claudia Filiberta Rivera Ortega', 'Jefatura de Ropería',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'RO')
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
-- FT-RO-06
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-RO-06', 'Bitácora de Entrega y Recepción de Ropa Hospitalaria',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'RO'),
  '02', 'en_revision', 'Jefatura de Ropería',
  '2024-02-26',
  'Claudia Filiberta Rivera Ortega', 'Jefatura de Ropería',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'RO')
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
-- FT-RO-07
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-RO-07', 'Control de Ropa Sucia Recolectada (Interna)',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'RO'),
  '01', 'en_revision', 'Jefatura de Ropería',
  '2024-02-26',
  'Claudia Filiberta Rivera Ortega', 'Jefatura de Ropería',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'RO')
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
-- FT-RO-08
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'FT-RO-08', 'Bitácora de Control de Entrega y Salida de Ropa Hospitalaria (Interna)',
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'RO'),
  '01', 'en_revision', 'Jefatura de Ropería',
  '2024-02-26',
  'Claudia Filiberta Rivera Ortega', 'Jefatura de Ropería',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'RO')
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
-- IT-RO-01
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-RO-01', 'Instrucción de Trabajo para el Abastecimiento de Ropa Limpia Hospitalaria',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'RO'),
  '03', 'en_revision', 'Jefatura de Ropería',
  '2023-03-30',
  'Claudia Filiberta Rivera Ortega', 'Jefatura de Ropería',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'RO')
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
-- IT-RO-02
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-RO-02', 'Instrucción de Trabajo para la Recolección de Ropa Sucia Hospitalaria',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'RO'),
  '02', 'en_revision', 'Jefatura de Ropería',
  '2023-03-30',
  'Claudia Filiberta Rivera Ortega', 'Jefatura de Ropería',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'RO')
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
-- PR-RO-02
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-RO-02', 'Proceso de Recepción y Almacenamiento de Ropa Limpia Hospitalaria',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'RO'),
  '02', 'en_revision', 'Jefatura de Ropería',
  '2022-07-17',
  'Claudia Filiberta Rivera Ortega', 'Jefatura de Ropería',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa',
  'Lic. María Elena Martínez',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'RO')
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

-- Contenido: FT-RO-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato para el registro del conteo de ropa sucia recolectada por turno proveniente de empresa externa de lavandería.', 'Formato para el registro del conteo de ropa sucia recolectada por turno proveniente de empresa externa de lavandería.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[{"version": "01", "fecha": "26/02/2024", "descripcion": "Alta de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "26/02/2024", "descripcion": "Modificación de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'FT-RO-01'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-RO-02
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Vale para la entrega extraordinaria de ropa hospitalaria a pacientes, con campos de solicitud, área, habitación y firmas de enfermería y ropería.', 'Vale para la entrega extraordinaria de ropa hospitalaria a pacientes, con campos de solicitud, área, habitación y firmas de enfermería y ropería.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[{"version": "01", "fecha": "26/02/2024", "descripcion": "Alta de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "26/02/2024", "descripcion": "Modificación de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'FT-RO-02'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-RO-03
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Vale de entrega de ropa hospitalaria por área y turno, con columnas de stock, cantidad solicitada, surtida y pendiente/adeudo.', 'Vale de entrega de ropa hospitalaria por área y turno, con columnas de stock, cantidad solicitada, surtida y pendiente/adeudo.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[{"version": "01", "fecha": "26/02/2024", "descripcion": "Alta de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "26/02/2024", "descripcion": "Modificación de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'FT-RO-03'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-RO-04
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato que establece los horarios y la ruta de recolección y distribución de ropa hospitalaria en las distintas áreas del hospital.', 'Formato que establece los horarios y la ruta de recolección y distribución de ropa hospitalaria en las distintas áreas del hospital.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[{"version": "01", "fecha": "26/02/2024", "descripcion": "Alta de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "26/02/2024", "descripcion": "Modificación de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'FT-RO-04'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-RO-05
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Bitácora de control de las prendas entregadas y recibidas con empresa externa de lavandería, con columnas de cantidad por tipo de prenda y firmas de operador.', 'Bitácora de control de las prendas entregadas y recibidas con empresa externa de lavandería, con columnas de cantidad por tipo de prenda y firmas de operador.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[{"version": "01", "fecha": "26/02/2024", "descripcion": "Alta de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "26/02/2024", "descripcion": "Modificación de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'FT-RO-05'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-RO-06
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Bitácora de entrega y recepción interna de ropa hospitalaria por área, con stocks de referencia y registro de prendas.', 'Bitácora de entrega y recepción interna de ropa hospitalaria por área, con stocks de referencia y registro de prendas.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[{"version": "01", "fecha": "26/02/2024", "descripcion": "Alta de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "26/02/2024", "descripcion": "Modificación de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'FT-RO-06'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-RO-07
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Formato para el registro del conteo de ropa sucia recolectada por turno en áreas internas del hospital.', 'Formato para el registro del conteo de ropa sucia recolectada por turno en áreas internas del hospital.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[{"version": "01", "fecha": "26/02/2024", "descripcion": "Alta de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'FT-RO-07'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: FT-RO-08
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Bitácora de control de entrega y salida de ropa hospitalaria en áreas internas, con registro de prendas y firmas de operador y ropería.', 'Bitácora de control de entrega y salida de ropa hospitalaria en áreas internas, con registro de prendas y firmas de operador y ropería.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[{"version": "01", "fecha": "26/02/2024", "descripcion": "Alta de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'FT-RO-08'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-RO-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'La presente instrucción de trabajo da inicio con la preparación de paquetes de ropa limpia para la entrega de esta y finaliza una vez que se han abastecido los stocks de ropa en las distintas áreas.', 'La presente instrucción de trabajo da inicio con la preparación de paquetes de ropa limpia para la entrega de esta y finaliza una vez que se han abastecido los stocks de ropa en las distintas áreas.',
  '[]'::jsonb, '[]'::jsonb,
  '["Vale de entrega de ropa hospitalaria.", "Carro exclusivo para el traslado de ropa hospitalaria limpia.", "Ropa hospitalaria."]'::jsonb, '[{"no": "1", "responsable": "Ropería", "actividad": "Realiza la higiene de manos conforme a IT-UV-01 Instrucción de trabajo para la higiene de manos con agua y jabón."}, {"no": "2", "responsable": "Ropería", "actividad": "Limpia y desinfecta el carrito exclusivo para la transportación de ropa limpia."}, {"no": "3", "responsable": "Ropería", "actividad": "Prepara el carro con la ropa limpia necesaria para surtir los stocks (sábana regular, sábana clínica, fundas, batas de aislamiento, batas de paciente, toallas, cobertores, filipinas, pantalones y almohadas). Nota: Los paquetes de ropa tienen que ir empaquetados en bolsa transparente y tapados con una sábana para la entrega de ropa a cada piso."}, {"no": "4", "responsable": "Ropería", "actividad": "Inicia el recorrido para la entrega de ropa limpia basándose en los horarios y ruta de distribución de ropa hospitalaria FT-RO-04."}, {"no": "5", "responsable": "Ropería", "actividad": "Comunica a personal de enfermería la entrega de ropa y surte la cantidad de prendas solicitadas para completar el stock."}, {"no": "6", "responsable": "Ropería", "actividad": "Registra la entrega de ropa limpia en FT-RO-03 Vale de entrega de ropa. Nota: En caso de que soliciten prendas extras, realizará entrega y llenará el FT-RO-02 Vale de entrega de ropería extraordinaria."}]'::jsonb, '[{"riesgo": "Desabasto de ropa hospitalaria en los stocks.", "barrera": "Realizar el conteo de ropa limpia en los stocks cada cierto tiempo."}, {"riesgo": "Falta de comunicación entre los departamentos involucrados que generen un desacuerdo con el abastecimiento de los stocks.", "barrera": "Contar con el personal necesario y capacitado para ejecutar el proceso, así como mejorar la comunicación entre cada involucrado."}]'::jsonb,
  '[{"nombre": "Instrucción de trabajo para la higiene de manos con agua y jabón", "codigo": "IT-UV-01"}, {"nombre": "Vale de entrega de ropería extraordinaria", "codigo": "FT-RO-02"}, {"nombre": "Vale de entrega de ropa", "codigo": "FT-RO-03"}, {"nombre": "Horarios y ruta de distribución de ropa hospitalaria", "codigo": "FT-RO-04"}]'::jsonb, '[{"version": "02", "fecha": "12/07/2022", "descripcion": "Modificación de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate Bautista"}, {"version": "03", "fecha": "30/03/2023", "descripcion": "Modificación de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate Bautista"}]'::jsonb
FROM documents d WHERE d.code = 'IT-RO-01'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-RO-02
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'La presente instrucción de trabajo da inicio con la recolección de ropa sucia hospitalaria en las distintas áreas y finaliza una vez que se ha depositado y clasificado la ropa sucia en el cuarto correspondiente.', 'La presente instrucción de trabajo da inicio con la recolección de ropa sucia hospitalaria en las distintas áreas y finaliza una vez que se ha depositado y clasificado la ropa sucia en el cuarto correspondiente.',
  '[]'::jsonb, '[]'::jsonb,
  '["Control de ropa sucia hospitalaria (FT-RO-01).", "Carro exclusivo para el traslado de ropa sucia hospitalaria."]'::jsonb, '[{"no": "1", "responsable": "Ropería", "actividad": "Prepara y desinfecta el carrito exclusivo para la recolección de la ropa sucia."}, {"no": "2", "responsable": "Ropería", "actividad": "Inicia el recorrido para la recolección de ropa sucia en base a los horarios y ruta de recolección FT-RO-04 Horarios y ruta de distribución de ropa hospitalaria."}, {"no": "3", "responsable": "Ropería", "actividad": "Realiza la recolección de ropa sucia en cada séptico correspondiente a cada área. Nota: La ropa sucia clasificada como contaminada deberá estar en bolsa transparente con su respectivo rótulo que nos indique qué prendas contiene la bolsa."}, {"no": "4", "responsable": "Ropería", "actividad": "Registra en FT-RO-01 Control de ropa sucia recolectada la cantidad de cada prenda que se recolectó en cada piso."}, {"no": "5", "responsable": "Ropería", "actividad": "Traslada el carrito con ropa sucia recolectada al cuarto de ''Ropa sucia''."}, {"no": "6", "responsable": "Ropería", "actividad": "Deposita cada prenda en el contenedor temporal de acuerdo con su clasificación (sábana regular, sábana clínica, fundas, batas de aislamiento, batas de paciente, toallas, cobertores, filipinas, pantalones y almohadas)."}, {"no": "7", "responsable": "Ropería", "actividad": "Realiza el conteo de ropa sucia recolectada haciendo la suma de cada prenda que se recolectó el día anterior en base a lo registrado en ambos turnos en FT-RO-01 Control de ropa recolectada."}, {"no": "8", "responsable": "Ropería", "actividad": "Se coloca el equipo necesario para su protección: bata, guantes y cubrebocas."}, {"no": "9", "responsable": "Ropería", "actividad": "Realiza la separación de la ropa sucia generada: ropa propia y ropa de la empresa subrogada."}, {"no": "10", "responsable": "Ropería", "actividad": "Supervisa que se realice el conteo general de la ropa de acuerdo con su separación y clasificación. Nota: En el caso de la ropa contaminada, toma en cuenta lo que se encuentra etiquetado en la bolsa."}, {"no": "11", "responsable": "Ropería", "actividad": "Solicita al personal de la empresa subrogada la nota de recolección y corrobora que el conteo total coincida con el total registrado en FT-RO-01 Control de ropa sucia recolectada. Registra la ropa sucia entregada a la empresa subrogada en FT-RO-05 Bitácora de control de entrega y salida de ropa hospitalaria en la sección de ''ropa entregada''."}, {"no": "12", "responsable": "Ropería", "actividad": "Realiza la higiene de manos conforme a IT-UV-01 Instrucción de trabajo para la higiene de manos con agua y jabón."}]'::jsonb, '[{"riesgo": "Riesgo de infecciones asociadas a la atención de salud (IAAS) entre el personal que manipula ropa sucia y/o contaminada.", "barrera": "Uso de equipo de protección personal adecuado (bata, guantes y cubrebocas), así como supervisión continua del cumplimiento del proceso."}, {"riesgo": "Pago extra por pérdida de ropa hospitalaria.", "barrera": "Llevar un registro y control interno de la ropa sucia recolectada."}]'::jsonb,
  '[{"nombre": "Control de ropa sucia recolectada", "codigo": "FT-RO-01"}, {"nombre": "Bitácora de control de entrega y salida de ropa hospitalaria (Externa)", "codigo": "FT-RO-05"}, {"nombre": "Instrucción de trabajo para la higiene de manos con agua y jabón", "codigo": "IT-UV-01"}, {"nombre": "Horarios y ruta de distribución de ropa hospitalaria", "codigo": "FT-RO-04"}]'::jsonb, '[{"version": "01", "fecha": "12/07/2022", "descripcion": "Alta de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate Bautista"}, {"version": "02", "fecha": "30/03/2023", "descripcion": "Modificación de documento", "realizado": "Claudia Filiberta Rivera Ortega", "aprobado": "Mtra. Ana Cecilia Zárate Bautista"}]'::jsonb
FROM documents d WHERE d.code = 'IT-RO-02'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-RO-02
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'El presente proceso da inicio una vez que el operador de la empresa subrogada acude a las instalaciones para la entrega de la ropa hospitalaria y termina una vez que se ejecutó la actividad quedando registrada en la bitácora correspondiente.', 'Disminuir el riesgo de infecciones asociadas al manejo de ropa limpia mediante la secuencia cronológica de pasos seguros y en forma estandarizada.',
  '[]'::jsonb, '[{"rol": "Actualización", "descripcion": "Jefatura de ropería"}, {"rol": "Ejecución", "descripcion": "Auxiliar de ropería"}, {"rol": "Supervisión", "descripcion": "Epidemiología y Jefatura de ropería"}]'::jsonb,
  '[]'::jsonb, '[{"no": "1", "responsable": "Ropería", "actividad": "Realiza higiene de manos antes de iniciar el proceso, conforme a IT-UV-01 Instrucción de trabajo para la higiene de manos con agua y jabón."}, {"no": "2", "responsable": "Ropería", "actividad": "Se coloca equipo de protección personal (bata de manga larga y cubrebocas)."}, {"no": "3", "responsable": "Operador de empresa subrogada", "actividad": "Realiza la técnica de higiene de manos conforme a IT-UV-01 Instrucción de trabajo para la higiene de manos con agua y jabón."}, {"no": "4", "responsable": "Operador de empresa subrogada", "actividad": "Entrega los paquetes de ropa limpia a la encargada de ropería y realiza el conteo de la cantidad de ropa que se está entregando."}, {"no": "5", "responsable": "Ropería", "actividad": "Indica al operador de la empresa subrogada el anaquel destinado para la colocación de la ropa limpia. Nota: Verificar que los anaqueles se encuentren limpios para el acomodo de la ropa."}, {"no": "5b", "responsable": "Operador de empresa subrogada", "actividad": "Distribuye y acomoda la ropa limpia en los anaqueles correspondientes."}, {"no": "6", "responsable": "Operador de empresa subrogada", "actividad": "Realiza el registro de la ropa limpia que entregó en las notas."}, {"no": "7", "responsable": "Ropería", "actividad": "Verifica que lo registrado en la nota coincida con lo que se le entregó de ropa limpia y firma de conformidad. Registra la cantidad de prendas recibidas en FT-RO-05 Bitácora de control de entrega y salida de ropa hospitalaria en la sección de ''ropa recibida''."}]'::jsonb, '[{"riesgo": "Desabasto de stocks en las distintas áreas.", "barrera": "Coordinación con la empresa subrogada para la recepción de ropa limpia en horarios establecidos."}, {"riesgo": "Pérdida monetaria por extravío de ropa limpia.", "barrera": "Control de bitácoras y realización de inventarios."}]'::jsonb,
  '[{"nombre": "Instrucción de trabajo para la higiene de manos con agua y jabón", "codigo": "IT-UV-01"}, {"nombre": "Bitácora de control de entrega y salida de ropa hospitalaria (Externa)", "codigo": "FT-RO-05"}, {"nombre": "Proceso para la preparación de habitaciones", "codigo": "PR-UV-02"}]'::jsonb, '[{"version": "01", "fecha": "06/04/2022", "descripcion": "Alta de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "12/07/2022", "descripcion": "Modificación de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'PR-RO-02'
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
WHERE dp.code = 'RO'
ORDER BY d.code;
