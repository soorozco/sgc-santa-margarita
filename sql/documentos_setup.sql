-- ============================================================
--  CONTROL DE DOCUMENTOS — Cláusula 7.5
--  Hospital Santa Margarita — SGC ISO 9001:2015
--
--  INSTRUCCIONES:
--  1. Ejecutar este archivo completo en Supabase → SQL Editor
--  2. Después de ejecutar, crear el bucket de Storage:
--     Storage → New bucket → nombre: "sgc-documents" → Private
--  3. Los PDFs se suben desde la interfaz web del sistema
-- ============================================================


-- ── 1. TABLA: Tipos de documento ────────────────────────────────
CREATE TABLE IF NOT EXISTS document_types (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  code_prefix text        NOT NULL UNIQUE,   -- Ej. FT, IT, PR
  name        text        NOT NULL,
  description text,
  created_at  timestamptz NOT NULL DEFAULT now()
);

-- Catálogo inicial de tipos
INSERT INTO document_types (code_prefix, name, description) VALUES
  ('FT',  'Formato',               'Plantillas y formularios de registro'),
  ('IT',  'Instrucción de Trabajo','Pasos detallados para actividades operativas'),
  ('PR',  'Procedimiento',         'Procesos del SGC con responsables y flujo'),
  ('PT',  'Política',              'Declaraciones de dirección y compromisos'),
  ('MN',  'Manual',                'Documentos de referencia general del SGC'),
  ('PL',  'Plan',                  'Planes de calidad, auditoría u otros'),
  ('RG',  'Registro',              'Evidencia de actividades realizadas')
ON CONFLICT (code_prefix) DO NOTHING;


-- ── 2. TABLA: Departamentos ──────────────────────────────────────
--  (Puede que ya exista; el ON CONFLICT evita errores)
CREATE TABLE IF NOT EXISTS departments (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  code        text        NOT NULL UNIQUE,
  name        text        NOT NULL,
  is_active   boolean     NOT NULL DEFAULT true,
  created_at  timestamptz NOT NULL DEFAULT now()
);

-- Departamentos del hospital
INSERT INTO departments (code, name) VALUES
  ('AR',  'Archivo Clínico'),
  ('ADM', 'Administración'),
  ('CAL', 'Calidad'),
  ('ENF', 'Enfermería'),
  ('FAR', 'Farmacia'),
  ('IMG', 'Imagenología'),
  ('LAB', 'Laboratorio'),
  ('LAV', 'Lavandería'),
  ('LIM', 'Limpieza'),
  ('MAN', 'Mantenimiento'),
  ('NUT', 'Nutrición'),
  ('QX',  'Quirófano y CEYE'),
  ('RH',  'Recursos Humanos'),
  ('UVH', 'UVEH'),
  ('RHB', 'Rehabilitación'),
  ('BSG', 'Banco de Sangre'),
  ('SEG', 'Seguridad'),
  ('DIR', 'Dirección General')
ON CONFLICT (code) DO NOTHING;


