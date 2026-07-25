-- ══════════════════════════════════════════════════════════════════
-- Aviso de incidentes por Telegram — varios destinatarios
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Permite que el aviso llegue a MÁS DE UN chat. En la configuración,
-- el valor de 'telegram_chat_id' puede ser uno o varios identificadores
-- separados por coma, por ejemplo:  1283636561,987654321
--
-- Cada mensaje se manda por separado a cada chat. Si uno falla, los
-- demás igual reciben, y el incidente siempre se guarda.
--
-- Ejecutar en: Supabase → SQL Editor
-- (reemplaza la función anterior; el disparador sigue igual)
-- ══════════════════════════════════════════════════════════════════

CREATE OR REPLACE FUNCTION public.avisar_incidente()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_token TEXT;
  v_chats TEXT;
  v_chat  TEXT;
  v_texto TEXT;
BEGIN
  BEGIN
    SELECT valor INTO v_token FROM public.app_config WHERE clave = 'telegram_token';
    SELECT valor INTO v_chats FROM public.app_config WHERE clave = 'telegram_chat_id';

    IF v_token IS NULL OR v_chats IS NULL
       OR v_token LIKE 'PON_AQUI%' OR v_chats LIKE 'PON_AQUI%' THEN
      RETURN NULL;   -- sin configurar: no se avisa
    END IF;

    v_texto := public.mensaje_incidente(NEW);

    -- Recorre cada chat de la lista separada por coma
    FOREACH v_chat IN ARRAY string_to_array(v_chats, ',')
    LOOP
      v_chat := btrim(v_chat);
      CONTINUE WHEN v_chat = '';
      PERFORM net.http_post(
        url     := 'https://api.telegram.org/bot' || v_token || '/sendMessage',
        headers := '{"Content-Type": "application/json"}'::jsonb,
        body    := jsonb_build_object(
                     'chat_id',    v_chat,
                     'text',       v_texto,
                     'parse_mode', 'HTML',
                     'disable_web_page_preview', true
                   )
      );
    END LOOP;
  EXCEPTION WHEN OTHERS THEN
    NULL;  -- nunca bloquear el guardado del incidente
  END;

  RETURN NULL;
END $$;

-- El disparador no cambia, pero lo dejamos por si aún no existía.
DROP TRIGGER IF EXISTS trg_avisar_incidente ON public.clinical_incidents;
CREATE TRIGGER trg_avisar_incidente
  AFTER INSERT ON public.clinical_incidents
  FOR EACH ROW EXECUTE FUNCTION public.avisar_incidente();

-- ══════════════════════════════════════════════════════════════════
-- CÓMO PONER LOS DOS DESTINATARIOS
--
-- Cuando tengas los dos identificadores de chat, ejecuta (con TUS
-- valores, separados por coma, sin espacios):
--
--   UPDATE public.app_config
--   SET valor = '1283636561,987654321'
--   WHERE clave = 'telegram_chat_id';
--
-- Puedes agregar cuantos quieras: 'id1,id2,id3'
-- ══════════════════════════════════════════════════════════════════
