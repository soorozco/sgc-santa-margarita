-- ============================================================
--  Laboratorio — Registro y contenido digital de documentos LA
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

-- Asegurarse que el departamento Laboratorio exista
INSERT INTO departments (code, name, is_active)
VALUES ('LA', 'Laboratorio', true)
ON CONFLICT (code) DO NOTHING;

-- ═══ REGISTRAR DOCUMENTOS ═══

-- IT-LA-06
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-LA-06', 'Instrucción de Trabajo para Procesar Test CK-MB/CtnI/Myo',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'LA'),
  '4', 'vigente', 'Jefatura de Servicio de Laboratorio',
  '2025-09-29',
  'QFB. Maria del Refugio Valadez Rivas', 'Jefatura de Servicio de Laboratorio',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. Maria de Jesus Garcia Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'LA')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-LA-08
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-LA-08', 'Instrucción de Trabajo para Procesar Test HBA1C',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'LA'),
  '4', 'vigente', 'Jefatura de Servicio de Laboratorio',
  '2025-09-29',
  'QFB. Maria del Refugio Valadez Rivas', 'Jefatura de Servicio de Laboratorio',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. Maria de Jesus Garcia Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'LA')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-LA-09
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-LA-09', 'Instrucción de Trabajo para Procesar Test NT-proBNP',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'LA'),
  '4', 'vigente', 'Jefatura de Servicio de Laboratorio',
  '2025-09-29',
  'QFB. Maria del Refugio Valadez Rivas', 'Jefatura de Servicio de Laboratorio',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. Maria de Jesus Garcia Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'LA')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-LA-10
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-LA-10', 'Instrucción de Trabajo para Procesar Test PCT',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'LA'),
  '4', 'vigente', 'Jefatura de Servicio de Laboratorio',
  '2025-09-29',
  'QFB. Maria del Refugio Valadez Rivas', 'Jefatura de Servicio de Laboratorio',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. Maria de Jesus Garcia Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'LA')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-LA-11
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-LA-11', 'Instrucción de Trabajo para Procesar Test Dímero D',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'LA'),
  '4', 'vigente', 'Jefatura de Servicio de Laboratorio',
  '2025-09-29',
  'QFB. Maria del Refugio Valadez Rivas', 'Jefatura de Servicio de Laboratorio',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. Maria de Jesus Garcia Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'LA')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-LA-13
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-LA-13', 'Instrucción de Trabajo para Recolección de Sangre Venosa',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'LA'),
  '4', 'vigente', 'Jefatura de Servicio de Laboratorio',
  '2025-09-29',
  'QFB. Maria del Refugio Valadez Rivas', 'Jefatura de Servicio de Laboratorio',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. Maria de Jesus Garcia Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'LA')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-LA-15
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-LA-15', 'Instrucción de Trabajo para Carga Automática de Cartuchos en el Equipo Vitros 250',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'LA'),
  '4', 'vigente', 'Jefatura de Servicio de Laboratorio',
  '2025-09-29',
  'QFB. Maria del Refugio Valadez Rivas', 'Jefatura de Servicio de Laboratorio',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. Maria de Jesus Garcia Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'LA')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-LA-20
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-LA-20', 'Instrucción de Trabajo para Detección de Dengue NS1 Ag – IgG e IgM Ac',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'LA'),
  '4', 'vigente', 'Jefatura de Servicio de Laboratorio',
  '2025-09-29',
  'QFB. Maria del Refugio Valadez Rivas', 'Jefatura de Servicio de Laboratorio',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. Maria de Jesus Garcia Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'LA')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-LA-29
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-LA-29', 'Instrucción de Trabajo para Toma de Muestra Nasofaríngea',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'LA'),
  '2', 'vigente', 'Jefatura de Servicio de Laboratorio',
  '2025-09-29',
  'QFB. Maria del Refugio Valadez Rivas', 'Jefatura de Servicio de Laboratorio',
  'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
  'Hna. Maria de Jesus Garcia Castro',  'Dirección General'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'LA')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;

-- ═══ CARGAR CONTENIDO DIGITAL ═══

