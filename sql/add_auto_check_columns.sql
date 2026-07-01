-- ══════════════════════════════════════════════════════════════════
-- Migración: Verificación Automática de Normas (Robot GitHub Actions)
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Agrega columnas para que el robot semanal registre el resultado de
-- verificar cada documento externo contra su fuente oficial:
--   auto_check_status : 'vigente' | 'no_verificado' | 'desactualizada'
--   auto_check_at     : cuándo corrió el robot
--   auto_check_note   : explicación breve del resultado
--   auto_check_url    : fuente consultada como evidencia
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.documents
  ADD COLUMN IF NOT EXISTS auto_check_status TEXT,
  ADD COLUMN IF NOT EXISTS auto_check_at     TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS auto_check_note   TEXT,
  ADD COLUMN IF NOT EXISTS auto_check_url    TEXT;

-- ── Verificación de columnas creadas ─────────────────────────────
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'documents'
  AND column_name LIKE 'auto_check%'
ORDER BY column_name;
