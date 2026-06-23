-- ============================================================
--  Médicos de Guardia — Registro y contenido digital de documentos MG
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

-- Asegurarse que el departamento Médicos de Guardia exista
INSERT INTO departments (code, name, is_active)
VALUES ('MG', 'Médicos de Guardia', true)
ON CONFLICT (code) DO NOTHING;

-- ═══ REGISTRAR DOCUMENTOS ═══

-- IT-MG-01
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-MG-01', 'Instrucción de Trabajo de Actualización de Censo y Entrega de Guardia por Turno',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'MG'),
  '1', 'vigente', 'Coordinador de Médicos de Guardia',
  '2026-05-05',
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'MG')
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

-- IT-MG-02
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-MG-02', 'Instrucción de Trabajo para Actualización de Indicaciones Médicas',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'MG'),
  '3', 'vigente', 'Coordinador de Médicos de Guardia',
  '2026-05-04',
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'MG')
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

-- IT-MG-03
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-MG-03', 'Instrucción de Trabajo para el Ingreso del Paciente',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'MG'),
  '2', 'vigente', 'Coordinador de Médicos de Guardia',
  '2026-05-03',
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'MG')
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

-- IT-MG-04
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-MG-04', 'Instrucción de Trabajo para el Pase de Visita',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'MG'),
  '3', 'vigente', 'Coordinador de Médicos de Guardia',
  '2026-05-03',
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'MG')
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

-- IT-MG-05
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-MG-05', 'Instrucción de Trabajo para Realizar Notas de Evolución',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'MG'),
  '3', 'vigente', 'Coordinador de Médicos de Guardia',
  '2026-05-03',
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'MG')
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

-- PR-MG-01
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-MG-01', 'Procedimiento para Colocación de Sondas o Retiro de Catéteres',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'MG'),
  '1', 'vigente', 'Coordinador de Médicos de Guardia',
  '2026-05-06',
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'MG')
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

-- PR-MG-02
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-MG-02', 'Procedimiento para Recepción de Indicaciones vía Telefónica',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'MG'),
  '2', 'vigente', 'Coordinador de Médicos de Guardia',
  '2026-05-06',
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'MG')
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

-- PR-MG-03
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'PR-MG-03', 'Procedimiento para Toma de Electrocardiograma',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments     WHERE code = 'MG'),
  '3', 'vigente', 'Coordinador de Médicos de Guardia',
  '2026-05-03',
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'MG')
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

-- Contenido: IT-MG-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo)
SELECT d.id,
  'Lograr una adecuada presentación del paciente y entrega de eventualidades.',
  NULL,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"item": "Equipo de cómputo"}, {"item": "Censo de Entrega de Guardia por piso"}]'::jsonb,
  '[{"no": "5.1", "responsable": "Médico de Guardia", "actividad": "Posterior a que realiza instrucción de pase de visita, edita o agrega al Censo de entrega de guardia de piso correspondiente la información pertinente de cada paciente."}, {"no": "5.2", "responsable": "Médico de Guardia", "actividad": "En el primer apartado \"PACIENTE/DX\" agrega nombre completo del paciente, edad, fecha de ingreso, nombre del médico tratante, diagnósticos, alergias y médicos interconsultantes."}, {"no": "5.3", "responsable": "Médico de Guardia", "actividad": "En el segundo apartado \"ESTADO ACTUAL\" especifica la sintomatología o eventualidades del paciente durante el turno, así como si es portador de algún dren o sonda."}, {"no": "5.4", "responsable": "Médico de Guardia", "actividad": "En el tercer apartado \"TX/EXTRAS\" especifica el tratamiento farmacológico que lleva el paciente con horario y las dosis únicas."}, {"no": "5.5", "responsable": "Médico de Guardia", "actividad": "En el cuarto apartado \"LABS\" coloca los resultados de laboratorio o cultivos del día."}, {"no": "5.6", "responsable": "Médico de Guardia", "actividad": "En el quinto apartado \"GABS\" coloca las interpretaciones de estudios de imagen, así como reportes de cateterismo, endoscopia o centesis."}, {"no": "5.7", "responsable": "Médico de Guardia", "actividad": "En el sexto apartado \"PENDIENTES\" anota los pendientes para el siguiente turno."}, {"no": "5.8", "responsable": "Médico de Guardia", "actividad": "Corrobora antes del término de su turno que el Censo está actualizado correctamente e imprime una copia."}, {"no": "5.9", "responsable": "Médico de Guardia", "actividad": "Le entrega la copia a su compañero del siguiente turno (en el cual puede realizar anotaciones) y se procede a realizar la entrega de pacientes."}, {"no": "5.10", "responsable": "Médico de Guardia", "actividad": "Si el paciente es de nuevo ingreso debe mencionar habitación, su nombre y edad y contar el motivo de ingreso, como se encuentra actualmente, tratamiento que se le inició y en caso de estudios mencionarlos."}, {"no": "5.11", "responsable": "Médico de Guardia", "actividad": "Si el paciente tiene varios días hospitalizado, se menciona habitación, nombre y edad en caso de agregar nuevo diagnóstico, estado actual, eventualidades, cambios en el tratamiento y estudios."}, {"no": "5.12", "responsable": "Médico de Guardia", "actividad": "Entrega paciente por paciente y resuelve dudas de su compañero. Al término de los pacientes, se termina la instrucción de trabajo."}]'::jsonb,
  '[{"riesgo": "Incorrecta anamnesis y exploración física.", "barrera": "Constante actualización en la correcta anamnesis y exploración física."}, {"riesgo": "Errores de transcripción al momento de copiar de un medio a otro.", "barrera": "Doble verificación a la transcripción de datos."}]'::jsonb,
  '[{"nombre": "Entrega de Guardia", "codigo": "FT-MG-01"}]'::jsonb,
  '[{"version": "1", "fecha": "05/05/2026", "descripcion": "Alta de documento", "realizado": "Dra. Daniela Hernández Alvarez", "aprobado": "Dr. Gonzalo Vázquez Camacho"}]'::jsonb,
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
FROM documents d WHERE d.code = 'IT-MG-01'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios,
  elaborado_por=EXCLUDED.elaborado_por, cargo_elaboro=EXCLUDED.cargo_elaboro,
  revisado_por=EXCLUDED.revisado_por, cargo_reviso=EXCLUDED.cargo_reviso,
  autorizado_por=EXCLUDED.autorizado_por, cargo_autorizo=EXCLUDED.cargo_autorizo;

