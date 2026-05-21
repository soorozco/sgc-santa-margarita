-- ── Consulta A: Ver TODOS los triggers activos en auth.users ───
SELECT
  tgname    AS trigger_nombre,
  tgenabled AS habilitado,
  pg_get_triggerdef(t.oid) AS definicion
FROM pg_trigger t
JOIN pg_class c ON c.oid = t.tgrelid
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'auth'
  AND c.relname = 'users'
  AND NOT tgisinternal;

-- ── Consulta B: ¿El correo ya existe de intentos anteriores? ───
SELECT id, email, created_at, email_confirmed_at
FROM auth.users
WHERE email ILIKE '%epidemiologia%'
   OR email ILIKE '%hsm%';
