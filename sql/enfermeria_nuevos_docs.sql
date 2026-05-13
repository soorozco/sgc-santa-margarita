-- ============================================================
--  Jefatura de Enfermería — Alta de 8 Instrucciones de Trabajo
--  IT-JE-18, 19, 20, 22, 26, 39, 41, 46
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
--
--  Departamento: JE (Jefatura de Enfermería)
--  Todos versión 03 · 30 SEP 2025
-- ============================================================

-- ── 1. Alta del departamento JE si no existe ──────────────────
INSERT INTO departments (code, name)
SELECT 'JE', 'Jefatura de Enfermería'
WHERE NOT EXISTS (SELECT 1 FROM departments WHERE code = 'JE');

-- ── 2. Alta / actualización de los 8 documentos ───────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments WHERE code = 'JE' LIMIT 1),
  '03', 'vigente', '2025-09-30'::date,
  'Lic. Juan Carlos Vanegas Reyes',
  'Dra. Giselle Ivette De la Torre García',
  'Jefatura de enfermería'
FROM (VALUES
  ('IT-JE-18','Instrucción de Trabajo para el Manejo de Medidas Precautorias para el Personal de Hemodiálisis'),
  ('IT-JE-19','Instrucción de Trabajo para Manejo de Usuario con Serología Positiva en Hemodiálisis'),
  ('IT-JE-20','Instrucción de Trabajo para el Manejo y Cuidado del Acceso Vascular para Hemodiálisis - Catéter'),
  ('IT-JE-22','Instrucción de Trabajo para la Técnica de Sanitización de la Máquina de Hemodiálisis'),
  ('IT-JE-26','Instrucción de Trabajo para la Intervención de Enfermería en el Tratamiento de Hemodiálisis'),
  ('IT-JE-39','Instrucción de Trabajo para la Admisión, Ingreso y Egreso del Paciente Hospitalizado a la Unidad de Hemodiálisis'),
  ('IT-JE-41','Instrucción de Trabajo para Nebulización de Pacientes'),
  ('IT-JE-46','Instrucción de Trabajo para Manejo de Ropa Hospitalaria')
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
SET department_id = (SELECT id FROM departments WHERE code = 'JE' LIMIT 1)
WHERE code IN ('IT-JE-18','IT-JE-19','IT-JE-20','IT-JE-22','IT-JE-26','IT-JE-39','IT-JE-41','IT-JE-46');

-- ── 4. Verificación ───────────────────────────────────────────
SELECT d.code, d.name, d.current_version AS ver,
       CASE WHEN d.department_id IS NOT NULL THEN 'Dept OK ✓'
            ELSE '⚠ Dept NULL — verificar code JE' END AS dept
FROM documents d
WHERE d.code IN ('IT-JE-18','IT-JE-19','IT-JE-20','IT-JE-22','IT-JE-26','IT-JE-39','IT-JE-41','IT-JE-46')
ORDER BY d.code;