-- Contenido: IT-MG-02
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo)
SELECT d.id,
  'Normalizar la actualización de la hoja de indicaciones médicas, por parte del equipo de médicos de guardia del turno nocturno, para evitar errores de transcripción/prescripción médica, sobre medicación, e interacciones medicamentosas.',
  NULL,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"item": "Equipo de cómputo"}, {"item": "Papelería"}, {"item": "Sistema MEDISIST"}]'::jsonb,
  '[{"no": "5.1", "responsable": "Médico de Guardia", "actividad": "Posterior a la recepción de guardia, y pase de visita completo en el área de hospitalización, procede a actualizar la hoja de indicaciones del día en curso, para el día siguiente."}, {"no": "5.2", "responsable": "Médico de Guardia", "actividad": "Con el formato de indicaciones médicas del día en curso ya sea en fotografía o en físico tomadas del expediente de enfermería, acude a la oficina de médicos, haciendo uso del equipo de cómputo asignado donde complementa en el MEDISIST las indicaciones médicas."}, {"no": "5.3", "responsable": "Médico de Guardia", "actividad": "El primer paso es la búsqueda correcta del paciente en el sistema, corroborando que los datos de la ficha de identificación correspondan con los datos de la hoja de indicaciones que se tiene."}, {"no": "5.4", "responsable": "Médico de Guardia", "actividad": "Una vez verificado los campos anteriores, se procede a la búsqueda de sellos de comunicación verbal para tenerlos presentes a la hora de la transcripción."}, {"no": "5.5", "responsable": "Médico de Guardia", "actividad": "Posterior a eso se inicia con la actualización o transcripción de las indicaciones comenzando con el apartado de DIETA indicando tipo de dieta, así como especificaciones en el apartado de \"comentarios\" en caso de que sea necesario."}, {"no": "5.6", "responsable": "Médico de Guardia", "actividad": "En el segundo apartado se agregarán CUIDADOS GENERALES, como son la toma de signos vitales, control estricto de líquidos, entre otros que el médico tratante especifique."}, {"no": "5.7", "responsable": "Médico de Guardia", "actividad": "En el tercer apartado se encuentran las SOLUCIONES donde se especifica la solución de base, las bombas de infusión, catéter heparinizado, o en su defecto sin vía; así como la cantidad, y el tiempo de duración de cada una."}, {"no": "5.8", "responsable": "Médico de Guardia", "actividad": "En el cuarto apartado se encuentran los MEDICAMENTOS el cual contendrá bajo las normas de prescripción médica, en primer lugar, el nombre del medicamento, la cantidad expresada en miligramos, gramos, unidades internacionales, etc. Posteriormente la presentación (tabletas, cápsulas, solución inyectable, etc.), continua con la vía de administración, para terminar con la periodicidad del medicamento. Realizando la comparación de la indicación, suspendiendo los medicamentos que ya no se encuentren prescritos."}, {"no": "5.9", "responsable": "Médico de Guardia", "actividad": "El quinto apartado corresponde a TERAPIA RESPIRATORIA, donde se transcribe la suplementación de oxígeno, fisioterapia pulmonar, necesidad de ventilación no invasiva. Agregando siempre los litros de oxígeno por minuto y la presentación de cómo se administra."}, {"no": "5.10", "responsable": "Médico de Guardia", "actividad": "En el sexto apartado se encuentra LABORATORIO, donde se integran los exámenes a solicitar, el horario en el que se deben de tomar. En caso de que se solicite transfusión o cruce sanguíneo por parte de banco de sangre se agrega en el apartado de laboratorio, siempre se especifica cantidad de paquetes, tipo de hemocomponente, y para cuanto tiempo se requiere la transfusión."}, {"no": "5.11", "responsable": "Médico de Guardia", "actividad": "Por último, en el séptimo apartado se encuentra IMAGENOLOGÍA; exámenes de gabinete siempre se deben de transcribir con el nombre claro y en caso de necesitar contraste la vía por la que se está administrando, en caso de que se solicite imagen de algún área específica, colocarlo en el apartado de comentarios."}, {"no": "5.12", "responsable": "Médico de Guardia", "actividad": "En caso de que médico tratante se comunique para dar indicación vía telefónica durante la transcripción de indicaciones nuevas, se realiza la instrucción de trabajo de recepción de indicaciones vía telefónica en las indicaciones anteriores y se transcriben en las nuevas."}, {"no": "5.13", "responsable": "Médico de Guardia", "actividad": "Una vez terminada la transcripción completa de indicaciones, se procede a imprimir, sellar y firmar las indicaciones en físico."}, {"no": "5.14", "responsable": "Médico de Guardia", "actividad": "Acude a las centrales de enfermería entre 00:00hrs y 01:00hrs para revisión de indicaciones, una por una. En caso de correcciones, acude a oficina a realizarlas pertinentemente."}, {"no": "5.15", "responsable": "Médico de Guardia", "actividad": "Al estar todas las indicaciones entregadas y correctas, se da por terminada la instrucción de actualización de indicaciones médicas."}]'::jsonb,
  '[{"riesgo": "Errores de transcripción al momento de recepción de información por vía telefónica.", "barrera": "Para evitar los errores de la comunicación efectiva se considera la acción esencial número dos, \"Comunicación efectiva\", la cual considera barreras como la doble verificación de la indicación verbal, la correcta recepción de indicaciones por vía telefónica."}, {"riesgo": "Errores de comunicación a través de canales no adecuados para la recepción de información.", "barrera": "Acción esencial número 2: Comunicación efectiva."}, {"riesgo": "Errores de transcripción al momento de la actualización del medio físico al medio digital.", "barrera": "Acción esencial número 2: Comunicación efectiva."}, {"riesgo": "Error de transcripción por letra no legible, o abreviaturas no permitidas.", "barrera": "Acción esencial número 2: Comunicación efectiva."}]'::jsonb,
  '[{"nombre": "Acciones esenciales para la seguridad del paciente. Acción esencial número 2: Comunicación efectiva.", "codigo": "NA"}, {"nombre": "http://www.calidad.salud.gob.mx/site/calidad/docs/acciones_esenciales.pdf", "codigo": "NA"}]'::jsonb,
  '[{"version": "1", "fecha": "06/06/2023", "descripcion": "Alta de documento", "realizado": "Dra. Elisa Nunila Villa Bernal", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "2", "fecha": "24/04/2024", "descripcion": "Actualización de documento", "realizado": "Dra. Elisa Nunila Villa Bernal", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "3", "fecha": "04/05/2026", "descripcion": "Actualización de documento", "realizado": "Dra. Daniela Hernández Alvarez", "aprobado": "Dr. Gonzalo Vázquez Camacho"}]'::jsonb,
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
FROM documents d WHERE d.code = 'IT-MG-02'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios,
  elaborado_por=EXCLUDED.elaborado_por, cargo_elaboro=EXCLUDED.cargo_elaboro,
  revisado_por=EXCLUDED.revisado_por, cargo_reviso=EXCLUDED.cargo_reviso,
  autorizado_por=EXCLUDED.autorizado_por, cargo_autorizo=EXCLUDED.cargo_autorizo;

