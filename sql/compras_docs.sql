-- ============================================================
--  COMPRAS — Alta de 1 Procedimiento (PR-JC-05)
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
--
--  Nota: el código usa prefijo JC (Jefatura de Compras)
--  pero el departamento en DB es code = 'COM' (Compras)
-- ============================================================

INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position
)
SELECT
  'PR-JC-05',
  'Procedimiento para la Solicitud, Control, Entrega y Suministro de Tóner',
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments WHERE code = 'COM'),
  '01', 'vigente', '2025-08-04'::date,
  'Hna. María de Jesús Gómez Flores',
  'Dra. Giselle Ivette De la Torre García',
  'Jefa o Jefe de Almacén'
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
            ELSE '⚠ Dept NULL — verificar code COM' END AS dept
FROM documents d WHERE d.code = 'PR-JC-05';
