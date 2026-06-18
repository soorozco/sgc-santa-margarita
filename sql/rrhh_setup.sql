-- ══════════════════════════════════════════════════════════════════
-- RRHH — Sistema de Gestión de Capital Humano
-- Hospital Santa Margarita · Módulo RRHH
--
-- ORDEN DE EJECUCIÓN:
--   1. Ejecutar este archivo completo en Supabase → SQL Editor
--   2. Insertar el primer usuario ADMIN_RH al final
--
-- Tablas:
--   rrhh_shifts   → Configuración de turnos
--   rrhh_staff    → Personal con campos RRHH
--   rrhh_requests → Solicitudes (vacaciones, pases, sindicales, convenios)
--   rrhh_survey_responses → Respuestas de encuestas y evaluaciones
-- ══════════════════════════════════════════════════════════════════

-- Extensión para hashing de contraseñas
CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- ════════════════════════════════════════════════════════════════
-- TABLA: rrhh_shifts (Turnos)
-- ════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS rrhh_shifts (
  id          TEXT PRIMARY KEY,
  name        TEXT NOT NULL,
  start_time  TEXT NOT NULL,       -- 'HH:MM'
  end_time    TEXT NOT NULL,       -- 'HH:MM'
  cycle_type  TEXT NOT NULL DEFAULT 'WEEKLY',  -- 'WEEKLY' | 'ROTATING_24_48' | 'ROTATING_12'
  rest_day    INTEGER,             -- 0=Dom 1=Lun ... 6=Sáb (para WEEKLY)
  created_at  TIMESTAMPTZ DEFAULT now(),
  updated_at  TIMESTAMPTZ DEFAULT now()
);

-- Turnos iniciales del hospital
INSERT INTO rrhh_shifts (id, name, start_time, end_time, cycle_type, rest_day) VALUES
  ('t-matutino',   'Matutino',             '07:00', '14:00', 'WEEKLY', 0),
  ('t-vespertino', 'Vespertino',           '14:00', '21:00', 'WEEKLY', 0),
  ('t-nocturno',   'Nocturno',             '21:00', '07:00', 'WEEKLY', 0),
  ('t-admin',      'Administrativo',       '08:00', '16:00', 'WEEKLY', 0),
  ('t-24-48',      'Guardia 24×48',        '07:00', '07:00', 'ROTATING_24_48', NULL),
  ('t-12-12',      'Turno 12h Rotatorio',  '07:00', '19:00', 'ROTATING_12', NULL)
ON CONFLICT (id) DO UPDATE SET
  name       = EXCLUDED.name,
  start_time = EXCLUDED.start_time,
  end_time   = EXCLUDED.end_time,
  updated_at = now();


-- ════════════════════════════════════════════════════════════════
-- TABLA: rrhh_staff (Personal)
-- ════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS rrhh_staff (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name                TEXT NOT NULL,
  email               TEXT,
  username            TEXT UNIQUE NOT NULL,
  password_hash       TEXT NOT NULL,           -- bcrypt via crypt()
  hire_date           DATE NOT NULL DEFAULT CURRENT_DATE,
  birth_date          DATE,
  area                TEXT NOT NULL,
  position            TEXT NOT NULL,
  shift_id            TEXT REFERENCES rrhh_shifts(id) DEFAULT 't-matutino',
  role                TEXT NOT NULL DEFAULT 'WORKER',  -- 'WORKER'|'MANAGER'|'ADMIN_RH'
  vacation_days       INTEGER NOT NULL DEFAULT 12,
  sindical_days       INTEGER NOT NULL DEFAULT 1,
  absences            INTEGER NOT NULL DEFAULT 0,
  delays_in_minutes   INTEGER NOT NULL DEFAULT 0,
  authorizes          TEXT[],                  -- áreas que puede autorizar (MANAGER)
  needs_password_reset BOOLEAN NOT NULL DEFAULT FALSE,
  custom_start_time   TEXT,
  custom_end_time     TEXT,
  custom_rest_day     INTEGER,
  is_active           BOOLEAN NOT NULL DEFAULT TRUE,
  created_at          TIMESTAMPTZ DEFAULT now(),
  updated_at          TIMESTAMPTZ DEFAULT now()
);

