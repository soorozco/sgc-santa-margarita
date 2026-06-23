-- ═══════════════════════════════════════════════════════════════
-- DIAGNÓSTICO — Ejecutar y compartir los resultados
-- ═══════════════════════════════════════════════════════════════

-- 1. Ver TODOS los triggers en auth.users
SELECT
  tgname        AS trigger_nombre,
  tgenabled     AS habilitado,
  pg_get_triggerdef(t.oid) AS definicion
FROM pg_trigger t
JOIN pg_class c ON c.oid = t.tgrelid
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'auth'
  AND c.relname = 'users';

-- 2. Ver el código exacto de handle_new_user
SELECT prosrc
FROM pg_proc
WHERE proname = 'handle_new_user';

-- 3. Ver si el correo ya existe en auth.users (de intentos anteriores)
SELECT id, email, created_at, email_confirmed_at, deleted_at
FROM auth.users
WHERE email = 'hsm.epidemiologia@gmail.com';
