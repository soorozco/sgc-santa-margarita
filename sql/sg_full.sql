-- ============================================================
--  Seguridad, Higiene y Medio Ambiente — IT/MA/PR (34 docs)
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

-- Asegurarse que el tipo de documento Manual exista
INSERT INTO document_types (code_prefix, name, description)
VALUES ('MA', 'Manual', 'Manuales operativos y de referencia departamental')
ON CONFLICT (code_prefix) DO NOTHING;

-- Asegurarse que el departamento Seguridad, Higiene y Medio Ambiente exista
INSERT INTO departments (code, name, is_active)
VALUES ('SG', 'Seguridad, Higiene y Medio Ambiente', true)
ON CONFLICT (code) DO NOTHING;

-- ═══ REGISTRAR DOCUMENTOS ═══

-- IT-SG-15
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-SG-15', 'Instrucción de Trabajo para el Traslado de Bebés',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- IT-SG-16
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-SG-16', 'Instrucción de Trabajo para Acceso a Visitantes',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-05-31',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad',
  'Lic. Ma. Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- IT-SG-17
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-SG-17', 'Instrucción de Trabajo para el Control de Ingreso y Egreso de Pacientes Hospitalizados',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-07-17',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Lic. Ma. Elena Martínez Alvarado',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- IT-SG-18
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-SG-18', 'Instrucción de Trabajo para Nebulización de Habitaciones y/o Cubículos',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- IT-SG-19
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-SG-19', 'Instrucción de Trabajo para el Acceso a Urgencias',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- IT-SG-20
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-SG-20', 'Instrucción de Trabajo en Caso de Extravío de Pertenencias',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- IT-SG-21
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-SG-21', 'Instrucción de Trabajo para Realizar Rondines de Vigilancia',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- IT-SG-22
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-SG-22', 'Instrucción de Trabajo para el Monitoreo de Niveles de Cloro en Agua',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-07-30',
  'L.A. Alizbeydi Vázquez Serafín', 'Analista de Seguridad Higiene y Medio Ambiente',
  'Lic. María Elena Martínez Alvarado',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate Bautista',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- IT-SG-23
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-SG-23', 'Instrucción de Trabajo para la Atención de Contingencias de Residuos Peligrosos Biológicos Infecciosos',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v01', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2022-08-17',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. María Elena Martínez Alvarado',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- IT-SG-24
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-SG-24', 'Instrucción de Trabajo para Supervisión de Áreas',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v01', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2023-04-28',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. María Elena Martínez Alvarado',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- MA-SG-01
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'MA-SG-01', 'Manual de Residuos Peligrosos Biológicos Infecciosos',
  (SELECT id FROM document_types WHERE code_prefix = 'MA'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v01', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2022-12-07',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. María Elena Martínez Alvarado',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-01
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-01', 'Proceso en Caso de Persona Violenta',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v01', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2023-02-24',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. María Elena Martínez Alvarado',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-02
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-02', 'Proceso para el Acceso a Proveedores y/o Representantes Comerciales',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-05-31',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Mtra. Ana Cecilia Zárate',  'Jefatura de Calidad',
  'Lic. Ma. Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-03
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-03', 'Proceso de Control de Ingreso y Egreso del Personal',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-04
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-04', 'Proceso de Mantenimiento Correctivo en Equipos o Infraestructura',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v01', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2022-08-17',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. María Elena Martínez Alvarado',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-05
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-05', 'Proceso de Mantenimiento Preventivo',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-06
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-06', 'Proceso para Manipulación, Almacenamiento y Trasvase de Productos Químicos',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2023-04-28',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. María Elena Martínez Alvarado',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-07
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-07', 'Proceso de Recolección Interna de RPBI',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-08
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-08', 'Proceso para la Regulación de los Niveles de Cloro en el Agua',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2023-04-28',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. María Elena Martínez Alvarado',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-09
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-09', 'Proceso para el Mantenimiento Preventivo Anual de Instalaciones, Inmuebles y Equipos del Hospital',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-10
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-10', 'Proceso de Revisión de Detectores de Humo',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-11
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-11', 'Procedimiento para la Revisión de Servicios Básicos',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-12
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-12', 'Proceso para Revisión de Habitaciones',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-13
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-13', 'Proceso para la Identificación de Sustancias Químicas Peligrosas',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-14
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-14', 'Proceso de Recolección Externa de Residuos Peligrosos',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-15
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-15', 'Proceso de Mantenimiento Preventivo Externo de Equipos o Instalaciones',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v01', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2023-02-28',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. María Elena Martínez Alvarado',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-16
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-16', 'Proceso para Supervisión en Construcción y Remodelación',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v03', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-17
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-17', 'Proceso de Coordinación con Empresas Subrogadas para Realizar Servicios Externos',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-07-24',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Lic. Ma. Elena Martínez Alvarado',  'Dirección Administrativa',
  'Mtra. Ana Cecilia Zárate Bautista',  'Jefatura de Calidad'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-19
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-19', 'Proceso para el Traslado de Pacientes con COVID',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-20
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-20', 'Proceso para la Coordinación de Fumigación y Control de Plagas',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v02', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-02-12',
  'Lic. Viviana Janeth Langarica Leal', 'Analista de Seguridad e Higiene y Medio Ambiente',
  'I.A. Alizbeydi Vázquez Serafín',  'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Rosa Isela Lopez Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-21
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-21', 'Monitoreo de los Niveles de Cloro en Agua Potable',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v21', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2023-02-24',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. María Elena Martínez Alvarado',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-22
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-22', 'Proceso de Actuación en Caso de Falla de Energía Eléctrica',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v01', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2023-01-20',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. María Elena Martínez Alvarado',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-23
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-23', 'Proceso para el Ingreso a Infantes o Familiares en Habitaciones',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v01', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-05-27',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Dr. José Gonzalo Vázquez Camacho',  'Dirección Médica',
  'Lic. María Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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
-- PR-SG-24
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-SG-24', 'Proceso para la Selección y Evaluación de Prestador de Servicios',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'SG'),
  'v01', 'en_revision', 'Jefatura de Seguridad, Higiene y Medio Ambiente',
  '2024-09-30',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Dr. José Gonzalo Vázquez Camacho',  'Dirección Médica',
  'María de Jesús Gómez Flores',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'SG')
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

