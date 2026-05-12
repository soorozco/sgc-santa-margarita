-- ============================================================
--  FIX: Eliminar departamento duplicado 'RH' (Recursos Humanos)
--  Mantener 'CH' (Capital Humano) como código oficial
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- 1. Reasignar documentos que apunten a 'RH' → 'CH'
UPDATE documents
SET department_id = (SELECT id FROM departments WHERE code = 'CH')
WHERE department_id = (SELECT id FROM departments WHERE code = 'RH');

-- 2. Reasignar cualquier otra FK que referencie a 'RH' (si existen)
--    Descomenta si tu schema tiene otras tablas con department_id:
-- UPDATE otra_tabla
-- SET department_id = (SELECT id FROM departments WHERE code = 'CH')
-- WHERE department_id = (SELECT id FROM departments WHERE code = 'RH');

-- 3. Eliminar el departamento 'RH' duplicado
DELETE FROM departments WHERE code = 'RH';

-- ── Verificación ──────────────────────────────────────────────
SELECT code, name FROM departments ORDER BY code;