-- Contenido: IT-LA-06
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios, definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-LA-06'),
  'Este documento inicia cuando el médico tratante solicita la prueba de CK-MB/cTnI/Myo para ayudar en el diagnóstico clínico, el pronóstico y la evaluación de pacientes con lesión miocárdica como el IAM (infarto agudo al miocardio), ANGINA INESTABLE, MIOCARDITIS AGUDA y SICA (síndrome coronario agudo), y termina cuando se procesa.', 'Este documento inicia cuando el médico tratante solicita la prueba de CK-MB/cTnI/Myo para ayudar en el diagnóstico clínico, el pronóstico y la evaluación de pacientes con lesión miocárdica como el IAM (infarto agudo al miocardio), ANGINA INESTABLE, MIOCARDITIS AGUDA y SICA (síndrome coronario agudo), y termina cuando se procesa.',
  '["Guantes", "Cubrebocas", "Papel para impresora", "Bata", "Puntillas", "Pipeta de 100 µl", "Cartucho de prueba", "Tubo oro con suero de paciente", "GETEIN 1100"]'::jsonb, '[{"num": "3.1", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Procedimiento de la prueba: Recolectar la muestra en tubo oro, procurar no hemolizar la muestra."}, {"num": "3.2", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Confirme el número de lote de la tarjeta SD de acuerdo con el lote del kit de la prueba. Realice la calibración de Tarjeta SD cuando sea necesario."}, {"num": "3.3", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Retire la tarjeta de prueba de la bolsa sellada inmediatamente antes de usarla."}, {"num": "3.4", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Edite la información del paciente: Nombre, sexo, edad, ID, muestra, nombre del ítem, auto."}, {"num": "3.5", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Etiquetar la tarjeta de prueba con los 4 últimos dígitos del ID del paciente."}, {"num": "3.6", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Coloque la tarjeta de prueba en la meseta limpia, colocada horizontalmente."}, {"num": "3.7", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Pipetear 100 µl de muestra (Suero)."}, {"num": "3.8", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Coloque 100 µl de muestra en el orificio de muestra de la tarjeta de prueba."}, {"num": "3.9", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Inserte la tarjeta de prueba en el Getein 1100 con la flecha apuntando hacia el equipo y presione el botón Comenzar."}, {"num": "3.10", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Una vez transcurridos los 15 minutos de reacción el resultado se mostrará en la pantalla e imprimirá automáticamente."}, {"num": "3.11", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Reportar en el sistema Eclipse."}, {"num": "3.12", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Registro en Bitácora de Resultados de Análisis de Hematología FT-LA-01."}]'::jsonb, '[{"riesgo": "Muestra hemolizada", "barrera": "Tomar la muestra adecuadamente evitando hacer mucha presión al momento de la toma."}, {"riesgo": "Muestra insuficiente", "barrera": "Tomar al paciente la muestra llenando el tubo hasta la marca."}, {"riesgo": "Reactivo caducado", "barrera": "Revisar la caducidad del reactivo antes de usarlo y llevar el inventario al día."}]'::jsonb,
  '[{"nombre": "Inserto de CK-MB/cTnI/Myo Fast Test Kit (Immunofluorescence Assay)", "codigo": "No Aplica"}, {"nombre": "Registro en Bitácora de Resultados de Análisis de Hematología", "codigo": "FT-LA-01"}]'::jsonb, '[{"version": "01", "fecha": "09/2019", "descripcion": "Alta", "realizado": "QFB. Eloísa González Beas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "09/2022", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "09/2023", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "09/2025", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb, '[]'::jsonb, '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-LA-06')
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-LA-08
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios, definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-LA-08'),
  'Este documento inicia cuando el médico tratante solicita la prueba de HbA1c para ayudar en la evaluación y control de pacientes diabéticos, y termina cuando se procesa.', 'Este documento inicia cuando el médico tratante solicita la prueba de HbA1c para ayudar en la evaluación y control de pacientes diabéticos, y termina cuando se procesa.',
  '["Guantes", "Cubrebocas", "Papel para impresora", "Bata", "Puntillas", "Pipeta de 100 µl", "Cartucho de prueba", "Diluyente", "Tubo lila con sangre total de paciente", "GETEIN 1100"]'::jsonb, '[{"num": "3.1", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Procedimiento de la prueba: Recolectar la muestra en tubo lila, procurar no hemolizar la muestra."}, {"num": "3.2", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Lleve a temperatura ambiente el diluyente que se utilizará para la prueba (aproximadamente 15 minutos)."}, {"num": "3.3", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Confirme el número de lote de la tarjeta SD de acuerdo con el lote del kit de la prueba. Realice la calibración de Tarjeta SD cuando sea necesario."}, {"num": "3.4", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Retire la tarjeta de prueba de la bolsa sellada inmediatamente antes de usarla."}, {"num": "3.5", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Edite la información del paciente: Nombre, sexo, edad, ID, muestra, nombre del ítem, auto."}, {"num": "3.6", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Etiquetar la tarjeta de prueba con los 4 últimos dígitos del ID del paciente."}, {"num": "3.7", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Coloque la tarjeta de prueba en la meseta limpia, colocada horizontalmente."}, {"num": "3.8", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Pipetear 10 µl de muestra (sangre total), limpiar el excedente de sangre con una gasa y depositar en el diluyente, homogenizar y tomar 100 µl de la mezcla."}, {"num": "3.9", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Coloque 100 µl de la mezcla en el orificio de muestra de la tarjeta de prueba."}, {"num": "3.10", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Inserte la tarjeta de prueba en el Getein 1100 con la flecha apuntando hacia el equipo y presione el botón Comenzar."}, {"num": "3.11", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Una vez transcurridos los 5 minutos de reacción el resultado se mostrará en la pantalla e imprimirá automáticamente."}, {"num": "3.12", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Reportar en el sistema Eclipse."}, {"num": "3.13", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Registro en Bitácora de Resultados de Análisis de Hematología FT-LA-01."}]'::jsonb, '[{"riesgo": "Muestra hemolizada", "barrera": "Tomar la muestra adecuadamente evitando hacer mucha presión al momento de la toma."}, {"riesgo": "Muestra insuficiente", "barrera": "Tomar al paciente la muestra llenando el tubo hasta la marca."}, {"riesgo": "Reactivo caducado", "barrera": "Revisar la caducidad del reactivo antes de usarlo y llevar el inventario al día."}]'::jsonb,
  '[{"nombre": "Inserto de HbA1c Fast Test Kit (Immunofluorescence Assay)", "codigo": "No Aplica"}, {"nombre": "Registro en Bitácora de Resultados de Análisis de Hematología", "codigo": "FT-LA-01"}]'::jsonb, '[{"version": "01", "fecha": "09/2019", "descripcion": "Alta", "realizado": "QFB. Eloísa González Beas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "09/2022", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "09/2023", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "29/08/2025", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb, '[]'::jsonb, '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-LA-08')
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-LA-09
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios, definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-LA-09'),
  'Este documento inicia cuando el médico tratante solicita la prueba de NT pro-BNP para ayudar en el diagnóstico clínico, el pronóstico y la evaluación de la insuficiencia cardiaca (IC), y termina cuando se procesa.', 'Este documento inicia cuando el médico tratante solicita la prueba de NT pro-BNP para ayudar en el diagnóstico clínico, el pronóstico y la evaluación de la insuficiencia cardiaca (IC), y termina cuando se procesa.',
  '["Guantes", "Cubrebocas", "Papel para impresora", "Bata", "Puntillas", "Pipeta de 100 µl", "Cartucho de prueba", "Tubo oro con suero de paciente", "GETEIN 1100"]'::jsonb, '[{"num": "3.1", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Procedimiento de la prueba: Recolectar la muestra en tubo oro, procurar no hemolizar la muestra."}, {"num": "3.2", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Confirme el número de lote de la tarjeta SD de acuerdo con el lote del kit de la prueba. Realice la calibración de Tarjeta SD cuando sea necesario."}, {"num": "3.3", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Retire la tarjeta de prueba de la bolsa sellada inmediatamente antes de usarla."}, {"num": "3.4", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Edite la información del paciente: Nombre, sexo, edad, ID, muestra, nombre del ítem, auto."}, {"num": "3.5", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Etiquetar la tarjeta de prueba con los 4 últimos dígitos del ID del paciente."}, {"num": "3.6", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Coloque la tarjeta de prueba en la meseta limpia, colocada horizontalmente."}, {"num": "3.7", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Pipetear 100 µl de muestra (Suero)."}, {"num": "3.8", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Coloque 100 µl de la mezcla de muestra en el orificio de muestra de la tarjeta de prueba."}, {"num": "3.9", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Inserte la tarjeta de prueba en el Getein 1100 con la flecha apuntando hacia el equipo y presione el botón Comenzar."}, {"num": "3.10", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Una vez transcurridos los 10 minutos de reacción el resultado se mostrará en la pantalla e imprimirá automáticamente."}, {"num": "3.11", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Reportar en el sistema Eclipse."}, {"num": "3.12", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Registro en Bitácora de Resultados de Análisis de Hematología FT-LA-01."}]'::jsonb, '[{"riesgo": "Muestra hemolizada", "barrera": "Tomar la muestra adecuadamente evitando hacer mucha presión al momento de la toma."}, {"riesgo": "Muestra insuficiente", "barrera": "Tomar al paciente la muestra llenando el tubo hasta la marca."}, {"riesgo": "Reactivo caducado", "barrera": "Revisar la caducidad del reactivo antes de usarlo y llevar el inventario al día."}]'::jsonb,
  '[{"nombre": "Inserto de NT-proBNP Fast Test Kit (Immunofluorescence Assay)", "codigo": "No Aplica"}, {"nombre": "Registro en Bitácora de Resultados de Análisis de Hematología", "codigo": "FT-LA-01"}]'::jsonb, '[{"version": "01", "fecha": "09/2019", "descripcion": "Alta", "realizado": "QFB. Eloísa González Beas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "09/2022", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "09/2023", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "29/08/2025", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb, '[]'::jsonb, '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-LA-09')
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-LA-10
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios, definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-LA-10'),
  'Este documento inicia cuando el médico tratante solicita la prueba de PCT para ayudar en la evaluación de pacientes con sospecha de infección bacteriana, trauma o shock, y termina cuando se procesa.', 'Este documento inicia cuando el médico tratante solicita la prueba de PCT para ayudar en la evaluación de pacientes con sospecha de infección bacteriana, trauma o shock, y termina cuando se procesa.',
  '["Guantes", "Cubrebocas", "Papel para impresora", "Bata", "Puntillas", "Pipeta de 100 µl", "Cartucho de prueba", "Tubo oro con suero de paciente", "GETEIN 1100"]'::jsonb, '[{"num": "3.1", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Procedimiento de la prueba: Recolectar la muestra en tubo oro, procurar no hemolizar la muestra."}, {"num": "3.2", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Confirme el número de lote de la tarjeta SD de acuerdo con el lote del kit de la prueba. Realice la calibración de Tarjeta SD cuando sea necesario."}, {"num": "3.3", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Retire la tarjeta de prueba de la bolsa sellada inmediatamente antes de usarla."}, {"num": "3.4", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Edite la información del paciente: Nombre, sexo, edad, ID, muestra, nombre del ítem, auto."}, {"num": "3.5", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Etiquetar la tarjeta de prueba con los 4 últimos dígitos del ID del paciente."}, {"num": "3.6", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Coloque la tarjeta de prueba en la meseta limpia, colocada horizontalmente."}, {"num": "3.7", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Pipetear 100 µl de muestra (Suero)."}, {"num": "3.8", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Coloque 100 µl de la mezcla de muestra en el orificio de muestra de la tarjeta de prueba."}, {"num": "3.9", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Inserte la tarjeta de prueba en el Getein 1100 con la flecha apuntando hacia el equipo y presione el botón Comenzar."}, {"num": "3.10", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Una vez transcurridos los 15 minutos de reacción el resultado se mostrará en la pantalla e imprimirá automáticamente."}, {"num": "3.11", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Reportar en el sistema Eclipse."}, {"num": "3.12", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Registro en Bitácora de Resultados de Análisis de Hematología FT-LA-01."}]'::jsonb, '[{"riesgo": "Muestra hemolizada", "barrera": "Tomar la muestra adecuadamente evitando hacer mucha presión al momento de la toma."}, {"riesgo": "Muestra insuficiente", "barrera": "Tomar al paciente la muestra llenando el tubo hasta la marca."}, {"riesgo": "Reactivo caducado", "barrera": "Revisar la caducidad del reactivo antes de usarlo y llevar el inventario al día."}]'::jsonb,
  '[{"nombre": "Inserto de PCT Fast Test Kit (Immunofluorescence Assay)", "codigo": "No Aplica"}, {"nombre": "Registro en Bitácora de Resultados de Análisis de Hematología", "codigo": "FT-LA-01"}]'::jsonb, '[{"version": "01", "fecha": "09/2019", "descripcion": "Alta", "realizado": "QFB. Eloísa González Beas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "09/2022", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "09/2023", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "09/2025", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb, '[]'::jsonb, '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-LA-10')
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-LA-11
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios, definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-LA-11'),
  'Este documento inicia cuando el médico tratante solicita la prueba de Dímero D para ayudar a la evaluación de pacientes con sospecha de trombosis venosa profunda o embolia pulmonar, y termina cuando se procesa.', 'Este documento inicia cuando el médico tratante solicita la prueba de Dímero D para ayudar a la evaluación de pacientes con sospecha de trombosis venosa profunda o embolia pulmonar, y termina cuando se procesa.',
  '["Guantes", "Cubrebocas", "Papel para impresora", "Bata", "Puntillas", "Pipeta de 100 µl", "Cartucho de prueba", "Diluyente", "Tubo azul con plasma de paciente", "GETEIN 1100"]'::jsonb, '[{"num": "3.1", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Procedimiento de la prueba: Recolectar la muestra en tubo con citrato de sodio, procurar no hemolizar la muestra."}, {"num": "3.2", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Lleve a temperatura ambiente el diluyente que se utilizará para la prueba (aproximadamente 15 minutos)."}, {"num": "3.3", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Confirme el número de lote de la tarjeta SD de acuerdo con el lote del kit de la prueba. Realice la calibración de Tarjeta SD cuando sea necesario."}, {"num": "3.4", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Retire la tarjeta de prueba de la bolsa sellada inmediatamente antes de usarla."}, {"num": "3.5", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Edite la información del paciente: Nombre, sexo, edad, ID, muestra, nombre del ítem, auto."}, {"num": "3.6", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Etiquetar la tarjeta de prueba con los 4 últimos dígitos del ID del paciente."}, {"num": "3.7", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Coloque la tarjeta de prueba en la meseta limpia, colocada horizontalmente."}, {"num": "3.8", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Pipetear 100 µl de muestra y depositarlos en un tubo de diluyente, mezcle con cuidado. Homogenice la mezcla antes de depositarla en la tarjeta."}, {"num": "3.9", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Coloque 100 µl de la mezcla de muestra en el orificio de muestra de la tarjeta de prueba."}, {"num": "3.10", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Inserte la tarjeta de prueba en el Getein 1100 con la flecha apuntando hacia el equipo y presione el botón Comenzar."}, {"num": "3.11", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Una vez transcurridos los 10 minutos de reacción el resultado se mostrará en la pantalla e imprimirá automáticamente."}, {"num": "3.12", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Reportar en el sistema Eclipse."}, {"num": "3.13", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Registro en Bitácora de Resultados de Análisis de Hematología FT-LA-01."}]'::jsonb, '[{"riesgo": "Muestra hemolizada", "barrera": "Tomar la muestra adecuadamente evitando hacer mucha presión al momento de la toma."}, {"riesgo": "Muestra insuficiente", "barrera": "Tomar al paciente la muestra llenando el tubo hasta la marca."}, {"riesgo": "Reactivo caducado", "barrera": "Revisar la caducidad del reactivo antes de usarlo y llevar el inventario al día."}]'::jsonb,
  '[{"nombre": "Inserto de Dímero D Fast Test Kit (Immunofluorescence Assay)", "codigo": "No Aplica"}, {"nombre": "Registro en Bitácora de Resultados de Análisis de Hematología", "codigo": "FT-LA-01"}]'::jsonb, '[{"version": "01", "fecha": "09/2019", "descripcion": "Alta", "realizado": "QFB. Eloísa González Beas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "09/2022", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "09/2023", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "09/2025", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb, '[]'::jsonb, '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-LA-11')
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-LA-13
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios, definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-LA-13'),
  'Este documento inicia cuando el médico tratante o el paciente por su cuenta solicita exámenes de laboratorio con muestras de sangre venosa, y termina cuando se realiza la toma.', 'Este documento inicia cuando el médico tratante o el paciente por su cuenta solicita exámenes de laboratorio con muestras de sangre venosa, y termina cuando se realiza la toma.',
  '["Guantes desechables", "Cubrebocas", "Bata", "Jeringas 3,5 y 10 mL", "Holder", "Aguja Naranja, Azul, Negra", "Aguja para vacutainer negra y verde", "Tubos Oro, lila, azul, rojo, verde", "Microtainer Oro, lila, azul", "Parches", "Torundas", "Torniquete", "Cinta micropore", "Contenedor Punzocortantes", "Marcador negro", "Anticoagulante para tubo lila EDTA K2", "Anticoagulante para tubo azul de Citrato de Sodio", "Anticoagulante para tubo verde Heparina de Sodio", "Gel separador para tubo oro", "Activador de coagulación con silicón para tubo rojo"]'::jsonb, '[{"num": "3.1", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Revisar en el expediente las indicaciones de exámenes de laboratorio indicados del día en curso por el médico tratante o en su caso por el médico de guardia."}, {"num": "3.2", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Realizar la solicitud de análisis anotando los siguientes datos: Nombre completo del paciente, Fecha de nacimiento, Diagnóstico, Habitación, Médico tratante, Anotar si es particular o de aseguradora, Laboratoriales solicitados, Fecha de la toma, Hora de la toma."}, {"num": "3.3", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Registrar a un lado de los análisis solicitados lo siguiente: Laboratorio, Nombre del químico que realizó la toma, Fecha en que se realizó la toma y la hora."}, {"num": "3.4", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Realizar su lavado de manos aplicando los 5 momentos."}, {"num": "3.5", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Identificar al paciente por su nombre completo y fecha de nacimiento."}, {"num": "3.6", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Seleccione el equipo apropiado para la recolección de las diferentes pruebas solicitadas."}, {"num": "3.7", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Etiquete los tubos con el nombre del paciente de la sangre recolectada. Nota: Del punto 1 al 7 se deberá realizar en cualquier tipo de muestra que se vaya a tomar."}, {"num": "3.8", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Asegúrese que la venopunción no dure mucho tiempo. La posición del paciente es con el codo extendido y brazo recargado. Haga que el paciente cierre el puño pero evite el ejercicio mano vigoroso (\"bombeo\")."}, {"num": "3.9", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Aplique el torniquete de 3-4 pulgadas arriba del sitio de venopunción. No parar el flujo de sangre por más de un minuto antes de que la sangre sea extraída. Si es necesario, quite y vuelva a poner el torniquete."}, {"num": "3.10", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Seleccione el sitio de la venopunción. Las venas medias antecubital y cefálica son las más comúnmente usadas."}, {"num": "3.11", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Limpie el sitio de venopunción con una torunda con alcohol, haciendo un barrido suave en círculo del centro a la periferia. Deje secar la piel para prevenir hemólisis. No toque el sitio de la vena después de limpiarlo."}, {"num": "3.12", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "ÁREAS A EVITAR: Áreas cicatrizadas como quemaduras; Venas esclerosadas; Áreas golpeadas (extraiga del sitio más alejado del área golpeada); En pacientes canalizados tomar las muestras del otro brazo."}, {"num": "3.13", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Efectuar la venopunción: Usando guantes, tome cuidadosamente el brazo del paciente cerca del sitio de la venopunción, usando el pulgar para estirar la piel."}, {"num": "3.14", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Con el bisel de la aguja hacia arriba, alinee la aguja con la vena. Penetre la piel y entre en vena con un ángulo de 15 a 30 grados. Empuje el tubo al vacío hacia delante para unir el vacío a la vena."}, {"num": "3.15", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Cuando la sangre empiece a fluir en el tubo, quite el torniquete y abra el puño del paciente para evitar sangrado en el sitio de punción."}, {"num": "3.16", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Mantenga constante la presión hacia delante en el tubo para evitar que la válvula de cerrado suspenda el flujo de sangre."}, {"num": "3.17", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Si la muestra de sangre no puede ser obtenida, cambie la posición de la aguja. Puede ser necesario intentar con otra aguja."}, {"num": "3.18", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Recolecta la muestra en el orden necesario: Tubo tapón rojo o amarillo, Tubo tapón azul, Tubo tapón lila, Tubo tapón verde. Llenar de acuerdo a la marca indicada en cada tubo."}, {"num": "3.19", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Suavemente remueva la aguja y aplique una torunda con alcohol presionando el sitio de venopunción. Asegúrese que el flujo de sangre ha parado y aplique una vendita."}, {"num": "3.20", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Suavemente invierta los tubos que contengan anticoagulante o activadores (EDTA, citrato de sodio, etc.) de 5 a 10 veces. No mezcle vigorosamente porque esto dañará las células de la sangre y generará errores en los resultados."}, {"num": "3.21", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Coloque las agujas en el contenedor de punzocortantes. Coloque los guantes en basura común; si hubo contacto con líquidos corporales desecharlos en bolsa roja."}, {"num": "3.22", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Lave sus manos."}]'::jsonb, '[{"riesgo": "Mal llenado de tubo", "barrera": "Tomar la muestra adecuadamente, cada tubo tiene su afore."}, {"riesgo": "No homogeneizar tubo", "barrera": "Hacer el correcto movimiento y en las veces recomendadas."}, {"riesgo": "Mezclado vigoroso", "barrera": "El mezclado debe ser lento y en un solo sentido."}]'::jsonb,
  '[{"nombre": "Orden de toma para la recolección de sangre venosa CLSI (Instituto de Normas Clínicas y de Laboratorio)", "codigo": "No Aplica"}, {"nombre": "Registro en Bitácora de Resultados de Análisis de Hematología", "codigo": "FT-LA-01"}]'::jsonb, '[{"version": "01", "fecha": "09/2019", "descripcion": "Alta", "realizado": "QFB. Eloísa González Beas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "09/2022", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "09/2023", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "09/2025", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb, '[]'::jsonb, '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-LA-13')
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-LA-15
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios, definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-LA-15'),
  'Este documento inicia cuando se requiere cargar cartuchos al equipo Vitros 250, y termina cuando se insertan los cartuchos.', 'Este documento inicia cuando se requiere cargar cartuchos al equipo Vitros 250, y termina cuando se insertan los cartuchos.',
  '["Guantes desechables", "Cubrebocas", "Bata", "Reactivos Tambor SS1: TP, TRIG, CL-, CA, BuBc, LIPA, URIC, CHOL, TBIL, K+, PHOS, Mg, PCR, ALB, AMYL, Na+, BUN", "Reactivos Tambor SS2: GLU, CREA, ALTV, GGT, AST, LDHI, PROT, AMON, ALKP, CK, CK-MB, UPRO", "Refrigerador", "Vitros 250"]'::jsonb, '[{"num": "3.1", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Revisar el inventario de slides en el menú principal del equipo dando clic en Manejo de cartuchos, después seleccionar Inventario de slides."}, {"num": "3.2", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Saque los cartuchos requeridos de su lugar de almacenamiento (refrigerador o congelador)."}, {"num": "3.3", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Con el cartucho aún en el envoltorio, espere a que alcance la temperatura ambiente 18-28°C (30 minutos si estaba en refrigerador, 60 minutos si estaba en congelador). El tiempo mínimo de calentamiento para Sodio (Na+) es de 2 horas."}, {"num": "3.4", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Desenvolver el cartucho y observe el color de la etiqueta para identificar la estación correcta: Alimentador 1 (derecha) etiqueta amarilla, Alimentador 2 (izquierda) etiqueta blanca."}, {"num": "3.5", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Con un movimiento suave y continuo inserte firmemente el cartucho en la estación de carga hasta que tope."}, {"num": "3.6", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "La unidad de control emitirá una señal sonora que indica que el cartucho fue aceptado. Si no escucha esa señal, el cartucho puede no estar orientado correctamente o el lector de códigos de barras no leyó la etiqueta. Si persiste, trate de cargar el cartucho manualmente."}, {"num": "3.7", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "El analizador cargará el cartucho tan pronto como se disponga de un pozo vacío y cuando la carga no interfiera con el proceso de la laminilla reactiva que se analiza en ese momento."}, {"num": "3.8", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Nota: Si la generación de laminillas reactivas por cargar es distinta de las que están en el analizador, aparecerá el mensaje ''Carga cancelada''. Seguir el diálogo de carga de nueva generación en ese momento."}]'::jsonb, '[{"riesgo": "Carga errónea de cartucho (tambor no correspondiente)", "barrera": "Verifique el cartucho antes de cargarlo en el analizador."}, {"riesgo": "Carga de cartucho nueva generación", "barrera": "Revisar que sea la misma generación que está cargada."}, {"riesgo": "No atemperar lo suficiente el cartucho antes de ingresarlo al analizador", "barrera": "No saltar el tiempo atemperado."}]'::jsonb,
  '[{"nombre": "Manual del equipo Vitros 250 Ortho Clinical Diagnostics J&J", "codigo": "No Aplica"}]'::jsonb, '[{"version": "01", "fecha": "09/2019", "descripcion": "Alta", "realizado": "QFB. Eloísa González Beas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "09/2022", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "09/2023", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "09/2025", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb, '[]'::jsonb, '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-LA-15')
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-LA-20
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios, definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-LA-20'),
  'Este documento inicia cuando el médico solicita prueba rápida para Dengue NS1 cuando el paciente presenta la sintomatología característica de esta patología, y termina cuando se procesa.', 'Este documento inicia cuando el médico solicita prueba rápida para Dengue NS1 cuando el paciente presenta la sintomatología característica de esta patología, y termina cuando se procesa.',
  '["Guantes desechables", "Cubrebocas", "Dispositivo de prueba", "Pipeta capilar", "Gotero desechable", "Diluyente del ensayo", "Centrífuga", "Cronómetro"]'::jsonb, '[{"num": "3.1", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Abra el envase y verifique el contenido: Dispositivo de prueba con desecantes (indicador de humedad) en bolsa de papel aluminio individual, Diluyente del ensayo, Gotero desechable, Pipeta capilar, Instrucciones de uso."}, {"num": "3.2", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Compruebe la fecha de caducidad en la parte posterior de la bolsa de papel aluminio. Si la fecha de caducidad ha vencido utilice otro lote."}, {"num": "3.3", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Abra la bolsa de papel aluminio y localice: Pocillo para muestra Dengue IgG e IgM, Pocillo del diluyente de ensayo, Pocillo para muestra Dengue NS1, Indicador de humedad. Nota: Indicador AMARILLO = continúe; Indicador VERDE = deseche el dispositivo y obtenga otro."}, {"num": "3.4", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Obtención de la muestra: Por venopunción (no usar sangre capilar), plasma o suero. Tome un gotero y recoja la muestra (suero) por encima de la línea de llenado mínimo."}, {"num": "3.5", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Dispense 3 gotas (cerca de 100 µl aprox) de la muestra en el pocillo para muestras ''S''."}, {"num": "3.6", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Con una nueva pipeta capilar desechable, recoja suero hasta la línea de llenado (10 µl). Dispense 10 µl de la muestra en el pocillo ''S''. Precaución: No usar muestras hemolizadas o almacenadas más de 24 horas."}, {"num": "3.7", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Inmediatamente (en un plazo de 20 segundos) dispense 4 gotas de diluyente de ensayo verticalmente en el pocillo de diluyente del ensayo, sosteniendo el frasco en posición vertical."}, {"num": "3.8", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Interprete los resultados de la prueba después de 15 a 20 minutos. Nota: Los resultados leídos después de los 20 minutos pueden ser imprecisos."}, {"num": "3.9", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Reportar en Bitácora de registro de resultados de análisis Química Clínica FT-LA-13."}, {"num": "3.10", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Reportar resultado en sistema Eclipse."}, {"num": "3.11", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "En caso de resultado positivo y el paciente sea hospitalizado, informar al área de Epidemiología."}]'::jsonb, '[{"riesgo": "Carga errónea de cartucho (tambor no correspondiente)", "barrera": "Verifique el cartucho antes de cargarlo en el analizador."}, {"riesgo": "Carga de cartucho nueva generación", "barrera": "Revisar que sea la misma generación que está cargada."}, {"riesgo": "No atemperar lo suficiente el cartucho antes de ingresarlo al analizador", "barrera": "No saltar el tiempo atemperado."}]'::jsonb,
  '[{"nombre": "Inserto en uso de Test Dengue NS1-IgG/IgM", "codigo": "No Aplica"}, {"nombre": "Bitácora de registro de resultados de análisis Química Clínica", "codigo": "FT-LA-13"}]'::jsonb, '[{"version": "01", "fecha": "09/2019", "descripcion": "Alta", "realizado": "QFB. Eloísa González Beas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "09/2022", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "09/2023", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "09/2025", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb, '[]'::jsonb, '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-LA-20')
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-LA-29
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios, definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-LA-29'),
  'Este documento inicia cuando el médico tratante o el paciente por su cuenta solicita exámenes de laboratorio con muestras de región nasofaríngea, y termina cuando se realiza la toma.', 'Este documento inicia cuando el médico tratante o el paciente por su cuenta solicita exámenes de laboratorio con muestras de región nasofaríngea, y termina cuando se realiza la toma.',
  '["Guantes desechables", "Cubrebocas", "Bata", "Hisopo", "Tubo para recolección", "Buffer"]'::jsonb, '[{"num": "3.1", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Revisar en el expediente las indicaciones de exámenes de laboratorio del día en curso por el médico tratante o médico de guardia. Si el paciente es externo, revisar la orden que expide su médico tratante."}, {"num": "3.2", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Realizar la solicitud de análisis anotando: Nombre completo del paciente, Fecha de nacimiento, Diagnóstico, Habitación, Médico tratante, Anotar si es particular o de aseguradora, Laboratoriales solicitados, Fecha de la toma."}, {"num": "3.3", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Realizar su lavado de manos aplicando los 5 momentos."}, {"num": "3.4", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Identificar al paciente por su nombre completo y fecha de nacimiento."}, {"num": "3.5", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Etiquete el tubo con el nombre del paciente de la muestra recolectada."}, {"num": "3.6", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Explicar al paciente el proceso de la toma, pedir que cubra solo su boca con el cubrebocas."}, {"num": "3.7", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "La cabeza del paciente tiene que estar ligeramente inclinada hacia atrás para que la toma sea adecuada y lo menos lastimosa posible."}, {"num": "3.8", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Introducir el hisopo en cada una de las fosas nasales, hasta la nasofaringe, aprox 3-4 cm."}, {"num": "3.9", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Girar el hisopo hacia el lado externo de cada fosa de 2-3 veces y retirarlo."}, {"num": "3.10", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Introducir el hisopo en el tubo de recolección previamente identificado, con el buffer apropiado para el tipo de prueba requerida."}, {"num": "3.11", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Dispensar la cantidad de buffer o diluyente (según la prueba) con muestra que cada prueba requiera y dejar correr la prueba en el tiempo requerido."}, {"num": "3.12", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Desechar todo el material utilizado en el destino de RPBI correspondiente."}, {"num": "3.13", "responsable": "Químico laboratorista y/o Técnico laboratorista", "actividad": "Lave sus manos."}]'::jsonb, '[{"riesgo": "Contagio por medio de expulsión de secreción del paciente", "barrera": "Usar el equipo de protección todo el tiempo requerido en el proceso de toma."}, {"riesgo": "Obtención de muestra no adecuada por cantidad", "barrera": "El hisopado es efectivo cuando se realiza la toma de las dos fosas nasales."}, {"riesgo": "Obtención de mala muestra por hisopado no profundo", "barrera": "La toma debe ser profunda para poder obtener una muestra de mejor calidad."}]'::jsonb,
  '[{"nombre": "Bitácora de registro de resultados de análisis Química Clínica", "codigo": "FT-LA-13"}]'::jsonb, '[{"version": "01", "fecha": "09/2023", "descripcion": "Alta", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "29/09/2025", "descripcion": "Modificación", "realizado": "QFB. Maria del Refugio Valadez Rivas", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb, '[]'::jsonb, '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-LA-29')
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;

-- Verificación
SELECT d.code, d.name, dc.document_id IS NOT NULL AS tiene_contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code LIKE 'IT-LA%'
ORDER BY d.code;
