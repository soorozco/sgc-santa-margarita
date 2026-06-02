-- ══════════════════════════════════════════════════════════════════
-- Migración: Agregar retention_months y disposition a documents
-- Ejecutar en: Supabase SQL Editor
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.documents
  ADD COLUMN IF NOT EXISTS retention_months INTEGER,
  ADD COLUMN IF NOT EXISTS disposition       TEXT;

COMMENT ON COLUMN public.documents.retention_months IS
  'Tiempo de retención en meses (usar cuando sea menor a 1 año). Tiene precedencia sobre retention_years en la UI.';
COMMENT ON COLUMN public.documents.disposition IS
  'Destino del documento al cumplir su vigencia. Ej: Archivo muerto, Destrucción, Digitalización.';

-- Verificación
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'documents'
  AND column_name IN ('retention_years','retention_months','disposition')
ORDER BY column_name;
