-- ══════════════════════════════════════════════════════════════════
-- Incidentes — arreglar la regla que impide guardar desde el formulario
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- El formulario "Notificar Incidente" ya llega a la tabla (el permiso
-- se arregló), pero la regla RLS de inserción lo rechaza con:
--   "new row violates row-level security policy"
--
-- Causa: la política de INSERT comprobaba  auth.role() = 'authenticated'.
-- Esa función quedó obsoleta en Supabase y puede devolver NULL, con lo
-- que la condición nunca se cumple. Se reemplaza por el patrón actual:
-- restringir la política al rol 'authenticated' con la cláusula TO, que
-- no depende de ninguna función.
--
-- Cualquier persona con sesión puede notificar un incidente (así debe
-- ser: es un buzón de seguridad del paciente para todo el personal).
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.clinical_incidents ENABLE ROW LEVEL SECURITY;

-- Fuera cualquier política de INSERT anterior (vieja o basada en auth.role)
DROP POLICY IF EXISTS "service_insert_incidents" ON public.clinical_incidents;
DROP POLICY IF EXISTS "admins_insert_incidents"  ON public.clinical_incidents;
DROP POLICY IF EXISTS "ci_insert"                ON public.clinical_incidents;

-- Nueva política: cualquier usuario con sesión puede insertar.
-- TO authenticated ya limita al rol correcto; no hace falta más.
CREATE POLICY "ci_insert" ON public.clinical_incidents
  FOR INSERT TO authenticated
  WITH CHECK (true);

-- ── Verificación ──────────────────────────────────────────────────
-- Debe listar 'ci_insert' con cmd = INSERT y roles = {authenticated}
SELECT policyname, cmd, roles, with_check
FROM pg_policies
WHERE schemaname = 'public' AND tablename = 'clinical_incidents'
ORDER BY cmd, policyname;
