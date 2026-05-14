-- ============================================================
--  Limpieza de departamentos — Hospital Santa Margarita
--  SGC ISO 9001:2015  (versión 3 — resuelve FK profiles y quality_indicators)
--
--  Ejecutar completo de una vez en Supabase SQL Editor
-- ============================================================

-- Subquery reutilizable: IDs de departamentos sin documentos
-- (se repite en cada paso para evitar CTEs que algunos clientes no soportan)

-- PASO 1: Quitar referencias en quality_indicators
UPDATE quality_indicators
SET responsible_department_id = NULL
WHERE responsible_department_id IN (
  SELECT d.id
  FROM departments d
  LEFT JOIN documents doc ON doc.department_id = d.id
  GROUP BY d.id
  HAVING COUNT(doc.id) = 0
);

-- PASO 2: Quitar referencias en profiles
UPDATE profiles
SET department_id = NULL
WHERE department_id IN (
  SELECT d.id
  FROM departments d
  LEFT JOIN documents doc ON doc.department_id = d.id
  GROUP BY d.id
  HAVING COUNT(doc.id) = 0
);

-- PASO 3: Eliminar departamentos vacíos
DELETE FROM departments
WHERE id IN (
  SELECT d.id
  FROM departments d
  LEFT JOIN documents doc ON doc.department_id = d.id
  GROUP BY d.id
  HAVING COUNT(doc.id) = 0
);

-- PASO 4: Verificación — solo deben quedar los 11 con documentos
SELECT
  d.code,
  d.name,
  COUNT(doc.id) AS num_documentos
FROM departments d
LEFT JOIN documents doc ON doc.department_id = d.id
GROUP BY d.id, d.code, d.name
ORDER BY num_documentos DESC, d.code;
