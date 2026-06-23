-- ============================================================
--  LABORATORIO — Alta de Documentos de Origen Externo
--  Hospital Santa Margarita · SGC ISO 9001:2015 · Cláusula §7.5
--  Plan correctivo: DV4 (control de documentos externos)
--
--  Ejecutar en Supabase → SQL Editor
--
--  Qué hace este script:
--    1. Crea el tipo de documento 'DE' (Documento Externo) si no existe.
--    2. Da de alta 9 documentos externos del Laboratorio (manuales de
--       fabricante de equipos biomédicos), DE-LA-001 ... DE-LA-009.
--    3. Es idempotente: ON CONFLICT (code) DO UPDATE.
--
--  Custodio asignado: Químico responsable del Laboratorio
--  Fecha de registro: 2025-11-28
-- ============================================================


-- ── 1. Crear tipo 'DE' (Documento Externo) ──────────────────────
INSERT INTO document_types (code_prefix, name, description)
VALUES (
  'DE',
  'Documento Externo',
  'Documentos de procedencia externa necesarios para el SGC: manuales de fabricante de equipos, normas, especificaciones técnicas y otros documentos no elaborados por la institución pero requeridos para la operación.'
)
ON CONFLICT (code_prefix) DO NOTHING;


-- ── 2. Alta de documentos externos del Laboratorio ──────────────
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position,
  description
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'DE'),
  (SELECT id FROM departments     WHERE code = 'LA'),
  '1.0', 'vigente', '2025-11-28'::date,
  d.fabricante,
  'Químico responsable del Laboratorio',
  'Químico responsable del Laboratorio',
  d.descripcion
FROM (VALUES
  (
    'DE-LA-001',
    'Manual del Analizador de Hematología Mindray BC-5150',
    'Mindray Bio-Medical Electronics Co., Ltd.',
    'Documento externo del fabricante. Analizador automático para hematología de 5 partes diferenciales. Uso: biometría hemática completa. Procedencia: Mindray (China). Ubicación física: archivo del Laboratorio Clínico.'
  ),
  (
    'DE-LA-002',
    'Manual del Coagulómetro Siemens BFT II',
    'Siemens Healthineers',
    'Documento externo del fabricante. Coagulómetro de dos canales para pruebas de rutina de coagulación (TP, TTPa, fibrinógeno y otros ensayos en plasma citratado). Procedencia: Siemens Healthcare Diagnostics. Ubicación física: archivo del Laboratorio Clínico.'
  ),
  (
    'DE-LA-003',
    'Manual del Sistema epoc Blood Analysis',
    'Siemens Healthineers',
    'Documento externo del fabricante. Sistema portátil de análisis de gases sanguíneos, electrolitos y metabolitos a partir de sangre completa (point-of-care). Procedencia: Siemens Healthcare Diagnostics. Ubicación física: archivo del Laboratorio Clínico.'
  ),
  (
    'DE-LA-004',
    'Manual del Analizador bioMérieux miniVIDAS Blue',
    'bioMérieux S.A.',
    'Documento externo del fabricante. Analizador inmunoenzimático automatizado (ELFA) para determinación de hormonas, marcadores tumorales y serología infecciosa. Procedencia: bioMérieux (Francia). Ubicación física: archivo del Laboratorio Clínico.'
  ),
  (
    'DE-LA-005',
    'Manual del Sistema de Química Clínica VITROS 250',
    'Ortho-Clinical Diagnostics, Inc.',
    'Documento externo del fabricante. Analizador de química clínica con tecnología de slides secos. Uso: pruebas de bioquímica clínica de rutina. Procedencia: Ortho-Clinical Diagnostics (publicación J04371). Ubicación física: archivo del Laboratorio Clínico.'
  ),
  (
    'DE-LA-006',
    'Manual del Analizador de Uroanálisis CLINITEK Status+',
    'Siemens Healthineers',
    'Documento externo del fabricante. Analizador portátil de tiras reactivas para uroanálisis y prueba de hCG. Procedencia: Siemens Healthcare Diagnostics. Ubicación física: archivo del Laboratorio Clínico.'
  ),
  (
    'DE-LA-007',
    'Manual de la Centrífuga Kitlab',
    'Kitlab',
    'Documento externo del fabricante. Centrífuga clínica de mesa para procesamiento de muestras de sangre. Procedencia: Kitlab (México). Ubicación física: archivo del Laboratorio Clínico. NOTA: confirmar modelo exacto (CK-6F, CK-12, CK-24 u otro) con el responsable del equipo.'
  ),
  (
    'DE-LA-008',
    'Manual del Microscopio Motic',
    'Motic Incorporation Ltd.',
    'Documento externo del fabricante. Microscopio óptico de uso clínico/laboratorio. Procedencia: Motic. Ubicación física: archivo del Laboratorio Clínico. NOTA: confirmar modelo exacto (familia BA210, SMZ168 u otro) con el responsable del equipo.'
  ),
  (
    'DE-LA-009',
    'Manual del Microscopio Carl Zeiss Primo Star',
    'Carl Zeiss Microscopy GmbH',
    'Documento externo del fabricante. Microscopio óptico de luz transmitida para uso clínico y de enseñanza, métodos de campo claro/oscuro y contraste de fase. Procedencia: Carl Zeiss (Alemania). Ubicación física: archivo del Laboratorio Clínico.'
  )
) AS d(code, name, fabricante, descripcion)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  description        = EXCLUDED.description,
  current_version    = EXCLUDED.current_version,
  status             = EXCLUDED.status,
  elaboration_date   = EXCLUDED.elaboration_date,
  elaborated_by      = EXCLUDED.elaborated_by,
  reviewed_by        = EXCLUDED.reviewed_by,
  custodian_position = EXCLUDED.custodian_position;


-- ── 3. Verificación ─────────────────────────────────────────────
SELECT
  d.code, d.name, d.current_version, d.status,
  dt.code_prefix AS tipo, dep.code AS depto
FROM documents d
JOIN document_types dt ON dt.id = d.document_type_id
JOIN departments    dep ON dep.id = d.department_id
WHERE dt.code_prefix = 'DE' AND dep.code = 'LA'
ORDER BY d.code;