-- Contenido: IT-MG-03
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo)
SELECT d.id,
  'Realizar historias clínicas y notas de ingreso, así como preparar al paciente en conjunto con enfermería para pasarlo a cirugía o procedimiento o iniciar tratamiento médico correspondiente.',
  NULL,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"item": "Bata clínica y credencial de identificación"}, {"item": "Medidas precautorias según el caso: cubrebocas, N95, gorro, guantes, bata de manga larga"}, {"item": "Estetoscopio, baumanómetro, oxímetro de pulso, estuche de diagnóstico"}, {"item": "Electrocardiograma"}, {"item": "Lámpara de exploración"}, {"item": "Equipo de cómputo y sistema MEDISIST"}]'::jsonb,
  '[{"no": "5.1", "responsable": "Médico de Guardia", "actividad": "Revisa constantemente grupo de difusión de WhatsApp, donde se anuncian los ingresos de pacientes a hospitalización. En caso de que el paciente anunciado no cuente con indicaciones es necesario comunicarse con el médico tratante para solicitarlas y se toman las indicaciones por medio de comunicación efectiva."}, {"no": "5.2", "responsable": "Médico de Guardia", "actividad": "Procede a proporcionar indicaciones médicas al personal pertinente ya sea admisión o enfermería en caso de que paciente no acuda con ellas, dadas por comunicación efectiva por el tratante."}, {"no": "5.3", "responsable": "Médico de Guardia", "actividad": "Si el ingreso no menciona \"corta estancia\" se acude inmediatamente al piso anunciado para la entrevista médico-paciente. Corta estancia no se realiza historia clínica ni nota de ingreso, a menos que su estancia en el hospital se prolongue por más de 8 horas."}, {"no": "5.4", "responsable": "Médico de Guardia", "actividad": "Revisa indicaciones que traiga el paciente o las que se hayan tomado en oficina vía telefónica, en caso de que haya un procedimiento por realizar (toma de EKG, colocación de sonda, cruce de paquete)."}, {"no": "5.5", "responsable": "Médico de Guardia", "actividad": "Procede a realizar instrucción de trabajo de pase de visita. Se solicita firma de consentimiento en caso de ser necesario."}, {"no": "5.6", "responsable": "Médico de Guardia", "actividad": "Se dirige a oficina de médicos de guardia donde se inicia sesión en el expediente electrónico, se busca por nombre al paciente y se realiza la nota en el apartado \"Historia clínica\" e \"Ingreso\"."}, {"no": "5.7", "responsable": "Médico de Guardia", "actividad": "Llena las notas con el formato SOAP (SUBJETIVO, OBJETIVO, ANÁLISIS, PLAN), así como padecimiento actual y antecedentes personales y heredofamiliares."}, {"no": "5.8", "responsable": "Médico de Guardia", "actividad": "Debe de registrar en el apartado de SUBJETIVO: patologías de base, el padecimiento y estado actual del paciente."}, {"no": "5.9", "responsable": "Médico de Guardia", "actividad": "Posteriormente en el apartado de OBJETIVO: colocar en el primer párrafo los hallazgos de la exploración física incluidos los signos vitales. En el segundo párrafo las pruebas de laboratorio o gabinete obtenidos de los sistemas hospitalarios."}, {"no": "5.10", "responsable": "Médico de Guardia", "actividad": "En el apartado del ANÁLISIS: incluye el resumen del paciente, sus posibles diagnósticos diferenciales y razonamiento clínico."}, {"no": "5.11", "responsable": "Médico de Guardia", "actividad": "En el apartado de PLAN debe de incluir la redacción para cada uno de los componentes (pruebas diagnósticas, plan terapéutico, educación para el paciente y seguimiento)."}, {"no": "5.12", "responsable": "Médico de Guardia", "actividad": "Coloca el pronóstico del paciente."}, {"no": "5.13", "responsable": "Médico de Guardia", "actividad": "Firma la nota con las credenciales virtuales proporcionadas por la unidad hospitalaria, imprime la nota, sella y firma."}, {"no": "5.14", "responsable": "Médico de Guardia", "actividad": "Se anexa la impresión al expediente clínico físico del paciente."}, {"no": "5.15", "responsable": "Médico de Guardia", "actividad": "Una vez realizada la historia clínica, nota de ingreso, completar el requerimiento de indicaciones médicas y llenado de consentimientos así requeridos, se da por terminado la actividad del ingreso."}]'::jsonb,
  '[{"riesgo": "Radiaciones ionizantes en traslado de pacientes para TAC o toma de radiografías portátiles.", "barrera": "Métodos de barrera y procedimiento de toma de estudios en el área de imagen."}, {"riesgo": "Choques contra objetos tras movilización del paciente.", "barrera": "Mecánica corporal y movimiento de pacientes."}, {"riesgo": "Caída de objetos tras manipulación y/o movilización del paciente.", "barrera": "Apoyo del servicio de camillería."}, {"riesgo": "Golpes por objetos o herramientas en la atención de los pacientes.", "barrera": "Procedimiento y uso correcto de materiales punzocortantes."}, {"riesgo": "Cortes o pinchazos por utensilios de canalización de pacientes.", "barrera": "Manejo y normativa de RPBI."}, {"riesgo": "Exposición a citostáticos.", "barrera": "Se brindan materiales de protección para cada uno de los procedimientos que el médico realice en las áreas."}, {"riesgo": "Dermatitis por contacto.", "barrera": "Se brinda capacitación y orientación específica al puesto para poder realizar los procedimientos dentro de un ámbito hospitalario."}, {"riesgo": "Infecciones de transmisión parenteral por pinchazo inadvertido (hepatitis B, C, VIH).", "barrera": "Materiales y equipo de protección necesario para el manejo de residuos biológicos, así como para la atención del paciente con potencial de infección."}, {"riesgo": "Infecciones de transmisión por gota (Tuberculosis, Influenza).", "barrera": "Materiales y equipo de protección necesario para la atención del paciente con potencial de infección."}, {"riesgo": "Incorrecta anamnesis y exploración física.", "barrera": "Constante actualización en la correcta anamnesis y exploración física."}, {"riesgo": "Errores de transcripción al momento de copiar de un medio a otro.", "barrera": "Doble verificación a la transcripción de datos."}]'::jsonb,
  '[{"nombre": "Norma Oficial Mexicana del expediente clínico", "codigo": "NOM-004-SSA3-2012"}]'::jsonb,
  '[{"version": "1", "fecha": "25/04/2024", "descripcion": "Alta de documento", "realizado": "Dra. Elisa Nunila Villa Bernal", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "2", "fecha": "03/05/2026", "descripcion": "Actualización de documento", "realizado": "Dra. Daniela Hernández Alvarez", "aprobado": "Dr. Gonzalo Vázquez Camacho"}]'::jsonb,
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
FROM documents d WHERE d.code = 'IT-MG-03'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios,
  elaborado_por=EXCLUDED.elaborado_por, cargo_elaboro=EXCLUDED.cargo_elaboro,
  revisado_por=EXCLUDED.revisado_por, cargo_reviso=EXCLUDED.cargo_reviso,
  autorizado_por=EXCLUDED.autorizado_por, cargo_autorizo=EXCLUDED.cargo_autorizo;

