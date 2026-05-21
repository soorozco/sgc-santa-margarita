-- ═══════════════════════════════════════════════════════════════
-- Agrega columna template_url a documents
-- Para guardar el enlace al archivo editable del formato (Google Docs, etc.)
-- Ejecutar en Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════

ALTER TABLE documents
  ADD COLUMN IF NOT EXISTS template_url TEXT;

-- Verificación
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'documents'
  AND column_name = 'template_url';
