-- ══════════════════════════════════════════════════════════════════
-- Migración: Farmacia — Bitácora de Pacientes Farmacia Clínica
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Crea las tablas para el formato "Bitácora de Pacientes Farmacia
-- Clínica": censo de pacientes por habitación (diagnóstico,
-- comorbilidades, alergias, conciliación, RAM) y las notas de enlace
-- por turno (matutino / vespertino / nocturno).
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── Censo de pacientes ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.pharmacy_clinical_patients (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  hab              TEXT NOT NULL,          -- habitación (JP01, GIN-03, PB104…)
  fecha_ingreso    DATE NOT NULL,
  paciente         TEXT NOT NULL,
  diagnostico      TEXT,
  comorbilidades   TEXT,
  alergias         TEXT,
  conciliacion     BOOLEAN DEFAULT FALSE,  -- conciliación de medicamentos realizada
  ram              TEXT,                   -- reacciones adversas a medicamentos
  activo           BOOLEAN DEFAULT TRUE,   -- FALSE al dar de alta
  alta_at          TIMESTAMPTZ,
  created_by       UUID,
  created_by_name  TEXT,
  created_at       TIMESTAMPTZ DEFAULT now()
);

-- ── Notas de enlace por turno ─────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.pharmacy_clinical_notes (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id       UUID NOT NULL REFERENCES public.pharmacy_clinical_patients(id) ON DELETE CASCADE,
  fecha            DATE NOT NULL,
  turno            TEXT NOT NULL,          -- M | V | N
  nota             TEXT NOT NULL,
  autor            TEXT,
  created_by       UUID,
  created_at       TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_pcn_patient
  ON public.pharmacy_clinical_notes (patient_id, fecha);

-- Permisos (mismo patrón que el resto de las tablas del SGC)
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pharmacy_clinical_patients TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pharmacy_clinical_notes    TO authenticated;
GRANT ALL ON public.pharmacy_clinical_patients TO service_role;
GRANT ALL ON public.pharmacy_clinical_notes    TO service_role;

-- RLS: cualquier usuario autenticado puede leer y capturar
ALTER TABLE public.pharmacy_clinical_patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pharmacy_clinical_notes    ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "authenticated acceso completo" ON public.pharmacy_clinical_patients;
CREATE POLICY "authenticated acceso completo"
  ON public.pharmacy_clinical_patients
  FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "authenticated acceso completo" ON public.pharmacy_clinical_notes;
CREATE POLICY "authenticated acceso completo"
  ON public.pharmacy_clinical_notes
  FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- ── Verificación ──────────────────────────────────────────────────
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_name IN ('pharmacy_clinical_patients', 'pharmacy_clinical_notes')
ORDER BY table_name, ordinal_position;
