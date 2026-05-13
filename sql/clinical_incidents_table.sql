-- ============================================================
--  Eventos Adversos — Tabla de Incidentes Clínicos
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- ── 1. Tabla principal ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS clinical_incidents (
  id                  uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  reported_at         timestamptz NOT NULL,
  patient_name        text,
  patient_dob         date,
  patient_sex         text,
  incident_date       date,
  incident_time       text,
  location            text,
  incident_type       text        NOT NULL,  -- Cuasi Falla, Evento Adverso, etc.
  incident_subtype    text,                  -- Medicación, Caídas, etc.
  damage_level        text,                  -- Sin Daño, Leve, Moderado, Grave, Muerte
  description         text,
  causes              text,
  contributing_factors text,
  mitigating_factors  text,
  immediate_actions   text,
  attachments         text,                  -- URLs separadas por coma
  created_at          timestamptz DEFAULT now()
);

-- ── 2. RLS — solo administrador y responsable_calidad pueden leer ─
ALTER TABLE clinical_incidents ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "admins_read_incidents" ON clinical_incidents;
CREATE POLICY "admins_read_incidents"
  ON clinical_incidents FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM profiles p
      JOIN roles r ON r.id = p.role_id
      WHERE p.id = auth.uid()
        AND r.name IN ('administrador', 'responsable_calidad')
    )
  );

DROP POLICY IF EXISTS "admins_insert_incidents" ON clinical_incidents;
CREATE POLICY "admins_insert_incidents"
  ON clinical_incidents FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles p
      JOIN roles r ON r.id = p.role_id
      WHERE p.id = auth.uid()
        AND r.name IN ('administrador', 'responsable_calidad')
    )
  );

-- ── 3. Índices ───────────────────────────────────────────────
CREATE INDEX IF NOT EXISTS idx_ci_incident_date  ON clinical_incidents (incident_date DESC);
CREATE INDEX IF NOT EXISTS idx_ci_incident_type  ON clinical_incidents (incident_type);
CREATE INDEX IF NOT EXISTS idx_ci_damage_level   ON clinical_incidents (damage_level);
CREATE INDEX IF NOT EXISTS idx_ci_reported_at    ON clinical_incidents (reported_at DESC);

-- ── 4. Verificación ─────────────────────────────────────────
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_name = 'clinical_incidents'
ORDER BY ordinal_position;
