-- ══════════════════════════════════════════════════════════════════
-- Oficios — campos para GENERAR el documento (PDF)
-- Hospital Santa Margarita · Oficina de Calidad
--
-- Agrega los campos que faltan para armar el oficio como documento
-- imprimible: el cuerpo (texto principal), los cargos del destinatario y
-- del firmante, las copias (c.c.p.) y el correo del destinatario (para
-- preparar el envío).
--
-- No borra nada. Re-ejecutable.
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.oficios
  ADD COLUMN IF NOT EXISTS cuerpo         text,   -- texto principal del oficio
  ADD COLUMN IF NOT EXISTS dirigido_cargo text,   -- cargo del destinatario
  ADD COLUMN IF NOT EXISTS firmado_cargo  text,   -- cargo de quien firma
  ADD COLUMN IF NOT EXISTS ccp            text,   -- copias (una por línea)
  ADD COLUMN IF NOT EXISTS email_dest     text;   -- correo del destinatario

-- Verificación
SELECT column_name FROM information_schema.columns
WHERE table_schema='public' AND table_name='oficios'
  AND column_name IN ('cuerpo','dirigido_cargo','firmado_cargo','ccp','email_dest')
ORDER BY column_name;
