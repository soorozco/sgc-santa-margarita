-- ============================================================
--  MÓDULO COMITÉS — COCASEP
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- ── 1. Comités ───────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS committees (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  code        text        NOT NULL UNIQUE,
  name        text        NOT NULL,
  acronym     text,
  description text,
  is_active   boolean     NOT NULL DEFAULT true,
  created_at  timestamptz NOT NULL DEFAULT now()
);

-- ── 2. Integrantes ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS committee_members (
  id             uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  committee_id   uuid        NOT NULL REFERENCES committees(id) ON DELETE CASCADE,
  full_name      text        NOT NULL,
  role           text        NOT NULL DEFAULT 'vocal'
                               CHECK (role IN ('presidenta','secretaria','vocal','invitado')),
  position_title text,
  department     text,
  is_active      boolean     NOT NULL DEFAULT true,
  sort_order     integer     NOT NULL DEFAULT 99,
  created_at     timestamptz NOT NULL DEFAULT now()
);

-- ── 3. Sesiones ──────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS committee_sessions (
  id             uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  committee_id   uuid        NOT NULL REFERENCES committees(id),
  session_year   integer     NOT NULL DEFAULT EXTRACT(year FROM now())::integer,
  session_number integer     NOT NULL DEFAULT 1,
  session_date   date        NOT NULL,
  session_time   time,
  session_type   text        NOT NULL DEFAULT 'ordinaria'
                               CHECK (session_type IN ('ordinaria','extraordinaria')),
  status         text        NOT NULL DEFAULT 'programada'
                               CHECK (status IN ('programada','realizada','cancelada')),
  location       text,
  agenda         text,
  notes          text,
  created_by     uuid        REFERENCES auth.users(id),
  created_at     timestamptz NOT NULL DEFAULT now(),
  updated_at     timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_sessions_committee ON committee_sessions(committee_id);
CREATE INDEX IF NOT EXISTS idx_sessions_date      ON committee_sessions(session_date);
CREATE INDEX IF NOT EXISTS idx_sessions_year      ON committee_sessions(session_year);

-- ── 4. Asistencia ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS session_attendance (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id    uuid        NOT NULL REFERENCES committee_sessions(id) ON DELETE CASCADE,
  member_id     uuid        NOT NULL REFERENCES committee_members(id),
  attended      boolean     NOT NULL DEFAULT false,
  justification text,
  created_at    timestamptz NOT NULL DEFAULT now(),
  UNIQUE (session_id, member_id)
);

CREATE INDEX IF NOT EXISTS idx_attendance_session ON session_attendance(session_id);

-- ── 5. Acuerdos ──────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS session_agreements (
  id              uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id      uuid        NOT NULL REFERENCES committee_sessions(id) ON DELETE CASCADE,
  committee_id    uuid        NOT NULL REFERENCES committees(id),
  description     text        NOT NULL,
  responsible     text,
  due_date        date,
  status          text        NOT NULL DEFAULT 'pendiente'
                                CHECK (status IN ('pendiente','en_proceso','cumplido','cancelado')),
  follow_up_notes text,
  created_at      timestamptz NOT NULL DEFAULT now(),
  updated_at      timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_agreements_session   ON session_agreements(session_id);
CREATE INDEX IF NOT EXISTS idx_agreements_committee ON session_agreements(committee_id);
CREATE INDEX IF NOT EXISTS idx_agreements_status    ON session_agreements(status);

-- ── Triggers updated_at ──────────────────────────────────────────
CREATE OR REPLACE FUNCTION update_committee_ts()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END; $$;

DROP TRIGGER IF EXISTS trg_sessions_ts   ON committee_sessions;
DROP TRIGGER IF EXISTS trg_agreements_ts ON session_agreements;
CREATE TRIGGER trg_sessions_ts
  BEFORE UPDATE ON committee_sessions
  FOR EACH ROW EXECUTE FUNCTION update_committee_ts();
CREATE TRIGGER trg_agreements_ts
  BEFORE UPDATE ON session_agreements
  FOR EACH ROW EXECUTE FUNCTION update_committee_ts();

-- ── RLS ──────────────────────────────────────────────────────────
ALTER TABLE committees        ENABLE ROW LEVEL SECURITY;
ALTER TABLE committee_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE committee_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_agreements ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "cmt_all"  ON committees;
DROP POLICY IF EXISTS "mbr_all"  ON committee_members;
DROP POLICY IF EXISTS "ses_all"  ON committee_sessions;
DROP POLICY IF EXISTS "att_all"  ON session_attendance;
DROP POLICY IF EXISTS "agr_all"  ON session_agreements;

CREATE POLICY "cmt_all" ON committees        FOR ALL TO authenticated USING (true);
CREATE POLICY "mbr_all" ON committee_members  FOR ALL TO authenticated USING (true);
CREATE POLICY "ses_all" ON committee_sessions FOR ALL TO authenticated USING (true);
CREATE POLICY "att_all" ON session_attendance FOR ALL TO authenticated USING (true);
CREATE POLICY "agr_all" ON session_agreements FOR ALL TO authenticated USING (true);

-- ── Datos iniciales — COCASEP ─────────────────────────────────────
INSERT INTO committees (code, name, acronym, description) VALUES (
  'COCASEP',
  'Comité de Calidad y Seguridad del Paciente',
  'COCASEP',
  'Órgano responsable de llevar a cabo las estrategias para establecer mejoras de calidad y seguridad del paciente. Ref: MA-CA-02.'
) ON CONFLICT (code) DO NOTHING;

-- Integrantes — Manual MA-CA-02 (actualiza los nombres en la sección Integrantes)
WITH c AS (SELECT id FROM committees WHERE code = 'COCASEP' LIMIT 1)
INSERT INTO committee_members
  (committee_id, full_name, role, position_title, department, sort_order)
VALUES
  ((SELECT id FROM c), 'Hna. María de Jesús García Castro',    'presidenta', 'Directora General',                    'Dirección General',   1),
  ((SELECT id FROM c), 'Responsable de Calidad',               'secretaria', 'Jefe(a) del Departamento de Calidad',  'Calidad',             2),
  ((SELECT id FROM c), 'Responsable de Administración',        'vocal',      'Jefe(a) de Administración',            'Administración',      3),
  ((SELECT id FROM c), 'Responsable de Seguridad e Higiene',   'vocal',      'Responsable de Seguridad e Higiene',   'Seguridad e Higiene', 4),
  ((SELECT id FROM c), 'Responsable de Capital Humano',        'vocal',      'Jefe(a) de Capital Humano',            'Capital Humano',      5),
  ((SELECT id FROM c), 'Responsable de Laboratorio',           'vocal',      'Jefe(a) de Laboratorio y Gabinete',    'Laboratorio',         6),
  ((SELECT id FROM c), 'Responsable de Enfermería',            'vocal',      'Jefe(a) de Enfermería',                'Enfermería',          7),
  ((SELECT id FROM c), 'Jefes de los Servicios',               'vocal',      'Representante de Jefes de Servicio',   'Varios',              8)
ON CONFLICT DO NOTHING;

-- ── Verificación ─────────────────────────────────────────────────
SELECT sort_order, role, full_name, position_title
FROM committee_members
WHERE committee_id = (SELECT id FROM committees WHERE code = 'COCASEP')
ORDER BY sort_order;
