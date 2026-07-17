-- ══════════════════════════════════════════════════════════════════
-- Migración: Sección Farmacia — Bitácora de Entrega de Turno
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Crea la tabla pharmacy_shift_logs para el formato "Bitácora de
-- entrega de turno Farmacia Central": datos del turno, control de
-- temperaturas y humedad, inventario crítico, traspasos y pendientes.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.pharmacy_shift_logs (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  fecha            DATE NOT NULL,
  turno            TEXT NOT NULL,          -- Matutino | Vespertino | Nocturno
  entrega          TEXT NOT NULL,          -- quién entrega el turno
  recibe           TEXT NOT NULL,          -- quién recibe el turno
  temps            JSONB,                  -- {refa, refb, farmacia, humedad}
  inventario       JSONB,                  -- {controlados, altocosto, caducados, antibioticos, observaciones}
  traspasos        JSONB,                  -- [{servicio, verificacion, folio}]
  pendientes       TEXT,                   -- pendientes operativos generales
  created_by       UUID,
  created_by_name  TEXT,
  created_at       TIMESTAMPTZ DEFAULT now()
);

-- Permisos (mismo patrón que el resto de las tablas del SGC)
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pharmacy_shift_logs TO authenticated;
GRANT ALL ON public.pharmacy_shift_logs TO service_role;

-- RLS: cualquier usuario autenticado puede leer y capturar
ALTER TABLE public.pharmacy_shift_logs ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "authenticated acceso completo" ON public.pharmacy_shift_logs;
CREATE POLICY "authenticated acceso completo"
  ON public.pharmacy_shift_logs
  FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- ── Verificación ──────────────────────────────────────────────────
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'pharmacy_shift_logs'
ORDER BY ordinal_position;
