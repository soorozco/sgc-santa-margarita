-- ============================================================
--  Fix: quitar NOT NULL de patient_name + reimportar datos
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- 1. Quitar la restricción NOT NULL (la tabla ya existe)
ALTER TABLE clinical_incidents
  ALTER COLUMN patient_name DROP NOT NULL;

-- 2. Limpiar cualquier registro parcial del intento fallido
TRUNCATE TABLE clinical_incidents RESTART IDENTITY CASCADE;
