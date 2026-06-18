import { useState } from 'react'
import { ArrowLeft } from 'lucide-react'
import { User } from '../types'

interface Props {
  user:     User
  onBack:   () => void
  onSubmit: (answers: Record<string, unknown>) => void
}

const COMPETENCIES = [
  { id: 'calidad',         label: 'Calidad en el trabajo',          desc: 'Precisión, limpieza y cumplimiento de estándares en sus actividades.' },
  { id: 'puntualidad',     label: 'Puntualidad y asistencia',        desc: 'Cumplimiento del horario y registro de asistencia.' },
  { id: 'trabajo_equipo',  label: 'Trabajo en equipo',              desc: 'Colaboración y apoyo al resto del área.' },
  { id: 'iniciativa',      label: 'Iniciativa y proactividad',       desc: 'Propone mejoras y actúa sin esperar instrucciones.' },
  { id: 'conocimiento',    label: 'Conocimiento técnico',            desc: 'Dominio de las competencias técnicas de su puesto.' },
  { id: 'comunicacion',    label: 'Comunicación efectiva',           desc: 'Se expresa con claridad, escucha activamente.' },
  { id: 'seguridad',       label: 'Cumplimiento de normas y seguridad', desc: 'Respeta procedimientos, usa EPP, reporta incidentes.' },
  { id: 'servicio',        label: 'Orientación al paciente / cliente', desc: 'Trato humano, empático y resolutivo.' },
]

const SCALE = [
  { v: 1, label: 'Deficiente',    color: 'bg-red-500 text-white'      },
  { v: 2, label: 'Regular',       color: 'bg-orange-400 text-white'   },
  { v: 3, label: 'Bueno',         color: 'bg-amber-400 text-white'    },
  { v: 4, label: 'Muy bueno',     color: 'bg-emerald-500 text-white'  },
  { v: 5, label: 'Excelente',     color: 'bg-blue-600 text-white'     },
]

export function PerformanceEvaluation({ user, onBack, onSubmit }: Props) {
  const [scores, setScores]     = useState<Record<string, number>>({})
  const [goals, setGoals]       = useState('')
  const [strengths, setStrengths] = useState('')
  const [areas, setAreas]       = useState('')

  const total   = Object.values(scores).reduce((a, b) => a + b, 0)
  const avg     = Object.keys(scores).length > 0 ? (total / Object.keys(scores).length).toFixed(1) : '—'
  const allDone = COMPETENCIES.every(c => scores[c.id] !== undefined)

  const handleSubmit = () => {
    if (!allDone) { alert('Por favor evalúa todas las competencias.'); return }
    onSubmit({ scores, avg, goals, strengths, areasForImprovement: areas, evaluatedUser: user.id })
  }

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      <header className="bg-white border-b border-gray-100 px-6 py-4 flex items-center gap-4">
        <button onClick={onBack} className="p-2 text-gray-500 bg-gray-100 rounded-xl">
          <ArrowLeft size={20} />
        </button>
        <div className="flex-1">
          <h1 className="font-bold text-gray-900 text-base">Evaluación de Desempeño</h1>
          <p className="text-xs text-gray-500">{user.name} · {user.position}</p>
        </div>
        <div className="text-center">
          <p className="text-2xl font-black text-blue-700">{avg}</p>
          <p className="text-[9px] text-gray-400 uppercase tracking-wider">Promedio</p>
        </div>
      </header>

      <main className="flex-1 overflow-y-auto p-5 pb-32 space-y-4">
        <p className="text-xs text-gray-500 text-center bg-white rounded-2xl p-3 border border-gray-100">
          Evalúa cada competencia del 1 (Deficiente) al 5 (Excelente)
        </p>

        {COMPETENCIES.map(comp => (
          <div key={comp.id} className="bg-white rounded-2xl p-4 border border-gray-100 shadow-sm">
            <p className="font-bold text-gray-800 text-sm mb-0.5">{comp.label}</p>
            <p className="text-[11px] text-gray-500 mb-3">{comp.desc}</p>
            <div className="flex gap-2">
              {SCALE.map(s => {
                const sel = scores[comp.id] === s.v
                return (
                  <button key={s.v} type="button"
                    onClick={() => setScores(prev => ({ ...prev, [comp.id]: s.v }))}
                    className={`flex-1 py-2.5 rounded-xl font-black text-base transition-all ${
                      sel ? s.color : 'bg-gray-100 text-gray-400'}`}>
                    {s.v}
                  </button>
                )
              })}
            </div>
            {scores[comp.id] && (
              <p className="text-[10px] text-center text-gray-400 mt-1 font-bold">
                {SCALE.find(s => s.v === scores[comp.id])?.label}
              </p>
            )}
          </div>
        ))}

        <div className="bg-white rounded-2xl p-4 border border-gray-100 shadow-sm space-y-4">
          <p className="font-bold text-gray-800 text-sm">Comentarios adicionales</p>
          <div>
            <label className="text-[10px] font-black text-gray-400 uppercase tracking-widest block mb-1">Fortalezas</label>
            <textarea value={strengths} onChange={e => setStrengths(e.target.value)} rows={2} placeholder="¿Qué hace muy bien?"
              className="w-full bg-gray-50 border border-gray-200 rounded-xl px-3 py-2 text-sm outline-none resize-none" />
          </div>
          <div>
            <label className="text-[10px] font-black text-gray-400 uppercase tracking-widest block mb-1">Áreas de mejora</label>
            <textarea value={areas} onChange={e => setAreas(e.target.value)} rows={2} placeholder="¿En qué puede mejorar?"
              className="w-full bg-gray-50 border border-gray-200 rounded-xl px-3 py-2 text-sm outline-none resize-none" />
          </div>
          <div>
            <label className="text-[10px] font-black text-gray-400 uppercase tracking-widest block mb-1">Objetivos próximo período</label>
            <textarea value={goals} onChange={e => setGoals(e.target.value)} rows={2} placeholder="Metas para el siguiente período..."
              className="w-full bg-gray-50 border border-gray-200 rounded-xl px-3 py-2 text-sm outline-none resize-none" />
          </div>
        </div>
      </main>

      <div className="fixed bottom-0 left-1/2 -translate-x-1/2 w-full max-w-md p-4 bg-white border-t border-gray-100">
        <button onClick={handleSubmit}
          className="w-full bg-purple-700 text-white py-4 rounded-2xl font-bold shadow-lg shadow-purple-200">
          Enviar Evaluación
        </button>
      </div>
    </div>
  )
}
