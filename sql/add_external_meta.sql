-- ══════════════════════════════════════════════════════════════════
-- Migración: Ficha de Documento Externo (ISO 9001:2015 § 7.5.3.2)
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Agrega la columna JSONB external_meta a documents, donde se guarda
-- la ficha de control de documentos externos con los campos de la
-- matriz institucional: proceso asociado, emisor, código externo,
-- fechas de emisión/recepción, medio de soporte, ubicación, uso
-- previsto, responsables, requisito ISO, métodos de identificación y
-- control de cambios, periodicidad, retención, disposición, acceso,
-- evidencia de difusión, próxima revisión, riesgo, barreras y
-- observaciones.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.documents
  ADD COLUMN IF NOT EXISTS external_meta JSONB;

-- ── Verificación ──────────────────────────────────────────────────
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'documents' AND column_name = 'external_meta';
