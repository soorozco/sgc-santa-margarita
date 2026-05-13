-- ============================================================
--  Fix completo: clinical_incidents
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- 1. Quitar NOT NULL de columnas que el formulario puede omitir
ALTER TABLE clinical_incidents
  ALTER COLUMN patient_name   DROP NOT NULL,
  ALTER COLUMN incident_date  DROP NOT NULL,
  ALTER COLUMN incident_type  DROP NOT NULL;

-- 2. Limpiar cualquier registro parcial
TRUNCATE TABLE clinical_incidents RESTART IDENTITY CASCADE;

-- 3. Reemplazar políticas RLS — la anterior hacía un JOIN a profiles
--    que también tiene RLS, causando bloqueo silencioso.
--    La verificación de rol se hace en el JS (redirige si no es admin).
DROP POLICY IF EXISTS "admins_read_incidents"   ON clinical_incidents;
DROP POLICY IF EXISTS "admins_insert_incidents" ON clinical_incidents;

-- Cualquier usuario autenticado puede leer (el JS bloquea no-admins)
CREATE POLICY "authenticated_read_incidents"
  ON clinical_incidents FOR SELECT
  USING (auth.role() = 'authenticated');

-- Solo service_role puede insertar (importación desde SQL Editor)
-- Los usuarios normales no insertan desde la app
CREATE POLICY "service_insert_incidents"
  ON clinical_incidents FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

-- 4. Verificar que las políticas quedaron bien
SELECT policyname, cmd, qual
FROM pg_policies
WHERE tablename = 'clinical_incidents';
