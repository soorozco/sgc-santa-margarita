import { supabase } from './supabase'
import { User, RequestRecord, RequestType, RequestStatus, UserRole, ShiftSettings } from '../types'
import { DEFAULT_SHIFTS } from '../constants'

// ── Sesión local ──────────────────────────────────────────────────
const SESSION_KEY = 'rrhh_session'

export function saveSession(user: User) {
  localStorage.setItem(SESSION_KEY, JSON.stringify(user))
}

export function loadSession(): User | null {
  try {
    const raw = localStorage.getItem(SESSION_KEY)
    return raw ? JSON.parse(raw) : null
  } catch { return null }
}

export function clearSession() {
  localStorage.removeItem(SESSION_KEY)
}

// ── Mappers ───────────────────────────────────────────────────────
function mapUser(d: Record<string, unknown>): User {
  return {
    id:                  String(d.id),
    name:                String(d.name || ''),
    email:               d.email ? String(d.email) : undefined,
    username:            d.username ? String(d.username) : undefined,
    hireDate:            String(d.hireDate || d.hire_date || ''),
    birthDate:           String(d.birthDate || d.birth_date || ''),
    area:                String(d.area || ''),
    position:            String(d.position || ''),
    shiftId:             String(d.shiftId || d.shift_id || 't-matutino'),
    role:                (d.role as UserRole) || UserRole.WORKER,
    vacationDays:        Number(d.vacationDays ?? d.vacation_days ?? 12),
    sindicalDays:        Number(d.sindicalDays ?? d.sindical_days ?? 1),
    absences:            Number(d.absences ?? 0),
    delaysInMinutes:     Number(d.delaysInMinutes ?? d.delays_in_minutes ?? 0),
    authorizes:          Array.isArray(d.authorizes) ? d.authorizes as string[] : [],
    needsPasswordReset:  Boolean(d.needsPasswordReset ?? d.needs_password_reset ?? false),
    customStartTime:     d.customStartTime ? String(d.customStartTime) : undefined,
    customEndTime:       d.customEndTime   ? String(d.customEndTime)   : undefined,
    customRestDay:       d.customRestDay != null ? Number(d.customRestDay) : undefined,
  }
}

function mapRequest(d: Record<string, unknown>): RequestRecord {
  return {
    id:              String(d.id),
    userId:          String(d.userId   || d.user_id   || ''),
    userName:        String(d.userName || d.user_name || ''),
    type:            (d.type as RequestType),
    startDate:       String(d.startDate || d.start_date || ''),
    endDate:         String(d.endDate   || d.end_date   || ''),
    startTime:       d.startTime ? String(d.startTime) : undefined,
    endTime:         d.endTime   ? String(d.endTime)   : undefined,
    durationMinutes: d.durationMinutes != null ? Number(d.durationMinutes) : undefined,
    reason:          String(d.reason || ''),
    status:          (d.status as RequestStatus) || RequestStatus.PENDING,
    createdAt:       String(d.createdAt || d.created_at || new Date().toISOString()),
    attachment:      d.attachment ? String(d.attachment) : undefined,
  }
}

// ── Auth ──────────────────────────────────────────────────────────
export async function apiLogin(username: string, password: string): Promise<User | null> {
  const { data, error } = await supabase.rpc('rrhh_login', {
    p_username: username,
    p_password: password,
  })
  if (error || !data) return null
  return mapUser(data as Record<string, unknown>)
}

export async function apiUpdatePassword(
  callerId: string,
  targetId: string,
  newPassword: string,
): Promise<boolean> {
  const { data } = await supabase.rpc('rrhh_update_password', {
    p_caller_id:   callerId,
    p_target_id:   targetId,
    p_new_password: newPassword,
  })
  return Boolean(data)
}

// ── Staff ─────────────────────────────────────────────────────────
export async function apiGetStaff(callerId: string): Promise<User[]> {
  const { data, error } = await supabase.rpc('rrhh_get_staff', { p_caller_id: callerId })
  if (error || !data) return []
  return (data as Record<string, unknown>[]).map(mapUser)
}

