-- ══════════════════════════════════════════════════════════════════
-- Documentos externos (NOMs) — Publicación en el DOF y norma vigente
-- Hospital Santa Margarita · Información Documentada
--
-- Agrega tres campos para mostrar en la tabla:
--   dof_fecha     → fecha de publicación en el DOF (DD/MM/AAAA) o "No aplica"
--   dof_proyecto  → proyecto/propuesta en curso (PROY-NOM…), si existe
--   norma_vigente → la NOM que hoy aplica ("La misma" si sigue vigente,
--                   o la clave equivalente si fue sustituida/cancelada)
--
-- No borra nada. Re-ejecutable.
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.documents
  ADD COLUMN IF NOT EXISTS dof_fecha     text,
  ADD COLUMN IF NOT EXISTS dof_proyecto  text,
  ADD COLUMN IF NOT EXISTS norma_vigente text;

-- Verificación
SELECT column_name FROM information_schema.columns
WHERE table_schema='public' AND table_name='documents'
  AND column_name IN ('dof_fecha','dof_proyecto','norma_vigente')
ORDER BY column_name;