-- Contenido: IT-SG-15
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Instrucción para el traslado seguro de bebés dentro de las instalaciones del hospital, estableciendo responsabilidades, verificaciones y registros necesarios para garantizar la seguridad del neonato.', 'Instrucción para el traslado seguro de bebés dentro de las instalaciones del hospital, estableciendo responsabilidades, verificaciones y registros necesarios para garantizar la seguridad del neonato.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'IT-SG-15'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-SG-16
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Instrucción para controlar y registrar el acceso de visitantes a las instalaciones del hospital, incluyendo verificación de identidad, horarios permitidos y áreas autorizadas.', 'Instrucción para controlar y registrar el acceso de visitantes a las instalaciones del hospital, incluyendo verificación de identidad, horarios permitidos y áreas autorizadas.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'IT-SG-16'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-SG-17
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Instrucción para el control del ingreso y egreso de pacientes hospitalizados, garantizando la trazabilidad y seguridad de cada movimiento dentro del hospital.', 'Instrucción para el control del ingreso y egreso de pacientes hospitalizados, garantizando la trazabilidad y seguridad de cada movimiento dentro del hospital.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'IT-SG-17'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-SG-18
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Instrucción para la nebulización de habitaciones y/o cubículos, especificando los productos autorizados, diluciones, equipos a utilizar y medidas de protección personal.', 'Instrucción para la nebulización de habitaciones y/o cubículos, especificando los productos autorizados, diluciones, equipos a utilizar y medidas de protección personal.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'IT-SG-18'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-SG-19
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Instrucción para regular el acceso al área de urgencias, estableciendo los criterios de ingreso para pacientes, acompañantes y visitantes según el protocolo del hospital.', 'Instrucción para regular el acceso al área de urgencias, estableciendo los criterios de ingreso para pacientes, acompañantes y visitantes según el protocolo del hospital.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'IT-SG-19'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-SG-20
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Instrucción para la atención de reportes de extravío de pertenencias de pacientes o visitantes, estableciendo el flujo de notificación, búsqueda y resguardo de objetos.', 'Instrucción para la atención de reportes de extravío de pertenencias de pacientes o visitantes, estableciendo el flujo de notificación, búsqueda y resguardo de objetos.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'IT-SG-20'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-SG-21
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Instrucción para realizar rondines de vigilancia en las instalaciones del hospital, definiendo rutas, frecuencias, puntos de control y registro de incidencias.', 'Instrucción para realizar rondines de vigilancia en las instalaciones del hospital, definiendo rutas, frecuencias, puntos de control y registro de incidencias.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'IT-SG-21'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-SG-22
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Instrucción para el monitoreo periódico de los niveles de cloro en el agua de las instalaciones del hospital, estableciendo frecuencias de medición, valores de referencia y acciones correctivas.', 'Instrucción para el monitoreo periódico de los niveles de cloro en el agua de las instalaciones del hospital, estableciendo frecuencias de medición, valores de referencia y acciones correctivas.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'IT-SG-22'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-SG-23
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Instrucción para la atención de contingencias relacionadas con residuos peligrosos biológico-infecciosos, incluyendo derrames, exposiciones accidentales y situaciones de riesgo.', 'Instrucción para la atención de contingencias relacionadas con residuos peligrosos biológico-infecciosos, incluyendo derrames, exposiciones accidentales y situaciones de riesgo.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'IT-SG-23'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-SG-24
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Instrucción para la supervisión periódica de áreas del hospital por parte de seguridad e higiene, verificando condiciones de orden, limpieza, seguridad y cumplimiento normativo.', 'Instrucción para la supervisión periódica de áreas del hospital por parte de seguridad e higiene, verificando condiciones de orden, limpieza, seguridad y cumplimiento normativo.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'IT-SG-24'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: MA-SG-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Manual que establece los lineamientos, responsabilidades y procedimientos para el manejo integral de residuos peligrosos biológico-infecciosos (RPBI) conforme a la normatividad vigente (NOM-087-ECOL-SSA1-2002).', 'Manual que establece los lineamientos, responsabilidades y procedimientos para el manejo integral de residuos peligrosos biológico-infecciosos (RPBI) conforme a la normatividad vigente (NOM-087-ECOL-SSA1-2002).',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'MA-SG-01'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso de actuación del personal de seguridad ante la presencia de personas violentas dentro de las instalaciones del hospital, incluyendo protocolo de contención, notificación y registro.', 'Proceso de actuación del personal de seguridad ante la presencia de personas violentas dentro de las instalaciones del hospital, incluyendo protocolo de contención, notificación y registro.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-01'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-02
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para regular el acceso de proveedores y/o representantes comerciales a las instalaciones del hospital, incluyendo registro, identificación, acompañamiento y control de áreas restringidas.', 'Proceso para regular el acceso de proveedores y/o representantes comerciales a las instalaciones del hospital, incluyendo registro, identificación, acompañamiento y control de áreas restringidas.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-02'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-03
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para el control del ingreso y egreso del personal del hospital, garantizando el registro de entradas y salidas, y la detección de accesos no autorizados.', 'Proceso para el control del ingreso y egreso del personal del hospital, garantizando el registro de entradas y salidas, y la detección de accesos no autorizados.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-03'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-04
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para la atención de mantenimiento correctivo en equipos o infraestructura del hospital, desde la detección de fallas hasta la verificación de la reparación y cierre de reporte.', 'Proceso para la atención de mantenimiento correctivo en equipos o infraestructura del hospital, desde la detección de fallas hasta la verificación de la reparación y cierre de reporte.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-04'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-05
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para la planeación y ejecución del mantenimiento preventivo de equipos e instalaciones del hospital, con programación anual, seguimiento y registro de actividades realizadas.', 'Proceso para la planeación y ejecución del mantenimiento preventivo de equipos e instalaciones del hospital, con programación anual, seguimiento y registro de actividades realizadas.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-05'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-06
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para la manipulación, almacenamiento y trasvase de productos químicos utilizados en el hospital, estableciendo condiciones de seguridad, EPP requerido y manejo de derrames.', 'Proceso para la manipulación, almacenamiento y trasvase de productos químicos utilizados en el hospital, estableciendo condiciones de seguridad, EPP requerido y manejo de derrames.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-06'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-07
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso de recolección interna de residuos peligrosos biológico-infecciosos (RPBI) en las diferentes áreas del hospital, con rutas establecidas, recipientes autorizados y frecuencias definidas.', 'Proceso de recolección interna de residuos peligrosos biológico-infecciosos (RPBI) en las diferentes áreas del hospital, con rutas establecidas, recipientes autorizados y frecuencias definidas.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-07'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-08
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para la regulación y ajuste de los niveles de cloro en el agua de las instalaciones del hospital, asegurando valores dentro del rango normativo para agua potable.', 'Proceso para la regulación y ajuste de los niveles de cloro en el agua de las instalaciones del hospital, asegurando valores dentro del rango normativo para agua potable.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-08'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-09
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para el mantenimiento preventivo anual de instalaciones, inmuebles y equipos del hospital, incluyendo programación, contratación de servicios externos y verificación de resultados.', 'Proceso para el mantenimiento preventivo anual de instalaciones, inmuebles y equipos del hospital, incluyendo programación, contratación de servicios externos y verificación de resultados.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-09'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-10
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso de revisión periódica de detectores de humo instalados en las instalaciones del hospital, verificando su correcto funcionamiento, estado físico y registro de inspecciones.', 'Proceso de revisión periódica de detectores de humo instalados en las instalaciones del hospital, verificando su correcto funcionamiento, estado físico y registro de inspecciones.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-10'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-11
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Procedimiento para la revisión y verificación del estado de los servicios básicos del hospital (agua, electricidad, gas, etc.), con registro de lecturas, anomalías y acciones correctivas.', 'Procedimiento para la revisión y verificación del estado de los servicios básicos del hospital (agua, electricidad, gas, etc.), con registro de lecturas, anomalías y acciones correctivas.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-11'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-12
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para la revisión de habitaciones del hospital, verificando condiciones de seguridad, higiene, funcionamiento de equipos y mobiliario antes de la asignación a un nuevo paciente.', 'Proceso para la revisión de habitaciones del hospital, verificando condiciones de seguridad, higiene, funcionamiento de equipos y mobiliario antes de la asignación a un nuevo paciente.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-12'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-13
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para la identificación y etiquetado de sustancias químicas peligrosas en el hospital, incluyendo inventario, hojas de seguridad (MSDS/HDS) y señalización de almacenes.', 'Proceso para la identificación y etiquetado de sustancias químicas peligrosas en el hospital, incluyendo inventario, hojas de seguridad (MSDS/HDS) y señalización de almacenes.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-13'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-14
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso de recolección externa de residuos peligrosos del hospital por empresa autorizada, incluyendo programación, manifiestos de entrega, pesaje y resguardo de documentación.', 'Proceso de recolección externa de residuos peligrosos del hospital por empresa autorizada, incluyendo programación, manifiestos de entrega, pesaje y resguardo de documentación.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-14'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-15
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para la contratación y supervisión del mantenimiento preventivo externo de equipos o instalaciones del hospital, incluyendo solicitud de cotizaciones, orden de servicio y validación de trabajos.', 'Proceso para la contratación y supervisión del mantenimiento preventivo externo de equipos o instalaciones del hospital, incluyendo solicitud de cotizaciones, orden de servicio y validación de trabajos.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-15'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-16
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para la supervisión de obras de construcción y remodelación dentro del hospital, garantizando el cumplimiento de medidas de seguridad, señalización y protección a pacientes y personal.', 'Proceso para la supervisión de obras de construcción y remodelación dentro del hospital, garantizando el cumplimiento de medidas de seguridad, señalización y protección a pacientes y personal.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-16'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-17
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso de coordinación con empresas subrogadas para la realización de servicios externos en el hospital, estableciendo los criterios de selección, contratación, seguimiento y evaluación de desempeño.', 'Proceso de coordinación con empresas subrogadas para la realización de servicios externos en el hospital, estableciendo los criterios de selección, contratación, seguimiento y evaluación de desempeño.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-17'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-19
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para el traslado seguro de pacientes con COVID-19 dentro o desde las instalaciones del hospital, con medidas de aislamiento, EPP y protocolos de descontaminación.', 'Proceso para el traslado seguro de pacientes con COVID-19 dentro o desde las instalaciones del hospital, con medidas de aislamiento, EPP y protocolos de descontaminación.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-19'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-20
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para la coordinación de fumigación y control de plagas en las instalaciones del hospital, incluyendo programación, selección de empresa, supervisión de actividades y registro de evidencias.', 'Proceso para la coordinación de fumigación y control de plagas en las instalaciones del hospital, incluyendo programación, selección de empresa, supervisión de actividades y registro de evidencias.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-20'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-21
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso de monitoreo sistemático de los niveles de cloro en el agua potable de las instalaciones del hospital, con registros de medición, valores de referencia y acciones ante desviaciones.', 'Proceso de monitoreo sistemático de los niveles de cloro en el agua potable de las instalaciones del hospital, con registros de medición, valores de referencia y acciones ante desviaciones.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-21'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-22
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso de actuación del hospital ante una falla de energía eléctrica, estableciendo la activación del sistema de respaldo, notificaciones, responsabilidades y registro del evento.', 'Proceso de actuación del hospital ante una falla de energía eléctrica, estableciendo la activación del sistema de respaldo, notificaciones, responsabilidades y registro del evento.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-22'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-23
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para autorizar y controlar el ingreso de infantes o familiares a las habitaciones del hospital, estableciendo los criterios de edad, condición clínica del paciente y horarios permitidos.', 'Proceso para autorizar y controlar el ingreso de infantes o familiares a las habitaciones del hospital, estableciendo los criterios de edad, condición clínica del paciente y horarios permitidos.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-23'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: PR-SG-24
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Proceso para la selección y evaluación de prestadores de servicios externos del hospital, incluyendo criterios de calificación, documentación requerida, evaluación de desempeño y registro de proveedores.', 'Proceso para la selección y evaluación de prestadores de servicios externos del hospital, incluyendo criterios de calificación, documentación requerida, evaluación de desempeño y registro de proveedores.',
  '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb, '[]'::jsonb,
  '[]'::jsonb, '[]'::jsonb
FROM documents d WHERE d.code = 'PR-SG-24'
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
WHERE dp.code = 'SG'
ORDER BY d.code;
