-- ══════════════════════════════════════════════════════════════════
-- Salidas a Madres y Casas — origen del vale
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Marca de dónde vino cada vale: de la hoja de Google que sincroniza
-- el robot, o capturado a mano en el sistema.
--
-- Sirve para dos cosas:
--   1. Mostrar en pantalla cuáles se administran desde la hoja
--      (esos se deben corregir allá, no aquí).
--   2. Que el robot solo toque los suyos y nunca pise una captura
--      manual.
--
-- Ejecutar en: Supabase → SQL Editor
-- (después de farmacia_dependencias_setup.sql)
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.pharmacy_dependency_vouchers
  ADD COLUMN IF NOT EXISTS origen        TEXT DEFAULT 'manual',
  ADD COLUMN IF NOT EXISTS sincronizado  TIMESTAMPTZ;

-- Los vales que ya existían se capturaron desde el Excel original
UPDATE public.pharmacy_dependency_vouchers
SET origen = 'manual'
WHERE origen IS NULL;

CREATE INDEX IF NOT EXISTS idx_pdv_origen
  ON public.pharmacy_dependency_vouchers (origen);

-- ── Verificación ──────────────────────────────────────────────────
SELECT origen, count(*) AS vales,
       to_char(sum(total), 'FM999,999,990.00') AS total
FROM public.pharmacy_dependency_vouchers
GROUP BY origen ORDER BY 1;
