-- ============================================================
--  RESET COMPLETO — Módulo Comités
--  Borra y recrea todas las tablas desde cero
--  Seguro porque aún no hay datos reales
-- ============================================================

-- Borrar en orden inverso (por las FK)
DROP TABLE IF EXISTS session_agreements  CASCADE;
DROP TABLE IF EXISTS session_attendance  CASCADE;
DROP TABLE IF EXISTS committee_sessions  CASCADE;
DROP TABLE IF EXISTS committee_members   CASCADE;
DROP TABLE IF EXISTS committees          CASCADE;

-- ── 1. Comités ───────────────────────────────────────────────────
CREATE TABLE committees (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  code        text        NOT NULL UNIQUE,
  name        text        NOT NULL,
  acronym     text,
  description text,
  is_active   boolean     NOT NULL DEFAULT true,
  created_at  timestamptz NOT NULL DEFAULT now()
);

-- ── 2. Integrantes ───────────────────────────────────────────────
CREATE TABLE committee_members (
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
CREATE TABLE committee_sessions (
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

-- ── 4. Asistencia ────────────────────────────────────────────────
CREATE TABLE session_attendance (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id    uuid        NOT NULL REFERENCES committee_sessions(id) ON DELETE CASCADE,
  member_id     uuid        NOT NULL REFERENCES committee_members(id),
  attended      boolean     NOT NULL DEFAULT false,
  justification text,
  created_at    timestamptz NOT NULL DEFAULT now(),
  UNIQUE (session_id, member_id)
);

-- ── 5. Acuerdos ──────────────────────────────────────────────────
CREATE TABLE session_agreements (
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

-- ── Triggers ─────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION update_committee_ts()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END; $$;

CREATE TRIGGER trg_sessions_ts
  BEFORE UPDATE ON committee_sessions
  FOR EACH ROW EXECUTE FUNCTION update_committee_ts();
CREATE TRIGGER trg_agreements_ts
  BEFORE UPDATE ON session_agreements
  FOR EACH ROW EXECUTE FUNCTION update_committee_ts();

-- ── RLS ──────────────────────────────────────────────────────────
ALTER TABLE committees         ENABLE ROW LEVEL SECURITY;
ALTER TABLE committee_members  ENABLE ROW LEVEL SECURITY;
ALTER TABLE committee_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_agreements ENABLE ROW LEVEL SECURITY;

CREATE POLICY "cmt_all" ON committees        FOR ALL TO authenticated USING (true);
CREATE POLICY "mbr_all" ON committee_members  FOR ALL TO authenticated USING (true);
CREATE POLICY "ses_all" ON committee_sessions FOR ALL TO authenticated USING (true);
CREATE POLICY "att_all" ON session_attendance FOR ALL TO authenticated USING (true);
CREATE POLICY "agr_all" ON session_agreements FOR ALL TO authenticated USING (true);

-- ── Datos — COCASEP ───────────────────────────────────────────────
INSERT INTO committees (code, name, acronym, description) VALUES (
  'COCASEP',
  'Comité de Calidad y Seguridad del Paciente',
  'COCASEP',
  'Órgano responsable de llevar a cabo las estrategias para establecer mejoras de calidad y seguridad del paciente. Ref: MA-CA-02.'
);

INSERT INTO committee_members
  (committee_id, full_name, role, position_title, department, sort_order)
SELECT
  c.id,
  m.full_name, m.role, m.position_title, m.department, m.sort_order
FROM committees c,
(VALUES
  ('Hna. María de Jesús García Castro',  'presidenta', 'Directora General',                   'Dirección General',   1),
  ('Responsable de Calidad',             'secretaria', 'Jefe(a) del Departamento de Calidad', 'Calidad',             2),
  ('Responsable de Administración',      'vocal',      'Jefe(a) de Administración',           'Administración',      3),
  ('Responsable de Seguridad e Higiene', 'vocal',      'Responsable de Seguridad e Higiene',  'Seguridad e Higiene', 4),
  ('Responsable de Capital Humano',      'vocal',      'Jefe(a) de Capital Humano',           'Capital Humano',      5),
  ('Responsable de Laboratorio',         'vocal',      'Jefe(a) de Laboratorio y Gabinete',   'Laboratorio',         6),
  ('Responsable de Enfermería',          'vocal',      'Jefe(a) de Enfermería',               'Enfermería',          7),
  ('Jefes de los Servicios',             'vocal',      'Representante de Jefes de Servicio',  'Varios',              8)
) AS m(full_name, role, position_title, department, sort_order)
WHERE c.code = 'COCASEP';

-- ── Verificación ─────────────────────────────────────────────────
SELECT m.sort_order, m.role, m.full_name, m.position_title
FROM committee_members m
JOIN committees c ON c.id = m.committee_id
WHERE c.code = 'COCASEP'
ORDER BY m.sort_order;
