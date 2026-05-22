-- ============================================================
--  Calidad — Formatos FT-CA y Manual MA-CA
--  33 Formatos: FT-CA-01 a FT-CA-39 (con huecos)
--  1 Manual:    MA-CA-02
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- ── 1. Asegurar departamento CA ───────────────────────────────
INSERT INTO departments (code, name)
SELECT 'CA', 'Jefatura de Calidad'
WHERE NOT EXISTS (SELECT 1 FROM departments WHERE code = 'CA');

-- ── 2. Asegurar tipo de documento MA (Manual) ─────────────────
INSERT INTO document_types (code_prefix, name)
SELECT 'MA', 'Manual'
WHERE NOT EXISTS (SELECT 1 FROM document_types WHERE code_prefix = 'MA');

-- ── 3. Alta de Formatos FT-CA ─────────────────────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'FT' LIMIT 1),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  d.ver, 'vigente',
  'Jefatura de Calidad'
FROM (VALUES
  ('FT-CA-01', 'Lista de Asistencia',                                          '4'),
  ('FT-CA-03', 'Solicitud de Documento',                                       '4'),
  ('FT-CA-04', 'Lista Maestra de Documentos',                                  '1'),
  ('FT-CA-05', 'Formato para Procedimiento',                                   '4'),
  ('FT-CA-06', 'Formato para Instrucción de Trabajo',                          '4'),
  ('FT-CA-07', 'Formato para Políticas',                                       '4'),
  ('FT-CA-11', 'Minuta de Sesiones de Comités',                               '3'),
  ('FT-CA-12', 'Acción Correctiva',                                            '2'),
  ('FT-CA-13', 'Agenda de Auditoría Interna',                                  '3'),
  ('FT-CA-14', 'Formato de Indicadores',                                       '1'),
  ('FT-CA-15', 'Lista de Verificación de Auditoría',                           '3'),
  ('FT-CA-16', 'Seguimiento de Hallazgos de Auditoría',                       '3'),
  ('FT-CA-17', 'Hallazgos de Auditoría Interna',                              '3'),
  ('FT-CA-18', 'Guía de Llenado',                                             '1'),
  ('FT-CA-19', 'Formato de Planificación y Seguimiento de Cambios',           '1'),
  ('FT-CA-20', 'Matriz de Riesgos',                                           '1'),
  ('FT-CA-21', 'Bitácora para el Seguimiento de Acciones',                    '1'),
  ('FT-CA-22', 'Registro de Acciones de Mejora',                              '1'),
  ('FT-CA-23', 'Entradas y Salidas del SGC',                                  '1'),
  ('FT-CA-24', 'Recepción de Felicitaciones, Sugerencias o Quejas',           '3'),
  ('FT-CA-25', 'Reprogramación de Auditoría Interna',                         '3'),
  ('FT-CA-26', 'Evaluación a Auditor Interno',                                '1'),
  ('FT-CA-27', 'Análisis de Desviaciones',                                    '1'),
  ('FT-CA-29', 'Bitácora de Registro y Seguimiento de Quejas',                '2'),
  ('FT-CA-31', 'Proyecto de Mejora',                                          '2'),
  ('FT-CA-32', 'Revisión por Parte de la Dirección',                          '2'),
  ('FT-CA-33', 'Encuesta de Satisfacción',                                    '1'),
  ('FT-CA-34', 'Formato de Calendario de Sesiones',                           '1'),
  ('FT-CA-35', 'Lista de Asistencia de Comité',                               '1'),
  ('FT-CA-36', 'Formato de Acta de Instalación de Comités',                   '1'),
  ('FT-CA-37', 'Acción Preventiva',                                           '1'),
  ('FT-CA-38', 'Seguimiento de Proyecto de Mejora',                           '1'),
  ('FT-CA-39', 'Plan Anual de Auditorías Internas',                           '1')
) AS d(code, name, ver)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  document_type_id   = EXCLUDED.document_type_id,
  department_id      = EXCLUDED.department_id,
  current_version    = EXCLUDED.current_version,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- ── 4. Alta del Manual MA-CA-02 ───────────────────────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position
)
SELECT
  'MA-CA-02',
  'Manual de Integración y Funcionamiento del Comité de Calidad y Seguridad del Paciente',
  (SELECT id FROM document_types WHERE code_prefix = 'MA' LIMIT 1),
  (SELECT id FROM departments WHERE code = 'CA' LIMIT 1),
  '1', 'vigente', 'Jefatura de Calidad'
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  document_type_id   = EXCLUDED.document_type_id,
  department_id      = EXCLUDED.department_id,
  current_version    = EXCLUDED.current_version,
  status             = EXCLUDED.status,
  custodian_position = EXCLUDED.custodian_position;

-- ── 5. Forzar department_id (por si quedó NULL) ───────────────
UPDATE documents
SET department_id = (SELECT id FROM departments WHERE code = 'CA' LIMIT 1)
WHERE code LIKE 'FT-CA-%' OR code LIKE 'MA-CA-%';

-- ── 6. Verificación ───────────────────────────────────────────
SELECT d.code, d.name, d.current_version AS ver,
       dt.code_prefix AS tipo,
       CASE WHEN d.department_id IS NOT NULL THEN 'Dept OK ✓' ELSE '⚠ Dept NULL' END AS dept
FROM documents d
JOIN document_types dt ON dt.id = d.document_type_id
WHERE d.code LIKE 'FT-CA-%' OR d.code LIKE 'MA-CA-%'
ORDER BY d.code;
