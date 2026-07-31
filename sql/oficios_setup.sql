-- ══════════════════════════════════════════════════════════════════
-- Oficios — Oficina de Calidad · SGC ISO 9001:2015
-- Hospital Santa Margarita
--
-- Catálogo de oficios (comunicaciones oficiales). El documento (PDF)
-- se queda en Google Drive; aquí se guardan los datos del oficio y un
-- ENLACE al archivo. Cada oficio se puede VINCULAR a:
--   · una queja / sugerencia / felicitación  (queja_id)
--   · una no conformidad                       (nonconformity_id)
-- Los vínculos son opcionales y no borran nada al eliminarse el origen
-- (ON DELETE SET NULL: si se borra la queja, el oficio queda sin liga).
--
-- Acceso (igual que Quejas): lo ven y capturan administrador,
-- responsable_calidad, jefe_departamento y recepción; solo Calidad y
-- Dirección pueden borrar. Requiere la función public.tiene_rol()
-- creada en sql/quejas_rls_cerrar.sql (ya ejecutada).
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── 1. Tabla ──────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.oficios (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  numero           text,                         -- número de oficio (manual)
  fecha            date NOT NULL DEFAULT current_date,
  tipo             text,                         -- respuesta_queja | solicitud | circular | otro
  asunto           text,
  dirigido_a       text,                         -- destinatario
  emitido_por      text,                         -- área/persona que lo emite
  firmado_por      text,
  estado           text NOT NULL DEFAULT 'enviado', -- borrador|enviado|respondido|archivado
  documento_url    text,                         -- enlace al archivo en Drive
  notas            text,
  queja_id         uuid REFERENCES public.quejas(id)          ON DELETE SET NULL,
  nonconformity_id uuid REFERENCES public.nonconformities(id) ON DELETE SET NULL,
  created_by       uuid,
  created_at       timestamptz NOT NULL DEFAULT now(),
  updated_at       timestamptz NOT NULL DEFAULT now()
);

-- Búsquedas frecuentes por vínculo
CREATE INDEX IF NOT EXISTS idx_oficios_queja  ON public.oficios(queja_id)         WHERE queja_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_oficios_nc     ON public.oficios(nonconformity_id) WHERE nonconformity_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_oficios_fecha  ON public.oficios(fecha DESC);

-- ── 2. Permisos y RLS ─────────────────────────────────────────────
REVOKE ALL ON public.oficios FROM anon;
GRANT  SELECT, INSERT, UPDATE, DELETE ON public.oficios TO authenticated;

ALTER TABLE public.oficios ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "of_select" ON public.oficios;
DROP POLICY IF EXISTS "of_insert" ON public.oficios;
DROP POLICY IF EXISTS "of_update" ON public.oficios;
DROP POLICY IF EXISTS "of_delete" ON public.oficios;

CREATE POLICY "of_select" ON public.oficios
  FOR SELECT TO authenticated
  USING (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

CREATE POLICY "of_insert" ON public.oficios
  FOR INSERT TO authenticated
  WITH CHECK (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

CREATE POLICY "of_update" ON public.oficios
  FOR UPDATE TO authenticated
  USING (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']))
  WITH CHECK (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

CREATE POLICY "of_delete" ON public.oficios
  FOR DELETE TO authenticated
  USING (public.tiene_rol(ARRAY['administrador','responsable_calidad']));

-- ── 3. Verificación ───────────────────────────────────────────────
-- Debe listar of_select/insert/update/delete, ninguna para 'anon'.
SELECT tablename, policyname, cmd, roles
FROM pg_policies
WHERE schemaname = 'public' AND tablename = 'oficios'
ORDER BY policyname;