-- Contenido: IT-MG-04
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo)
SELECT d.id,
  'Estandarizar el pase de visita por parte del equipo médico de guardia con el objetivo de evitar omisiones y/o errores, asegurando así la buena práctica de las políticas internas de la institución.',
  NULL,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"item": "Bata clínica y credencial de identificación"}, {"item": "Medidas precautorias según el caso: cubrebocas, N95, gorro, guantes, bata de manga larga"}, {"item": "Estetoscopio, baumanómetro, oxímetro de pulso, estuche de diagnóstico"}, {"item": "Electrocardiograma"}, {"item": "Lámpara de exploración"}]'::jsonb,
  '[{"no": "5.1", "responsable": "Médico de Guardia", "actividad": "Posterior a registrar hora de entrada, debe de acudir al área de trabajo que ha sido asignado previamente, donde se encontrará con el médico en turno, para realizar el enlace inter-turno."}, {"no": "5.2", "responsable": "Médico de Guardia", "actividad": "Una vez terminado el enlace de turno, realizará un triage con base en la información obtenida en la entrega de guardia identificando a los pacientes que se encuentran más graves."}, {"no": "5.3", "responsable": "Médico de Guardia", "actividad": "El médico en turno inicia el pase de visita, con los pacientes que se encuentran más graves determinando así si ocupan estabilización inmediata."}, {"no": "5.4", "responsable": "Médico de Guardia", "actividad": "El médico ingresa a la habitación con un saludo cordial, además de presentarse con su nombre y primer apellido."}, {"no": "5.5", "responsable": "Médico de Guardia", "actividad": "Una vez que se encuentre dentro de la habitación, procede a realizar interrogatorio dirigido, además de identificación de datos clínicos que ayuden en el abordaje diagnóstico, mediante la exploración física."}, {"no": "5.6", "responsable": "Médico de Guardia", "actividad": "Si se detectan datos clínicos de gravedad debe de activar el código verde o azul según dependa el caso (Ver Procedimiento de activación de código verde o azul)."}, {"no": "5.7", "responsable": "Médico de Guardia", "actividad": "Se solicita firma de consentimiento en caso de ser necesario."}, {"no": "5.8", "responsable": "Médico de Guardia", "actividad": "Una vez que termine la exploración física y de por terminado el interrogatorio, se despide de manera cordial, reafirmando la relación médico-paciente."}, {"no": "5.9", "responsable": "Médico de Guardia", "actividad": "Acude a la oficina de médicos de guardia donde procede a colocar las eventualidades, cambio de indicaciones y estudios de gabinete nuevos en Censo de entrega de guardia por piso y da por concluido la instrucción de trabajo para el pase de visita."}]'::jsonb,
  '[{"riesgo": "Radiaciones ionizantes en traslado de pacientes para TAC o toma de radiografías portátiles.", "barrera": "Métodos de barrera y procedimiento de toma de estudios en el área de imagen."}, {"riesgo": "Choques contra objetos tras movilización del paciente.", "barrera": "Mecánica corporal y movimiento de pacientes."}, {"riesgo": "Caída de objetos tras manipulación y/o movilización del paciente.", "barrera": "Apoyo del servicio de camillería."}, {"riesgo": "Golpes por objetos o herramientas en la atención de los pacientes.", "barrera": "Procedimiento y uso correcto de materiales punzocortantes."}, {"riesgo": "Cortes o pinchazos por utensilios de canalización de pacientes.", "barrera": "Manejo y normativa de RPBI."}, {"riesgo": "Exposición a citostáticos.", "barrera": "Se brindan materiales de protección para cada uno de los procedimientos que el médico realice en las áreas."}, {"riesgo": "Dermatitis por contacto.", "barrera": "Se brinda capacitación y orientación específica al puesto para poder realizar los procedimientos dentro de un ámbito hospitalario."}, {"riesgo": "Infecciones de transmisión parenteral por pinchazo inadvertido (hepatitis B, C, VIH).", "barrera": "Materiales y equipo de protección necesario para el manejo de residuos biológicos, así como para la atención del paciente con potencial de infección."}, {"riesgo": "Infecciones de transmisión por gota (Tuberculosis, Influenza).", "barrera": "Materiales y equipo de protección necesario para la atención del paciente con potencial de infección."}, {"riesgo": "Relaciones personales y responsabilidades.", "barrera": "Se genera un adecuado ambiente de trabajo."}, {"riesgo": "Monotonía/Repetitividad en las actividades laborales.", "barrera": "Se realiza distribución equitativa del trabajo donde se cambia de área con periodicidad para evitar la ceguera de taller."}, {"riesgo": "Consecuencias nocivas: insatisfacción, estrés laboral, síndrome del burnout, acoso psicológico laboral.", "barrera": "Se realiza la correcta distribución de horarios para evitar la fatiga de un solo médico con disposición de guardias distribuidas de manera equitativa."}]'::jsonb,
  '[]'::jsonb,
  '[{"version": "1", "fecha": "18/03/2021", "descripcion": "Alta de documento", "realizado": "Dr. Daniel Robles Martin", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "2", "fecha": "24/04/2024", "descripcion": "Actualización de documento", "realizado": "Dra. Elisa Nunila Villa Bernal", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "3", "fecha": "03/05/2026", "descripcion": "Actualización de documento", "realizado": "Dra. Daniela Hernández Alvarez", "aprobado": "Dr. Gonzalo Vázquez Camacho"}]'::jsonb,
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
FROM documents d WHERE d.code = 'IT-MG-04'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios,
  elaborado_por=EXCLUDED.elaborado_por, cargo_elaboro=EXCLUDED.cargo_elaboro,
  revisado_por=EXCLUDED.revisado_por, cargo_reviso=EXCLUDED.cargo_reviso,
  autorizado_por=EXCLUDED.autorizado_por, cargo_autorizo=EXCLUDED.cargo_autorizo;

