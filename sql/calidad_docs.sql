-- ============================================================
--  Calidad — Alta de 3 Procedimientos
--  PR-CA-05, PR-CA-06, PR-CA-07
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- ── 1. Alta del departamento CA si no existe ──────────────────
INSERT INTO departments (code, name)
SELECT 'CA', 'Jefatura de Calidad'
WHERE NOT EXISTS (SELECT 1 FROM departments WHERE code = 'CA');

-- ── 2. Alta / actualización de los 3 documentos ───────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  d.ver, 'vigente', d.fecha::date,
  'Dra. Giselle Ivette De la Torre García',
  'Hna. María de Jesús Gómez Flores',
  'Jefatura de Calidad'
FROM (VALUES
  ('PR-CA-05','Procedimiento para la Gestión de Quejas, Sugerencias y Felicitaciones',              '03','2025-03-03'),
  ('PR-CA-06','Procedimiento para la Realización de Encuestas de Satisfacción',                    '01','2025-04-07'),
  ('PR-CA-07','Procedimiento para la Notificación, Registro y Análisis de Incidentes Clínicos',    '01','2025-09-30')
) AS d(code, name, ver, fecha)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  department_id      = EXCLUDED.department_id,
  current_version    = EXCLUDED.current_version,
  status             = EXCLUDED.status,
  elaboration_date   = EXCLUDED.elaboration_date,
  elaborated_by      = EXCLUDED.elaborated_by,
  reviewed_by        = EXCLUDED.reviewed_by,
  custodian_position = EXCLUDED.custodian_position;

-- ── 3. Forzar department_id ───────────────────────────────────
UPDATE documents
SET department_id = (SELECT id FROM departments WHERE code = 'CA' LIMIT 1)
WHERE code IN ('PR-CA-05','PR-CA-06','PR-CA-07');

-- ── 4. Verificación ───────────────────────────────────────────
SELECT d.code, d.name, d.current_version AS ver,
       CASE WHEN d.department_id IS NOT NULL THEN 'Dept OK ✓'
            ELSE '⚠ Dept NULL' END AS dept
FROM documents d
WHERE d.code IN ('PR-CA-05','PR-CA-06','PR-CA-07')
ORDER BY d.code;
