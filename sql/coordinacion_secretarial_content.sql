-- ============================================================
--  COORDINACIÓN SECRETARIAL — Vista digital de 4 Procedimientos
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar DESPUÉS de coordinacion_secretarial_docs.sql
--
--  ⚠ NOTA: Los pasos del desarrollo son los capturados del PDF.
--    Los campos elaborado_por se actualizarán cuando se confirme
--    el nombre de la responsable del área.
-- ============================================================

-- ── PR-CS-01  Ingreso de Pacientes a Hospitalización ─────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Establecer los pasos para la atención en admisión hospitalaria, identificando necesidades, brindando información clara y obteniendo datos para el expediente clínico.',

'Aplica a todos los pacientes con indicaciones médicas desde su arribo hasta su traslado a la habitación o área de procedimiento.',

'[]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Coordinación de atención continua"},{"tipo":"4.2 Ejecución","descripcion":"Admisión hospitalaria, recepción, supervisión de enfermería, guardias y camilleros"},{"tipo":"4.3 Supervisión","descripcion":"Dirección administrativa"}]'::jsonb,

'[{"no":"5.2","responsable":"Admisión hospitalaria","actividad":"Identifica necesidades y solicita identificación oficial del paciente y responsable."},{"no":"5.4","responsable":"Admisión hospitalaria","actividad":"Informa sobre el depósito requerido como anticipo y los costos de habitaciones."},{"no":"5.7","responsable":"Supervisión de enfermería","actividad":"Verifica si el caso es infeccioso con epidemiología y asigna habitación."},{"no":"5.11","responsable":"Admisión hospitalaria","actividad":"Genera expediente clínico (12 documentos) y administrativo (5 documentos)."},{"no":"5.13","responsable":"Admisión hospitalaria","actividad":"Notifica ingreso vía WhatsApp detallando médico, diagnóstico y horario de procedimiento."}]'::jsonb,

'[{"riesgo":"Usuarios que se nieguen a firmar expedientes.","barrera":"Se informa a dirección médica para determinar medidas."},{"riesgo":"Caída del sistema.","barrera":"Se da aviso inmediato al área de TI."}]'::jsonb,

'[{"nombre":"Vale de habitación","codigo":"FT-CS-23"},{"nombre":"Carta de responsabilidad (sin ID)","codigo":"FT-CS-27"}]'::jsonb,

'[{"version":"7","fecha":"30/09/2025","descripcion":"Versión vigente","realizado":"Coordinación de Atención Continua","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Coordinación de Atención Continua', 'Coordinación de Atención Continua',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CS-01'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CS-02  Ingreso de Paciente a Urgencias ─────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Estandarizar la atención oportuna en urgencias, priorizando la gravedad clínica mediante el Triage.',

'Aplica a todos los pacientes que ingresan al área de urgencias del hospital.',

'[]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Coordinación de atención continua"},{"tipo":"4.2 Ejecución","descripcion":"Admisión urgencias, enfermería, médico urgenciólogo"},{"tipo":"4.3 Supervisión","descripcion":"Dirección administrativa"}]'::jsonb,

'[{"no":"5.2","responsable":"Enfermería","actividad":"Identifica nivel de prioridad médica según la escala de Triage."},{"no":"5.8","responsable":"Admisión urgencias","actividad":"Si hay médico tratante, enlaza llamada al médico urgenciólogo para recibir indicaciones."},{"no":"5.10","responsable":"Admisión urgencias","actividad":"Si requiere hospitalización, inicia registro bajo el procedimiento PR-CS-01."},{"no":"5.13","responsable":"Admisión urgencias","actividad":"Coloca brazalete de identificación y entrega expediente clínico a enfermería."}]'::jsonb,

'[{"riesgo":"Paciente se presenta solo.","barrera":"Se le solicita contactar a un acompañante o el personal se comunica con su médico tratante."}]'::jsonb,

'[]'::jsonb,

'[{"version":"3","fecha":"30/09/2025","descripcion":"Versión vigente","realizado":"Coordinación de Atención Continua","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Coordinación de Atención Continua', 'Coordinación de Atención Continua',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CS-02'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CS-03  Atención a Paciente Médico Legal ────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Asegurar el ingreso de pacientes involucrados en situaciones legales (agresiones, accidentes viales, etc.) con los documentos requeridos.',

'Aplica a todos los pacientes que ingresan al hospital en calidad de paciente médico legal.',

'[]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Coordinación de atención continua"},{"tipo":"4.2 Ejecución","descripcion":"Admisión urgencias, médico urgenciólogo"},{"tipo":"4.3 Supervisión","descripcion":"Dirección administrativa"}]'::jsonb,

'[{"no":"5.4","responsable":"Médico urgenciólogo","actividad":"Valora instalaciones y asegura que el paciente cuente con el Parte de Lesiones."},{"no":"5.6","responsable":"Admisión urgencias","actividad":"Notifica al Ministerio Público la llegada del paciente y, en su caso, la falta del parte de lesiones."},{"no":"5.8","responsable":"Médico urgenciólogo","actividad":"Si hay médico tratante, le solicita que deje la Responsiva Médica."}]'::jsonb,

'[{"riesgo":"No contar con instalaciones para atención médico-legal.","barrera":"El médico urgenciólogo determina la viabilidad de la atención."}]'::jsonb,

'[]'::jsonb,

'[{"version":"2","fecha":"29/09/2025","descripcion":"Versión vigente","realizado":"Coordinación de Atención Continua","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Coordinación de Atención Continua', 'Coordinación de Atención Continua',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CS-03'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CS-04  Atención en el Área de Recepción Informes ───────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Ofrecer información eficiente y servir de apoyo a otros departamentos del hospital.',

'Aplica al área de recepción e informes del hospital y sus actividades de atención a pacientes, familiares y personal interno.',

'[]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Coordinación de atención continua"},{"tipo":"4.2 Ejecución","descripcion":"Recepción hospitalaria"},{"tipo":"4.3 Supervisión","descripcion":"Dirección administrativa"}]'::jsonb,

'[{"no":"5.2","responsable":"Recepción hospitalaria","actividad":"Consulta precios de estudios en sistema Medisist e informa condiciones."},{"no":"5.4","responsable":"Recepción hospitalaria","actividad":"Gestiona préstamo de controles de TV/Aire mediante garantía ($200 o ID) y formato FT-CS-22."},{"no":"5.8","responsable":"Recepción hospitalaria","actividad":"Realiza voceos para localizar familiares o activar códigos de seguridad."},{"no":"5.10","responsable":"Recepción hospitalaria","actividad":"Controla el préstamo de llaves de habitaciones mediante bitácora FT-CS-24."}]'::jsonb,

'[{"riesgo":"Pérdida de identificaciones o efectivo de garantías.","barrera":"Entrega obligatoria de las garantías al área de administración."}]'::jsonb,

'[{"nombre":"Préstamo de controles","codigo":"FT-CS-22"},{"nombre":"Bitácora de llaves de habitaciones","codigo":"FT-CS-24"}]'::jsonb,

'[{"version":"2","fecha":"29/09/2025","descripcion":"Versión vigente","realizado":"Coordinación de Atención Continua","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Coordinación de Atención Continua', 'Coordinación de Atención Continua',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CS-04'
ON CONFLICT (document_id) DO NOTHING;

-- ── Verificación final ────────────────────────────────────────
SELECT d.code, d.current_version AS ver,
       CASE WHEN dc.id IS NOT NULL THEN 'Con contenido ✓' ELSE 'Sin contenido' END AS contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code LIKE 'PR-CS-%'
ORDER BY d.code;
