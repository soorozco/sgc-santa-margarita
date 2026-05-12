-- ============================================================
--  CAPITAL HUMANO — Alta de 10 Procedimientos (PR-CH-01..10)
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
--
--  ⚠ VERIFICAR ANTES DE EJECUTAR:
--  SELECT code, name FROM departments
--    WHERE name ILIKE '%capital%' OR name ILIKE '%humano%' OR code = 'RH';
--  Si el code no es 'RH', cambia la subquery de department_id abajo.
--
--  DESPUÉS de ejecutar ambos archivos:
--  GRANT ALL ON documents        TO anon, authenticated;
--  GRANT ALL ON document_content TO anon, authenticated;
-- ============================================================

INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments WHERE code = 'RH'),  -- ⚠ ajusta si tu código es distinto
  d.ver, 'vigente', d.fecha::date,
  'Lic. Jorge Octavio Ramírez Chávez',
  'Dra. Giselle Ivette De la Torre García',
  'Jefe de Capital Humano'
FROM (VALUES
  ('PR-CH-01','Procedimiento para Reclutamiento y Selección',                               '05','2025-10-01'),
  ('PR-CH-02','Procedimiento para Ingreso de Personal',                                     '05','2025-09-29'),
  ('PR-CH-03','Procedimiento para Riesgo de Trabajo dentro de la Empresa',                  '04','2025-09-29'),
  ('PR-CH-04','Procedimiento para Baja del Empleado',                                       '04','2025-09-29'),
  ('PR-CH-05','Procedimiento de Inducción a la Empresa para el Personal de Nuevo Ingreso',  '05','2025-09-29'),
  ('PR-CH-06','Procedimiento de Solicitud de Permiso y Vacaciones',                         '05','2025-09-29'),
  ('PR-CH-07','Procedimiento para Aplicación de Cuestionarios de la NOM-035',               '05','2025-09-29'),
  ('PR-CH-08','Procedimiento para Capacitación',                                             '04','2025-09-29'),
  ('PR-CH-09','Procedimiento para Realizar Evaluación de Desempeño',                        '04','2025-08-08'),
  ('PR-CH-10','Procedimiento de Evaluación de Clima Laboral',                               '03','2025-09-29')
) AS d(code, name, ver, fecha)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  current_version    = EXCLUDED.current_version,
  status             = EXCLUDED.status,
  elaboration_date   = EXCLUDED.elaboration_date,
  elaborated_by      = EXCLUDED.elaborated_by,
  reviewed_by        = EXCLUDED.reviewed_by,
  custodian_position = EXCLUDED.custodian_position;

-- ── Verificación ──────────────────────────────────────────────────────────────
SELECT d.code, d.name, d.current_version AS ver,
       CASE WHEN d.department_id IS NOT NULL THEN 'Dept OK ✓'
            ELSE '⚠ Dept NULL — verificar code RH' END AS dept
FROM documents d
WHERE d.code LIKE 'PR-CH-%'
ORDER BY d.code;
