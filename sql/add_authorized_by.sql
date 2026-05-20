-- Agregar columna authorized_by a la tabla documents
-- Ejecutar una sola vez en el SQL Editor de Supabase

ALTER TABLE documents
  ADD COLUMN IF NOT EXISTS authorized_by text;
