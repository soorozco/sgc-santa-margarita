-- ══════════════════════════════════════════════════════════════════
-- Incidentes — quitar los duplicados de la primera sincronización
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- QUÉ PASÓ: los 137 incidentes que ya estaban en la base venían de una
-- importación anterior del mismo formulario, pero SIN la marca temporal
-- (sheet_ref). Al correr el robot por primera vez, no pudo reconocerlos
-- y los volvió a insertar: quedaron duplicados
--   · 137 con origen 'manual' (los viejos, sin sheet_ref)
--   · 138 con origen 'hoja'   (los que ahora mantiene el robot)
--
-- Esta migración borra los 'manual' que tienen un gemelo en 'hoja'
-- (mismo paciente y misma fecha, ignorando mayúsculas y espacios de
-- más). Se probó que los 137 tienen gemelo, así que no se pierde nada:
-- la versión 'hoja' es la que queda y la que se seguirá sincronizando.
--
-- ES SEGURO: solo borra 'manual' que estén repetidos en 'hoja'. Si
-- algún 'manual' no tuviera gemelo (p. ej. capturado a mano de verdad),
-- NO se toca. Revisa primero el paso 1 antes de ejecutar el paso 2.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── 1. Revisión: cuántos se borrarían y cuántos manual quedarían ──
SELECT
  count(*) FILTER (WHERE tiene_gemelo)       AS se_borraran,
  count(*) FILTER (WHERE NOT tiene_gemelo)   AS manual_sin_gemelo_se_conservan
FROM (
  SELECT m.id,
    EXISTS (
      SELECT 1 FROM public.clinical_incidents h
      WHERE h.origen = 'hoja'
        AND regexp_replace(upper(btrim(h.patient_name)), '\s+', ' ', 'g')
          = regexp_replace(upper(btrim(m.patient_name)), '\s+', ' ', 'g')
        AND h.incident_date = m.incident_date
    ) AS tiene_gemelo
  FROM public.clinical_incidents m
  WHERE m.origen = 'manual'
) t;

-- ── 2. Borrado (ejecuta después de revisar el paso 1) ─────────────
BEGIN;

DELETE FROM public.clinical_incidents m
WHERE m.origen = 'manual'
  AND EXISTS (
    SELECT 1 FROM public.clinical_incidents h
    WHERE h.origen = 'hoja'
      AND regexp_replace(upper(btrim(h.patient_name)), '\s+', ' ', 'g')
        = regexp_replace(upper(btrim(m.patient_name)), '\s+', ' ', 'g')
      AND h.incident_date = m.incident_date
  );

COMMIT;

-- ── 3. Verificación — debe quedar solo 'hoja' (o algún 'manual' real) ──
SELECT origen, count(*) AS registros
FROM public.clinical_incidents
GROUP BY origen ORDER BY 1;
