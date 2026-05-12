-- ============================================================
--  REHABILITACIÓN — Alta de 4 Procedimientos (PR-RE-01..04)
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
--
--  Departamento confirmado: code = 'RHB' (Rehabilitación)
-- ============================================================

INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments WHERE code = 'RHB'),
  d.ver, 'vigente', '2025-09-23'::date,
  'Dra. Fernanda Toro Sashida',
  'Dra. Giselle Ivette De la Torre García',
  'Jefa de Rehabilitación'
FROM (VALUES
  ('PR-RE-01','Procedimiento de Electroterapia',   '03'),
  ('PR-RE-02','Procedimiento Mecanoterapia',        '03'),
  ('PR-RE-03','Procedimiento Terapia Ocupacional',  '03'),
  ('PR-RE-04','Procedimiento de Hidroterapia',      '03')
) AS d(code, name, ver)
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
            ELSE '⚠ Dept NULL — verificar code RHB' END AS dept
FROM documents d
WHERE d.code LIKE 'PR-RE-%'
ORDER BY d.code;
