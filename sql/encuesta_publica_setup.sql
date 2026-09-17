-- ══════════════════════════════════════════════════════════════════
-- Encuesta y Quejas PÚBLICAS (QR de habitación) — Hospital Santa Margarita
--
-- Permite que un paciente/familiar, SIN iniciar sesión (rol anon), pueda
-- ENVIAR una encuesta de satisfacción y una queja/sugerencia/felicitación
-- desde la página pública encuesta.html.
--
-- Seguridad:
--   • Se otorga SOLO permiso de INSERT al rol anónimo (no puede leer,
--     modificar ni borrar datos de nadie).
--   • NO se activa/desactiva RLS (para no alterar el acceso actual del
--     panel). Si las tablas ya tienen RLS activo, la política de abajo
--     habilita el INSERT anónimo; si no lo tienen, basta el GRANT.
--
-- No borra nada. Re-ejecutable. Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- 1) Columna con el detalle completo de la encuesta del paciente (todas
--    las preguntas tal cual las respondió), sin tocar el resto de columnas.
ALTER TABLE public.satisfaction_surveys
  ADD COLUMN IF NOT EXISTS respuestas_paciente jsonb;

-- 2) created_by puede quedar vacío (el paciente no está autenticado).
ALTER TABLE public.satisfaction_surveys ALTER COLUMN created_by DROP NOT NULL;
ALTER TABLE public.quejas               ALTER COLUMN created_by DROP NOT NULL;

-- 3) Permitir SOLO insertar al rol anónimo.
GRANT INSERT ON public.satisfaction_surveys TO anon;
GRANT INSERT ON public.quejas               TO anon;

-- 4) Políticas de INSERT para anon (aplican si la tabla tiene RLS activo).
DROP POLICY IF EXISTS "anon_insert_surveys" ON public.satisfaction_surveys;
CREATE POLICY "anon_insert_surveys" ON public.satisfaction_surveys
  FOR INSERT TO anon WITH CHECK (true);

DROP POLICY IF EXISTS "anon_insert_quejas" ON public.quejas;
CREATE POLICY "anon_insert_quejas" ON public.quejas
  FOR INSERT TO anon WITH CHECK (true);

-- Verificación
SELECT 'satisfaction_surveys' AS tabla, has_table_privilege('anon','public.satisfaction_surveys','INSERT') AS anon_puede_insertar
UNION ALL
SELECT 'quejas', has_table_privilege('anon','public.quejas','INSERT');
