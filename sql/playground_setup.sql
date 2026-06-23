-- =============================================================
-- PLAYGROUND SETUP
-- Aísla los documentos de playground del resto de la base de datos
-- Ejecutar UNA SOLA VEZ en Supabase SQL Editor
-- =============================================================

-- 1. Agregar columna is_playground a la tabla documents
ALTER TABLE public.documents
  ADD COLUMN IF NOT EXISTS is_playground BOOLEAN NOT NULL DEFAULT FALSE;

-- 2. Índice parcial para acelerar consultas de playground
CREATE INDEX IF NOT EXISTS idx_documents_playground
  ON public.documents (is_playground)
  WHERE is_playground = TRUE;

-- =============================================================
-- 3. RLS: sólo omar.orozco@gmail.com puede ver/editar registros
--    donde is_playground = TRUE
-- =============================================================

-- Política: SELECT (leer) documentos de playground
DROP POLICY IF EXISTS playground_select ON public.documents;
CREATE POLICY playground_select
  ON public.documents
  FOR SELECT
  USING (
    -- Documentos normales: cualquier usuario autenticado
    (is_playground = FALSE)
    OR
    -- Documentos de playground: sólo omar
    (
      is_playground = TRUE
      AND (auth.jwt() ->> 'email') = 'omar.orozco@gmail.com'
    )
  );

-- Política: INSERT de documentos de playground
DROP POLICY IF EXISTS playground_insert ON public.documents;
CREATE POLICY playground_insert
  ON public.documents
  FOR INSERT
  WITH CHECK (
    (is_playground = FALSE)
    OR
    (
      is_playground = TRUE
      AND (auth.jwt() ->> 'email') = 'omar.orozco@gmail.com'
    )
  );

-- Política: UPDATE de documentos de playground
DROP POLICY IF EXISTS playground_update ON public.documents;
CREATE POLICY playground_update
  ON public.documents
  FOR UPDATE
  USING (
    (is_playground = FALSE)
    OR
    (
      is_playground = TRUE
      AND (auth.jwt() ->> 'email') = 'omar.orozco@gmail.com'
    )
  )
  WITH CHECK (
    (is_playground = FALSE)
    OR
    (
      is_playground = TRUE
      AND (auth.jwt() ->> 'email') = 'omar.orozco@gmail.com'
    )
  );

-- Política: DELETE de documentos de playground
DROP POLICY IF EXISTS playground_delete ON public.documents;
CREATE POLICY playground_delete
  ON public.documents
  FOR DELETE
  USING (
    (is_playground = FALSE)
    OR
    (
      is_playground = TRUE
      AND (auth.jwt() ->> 'email') = 'omar.orozco@gmail.com'
    )
  );

-- =============================================================
-- NOTA: Si la tabla documents ya tiene una política permisiva
-- tipo "authenticated can do everything", puede entrar en
-- conflicto. En ese caso, elimina la política anterior primero:
--
--   DROP POLICY IF EXISTS "Allow authenticated access" ON public.documents;
--   (o el nombre que tenga tu política existente)
--
-- Luego vuelve a ejecutar este script.
-- =============================================================

-- 4. Verificación
SELECT
  column_name,
  data_type,
  column_default,
  is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name   = 'documents'
  AND column_name  = 'is_playground';
