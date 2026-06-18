import { useState } from 'react'
import { ArrowLeft } from 'lucide-react'
import { User } from '../types'

interface Props {
  user:     User
  onBack:   () => void
  onSubmit: (answers: Record<string, unknown>) => void
}

const SECTIONS = [
  {
    title: 'Comunicación',
    questions: [
      'La información que necesito para hacer mi trabajo llega a tiempo.',
      'Me siento escuchado(a) por mi jefe directo.',
      'La comunicación entre áreas funciona bien en el hospital.',
    ],
  },
  {
    title: 'Liderazgo y gestión',
    questions: [
      'Mi jefe es justo y consistente en sus decisiones.',
      'Mi jefe me apoya cuando tengo un problema en el trabajo.',
      'Las decisiones directivas benefician al equipo de trabajo.',
    ],
  },
  {
    title: 'Colaboración y equipo',
    questions: [
      'Me llevo bien con mis compañeros de trabajo.',
      'Existe un ambiente de respeto en mi área.',
      'Cuando alguien tiene dificultades, el equipo se apoya.',
    ],
  },
  {
    title: 'Desarrollo y reconocimiento',
    questions: [
      'Tengo oportunidades de crecimiento y desarrollo en el hospital.',
      'Mi trabajo es reconocido cuando lo hago bien.',
      'Recibo la capacitación necesaria para desempeñar mi puesto.',
    ],
  },
  {
    title: 'Condiciones y satisfacción general',
    questions: [
      'Las condiciones físicas de mi área de trabajo son adecuadas.',
      'Me siento orgulloso(a) de trabajar en el Hospital Santa Margarita.',
      'Recomendaría este hospital como un buen lugar para trabajar.',
    ],
  },
]

const SCALE = [
  { v: 1, label: 'Muy en desacuerdo' },
  { v: 2, label: 'En desacuerdo' },
  { v: 3, label: 'Neutral' },
  { v: 4, label: 'De acuerdo' },
  { v: 5, label: 'Muy de acuerdo' },
]

export function WorkClimateSurvey({ user, onBack, onSubmit }: Props) {
  const [answers, setAnswers] = useState<Record<string, number>>({})
  const [openComment, setOpenComment] = useState('')

  const allQ = SECTIONS.flatMap(s => s.questions)
  const answered = Object.keys(answers).length

  const handleSubmit = () => {
    if (answered < allQ.length) {
      alert('Por favor responde todas las preguntas antes de enviar.')
      return
    }
    onSubmit({ answers, openComment, respondent: user.id, area: user.area })
  }

  let globalIdx = 0

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      <header className="bg-white border-b border-gray-100 px-6 py-4 flex items-center gap-4">
        <button onClick={onBack} className="p-2 text-gray-500 bg-gray-100 rounded-xl">
          <ArrowLeft size={20} />
        </button>
        <div className="flex-1">
          <h1 className="font-bold text-gray-900 text-base">Clima Laboral</h1>
          <p className="text-xs text-gray-500">Encuesta anual · {user.area}</p>
        </div>
        <span className="text-xs font-bold text-gray-400">{answered}/{allQ.length}</span>
      </header>

      <div className="h-1 bg-gray-200">
        <div className="h-1 bg-green-500 transition-all" style={{ width: `${(answered / allQ.length) * 100}%` }} />
      </div>

      <main className="flex-1 overflow-y-auto p-5 pb-32 space-y-6">
        <p className="text-xs text-center text-gray-500 bg-white rounded-2xl p-3 border border-gray-100">
          Tus respuestas son <strong>anónimas</strong>. Responde con sinceridad.
        </p>

        {SECTIONS.map(section => (
          <div key={section.title}>
            <h2 className="font-bold text-gray-700 text-sm mb-3 px-1">{section.title}</h2>
            <div className="space-y-3">
              {section.questions.map(q => {
                const idx = globalIdx++
                return (
                  <div key={idx} className="bg-white rounded-2xl p-4 border border-gray-100 shadow-sm">
                    <p className="text-sm text-gray-700 font-medium mb-3 leading-relaxed">{q}</p>
                    <div className="grid grid-cols-5 gap-1">
                      {SCALE.map(s => {
                        const sel = answers[String(idx)] === s.v
                        return (
                          <button key={s.v} type="button"
                            onClick={() => setAnswers(prev => ({ ...prev, [String(idx)]: s.v }))}
                            className={`py-2 rounded-xl font-black text-sm transition-all ${
                              sel ? 'bg-green-600 text-white' : 'bg-gray-50 text-gray-500 hover:bg-gray-100'}`}>
                            {s.v}
                          </button>
                        )
                      })}
                    </div>
                    {answers[String(idx)] && (
                      <p className="text-[10px] text-center text-gray-400 mt-1">
                        {SCALE.find(s => s.v === answers[String(idx)])?.label}
                      </p>
                    )}
                  </div>
                )
              })}
            </div>
          </div>
        ))}

        <div className="bg-white rounded-2xl p-4 border border-gray-100 shadow-sm">
          <label className="block font-bold text-gray-800 text-sm mb-2">
            ¿Algo más que quieras compartir? (opcional)
          </label>
          <textarea value={openComment} onChange={e => setOpenComment(e.target.value)} rows={3}
            placeholder="Sugerencias, comentarios o lo que quieras decirle a la dirección..."
            className="w-full bg-gray-50 border border-gray-200 rounded-xl px-3 py-2 text-sm outline-none resize-none" />
        </div>
      </main>

      <div className="fixed bottom-0 left-1/2 -translate-x-1/2 w-full max-w-md p-4 bg-white border-t border-gray-100">
        <button onClick={handleSubmit}
          className="w-full bg-green-600 text-white py-4 rounded-2xl font-bold shadow-lg shadow-green-200">
          Enviar Encuesta
        </button>
      </div>
    </div>
  )
}
