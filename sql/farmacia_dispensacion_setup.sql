-- ══════════════════════════════════════════════════════════════════
-- Migración: Farmacia — Bitácora de Dispensación de Controlados
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Crea la tabla pharmacy_dispensing_log para el formato "Bitácora de
-- Control de Dispensación de Medicamentos Controlados": un registro
-- por movimiento (entrada de abasto o salida por dispensación), con
-- paciente, médico tratante, cédula, no. de receta, lote, caducidad,
-- balance resultante y personal que dispensa.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.pharmacy_dispensing_log (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  fecha            DATE NOT NULL,
  medicamento      TEXT NOT NULL,
  entrada          NUMERIC,        -- cantidad que ingresa (abasto)
  salida           NUMERIC,        -- cantidad dispensada
  balance          NUMERIC,        -- balance resultante al momento del registro
  paciente         TEXT,           -- solo salidas
  medico           TEXT,           -- médico tratante (solo salidas)
  cedula           TEXT,           -- cédula profesional (solo salidas)
  receta           TEXT,           -- no. de receta (solo salidas)
  lote             TEXT,
  cad              TEXT,           -- caducidad (YYYY-MM)
  personal         TEXT NOT NULL,  -- personal que dispensa / registra
  created_by       UUID,
  created_by_name  TEXT,
  created_at       TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_pdl_medicamento
  ON public.pharmacy_dispensing_log (medicamento, fecha);

-- Permisos (mismo patrón que el resto de las tablas del SGC)
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pharmacy_dispensing_log TO authenticated;
GRANT ALL ON public.pharmacy_dispensing_log TO service_role;

-- RLS: cualquier usuario autenticado puede leer y capturar
ALTER TABLE public.pharmacy_dispensing_log ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "authenticated acceso completo" ON public.pharmacy_dispensing_log;
CREATE POLICY "authenticated acceso completo"
  ON public.pharmacy_dispensing_log
  FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- ── Verificación ──────────────────────────────────────────────────
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'pharmacy_dispensing_log'
ORDER BY ordinal_position;
