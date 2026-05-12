-- ============================================================
--  COORDINACIÓN SECRETARIAL — Alta de 4 Procedimientos (PR-CS-01..04)
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
--
--  ⚠ VERIFICAR ANTES DE EJECUTAR:
--  SELECT code, name FROM departments WHERE code IN ('CS','COORD');
--
--  Si decides usar COORD en lugar de CS, sustituye 'CS' → 'COORD'
--  en la subquery de department_id de abajo.
-- ============================================================

-- ── 0. Asegurar que exista el departamento CS ─────────────────
INSERT INTO departments (code, name)
VALUES ('CS', 'Coordinación Secretarial')
ON CONFLICT (code) DO NOTHING;

-- ── 1. Documentos ─────────────────────────────────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'PR'),
  (SELECT id FROM departments WHERE code = 'CS'),
  d.ver, 'vigente', d.fecha::date,
  'Coordinación de Atención Continua',
  'Dra. Giselle Ivette De la Torre García',
  'Coordinación de Atención Continua'
FROM (VALUES
  ('PR-CS-01','Procedimiento para el Ingreso de Pacientes a Hospitalización','07','2025-09-30'),
  ('PR-CS-02','Procedimiento para el Ingreso de Paciente a Urgencias',       '03','2025-09-30'),
  ('PR-CS-03','Procedimiento para la Atención a Paciente Médico Legal',       '02','2025-09-29'),
  ('PR-CS-04','Procedimiento para la Atención en el Área de Recepción Informes','02','2025-09-29')
) AS d(code, name, ver, fecha)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  current_version    = EXCLUDED.current_version,
  status             = EXCLUDED.status,
  elaboration_date   = EXCLUDED.elaboration_date,
  reviewed_by        = EXCLUDED.reviewed_by,
  custodian_position = EXCLUDED.custodian_position;

-- ── Verificación ──────────────────────────────────────────────
SELECT d.code, d.name, d.current_version AS ver,
       CASE WHEN d.department_id IS NOT NULL THEN 'Dept OK ✓'
            ELSE '⚠ Dept NULL — verificar code CS' END AS dept
FROM documents d
WHERE d.code LIKE 'PR-CS-%'
ORDER BY d.code;
