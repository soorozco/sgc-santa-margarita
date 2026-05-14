-- ============================================================
--  Archivo Clínico — Contenido digital de documentos AR
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase SQL Editor
--  Incluye: IT-AR-01..05, PR-AR-01, PR-AR-03, FT-AR-01, FT-AR-02
-- ============================================================

-- IT-AR-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-AR-01'),
  'Esta instrucción de trabajo aplica cuando se solicita en el departamento de archivo clínico el acceso a un expediente clínico cerrado por personal clínico y no clínico que esté autorizado para el manejo de datos personales.',
  'Esta instrucción de trabajo aplica cuando se solicita en el departamento de archivo clínico el acceso a un expediente clínico cerrado por personal clínico y no clínico que esté autorizado para el manejo de datos personales.',
  '["Equipo de cómputo"]'::jsonb,
  '[{"num": "5.1", "responsable": "Personal de archivo clínico", "actividad": "Ingresa a la base de datos de archivo clínico para verificar la existencia y situación actual del expediente solicitado."}, {"num": "5.2", "responsable": "Personal de archivo clínico", "actividad": "Se recaba la documentación necesaria para verificar el acceso a la información del solicitante según corresponda: Copia de INE del paciente; Copia de INE del representante (en caso de familiar); Carta poder simple firmada para la solicitud de información (en caso de acudir familiar de paciente que no sea el representante); Documento testamentario o de albacea de información (para defunciones en caso de acudir familiar de paciente sin carta poder); Cédula o INE (médico tratante o Interconsultantes)."}, {"num": "5.3", "responsable": "Personal de archivo clínico", "actividad": "Entregar formato de recibo de copias a paciente o familiar para su llenado."}, {"num": "5.4", "responsable": "Personal de archivo clínico", "actividad": "En caso de solicitud de copias o expediente clínico completo de paciente finados se entregará una copia de la solicitud llenada y documentación al área jurídica para su revisión y su aprobación antes de continuar la instrucción de trabajo."}, {"num": "5.5", "responsable": "Personal de archivo clínico", "actividad": "Se entrega una copia de la documentación solicitada."}, {"num": "5.6", "responsable": "Personal de archivo clínico", "actividad": "En caso de solicitud de expediente clínico completo este se entregará al área jurídica quien realizará la entrega."}, {"num": "5.7", "responsable": "Personal de archivo clínico", "actividad": "Se resguarda la documentación en la carpeta correspondiente."}, {"num": "5.8", "responsable": "Personal de archivo clínico", "actividad": "En caso de médico tratante o Interconsultantes: se entrega el expediente para su revisión en el área de archivo designada y está presente para verificar se cumplan las políticas generales del expediente clínico."}, {"num": "5.9", "responsable": "Personal de archivo clínico", "actividad": "Vuelve a archivar el expediente clínico."}]'::jsonb,
  '[{"riesgo": "No funcione el equipo de cómputo para verificación de base de datos.", "barrera": "Se mantendrá una copia de la base de datos actualizada en la red del Hospital Santa Margarita."}, {"riesgo": "Familiar o paciente agresivo ante negativa por falta de documentación completa.", "barrera": "Se avisará a personal de vigilancia y al coordinador de archivo en caso de no estar presente."}, {"riesgo": "Familiar o paciente agresivo ante negativa por firmar el recibo para recibir la información solicitada del expediente.", "barrera": "Se le explicará la importancia de que firme el documento para salvaguardar la información del expediente."}]'::jsonb,
  '[{"nombre": "Recibo de copias de expediente", "codigo": "NA"}]'::jsonb,
  '[{"version": "01", "fecha": "16/11/2018", "descripcion": "Alta de documento", "realizado": "Dr. Hugo Munguia Nava", "aprobado": "Hna. Ma Dolores Sandoval Torres"}, {"version": "02", "fecha": "03/02/2022", "descripcion": "Actualización de documento", "realizado": "Areli Janeth Ruiz Sánchez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "24/01/2024", "descripcion": "Actualización de documento", "realizado": "Mayra Olivares Cervantes", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "29/09/2025", "descripcion": "Actualización del formato", "realizado": "Mayra Olivares Cervantes", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-AR-01')