-- Contenido: IT-MG-05
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo)
SELECT d.id,
  'Objetivar la manera en la cual se registra la información recabada mediante el proceso de atención médico-paciente, de manera continua evitando los sesgos de información en el archivo clínico.',
  NULL,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"item": "Equipo de cómputo"}, {"item": "Sistema MEDISIST"}, {"item": "Estetoscopio, baumanómetro, oxímetro de pulso, estuche de diagnóstico"}, {"item": "Papelería"}]'::jsonb,
  '[{"no": "5.1", "responsable": "Médico de Guardia", "actividad": "Posterior a la entrega de guardia, el médico de guardia en turno procede a realizar la instrucción de pase de visita a los pacientes hospitalizados en su área de trabajo."}, {"no": "5.2", "responsable": "Médico de Guardia", "actividad": "Una vez concluido el pase de visita, el cual incluye la anamnesis y exploración física, se procede a verificar la continuidad de las indicaciones en cuanto a medicamentos (dosis y horarios) además de procedimientos."}, {"no": "5.3", "responsable": "Médico de Guardia", "actividad": "Procede a verificar la actualización de signos vitales en hoja de enfermería."}, {"no": "5.4", "responsable": "Médico de Guardia", "actividad": "Se dirige a oficina de médicos de guardia donde se inicia sesión en el expediente electrónico, se busca por nombre al paciente y se realizará la nota en el apartado \"Evolución\"."}, {"no": "5.5", "responsable": "Médico de Guardia", "actividad": "Llena la nota con el formato SOAP (SUBJETIVO, OBJETIVO, ANÁLISIS, PLAN)."}, {"no": "5.6", "responsable": "Médico de Guardia", "actividad": "Debe de registrar en el apartado de SUBJETIVO: patologías de base, el padecimiento y estado actual del paciente."}, {"no": "5.7", "responsable": "Médico de Guardia", "actividad": "Posteriormente en el apartado de OBJETIVO: colocar en el primer párrafo los hallazgos de la exploración física incluidos los signos vitales. En el segundo párrafo las pruebas de laboratorio o gabinete obtenidos de los sistemas hospitalarios."}, {"no": "5.8", "responsable": "Médico de Guardia", "actividad": "En el apartado del ANÁLISIS: incluye el resumen del paciente, sus posibles diagnósticos diferenciales y razonamiento clínico."}, {"no": "5.9", "responsable": "Médico de Guardia", "actividad": "En el apartado de PLAN debe de incluir la redacción para cada uno de los componentes (pruebas diagnósticas, plan terapéutico, educación para el paciente y seguimiento)."}, {"no": "5.10", "responsable": "Médico de Guardia", "actividad": "Coloca el pronóstico del paciente."}, {"no": "5.11", "responsable": "Médico de Guardia", "actividad": "Firma la nota con las credenciales virtuales proporcionadas por la unidad hospitalaria, imprime la nota, sella y firma."}, {"no": "5.12", "responsable": "Médico de Guardia", "actividad": "Por último, se anexa la impresión al expediente clínico físico del paciente."}]'::jsonb,
  '[{"riesgo": "Incorrecta anamnesis y exploración física.", "barrera": "Constante actualización en la correcta anamnesis y exploración física."}, {"riesgo": "Errores de transcripción al momento de copiar de un medio a otro.", "barrera": "Doble verificación a la transcripción de datos."}]'::jsonb,
  '[{"nombre": "Norma Oficial Mexicana del expediente clínico", "codigo": "NOM-004-SSA3-2012"}]'::jsonb,
  '[{"version": "1", "fecha": "18/03/2022", "descripcion": "Alta de documento", "realizado": "Dr. Daniel Robles Martin", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "2", "fecha": "24/04/2024", "descripcion": "Actualización de documento", "realizado": "Dra. Elisa Nunila Villa Bernal", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "3", "fecha": "03/05/2026", "descripcion": "Actualización de documento", "realizado": "Dra. Daniela Hernández Alvarez", "aprobado": "Dr. Gonzalo Vázquez Camacho"}]'::jsonb,
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
FROM documents d WHERE d.code = 'IT-MG-05'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios,
  elaborado_por=EXCLUDED.elaborado_por, cargo_elaboro=EXCLUDED.cargo_elaboro,
  revisado_por=EXCLUDED.revisado_por, cargo_reviso=EXCLUDED.cargo_reviso,
  autorizado_por=EXCLUDED.autorizado_por, cargo_autorizo=EXCLUDED.cargo_autorizo;

