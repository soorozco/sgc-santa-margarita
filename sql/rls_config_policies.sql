-- ============================================================
--  Políticas RLS para módulo de Configuración
--  Hospital Santa Margarita · SGC ISO 9001:2015
--
--  Permite a administrador y responsable_calidad hacer
--  INSERT / UPDATE / DELETE en departments y document_types
--
--  Ejecutar en Supabase SQL Editor
-- ============================================================

-- ── Helper: verifica si el usuario actual es admin/calidad ─────
-- (reutilizado en cada política con EXISTS para performance)

-- ── DEPARTMENTS ────────────────────────────────────────────────

-- INSERT
DROP POLICY IF EXISTS "cfg_insert_departments" ON departments;
CREATE POLICY "cfg_insert_departments" ON departments
FOR INSERT TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1 FROM profiles p
    JOIN roles r ON r.id = p.role_id
    WHERE p.id = auth.uid()
      AND r.name IN ('administrador', 'responsable_calidad')
  )
);

-- UPDATE
DROP POLICY IF EXISTS "cfg_update_departments" ON departments;
CREATE POLICY "cfg_update_departments" ON departments
FOR UPDATE TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM profiles p
    JOIN roles r ON r.id = p.role_id
    WHERE p.id = auth.uid()
      AND r.name IN ('administrador', 'responsable_calidad')
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM profiles p
    JOIN roles r ON r.id = p.role_id
    WHERE p.id = auth.uid()
      AND r.name IN ('administrador', 'responsable_calidad')
  )
);

-- DELETE
DROP POLICY IF EXISTS "cfg_delete_departments" ON departments;
CREATE POLICY "cfg_delete_departments" ON departments
FOR DELETE TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM profiles p
    JOIN roles r ON r.id = p.role_id
    WHERE p.id = auth.uid()
      AND r.name IN ('administrador', 'responsable_calidad')
  )
);

-- ── DOCUMENT_TYPES ─────────────────────────────────────────────

-- INSERT
DROP POLICY IF EXISTS "cfg_insert_document_types" ON document_types;
CREATE POLICY "cfg_insert_document_types" ON document_types
FOR INSERT TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1 FROM profiles p
    JOIN roles r ON r.id = p.role_id
    WHERE p.id = auth.uid()
      AND r.name IN ('administrador', 'responsable_calidad')
  )
);

-- UPDATE
DROP POLICY IF EXISTS "cfg_update_document_types" ON document_types;
CREATE POLICY "cfg_update_document_types" ON document_types
FOR UPDATE TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM profiles p
    JOIN roles r ON r.id = p.role_id
    WHERE p.id = auth.uid()
      AND r.name IN ('administrador', 'responsable_calidad')
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM profiles p
    JOIN roles r ON r.id = p.role_id
    WHERE p.id = auth.uid()
      AND r.name IN ('administrador', 'responsable_calidad')
  )
);

-- DELETE
DROP POLICY IF EXISTS "cfg_delete_document_types" ON document_types;
CREATE POLICY "cfg_delete_document_types" ON document_types
FOR DELETE TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM profiles p
    JOIN roles r ON r.id = p.role_id
    WHERE p.id = auth.uid()
      AND r.name IN ('administrador', 'responsable_calidad')
  )
);

-- ── Verificación ───────────────────────────────────────────────
SELECT tablename, policyname, cmd, roles
FROM pg_policies
WHERE tablename IN ('departments', 'document_types')
ORDER BY tablename, cmd;
