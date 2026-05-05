-- ============================================================
--  FIX: agregar columnas faltantes a la tabla documents
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- Columnas que el sistema necesita y pueden no existir
ALTER TABLE documents ADD COLUMN IF NOT EXISTS elaboration_date   date;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS retention_years    integer DEFAULT 2;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS elaborated_by      text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS reviewed_by        text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS custodian_position text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS description        text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS updated_at         timestamptz NOT NULL DEFAULT now();


-- ── Re-insertar los 9 documentos de Archivo ─────────────────────
WITH
  dept AS (SELECT id FROM departments  WHERE code         = 'AR' LIMIT 1),
  t_ft AS (SELECT id FROM document_types WHERE code_prefix = 'FT' LIMIT 1),
  t_it AS (SELECT id FROM document_types WHERE code_prefix = 'IT' LIMIT 1),
  t_pr AS (SELECT id FROM document_types WHERE code_prefix = 'PR' LIMIT 1)

INSERT INTO documents
  (code, name, document_type_id, department_id,
   custodian_position, current_version, status,
   elaboration_date, retention_years, description)
VALUES
  ('FT-AR-01','Formato para la Solicitud de Copias de Expedientes',
    (SELECT id FROM t_ft),(SELECT id FROM dept),
    'Responsable de Archivo Clínico','1.0','vigente',NULL,5,
    'Formulario utilizado por pacientes o familiares para solicitar copias de su expediente clínico.'),

  ('FT-AR-02','Formato de Préstamo de Expedientes',
    (SELECT id FROM t_ft),(SELECT id FROM dept),
    'Responsable de Archivo Clínico','1.0','vigente',NULL,5,
    'Registro de préstamo interno de expedientes clínicos a personal autorizado del hospital.'),

  ('IT-AR-01','Instrucción de Trabajo para el Acceso a la Información del Expediente Clínico Cerrado',
    (SELECT id FROM t_it),(SELECT id FROM dept),
    'Responsable de Archivo Clínico','1.0','vigente',NULL,5,
    'Define los pasos y criterios para que el personal autorizado acceda a expedientes clínicos en archivo muerto.'),

  ('IT-AR-02','Instrucción de Trabajo para la Destrucción de Archivo Muerto',
    (SELECT id FROM t_it),(SELECT id FROM dept),
    'Responsable de Archivo Clínico','1.0','vigente',NULL,5,
    'Establece el procedimiento seguro para la destrucción de expedientes clínicos una vez cumplido su tiempo de resguardo legal.'),

  ('IT-AR-03','Instrucción de Trabajo para Recolección de Expedientes en Urgencias',
    (SELECT id FROM t_it),(SELECT id FROM dept),
    'Responsable de Archivo Clínico','1.0','vigente',NULL,5,
    'Describe el proceso para la recolección y devolución de expedientes clínicos del área de Urgencias.'),

  ('IT-AR-04','Instrucción de Trabajo para la Recolección de Expedientes en Hospitalización',
    (SELECT id FROM t_it),(SELECT id FROM dept),
    'Responsable de Archivo Clínico','1.0','vigente',NULL,5,
    'Detalla los pasos para la recolección de expedientes de pacientes egresados del área de Hospitalización.'),

  ('IT-AR-05','Instrucción de Trabajo para Solicitud de Papelería y Material de Trabajo para Archivo',
    (SELECT id FROM t_it),(SELECT id FROM dept),
    'Responsable de Archivo Clínico','1.0','vigente',NULL,2,
    'Establece el proceso para la solicitud y control de papelería y materiales del departamento de Archivo.'),

  ('PR-AR-01','Procedimiento para el Préstamo Interno de Expedientes Clínicos',
    (SELECT id FROM t_pr),(SELECT id FROM dept),
    'Responsable de Archivo Clínico','1.0','vigente',NULL,5,
    'Define el flujo completo para la solicitud, autorización, préstamo y devolución de expedientes clínicos.'),

  ('PR-AR-03','Procedimiento para la Recolección de Expedientes en Urgencias',
    (SELECT id FROM t_pr),(SELECT id FROM dept),
    'Responsable de Archivo Clínico','1.0','vigente',NULL,5,
    'Describe el proceso y responsabilidades para la recolección oportuna de expedientes del área de Urgencias.')

ON CONFLICT (code) DO NOTHING;


-- ── Verificación ─────────────────────────────────────────────────
SELECT
  d.code,
  dt.code_prefix AS tipo,
  dp.code        AS depto,
  d.current_version,
  d.status
FROM documents d
LEFT JOIN document_types dt ON dt.id = d.document_type_id
LEFT JOIN departments    dp ON dp.id = d.department_id
ORDER BY d.code;
