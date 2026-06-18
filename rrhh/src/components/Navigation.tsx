import { Home, ClipboardList, Clock, Settings, User } from 'lucide-react'
import { UserRole } from '../types'

interface Props {
  currentTab: string
  setTab: (tab: string) => void
  role: UserRole
}

const TABS_WORKER   = ['inicio', 'historial', 'perfil']
const TABS_MANAGER  = ['inicio', 'solicitudes', 'historial', 'perfil']
const TABS_ADMIN    = ['inicio', 'solicitudes', 'historial', 'config', 'perfil']

export function Navigation({ currentTab, setTab, role }: Props) {
  const tabs = role === UserRole.ADMIN_RH
    ? TABS_ADMIN
    : role === UserRole.MANAGER
      ? TABS_MANAGER
      : TABS_WORKER

  const icon = (t: string, active: boolean) => {
    const cls = `w-6 h-6 ${active ? 'text-blue-700' : 'text-gray-400'}`
    switch (t) {
      case 'inicio':      return <Home className={cls} />
      case 'solicitudes': return <ClipboardList className={cls} />
      case 'historial':   return <Clock className={cls} />
      case 'config':      return <Settings className={cls} />
      case 'perfil':      return <User className={cls} />
      default:            return null
    }
  }
  const label = (t: string) => ({
    inicio: 'Inicio', solicitudes: 'Bandeja',
    historial: 'Historial', config: 'Personal', perfil: 'Perfil'
  }[t] || t)

  return (
    <nav className="fixed bottom-0 left-1/2 -translate-x-1/2 w-full max-w-md bg-white border-t border-gray-100 shadow-xl z-50 pb-safe">
      <div className="flex justify-around items-center h-16 px-2">
        {tabs.map(t => {
          const active = currentTab === t
          return (
            <button
              key={t}
              onClick={() => setTab(t)}
              className="flex flex-col items-center gap-0.5 py-2 px-3 rounded-2xl transition-all active:scale-90"
            >
              {icon(t, active)}
              <span className={`text-[9px] font-bold uppercase tracking-wider ${active ? 'text-blue-700' : 'text-gray-400'}`}>
                {label(t)}
              </span>
            </button>
          )
        })}
      </div>
    </nav>
  )
}
