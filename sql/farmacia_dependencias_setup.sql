-- ══════════════════════════════════════════════════════════════════
-- Salidas a Madres y Casas — Relación de costo de vales de dependencia
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Registra las salidas de farmacia hacia las casas de la congregación.
-- Cada renglón es un vale: fecha, dependencia (casa), almacén, folio,
-- importe y observaciones.
--
-- Incluye la carga inicial de los 14 vales del archivo
-- "SALIDAS A MADRES Y CASAS.xlsx" (21 y 22 de julio de 2026).
--
-- Ejecutar en: Supabase → SQL Editor
-- Se puede volver a ejecutar sin duplicar la carga inicial.
-- ══════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.pharmacy_dependency_vouchers (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  fecha           DATE NOT NULL,
  dependencia     TEXT,                    -- casa / dependencia que recibe
  almacen         TEXT DEFAULT 'FARMACIA',
  folio           TEXT,                    -- folio del vale
  total           NUMERIC(12,2) NOT NULL DEFAULT 0,
  observaciones   TEXT,
  created_by      UUID,
  created_by_name TEXT,
  created_at      TIMESTAMPTZ DEFAULT now(),
  updated_at      TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_pdv_fecha
  ON public.pharmacy_dependency_vouchers (fecha DESC);
CREATE INDEX IF NOT EXISTS idx_pdv_dependencia
  ON public.pharmacy_dependency_vouchers (dependencia, fecha);

-- El folio identifica al vale: evita capturarlo dos veces por error.
-- Es UNIQUE parcial porque hay vales sin folio.
CREATE UNIQUE INDEX IF NOT EXISTS idx_pdv_folio_unico
  ON public.pharmacy_dependency_vouchers (folio)
  WHERE folio IS NOT NULL AND folio <> '';

-- ── Permisos (mismo patrón que el resto de Farmacia) ──────────────
ALTER TABLE public.pharmacy_dependency_vouchers ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "authenticated acceso completo" ON public.pharmacy_dependency_vouchers;
CREATE POLICY "authenticated acceso completo"
  ON public.pharmacy_dependency_vouchers
  FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.pharmacy_dependency_vouchers TO authenticated;
GRANT ALL ON public.pharmacy_dependency_vouchers TO service_role;

-- ── Carga inicial ─────────────────────────────────────────────────
-- ON CONFLICT sobre el folio: si ya se cargaron, no se duplican.
INSERT INTO public.pharmacy_dependency_vouchers
  (fecha, dependencia, almacen, folio, total, observaciones)
VALUES
  ('2026-07-21', 'CASA DE ORACION', 'FARMACIA', '669499', 20882.06, NULL),
  ('2026-07-21', 'HERMANAS HOSPITAL SANTA MARGARITA', 'FARMACIA', '669555', 2947.45, NULL),
  ('2026-07-21', 'CASA DE ORACION', 'FARMACIA', '669656', 770.94, NULL),
  ('2026-07-21', 'CASA DE ORACION', 'FARMACIA', '669694', 3694.2, NULL),
  ('2026-07-21', 'HERMANAS HOSPITAL SANTA MARGARITA', 'FARMACIA', '669702', 475.06, NULL),
  ('2026-07-21', 'CASA GENERAL', 'FARMACIA', '669716', 1601.99, NULL),
  ('2026-07-21', 'HERMANAS HOSPITAL SANTA MARGARITA', 'FARMACIA', '669854', 8116.87, NULL),
  ('2026-07-21', 'HERMANAS HOSPITAL SANTA MARGARITA', 'FARMACIA', '669855', 427.69, NULL),
  ('2026-07-22', 'CASA PRE-NOVISIADO', 'FARMACIA', '670119', 2283.54, NULL),
  ('2026-07-22', 'CASA GENERAL', 'FARMACIA', '670127', 0.39, 'ERROR DE CARGO, SOLO SE CARGO 1 TABLETA'),
  ('2026-07-22', 'CASA GENERAL', 'FARMACIA', '670131', 11.35, 'LAS OTRAS 29 QUE FALTABAN DE DAR DE BAJA.'),
  ('2026-07-22', 'CASA JUNIORAD', 'FARMACIA', '670159', 372.53, NULL),
  ('2026-07-22', 'CASA DE ORACION', 'FARMACIA', '670186', 660.65, NULL),
  -- Este vale venía sin dependencia ni almacén en el archivo original:
  ('2026-07-22', NULL, 'FARMACIA', '670401', 42.00, NULL)
-- La condición repite la del índice parcial de arriba; Postgres la exige
-- para saber a qué índice se refiere el ON CONFLICT.
ON CONFLICT (folio) WHERE folio IS NOT NULL AND folio <> '' DO NOTHING;

-- ── Verificación ──────────────────────────────────────────────────
-- Debe dar 14 vales y un total de 42,286.72 (igual que el Excel)
SELECT count(*) AS vales, to_char(sum(total), 'FM999,999,990.00') AS total
FROM public.pharmacy_dependency_vouchers;

SELECT coalesce(dependencia, '(sin dependencia)') AS dependencia,
       count(*) AS vales,
       to_char(sum(total), 'FM999,999,990.00') AS total
FROM public.pharmacy_dependency_vouchers
GROUP BY 1 ORDER BY sum(total) DESC;