-- RLS: habilitado pero permisivo en MVP (acceso vía RPC)
ALTER TABLE rrhh_staff ENABLE ROW LEVEL SECURITY;
CREATE POLICY "anon_read_rrhh_staff" ON rrhh_staff FOR SELECT TO anon USING (FALSE);
CREATE POLICY "anon_write_rrhh_staff" ON rrhh_staff FOR ALL TO anon USING (FALSE);


-- ════════════════════════════════════════════════════════════════
-- TABLA: rrhh_requests (Solicitudes)
-- ════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS rrhh_requests (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id           UUID REFERENCES rrhh_staff(id) ON DELETE CASCADE,
  user_name         TEXT NOT NULL,
  type              TEXT NOT NULL,   -- 'VACATION'|'PASS_EXIT'|'PASS_ENTRY'|'SINDICAL'|'CONVENIO'
  start_date        DATE NOT NULL,
  end_date          DATE NOT NULL,
  start_time        TEXT,
  end_time          TEXT,
  duration_minutes  INTEGER,
  reason            TEXT,
  status            TEXT NOT NULL DEFAULT 'PENDING',
  -- 'PENDING'|'APPROVED_MANAGER'|'APPROVED_HR'|'REJECTED'
  attachment        TEXT,
  created_at        TIMESTAMPTZ DEFAULT now(),
  updated_at        TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE rrhh_requests ENABLE ROW LEVEL SECURITY;
CREATE POLICY "anon_rrhh_requests" ON rrhh_requests FOR ALL TO anon USING (FALSE);


-- ════════════════════════════════════════════════════════════════
-- TABLA: rrhh_survey_responses (Encuestas y Evaluaciones)
-- ════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS rrhh_survey_responses (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID REFERENCES rrhh_staff(id) ON DELETE CASCADE,
  survey_type   TEXT NOT NULL,   -- 'NOM035'|'PERFORMANCE'|'CLIMATE'
  answers       JSONB NOT NULL,
  submitted_at  TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE rrhh_survey_responses ENABLE ROW LEVEL SECURITY;
CREATE POLICY "anon_surveys" ON rrhh_survey_responses FOR ALL TO anon USING (FALSE);


-- ════════════════════════════════════════════════════════════════
-- RPC: rrhh_login
-- Autentica usuario por username+password. Devuelve JSONB con
-- datos del usuario o NULL si credenciales incorrectas.
-- SECURITY DEFINER → bypassa RLS para leer rrhh_staff.
-- ════════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION rrhh_login(p_username TEXT, p_password TEXT)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_staff rrhh_staff%ROWTYPE;
BEGIN
  SELECT * INTO v_staff
  FROM rrhh_staff
  WHERE username = LOWER(TRIM(p_username))
    AND password_hash = crypt(p_password, password_hash)
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


-- ════════════════════════════════════════════════════════════════
-- RPC: rrhh_create_user
-- Crea un nuevo usuario con contraseña hasheada.
-- Solo se llama desde la app como ADMIN_RH (validación en app).
-- ════════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION rrhh_create_user(
  p_caller_id   UUID,
  p_name        TEXT,
  p_username    TEXT,
  p_password    TEXT,
  p_email       TEXT,
  p_hire_date   DATE,
  p_birth_date  DATE,
  p_area        TEXT,
  p_position    TEXT,
  p_shift_id    TEXT,
  p_role        TEXT,
  p_vacation_days INTEGER,
  p_sindical_days INTEGER
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_caller rrhh_staff%ROWTYPE;
  v_new    rrhh_staff%ROWTYPE;
BEGIN
  -- Verificar que el llamador es ADMIN_RH
  SELECT * INTO v_caller FROM rrhh_staff WHERE id = p_caller_id AND is_active = TRUE;
  IF NOT FOUND OR v_caller.role != 'ADMIN_RH' THEN
    RAISE EXCEPTION 'Sin autorización';
  END IF;

  INSERT INTO rrhh_staff (
    name, username, password_hash, email,
    hire_date, birth_date, area, position, shift_id,
    role, vacation_days, sindical_days
  ) VALUES (
    p_name, LOWER(TRIM(p_username)), crypt(p_password, gen_salt('bf')), p_email,
    p_hire_date, p_birth_date, p_area, p_position, p_shift_id,
    p_role, p_vacation_days, p_sindical_days
  )
  RETURNING * INTO v_new;

  RETURN jsonb_build_object('id', v_new.id, 'name', v_new.name, 'username', v_new.username);
END;
$$;


-- ════════════════════════════════════════════════════════════════
-- RPC: rrhh_update_password
-- Cambia contraseña de un usuario (propio o Admin RH).
-- ════════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION rrhh_update_password(
  p_caller_id  UUID,
  p_target_id  UUID,
  p_new_password TEXT
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_caller rrhh_staff%ROWTYPE;
BEGIN
  SELECT * INTO v_caller FROM rrhh_staff WHERE id = p_caller_id AND is_active = TRUE;
  IF NOT FOUND THEN RETURN FALSE; END IF;

  -- Solo Admin RH puede cambiar contraseña de otro usuario
  IF p_caller_id != p_target_id AND v_caller.role != 'ADMIN_RH' THEN
    RETURN FALSE;
  END IF;

  UPDATE rrhh_staff
  SET password_hash = crypt(p_new_password, gen_salt('bf')),
      needs_password_reset = FALSE,
      updated_at = now()
  WHERE id = p_target_id;

  RETURN TRUE;
END;
$$;


-- ════════════════════════════════════════════════════════════════
-- RPC: rrhh_get_staff (Admin/Manager view)
-- Devuelve lista de personal con datos para la app.
-- ════════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION rrhh_get_staff(p_caller_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_caller rrhh_staff%ROWTYPE;
  v_result JSONB;
BEGIN
  SELECT * INTO v_caller FROM rrhh_staff WHERE id = p_caller_id AND is_active = TRUE;
  IF NOT FOUND THEN RETURN '[]'::JSONB; END IF;

  IF v_caller.role = 'ADMIN_RH' THEN
    SELECT jsonb_agg(
      jsonb_build_object(
        'id', s.id, 'name', s.name, 'email', s.email, 'username', s.username,
        'hireDate', s.hire_date, 'birthDate', s.birth_date,
        'area', s.area, 'position', s.position, 'shiftId', s.shift_id,
        'role', s.role, 'vacationDays', s.vacation_days, 'sindicalDays', s.sindical_days,
        'absences', s.absences, 'delaysInMinutes', s.delays_in_minutes,
        'authorizes', COALESCE(s.authorizes, '{}'),
        'needsPasswordReset', s.needs_password_reset,
        'customStartTime', s.custom_start_time,
        'customEndTime', s.custom_end_time,
        'customRestDay', s.custom_rest_day
      ) ORDER BY s.name
    ) INTO v_result
    FROM rrhh_staff s WHERE s.is_active = TRUE;
  ELSIF v_caller.role = 'MANAGER' THEN
    SELECT jsonb_agg(
      jsonb_build_object(
        'id', s.id, 'name', s.name, 'email', s.email, 'username', s.username,
        'hireDate', s.hire_date, 'birthDate', s.birth_date,
        'area', s.area, 'position', s.position, 'shiftId', s.shift_id,
        'role', s.role, 'vacationDays', s.vacation_days, 'sindicalDays', s.sindical_days,
        'absences', s.absences, 'delaysInMinutes', s.delays_in_minutes,
        'authorizes', COALESCE(s.authorizes, '{}'),
        'needsPasswordReset', s.needs_password_reset,
        'customStartTime', s.custom_start_time,
        'customEndTime', s.custom_end_time,
        'customRestDay', s.custom_rest_day
      ) ORDER BY s.name
    ) INTO v_result
    FROM rrhh_staff s
    WHERE s.is_active = TRUE AND s.area = v_caller.area;
  ELSE
    -- Workers solo se ven a sí mismos
    SELECT jsonb_agg(
      jsonb_build_object(
        'id', s.id, 'name', s.name, 'email', s.email, 'username', s.username,
        'hireDate', s.hire_date, 'birthDate', s.birth_date,
        'area', s.area, 'position', s.position, 'shiftId', s.shift_id,
        'role', s.role, 'vacationDays', s.vacation_days, 'sindicalDays', s.sindical_days,
        'absences', s.absences, 'delaysInMinutes', s.delays_in_minutes,
        'authorizes', '{}', 'needsPasswordReset', s.needs_password_reset,
        'customStartTime', s.custom_start_time,
        'customEndTime', s.custom_end_time,
        'customRestDay', s.custom_rest_day
      )
    ) INTO v_result
    FROM rrhh_staff s WHERE s.id = p_caller_id;
  END IF;

  RETURN COALESCE(v_result, '[]'::JSONB);
END;
$$;


-- ════════════════════════════════════════════════════════════════
-- RPC: rrhh_get_requests
-- ════════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION rrhh_get_requests(p_caller_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_caller rrhh_staff%ROWTYPE;
  v_result JSONB;
BEGIN
  SELECT * INTO v_caller FROM rrhh_staff WHERE id = p_caller_id AND is_active = TRUE;
  IF NOT FOUND THEN RETURN '[]'::JSONB; END IF;

  IF v_caller.role = 'ADMIN_RH' THEN
    SELECT jsonb_agg(r ORDER BY r.created_at DESC) INTO v_result
    FROM (SELECT id, user_id AS "userId", user_name AS "userName",
                 type, start_date AS "startDate", end_date AS "endDate",
                 start_time AS "startTime", end_time AS "endTime",
                 duration_minutes AS "durationMinutes", reason, status,
                 attachment, created_at AS "createdAt"
          FROM rrhh_requests ORDER BY created_at DESC) r;
  ELSIF v_caller.role = 'MANAGER' THEN
    SELECT jsonb_agg(r ORDER BY r."createdAt" DESC) INTO v_result
    FROM (SELECT rr.id, rr.user_id AS "userId", rr.user_name AS "userName",
                 rr.type, rr.start_date AS "startDate", rr.end_date AS "endDate",
                 rr.start_time AS "startTime", rr.end_time AS "endTime",
                 rr.duration_minutes AS "durationMinutes", rr.reason, rr.status,
                 rr.attachment, rr.created_at AS "createdAt"
          FROM rrhh_requests rr
          JOIN rrhh_staff s ON s.id = rr.user_id
          WHERE s.area = v_caller.area OR rr.user_id = v_caller.id
          ORDER BY rr.created_at DESC) r;
  ELSE
    SELECT jsonb_agg(r ORDER BY r."createdAt" DESC) INTO v_result
    FROM (SELECT id, user_id AS "userId", user_name AS "userName",
                 type, start_date AS "startDate", end_date AS "endDate",
                 start_time AS "startTime", end_time AS "endTime",
                 duration_minutes AS "durationMinutes", reason, status,
                 attachment, created_at AS "createdAt"
          FROM rrhh_requests WHERE user_id = p_caller_id
          ORDER BY created_at DESC) r;
  END IF;

  RETURN COALESCE(v_result, '[]'::JSONB);
END;
$$;


-- ════════════════════════════════════════════════════════════════
-- RPC: rrhh_update_staff
-- Actualiza campos de un empleado (solo Admin RH o el propio).
-- ════════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION rrhh_update_staff(
  p_caller_id  UUID,
  p_target_id  UUID,
  p_updates    JSONB
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_caller rrhh_staff%ROWTYPE;
BEGIN
  SELECT * INTO v_caller FROM rrhh_staff WHERE id = p_caller_id AND is_active = TRUE;
  IF NOT FOUND THEN RETURN FALSE; END IF;
  IF p_caller_id != p_target_id AND v_caller.role NOT IN ('ADMIN_RH', 'MANAGER') THEN
    RETURN FALSE;
  END IF;

  UPDATE rrhh_staff SET
    name               = COALESCE((p_updates->>'name')::TEXT,               name),
    area               = COALESCE((p_updates->>'area')::TEXT,               area),
    position           = COALESCE((p_updates->>'position')::TEXT,           position),
    shift_id           = COALESCE((p_updates->>'shiftId')::TEXT,            shift_id),
    role               = COALESCE((p_updates->>'role')::TEXT,               role),
    vacation_days      = COALESCE((p_updates->>'vacationDays')::INTEGER,    vacation_days),
    sindical_days      = COALESCE((p_updates->>'sindicalDays')::INTEGER,    sindical_days),
    absences           = COALESCE((p_updates->>'absences')::INTEGER,        absences),
    delays_in_minutes  = COALESCE((p_updates->>'delaysInMinutes')::INTEGER, delays_in_minutes),
    authorizes         = CASE WHEN p_updates ? 'authorizes'
                           THEN ARRAY(SELECT jsonb_array_elements_text(p_updates->'authorizes'))
                           ELSE authorizes END,
    needs_password_reset = COALESCE((p_updates->>'needsPasswordReset')::BOOLEAN, needs_password_reset),
    custom_start_time  = CASE WHEN p_updates ? 'customStartTime'
                           THEN (p_updates->>'customStartTime')::TEXT ELSE custom_start_time END,
    custom_end_time    = CASE WHEN p_updates ? 'customEndTime'
                           THEN (p_updates->>'customEndTime')::TEXT ELSE custom_end_time END,
    custom_rest_day    = CASE WHEN p_updates ? 'customRestDay'
                           THEN (p_updates->>'customRestDay')::INTEGER ELSE custom_rest_day END,
    updated_at         = now()
  WHERE id = p_target_id;

  RETURN TRUE;
END;
$$;


-- ════════════════════════════════════════════════════════════════
-- RPC: rrhh_delete_staff (soft delete)
-- ════════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION rrhh_delete_staff(p_caller_id UUID, p_target_id UUID)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE v_caller rrhh_staff%ROWTYPE;
BEGIN
  SELECT * INTO v_caller FROM rrhh_staff WHERE id = p_caller_id;
  IF NOT FOUND OR v_caller.role != 'ADMIN_RH' THEN RETURN FALSE; END IF;
  IF p_caller_id = p_target_id THEN RETURN FALSE; END IF;

  UPDATE rrhh_staff SET is_active = FALSE, updated_at = now() WHERE id = p_target_id;
  RETURN TRUE;
END;
$$;


-- ════════════════════════════════════════════════════════════════
-- RPC: rrhh_create_request
-- ════════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION rrhh_create_request(
  p_user_id         UUID,
  p_user_name       TEXT,
  p_type            TEXT,
  p_start_date      DATE,
  p_end_date        DATE,
  p_start_time      TEXT,
  p_end_time        TEXT,
  p_duration_minutes INTEGER,
  p_reason          TEXT,
  p_attachment      TEXT
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE v_id UUID;
BEGIN
  INSERT INTO rrhh_requests (
    user_id, user_name, type, start_date, end_date,
    start_time, end_time, duration_minutes, reason, attachment
  ) VALUES (
    p_user_id, p_user_name, p_type, p_start_date, p_end_date,
    p_start_time, p_end_time, p_duration_minutes, p_reason, p_attachment
  ) RETURNING id INTO v_id;
  RETURN v_id;
END;
$$;


-- ════════════════════════════════════════════════════════════════
-- RPC: rrhh_update_request_status
-- ════════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION rrhh_update_request_status(
  p_caller_id  UUID,
  p_request_id UUID,
  p_new_status TEXT
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_caller rrhh_staff%ROWTYPE;
BEGIN
  SELECT * INTO v_caller FROM rrhh_staff WHERE id = p_caller_id AND is_active = TRUE;
  IF NOT FOUND THEN RETURN FALSE; END IF;
  IF v_caller.role NOT IN ('MANAGER', 'ADMIN_RH') THEN RETURN FALSE; END IF;

  UPDATE rrhh_requests SET status = p_new_status, updated_at = now()
  WHERE id = p_request_id;
  RETURN TRUE;
END;
$$;


-- ════════════════════════════════════════════════════════════════
-- RPC: rrhh_submit_survey
-- ════════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION rrhh_submit_survey(
  p_user_id    UUID,
  p_type       TEXT,
  p_answers    JSONB
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE v_id UUID;
BEGIN
  INSERT INTO rrhh_survey_responses (user_id, survey_type, answers)
  VALUES (p_user_id, p_type, p_answers)
  RETURNING id INTO v_id;
  RETURN v_id;
END;
$$;


-- ════════════════════════════════════════════════════════════════
-- USUARIO INICIAL: Admin RH
-- Cambia nombre, username y contraseña antes de ejecutar.
-- ════════════════════════════════════════════════════════════════
INSERT INTO rrhh_staff (
  name, username, password_hash, email,
  hire_date, birth_date, area, position, shift_id, role,
  vacation_days, sindical_days
) VALUES (
  'Administrador RRHH',
  'admin',
  crypt('Admin2025!', gen_salt('bf')),
  'rrhh@hsm.mx',
  CURRENT_DATE,
  '1990-01-01',
  'Capital Humano',
  'Jefe de Capital Humano',
  't-admin',
  'ADMIN_RH',
  12,
  1
) ON CONFLICT (username) DO NOTHING;


-- ── Verificación ─────────────────────────────────────────────────
SELECT 'Turnos' AS tabla, COUNT(*) FROM rrhh_shifts
UNION ALL SELECT 'Staff', COUNT(*) FROM rrhh_staff
UNION ALL SELECT 'Requests', COUNT(*) FROM rrhh_requests;
