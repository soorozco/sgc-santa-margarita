-- ============================================================
-- Solicitudes de Clave Nueva (Alta de Documentos)
-- Ejecutar en Supabase → SQL Editor
-- ============================================================

-- 1. Crear tabla
CREATE TABLE IF NOT EXISTS public.document_code_requests (
  id                  UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  requested_by        UUID NOT NULL REFERENCES profiles(id),
  document_type_id    UUID REFERENCES document_types(id),
  department_id       UUID REFERENCES departments(id),
  suggested_code      TEXT,
  proposed_name       TEXT NOT NULL,
  justification       TEXT,
  status              TEXT NOT NULL DEFAULT 'pending'
                        CHECK (status IN ('pending','approved','rejected')),
  assigned_code       TEXT,
  reviewed_by         UUID REFERENCES profiles(id),
  reviewed_at         TIMESTAMPTZ,
  review_notes        TEXT,
  created_document_id UUID REFERENCES documents(id),
  created_at          TIMESTAMPTZ DEFAULT now(),
  updated_at          TIMESTAMPTZ DEFAULT now()
);

-- 2. Índices
CREATE INDEX IF NOT EXISTS idx_dcr_status ON document_code_requests(status);
CREATE INDEX IF NOT EXISTS idx_dcr_reqby  ON document_code_requests(requested_by);
CREATE INDEX IF NOT EXISTS idx_dcr_dept   ON document_code_requests(department_id);

-- 3. RLS — mismo patrón que el resto del proyecto
ALTER TABLE document_code_requests ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "dcr_all" ON document_code_requests;
CREATE POLICY "dcr_all"
  ON document_code_requests FOR ALL
  TO anon, authenticated
  USING (true) WITH CHECK (true);

-- 4. Permisos
GRANT ALL ON document_code_requests TO anon, authenticated;

-- 5. Trigger updated_at
CREATE OR REPLACE FUNCTION update_dcr_timestamp()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_dcr_updated_at ON document_code_requests;
CREATE TRIGGER trg_dcr_updated_at
  BEFORE UPDATE ON document_code_requests
  FOR EACH ROW EXECUTE FUNCTION update_dcr_timestamp();

-- 6. Verificación
SELECT 'Tabla creada correctamente ✓' AS resultado;
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'document_code_requests'
ORDER BY ordinal_position;
