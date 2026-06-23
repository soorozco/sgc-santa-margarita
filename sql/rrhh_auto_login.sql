-- ============================================================
--  RRHH Auto-Login por sesión Supabase
--  Ejecutar en Supabase → SQL Editor
--
--  Permite que un usuario ya autenticado en el SGC (Supabase Auth)
--  entre al módulo RRHH sin segunda contraseña, siempre que su email
--  coincida con un registro activo en rrhh_staff.
-- ============================================================

CREATE OR REPLACE FUNCTION rrhh_login_by_email()
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_email TEXT;
  v_staff rrhh_staff%ROWTYPE;
BEGIN
  -- Obtener email del usuario autenticado via Supabase Auth
  v_email := auth.email();

  IF v_email IS NULL THEN
    RETURN NULL;
  END IF;

  SELECT * INTO v_staff
  FROM rrhh_staff
  WHERE LOWER(TRIM(email)) = LOWER(TRIM(v_email))
    AND is_active = TRUE;

  IF NOT FOUND THEN
    RETURN NULL;
  END IF;

  RETURN jsonb_build_object(
    'id',                   v_staff.id,
    'name',                 v_staff.name,
    'email',                v_staff.email,
    'username',             v_staff.username,
    'hireDate',             v_staff.hire_date,
    'birthDate',            v_staff.birth_date,
    'area',                 v_staff.area,
    'position',             v_staff.position,
    'shiftId',              v_staff.shift_id,
    'role',                 v_staff.role,
    'vacationDays',         v_staff.vacation_days,
    'sindicalDays',         v_staff.sindical_days,
    'absences',             v_staff.absences,
    'delaysInMinutes',      v_staff.delays_in_minutes,
    'authorizes',           COALESCE(v_staff.authorizes, '{}'),
    'needsPasswordReset',   v_staff.needs_password_reset,
    'customStartTime',      v_staff.custom_start_time,
    'customEndTime',        v_staff.custom_end_time,
    'customRestDay',        v_staff.custom_rest_day
  );
END;
$$;
