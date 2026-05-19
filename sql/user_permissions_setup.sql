-- ============================================================
--  Control de permisos por usuario
--  Hospital Santa Margarita · SGC ISO 9001:2015
-- ============================================================

-- Agrega columna permissions al perfil del usuario.
-- Es un objeto JSON que mapea módulo → true/false.
-- Ausencia de clave o valor true = acceso permitido.
-- false = acceso bloqueado.
-- {} vacío = acceso completo (compatibilidad con usuarios existentes).

ALTER TABLE profiles
  ADD COLUMN IF NOT EXISTS permissions jsonb NOT NULL DEFAULT '{}'::jsonb;

-- Política RLS: el administrador puede leer y actualizar todos los perfiles.
-- (Si ya existe una política general, estas pueden ser redundantes.)

-- Lectura: admin ve todos los perfiles
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'profiles' AND policyname = 'admin_read_all_profiles'
  ) THEN
    EXECUTE $pol$
      CREATE POLICY admin_read_all_profiles ON profiles
        FOR SELECT
        USING (
          auth.uid() = id
          OR EXISTS (
            SELECT 1 FROM profiles p
            JOIN roles r ON r.id = p.role_id
            WHERE p.id = auth.uid() AND r.name = 'administrador'
          )
        );
    $pol$;
  END IF;
END $$;

-- Escritura: admin puede actualizar permisos de cualquier usuario
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'profiles' AND policyname = 'admin_update_permissions'
  ) THEN
    EXECUTE $pol$
      CREATE POLICY admin_update_permissions ON profiles
        FOR UPDATE
        USING (
          EXISTS (
            SELECT 1 FROM profiles p
            JOIN roles r ON r.id = p.role_id
            WHERE p.id = auth.uid() AND r.name = 'administrador'
          )
        );
    $pol$;
  END IF;
END $$;

-- Verificación
SELECT id, full_name, permissions
FROM profiles
ORDER BY full_name
LIMIT 20;
