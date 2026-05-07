-- ============================================================
--  FIX: agregar columnas faltantes a tablas de comités
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- Columnas que pueden faltar en committee_members
ALTER TABLE committee_members ADD COLUMN IF NOT EXISTS committee_id   uuid REFERENCES committees(id) ON DELETE CASCADE;
ALTER TABLE committee_members ADD COLUMN IF NOT EXISTS role           text NOT NULL DEFAULT 'vocal';
ALTER TABLE committee_members ADD COLUMN IF NOT EXISTS position_title text;
ALTER TABLE committee_members ADD COLUMN IF NOT EXISTS department     text;
ALTER TABLE committee_members ADD COLUMN IF NOT EXISTS is_active      boolean NOT NULL DEFAULT true;
ALTER TABLE committee_members ADD COLUMN IF NOT EXISTS sort_order     integer NOT NULL DEFAULT 99;

-- Columnas que pueden faltar en committee_sessions
ALTER TABLE committee_sessions ADD COLUMN IF NOT EXISTS committee_id   uuid REFERENCES committees(id);
ALTER TABLE committee_sessions ADD COLUMN IF NOT EXISTS session_year   integer NOT NULL DEFAULT EXTRACT(year FROM now())::integer;
ALTER TABLE committee_sessions ADD COLUMN IF NOT EXISTS session_number integer NOT NULL DEFAULT 1;
ALTER TABLE committee_sessions ADD COLUMN IF NOT EXISTS session_time   time;
ALTER TABLE committee_sessions ADD COLUMN IF NOT EXISTS session_type   text NOT NULL DEFAULT 'ordinaria';
ALTER TABLE committee_sessions ADD COLUMN IF NOT EXISTS location       text;
ALTER TABLE committee_sessions ADD COLUMN IF NOT EXISTS agenda         text;
ALTER TABLE committee_sessions ADD COLUMN IF NOT EXISTS notes          text;
ALTER TABLE committee_sessions ADD COLUMN IF NOT EXISTS updated_at     timestamptz NOT NULL DEFAULT now();

-- Columnas que pueden faltar en session_agreements
ALTER TABLE session_agreements ADD COLUMN IF NOT EXISTS committee_id    uuid REFERENCES committees(id);
ALTER TABLE session_agreements ADD COLUMN IF NOT EXISTS follow_up_notes text;
ALTER TABLE session_agreements ADD COLUMN IF NOT EXISTS updated_at      timestamptz NOT NULL DEFAULT now();

-- Columnas que pueden faltar en session_attendance
ALTER TABLE session_attendance ADD COLUMN IF NOT EXISTS justification text;

-- ── Re-insertar COCASEP ───────────────────────────────────────────
INSERT INTO committees (code, name, acronym, description) VALUES (
  'COCASEP',
  'Comité de Calidad y Seguridad del Paciente',
  'COCASEP',
  'Órgano responsable de llevar a cabo las estrategias para establecer mejoras de calidad y seguridad del paciente. Ref: MA-CA-02.'
) ON CONFLICT (code) DO NOTHING;

-- ── Re-insertar integrantes ───────────────────────────────────────
WITH c AS (SELECT id FROM committees WHERE code = 'COCASEP' LIMIT 1)
INSERT INTO committee_members
  (committee_id, full_name, role, position_title, department, sort_order)
VALUES
  ((SELECT id FROM c), 'Hna. María de Jesús García Castro',  'presidenta', 'Directora General',                   'Dirección General',   1),
  ((SELECT id FROM c), 'Responsable de Calidad',             'secretaria', 'Jefe(a) del Departamento de Calidad', 'Calidad',             2),
  ((SELECT id FROM c), 'Responsable de Administración',      'vocal',      'Jefe(a) de Administración',           'Administración',      3),
  ((SELECT id FROM c), 'Responsable de Seguridad e Higiene', 'vocal',      'Responsable de Seguridad e Higiene',  'Seguridad e Higiene', 4),
  ((SELECT id FROM c), 'Responsable de Capital Humano',      'vocal',      'Jefe(a) de Capital Humano',           'Capital Humano',      5),
  ((SELECT id FROM c), 'Responsable de Laboratorio',         'vocal',      'Jefe(a) de Laboratorio y Gabinete',   'Laboratorio',         6),
  ((SELECT id FROM c), 'Responsable de Enfermería',          'vocal',      'Jefe(a) de Enfermería',               'Enfermería',          7),
  ((SELECT id FROM c), 'Jefes de los Servicios',             'vocal',      'Representante de Jefes de Servicio',  'Varios',              8)
ON CONFLICT DO NOTHING;

-- ── RLS (por si no se aplicó antes) ──────────────────────────────
ALTER TABLE committees         ENABLE ROW LEVEL SECURITY;
ALTER TABLE committee_members  ENABLE ROW LEVEL SECURITY;
ALTER TABLE committee_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_agreements ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "cmt_all" ON committees;
DROP POLICY IF EXISTS "mbr_all" ON committee_members;
DROP POLICY IF EXISTS "ses_all" ON committee_sessions;
DROP POLICY IF EXISTS "att_all" ON session_attendance;
DROP POLICY IF EXISTS "agr_all" ON session_agreements;

CREATE POLICY "cmt_all" ON committees        FOR ALL TO authenticated USING (true);
CREATE POLICY "mbr_all" ON committee_members  FOR ALL TO authenticated USING (true);
CREATE POLICY "ses_all" ON committee_sessions FOR ALL TO authenticated USING (true);
CREATE POLICY "att_all" ON session_attendance FOR ALL TO authenticated USING (true);
CREATE POLICY "agr_all" ON session_agreements FOR ALL TO authenticated USING (true);

-- ── Verificación ──────────────────────────────────────────────────
SELECT sort_order, role, full_name, position_title
FROM committee_members
WHERE committee_id = (SELECT id FROM committees WHERE code = 'COCASEP')
ORDER BY sort_order;