ON CONFLICT (document_id) DO UPDATE SET
  alcance           = EXCLUDED.alcance,
  objetivo          = EXCLUDED.objetivo,
  material_equipo   = EXCLUDED.material_equipo,
  desarrollo        = EXCLUDED.desarrollo,
  gestion_riesgos   = EXCLUDED.gestion_riesgos,
  referencias       = EXCLUDED.referencias,
  control_cambios   = EXCLUDED.control_cambios,
  definiciones      = EXCLUDED.definiciones,
  responsabilidades = EXCLUDED.responsabilidades;

-- IT-AR-02
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-AR-02'),
  'Este documento aplica cuando se realiza la destrucción de los expedientes clínicos cerrados del área de archivo clínico a los expedientes que cumplen más de 5 años siguiendo las políticas generales de archivo y la NOM-004-SSA3-2012 bajo la autorización de la Directora General del Hospital Santa Margarita.',
  'Este documento aplica cuando se realiza la destrucción de los expedientes clínicos cerrados del área de archivo clínico a los expedientes que cumplen más de 5 años siguiendo las políticas generales de archivo y la NOM-004-SSA3-2012 bajo la autorización de la Directora General del Hospital Santa Margarita.',
  '["Trituradora de papel", "Quita grapas", "Bolsas para depositar el material triturado"]'::jsonb,
  '[{"num": "5.1", "responsable": "Asistente de archivo", "actividad": "Separa los expedientes que cumplen más de 5 años desde la última atención medica indicados por el personal auxiliar administrativo de archivo clínico."}, {"num": "5.2", "responsable": "Asistente de archivo", "actividad": "Retira cualquier objeto de metal (grapas, clips, etc.) de los expedientes clínicos."}, {"num": "5.3", "responsable": "Asistente de archivo", "actividad": "Verifica y/o coloca una bolsa de plástico adecuada para el almacenaje de papel en la trituradora de papel del área."}, {"num": "5.4", "responsable": "Asistente de archivo", "actividad": "Se procede a la destrucción de los expedientes en periodos de 30 minutos por 30 minutos de descanso (para no sobrecalentar el motor de la trituradora)."}, {"num": "5.5", "responsable": "Asistente de archivo", "actividad": "Se hace el recambio de la bolsa para almacenaje conforme sea necesario."}]'::jsonb,
  '[{"riesgo": "Destrucción de expedientes clínicos incorrectos.", "barrera": "Se verifican los datos para corroborar que el expediente ya tenga 5 años de su última atención."}]'::jsonb,
  '[{"nombre": "No aplica", "codigo": "NA"}]'::jsonb,
  '[{"version": "01", "fecha": "16/11/2019", "descripcion": "Alta de documento", "realizado": "Selene Araceli Silva Valdez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "03/02/2022", "descripcion": "Modificación de documento", "realizado": "Areli Janeth Ruiz Sánchez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "24/01/2024", "descripcion": "Actualización", "realizado": "Mayra Olivares Cervantes", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "20/09/2025", "descripcion": "Actualización del formato", "realizado": "Mayra Olivares Cervantes", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-AR-02')
ON CONFLICT (document_id) DO UPDATE SET
  alcance           = EXCLUDED.alcance,
  objetivo          = EXCLUDED.objetivo,
  material_equipo   = EXCLUDED.material_equipo,
  desarrollo        = EXCLUDED.desarrollo,
  gestion_riesgos   = EXCLUDED.gestion_riesgos,
  referencias       = EXCLUDED.referencias,
  control_cambios   = EXCLUDED.control_cambios,
  definiciones      = EXCLUDED.definiciones,
  responsabilidades = EXCLUDED.responsabilidades;

-- IT-AR-03
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-AR-03'),
  'Este documento aplica cuando se busca recabar los expedientes clínicos correspondientes a los egresos del día del área de urgencias y endoscopia.',
  'Este documento aplica cuando se busca recabar los expedientes clínicos correspondientes a los egresos del día del área de urgencias y endoscopia.',
  '["Equipo de cómputo"]'::jsonb,
  '[{"num": "5.1", "responsable": "Asistente de archivo", "actividad": "Imprime el censo y verifica si hubo altas en el servicio de urgencias y endoscopia."}, {"num": "5.2", "responsable": "Asistente de archivo", "actividad": "Solicita al personal de admisión del área de urgencias los expedientes clínicos de las consultas, endoscopias."}, {"num": "5.3", "responsable": "Asistente de archivo", "actividad": "Personal de admisión de urgencias firma censo."}, {"num": "5.4", "responsable": "Asistente de archivo", "actividad": "Se retira del área con los expedientes clínicos cerrados."}, {"num": "5.5", "responsable": "Asistente de archivo", "actividad": "Realiza esta instrucción de lunes a sábado."}]'::jsonb,
  '[{"riesgo": "Se olviden expedientes en el área.", "barrera": "Se verifica la realización de los folios de TRIAJE con los restantes físicos en el área."}]'::jsonb,
  '[{"nombre": "No Aplica", "codigo": "NA"}]'::jsonb,
  '[{"version": "01", "fecha": "16/11/2019", "descripcion": "Alta de documento", "realizado": "Selene Araceli Silva Valdez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "03/02/2022", "descripcion": "Modificación de documento", "realizado": "Areli Janeth Ruiz Sánchez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "24/01/2024", "descripcion": "Modificación de documento", "realizado": "Mayra Olivares Cervantes", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "20/09/2025", "descripcion": "Actualización del documento", "realizado": "Mayra Olivares Cervantes", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-AR-03')
