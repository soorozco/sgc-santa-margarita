CREATE TABLE IF NOT EXISTS public.document_deactivation_requests (
  id            UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  document_id   UUID NOT NULL REFERENCES documents(id),
  requested_by  UUID NOT NULL REFERENCES profiles(id),
  reason        TEXT,
  status        TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','approved','rejected')),
  reviewed_by   UUID REFERENCES profiles(id),
  reviewed_at   TIMESTAMPTZ,
  reviewer_comment TEXT,
  created_at    TIMESTAMPTZ DEFAULT now()
);
-- Índices
CREATE INDEX IF NOT EXISTS idx_ddr_document ON document_deactivation_requests(document_id);
CREATE INDEX IF NOT EXISTS idx_ddr_status   ON document_deactivation_requests(status);
CREATE INDEX IF NOT EXISTS idx_ddr_reqby    ON document_deactivation_requests(requested_by);
