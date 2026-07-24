-- ══════════════════════════════════════════════════════════════════
-- Incidentes clínicos — arreglar el guardado y preparar la sincroniz.
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Hace dos cosas:
--
-- 1. ARREGLA EL FORMULARIO "Notificar Incidente".
--    Hoy falla al guardar con "permission denied for table
--    clinical_incidents" (código 42501). La política RLS sí permite
--    la inserción, pero al rol de usuarios autenticados le faltaba el
--    permiso (GRANT) a nivel de tabla. Sin ese permiso, PostgREST
--    rechaza antes de siquiera evaluar la política. Esto lo concede.
--
-- 2. PREPARA LA SINCRONIZACIÓN con la hoja de Google, para tener
--    homologada la información de las dos vías (el formulario web y
--    el formulario de Google). Agrega:
--      · origen        — 'hoja' o 'manual'/'web'
--      · sheet_ref     — la marca temporal de la respuesta (LLAVE del
--                        robot; el formulario de Google no da folio)
--      · sincronizado  — cuándo se sincronizó por última vez
--
-- NO borra ni un registro.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── 1. Permiso que faltaba (arregla el guardado) ──────────────────
-- Cualquier persona con sesión puede notificar un incidente; la
-- política RLS ya lo contempla, solo faltaba el permiso de tabla.
GRANT SELECT, INSERT ON public.clinical_incidents TO authenticated;

-- ── 2. Columnas para sincronizar ──────────────────────────────────
ALTER TABLE public.clinical_incidents
  ADD COLUMN IF NOT EXISTS origen       TEXT DEFAULT 'manual',
  ADD COLUMN IF NOT EXISTS sheet_ref    TEXT,
  ADD COLUMN IF NOT EXISTS sincronizado TIMESTAMPTZ;

-- Los incidentes que ya existían venían de la importación / el formulario
UPDATE public.clinical_incidents SET origen = 'manual' WHERE origen IS NULL;

-- La marca temporal identifica cada respuesta del formulario de Google.
-- Índice único completo (no parcial) para que el robot actualice en vez
-- de duplicar. Los incidentes sin sheet_ref (los del formulario web)
-- conviven: Postgres considera distinto cada nulo.
CREATE UNIQUE INDEX IF NOT EXISTS idx_ci_sheet_ref
  ON public.clinical_incidents (sheet_ref);

CREATE INDEX IF NOT EXISTS idx_ci_origen ON public.clinical_incidents (origen);

-- ── Verificación ──────────────────────────────────────────────────
SELECT origen, count(*) AS registros
FROM public.clinical_incidents GROUP BY origen ORDER BY 1;
