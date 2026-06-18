-- ══════════════════════════════════════════════════════════════════
-- Migración: Columnas de Verificación de Vigencia (Documentos Externos)
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Agrega tres columnas a la tabla documents para permitir registrar
-- cuándo y por quién fue verificada la vigencia de cada documento
-- externo (DE-LEY, DE-REG, DE-NOM, DE-GPC, DE-CSG).
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.documents
  ADD COLUMN IF NOT EXISTS last_verified_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS verified_by      TEXT,
  ADD COLUMN IF NOT EXISTS is_current       BOOLEAN DEFAULT TRUE;

-- ── Verificación de columnas creadas ─────────────────────────────
SELECT column_name, data_type, column_default, is_nullable
FROM information_schema.columns
WHERE table_name = 'documents'
  AND column_name IN ('last_verified_at', 'verified_by', 'is_current')
ORDER BY column_name;