export async function apiCreateUser(
  callerId: string,
  payload: {
    name: string; username: string; password: string; email: string
    hireDate: string; birthDate: string; area: string; position: string
    shiftId: string; role: string; vacationDays: number; sindicalDays: number
  },
): Promise<{ id: string; name: string } | null> {
  const { data, error } = await supabase.rpc('rrhh_create_user', {
    p_caller_id:    callerId,
    p_name:         payload.name,
    p_username:     payload.username,
    p_password:     payload.password,
    p_email:        payload.email,
    p_hire_date:    payload.hireDate,
    p_birth_date:   payload.birthDate,
    p_area:         payload.area,
    p_position:     payload.position,
    p_shift_id:     payload.shiftId,
    p_role:         payload.role,
    p_vacation_days: payload.vacationDays,
    p_sindical_days: payload.sindicalDays,
  })
  if (error || !data) { console.error('apiCreateUser', error); return null }
  return data as { id: string; name: string }
}

export async function apiUpdateStaff(
  callerId: string,
  targetId: string,
  updates: Partial<User>,
): Promise<boolean> {
  const payload: Record<string, unknown> = {}
  if (updates.name             != null) payload.name              = updates.name
  if (updates.area             != null) payload.area              = updates.area
  if (updates.position         != null) payload.position          = updates.position
  if (updates.shiftId          != null) payload.shiftId           = updates.shiftId
  if (updates.role             != null) payload.role              = updates.role
  if (updates.vacationDays     != null) payload.vacationDays      = updates.vacationDays
  if (updates.sindicalDays     != null) payload.sindicalDays      = updates.sindicalDays
  if (updates.absences         != null) payload.absences          = updates.absences
  if (updates.delaysInMinutes  != null) payload.delaysInMinutes   = updates.delaysInMinutes
  if (updates.authorizes       != null) payload.authorizes        = updates.authorizes
  if (updates.needsPasswordReset != null) payload.needsPasswordReset = updates.needsPasswordReset
  if ('customStartTime' in updates)    payload.customStartTime    = updates.customStartTime ?? null
  if ('customEndTime'   in updates)    payload.customEndTime      = updates.customEndTime   ?? null
  if ('customRestDay'   in updates)    payload.customRestDay      = updates.customRestDay   ?? null

  const { data } = await supabase.rpc('rrhh_update_staff', {
    p_caller_id: callerId,
    p_target_id: targetId,
    p_updates:   payload,
  })
  return Boolean(data)
}

export async function apiDeleteStaff(callerId: string, targetId: string): Promise<boolean> {
  const { data } = await supabase.rpc('rrhh_delete_staff', {
    p_caller_id: callerId,
    p_target_id: targetId,
  })
  return Boolean(data)
}

// ── Requests ─────────────────────────────────────────────────────
export async function apiGetRequests(callerId: string): Promise<RequestRecord[]> {
  const { data, error } = await supabase.rpc('rrhh_get_requests', { p_caller_id: callerId })
  if (error || !data) return []
  return (data as Record<string, unknown>[]).map(mapRequest)
}

export async function apiCreateRequest(
  userId: string,
  userName: string,
  req: {
    type: RequestType; startDate: string; endDate: string
    startTime?: string; endTime?: string; durationMinutes?: number
    reason: string; attachment?: string
  },
): Promise<string | null> {
  const { data, error } = await supabase.rpc('rrhh_create_request', {
    p_user_id:          userId,
    p_user_name:        userName,
    p_type:             req.type,
    p_start_date:       req.startDate,
    p_end_date:         req.endDate,
    p_start_time:       req.startTime   || null,
    p_end_time:         req.endTime     || null,
    p_duration_minutes: req.durationMinutes || null,
    p_reason:           req.reason,
    p_attachment:       req.attachment  || null,
  })
  if (error) { console.error('apiCreateRequest', error); return null }
  return String(data)
}

export async function apiUpdateRequestStatus(
  callerId: string,
  requestId: string,
  newStatus: RequestStatus,
): Promise<boolean> {
  const { data } = await supabase.rpc('rrhh_update_request_status', {
    p_caller_id:  callerId,
    p_request_id: requestId,
    p_new_status: newStatus,
  })
  return Boolean(data)
}

// ── Surveys ───────────────────────────────────────────────────────
export async function apiSubmitSurvey(
  userId: string,
  type: 'NOM035' | 'PERFORMANCE' | 'CLIMATE',
  answers: Record<string | number, unknown>,
): Promise<boolean> {
  const { error } = await supabase.rpc('rrhh_submit_survey', {
    p_user_id: userId,
    p_type:    type,
    p_answers: answers,
  })
  return !error
}

// ── Shifts (solo lectura local, no hace falta DB para MVP) ────────
export function apiGetShifts(): ShiftSettings[] {
  return DEFAULT_SHIFTS
}