-- Contenido: PR-MG-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo)
SELECT d.id,
  'Realizar la colocación de sonda foley o sonda nasogástrica, así como el retiro de catéter venoso central, homepump o drenes en las áreas de hospitalización con pacientes en habitaciones.',
  'Explicar el proceso de la colocación de sondas o retiro de catéteres.',
  '[{"termino": "Sonda Foley", "definicion": "Tubo estéril, flexible y delgado, fabricado comúnmente de látex o silicona, que se inserta a través de la uretra hasta la vejiga para drenar orina de forma continua."}, {"termino": "Sonda Nasogástrica", "definicion": "Tubo delgado y flexible que se inserta por la nariz, pasa por el esófago y llega hasta el estómago."}, {"termino": "Catéter Venoso Central", "definicion": "Tubo largo y flexible que se introduce en una vena grande (generalmente en el pecho o cuello) para administrar medicamentos, fluidos, nutrición o derivados sanguíneos durante un periodo prolongado."}, {"termino": "Bomba Homepump", "definicion": "Sistema de infusión elastomérico, desechable y portátil, diseñado para la administración continua y precisa de medicamentos."}, {"termino": "Drenes", "definicion": "Dispositivos utilizados tras una intervención para eliminar fluidos (sangre, pus, suero) acumulados en tejidos o cavidades, previniendo infecciones y facilitando la cicatrización."}]'::jsonb,
  '[{"tipo": "Actualización", "descripcion": "Coordinador de Médicos de Guardia"}, {"tipo": "Ejecución", "descripcion": "Médicos de Guardia"}, {"tipo": "Supervisión", "descripcion": "Dirección Médica"}]'::jsonb,
  '[]'::jsonb,
  '[{"no": "5.1", "responsable": "Médico Tratante", "actividad": "Realiza la solicitud vía telefónica (se realiza procedimiento de toma de indicaciones vía telefónica), verbal, o escrita en la hoja de indicaciones médicas."}, {"no": "5.2", "responsable": "Enfermería", "actividad": "Avisa en caso de solicitud escrita en hoja de indicaciones médicas."}, {"no": "5.3", "responsable": "Médico de Guardia", "actividad": "Verifica indicación en la hoja de indicaciones de enfermería y solicita el material a enfermería. Sonda foley: sonda foley de cierto fr, gel, guantes crudos, guantes estériles, jabón, solución, gasas, jeringa, fijador y bolsa recolectora. Sonda nasogástrica: sonda, gel, jeringa, guantes estériles. Catéter Venoso Central: guantes estériles, bisturí, gasas oftálmicas, tegaderm. Homepump: guantes estériles y gasas. Dren: guantes estériles y gasas."}, {"no": "5.4", "responsable": "Médico de Guardia", "actividad": "Ingresa a la habitación del paciente en cuestión, saluda cordialmente, corrobora la identidad del paciente con nombre y fecha de nacimiento, se identifica así mismo como médico de guardia con nombre y apellido, procede a explicar y resolver dudas respecto al procedimiento."}, {"no": "5.5", "responsable": "Médico de Guardia", "actividad": "Procede a colocación o retiro."}, {"no": "5.6", "responsable": "Médico de Guardia", "actividad": "Notifica al servicio de enfermería que ya se realizó para que haga sus procesos de rotulación pertinentes o aseo del paciente."}, {"no": "5.7", "responsable": "Médico de Guardia", "actividad": "En caso de procedimiento fallido se le avisa a enfermería y al médico tratante."}, {"no": "5.8", "responsable": "Médico de Guardia", "actividad": "Finaliza su proceso de colocación o retiro."}, {"no": "5.9", "responsable": "Médico de Guardia", "actividad": "Registra la colocación en los registros clínicos del paciente."}]'::jsonb,
  '[{"riesgo": "Choques contra objetos tras movilización del paciente.", "barrera": "Métodos de barrera y procedimiento de toma de estudios en el área de imagen."}, {"riesgo": "Caída de objetos tras manipulación y/o movilización del paciente.", "barrera": "Mecánica corporal y movimiento de pacientes."}, {"riesgo": "Golpes por objetos o herramientas en la atención de los pacientes.", "barrera": "Apoyo del servicio de camillería."}, {"riesgo": "Punciones accidentales con materiales punzocortantes (agujas, bisturí).", "barrera": "Procedimiento y uso correcto de materiales punzocortantes."}, {"riesgo": "Mal manejo de los materiales del RPBI.", "barrera": "Conocimiento de la normativa de RPBI."}, {"riesgo": "Infecciones de transmisión o exposición por gotas de Flügge y aerosoles (Tuberculosis, Influenza, COVID-19, etc.).", "barrera": "Materiales y equipo de protección necesario para el manejo de residuos biológicos, así como para la atención del paciente con potencial de infección."}]'::jsonb,
  '[]'::jsonb,
  '[{"version": "1", "fecha": "06/05/2026", "descripcion": "Alta de documento", "realizado": "Dra. Daniela Hernandez Alvarez", "aprobado": "Dr. Gonzalo Vázquez Camacho"}]'::jsonb,
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
FROM documents d WHERE d.code = 'PR-MG-01'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios,
  elaborado_por=EXCLUDED.elaborado_por, cargo_elaboro=EXCLUDED.cargo_elaboro,
  revisado_por=EXCLUDED.revisado_por, cargo_reviso=EXCLUDED.cargo_reviso,
  autorizado_por=EXCLUDED.autorizado_por, cargo_autorizo=EXCLUDED.cargo_autorizo;

