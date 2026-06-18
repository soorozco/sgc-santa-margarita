import { useState } from 'react'
import { X, Calendar, Clock, Briefcase, SlidersHorizontal, DoorOpen } from 'lucide-react'
import { RequestType, RequestStatus, User, RequestRecord } from '../types'

interface Props {
  user:             User
  initialType:      RequestType
  onClose:          () => void
  onSubmit:         (data: FormData) => void
  existingRequests: RequestRecord[]
}

interface FormData {
  type:             RequestType
  startDate:        string
  endDate:          string
  startTime?:       string
  endTime?:         string
  durationMinutes?: number
  reason:           string
  attachment?:      File
}

const TYPE_META: Record<RequestType, { label: string; icon: React.FC<{ size?: number }>, color: string }> = {
  [RequestType.VACATION]:   { label: 'Vacaciones',       icon: Calendar,         color: 'bg-blue-700'   },
  [RequestType.PASS_EXIT]:  { label: 'Pase de Salida',   icon: DoorOpen,         color: 'bg-amber-600'  },
  [RequestType.PASS_ENTRY]: { label: 'Pase de Entrada',  icon: DoorOpen,         color: 'bg-orange-600' },
  [RequestType.SINDICAL]:   { label: 'Día Sindical',     icon: Briefcase,        color: 'bg-emerald-600'},
  [RequestType.CONVENIO]:   { label: 'Convenio',         icon: SlidersHorizontal, color: 'bg-gray-600'  },
}

function calcDuration(start: string, end: string): number {
  const [sh, sm] = start.split(':').map(Number)
  const [eh, em] = end.split(':').map(Number)
  return Math.max(0, (eh * 60 + em) - (sh * 60 + sm))
}

export function RequestForm({ user, initialType, onClose, onSubmit, existingRequests }: Props) {
  const today = new Date().toISOString().split('T')[0]
  const [type, setType]           = useState<RequestType>(initialType)
  const [startDate, setStartDate] = useState(today)
  const [endDate, setEndDate]     = useState(today)
  const [startTime, setStartTime] = useState('10:00')
  const [endTime, setEndTime]     = useState('11:00')
  const [reason, setReason]       = useState('')
  const [file, setFile]           = useState<File | undefined>()

  const isPass = type === RequestType.PASS_EXIT || type === RequestType.PASS_ENTRY
  const usedMin = existingRequests
    .filter(r =>
      (r.type === RequestType.PASS_EXIT || r.type === RequestType.PASS_ENTRY) &&
      r.status !== RequestStatus.REJECTED &&
      new Date(r.startDate).getMonth() === new Date().getMonth()
    )
    .reduce((a, r) => a + (r.durationMinutes || 0), 0)
  const availMin = 120 - usedMin
  const reqMin   = isPass ? calcDuration(startTime, endTime) : 0

  const meta = TYPE_META[type]
  const Icon = meta.icon

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    if (!reason.trim()) { alert('Por favor escribe el motivo de la solicitud.'); return }
    if (isPass && reqMin > availMin) {
      alert(`Solo tienes ${availMin} minutos disponibles este mes.`)
      return
    }
    onSubmit({
      type, startDate, endDate,
      ...(isPass ? { startTime, endTime, durationMinutes: reqMin } : {}),
      reason,
      attachment: file,
    })
  }

  return (
    <div className="fixed inset-0 z-50 flex items-end sm:items-center justify-center bg-black/50 backdrop-blur-sm">
      <div className="bg-white rounded-t-3xl sm:rounded-3xl w-full max-w-md max-h-[90vh] overflow-y-auto shadow-2xl">
        <div className={`sticky top-0 ${meta.color} text-white flex items-center justify-between px-6 py-4 rounded-t-3xl`}>
          <div className="flex items-center gap-3">
            <Icon size={22} />
            <div>
              <h3 className="font-bold text-base">Nueva Solicitud</h3>
              <p className="text-[11px] opacity-80">{user.name}</p>
            </div>
          </div>
          <button onClick={onClose} className="p-2 opacity-80 hover:opacity-100"><X size={20} /></button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 space-y-5">
          {/* Tipo */}
          <div>
            <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-2">Tipo de solicitud</label>
            <div className="grid grid-cols-2 gap-2">
              {Object.entries(TYPE_META).map(([t, m]) => {
                const TIcon = m.icon
                const active = type === t
                return (
                  <button key={t} type="button" onClick={() => setType(t as RequestType)}
                    className={`flex items-center gap-2 p-3 rounded-2xl border-2 text-sm font-bold transition-all ${
                      active ? `${m.color} text-white border-transparent` : 'border-gray-100 text-gray-600 bg-gray-50'}`}>
                    <TIcon size={16} />{m.label}
                  </button>
                )
              })}
            </div>
          </div>

          {/* Fechas */}
          {isPass ? (
            <>
              <div>
                <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Fecha</label>
                <input type="date" value={startDate} min={today}
                  onChange={e => { setStartDate(e.target.value); setEndDate(e.target.value) }}
                  className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none focus:ring-2 focus:ring-blue-500" />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Hora salida</label>
                  <input type="time" value={startTime} onChange={e => setStartTime(e.target.value)}
                    className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none" />
                </div>
                <div>
                  <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Hora regreso</label>
                  <input type="time" value={endTime} onChange={e => setEndTime(e.target.value)}
                    className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none" />
                </div>
              </div>
              <div className="bg-amber-50 border border-amber-200 rounded-2xl p-3 text-center">
                <p className="text-xs font-bold text-amber-700">
                  {reqMin} min solicitados · {availMin} min disponibles este mes
                </p>
              </div>
            </>
          ) : (
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Fecha inicio</label>
                <input type="date" value={startDate} min={today} onChange={e => setStartDate(e.target.value)}
                  className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none" />
              </div>
              <div>
                <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Fecha fin</label>
                <input type="date" value={endDate} min={startDate} onChange={e => setEndDate(e.target.value)}
                  className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none" />
              </div>
            </div>
          )}

          {/* Motivo */}
          <div>
            <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Motivo *</label>
            <textarea value={reason} onChange={e => setReason(e.target.value)} rows={3}
              placeholder="Describe brevemente el motivo de tu solicitud..."
              className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none resize-none focus:ring-2 focus:ring-blue-500" />
          </div>

          {/* Adjunto */}
          <div>
            <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Adjunto (opcional)</label>
            <input type="file" accept="image/*,.pdf"
              onChange={e => setFile(e.target.files?.[0])}
              className="w-full text-sm text-gray-600 file:mr-3 file:py-2 file:px-4 file:rounded-xl file:border-0 file:bg-gray-100 file:text-sm file:font-bold" />
          </div>

          <button type="submit"
            className={`w-full ${meta.color} text-white py-4 rounded-2xl font-bold text-sm shadow-lg`}>
            Enviar Solicitud
          </button>
        </form>
      </div>
    </div>
  )
}
