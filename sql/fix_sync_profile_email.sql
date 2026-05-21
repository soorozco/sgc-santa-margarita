-- ═══════════════════════════════════════════════════════════════
-- FIX: sync_profile_email — agrega EXCEPTION handler
-- Este trigger también dispara en INSERT y bloqueaba la creación
-- de nuevos usuarios con "Database error saving new user"
-- Ejecutar en Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════

-- 1. Ver el código actual de la función
SELECT prosrc
FROM pg_proc
WHERE proname = 'sync_profile_email';

-- 2. Reemplazar con versión que no bloquea el INSERT
CREATE OR REPLACE FUNCTION public.sync_profile_email()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  UPDATE public.profiles
  SET email = new.email
  WHERE id = new.id;

  RETURN new;
EXCEPTION
  WHEN OTHERS THEN
    RETURN new;
END;
$$;

-- 3. Verificar que quedó bien
SELECT prosrc
FROM pg_proc
WHERE proname = 'sync_profile_email';