-- Contenido: PR-MG-02
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo)
SELECT d.id,
  'Recibir indicaciones médicas por parte de médicos tratantes.',
  'Explicar el proceso de toma de indicaciones médicas dadas por el médico tratante, vía telefónica.',
  '[{"termino": "Comunicación efectiva", "definicion": "El mensaje es transmitido de forma exitosa, porque el receptor comprende el significado y la intención del emisor."}]'::jsonb,
  '[{"tipo": "Actualización", "descripcion": "Coordinador de Médicos de Guardia"}, {"tipo": "Ejecución", "descripcion": "Médicos de Guardia"}, {"tipo": "Supervisión", "descripcion": "Dirección Médica"}]'::jsonb,
  '[]'::jsonb,
  '[{"no": "5.1", "responsable": "Médico Tratante", "actividad": "Se comunica con médicos de guardia vía telefónica o aplicación de mensajería, para dejar las indicaciones. Dando nombre del paciente y habitación."}, {"no": "5.2", "responsable": "Médico de Guardia", "actividad": "Toma la llamada y se presenta con el médico tratante como \"Médico de guardia del Hospital Santa Margarita\" y su nombre. Toma la indicación con comunicación efectiva. En caso de dudas se cuestiona al médico tratante, antes de colocar la indicación."}, {"no": "5.3", "responsable": "Médico de Guardia", "actividad": "En el formato de \"Indicaciones Médicas IM-009 5/4/2018 REV 3.0\" en la parte posterior donde indica \"Exclusivo Sello de Comunicación Verbal y Vía Telefónica\" se coloca el Sello llenando fecha y hora, nombre completo del tratante, nombre completo del paciente, diagnóstico y las indicaciones brindadas por médico tratante, por último quien recibió y transcribe la indicación."}, {"no": "5.4", "responsable": "Médico de Guardia", "actividad": "Le informa a enfermera encargada del paciente la nueva indicación y se le leen las indicaciones en voz alta, se pregunta si tiene alguna duda y en caso de negativa se entregan en la mano. En caso de ser un procedimiento de médico de guardia, procede a ejecutarlo."}, {"no": "5.5", "responsable": "Enfermería", "actividad": "Ejecuta la indicación dada."}, {"no": "5.6", "responsable": "Médico Tratante", "actividad": "Acude a su pase de visita, busca el sello de comunicación vía telefónica y firma de responsable."}]'::jsonb,
  '[{"riesgo": "Errores de transcripción al momento de recepción de información por vía telefónica.", "barrera": "Para evitar los errores de la comunicación efectiva se considera la acción esencial número dos, \"Comunicación efectiva\", la cual considera barreras como la doble verificación de la indicación verbal y la correcta recepción de indicaciones por vía telefónica."}, {"riesgo": "Errores de comunicación a través de canales no adecuados para la recepción de información.", "barrera": "Comunicación efectiva."}]'::jsonb,
  '[{"nombre": "Formato de Indicaciones Médicas", "codigo": "NA"}, {"nombre": "Sello de comunicación verbal o vía telefónica", "codigo": "NA"}]'::jsonb,
  '[{"version": "1", "fecha": "24/04/2024", "descripcion": "Alta de documento", "realizado": "Dra. Elisa Nunila Villa Bernal", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "2", "fecha": "06/05/2026", "descripcion": "Actualización de documento", "realizado": "Dra. Daniela Hernández Alvarez", "aprobado": "Dr. Gonzalo Vázquez Camacho"}]'::jsonb,
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
FROM documents d WHERE d.code = 'PR-MG-02'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios,
  elaborado_por=EXCLUDED.elaborado_por, cargo_elaboro=EXCLUDED.cargo_elaboro,
  revisado_por=EXCLUDED.revisado_por, cargo_reviso=EXCLUDED.cargo_reviso,
  autorizado_por=EXCLUDED.autorizado_por, cargo_autorizo=EXCLUDED.cargo_autorizo;

