-- ============================================================
--  Jefatura de Enfermería — Alta de 7 Instrucciones de Trabajo
--  IT-JE-21, 33, 40, 42, 43, 44, 45
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
--
--  Departamento: JE (Jefatura de Enfermería)
--  Todos versión 03 · 30 SEP 2025
-- ============================================================

INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments WHERE code = 'JE'),
  '03', 'vigente', '2025-09-30'::date,
  'Lic. Juan Carlos Vanegas Reyes',
  'Dra. Giselle Ivette De la Torre García',
  'Jefatura de enfermería'
FROM (VALUES
  ('IT-JE-21','Instrucción de Trabajo de Manejo y Cuidado del Acceso Vascular para Hemodiálisis - FAVI'),
  ('IT-JE-33','Instrucción de Trabajo para Administración de Medicamentos Oftálmicos'),
  ('IT-JE-40','Instrucción de Trabajo para Admisión, Ingreso y Egreso del Paciente Externo a la Unidad de Hemodiálisis'),
  ('IT-JE-42','Instrucción de Trabajo de Preparación de Medicamentos Nebulizados'),
  ('IT-JE-43','Instrucción de Trabajo para el Lavado y Desinfección de Material Reutilizable de Inhaloterapia'),
  ('IT-JE-44','Instrucción de Trabajo de Solicitud de Instrumental y Material o Ropa Reusable'),
  ('IT-JE-45','Instrucción de Trabajo de Desmontaje y Sanitización de Material y Equipo')
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
            ELSE '⚠ Dept NULL — verificar code JE' END AS dept
FROM documents d
WHERE d.code IN ('IT-JE-21','IT-JE-33','IT-JE-40','IT-JE-42','IT-JE-43','IT-JE-44','IT-JE-45')
ORDER BY d.code;
