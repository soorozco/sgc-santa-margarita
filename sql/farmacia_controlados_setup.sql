-- ══════════════════════════════════════════════════════════════════
-- Migración: Farmacia — Conteo de Controlados
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Crea la tabla pharmacy_controlled_counts para el formato "Conteo de
-- Controlados" (Grupos I, II y III): un registro por fecha + turno +
-- grupo, con el conteo por medicamento (RE/IN/SA/EN, lote, caducidad).
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.pharmacy_controlled_counts (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  fecha            DATE NOT NULL,
  turno            TEXT NOT NULL,          -- Matutino | Vespertino | Nocturno
  grupo            TEXT NOT NULL,          -- I | II | III
  responsable      TEXT NOT NULL,          -- quien realiza el conteo
  conteos          JSONB,                  -- [{medicamento, re, in, sa, en, lote, cad, diferencia}]
  observaciones    TEXT,
  created_by       UUID,
  created_by_name  TEXT,
  created_at       TIMESTAMPTZ DEFAULT now()
);

-- Permisos (mismo patrón que el resto de las tablas del SGC)
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pharmacy_controlled_counts TO authenticated;
GRANT ALL ON public.pharmacy_controlled_counts TO service_role;

-- RLS: cualquier usuario autenticado puede leer y capturar
ALTER TABLE public.pharmacy_controlled_counts ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "authenticated acceso completo" ON public.pharmacy_controlled_counts;
CREATE POLICY "authenticated acceso completo"
  ON public.pharmacy_controlled_counts
  FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- ── Verificación ──────────────────────────────────────────────────
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'pharmacy_controlled_counts'
ORDER BY ordinal_position;
