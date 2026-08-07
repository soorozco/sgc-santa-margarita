-- ══════════════════════════════════════════════════════════════════
-- LIMPIAR duplicados de Quejas — conservar el CA, borrar WEB/QJ gemelos
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Borra las quejas cuyo folio NO empieza con 'CA' cuando existe otra
-- queja con folio 'CA...' de la MISMA fecha y el MISMO teléfono (es decir,
-- la misma solicitud capturada dos veces). Conserva siempre la CA.
--
-- IMPORTANTE — orden:
--   1) Primero debe estar ya publicado el robot con el anti-duplicados
--      (sync_quejas.py actualizado), para que no vuelva a crearlos.
--   2) Ejecuta el PASO 1 (revisar) y confirma que la lista tiene sentido.
--   3) Luego ejecuta el PASO 2 (borrar).
--
-- Solo borra duplicados con gemelo CA; los WEB/QJ que NO tengan gemelo CA
-- NO se tocan. Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── PASO 1 · REVISAR (no borra) ───────────────────────────────────
-- Debe listar, por cada duplicado, el folio que se BORRA y el CA que se
-- CONSERVA. Si algo no cuadra, no ejecutes el paso 2 y avísame.
SELECT q.folio AS se_borra, q.origen, q.fecha, q.telefono, c.folio AS se_conserva
FROM public.quejas q
JOIN public.quejas c
  ON c.id <> q.id
 AND c.folio LIKE 'CA%'
 AND c.fecha = q.fecha
 AND regexp_replace(coalesce(c.telefono,''), '\D', '', 'g') <> ''
 AND regexp_replace(coalesce(c.telefono,''), '\D', '', 'g')
   = regexp_replace(coalesce(q.telefono,''), '\D', '', 'g')
WHERE q.folio NOT LIKE 'CA%'
ORDER BY q.fecha, q.folio;

-- ── PASO 2 · BORRAR (ejecuta tras revisar el paso 1) ──────────────
BEGIN;

CREATE TEMP TABLE _dup_del ON COMMIT DROP AS
SELECT q.id
FROM public.quejas q
WHERE q.folio NOT LIKE 'CA%'
  AND EXISTS (
    SELECT 1 FROM public.quejas c
    WHERE c.folio LIKE 'CA%' AND c.id <> q.id AND c.fecha = q.fecha
      AND regexp_replace(coalesce(c.telefono,''), '\D', '', 'g') <> ''
      AND regexp_replace(coalesce(c.telefono,''), '\D', '', 'g')
        = regexp_replace(coalesce(q.telefono,''), '\D', '', 'g')
  );

-- Quitar dependencias primero (las imágenes se borran en cascada)
DELETE FROM public.quejas_notas WHERE queja_id IN (SELECT id FROM _dup_del);
DELETE FROM public.quejas       WHERE id       IN (SELECT id FROM _dup_del);

COMMIT;

-- ── PASO 3 · Verificación ─────────────────────────────────────────
SELECT origen, count(*) AS registros FROM public.quejas GROUP BY origen ORDER BY 1;
