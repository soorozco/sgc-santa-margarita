import { useState, useEffect, useCallback } from 'react'
import {
  LogOut, RefreshCw, Plus, Check, X, ChevronDown, ChevronUp,
  Download, Search, Trash2, Edit3, Eye, EyeOff, Calendar,
  ClipboardList, Users, Clock, TrendingUp, AlertCircle, Shield,
  FileText, BarChart2, Star, Wind, UserCheck
} from 'lucide-react'
import * as XLSX from 'xlsx'

import { User, UserRole, RequestStatus, RequestType, RequestRecord } from './types'
import { getStatusConfig, DEFAULT_SHIFTS } from './constants'
import {
  apiLogin, apiGetStaff, apiGetRequests, apiCreateRequest,
  apiUpdateRequestStatus, apiCreateUser, apiUpdateStaff,
  apiDeleteStaff, apiSubmitSurvey, apiUpdatePassword,
  loadSession, clearSession
} from './lib/api'

import { Navigation }          from './components/Navigation'
import { StatsCard }           from './components/StatsCard'
import { RequestForm }         from './components/RequestForm'
import { AddEmployeeModal }    from './components/AddEmployeeModal'
import { ConfirmationModal }   from './components/ConfirmationModal'
import { Nom035Survey }        from './components/Nom035Survey'
import { PerformanceEvaluation } from './components/PerformanceEvaluation'
import { WorkClimateSurvey }   from './components/WorkClimateSurvey'

// ─── helpers ─────────────────────────────────────────────────────────────────

function formatDate(d: string) {
  return new Date(d).toLocaleDateString('es-MX', { day: '2-digit', month: 'short', year: 'numeric' })
}
function diffDays(a: string, b: string) {
  return Math.round((new Date(b).getTime() - new Date(a).getTime()) / 86400000) + 1
}

// ─── App ─────────────────────────────────────────────────────────────────────

