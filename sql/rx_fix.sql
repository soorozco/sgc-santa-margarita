-- ═══════════════════════════════════════════════════════════════════
-- FIX: Radiología e Imagen — Crear departamento e insertar documentos
-- Ejecutar en Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════════

-- ── 1. Crear departamento si no existe ──────────────────────────────
INSERT INTO departments (name, code, is_active)
SELECT 'Radiología e Imagen', 'RX', true
WHERE NOT EXISTS (SELECT 1 FROM departments WHERE code = 'RX');

-- ── 2. Insertar documentos (con department_id correcto) ─────────────
--    Si ya existen con department_id NULL, los actualiza.
--    Si no existen, los inserta.

-- PR-RX-01
INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-01',
  'Procesos para Toma de Estudios Contrastados de Hospitalización',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE code='RX'),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-01');

UPDATE documents SET
  department_id = (SELECT id FROM departments WHERE code='RX')
WHERE code='PR-RX-01' AND department_id IS NULL;

-- PR-RX-02
INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-02',
  'Proceso de Solicitud para la Realización de Estudios Contrastados de Pacientes de Urgencias',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE code='RX'),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-02');

UPDATE documents SET
  department_id = (SELECT id FROM departments WHERE code='RX')
WHERE code='PR-RX-02' AND department_id IS NULL;

-- PR-RX-03
INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-03',
  'Proceso de Solicitud para la Realización de Estudios de Radiología Simples de Pacientes Externos',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE code='RX'),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-03');

UPDATE documents SET
  department_id = (SELECT id FROM departments WHERE code='RX')
WHERE code='PR-RX-03' AND department_id IS NULL;

-- PR-RX-04
INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-04',
  'Proceso de Solicitud para la Realización de Estudios de Radiografías Simples de Pacientes Hospitalizados',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE code='RX'),
  '3', 'vigente', '2025-09-29',
  'Dr. Stanislawsky Vázquez Hernández', 'Dra. Giselle Ivette De la Torre García'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-04');

UPDATE documents SET
  department_id = (SELECT id FROM departments WHERE code='RX')
WHERE code='PR-RX-04' AND department_id IS NULL;

-- PR-RX-05
INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-05',
  'Proceso de Solicitud para la Realización de Estudios Contrastados en Pacientes Externos',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE code='RX'),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-05');

UPDATE documents SET
  department_id = (SELECT id FROM departments WHERE code='RX')
WHERE code='PR-RX-05' AND department_id IS NULL;

-- PR-RX-06
INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-06',
  'Proceso de Solicitud para la Realización de Estudios Contrastados de Pacientes de Hospitalización con COVID',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE code='RX'),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-06');

UPDATE documents SET
  department_id = (SELECT id FROM departments WHERE code='RX')
WHERE code='PR-RX-06' AND department_id IS NULL;

-- PR-RX-07
INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-07',
  'Proceso de Solicitud para la Realización de Estudios de Radiología Simples de Pacientes Externos con COVID',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE code='RX'),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-07');

UPDATE documents SET
  department_id = (SELECT id FROM departments WHERE code='RX')
WHERE code='PR-RX-07' AND department_id IS NULL;

-- PR-RX-08
INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-08',
  'Proceso de Solicitud para la Realización de Estudios Contrastados en Pacientes Externos con COVID',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE code='RX'),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-08');

UPDATE documents SET
  department_id = (SELECT id FROM departments WHERE code='RX')
WHERE code='PR-RX-08' AND department_id IS NULL;

-- PR-RX-09
INSERT INTO documents (code, name, document_type_id, department_id, current_version, status, elaboration_date, elaborated_by, reviewed_by)
SELECT 'PR-RX-09',
  'Proceso de Solicitud para la Realización de Estudios de Radiografías Simples de Pacientes de Hospitalización con COVID',
  (SELECT id FROM document_types WHERE code_prefix='PR' LIMIT 1),
  (SELECT id FROM departments WHERE code='RX'),
  '2', 'vigente', '2024-08-27',
  'Dr. Juan Carlos Ledesma Perea', 'Dr. José Gonzalo Vázquez Camacho'
WHERE NOT EXISTS (SELECT 1 FROM documents WHERE code='PR-RX-09');

UPDATE documents SET
  department_id = (SELECT id FROM departments WHERE code='RX')
WHERE code='PR-RX-09' AND department_id IS NULL;

-- ── 3. Verificación ─────────────────────────────────────────────────
SELECT
  d.code,
  d.name,
  dep.name AS departamento,
  d.current_version AS version,
  d.status,
  CASE WHEN dc.id IS NOT NULL THEN 'Con contenido' ELSE 'Sin contenido' END AS contenido
FROM documents d
LEFT JOIN departments dep ON dep.id = d.department_id
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code LIKE 'PR-RX-%'
ORDER BY d.code;
