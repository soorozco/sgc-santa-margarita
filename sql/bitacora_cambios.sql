-- ══════════════════════════════════════════════════════════════════
-- Bitácora de cambios (trazabilidad ISO 9001:2015 § 7.5.3)
-- Hospital Santa Margarita · SGC
--
-- Registra automáticamente QUIÉN creó, modificó o eliminó CADA
-- registro del sistema, y con qué valores quedó antes y después.
--
-- Usa la tabla audit_log, que ya existe en la base pero nunca se
-- había conectado. NO crea ni modifica ninguna tabla de datos, y NO
-- cambia el comportamiento de la aplicación.
--
-- Ejecutar en: Supabase → SQL Editor
-- Se puede volver a ejecutar cuantas veces quieras (es idempotente).
-- Para desactivarlo todo, ver el bloque final del archivo.
-- ══════════════════════════════════════════════════════════════════

-- ── 1. La función que escribe en la bitácora ──────────────────────

CREATE OR REPLACE FUNCTION public.registrar_en_bitacora()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER          -- puede escribir en audit_log aunque el usuario no
SET search_path = public
AS $$
DECLARE
  v_fila  JSONB;
  v_id    UUID;
  v_texto TEXT;
BEGIN
  -- Todo va dentro de un bloque protegido: si algo falla al registrar,
  -- el registro clínico o de calidad SE GUARDA IGUAL. La bitácora nunca
  -- debe impedir que alguien capture su trabajo.
  BEGIN
    -- Si es una modificación que no cambió nada, no la anotamos.
    IF TG_OP = 'UPDATE' AND to_jsonb(OLD) = to_jsonb(NEW) THEN
      RETURN NULL;
    END IF;

    v_fila := to_jsonb(COALESCE(NEW, OLD));

    -- El identificador solo se guarda si es UUID; hay tablas con id
    -- numérico y en esas queda nulo (el valor completo igual se guarda).
    v_texto := v_fila ->> 'id';
    IF v_texto ~ '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$' THEN
      v_id := v_texto::uuid;
    END IF;

    INSERT INTO public.audit_log (
      user_id, action, table_name, record_id, old_values, new_values
    ) VALUES (
      auth.uid(),        -- nulo si lo hizo un proceso automático (respaldo, importación)
      TG_OP,             -- INSERT | UPDATE | DELETE
      TG_TABLE_NAME,
      v_id,
      CASE WHEN TG_OP IN ('UPDATE', 'DELETE') THEN to_jsonb(OLD) END,
      CASE WHEN TG_OP IN ('INSERT', 'UPDATE') THEN to_jsonb(NEW) END
    );
  EXCEPTION WHEN OTHERS THEN
    NULL;  -- se ignora en silencio: nunca bloquear la captura
  END;

  RETURN NULL;  -- trigger AFTER: el valor de retorno no se usa
END $$;


-- ── 2. Conectarla a todas las tablas ──────────────────────────────
-- Recorre las tablas reales del esquema public y les pone el trigger.
-- Se excluye audit_log (se registraría a sí misma sin parar).

DO $$
DECLARE
  t     TEXT;
  n     INT := 0;
BEGIN
  FOR t IN
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'public'
      AND table_type   = 'BASE TABLE'
      AND table_name  <> 'audit_log'
    ORDER BY table_name
  LOOP
    EXECUTE format('DROP TRIGGER IF EXISTS trg_bitacora ON public.%I', t);
    EXECUTE format(
      'CREATE TRIGGER trg_bitacora
         AFTER INSERT OR UPDATE OR DELETE ON public.%I
         FOR EACH ROW EXECUTE FUNCTION public.registrar_en_bitacora()', t);
    n := n + 1;
  END LOOP;
  RAISE NOTICE 'Bitácora activada en % tablas.', n;
END $$;


-- ── 3. Proteger la bitácora ───────────────────────────────────────
-- Una bitácora que se puede editar no sirve como evidencia. Nadie
-- puede modificarla ni borrarla desde la aplicación; solo la escribe
-- la función de arriba. La consulta se limita a Dirección y Calidad.

ALTER TABLE public.audit_log ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS bitacora_lectura ON public.audit_log;
CREATE POLICY bitacora_lectura ON public.audit_log
  FOR SELECT TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles p
      JOIN public.roles r ON r.id = p.role_id
      WHERE p.id = auth.uid()
        AND r.name IN ('administrador', 'responsable_calidad', 'auditor')
    )
  );

-- Sin políticas de INSERT/UPDATE/DELETE: con RLS activo, la ausencia
-- de política significa que nadie puede hacerlo. La función escribe
-- porque es SECURITY DEFINER.

GRANT SELECT ON public.audit_log TO authenticated;
REVOKE INSERT, UPDATE, DELETE ON public.audit_log FROM authenticated, anon;


-- ── 4. Verificación ───────────────────────────────────────────────

-- (cada tabla tiene 3 eventos: INSERT, UPDATE y DELETE; contamos tablas)
SELECT count(DISTINCT event_object_table) AS tablas_con_bitacora
FROM information_schema.triggers
WHERE trigger_schema = 'public' AND trigger_name = 'trg_bitacora';

-- Prueba real sobre una tabla desechable, creada y eliminada aquí
-- mismo. No toca ninguna tabla de datos ni depende de sus columnas
-- obligatorias.
DO $$
DECLARE v_id UUID;
BEGIN
  CREATE TABLE public.zzz_prueba_bitacora (
    id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre TEXT
  );
  CREATE TRIGGER trg_bitacora
    AFTER INSERT OR UPDATE OR DELETE ON public.zzz_prueba_bitacora
    FOR EACH ROW EXECUTE FUNCTION public.registrar_en_bitacora();

  INSERT INTO public.zzz_prueba_bitacora (nombre) VALUES ('antes')
    RETURNING id INTO v_id;
  UPDATE public.zzz_prueba_bitacora SET nombre = 'después' WHERE id = v_id;
  DELETE FROM public.zzz_prueba_bitacora WHERE id = v_id;

  DROP TABLE public.zzz_prueba_bitacora;
END $$;

SELECT action,
       old_values ->> 'nombre' AS antes,
       new_values ->> 'nombre' AS despues,
       user_id IS NOT NULL AS identifico_usuario,
       created_at
FROM public.audit_log
WHERE table_name = 'zzz_prueba_bitacora'
ORDER BY created_at DESC;


-- ══════════════════════════════════════════════════════════════════
-- PARA DESACTIVAR TODO (si algo saliera mal)
-- Copia y ejecuta solo estas líneas, sin el guion doble del inicio:
--
-- DO $$ DECLARE t TEXT; BEGIN
--   FOR t IN SELECT table_name FROM information_schema.tables
--            WHERE table_schema='public' AND table_type='BASE TABLE'
--   LOOP EXECUTE format('DROP TRIGGER IF EXISTS trg_bitacora ON public.%I', t);
--   END LOOP; END $$;
--
-- Los datos no se tocan y lo ya registrado en audit_log se conserva.
-- ══════════════════════════════════════════════════════════════════
