-- ══════════════════════════════════════════════════════════════════
-- Migración: Farmacia — Vía de administración por defecto (catálogo PFT)
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Agrega via_default al catálogo para autollenar la vía al elegir el
-- medicamento en el Perfil Farmacoterapéutico (ahorra un paso y evita
-- errores, p. ej. tabletas marcadas como IV).
--
--   · Tabletas / gotas → Vía oral
--   · Parches          → Transdérmica
--   · Enoxaparina      → Subcutánea (HBPM)
--   · Inyectables      → Intravenosa (por defecto; editable)
--
-- Ejecutar en: Supabase → SQL Editor  (después de farmacia_pft_setup.sql)
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.pharmacy_med_catalog ADD COLUMN IF NOT EXISTS via_default TEXT;

UPDATE public.pharmacy_med_catalog SET via_default = CASE
  WHEN nombre ILIKE 'ENOXAPARINA%'                         THEN 'Subcutánea'
  WHEN nombre ILIKE '%TAB%' OR nombre ILIKE '%GOTAS%'      THEN 'Vía oral'
  WHEN nombre ILIKE '%PARCHE%'                             THEN 'Transdérmica'
  ELSE 'Intravenosa'
END
WHERE via_default IS NULL;

-- ── Verificación ──────────────────────────────────────────────────
SELECT via_default, count(*) FROM public.pharmacy_med_catalog GROUP BY via_default ORDER BY 1;
