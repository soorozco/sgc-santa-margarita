import { X, AlertTriangle } from 'lucide-react'

interface Props {
  isOpen:    boolean
  onClose:   () => void
  onConfirm: () => void
  title:     string
  message:   string
}

export function ConfirmationModal({ isOpen, onClose, onConfirm, title, message }: Props) {
  if (!isOpen) return null
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-6 bg-black/50 backdrop-blur-sm">
      <div className="bg-white rounded-3xl w-full max-w-sm shadow-2xl animate-in">
        <div className="p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 bg-red-100 text-red-600 rounded-2xl flex items-center justify-center">
                <AlertTriangle size={20} />
              </div>
              <h3 className="font-bold text-gray-900">{title}</h3>
            </div>
            <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600">
              <X size={18} />
            </button>
          </div>
          <p className="text-sm text-gray-600 mb-6">{message}</p>
          <div className="flex gap-3">
            <button onClick={onClose}
              className="flex-1 py-3 rounded-2xl border border-gray-200 text-sm font-bold text-gray-600">
              Cancelar
            </button>
            <button onClick={onConfirm}
              className="flex-1 py-3 rounded-2xl bg-red-600 text-white text-sm font-bold">
              Eliminar
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}
