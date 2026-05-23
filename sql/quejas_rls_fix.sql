-- Fix RLS y permisos para tablas de quejas
-- Ejecutar en Supabase → SQL Editor

-- Eliminar políticas anteriores
DROP POLICY IF EXISTS "auth_see_quejas"      ON quejas;
DROP POLICY IF EXISTS "writers_insert_quejas" ON quejas;
DROP POLICY IF EXISTS "admins_update_quejas"  ON quejas;
DROP POLICY IF EXISTS "auth_see_notas"        ON quejas_notas;
DROP POLICY IF EXISTS "managers_insert_notas" ON quejas_notas;

-- Políticas simples (mismo patrón que el resto del proyecto)
CREATE POLICY "qj_all" ON quejas       FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "qn_all" ON quejas_notas FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

-- Permisos de acceso
GRANT ALL ON quejas, quejas_notas TO anon, authenticated;

-- Verificación
SELECT id, folio, tipo, status FROM quejas LIMIT 5;
