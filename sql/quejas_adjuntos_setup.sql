-- ══════════════════════════════════════════════════════════════════
-- Imágenes adjuntas para Quejas / Sugerencias / Felicitaciones (FT-CA-24)
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Permite adjuntar fotos a cada solicitud. Las imágenes se guardan en un
-- bucket PRIVADO de Supabase Storage: NO son públicas, solo el personal
-- con sesión y con rol de quejas puede verlas (a través de enlaces
-- firmados que caducan en 1 hora). Esto protege datos del paciente que
-- pudieran aparecer en las fotos.
--
-- Requiere la función public.tiene_rol() (creada en quejas_rls_cerrar.sql).
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── 1. Bucket privado para las imágenes ───────────────────────────
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES ('quejas-adjuntos', 'quejas-adjuntos', false, 10485760,
        ARRAY['image/jpeg','image/jpg','image/png','image/webp','image/gif','image/heic','image/heif'])
ON CONFLICT (id) DO UPDATE
  SET public = false,
      file_size_limit = EXCLUDED.file_size_limit,
      allowed_mime_types = EXCLUDED.allowed_mime_types;

-- ── 2. Tabla con la referencia de cada imagen ─────────────────────
CREATE TABLE IF NOT EXISTS public.quejas_adjuntos (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  queja_id       uuid NOT NULL REFERENCES public.quejas(id) ON DELETE CASCADE,
  file_path      text NOT NULL,           -- ruta dentro del bucket
  file_name      text,
  file_size_bytes bigint,
  mime_type      text,
  uploaded_by    uuid,
  uploaded_at    timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_qadj_queja ON public.quejas_adjuntos(queja_id);

REVOKE ALL ON public.quejas_adjuntos FROM anon;
GRANT  SELECT, INSERT, DELETE ON public.quejas_adjuntos TO authenticated;

ALTER TABLE public.quejas_adjuntos ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "qadj_select" ON public.quejas_adjuntos;
DROP POLICY IF EXISTS "qadj_insert" ON public.quejas_adjuntos;
DROP POLICY IF EXISTS "qadj_delete" ON public.quejas_adjuntos;

CREATE POLICY "qadj_select" ON public.quejas_adjuntos
  FOR SELECT TO authenticated
  USING (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

CREATE POLICY "qadj_insert" ON public.quejas_adjuntos
  FOR INSERT TO authenticated
  WITH CHECK (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

CREATE POLICY "qadj_delete" ON public.quejas_adjuntos
  FOR DELETE TO authenticated
  USING (public.tiene_rol(ARRAY['administrador','responsable_calidad']));

-- ── 3. Políticas del bucket (storage.objects) ─────────────────────
-- Mismos roles: ver y subir los cuatro; borrar solo Calidad/Dirección.
DROP POLICY IF EXISTS "qadj_obj_select" ON storage.objects;
DROP POLICY IF EXISTS "qadj_obj_insert" ON storage.objects;
DROP POLICY IF EXISTS "qadj_obj_delete" ON storage.objects;

CREATE POLICY "qadj_obj_select" ON storage.objects
  FOR SELECT TO authenticated
  USING (bucket_id = 'quejas-adjuntos'
         AND public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

CREATE POLICY "qadj_obj_insert" ON storage.objects
  FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'quejas-adjuntos'
         AND public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

CREATE POLICY "qadj_obj_delete" ON storage.objects
  FOR DELETE TO authenticated
  USING (bucket_id = 'quejas-adjuntos'
         AND public.tiene_rol(ARRAY['administrador','responsable_calidad']));

-- ── 4. Verificación ───────────────────────────────────────────────
SELECT 'bucket' AS que, id AS detalle FROM storage.buckets WHERE id = 'quejas-adjuntos'
UNION ALL
SELECT 'policy', policyname FROM pg_policies
WHERE (schemaname='public' AND tablename='quejas_adjuntos')
   OR (schemaname='storage' AND tablename='objects' AND policyname LIKE 'qadj_obj_%');