-- Contenido: PR-MG-03
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo)
SELECT d.id,
  'Realizar la toma de electrocardiograma de 12 derivaciones en las áreas de hospitalización con pacientes en habitaciones.',
  'Explicar el proceso de la toma de electrocardiograma a pacientes hospitalizados.',
  '[{"termino": "Electrocardiograma", "definicion": "Prueba rápida en la que se revisan los latidos cardíacos y se registran las señales eléctricas del corazón."}]'::jsonb,
  '[{"tipo": "Actualización", "descripcion": "Coordinador de Médicos de Guardia"}, {"tipo": "Ejecución", "descripcion": "Médicos de Guardia"}, {"tipo": "Supervisión", "descripcion": "Dirección Médica"}]'::jsonb,
  '[]'::jsonb,
  '[{"no": "5.1", "responsable": "Médico Tratante", "actividad": "Realiza la solicitud vía telefónica (se realiza procedimiento de toma de indicaciones vía telefónica), verbal, o escrita en la hoja de indicaciones médicas."}, {"no": "5.2", "responsable": "Enfermería", "actividad": "Notifica en caso de solicitud escrita en hoja de indicaciones médicas."}, {"no": "5.3", "responsable": "Médico de Guardia", "actividad": "Verifica indicación en la hoja de indicaciones de enfermería y acude por el electrocardiógrafo a la oficina de médicos, al servicio de urgencias o al departamento de cardiología para solicitarlo."}, {"no": "5.4", "responsable": "Médico de Guardia", "actividad": "Ingresa a la habitación del paciente en cuestión, saluda cordialmente, corrobora la identidad del paciente, identificándose como médico de guardia con nombre y apellido, procede a explicar y resolver dudas respecto al estudio."}, {"no": "5.5", "responsable": "Médico de Guardia", "actividad": "Procede a la colocación de electrodos, precordiales y bipolares; en caso de ser necesario se usa gel conductor. Posteriormente se procede a la impresión del electrocardiograma y a la limpieza del equipo antes de guardarlo."}, {"no": "5.6", "responsable": "Médico de Guardia", "actividad": "Notifica al servicio de enfermería que ya se realizó el electrocardiograma y rotula con los datos del paciente el estudio."}, {"no": "5.7", "responsable": "Médico de Guardia", "actividad": "Regresa el equipo a la oficina o al departamento solicitado, en buenas condiciones y limpio."}, {"no": "5.8", "responsable": "Médico de Guardia", "actividad": "Toma fotografía del electrocardiograma y lo envía vía electrónica al médico tratante."}, {"no": "5.9", "responsable": "Médico de Guardia", "actividad": "Se dirige a la central de enfermería y guarda el estudio en el expediente clínico del paciente."}, {"no": "5.10", "responsable": "Médico de Guardia", "actividad": "Regresa a oficina de médicos de guardia donde llena ficha de pago con datos del paciente, fecha, habitación y tipo de estudio realizado. Se dirige a cajas a entregar ficha."}, {"no": "5.11", "responsable": "Personal de Cajas", "actividad": "Recibe ficha de pago y hace su procedimiento necesario."}]'::jsonb,
  '[{"riesgo": "Choques contra objetos tras movilización del paciente.", "barrera": "Métodos de barrera y procedimiento de toma de estudios en el área de imagen."}, {"riesgo": "Caída de objetos tras manipulación y/o movilización del paciente.", "barrera": "Mecánica corporal y movimiento de pacientes."}, {"riesgo": "Golpes por objetos o herramientas en la atención de los pacientes.", "barrera": "Apoyo del servicio de camillería."}, {"riesgo": "Punciones accidentales con materiales punzocortantes (agujas, bisturí).", "barrera": "Procedimiento y uso correcto de materiales punzocortantes."}, {"riesgo": "Mal manejo de los materiales del RPBI.", "barrera": "Conocimiento de la normativa de RPBI."}, {"riesgo": "Infecciones de transmisión o exposición por gotas de Flügge y aerosoles (Tuberculosis, Influenza, COVID-19, etc.).", "barrera": "Materiales y equipo de protección necesario para el manejo de residuos biológicos, así como para la atención del paciente con potencial de infección."}]'::jsonb,
  '[]'::jsonb,
  '[{"version": "1", "fecha": "18/03/2022", "descripcion": "Alta de documento", "realizado": "Dr. Daniel Robles Martin", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "2", "fecha": "24/04/2024", "descripcion": "Actualización de documento", "realizado": "Dra. Elisa Nunila Villa Bernal", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "3", "fecha": "03/05/2026", "descripcion": "Actualización de documento", "realizado": "Dra. Daniela Hernández Alvarez", "aprobado": "Dr. Gonzalo Vázquez Camacho"}]'::jsonb,
  'Dra. Daniela Hernández Alvarez', 'Coordinadora de médicos de guardia',
  'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
  'Dr. Gonzalo Vázquez Camacho', 'Dirección Médica'
FROM documents d WHERE d.code = 'PR-MG-03'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios,
  elaborado_por=EXCLUDED.elaborado_por, cargo_elaboro=EXCLUDED.cargo_elaboro,
  revisado_por=EXCLUDED.revisado_por, cargo_reviso=EXCLUDED.cargo_reviso,
  autorizado_por=EXCLUDED.autorizado_por, cargo_autorizo=EXCLUDED.cargo_autorizo;
