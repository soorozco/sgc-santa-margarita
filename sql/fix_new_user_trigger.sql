-- ═══════════════════════════════════════════════════════════════
-- FIX: Trigger de creación de usuario
-- Soluciona "Database error saving new user" al crear usuarios
-- desde el panel de Configuración.
-- Ejecutar en Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════

-- ── 1. Ver el trigger actual (diagnóstico) ──────────────────────
SELECT trigger_name, event_manipulation, action_statement
FROM information_schema.triggers
WHERE event_object_schema = 'auth'
  AND event_object_table   = 'users';

-- ── 2. Reemplazar la función del trigger con versión robusta ────
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name)
  VALUES (
    new.id,
    new.email,
    COALESCE(
      new.raw_user_meta_data->>'full_name',
      split_part(new.email, '@', 1)
    )
  )
  ON CONFLICT (id) DO UPDATE
    SET email     = EXCLUDED.email,
        full_name = COALESCE(EXCLUDED.full_name, profiles.full_name);

  RETURN new;
EXCEPTION
  WHEN OTHERS THEN
    -- No bloquear la creación del usuario aunque falle el perfil
    RETURN new;
END;
$$;

-- ── 3. Asegurarse de que el trigger existe ──────────────────────
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- ── 4. Verificar ────────────────────────────────────────────────
SELECT trigger_name, event_manipulation
FROM information_schema.triggers
WHERE event_object_schema = 'auth'
  AND event_object_table   = 'users';
