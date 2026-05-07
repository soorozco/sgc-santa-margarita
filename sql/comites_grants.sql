-- Fix permisos PostgreSQL en tablas de comités
GRANT ALL ON committees, committee_members, committee_sessions, session_attendance, session_agreements TO anon, authenticated;

-- Verificación
SELECT code, name FROM committees WHERE code = 'COCASEP';
