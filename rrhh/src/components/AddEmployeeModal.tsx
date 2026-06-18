import { X, UserPlus } from 'lucide-react'
import { User, UserRole } from '../types'
import { AREAS, DEPARTMENTS_DATA, DEFAULT_SHIFTS } from '../constants'

interface Props {
  onClose:  () => void
  data:     Partial<User> & { password?: string }
  setData:  (d: Partial<User> & { password?: string }) => void
  onSubmit: () => void
}

export function AddEmployeeModal({ onClose, data, setData, onSubmit }: Props) {
  const positions = data.area ? DEPARTMENTS_DATA[data.area] || [] : []
  const set = (k: string, v: unknown) => setData({ ...data, [k]: v })

  return (
    <div className="fixed inset-0 z-50 flex items-end sm:items-center justify-center bg-black/50 backdrop-blur-sm">
      <div className="bg-white rounded-t-3xl sm:rounded-3xl w-full max-w-md max-h-[90vh] overflow-y-auto shadow-2xl">
        <div className="sticky top-0 bg-white flex items-center justify-between px-6 py-4 border-b border-gray-100 rounded-t-3xl">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 bg-blue-700 text-white rounded-xl flex items-center justify-center">
              <UserPlus size={18} />
            </div>
            <h3 className="font-bold text-gray-900">Nuevo Empleado</h3>
          </div>
          <button onClick={onClose} className="p-2 text-gray-400"><X size={20} /></button>
        </div>

        <div className="p-6 space-y-4">
          {[
            { label: 'Nombre completo *',  key: 'name',      type: 'text',     ph: 'Dr. Juan Pérez López' },
            { label: 'No. Trabajador / Usuario *', key: 'username', type: 'text', ph: '10567 o jperez' },
            { label: 'Contraseña inicial *', key: 'password', type: 'password', ph: 'Mínimo 6 caracteres' },
            { label: 'Correo electrónico',  key: 'email',     type: 'email',    ph: 'correo@hsm.mx' },
            { label: 'Fecha de contratación', key: 'hireDate', type: 'date',   ph: '' },
            { label: 'Fecha de nacimiento',   key: 'birthDate', type: 'date',  ph: '' },
          ].map(f => (
            <div key={f.key}>
              <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">{f.label}</label>
              <input
                type={f.type}
                value={(data as Record<string, unknown>)[f.key] as string || ''}
                onChange={e => set(f.key, e.target.value)}
                placeholder={f.ph}
                className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
          ))}

          <div>
            <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Área *</label>
            <select
              value={data.area || ''}
              onChange={e => setData({ ...data, area: e.target.value, position: DEPARTMENTS_DATA[e.target.value]?.[0] || '' })}
              className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none">
              <option value="">— Seleccionar —</option>
              {AREAS.map(a => <option key={a} value={a}>{a}</option>)}
            </select>
          </div>

          <div>
            <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Puesto *</label>
            <select
              value={data.position || ''}
              onChange={e => set('position', e.target.value)}
              disabled={!data.area}
              className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none disabled:opacity-50">
              <option value="">— Seleccionar —</option>
              {positions.map(p => <option key={p} value={p}>{p}</option>)}
            </select>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Rol</label>
              <select value={data.role || UserRole.WORKER} onChange={e => set('role', e.target.value)}
                className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none">
                <option value={UserRole.WORKER}>Empleado</option>
                <option value={UserRole.MANAGER}>Encargado</option>
                <option value={UserRole.ADMIN_RH}>Admin RH</option>
              </select>
            </div>
            <div>
              <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Turno</label>
              <select value={data.shiftId || 't-matutino'} onChange={e => set('shiftId', e.target.value)}
                className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none">
                {DEFAULT_SHIFTS.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
              </select>
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Días Vacaciones</label>
              <input type="number" value={data.vacationDays ?? 12}
                onChange={e => set('vacationDays', parseInt(e.target.value) || 12)}
                className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none" />
            </div>
            <div>
              <label className="block text-[10px] font-black text-gray-400 uppercase tracking-widest mb-1.5">Días Sindicato</label>
              <input type="number" value={data.sindicalDays ?? 1}
                onChange={e => set('sindicalDays', parseInt(e.target.value) || 1)}
                className="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none" />
            </div>
          </div>

          <button onClick={onSubmit}
            className="w-full bg-blue-700 text-white py-4 rounded-2xl font-bold text-sm shadow-lg shadow-blue-200 mt-2">
            Agregar Empleado
          </button>
        </div>
      </div>
    </div>
  )
}