ON CONFLICT (document_id) DO UPDATE SET
  alcance           = EXCLUDED.alcance,
  objetivo          = EXCLUDED.objetivo,
  material_equipo   = EXCLUDED.material_equipo,
  desarrollo        = EXCLUDED.desarrollo,
  gestion_riesgos   = EXCLUDED.gestion_riesgos,
  referencias       = EXCLUDED.referencias,
  control_cambios   = EXCLUDED.control_cambios,
  definiciones      = EXCLUDED.definiciones,
  responsabilidades = EXCLUDED.responsabilidades;

-- IT-AR-04
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-AR-04'),
  'Este documento aplica cuando se busca recabar los expedientes clínicos correspondientes a los egresos del día del área de hospitalización.',
  'Este documento aplica cuando se busca recabar los expedientes clínicos correspondientes a los egresos del día del área de hospitalización.',
  '["Bolsas de plástico", "Bitácora de recolección de expedientes cerrados"]'::jsonb,
  '[{"num": "5.1", "responsable": "Auxiliar administrativo de archivo", "actividad": "Imprime censo diario."}, {"num": "5.2", "responsable": "Auxiliar administrativo de archivo", "actividad": "Anota en la bitácora de recolección de expedientes cerrados: nombre completo, fecha de ingreso, fecha de egreso, institución, habitación y motivo de egreso de los expedientes que se encuentren en los contenedores."}, {"num": "5.3", "responsable": "Auxiliar administrativo de archivo", "actividad": "Realiza verificación de los datos en la bitácora con el personal de enfermería del área con una firma de conformidad de dicho personal en la libreta."}, {"num": "5.4", "responsable": "Auxiliar administrativo de archivo", "actividad": "Se asegura de dejar en los contenedores de cartón 10 bolsas de plástico dobladas."}, {"num": "5.5", "responsable": "Auxiliar administrativo de archivo", "actividad": "Se retira del área con los expedientes clínicos cerrados."}, {"num": "5.6", "responsable": "Auxiliar administrativo de archivo", "actividad": "Realiza esta instrucción de lunes a sábado."}]'::jsonb,
  '[{"riesgo": "Se olviden expedientes en el área.", "barrera": "Se verifica la realización de los folios con los restantes físicos en el área."}]'::jsonb,
  '[{"nombre": "Políticas generales de archivo y expediente clínico", "codigo": "NA"}]'::jsonb,
  '[{"version": "01", "fecha": "16/11/2019", "descripcion": "Alta de documento", "realizado": "Selene Araceli Silva Valdez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "03/02/2022", "descripcion": "Modificación de documento", "realizado": "Areli Janeth Ruiz Sánchez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "24/01/2024", "descripcion": "Modificación de documento", "realizado": "Mayra Olivares Cervantes", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "20/09/2025", "descripcion": "Actualización del documento", "realizado": "Mayra Olivares Cervantes", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-AR-04')
ON CONFLICT (document_id) DO UPDATE SET
  alcance           = EXCLUDED.alcance,
  objetivo          = EXCLUDED.objetivo,
  material_equipo   = EXCLUDED.material_equipo,
  desarrollo        = EXCLUDED.desarrollo,
  gestion_riesgos   = EXCLUDED.gestion_riesgos,
  referencias       = EXCLUDED.referencias,
  control_cambios   = EXCLUDED.control_cambios,
  definiciones      = EXCLUDED.definiciones,
  responsabilidades = EXCLUDED.responsabilidades;

