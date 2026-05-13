-- ============================================================
--  UCI — Alta de 8 Procedimientos (PR-UCI-13..20)
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
--
--  Departamento: UCI (Unidad de Cuidados Intensivos)
--  Todos versión 02 · 25 MAR 2024
-- ============================================================

INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments WHERE code = 'UCI'),
  '02', 'vigente', '2024-03-25'::date,
  'Dr. Jorge Isaac Michel González',
  'Dr. José Gonzalo Vázquez Camacho',
  'Jefe de Terapia Intensiva'
FROM (VALUES
  ('PR-UCI-13','Proceso de Extubación'),
  ('PR-UCI-14','Proceso de Intubación Orotraqueal'),
  ('PR-UCI-15','Proceso de Monitoreo de Gasto Cardiaco'),
  ('PR-UCI-16','Proceso de Monitoreo en Cuidados Intensivos'),
  ('PR-UCI-17','Proceso de Paracentesis'),
  ('PR-UCI-18','Proceso de Pericardiocentesis'),
  ('PR-UCI-19','Proceso de Punción Lumbar'),
  ('PR-UCI-20','Proceso de Toracocentesis')
) AS d(code, name)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  current_version    = EXCLUDED.current_version,
  status             = EXCLUDED.status,
  elaboration_date   = EXCLUDED.elaboration_date,
  elaborated_by      = EXCLUDED.elaborated_by,
  reviewed_by        = EXCLUDED.reviewed_by,
  custodian_position = EXCLUDED.custodian_position;

-- ── Verificación ──────────────────────────────────────────────
SELECT d.code, d.name, d.current_version AS ver,
       CASE WHEN d.department_id IS NOT NULL THEN 'Dept OK ✓'
            ELSE '⚠ Dept NULL — verificar code UCI' END AS dept
FROM documents d
WHERE d.code BETWEEN 'PR-UCI-13' AND 'PR-UCI-20'
ORDER BY d.code;
