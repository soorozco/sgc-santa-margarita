-- ============================================================
--  Tecnologías de la Información — Alta de 2 Instrucciones de Trabajo
--  IT-TI-02, IT-TI-03
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
--
--  Departamento: TI (Tecnologías de la Información)
--  Todos versión 03 · 30 SEP 2025
-- ============================================================

-- ── 1. Alta del departamento TI si no existe ──────────────────
INSERT INTO departments (code, name)
SELECT 'TI', 'Tecnologías de la Información'
WHERE NOT EXISTS (SELECT 1 FROM departments WHERE code = 'TI');

-- ── 2. Alta / actualización de los 2 documentos ───────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments WHERE code = 'TI' LIMIT 1),
  '03', 'vigente', '2025-09-30'::date,
  'José Alberto Bustamante Jiménez',
  'Dra. Giselle Ivette De la Torre García',
  'Jefatura de TI'
FROM (VALUES
  ('IT-TI-02','Instrucción de Trabajo para Requisición de Consumibles'),
  ('IT-TI-03','Instrucción de Trabajo para la Realización de Respaldos')
) AS d(code, name)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  department_id      = EXCLUDED.department_id,
  current_version    = EXCLUDED.current_version,
  status             = EXCLUDED.status,
  elaboration_date   = EXCLUDED.elaboration_date,
  elaborated_by      = EXCLUDED.elaborated_by,
  reviewed_by        = EXCLUDED.reviewed_by,
  custodian_position = EXCLUDED.custodian_position;

-- ── 3. Forzar department_id por UPDATE directo ────────────────
UPDATE documents
SET department_id = (SELECT id FROM departments WHERE code = 'TI' LIMIT 1)
WHERE code IN ('IT-TI-02','IT-TI-03');

-- ── 4. Verificación ───────────────────────────────────────────
SELECT d.code, d.name, d.current_version AS ver,
       CASE WHEN d.department_id IS NOT NULL THEN 'Dept OK ✓'
            ELSE '⚠ Dept NULL' END AS dept
FROM documents d
WHERE d.code IN ('IT-TI-02','IT-TI-03')
ORDER BY d.code;
