-- ============================================================
--  Asignar rol administrador a usuarios específicos
--  Hospital Santa Margarita · SGC ISO 9001:2015
-- ============================================================

UPDATE profiles
SET role_id = (SELECT id FROM roles WHERE name = 'administrador')
WHERE id IN (
  SELECT id FROM auth.users
  WHERE email IN (
    'calidadhsm.gdl@gmail.com',
    'omar.orozco@gmail.com'
  )
);

-- Verificación
SELECT
  u.email,
  p.full_name,
  r.name        AS rol,
  r.display_name AS rol_display
FROM auth.users u
JOIN profiles p ON p.id = u.id
JOIN roles    r ON r.id = p.role_id
WHERE u.email IN (
  'calidadhsm.gdl@gmail.com',
  'omar.orozco@gmail.com'
);
