-- ══════════════════════════════════════════════════════════════════
-- Adjuntos (fotos / archivos) en el buzón PÚBLICO — Hospital Santa Margarita
--
-- Permite que un paciente, sin iniciar sesión (rol anon), ADJUNTE fotos o
-- archivos a su queja/sugerencia/felicitación desde encuesta.html.
--
-- Seguridad: el anónimo SOLO puede SUBIR (no leer, ni borrar) al bucket
-- privado 'quejas-adjuntos' y registrar la fila en quejas_adjuntos. No puede
-- ver los adjuntos de nadie.
--
-- Requiere haber corrido antes: sql/encuesta_publica_setup.sql
-- No borra nada. Re-ejecutable. Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- 1) uploaded_by puede quedar vacío (el paciente no está autenticado).
ALTER TABLE public.quejas_adjuntos ALTER COLUMN uploaded_by DROP NOT NULL;

-- 2) Permitir SOLO insertar la fila del adjunto al rol anónimo.
GRANT INSERT ON public.quejas_adjuntos TO anon;
DROP POLICY IF EXISTS "anon_insert_quejas_adj" ON public.quejas_adjuntos;
CREATE POLICY "anon_insert_quejas_adj" ON public.quejas_adjuntos
  FOR INSERT TO anon WITH CHECK (true);

-- 3) Permitir SOLO subir archivos al bucket privado (no leer, no borrar).
DROP POLICY IF EXISTS "anon_upload_quejas_adj" ON storage.objects;
CREATE POLICY "anon_upload_quejas_adj" ON storage.objects
  FOR INSERT TO anon WITH CHECK (bucket_id = 'quejas-adjuntos');

-- Verificación
SELECT has_table_privilege('anon','public.quejas_adjuntos','INSERT') AS anon_inserta_fila;