-- IT-AR-05
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'IT-AR-05'),
  'Este documento aplica cuando se necesita realizar un pedido al departamento de almacén de algún insumo necesario para el área de archivo y expediente clínico.',
  'Este documento aplica cuando se necesita realizar un pedido al departamento de almacén de algún insumo necesario para el área de archivo y expediente clínico.',
  '["Equipo de cómputo"]'::jsonb,
  '[{"num": "5.1", "responsable": "Coordinadora de archivo", "actividad": "Hace revisión semanal de material de oficina (plumas, grapas, metálicas, separadores, clips, etc.), papelería y material de trabajo en el área de archivo o se le indica por el personal de necesidades específicas."}, {"num": "5.2", "responsable": "Coordinadora de archivo", "actividad": "Realiza el pedido en el sistema MEDISIST."}, {"num": "5.3", "responsable": "Coordinadora de archivo", "actividad": "Recibe el pedido que entrega el auxiliar de almacén y verifica que se entregue el material solicitado."}, {"num": "5.4", "responsable": "Coordinadora de archivo", "actividad": "Realiza el acomodo del material en su lugar correspondiente."}]'::jsonb,
  '[{"riesgo": "Falta de insumos.", "barrera": "Revisión semanal para verificar y pedir el material faltante."}]'::jsonb,
  '[{"nombre": "No Aplica", "codigo": "NA"}]'::jsonb,
  '[{"version": "01", "fecha": "16/11/2019", "descripcion": "Alta de documento", "realizado": "Areli Janeth Ruiz Sánchez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "03/02/2022", "descripcion": "Modificación de documento", "realizado": "Areli Janeth Ruiz Sánchez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "24/01/2024", "descripcion": "Modificación de documento", "realizado": "Mayra Olivares Cervantes", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "29/09/2025", "descripcion": "Actualización del documento", "realizado": "Mayra Olivares", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'IT-AR-05')
ON CONFLICT (document_id) DO UPDATE SET
  alcance           = EXCLUDED.alcance,
  objetivo          = EXCLUDED.objetivo,
  material_equipo   = EXCLUDED.material_equipo,
  desarrollo        = EXCLUDED.desarrollo,
  gestion_riesgos   = EXCLUDED.gestion_riesgos,
  referencias       = EXCLUDED.referencias,
  control_cambios   = EXCLUDED.control_cambios,
  definiciones      = EXCLUDED.definiciones,
  responsabilidades = EXCLUDED.responsabilidades;

-- FT-AR-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'FT-AR-01'),
  'Formato para la solicitud de copias de expedientes clínicos cerrados al departamento de Archivo Clínico del Hospital Santa Margarita.',
  'Formato para la solicitud de copias de expedientes clínicos cerrados al departamento de Archivo Clínico del Hospital Santa Margarita.',
  '[]'::jsonb,
  '[{"num": "1", "responsable": "Solicitante", "actividad": "Completar todos los campos del formato: nombre del paciente, número de expediente, motivo de solicitud, identificación oficial y firma."}, {"num": "2", "responsable": "Personal de archivo clínico", "actividad": "Verifica la documentación presentada conforme a la instrucción IT-AR-01."}, {"num": "3", "responsable": "Personal de archivo clínico", "actividad": "Sella y firma de recibido, entregando copia al solicitante."}]'::jsonb,
  '[]'::jsonb,
  '[{"nombre": "Instrucción de Trabajo para el Acceso a la Información del Expediente Clínico Cerrado", "codigo": "IT-AR-01"}]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'FT-AR-01')
ON CONFLICT (document_id) DO UPDATE SET
  alcance           = EXCLUDED.alcance,
  objetivo          = EXCLUDED.objetivo,
  material_equipo   = EXCLUDED.material_equipo,
  desarrollo        = EXCLUDED.desarrollo,
  gestion_riesgos   = EXCLUDED.gestion_riesgos,
  referencias       = EXCLUDED.referencias,
  control_cambios   = EXCLUDED.control_cambios,
  definiciones      = EXCLUDED.definiciones,
  responsabilidades = EXCLUDED.responsabilidades;

