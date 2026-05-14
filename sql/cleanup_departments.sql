-- ============================================================
--  Limpieza de departamentos — Hospital Santa Margarita
--  SGC ISO 9001:2015  (versión 5 — deshabilita RLS en profiles)
--
--  Ejecutar completo de una vez en Supabase SQL Editor
-- ============================================================

-- RLS en profiles bloquea el UPDATE aunque seamos admin.
-- Lo deshabilitamos solo durante la limpieza y lo volvemos a activar.
ALTER TABLE profiles DISABLE ROW LEVEL SECURITY;

DO $$
DECLARE
  dept_ids uuid[];
  n_qi     int;
  n_prof   int;
  n_del    int;
BEGIN
  -- IDs de departamentos sin ningún documento
  SELECT ARRAY_AGG(d.id) INTO dept_ids
  FROM departments d
  LEFT JOIN documents doc ON doc.department_id = d.id
  GROUP BY d.id
  HAVING COUNT(doc.id) = 0;

  IF dept_ids IS NULL THEN
    RAISE NOTICE 'No hay departamentos vacíos. Nada que eliminar.';
    RETURN;
  END IF;

  RAISE NOTICE '% departamentos vacíos encontrados.', ARRAY_LENGTH(dept_ids, 1);

  -- Liberar FK en quality_indicators
  UPDATE quality_indicators
    SET responsible_department_id = NULL
    WHERE responsible_department_id = ANY(dept_ids);
  GET DIAGNOSTICS n_qi = ROW_COUNT;
  RAISE NOTICE '  quality_indicators actualizados: %', n_qi;

  -- Liberar FK en profiles (RLS deshabilitado arriba)
  UPDATE profiles
    SET department_id = NULL
    WHERE department_id = ANY(dept_ids);
  GET DIAGNOSTICS n_prof = ROW_COUNT;
  RAISE NOTICE '  profiles actualizados: %', n_prof;

  -- Eliminar departamentos vacíos
  DELETE FROM departments WHERE id = ANY(dept_ids);
  GET DIAGNOSTICS n_del = ROW_COUNT;
  RAISE NOTICE '  departamentos eliminados: %', n_del;
END;
$$;

-- Volver a activar RLS en profiles
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Verificación final
SELECT
  d.code,
  d.name,
  COUNT(doc.id) AS num_documentos
FROM departments d
LEFT JOIN documents doc ON doc.department_id = d.id
GROUP BY d.id, d.code, d.name
ORDER BY num_documentos DESC, d.code;
