-- ============================================================
--  Diagnóstico de departamentos — qué documentos tienen contenido
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase SQL Editor
-- ============================================================

-- Vista 1: Departamentos con conteo de docs Y de docs con contenido
SELECT
  d.code,
  d.name,
  COUNT(doc.id)                                              AS total_docs,
  COUNT(dc.document_id)                                     AS docs_con_contenido,
  COUNT(doc.id) - COUNT(dc.document_id)                     AS docs_SIN_contenido
FROM departments d
LEFT JOIN documents doc   ON doc.department_id = d.id
LEFT JOIN document_content dc ON dc.document_id = doc.id
GROUP BY d.id, d.code, d.name
ORDER BY total_docs DESC, d.code;

-- Vista 2: Documentos que NO tienen document_content (los que aparecen vacíos)
SELECT
  doc.code,
  doc.name,
  d.name AS departamento
FROM documents doc
JOIN departments d ON d.id = doc.department_id
LEFT JOIN document_content dc ON dc.document_id = doc.id
WHERE dc.document_id IS NULL
ORDER BY d.code, doc.code;