-- FT-AR-02
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'FT-AR-02'),
  'Formato para el registro y control del préstamo interno de expedientes clínicos solicitados por áreas autorizadas del Hospital Santa Margarita.',
  'Formato para el registro y control del préstamo interno de expedientes clínicos solicitados por áreas autorizadas del Hospital Santa Margarita.',
  '[]'::jsonb,
  '[{"num": "1", "responsable": "Personal de archivo clínico", "actividad": "Registra los datos del expediente prestado: nombre del paciente, número de folio, área solicitante, nombre del solicitante, fecha de préstamo y firma de recepción."}, {"num": "2", "responsable": "El solicitante", "actividad": "Firma el formato en el campo correspondiente como acuse de recibo y aceptación de responsabilidad."}, {"num": "3", "responsable": "Personal de archivo clínico", "actividad": "Registra la fecha de devolución y firma de conformidad al reintegrar el expediente."}]'::jsonb,
  '[]'::jsonb,
  '[{"nombre": "Procedimiento para el Préstamo Interno de Expedientes Clínicos", "codigo": "PR-AR-01"}]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'FT-AR-02')
ON CONFLICT (document_id) DO UPDATE SET
  alcance           = EXCLUDED.alcance,
  objetivo          = EXCLUDED.objetivo,
  material_equipo   = EXCLUDED.material_equipo,
  desarrollo        = EXCLUDED.desarrollo,
  gestion_riesgos   = EXCLUDED.gestion_riesgos,
  referencias       = EXCLUDED.referencias,
  control_cambios   = EXCLUDED.control_cambios,
  definiciones      = EXCLUDED.definiciones,
  responsabilidades = EXCLUDED.responsabilidades;

-- PR-AR-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'PR-AR-01'),
  'Este procedimiento inicia cuando se realiza la solicitud del expediente o los expedientes cerrados al archivo clínico concluyendo cuando se regresa el expediente clínico archivando en el lugar que corresponde. Las áreas autorizadas a solicitar para consulta el préstamo interno de expedientes clínicos son: Dirección Médica, Dirección Administrativa, Coordinación Médica, Dpto. de Calidad, Coordinación de Expediente Clínico, Epidemiología, Servicios Farmacéuticos, Administración y Convenio Vigente, Jurídico. El Área Jurídica es la única que puede extraer al exterior del hospital un expediente clínico, única y exclusivamente cuando sea solicitado por escrito por una instancia judicial o juez.',
  'Proporcionar a los departamentos autorizados para solicitar préstamo, el soporte documental que se incluye en el expediente cerrado, para consulta en forma segura y responsable.',
  '[]'::jsonb,
  '[{"num": "5.1", "responsable": "Áreas autorizadas", "actividad": "Realiza la solicitud del expediente o los expedientes cerrados al archivo clínico."}, {"num": "5.2", "responsable": "Personal de archivo", "actividad": "Entrega expedientes solicitados."}, {"num": "5.3", "responsable": "El solicitante", "actividad": "Firma la recepción de los expedientes junto con la aceptación de la responsabilidad legal del documento."}, {"num": "5.4", "responsable": "El solicitante", "actividad": "Una vez que desocupa el o los expedientes, los devuelve al archivo clínico para su resguardo."}, {"num": "5.5", "responsable": "Personal de archivo", "actividad": "Archiva el expediente clínico en el lugar que corresponda."}]'::jsonb,
  '[{"riesgo": "Servicio se quede de forma indefinida el expediente.", "barrera": "Personal de archivo realizará una solicitud de devolución de forma quincenal."}, {"riesgo": "Que se extravíe el expediente.", "barrera": "Personal de archivo establece políticas claras sobre el manejo del expediente así como la responsabilidad de su resguardo."}]'::jsonb,
  '[{"nombre": "No Aplica", "codigo": "NA"}]'::jsonb,
  '[{"version": "01", "fecha": "03/06/2021", "descripcion": "Alta de documento", "realizado": "Areli Janeth Ruiz Sánchez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "11/03/2022", "descripcion": "Actualización del documento", "realizado": "Areli Janeth Ruiz Sánchez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "24/09/2025", "descripcion": "Actualización del documento", "realizado": "Mayra Olivares Cervantes", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb,
  '[{"termino": "Expediente Clínico", "definicion": "Es la información y datos personales de un paciente, que incluye documentos escritos, imagenológicos y electrónicos, donde se registran todos los datos relevantes de la atención médica recibida, desde su ingreso hasta su egreso."}]'::jsonb,
  '[{"tipo": "Actualización", "descripcion": "Coordinador del departamento de Archivo clínico."}, {"tipo": "Ejecución", "descripcion": "Coordinador del departamento de Archivo clínico, personal de archivo."}, {"tipo": "Supervisión", "descripcion": "Dirección Médica, Coordinador del departamento de Archivo clínico, Departamento de Calidad."}]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'PR-AR-01')
