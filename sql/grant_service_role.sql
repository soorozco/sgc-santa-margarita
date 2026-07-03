-- ══════════════════════════════════════════════════════════════════
-- Migración: Permisos para service_role
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- El rol service_role (usado por el importador de documentos externos
-- y el robot verificador de normas en GitHub Actions) no tenía
-- permisos sobre las tablas, porque las migraciones anteriores solo
-- otorgaron GRANT a anon/authenticated.
--
-- service_role es la llave "administrativa" de Supabase: nunca se usa
-- en el navegador, solo en scripts del lado servidor.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

GRANT USAGE ON SCHEMA public TO service_role;
GRANT ALL ON ALL TABLES IN SCHEMA public TO service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO service_role;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO service_role;

-- Que las tablas que se creen en el futuro también tengan permisos
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT ALL ON TABLES TO service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT ALL ON SEQUENCES TO service_role;

-- ── Verificación: debe listar las tablas con privilegios ──────────
SELECT table_name, privilege_type
FROM information_schema.table_privileges
WHERE grantee = 'service_role' AND table_schema = 'public'
ORDER BY table_name
LIMIT 20;
