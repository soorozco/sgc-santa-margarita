-- ══════════════════════════════════════════════════════════════════
-- Aviso por Telegram al registrarse un incidente clínico
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- En cuanto alguien notifica un incidente, la base manda un mensaje
-- de Telegram. Es inmediato y no depende de ningún servicio externo
-- que haya que pagar o mantener.
--
-- POR PRIVACIDAD, el mensaje NO lleva el nombre del paciente ni la
-- descripción del caso: solo el tipo, la gravedad, el área y la hora,
-- con una liga para entrar al sistema. Telegram queda fuera del
-- control del hospital, así que ahí no viajan datos identificables.
--
-- Si el envío falla (sin internet, token vencido), el incidente SE
-- GUARDA IGUAL. Avisar nunca debe impedir notificar.
--
-- ANTES DE EJECUTAR necesitas dos datos (ver instrucciones abajo):
--   · el token del bot
--   · el identificador del chat
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── 1. Extensión que permite a la base hacer llamadas HTTP ────────
CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;

-- ── 2. Dónde se guardan el token y el chat ────────────────────────
-- Tabla privada: nadie puede leerla desde la aplicación.
CREATE TABLE IF NOT EXISTS public.app_config (
  clave       TEXT PRIMARY KEY,
  valor       TEXT NOT NULL,
  descripcion TEXT,
  updated_at  TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.app_config ENABLE ROW LEVEL SECURITY;
-- Sin políticas = nadie con sesión normal puede verla ni escribirla.
REVOKE ALL ON public.app_config FROM anon, authenticated;

-- ⬇⬇⬇  SUSTITUYE LOS DOS VALORES DE ABAJO  ⬇⬇⬇
INSERT INTO public.app_config (clave, valor, descripcion) VALUES
  ('telegram_token',   'PON_AQUI_EL_TOKEN_DEL_BOT', 'Token del bot de Telegram'),
  ('telegram_chat_id', 'PON_AQUI_EL_CHAT_ID',       'Chat o grupo que recibe los avisos')
ON CONFLICT (clave) DO UPDATE
  SET valor = EXCLUDED.valor, updated_at = now();

-- ── 3. Armado del mensaje ─────────────────────────────────────────
-- Separado del envío para poder revisarlo sin mandar nada.
CREATE OR REPLACE FUNCTION public.mensaje_incidente(r public.clinical_incidents)
RETURNS TEXT
LANGUAGE plpgsql IMMUTABLE
SET search_path = public
AS $$
DECLARE
  v_icono TEXT;
  v_hora  TEXT;
BEGIN
  v_icono := CASE r.damage_level
    WHEN 'Muerte'   THEN '⚫'
    WHEN 'Grave'    THEN '🔴'
    WHEN 'Moderado' THEN '🟠'
    WHEN 'Leve'     THEN '🟡'
    ELSE '🟢'
  END;

  v_hora := coalesce(to_char(r.incident_date, 'DD/MM/YYYY'), 'sin fecha');
  IF coalesce(r.incident_time, '') <> '' THEN
    v_hora := v_hora || ' ' || r.incident_time;
  END IF;

  RETURN v_icono || ' <b>Nuevo incidente notificado</b>' || E'\n\n'
      || '<b>Tipo:</b> '     || coalesce(r.incident_type, '—')    || E'\n'
      || '<b>Daño:</b> '     || coalesce(r.damage_level, '—')     || E'\n'
      || '<b>Área:</b> '     || coalesce(r.location, '—')         || E'\n'
      || '<b>Categoría:</b> '|| coalesce(r.incident_subtype, '—') || E'\n'
      || '<b>Ocurrió:</b> '  || v_hora || E'\n\n'
      || '<a href="https://soorozco.github.io/sgc-santa-margarita/eventos-adversos.html">'
      || 'Ver el detalle en el sistema</a>' || E'\n'
      || '<i>Por privacidad no se incluyen datos del paciente.</i>';
END $$;

-- ── 4. Envío ──────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.avisar_incidente()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_token TEXT;
  v_chat  TEXT;
BEGIN
  -- Todo va protegido: si el aviso falla, el incidente se guarda igual.
  BEGIN
    SELECT valor INTO v_token FROM public.app_config WHERE clave = 'telegram_token';
    SELECT valor INTO v_chat  FROM public.app_config WHERE clave = 'telegram_chat_id';

    IF v_token IS NULL OR v_chat IS NULL
       OR v_token LIKE 'PON_AQUI%' OR v_chat LIKE 'PON_AQUI%' THEN
      RETURN NULL;   -- todavía sin configurar: no se avisa
    END IF;

    PERFORM net.http_post(
      url     := 'https://api.telegram.org/bot' || v_token || '/sendMessage',
      headers := '{"Content-Type": "application/json"}'::jsonb,
      body    := jsonb_build_object(
                   'chat_id',    v_chat,
                   'text',       public.mensaje_incidente(NEW),
                   'parse_mode', 'HTML',
                   'disable_web_page_preview', true
                 )
    );
  EXCEPTION WHEN OTHERS THEN
    NULL;  -- en silencio: notificar el incidente es lo prioritario
  END;

  RETURN NULL;
END $$;

DROP TRIGGER IF EXISTS trg_avisar_incidente ON public.clinical_incidents;
CREATE TRIGGER trg_avisar_incidente
  AFTER INSERT ON public.clinical_incidents
  FOR EACH ROW EXECUTE FUNCTION public.avisar_incidente();


-- ══════════════════════════════════════════════════════════════════
-- CÓMO OBTENER EL TOKEN Y EL CHAT
--
-- 1. En Telegram busca  @BotFather  y mándale  /newbot
--    Te pide un nombre y un usuario (debe terminar en "bot").
--    Al final te da el TOKEN: algo como 123456789:AAG...
--
-- 2. Escríbele algo a tu bot recién creado (un "hola" basta).
--    Si quieres que llegue a un grupo, agrega el bot al grupo
--    y manda un mensaje ahí.
--
-- 3. Abre en el navegador (sustituyendo TU_TOKEN):
--    https://api.telegram.org/botTU_TOKEN/getUpdates
--    Busca  "chat":{"id":  → ese número es el CHAT_ID.
--    En grupos es negativo (ej. -1001234567890): cópialo con el signo.
--
-- 4. Pon ambos valores en el INSERT del paso 2 y ejecuta este archivo.
-- ══════════════════════════════════════════════════════════════════


-- ══════════════════════════════════════════════════════════════════
-- PRUEBAS (ejecútalas por separado, después de configurar)
--
-- a) Ver cómo quedaría el mensaje del último incidente, SIN enviarlo:
--
--    SELECT public.mensaje_incidente(c) FROM public.clinical_incidents c
--    ORDER BY created_at DESC LIMIT 1;
--
-- b) Mandar un mensaje de prueba a Telegram ahora mismo:
--
--    SELECT net.http_post(
--      url     := 'https://api.telegram.org/bot'
--                 || (SELECT valor FROM public.app_config WHERE clave='telegram_token')
--                 || '/sendMessage',
--      headers := '{"Content-Type": "application/json"}'::jsonb,
--      body    := jsonb_build_object(
--                   'chat_id', (SELECT valor FROM public.app_config WHERE clave='telegram_chat_id'),
--                   'text',    'Prueba del SGC: los avisos de incidentes ya están activos.')
--    );
--
-- c) Revisar si Telegram respondió bien (200 = correcto):
--    Espera unos segundos tras la prueba y ejecuta:
--
--    SELECT status_code, content FROM net._http_response
--    ORDER BY created DESC LIMIT 3;
--
-- PARA DESACTIVAR LOS AVISOS:
--    DROP TRIGGER IF EXISTS trg_avisar_incidente ON public.clinical_incidents;
-- ══════════════════════════════════════════════════════════════════
