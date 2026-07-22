-- ══════════════════════════════════════════════════════════════════
-- Migración: PFT — Área / Servicio y Habitación
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Agrega la ubicación del paciente al Perfil Farmacoterapéutico, con
-- el mismo catálogo que usa la Encuesta de Satisfacción, para poder
-- filtrar los perfiles por área/servicio y por habitación.
--
-- Ejecutar en: Supabase → SQL Editor  (después de farmacia_pft_setup.sql)
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.pharmacy_pft
  ADD COLUMN IF NOT EXISTS area       TEXT,
  ADD COLUMN IF NOT EXISTS habitacion TEXT;

CREATE INDEX IF NOT EXISTS idx_pft_area ON public.pharmacy_pft (area, habitacion);

-- ── Verificación ──────────────────────────────────────────────────
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'pharmacy_pft' AND column_name IN ('area','habitacion')
ORDER BY column_name;
