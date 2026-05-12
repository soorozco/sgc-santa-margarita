-- ============================================================
--  UCI — Alta de 12 Procedimientos (PR-UCI-01..12)
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
  ('PR-UCI-01','Proceso de Cardioversión'),
  ('PR-UCI-02','Proceso de Colocación de Catéter Venoso Central'),
  ('PR-UCI-03','Proceso de Colocación de Catéter Swan Ganz'),
  ('PR-UCI-04','Proceso de Colocación de Línea Arterial'),
  ('PR-UCI-05','Proceso de Colocación de Marcapasos Cutáneo'),
  ('PR-UCI-06','Proceso de Colocación de Marcapasos Temporal Venoso'),
  ('PR-UCI-07','Proceso de Colocación de Sonda Nasogástrica o Nasoyeyunal'),
  ('PR-UCI-08','Proceso de Colocación de Sonda Vesical'),
  ('PR-UCI-09','Proceso de Colocación de Tubo Pleural'),
  ('PR-UCI-10','Proceso de Cultivo de Punta de Catéter'),
  ('PR-UCI-11','Proceso de Cultivo de Secreción Bronquial'),
  ('PR-UCI-12','Proceso de Desfibrilación')
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
WHERE d.code LIKE 'PR-UCI-%'
ORDER BY d.code;
