-- ══════════════════════════════════════════════════════════════════
-- Quejas — columnas para sincronizar con la hoja de Google
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Prepara la tabla quejas para recibir las respuestas del formulario
-- de Google. Agrega:
--   · origen        — 'hoja' o 'manual', para distinguir el origen
--   · sheet_ref     — la marca temporal de la respuesta; es la LLAVE
--                     con la que el robot reconoce cada registro (la
--                     hoja no tiene folio)
--   · sincronizado  — cuándo se sincronizó por última vez
--   · email         — el formulario pide correo y la tabla no lo tenía
--
-- Ejecutar en: Supabase → SQL Editor
-- (después de quejas_rls_cerrar.sql)
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.quejas
  ADD COLUMN IF NOT EXISTS origen       TEXT DEFAULT 'manual',
  ADD COLUMN IF NOT EXISTS sheet_ref    TEXT,
  ADD COLUMN IF NOT EXISTS sincronizado TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS email        TEXT;

-- Las quejas que ya existían se capturaron a mano
UPDATE public.quejas SET origen = 'manual' WHERE origen IS NULL;

-- La marca temporal identifica cada respuesta del formulario. Índice
-- único completo (no parcial) para que el robot pueda actualizar en
-- vez de duplicar. Varios registros manuales sin sheet_ref conviven:
-- Postgres considera distinto cada nulo.
CREATE UNIQUE INDEX IF NOT EXISTS idx_quejas_sheet_ref
  ON public.quejas (sheet_ref);

CREATE INDEX IF NOT EXISTS idx_quejas_origen ON public.quejas (origen);

-- ── Verificación ──────────────────────────────────────────────────
SELECT origen, count(*) AS registros
FROM public.quejas GROUP BY origen ORDER BY 1;