ON CONFLICT (document_id) DO UPDATE SET
  alcance           = EXCLUDED.alcance,
  objetivo          = EXCLUDED.objetivo,
  material_equipo   = EXCLUDED.material_equipo,
  desarrollo        = EXCLUDED.desarrollo,
  gestion_riesgos   = EXCLUDED.gestion_riesgos,
  referencias       = EXCLUDED.referencias,
  control_cambios   = EXCLUDED.control_cambios,
  definiciones      = EXCLUDED.definiciones,
  responsabilidades = EXCLUDED.responsabilidades;

-- PR-AR-03
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = 'PR-AR-03'),
  'El proceso inicia al momento del alta del paciente en urgencias por Médico tratante y concluye con el resguardo del expediente clínico cerrado en el área de archivo clínico por un lapso de 5 años. Este procedimiento es aplicable en el servicio de urgencias. Las áreas que intervienen en el proceso son: el departamento de archivo clínico, departamento de urgencias, enfermería y admisión.',
  'Resguardo oportuno de los expedientes, por parte de archivo clínico, después del alta de pacientes del área urgencias por médico tratante.',
  '[]'::jsonb,
  '[{"num": "5.1", "responsable": "Médico Tratante / Médico de Urgencias", "actividad": "El Médico de Urgencias indica el alta del paciente."}, {"num": "5.2", "responsable": "Recepcionista de urgencias", "actividad": "Verifica el cumplimiento en el llenado correcto y completo del expediente clínico."}, {"num": "5.3", "responsable": "Recepcionista de urgencias", "actividad": "Resguarda los expedientes en recepción de urgencias hasta que los recolecta el área de archivo clínico."}, {"num": "5.4", "responsable": "Personal de archivo clínico", "actividad": "Recoge expedientes de urgencias y confirma su recolección con la firma de la recepcionista de urgencias del turno en el censo diario."}, {"num": "5.5", "responsable": "Personal de archivo", "actividad": "Los expedientes son llevados al archivo clínico."}, {"num": "5.6", "responsable": "Personal de archivo", "actividad": "Se registran en la base de datos y se asigna número de folio."}, {"num": "5.7", "responsable": "Personal de archivo", "actividad": "Se archiva en repisa por orden de folio."}]'::jsonb,
  '[{"riesgo": "Expediente no se encuentre completo.", "barrera": "El personal de admisión debe engrapar todas las hojas que conforman el expediente."}, {"riesgo": "Familiares o pacientes busquen modificar o sacar fotos de expediente clínico.", "barrera": "Se resguarda en jefatura de enfermería y se avisa a personal de archivo."}]'::jsonb,
  '[{"nombre": "No aplica", "codigo": "NA"}]'::jsonb,
  '[{"version": "01", "fecha": "16/11/2019", "descripcion": "Alta de documento", "realizado": "Selene Araceli Silva Valdez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "02", "fecha": "11/03/2022", "descripcion": "Modificación de documento", "realizado": "Areli Janeth Ruiz Sánchez", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "03", "fecha": "24/01/2024", "descripcion": "Modificación de documento", "realizado": "Mayra Olivares Cervantes", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "04", "fecha": "24/09/2025", "descripcion": "Actualización del documento", "realizado": "Mayra Olivares Cervantes", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb,
  '[{"termino": "Expediente clínico", "definicion": "Es la información y datos personales de un paciente, que incluye documentos escritos, imagenológicos y electrónicos, donde se registran todos los datos relevantes de la atención médica recibida, desde su ingreso hasta su egreso."}]'::jsonb,
  '[{"tipo": "Actualización", "descripcion": "Coordinador del departamento de Archivo clínico."}, {"tipo": "Ejecución", "descripcion": "Coordinador del departamento de Archivo clínico, personal de archivo."}, {"tipo": "Supervisión", "descripcion": "Dirección Médica, Coordinador del departamento de Archivo clínico, Departamento de Calidad."}]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = 'PR-AR-03')
ON CONFLICT (document_id) DO UPDATE SET
  alcance           = EXCLUDED.alcance,
  objetivo          = EXCLUDED.objetivo,
  material_equipo   = EXCLUDED.material_equipo,
  desarrollo        = EXCLUDED.desarrollo,
  gestion_riesgos   = EXCLUDED.gestion_riesgos,
  referencias       = EXCLUDED.referencias,
  control_cambios   = EXCLUDED.control_cambios,
  definiciones      = EXCLUDED.definiciones,
  responsabilidades = EXCLUDED.responsabilidades;
