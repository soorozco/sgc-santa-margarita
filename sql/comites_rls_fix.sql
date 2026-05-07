-- Fix RLS: agregar permisos para roles anon y authenticated
-- Ejecutar en Supabase → SQL Editor

DROP POLICY IF EXISTS "cmt_all" ON committees;
DROP POLICY IF EXISTS "mbr_all" ON committee_members;
DROP POLICY IF EXISTS "ses_all" ON committee_sessions;
DROP POLICY IF EXISTS "att_all" ON session_attendance;
DROP POLICY IF EXISTS "agr_all" ON session_agreements;

CREATE POLICY "cmt_all" ON committees        FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "mbr_all" ON committee_members  FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "ses_all" ON committee_sessions FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "att_all" ON session_attendance FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "agr_all" ON session_agreements FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

-- Verificar que el dato sigue ahí
SELECT code, name FROM committees WHERE code = 'COCASEP';
