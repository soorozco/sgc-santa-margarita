-- ============================================================
--  Fix: quitar NOT NULL de patient_name + reimportar datos
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- 1. Quitar todas las restricciones NOT NULL (el formulario puede dejar campos vacíos)
ALTER TABLE clinical_incidents
  ALTER COLUMN patient_name   DROP NOT NULL,
  ALTER COLUMN incident_date  DROP NOT NULL,
  ALTER COLUMN incident_type  DROP NOT NULL;

-- 2. Limpiar cualquier registro parcial del intento fallido
TRUNCATE TABLE clinical_incidents RESTART IDENTITY CASCADE;
