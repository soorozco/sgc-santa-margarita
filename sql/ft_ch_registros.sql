-- ============================================================
--  Control de Registros — Formatos FT de Capital Humano
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- ── Asegurar columnas extendidas en documents ────────────────
ALTER TABLE documents ADD COLUMN IF NOT EXISTS issue_date      date;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS elaboro_nombre  text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS elaboro_cargo   text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS reviso_nombre   text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS reviso_cargo    text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS autorizo_nombre text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS autorizo_cargo  text;

-- ── Asegurar que el departamento CH exista ───────────────────
INSERT INTO departments (code, name, is_active)
VALUES ('CH', 'Capital Humano', true)
ON CONFLICT (code) DO NOTHING;

-- ── Insertar formatos FT-CH ──────────────────────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  retention_years,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'FT'),
  (SELECT id FROM departments     WHERE code = 'CH'),
  d.ver, 'vigente', 'Jefe de Capital Humano',
  d.ret,
  'Lic. Jorge Octavio Ramírez Chávez', 'Jefe de Capital Humano',
  'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
  'Hna. Maria de Jesus Garcia Castro', 'Dirección General'
FROM (VALUES
  ('FT-CH-01', 'Solicitud de Permiso',                          '1', NULL),
  ('FT-CH-02', 'Requisición de Personal',                       '1', NULL),
  ('FT-CH-03', 'Solicitud Interna de Trabajo',                  '1', NULL),
  ('FT-CH-05', 'Solicitud de Referencias Laborales',            '1', NULL),
  ('FT-CH-06', 'Checklist Integración de Expediente',           '1', NULL),
  ('FT-CH-07', 'Alta de Nómina',                                '1', NULL),
  ('FT-CH-08', 'Formato Control de Riesgos de Trabajo',         '1', NULL),
  ('FT-CH-25', 'Evidencia de Capacitación',                     '1', NULL),
  ('FT-CH-34', 'Detección de Necesidades de Capacitación',      '1', NULL),
  ('FT-CH-35', 'Formato de Entrevista de Salida',               '1', NULL),
  ('FT-CH-40', 'Solicitud de Vacaciones',                       '1', NULL),
  ('FT-CH-42', 'Reporte de Entrevista',                         '1', NULL),
  ('FT-CH-47', 'Formato de Evaluación de Desempeño',            '1', NULL),
  ('FT-CH-48', 'Lista de Asistencia',                           '1', NULL),
  ('FT-CH-49', 'Encuesta de Clima Laboral',                     '1', NULL)
) AS d(code, name, ver, ret)
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'CH')
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  current_version    = EXCLUDED.current_version,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position,
  elaboro_nombre     = EXCLUDED.elaboro_nombre,
  elaboro_cargo      = EXCLUDED.elaboro_cargo,
  reviso_nombre      = EXCLUDED.reviso_nombre,
  reviso_cargo       = EXCLUDED.reviso_cargo,
  autorizo_nombre    = EXCLUDED.autorizo_nombre,
  autorizo_cargo     = EXCLUDED.autorizo_cargo;

-- ── Verificación ─────────────────────────────────────────────
SELECT
  d.code,
  d.name,
  d.current_version AS ver,
  d.retention_years  AS retención_años,
  d.status
FROM documents d
JOIN document_types dt ON dt.id = d.document_type_id
JOIN departments    dp ON dp.id = d.department_id
WHERE dt.code_prefix = 'FT'
  AND dp.code = 'CH'
ORDER BY d.code;
