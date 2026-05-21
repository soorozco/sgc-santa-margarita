-- ═══════════════════════════════════════════════════════════════
-- FIX v2: Creación de usuarios — solución completa
-- Ejecutar en Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════

-- ── 1. Asegurar DEFAULT en columnas que pueden causar fallo ─────
ALTER TABLE public.profiles
  ALTER COLUMN permissions   SET DEFAULT '{}'::jsonb,
  ALTER COLUMN full_name     DROP NOT NULL,
  ALTER COLUMN role_id       DROP NOT NULL,
  ALTER COLUMN department_id DROP NOT NULL;

-- ── 2. Reescribir la función del trigger ────────────────────────
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, permissions)
  VALUES (
    new.id,
    new.email,
    COALESCE(
      new.raw_user_meta_data->>'full_name',
      split_part(new.email, '@', 1)
    ),
    '{}'::jsonb
  )
  ON CONFLICT (id) DO UPDATE
    SET email     = EXCLUDED.email,
        full_name = COALESCE(EXCLUDED.full_name, profiles.full_name);

  RETURN new;
EXCEPTION
  WHEN OTHERS THEN
    RETURN new;
END;
$$;

-- ── 3. Recrear el trigger ───────────────────────────────────────
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- ── 4. Verificar resultado ──────────────────────────────────────
SELECT
  c.column_name,
  c.is_nullable,
  c.column_default
FROM information_schema.columns c
WHERE c.table_schema = 'public'
  AND c.table_name   = 'profiles'
ORDER BY c.ordinal_position;
