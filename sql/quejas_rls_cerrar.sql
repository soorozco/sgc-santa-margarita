-- ══════════════════════════════════════════════════════════════════
-- Cerrar el acceso público a Quejas, Sugerencias y Felicitaciones
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- HOY estas tablas están abiertas a internet: cualquiera con la llave
-- pública (que está en el repositorio público) puede LEER y hasta
-- BORRAR las quejas, con nombres y teléfonos incluidos. Lo causó una
-- migración anterior (quejas_rls_fix.sql) que puso USING(true) para el
-- rol anónimo y un GRANT ALL TO anon.
--
-- Esta migración lo corrige:
--   · Nadie sin iniciar sesión puede ver ni tocar estas tablas.
--   · Las ven: administrador, responsable_calidad, jefe_departamento
--     y recepción (los mismos que ya trabajan quejas en la app).
--   · Escriben: los mismos, salvo recepción que no borra.
--   · El robot de sincronización usa la llave service_role, que pasa
--     por encima de RLS, así que no necesita política.
--
-- NO borra ni un solo registro. Solo cambia quién puede verlos.
-- Para revertir, al final del archivo está cómo.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── 1. Quitar el permiso abierto que causaba la fuga ──────────────
REVOKE ALL ON public.quejas       FROM anon;
REVOKE ALL ON public.quejas_notas FROM anon;

GRANT  SELECT, INSERT, UPDATE, DELETE ON public.quejas       TO authenticated;
GRANT  SELECT, INSERT, UPDATE, DELETE ON public.quejas_notas TO authenticated;

-- ── 2. Función auxiliar: ¿qué rol tiene el usuario conectado? ──────
-- SECURITY DEFINER evita la recursión de leer profiles dentro de una
-- política sobre profiles, y hace la comprobación rápida.
CREATE OR REPLACE FUNCTION public.tiene_rol(roles TEXT[])
RETURNS BOOLEAN
LANGUAGE sql SECURITY DEFINER STABLE
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles p
    JOIN public.roles r ON r.id = p.role_id
    WHERE p.id = auth.uid() AND r.name = ANY(roles)
  )
$$;

-- ── 3. Políticas de quejas ────────────────────────────────────────
ALTER TABLE public.quejas ENABLE ROW LEVEL SECURITY;

-- Fuera las políticas abiertas anteriores (de quejas_rls_fix.sql)
DROP POLICY IF EXISTS "qj_all"                ON public.quejas;
DROP POLICY IF EXISTS "auth_see_quejas"       ON public.quejas;
DROP POLICY IF EXISTS "writers_insert_quejas" ON public.quejas;
DROP POLICY IF EXISTS "admins_update_quejas"  ON public.quejas;
DROP POLICY IF EXISTS "qj_select" ON public.quejas;
DROP POLICY IF EXISTS "qj_insert" ON public.quejas;
DROP POLICY IF EXISTS "qj_update" ON public.quejas;
DROP POLICY IF EXISTS "qj_delete" ON public.quejas;

-- Ver: los roles que atienden quejas
CREATE POLICY "qj_select" ON public.quejas
  FOR SELECT TO authenticated
  USING (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

-- Capturar: los mismos
CREATE POLICY "qj_insert" ON public.quejas
  FOR INSERT TO authenticated
  WITH CHECK (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

-- Modificar / dar seguimiento: los mismos
CREATE POLICY "qj_update" ON public.quejas
  FOR UPDATE TO authenticated
  USING (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']))
  WITH CHECK (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

-- Borrar: solo Calidad y Dirección (recepción no)
CREATE POLICY "qj_delete" ON public.quejas
  FOR DELETE TO authenticated
  USING (public.tiene_rol(ARRAY['administrador','responsable_calidad']));

-- ── 4. Políticas de quejas_notas (mismo criterio) ─────────────────
ALTER TABLE public.quejas_notas ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "qn_all"                ON public.quejas_notas;
DROP POLICY IF EXISTS "auth_see_notas"        ON public.quejas_notas;
DROP POLICY IF EXISTS "managers_insert_notas" ON public.quejas_notas;
DROP POLICY IF EXISTS "qn_select" ON public.quejas_notas;
DROP POLICY IF EXISTS "qn_insert" ON public.quejas_notas;
DROP POLICY IF EXISTS "qn_delete" ON public.quejas_notas;

CREATE POLICY "qn_select" ON public.quejas_notas
  FOR SELECT TO authenticated
  USING (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

CREATE POLICY "qn_insert" ON public.quejas_notas
  FOR INSERT TO authenticated
  WITH CHECK (public.tiene_rol(ARRAY['administrador','responsable_calidad','jefe_departamento','recepcion']));

CREATE POLICY "qn_delete" ON public.quejas_notas
  FOR DELETE TO authenticated
  USING (public.tiene_rol(ARRAY['administrador','responsable_calidad']));

-- ── 5. Verificación ───────────────────────────────────────────────
-- Debe listar las políticas nuevas (qj_* y qn_*), ninguna para 'anon'.
SELECT tablename, policyname, cmd, roles
FROM pg_policies
WHERE schemaname = 'public' AND tablename IN ('quejas','quejas_notas')
ORDER BY tablename, policyname;

-- ══════════════════════════════════════════════════════════════════
-- PARA REVERTIR (si algo saliera mal) — deja la tabla como estaba:
--   GRANT ALL ON public.quejas, public.quejas_notas TO anon, authenticated;
--   CREATE POLICY "qj_all" ON public.quejas       FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
--   CREATE POLICY "qn_all" ON public.quejas_notas FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
-- (No hace falta: ningún dato se pierde con esta migración.)
-- ══════════════════════════════════════════════════════════════════
