-- ══════════════════════════════════════════════════════════════════
-- Seguimiento y gestión de Quejas (FT-CA-24) — ciclo completo del buzón
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Agrega a cada queja los campos del seguimiento completo que se llevaba
-- en la hoja "Seguimiento de Buzón": validación, clasificación,
-- investigación, notificación al área (con número de oficio), resolución
-- y cierre.
--
-- Todo se guarda en UNA sola columna JSON llamada 'seguimiento', para no
-- crear decenas de columnas sueltas. Las llaves del JSON son, por ejemplo:
--   procede, priorizacion, gravedad, clasificacion, subclasificacion,
--   origen_seg, fecha_validacion, hora_validacion, revision_expediente,
--   llamada_entrevista, intentos_llamada, respuesta_llamada, recibe_llamada,
--   investigacion, investiga, medio_notificacion, fecha_notificacion,
--   persona_notifica, numero_oficio, resolucion, fecha_resolucion,
--   notif_solicitante, fecha_notif_solicitante, observaciones, categoria
--
-- No borra nada. Re-ejecutable.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.quejas
  ADD COLUMN IF NOT EXISTS seguimiento jsonb NOT NULL DEFAULT '{}'::jsonb;

-- Índice para poder filtrar/ordenar por campos del seguimiento más adelante
-- (priorización, gravedad, etc.) sin escaneos lentos.
CREATE INDEX IF NOT EXISTS idx_quejas_seguimiento ON public.quejas USING gin (seguimiento);

-- Verificación
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'quejas' AND column_name = 'seguimiento';
