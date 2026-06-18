import { type LucideIcon } from 'lucide-react'

interface Props {
  label:     string
  value:     string | number
  icon:      LucideIcon
  color:     string
  className?: string
}

export function StatsCard({ label, value, icon: Icon, color, className = '' }: Props) {
  return (
    <div className={`bg-white rounded-3xl p-5 border border-gray-100 shadow-sm flex flex-col gap-3 ${className}`}>
      <div className={`w-10 h-10 ${color} text-white rounded-2xl flex items-center justify-center`}>
        <Icon size={20} />
      </div>
      <div>
        <p className="text-2xl font-black text-gray-900 leading-none">{value}</p>
        <p className="text-[10px] font-bold text-gray-400 uppercase tracking-wider mt-1">{label}</p>
      </div>
    </div>
  )
}
