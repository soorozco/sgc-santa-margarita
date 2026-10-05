-- ══════════════════════════════════════════════════════════════════
-- Checklist de aprobación por área — Información Documentada (ISO 9001 §7.5)
--
-- Agrega a cada documento un pequeño flujo de aprobación:
--   1) Propuesta enviada al área   (+ fecha de envío)
--   2) Aprobado por el área        (+ fecha de aprobación)
--
-- Se edita desde el modal del lápiz y se muestra como columna en la tabla.
-- No borra nada. Re-ejecutable. Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.documents
  ADD COLUMN IF NOT EXISTS propuesta_enviada boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS propuesta_fecha   date,
  ADD COLUMN IF NOT EXISTS aprobado_area     boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS aprobado_fecha    date;

COMMENT ON COLUMN public.documents.propuesta_enviada IS 'Checklist: propuesta enviada al área responsable';
COMMENT ON COLUMN public.documents.propuesta_fecha   IS 'Fecha en que se envió la propuesta al área';
COMMENT ON COLUMN public.documents.aprobado_area     IS 'Checklist: propuesta aprobada por el área';
COMMENT ON COLUMN public.documents.aprobado_fecha    IS 'Fecha en que el área aprobó la propuesta';

-- Verificación
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'documents'
  AND column_name IN ('propuesta_enviada','propuesta_fecha','aprobado_area','aprobado_fecha')
ORDER BY column_name;
