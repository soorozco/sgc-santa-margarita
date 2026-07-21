-- ══════════════════════════════════════════════════════════════════
-- Migración: Solicitudes de Baja — motivos estructurados + flujo 2 pasos
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Agrega a document_deactivation_requests:
--   · motivo_tipo             'sustitucion' | 'normativo' | 'no_util'
--   · replacement_document_id  formato que lo sustituye (si aplica)
--   · norma                    norma que aplica (cambio normativo)
--   · linked_procedure_id      procedimiento vinculado (obligatorio)
--
-- Y amplía el estado para el flujo de dos pasos:
--   pending → aceptada (baja aceptada, falta recibir el procedimiento
--   actualizado) → approved (nuevo proceso recibido → documento obsoleto)
--   · rejected (rechazada)
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.document_deactivation_requests
  ADD COLUMN IF NOT EXISTS motivo_tipo            TEXT,
  ADD COLUMN IF NOT EXISTS replacement_document_id UUID REFERENCES public.documents(id),
  ADD COLUMN IF NOT EXISTS norma                  TEXT,
  ADD COLUMN IF NOT EXISTS linked_procedure_id    UUID REFERENCES public.documents(id);

-- Ampliar el CHECK de status para incluir 'aceptada'
ALTER TABLE public.document_deactivation_requests
  DROP CONSTRAINT IF EXISTS document_deactivation_requests_status_check;
ALTER TABLE public.document_deactivation_requests
  ADD CONSTRAINT document_deactivation_requests_status_check
  CHECK (status IN ('pending','aceptada','approved','rejected'));

-- ── Verificación ──────────────────────────────────────────────────
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'document_deactivation_requests'
  AND column_name IN ('motivo_tipo','replacement_document_id','norma','linked_procedure_id')
ORDER BY column_name;