-- ── 3. TABLA: Documentos (Lista Maestra) ────────────────────────
CREATE TABLE IF NOT EXISTS documents (
  id                   uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  code                 text        NOT NULL UNIQUE,
  name                 text        NOT NULL,
  document_type_id     uuid        REFERENCES document_types(id),
  department_id        uuid        REFERENCES departments(id),
  custodian_position   text,
  description          text,
  current_version      text        NOT NULL DEFAULT '1.0',
  status               text        NOT NULL DEFAULT 'borrador'
                         CHECK (status IN ('borrador','en_revision','en_aprobacion','vigente','obsoleto')),
  retention_years      integer     DEFAULT 2,
  elaboration_date     date,
  elaborated_by        text,
  reviewed_by          text,
  created_by           uuid        REFERENCES auth.users(id),
  created_at           timestamptz NOT NULL DEFAULT now(),
  updated_at           timestamptz NOT NULL DEFAULT now()
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_documents_code   ON documents(code);
CREATE INDEX IF NOT EXISTS idx_documents_status ON documents(status);
CREATE INDEX IF NOT EXISTS idx_documents_dept   ON documents(department_id);

-- Trigger para updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END; $$;

DROP TRIGGER IF EXISTS trg_documents_updated_at ON documents;
CREATE TRIGGER trg_documents_updated_at
  BEFORE UPDATE ON documents
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ── 4. TABLA: Versiones de documentos ───────────────────────────
CREATE TABLE IF NOT EXISTS document_versions (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  document_id      uuid        NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  version          text        NOT NULL,
  change_summary   text,
  change_date      date,
  file_path        text,
  file_name        text,
  file_size_bytes  bigint,
  file_mime_type   text,
  status           text        DEFAULT 'vigente',
  submitted_by     uuid        REFERENCES auth.users(id),
  submitted_at     timestamptz,
  created_at       timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_doc_versions_doc ON document_versions(document_id);


-- ── 5. RLS — Row Level Security ──────────────────────────────────
ALTER TABLE document_types    ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents         ENABLE ROW LEVEL SECURITY;
ALTER TABLE document_versions ENABLE ROW LEVEL SECURITY;

-- document_types: lectura pública para usuarios autenticados
DROP POLICY IF EXISTS "doc_types_read"  ON document_types;
CREATE POLICY "doc_types_read" ON document_types
  FOR SELECT TO authenticated USING (true);

-- documents: lectura pública, escritura solo autenticados
DROP POLICY IF EXISTS "docs_read"   ON documents;
DROP POLICY IF EXISTS "docs_write"  ON documents;
CREATE POLICY "docs_read"  ON documents FOR SELECT TO authenticated USING (true);
CREATE POLICY "docs_write" ON documents FOR ALL    TO authenticated USING (true);

-- document_versions: igual
DROP POLICY IF EXISTS "docver_read"  ON document_versions;
DROP POLICY IF EXISTS "docver_write" ON document_versions;
CREATE POLICY "docver_read"  ON document_versions FOR SELECT TO authenticated USING (true);
CREATE POLICY "docver_write" ON document_versions FOR ALL    TO authenticated USING (true);

-- departments: lectura pública
DROP POLICY IF EXISTS "depts_read" ON departments;
CREATE POLICY "depts_read" ON departments FOR SELECT TO authenticated USING (true);


-- ── 6. DATOS INICIALES — Documentos reales de Archivo ───────────
--
--  Todos se insertan como "vigente" porque ya son documentos
--  aprobados y en uso. Los PDFs se suben después desde la web.
-- ────────────────────────────────────────────────────────────────

-- Usamos CTEs para resolver los IDs de tipo y departamento
WITH
  dept AS (SELECT id FROM departments WHERE code = 'AR'  LIMIT 1),
  t_ft AS (SELECT id FROM document_types WHERE code_prefix = 'FT' LIMIT 1),
  t_it AS (SELECT id FROM document_types WHERE code_prefix = 'IT' LIMIT 1),
  t_pr AS (SELECT id FROM document_types WHERE code_prefix = 'PR' LIMIT 1)

INSERT INTO documents
  (code, name, document_type_id, department_id,
   custodian_position, current_version, status,
   elaboration_date, retention_years, description)
VALUES

  -- ── FORMATOS ──────────────────────────────────────────────────
  (
    'FT-AR-01',
    'Formato para la Solicitud de Copias de Expedientes',
    (SELECT id FROM t_ft),
    (SELECT id FROM dept),
    'Responsable de Archivo Clínico',
    '1.0', 'vigente',
    NULL, 5,
    'Formulario utilizado por pacientes o familiares para solicitar copias de su expediente clínico.'
  ),
  (
    'FT-AR-02',
    'Formato de Préstamo de Expedientes',
    (SELECT id FROM t_ft),
    (SELECT id FROM dept),
    'Responsable de Archivo Clínico',
    '1.0', 'vigente',
    NULL, 5,
    'Registro de préstamo interno de expedientes clínicos a personal autorizado del hospital.'
  ),

  -- ── INSTRUCCIONES DE TRABAJO ───────────────────────────────────
  (
    'IT-AR-01',
    'Instrucción de Trabajo para el Acceso a la Información del Expediente Clínico Cerrado',
    (SELECT id FROM t_it),
    (SELECT id FROM dept),
    'Responsable de Archivo Clínico',
    '1.0', 'vigente',
    NULL, 5,
    'Define los pasos y criterios para que el personal autorizado acceda a expedientes clínicos en archivo muerto.'
  ),
  (
    'IT-AR-02',
    'Instrucción de Trabajo para la Destrucción de Archivo Muerto',
    (SELECT id FROM t_it),
    (SELECT id FROM dept),
    'Responsable de Archivo Clínico',
    '1.0', 'vigente',
    NULL, 5,
    'Establece el procedimiento seguro para la destrucción de expedientes clínicos una vez cumplido su tiempo de resguardo legal.'
  ),
  (
    'IT-AR-03',
    'Instrucción de Trabajo para Recolección de Expedientes en Urgencias',
    (SELECT id FROM t_it),
    (SELECT id FROM dept),
    'Responsable de Archivo Clínico',
    '1.0', 'vigente',
    NULL, 5,
    'Describe el proceso para la recolección y devolución de expedientes clínicos del área de Urgencias.'
  ),
  (
    'IT-AR-04',
    'Instrucción de Trabajo para la Recolección de Expedientes en Hospitalización',
    (SELECT id FROM t_it),
    (SELECT id FROM dept),
    'Responsable de Archivo Clínico',
    '1.0', 'vigente',
    NULL, 5,
    'Detalla los pasos para la recolección de expedientes de pacientes egresados del área de Hospitalización.'
  ),
  (
    'IT-AR-05',
    'Instrucción de Trabajo para Solicitud de Papelería y Material de Trabajo para Archivo',
    (SELECT id FROM t_it),
    (SELECT id FROM dept),
    'Responsable de Archivo Clínico',
    '1.0', 'vigente',
    NULL, 2,
    'Establece el proceso para la solicitud y control de papelería y materiales de trabajo del departamento de Archivo.'
  ),

  -- ── PROCEDIMIENTOS ─────────────────────────────────────────────
  (
    'PR-AR-01',
    'Procedimiento para el Préstamo Interno de Expedientes Clínicos',
    (SELECT id FROM t_pr),
    (SELECT id FROM dept),
    'Responsable de Archivo Clínico',
    '1.0', 'vigente',
    NULL, 5,
    'Define el flujo completo para la solicitud, autorización, préstamo y devolución de expedientes clínicos a personal del hospital.'
  ),
  (
    'PR-AR-03',
    'Procedimiento para la Recolección de Expedientes en Urgencias',
    (SELECT id FROM t_pr),
    (SELECT id FROM dept),
    'Responsable de Archivo Clínico',
    '1.0', 'vigente',
    NULL, 5,
    'Describe el proceso y responsabilidades para la recolección oportuna de expedientes del área de Urgencias.'
  )

ON CONFLICT (code) DO NOTHING;


-- ── Verificación ─────────────────────────────────────────────────
SELECT
  d.code,
  dt.code_prefix AS tipo,
  dp.code        AS depto,
  d.current_version AS version,
  d.status
FROM documents d
LEFT JOIN document_types dt ON dt.id = d.document_type_id
LEFT JOIN departments    dp ON dp.id = d.department_id
ORDER BY d.code;
