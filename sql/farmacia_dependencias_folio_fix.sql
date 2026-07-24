-- ══════════════════════════════════════════════════════════════════
-- Corrección: índice del folio para que el robot pueda sincronizar
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- El índice original era PARCIAL (solo aplicaba a folios no vacíos).
-- Postgres no acepta ese tipo de índice para la fusión automática que
-- usa el robot al sincronizar la hoja de Google, y falla con:
--   42P10: there is no unique or exclusion constraint matching the
--          ON CONFLICT specification
--
-- Se reemplaza por un índice único normal. Los vales sin folio siguen
-- permitidos: Postgres considera distinto cada valor nulo, así que
-- pueden existir varios.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- Un folio vacío debe guardarse como nulo, no como texto en blanco:
-- de lo contrario dos vales sin folio chocarían entre sí.
UPDATE public.pharmacy_dependency_vouchers
SET folio = NULL
WHERE folio IS NOT NULL AND btrim(folio) = '';

DROP INDEX IF EXISTS public.idx_pdv_folio_unico;

CREATE UNIQUE INDEX IF NOT EXISTS idx_pdv_folio_unico
  ON public.pharmacy_dependency_vouchers (folio);

-- ── Verificación ──────────────────────────────────────────────────
-- Debe salir: es_unico = t  ·  es_parcial = f
SELECT c.relname       AS indice,
       i.indisunique   AS es_unico,
       i.indpred IS NOT NULL AS es_parcial
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
WHERE c.relname = 'idx_pdv_folio_unico';
