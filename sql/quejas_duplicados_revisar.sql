-- ══════════════════════════════════════════════════════════════════
-- REVISAR duplicados de Quejas (SOLO LECTURA — no borra nada)
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Muestra los grupos de quejas que parecen la MISMA solicitud capturada
-- más de una vez (misma fecha + mismo teléfono, o misma fecha + misma
-- descripción). Sirve para ver cuáles son WEB/QJ (del formulario o manual)
-- y cuál es la CA (la buena) antes de decidir qué borrar.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

WITH claves AS (
  SELECT
    id, folio, origen, fecha, telefono, status, nombre_paciente,
    fecha::text || '|' || regexp_replace(coalesce(telefono,''), '\D', '', 'g')                       AS k_tel,
    fecha::text || '|' || left(regexp_replace(lower(coalesce(descripcion,'')), '[^a-z0-9]', '', 'g'), 40) AS k_desc
  FROM public.quejas
),
grupos AS (
  SELECT k_tel  AS grupo FROM claves WHERE k_tel  NOT LIKE '%|' GROUP BY k_tel  HAVING count(*) > 1
  UNION
  SELECT k_desc AS grupo FROM claves WHERE k_desc NOT LIKE '%|' GROUP BY k_desc HAVING count(*) > 1
)
SELECT
  c.fecha,
  c.telefono,
  c.nombre_paciente,
  c.folio,
  c.origen,
  c.status,
  CASE WHEN c.folio LIKE 'CA%' THEN '⭐ conservar (CA)' ELSE 'posible duplicado' END AS nota
FROM claves c
WHERE c.k_tel  IN (SELECT grupo FROM grupos)
   OR c.k_desc IN (SELECT grupo FROM grupos)
ORDER BY c.fecha, c.telefono, (c.folio LIKE 'CA%') DESC, c.folio;
