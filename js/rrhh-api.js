// ─── RRHH Session (localStorage independiente del SGC) ───────────
const RRHH_KEY = 'rrhh_session'

function rrhhSaveSession(u) { localStorage.setItem(RRHH_KEY, JSON.stringify(u)) }
function rrhhLoadSession() {
  try { const r = localStorage.getItem(RRHH_KEY); return r ? JSON.parse(r) : null }
  catch { return null }
}
function rrhhClearSession() { localStorage.removeItem(RRHH_KEY) }

// ─── Helpers ─────────────────────────────────────────────────────
function mapRrhhUser(d) {
  return {
    id:               String(d.id),
    name:             String(d.name || ''),
    email:            d.email     || null,
    username:         d.username  || null,
    hireDate:         d.hire_date || d.hireDate || '',
    area:             d.area      || '',
    position:         d.position  || '',
    shiftId:          d.shift_id  || d.shiftId || 't-matutino',
    role:             d.role      || 'WORKER',
    vacationDays:     Number(d.vacation_days  ?? d.vacationDays  ?? 12),
    sindicalDays:     Number(d.sindical_days  ?? d.sindicalDays  ?? 1),
    needsPasswordReset: Boolean(d.needs_password_reset ?? d.needsPasswordReset ?? false),
  }
}

function mapRrhhRequest(d) {
  return {
    id:              String(d.id),
    userId:          String(d.user_id   || d.userId   || ''),
    userName:        String(d.user_name || d.userName || ''),
    type:            d.type,
    startDate:       d.start_date || d.startDate || '',
    endDate:         d.end_date   || d.endDate   || '',
    startTime:       d.start_time || d.startTime || null,
    endTime:         d.end_time   || d.endTime   || null,
    durationMinutes: d.duration_minutes != null ? Number(d.duration_minutes) : null,
    reason:          d.reason || '',
    status:          d.status || 'PENDING',
    createdAt:       d.created_at || d.createdAt || '',
  }
}

// ─── Auth ─────────────────────────────────────────────────────────
async function rrhhLogin(username, password) {
  const { data, error } = await db.rpc('rrhh_login', {
    p_username: username,
    p_password: password,
  })
  if (error || !data) throw new Error('Credenciales incorrectas')
  const user = mapRrhhUser(data)
  rrhhSaveSession(user)
  return user
}

async function rrhhAutoLogin() {
  const { data, error } = await db.rpc('rrhh_login_by_email')
  if (error || !data) return null
  const user = mapRrhhUser(data)
  rrhhSaveSession(user)
  return user
}

async function rrhhUpdatePassword(callerId, targetId, newPassword) {
  const { error } = await db.rpc('rrhh_update_password', {
    p_caller_id:    callerId,
    p_target_id:    targetId,
    p_new_password: newPassword,
  })
  return !error
}

// ─── Staff ────────────────────────────────────────────────────────
async function rrhhGetStaff(callerId) {
  const { data, error } = await db.rpc('rrhh_get_staff', { p_caller_id: callerId })
  if (error || !data) return []
  return data.map(mapRrhhUser)
}

async function rrhhCreateUser(callerId, p) {
  const { data, error } = await db.rpc('rrhh_create_user', {
    p_caller_id:      callerId,
    p_name:           p.name,
    p_username:       p.username,
    p_password:       p.password,
    p_email:          p.email        || '',
    p_hire_date:      p.hireDate     || '',
    p_birth_date:     p.birthDate    || '',
    p_area:           p.area,
    p_position:       p.position,
    p_shift_id:       p.shiftId      || 't-matutino',
    p_role:           p.role         || 'WORKER',
    p_vacation_days:  p.vacationDays ?? 12,
    p_sindical_days:  p.sindicalDays ?? 1,
  })
  if (error) { console.error('rrhhCreateUser', error); return null }
  return data
}

async function rrhhUpdateStaff(callerId, targetId, updates) {
  const { error } = await db.rpc('rrhh_update_staff', {
    p_caller_id: callerId,
    p_target_id: targetId,
    p_updates:   updates,
  })
  return !error
}

async function rrhhDeleteStaff(callerId, targetId) {
  const { error } = await db.rpc('rrhh_delete_staff', {
    p_caller_id: callerId,
    p_target_id: targetId,
  })
  return !error
}

// ─── Requests ─────────────────────────────────────────────────────
async function rrhhGetRequests(callerId) {
  const { data, error } = await db.rpc('rrhh_get_requests', { p_caller_id: callerId })
  if (error || !data) return []
  return data.map(mapRrhhRequest)
}

async function rrhhCreateRequest(userId, userName, req) {
  const { data, error } = await db.rpc('rrhh_create_request', {
    p_user_id:          userId,
    p_user_name:        userName,
    p_type:             req.type,
    p_start_date:       req.startDate,
    p_end_date:         req.endDate,
    p_start_time:       req.startTime       || null,
    p_end_time:         req.endTime         || null,
    p_duration_minutes: req.durationMinutes || null,
    p_reason:           req.reason,
    p_attachment:       req.attachment      || null,
  })
  if (error) { console.error('rrhhCreateRequest', error); return null }
  return String(data)
}

async function rrhhUpdateStatus(callerId, requestId, newStatus) {
  const { error } = await db.rpc('rrhh_update_request_status', {
    p_caller_id:  callerId,
    p_request_id: requestId,
    p_new_status: newStatus,
  })
  return !error
}

// ─── Surveys ──────────────────────────────────────────────────────
async function rrhhSubmitSurvey(userId, type, answers) {
  const { error } = await db.rpc('rrhh_submit_survey', {
    p_user_id: userId,
    p_type:    type,
    p_answers: answers,
  })
  return !error
}

// ─── Shifts (local) ───────────────────────────────────────────────
const RRHH_SHIFTS = [
  { id: 't-matutino',   name: 'Matutino',         startTime: '07:00', endTime: '14:00' },
  { id: 't-vespertino', name: 'Vespertino',        startTime: '14:00', endTime: '21:00' },
  { id: 't-nocturno',   name: 'Nocturno',          startTime: '21:00', endTime: '07:00' },
  { id: 't-admin',      name: 'Administrativo',    startTime: '08:00', endTime: '16:00' },
  { id: 't-24-48',      name: 'Guardia 24×48',     startTime: '07:00', endTime: '07:00' },
  { id: 't-12-12',      name: '12h Rotatorio',     startTime: '07:00', endTime: '19:00' },
]

const STATUS_LABELS = {
  PENDING:          { label: 'Pendiente',           cls: 'status-pending'   },
  APPROVED_MANAGER: { label: 'Aprobada encargado',  cls: 'status-approved1' },
  APPROVED_HR:      { label: 'Aprobada RH',         cls: 'status-approved'  },
  REJECTED:         { label: 'Rechazada',           cls: 'status-rejected'  },
}

const TYPE_LABELS = {
  VACATION:   'Vacaciones',
  PASS_EXIT:  'Pase de Salida',
  PASS_ENTRY: 'Pase de Entrada',
  SINDICAL:   'Día Sindical',
  CONVENIO:   'Convenio',
}

function fmtDate(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('es-MX', { day: '2-digit', month: 'short', year: 'numeric' })
}
function fmtDiff(a, b) {
  return Math.round((new Date(b) - new Date(a)) / 86400000) + 1
}
