-- ============================================================
-- Tabla: document_code_requests
-- Solicitudes de clave nueva para Control de Documentos
-- ============================================================

CREATE TABLE IF NOT EXISTS public.document_code_requests (
  id                 UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  requested_by       UUID NOT NULL REFERENCES profiles(id),
  document_type_id   UUID REFERENCES document_types(id),
  department_id      UUID REFERENCES departments(id),
  suggested_code     TEXT,
  proposed_name      TEXT NOT NULL,
  justification      TEXT,
  status             TEXT NOT NULL DEFAULT 'pending'
                       CHECK (status IN ('pending','approved','rejected')),
  assigned_code      TEXT,
  reviewed_by        UUID REFERENCES profiles(id),
  reviewed_at        TIMESTAMPTZ,
  review_notes       TEXT,
  created_document_id UUID REFERENCES documents(id),
  created_at         TIMESTAMPTZ DEFAULT now(),
  updated_at         TIMESTAMPTZ DEFAULT now()
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_dcr_status    ON document_code_requests(status);
CREATE INDEX IF NOT EXISTS idx_dcr_reqby     ON document_code_requests(requested_by);
CREATE INDEX IF NOT EXISTS idx_dcr_dept      ON document_code_requests(department_id);

-- RLS
ALTER TABLE document_code_requests ENABLE ROW LEVEL SECURITY;

-- Cualquier usuario autenticado puede ver sus propias solicitudes
CREATE POLICY "users_see_own_requests"
  ON document_code_requests FOR SELECT
  USING (requested_by = auth.uid());

-- Admin y responsable_calidad ven todas
CREATE POLICY "admins_see_all_requests"
  ON document_code_requests FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM profiles p
      JOIN roles r ON p.role_id = r.id
      WHERE p.id = auth.uid()
        AND r.name IN ('administrador','responsable_calidad')
    )
  );

-- Usuarios con rol escritor pueden crear solicitudes
CREATE POLICY "writers_can_insert"
  ON document_code_requests FOR INSERT
  WITH CHECK (auth.uid() = requested_by);

-- Solo admin/responsable_calidad pueden actualizar (revisar)
CREATE POLICY "admins_can_update"
  ON document_code_requests FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM profiles p
      JOIN roles r ON p.role_id = r.id
      WHERE p.id = auth.uid()
        AND r.name IN ('administrador','responsable_calidad')
    )
  );

-- Trigger para updated_at
CREATE OR REPLACE FUNCTION update_dcr_timestamp()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_dcr_updated_at
  BEFORE UPDATE ON document_code_requests
  FOR EACH ROW EXECUTE FUNCTION update_dcr_timestamp();
