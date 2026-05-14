-- ============================================================
--  Limpieza de departamentos — Hospital Santa Margarita
--  SGC ISO 9001:2015
--
--  INSTRUCCIONES:
--  1. Ejecuta primero el bloque DIAGNÓSTICO para revisar
--  2. Si todo es correcto, ejecuta el bloque LIMPIEZA
-- ============================================================


-- ============================================================
--  BLOQUE 1 — DIAGNÓSTICO (solo lectura, no modifica nada)
-- ============================================================

-- Ver TODOS los departamentos con su cantidad de documentos
SELECT
  d.code,
  d.name,
  COUNT(doc.id) AS num_documentos
FROM departments d
LEFT JOIN documents doc ON doc.department_id = d.id
GROUP BY d.id, d.code, d.name
ORDER BY num_documentos DESC, d.code;

-- Ver solo los departamentos SIN documentos (candidatos a eliminar)
SELECT
  d.code,
  d.name,
  'SIN DOCUMENTOS — candidato a eliminar' AS estado
FROM departments d
LEFT JOIN documents doc ON doc.department_id = d.id
GROUP BY d.id, d.code, d.name
HAVING COUNT(doc.id) = 0
ORDER BY d.code;


-- ============================================================
--  BLOQUE 2 — LIMPIEZA
--  Solo elimina departamentos con 0 documentos asociados.
--  Es seguro repetir: el WHERE COUNT protege contra errores.
-- ============================================================

DELETE FROM departments
WHERE id IN (
  SELECT d.id
  FROM departments d
  LEFT JOIN documents doc ON doc.department_id = d.id
  GROUP BY d.id
  HAVING COUNT(doc.id) = 0
);

-- Verificación post-limpieza
SELECT
  d.code,
  d.name,
  COUNT(doc.id) AS num_documentos
FROM departments d
LEFT JOIN documents doc ON doc.department_id = d.id
GROUP BY d.id, d.code, d.name
ORDER BY d.name;