export default function App() {
  // Auth state
  const [user,        setUser]        = useState<User | null>(null)
  const [loginUser,   setLoginUser]   = useState('')
  const [loginPass,   setLoginPass]   = useState('')
  const [loginErr,    setLoginErr]    = useState('')
  const [loginLoading, setLoginLoading] = useState(false)
  const [showPass,    setShowPass]    = useState(false)
  const [firstLogin,  setFirstLogin]  = useState(false)
  const [newPass,     setNewPass]     = useState('')
  const [newPass2,    setNewPass2]    = useState('')

  // Data
  const [staff,       setStaff]       = useState<User[]>([])
  const [requests,    setRequests]    = useState<RequestRecord[]>([])
  const [loading,     setLoading]     = useState(false)

  // UI
  const [tab,         setTab]         = useState('inicio')
  const [search,      setSearch]      = useState('')
  const [filterArea,  setFilterArea]  = useState('')

  // Modals / sub-views
  const [showRequestForm,  setShowRequestForm]  = useState(false)
  const [reqFormType,      setReqFormType]      = useState<RequestType>(RequestType.VACATION)
  const [showAddEmployee,  setShowAddEmployee]  = useState(false)
  const [newEmployee,      setNewEmployee]      = useState<Partial<User> & { password?: string }>({})
  const [confirmDelete,    setConfirmDelete]    = useState<User | null>(null)
  const [editingUser,      setEditingUser]      = useState<User | null>(null)
  const [expandedReqId,    setExpandedReqId]    = useState<string | null>(null)
  const [subView,          setSubView]          = useState<
    null | { type: 'nom035' } | { type: 'performance'; target: User } | { type: 'climate' }
  >(null)

  // ─── Session restore ───────────────────────────────────────────────────────
  useEffect(() => {
    const session = loadSession()
    if (session) {
      setUser(session)
      if (session.passwordChangeRequired) setFirstLogin(true)
    }
  }, [])

  // ─── Data fetch ────────────────────────────────────────────────────────────
  const fetchData = useCallback(async (u: User) => {
    setLoading(true)
    try {
      const [staffData, reqData] = await Promise.all([
        u.role !== UserRole.WORKER ? apiGetStaff(u) : Promise.resolve([]),
        apiGetRequests(u),
      ])
      setStaff(staffData)
      setRequests(reqData)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => { if (user) fetchData(user) }, [user, fetchData])

  // ─── Login ─────────────────────────────────────────────────────────────────
  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoginErr('')
    setLoginLoading(true)
    try {
      const u = await apiLogin(loginUser.trim(), loginPass)
      setUser(u)
      if (u.passwordChangeRequired) setFirstLogin(true)
    } catch (err: unknown) {
      setLoginErr(err instanceof Error ? err.message : 'Credenciales incorrectas')
    } finally {
      setLoginLoading(false)
    }
  }

  const handleChangePassword = async (e: React.FormEvent) => {
    e.preventDefault()
    if (newPass.length < 6) { alert('La contraseña debe tener al menos 6 caracteres.'); return }
    if (newPass !== newPass2) { alert('Las contraseñas no coinciden.'); return }
    if (!user) return
    await apiUpdatePassword(user.id, newPass)
    setFirstLogin(false)
    setNewPass('')
    setNewPass2('')
  }

  const handleLogout = () => {
    clearSession()
    setUser(null)
    setStaff([])
    setRequests([])
    setTab('inicio')
  }

  // ─── Request actions ───────────────────────────────────────────────────────
  const handleCreateRequest = async (data: {
    type: RequestType; startDate: string; endDate: string
    startTime?: string; endTime?: string; durationMinutes?: number; reason: string
  }) => {
    if (!user) return
    await apiCreateRequest(user, data)
    setShowRequestForm(false)
    await fetchData(user)
  }

  const handleUpdateStatus = async (reqId: string, status: RequestStatus, comment = '') => {
    if (!user) return
    await apiUpdateRequestStatus(user, reqId, status, comment)
    await fetchData(user)
  }

  // ─── Staff actions ─────────────────────────────────────────────────────────
  const handleAddEmployee = async () => {
    if (!user) return
    const { password, ...rest } = newEmployee
    if (!rest.name || !rest.username || !password || !rest.area || !rest.position) {
      alert('Por favor completa nombre, usuario, contraseña, área y puesto.')
      return
    }
    await apiCreateUser(user, { ...rest, password } as User & { password: string })
    setShowAddEmployee(false)
    setNewEmployee({})
    await fetchData(user)
  }

  const handleDeleteEmployee = async () => {
    if (!user || !confirmDelete) return
    await apiDeleteStaff(user, confirmDelete.id)
    setConfirmDelete(null)
    await fetchData(user)
  }

  const handleUpdateEmployee = async () => {
    if (!user || !editingUser) return
    await apiUpdateStaff(user, editingUser)
    setEditingUser(null)
    await fetchData(user)
  }

  const handleSubmitSurvey = async (type: string, answers: Record<string, unknown>) => {
    if (!user) return
    await apiSubmitSurvey(user, type, answers)
    setSubView(null)
    alert('¡Evaluación enviada correctamente!')
  }

  // ─── Export ────────────────────────────────────────────────────────────────
  const exportToExcel = () => {
    const rows = requests.map(r => ({
      'Empleado':     r.employeeName || r.employeeId,
      'Tipo':         r.type,
      'Inicio':       r.startDate,
      'Fin':          r.endDate,
      'Días/Min':     r.type === RequestType.PASS_EXIT || r.type === RequestType.PASS_ENTRY
                        ? `${r.durationMinutes || 0} min`
                        : `${diffDays(r.startDate, r.endDate)} días`,
      'Estado':       r.status,
      'Motivo':       r.reason,
      'Creado':       r.createdAt,
    }))
    const ws = XLSX.utils.json_to_sheet(rows)
    const wb = XLSX.utils.book_new()
    XLSX.utils.book_append_sheet(wb, ws, 'Solicitudes')
    XLSX.writeFile(wb, `solicitudes_${new Date().toISOString().split('T')[0]}.xlsx`)
  }

  // ─── Derived data ──────────────────────────────────────────────────────────
  const myRequests = user ? requests.filter(r => r.employeeId === user.id) : []
  const pendingForMe = user?.role === UserRole.MANAGER
    ? requests.filter(r => r.status === RequestStatus.PENDING)
    : user?.role === UserRole.ADMIN_RH
      ? requests.filter(r => r.status === RequestStatus.APPROVED_MANAGER)
      : []

  const usedVacation = myRequests
    .filter(r => r.type === RequestType.VACATION && r.status === RequestStatus.APPROVED_HR)
    .reduce((a, r) => a + diffDays(r.startDate, r.endDate), 0)

  const usedPassMin = myRequests
    .filter(r =>
      (r.type === RequestType.PASS_EXIT || r.type === RequestType.PASS_ENTRY) &&
      r.status !== RequestStatus.REJECTED &&
      new Date(r.startDate).getMonth() === new Date().getMonth()
    )
    .reduce((a, r) => a + (r.durationMinutes || 0), 0)

  const filteredStaff = staff.filter(s => {
    const q = search.toLowerCase()
    const matchQ = !q || s.name.toLowerCase().includes(q) || s.username.toLowerCase().includes(q)
    const matchA = !filterArea || s.area === filterArea
    return matchQ && matchA
  })

  const areas = [...new Set(staff.map(s => s.area).filter(Boolean))]

  // ─── Sub-views ─────────────────────────────────────────────────────────────
  if (subView?.type === 'nom035')
    return <Nom035Survey onBack={() => setSubView(null)}
      onSubmit={ans => handleSubmitSurvey('nom035', ans as Record<string, unknown>)} />

  if (subView?.type === 'performance' && user)
    return <PerformanceEvaluation user={subView.target} onBack={() => setSubView(null)}
      onSubmit={ans => handleSubmitSurvey('performance', ans)} />

  if (subView?.type === 'climate' && user)
    return <WorkClimateSurvey user={user} onBack={() => setSubView(null)}
      onSubmit={ans => handleSubmitSurvey('climate', ans)} />

  // ─── Login screen ──────────────────────────────────────────────────────────
  if (!user) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-900 via-blue-800 to-blue-700 flex items-center justify-center p-6">
        <div className="bg-white rounded-3xl w-full max-w-sm shadow-2xl overflow-hidden">
          <div className="bg-blue-700 p-8 text-center">
            <div className="w-16 h-16 bg-white/20 rounded-3xl flex items-center justify-center mx-auto mb-3">
              <Shield className="text-white" size={32} />
            </div>
            <h1 className="text-white font-black text-xl">Sistema RRHH</h1>
            <p className="text-blue-200 text-xs mt-1">Hospital Santa Margarita</p>
          </div>
          <form onSubmit={handleLogin} className="p-6 space-y-4">
            <div>
              <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">
                No. Trabajador / Usuario
              </label>
              <input
                type="text" value={loginUser} onChange={e => setLoginUser(e.target.value)}
                placeholder="ej. 10567 o jperez"
                className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">
                Contraseña
              </label>
              <div className="relative">
                <input
                  type={showPass ? 'text' : 'password'} value={loginPass}
                  onChange={e => setLoginPass(e.target.value)} placeholder="••••••••"
                  className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 pr-10 text-sm font-bold outline-none focus:ring-2 focus:ring-blue-500"
                />
                <button type="button" onClick={() => setShowPass(p => !p)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400">
                  {showPass ? <EyeOff size={16} /> : <Eye size={16} />}
                </button>
              </div>
            </div>
            {loginErr && (
              <div className="bg-red-50 border border-red-200 rounded-xl p-3 flex items-center gap-2">
                <AlertCircle size={14} className="text-red-500 shrink-0" />
                <p className="text-xs text-red-600 font-bold">{loginErr}</p>
              </div>
            )}
            <button type="submit" disabled={loginLoading}
              className="w-full bg-blue-700 text-white py-4 rounded-2xl font-bold text-sm shadow-lg shadow-blue-200 disabled:opacity-50">
              {loginLoading ? 'Verificando...' : 'Ingresar'}
            </button>
          </form>
        </div>
      </div>
    )
  }

  // ─── First login: change password ─────────────────────────────────────────
  if (firstLogin) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-900 via-blue-800 to-blue-700 flex items-center justify-center p-6">
        <div className="bg-white rounded-3xl w-full max-w-sm shadow-2xl p-6">
          <h2 className="font-black text-gray-900 text-lg mb-1">Cambia tu contraseña</h2>
          <p className="text-xs text-gray-500 mb-5">Por seguridad debes establecer una contraseña personal antes de continuar.</p>
          <form onSubmit={handleChangePassword} className="space-y-4">
            {[
              { label: 'Nueva contraseña', v: newPass,  sv: setNewPass  },
              { label: 'Confirmar',         v: newPass2, sv: setNewPass2 },
            ].map(f => (
              <div key={f.label}>
                <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">{f.label}</label>
                <input type="password" value={f.v} onChange={e => f.sv(e.target.value)}
                  className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none" />
              </div>
            ))}
            <button type="submit" className="w-full bg-blue-700 text-white py-4 rounded-2xl font-bold text-sm">
              Guardar contraseña
            </button>
          </form>
        </div>
      </div>
    )
  }

  // ─── Role badge ───────────────────────────────────────────────────────────
  const roleBadge = {
    [UserRole.WORKER]:   { label: 'Empleado',   cls: 'bg-gray-100 text-gray-600' },
    [UserRole.MANAGER]:  { label: 'Encargado',  cls: 'bg-blue-100 text-blue-700' },
    [UserRole.ADMIN_RH]: { label: 'Admin RH',   cls: 'bg-purple-100 text-purple-700' },
  }[user.role]

  // ─── INICIO ───────────────────────────────────────────────────────────────
  const renderInicio = () => (
    <div className="p-6 space-y-5 pb-28">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="font-black text-gray-900 text-xl leading-tight">
            Hola, {user.name.split(' ')[0]}
          </h1>
          <span className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${roleBadge.cls}`}>
            {roleBadge.label}
          </span>
        </div>
        <button onClick={() => fetchData(user)} className="p-2.5 bg-gray-100 rounded-2xl text-gray-500">
          <RefreshCw size={18} className={loading ? 'animate-spin' : ''} />
        </button>
      </div>

      {/* Worker: stats */}
      {user.role === UserRole.WORKER && (
        <>
          <div className="grid grid-cols-2 gap-3">
            <StatsCard label="Vacaciones usadas" value={`${usedVacation}/${user.vacationDays || 12}d`}
              icon={Calendar}  color="bg-blue-600" />
            <StatsCard label="Pases este mes"    value={`${usedPassMin}/120min`}
              icon={Clock}     color="bg-amber-500" />
            <StatsCard label="Días sindicato"    value={`${myRequests.filter(r => r.type === RequestType.SINDICAL && r.status === RequestStatus.APPROVED_HR).length}/${user.sindicalDays || 1}`}
              icon={UserCheck} color="bg-emerald-600" />
            <StatsCard label="Mis solicitudes"   value={myRequests.length}
              icon={ClipboardList} color="bg-gray-600" />
          </div>

          {/* Quick actions */}
          <div>
            <p className="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-3">Nueva solicitud</p>
            <div className="grid grid-cols-2 gap-2">
              {[
                { type: RequestType.VACATION,   label: 'Vacaciones',      cls: 'bg-blue-700 text-white'   },
                { type: RequestType.PASS_EXIT,  label: 'Pase de Salida',  cls: 'bg-amber-600 text-white'  },
                { type: RequestType.PASS_ENTRY, label: 'Pase de Entrada', cls: 'bg-orange-600 text-white' },
                { type: RequestType.SINDICAL,   label: 'Día Sindical',    cls: 'bg-emerald-600 text-white'},
              ].map(a => (
                <button key={a.type} onClick={() => { setReqFormType(a.type); setShowRequestForm(true) }}
                  className={`${a.cls} py-3 px-4 rounded-2xl text-sm font-bold text-left shadow-sm`}>
                  <Plus size={14} className="inline mb-0.5 mr-1" />{a.label}
                </button>
              ))}
            </div>
          </div>

          {/* Evaluaciones */}
          <div>
            <p className="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-3">Evaluaciones</p>
            <div className="space-y-2">
              {[
                { label: 'NOM-035 STPS',      sub: 'Factores de riesgo psicosocial', icon: Shield,   action: () => setSubView({ type: 'nom035' }),  cls: 'bg-blue-50 border-blue-200' },
                { label: 'Clima Laboral',      sub: 'Encuesta anual',                 icon: Wind,     action: () => setSubView({ type: 'climate' }), cls: 'bg-green-50 border-green-200' },
              ].map(e => (
                <button key={e.label} onClick={e.action}
                  className={`w-full ${e.cls} border rounded-2xl p-4 flex items-center gap-4 text-left`}>
                  <e.icon size={20} className="text-gray-600 shrink-0" />
                  <div>
                    <p className="font-bold text-gray-800 text-sm">{e.label}</p>
                    <p className="text-[11px] text-gray-500">{e.sub}</p>
                  </div>
                </button>
              ))}
            </div>
          </div>

          {/* Últimas solicitudes */}
          {myRequests.length > 0 && (
            <div>
              <p className="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-3">Mis solicitudes recientes</p>
              <div className="space-y-2">
                {myRequests.slice(0, 3).map(r => {
                  const cfg = getStatusConfig(r.status)
                  return (
                    <div key={r.id} className="bg-white rounded-2xl p-4 border border-gray-100 shadow-sm">
                      <div className="flex items-center justify-between">
                        <span className="font-bold text-gray-800 text-sm">{r.type}</span>
                        <span className={`text-[10px] font-bold px-2 py-1 rounded-full ${cfg.color}`}>{cfg.label}</span>
                      </div>
                      <p className="text-xs text-gray-500 mt-1">{formatDate(r.startDate)} — {formatDate(r.endDate)}</p>
                    </div>
                  )
                })}
              </div>
            </div>
          )}
        </>
      )}

      {/* Manager / Admin: dashboard */}
      {(user.role === UserRole.MANAGER || user.role === UserRole.ADMIN_RH) && (
        <>
          <div className="grid grid-cols-2 gap-3">
            <StatsCard label="Total personal"    value={staff.length}          icon={Users}       color="bg-blue-700" />
            <StatsCard label="Pendientes"        value={pendingForMe.length}   icon={AlertCircle} color="bg-amber-500" />
            <StatsCard label="Total solicitudes" value={requests.length}       icon={ClipboardList} color="bg-gray-600" />
            <StatsCard label="Aprobadas"         value={requests.filter(r => r.status === RequestStatus.APPROVED_HR).length}
              icon={TrendingUp} color="bg-emerald-600" />
          </div>

          {pendingForMe.length > 0 && (
            <div>
              <p className="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-3">
                Esperan tu aprobación ({pendingForMe.length})
              </p>
              <div className="space-y-2">
                {pendingForMe.slice(0, 3).map(r => (
                  <div key={r.id} className="bg-white rounded-2xl p-4 border border-amber-100 shadow-sm">
                    <div className="flex items-center justify-between mb-2">
                      <div>
                        <p className="font-bold text-gray-800 text-sm">{r.employeeName}</p>
                        <p className="text-xs text-gray-500">{r.type} · {formatDate(r.startDate)}</p>
                      </div>
                      <div className="flex gap-2">
                        <button onClick={() => handleUpdateStatus(r.id, user.role === UserRole.MANAGER ? RequestStatus.APPROVED_MANAGER : RequestStatus.APPROVED_HR)}
                          className="w-8 h-8 bg-emerald-100 text-emerald-600 rounded-xl flex items-center justify-center">
                          <Check size={16} />
                        </button>
                        <button onClick={() => handleUpdateStatus(r.id, RequestStatus.REJECTED)}
                          className="w-8 h-8 bg-red-100 text-red-500 rounded-xl flex items-center justify-center">
                          <X size={16} />
                        </button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Evaluaciones para manager */}
          {user.role === UserRole.ADMIN_RH && staff.length > 0 && (
            <div>
              <p className="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-3">Evaluaciones de desempeño</p>
              <div className="space-y-2">
                {staff.slice(0, 3).map(s => (
                  <button key={s.id} onClick={() => setSubView({ type: 'performance', target: s })}
                    className="w-full bg-white border border-purple-100 rounded-2xl p-4 flex items-center gap-3 text-left shadow-sm">
                    <div className="w-8 h-8 bg-purple-100 text-purple-700 rounded-xl flex items-center justify-center">
                      <Star size={16} />
                    </div>
                    <div>
                      <p className="font-bold text-gray-800 text-sm">{s.name}</p>
                      <p className="text-[11px] text-gray-400">{s.position} · {s.area}</p>
                    </div>
                    <BarChart2 size={16} className="ml-auto text-purple-400" />
                  </button>
                ))}
              </div>
            </div>
          )}
        </>
      )}
    </div>
  )

  // ─── SOLICITUDES (bandeja de aprobación) ─────────────────────────────────
  const renderSolicitudes = () => (
    <div className="p-6 space-y-4 pb-28">
      <div className="flex items-center justify-between">
        <h2 className="font-black text-gray-900 text-lg">Bandeja</h2>
        <button onClick={exportToExcel}
          className="flex items-center gap-2 px-3 py-2 bg-gray-100 text-gray-600 rounded-xl text-xs font-bold">
          <Download size={14} /> Excel
        </button>
      </div>

      {pendingForMe.length === 0 && (
        <div className="text-center py-12 text-gray-400">
          <Check size={40} className="mx-auto mb-3 opacity-30" />
          <p className="font-bold">Todo al día</p>
          <p className="text-xs mt-1">No hay solicitudes pendientes.</p>
        </div>
      )}

      {pendingForMe.map(r => {
        const expanded = expandedReqId === r.id
        const approveStatus = user.role === UserRole.MANAGER
          ? RequestStatus.APPROVED_MANAGER
          : RequestStatus.APPROVED_HR

        return (
          <div key={r.id} className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
            <button onClick={() => setExpandedReqId(expanded ? null : r.id)}
              className="w-full p-4 flex items-center justify-between text-left">
              <div>
                <p className="font-bold text-gray-800 text-sm">{r.employeeName}</p>
                <p className="text-xs text-gray-500">{r.type} · {formatDate(r.startDate)}</p>
              </div>
              {expanded ? <ChevronUp size={18} className="text-gray-400" /> : <ChevronDown size={18} className="text-gray-400" />}
            </button>
            {expanded && (
              <div className="px-4 pb-4 space-y-3 border-t border-gray-50 pt-3">
                <p className="text-xs text-gray-600"><span className="font-bold">Motivo:</span> {r.reason}</p>
                {r.durationMinutes && (
                  <p className="text-xs text-gray-600"><span className="font-bold">Duración:</span> {r.durationMinutes} min</p>
                )}
                <div className="flex gap-2">
                  <button onClick={() => handleUpdateStatus(r.id, approveStatus)}
                    className="flex-1 py-2.5 bg-emerald-600 text-white rounded-xl text-xs font-bold flex items-center justify-center gap-1">
                    <Check size={14} /> Aprobar
                  </button>
                  <button onClick={() => handleUpdateStatus(r.id, RequestStatus.REJECTED)}
                    className="flex-1 py-2.5 bg-red-500 text-white rounded-xl text-xs font-bold flex items-center justify-center gap-1">
                    <X size={14} /> Rechazar
                  </button>
                </div>
              </div>
            )}
          </div>
        )
      })}
    </div>
  )

  // ─── HISTORIAL ────────────────────────────────────────────────────────────
  const renderHistorial = () => {
    const list = user.role === UserRole.WORKER ? myRequests : requests
    return (
      <div className="p-6 space-y-4 pb-28">
        <div className="flex items-center justify-between">
          <h2 className="font-black text-gray-900 text-lg">Historial</h2>
          {user.role !== UserRole.WORKER && (
            <button onClick={exportToExcel}
              className="flex items-center gap-2 px-3 py-2 bg-gray-100 text-gray-600 rounded-xl text-xs font-bold">
              <Download size={14} /> Excel
            </button>
          )}
        </div>

        {list.length === 0 ? (
          <div className="text-center py-12 text-gray-400">
            <FileText size={40} className="mx-auto mb-3 opacity-30" />
            <p className="font-bold">Sin solicitudes</p>
          </div>
        ) : (
          <div className="space-y-2">
            {list.map(r => {
              const cfg = getStatusConfig(r.status)
              return (
                <div key={r.id} className="bg-white rounded-2xl p-4 border border-gray-100 shadow-sm">
                  <div className="flex items-start justify-between gap-2">
                    <div className="flex-1 min-w-0">
                      {user.role !== UserRole.WORKER && (
                        <p className="font-bold text-gray-800 text-sm truncate">{r.employeeName}</p>
                      )}
                      <p className={`${user.role === UserRole.WORKER ? 'font-bold text-gray-800 text-sm' : 'text-xs text-gray-500'}`}>
                        {r.type}
                      </p>
                      <p className="text-[11px] text-gray-400 mt-0.5">
                        {formatDate(r.startDate)}
                        {r.endDate !== r.startDate && ` — ${formatDate(r.endDate)}`}
                        {r.durationMinutes ? ` · ${r.durationMinutes} min` : ''}
                      </p>
                    </div>
                    <span className={`shrink-0 text-[10px] font-bold px-2 py-1 rounded-full ${cfg.color}`}>
                      {cfg.label}
                    </span>
                  </div>
                  {r.reason && (
                    <p className="text-[11px] text-gray-500 mt-2 leading-relaxed">{r.reason}</p>
                  )}
                </div>
              )
            })}
          </div>
        )}
      </div>
    )
  }

  // ─── CONFIG (gestión de personal) ────────────────────────────────────────
  const renderConfig = () => (
    <div className="p-6 space-y-4 pb-28">
      <div className="flex items-center justify-between">
        <h2 className="font-black text-gray-900 text-lg">Personal</h2>
        <button onClick={() => setShowAddEmployee(true)}
          className="flex items-center gap-2 px-3 py-2 bg-blue-700 text-white rounded-xl text-xs font-bold">
          <Plus size={14} /> Agregar
        </button>
      </div>

      {/* Search + filter */}
      <div className="space-y-2">
        <div className="relative">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
          <input value={search} onChange={e => setSearch(e.target.value)}
            placeholder="Buscar por nombre o usuario..."
            className="w-full bg-gray-50 border border-gray-200 rounded-xl pl-9 pr-4 py-2.5 text-sm outline-none" />
        </div>
        <select value={filterArea} onChange={e => setFilterArea(e.target.value)}
          className="w-full bg-gray-50 border border-gray-200 rounded-xl px-3 py-2.5 text-sm outline-none">
          <option value="">Todas las áreas</option>
          {areas.map(a => <option key={a} value={a}>{a}</option>)}
        </select>
      </div>

      <p className="text-[10px] font-bold text-gray-400">{filteredStaff.length} empleados</p>

      <div className="space-y-2">
        {filteredStaff.map(s => (
          <div key={s.id} className="bg-white rounded-2xl p-4 border border-gray-100 shadow-sm">
            <div className="flex items-start justify-between gap-2">
              <div className="flex-1 min-w-0">
                <p className="font-bold text-gray-800 text-sm truncate">{s.name}</p>
                <p className="text-xs text-gray-500">{s.position}</p>
                <p className="text-[11px] text-gray-400">{s.area}</p>
              </div>
              <div className="flex gap-1.5">
                <button onClick={() => setEditingUser({ ...s })}
                  className="w-8 h-8 bg-blue-50 text-blue-600 rounded-xl flex items-center justify-center">
                  <Edit3 size={14} />
                </button>
                <button onClick={() => setConfirmDelete(s)}
                  className="w-8 h-8 bg-red-50 text-red-500 rounded-xl flex items-center justify-center">
                  <Trash2 size={14} />
                </button>
              </div>
            </div>
            <div className="mt-2 flex gap-2">
              <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-gray-100 text-gray-500">
                {DEFAULT_SHIFTS.find(sh => sh.id === s.shiftId)?.name || s.shiftId}
              </span>
              <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-blue-50 text-blue-600">
                {s.role}
              </span>
            </div>
          </div>
        ))}
      </div>

      {/* Edit modal */}
      {editingUser && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-6 bg-black/50 backdrop-blur-sm">
          <div className="bg-white rounded-3xl w-full max-w-sm p-6 shadow-2xl space-y-4">
            <div className="flex items-center justify-between">
              <h3 className="font-bold text-gray-900">Editar empleado</h3>
              <button onClick={() => setEditingUser(null)}><X size={20} className="text-gray-400" /></button>
            </div>
            {[
              { label: 'Nombre', key: 'name' },
              { label: 'Correo', key: 'email' },
            ].map(f => (
              <div key={f.key}>
                <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1">{f.label}</label>
                <input value={(editingUser as Record<string, unknown>)[f.key] as string || ''}
                  onChange={e => setEditingUser({ ...editingUser, [f.key]: e.target.value })}
                  className="w-full bg-gray-50 border border-gray-200 rounded-xl px-3 py-2.5 text-sm outline-none" />
              </div>
            ))}
            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1">Rol</label>
                <select value={editingUser.role}
                  onChange={e => setEditingUser({ ...editingUser, role: e.target.value as UserRole })}
                  className="w-full bg-gray-50 border border-gray-200 rounded-xl px-3 py-2.5 text-sm outline-none">
                  <option value={UserRole.WORKER}>Empleado</option>
                  <option value={UserRole.MANAGER}>Encargado</option>
                  <option value={UserRole.ADMIN_RH}>Admin RH</option>
                </select>
              </div>
              <div>
                <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1">Turno</label>
                <select value={editingUser.shiftId || ''}
                  onChange={e => setEditingUser({ ...editingUser, shiftId: e.target.value })}
                  className="w-full bg-gray-50 border border-gray-200 rounded-xl px-3 py-2.5 text-sm outline-none">
                  {DEFAULT_SHIFTS.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
                </select>
              </div>
            </div>
            <div className="flex gap-3">
              <button onClick={() => setEditingUser(null)}
                className="flex-1 py-3 rounded-2xl border border-gray-200 text-sm font-bold text-gray-600">
                Cancelar
              </button>
              <button onClick={handleUpdateEmployee}
                className="flex-1 py-3 rounded-2xl bg-blue-700 text-white text-sm font-bold">
                Guardar
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )

  // ─── PERFIL ───────────────────────────────────────────────────────────────
  const renderPerfil = () => {
    const shift = DEFAULT_SHIFTS.find(s => s.id === user.shiftId)
    return (
      <div className="p-6 space-y-5 pb-28">
        <h2 className="font-black text-gray-900 text-lg">Mi Perfil</h2>

        {/* Avatar card */}
        <div className="bg-blue-700 text-white rounded-3xl p-6 text-center">
          <div className="w-16 h-16 bg-white/20 rounded-3xl flex items-center justify-center mx-auto mb-3">
            <span className="text-2xl font-black">{user.name.charAt(0)}</span>
          </div>
          <h3 className="font-black text-lg">{user.name}</h3>
          <p className="text-blue-200 text-sm">{user.position}</p>
          <p className="text-blue-300 text-xs mt-1">{user.area}</p>
        </div>

        {/* Info rows */}
        {[
          { label: 'Usuario',       value: user.username },
          { label: 'Correo',        value: user.email || '—' },
          { label: 'Rol',           value: roleBadge.label },
          { label: 'Turno',         value: shift ? `${shift.name} (${shift.startTime}–${shift.endTime})` : user.shiftId || '—' },
          { label: 'Vacaciones',    value: `${usedVacation} / ${user.vacationDays || 12} días usados` },
          { label: 'Pases este mes', value: `${usedPassMin} / 120 min usados` },
          { label: 'Contratación',  value: user.hireDate ? formatDate(user.hireDate) : '—' },
        ].map(row => (
          <div key={row.label} className="flex items-center justify-between py-2 border-b border-gray-100">
            <span className="text-xs font-bold text-gray-400 uppercase tracking-widest">{row.label}</span>
            <span className="text-sm font-bold text-gray-800">{row.value}</span>
          </div>
        ))}

        <button onClick={handleLogout}
          className="w-full flex items-center justify-center gap-2 py-4 border-2 border-red-100 text-red-500 rounded-2xl font-bold text-sm mt-4">
          <LogOut size={16} /> Cerrar sesión
        </button>
      </div>
    )
  }

  // ─── Main layout ──────────────────────────────────────────────────────────
  return (
    <div className="min-h-screen bg-gray-50 max-w-md mx-auto relative">
      {/* Content */}
      <main className="overflow-y-auto">
        {tab === 'inicio'      && renderInicio()}
        {tab === 'solicitudes' && renderSolicitudes()}
        {tab === 'historial'   && renderHistorial()}
        {tab === 'config'      && renderConfig()}
        {tab === 'perfil'      && renderPerfil()}
      </main>

      {/* Navigation */}
      <Navigation currentTab={tab} setTab={setTab} role={user.role} />

      {/* Modals */}
      {showRequestForm && (
        <RequestForm
          user={user}
          initialType={reqFormType}
          onClose={() => setShowRequestForm(false)}
          onSubmit={handleCreateRequest}
          existingRequests={myRequests}
        />
      )}

      {showAddEmployee && (
        <AddEmployeeModal
          data={newEmployee}
          setData={setNewEmployee}
          onClose={() => { setShowAddEmployee(false); setNewEmployee({}) }}
          onSubmit={handleAddEmployee}
        />
      )}

      <ConfirmationModal
        isOpen={!!confirmDelete}
        onClose={() => setConfirmDelete(null)}
        onConfirm={handleDeleteEmployee}
        title="Eliminar empleado"
        message={`¿Estás seguro de que deseas eliminar a ${confirmDelete?.name}? Esta acción no se puede deshacer.`}
      />
    </div>
  )
}
