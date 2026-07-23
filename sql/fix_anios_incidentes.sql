-- ══════════════════════════════════════════════════════════════════
-- Corrección de años mal capturados en notificaciones de incidentes
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Dos notificaciones se guardaron con el año "0026" en lugar de "2026"
-- (un cero de más al teclear). Por eso no aparecen en los reportes de
-- 2026 y los conteos de abril y mayo salen una unidad abajo.
--
--   0026-04-09  Julieta Valadez Álvarez        → 2026-04-09
--   0026-05-19  Gutiérrez González, Mauricio   → 2026-05-19
--
-- ESTE ARCHIVO MODIFICA REGISTROS CLÍNICOS EXISTENTES.
-- Va aparte de la importación para que sea una decisión deliberada.
-- Solo cambia el año de la fecha; ningún otro dato se toca.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── 1. Ver qué se va a cambiar (ejecuta esto primero) ─────────────
SELECT id, incident_date AS fecha_actual,
       make_date(2000 + EXTRACT(YEAR FROM incident_date)::int,
                 EXTRACT(MONTH FROM incident_date)::int,
                 EXTRACT(DAY FROM incident_date)::int) AS fecha_corregida,
       patient_name, incident_type
FROM public.clinical_incidents
WHERE incident_date < '1900-01-01'
ORDER BY incident_date;

-- ── 2. Aplicar la corrección ──────────────────────────────────────
BEGIN;

UPDATE public.clinical_incidents
SET incident_date = make_date(
      2000 + EXTRACT(YEAR FROM incident_date)::int,
      EXTRACT(MONTH FROM incident_date)::int,
      EXTRACT(DAY FROM incident_date)::int)
WHERE incident_date < '1900-01-01'
  AND EXTRACT(YEAR FROM incident_date)::int BETWEEN 1 AND 99;

COMMIT;

-- ── 3. Verificación ───────────────────────────────────────────────
-- Ya no debe quedar ninguna fecha anterior a 1900,
-- y abril 2026 debe pasar a 26 y mayo 2026 a 11.
SELECT count(*) AS fechas_invalidas_restantes
FROM public.clinical_incidents
WHERE incident_date < '1900-01-01';

SELECT to_char(incident_date, 'YYYY-MM') AS mes, count(*) AS notificaciones
FROM public.clinical_incidents
WHERE incident_date >= '2026-01-01'
GROUP BY 1 ORDER BY 1;

-- Nota: la fecha de nacimiento (patient_dob) tiene errores parecidos
-- en varios registros (años 3945, 0026…). No se tocan aquí: no afectan
-- los reportes y conviene corregirlos contra el expediente, no a ciegas.
