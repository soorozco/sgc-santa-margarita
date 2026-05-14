-- ============================================================
--  Limpieza de departamentos — Hospital Santa Margarita
--  SGC ISO 9001:2015  (versión 4 — DO block, transacción única)
--
--  Ejecutar completo de una vez en Supabase SQL Editor
-- ============================================================

DO $$
DECLARE
  dept_ids uuid[];
  n_deleted int;
BEGIN
  -- Recopilar IDs de departamentos sin ningún documento
  SELECT ARRAY_AGG(d.id) INTO dept_ids
  FROM departments d
  LEFT JOIN documents doc ON doc.department_id = d.id
  GROUP BY d.id
  HAVING COUNT(doc.id) = 0;

  IF dept_ids IS NULL THEN
    RAISE NOTICE 'No hay departamentos vacíos. Nada que eliminar.';
    RETURN;
  END IF;

  RAISE NOTICE 'Departamentos a eliminar: %', ARRAY_LENGTH(dept_ids, 1);

  -- Liberar FK en quality_indicators
  UPDATE quality_indicators
  SET responsible_department_id = NULL
  WHERE responsible_department_id = ANY(dept_ids);

  -- Liberar FK en profiles
  UPDATE profiles
  SET department_id = NULL
  WHERE department_id = ANY(dept_ids);

  -- Eliminar departamentos vacíos
  DELETE FROM departments WHERE id = ANY(dept_ids);
  GET DIAGNOSTICS n_deleted = ROW_COUNT;

  RAISE NOTICE 'Eliminados: % departamentos.', n_deleted;
END;
$$;

-- Verificación — solo deben quedar los departamentos con documentos
SELECT
  d.code,
  d.name,
  COUNT(doc.id) AS num_documentos
FROM departments d
LEFT JOIN documents doc ON doc.department_id = d.id
GROUP BY d.id, d.code, d.name
ORDER BY num_documentos DESC, d.code;
