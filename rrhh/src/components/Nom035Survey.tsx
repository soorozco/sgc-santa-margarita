import { useState } from 'react'
import { ArrowLeft, ChevronRight } from 'lucide-react'

interface Props {
  onBack:   () => void
  onSubmit: (answers: { [key: number]: number }) => void
}

const CATEGORIES = [
  {
    title: 'Ambiente de trabajo',
    questions: [
      'Mi trabajo implica que me exponga a situaciones que me resultan muy difíciles de controlar.',
      'En mi trabajo tengo que hacer esfuerzo importante para evitar enfermarme.',
      'Las condiciones en que trabajo son buenas (iluminación, temperatura, ventilación).',
      'Mi trabajo me exige hacer varios asuntos al mismo tiempo.',
    ],
  },
  {
    title: 'Factores propios de la actividad',
    questions: [
      'Cuando termino mi jornada me siento agotado(a).',
      'En mi trabajo tengo que dar más del 100% para que salga bien.',
      'En mi trabajo hay reglas y procedimientos claros que me ayudan a trabajar bien.',
      'Tengo autonomía para organizar mi propio trabajo.',
    ],
  },
  {
    title: 'Organización del tiempo de trabajo',
    questions: [
      'Mi jornada de trabajo me permite tener tiempo para mi familia y vida personal.',
      'Puedo descansar los días establecidos en mi horario de trabajo.',
      'Mis jornadas de trabajo son superiores a 10 horas.',
      'Tengo que trabajar en días de descanso sin que se me paguen o den tiempo compensatorio.',
    ],
  },
  {
    title: 'Liderazgo y relaciones en el trabajo',
    questions: [
      'Mi jefe me trata con respeto.',
      'Mi jefe me da retroalimentación sobre mi trabajo.',
      'Entre compañeros nos ayudamos cuando alguien tiene problemas en el trabajo.',
      'En el trabajo siento que mis compañeros o jefes me ignoran.',
    ],
  },
  {
    title: 'Entorno organizacional',
    questions: [
      'Mi trabajo me permite desarrollar mis habilidades.',
      'En mi trabajo existen oportunidades de desarrollo profesional.',
      'Se me reconoce cuando hago bien mi trabajo.',
      'En mi área de trabajo se trabaja bajo mucha presión.',
    ],
  },
]

const OPTIONS = [
  { value: 0, label: 'Nunca' },
  { value: 1, label: 'Casi nunca' },
  { value: 2, label: 'Algunas veces' },
  { value: 3, label: 'Casi siempre' },
  { value: 4, label: 'Siempre' },
]

export function Nom035Survey({ onBack, onSubmit }: Props) {
  const [answers, setAnswers] = useState<{ [key: number]: number }>({})
  const [cat, setCat] = useState(0)

  const allQ = CATEGORIES.flatMap(c => c.questions)
  const startIdx = CATEGORIES.slice(0, cat).reduce((a, c) => a + c.questions.length, 0)
  const currentCat = CATEGORIES[cat]
  const catAnswered = currentCat.questions.every((_, i) => answers[startIdx + i] !== undefined)
  const totalAnswered = Object.keys(answers).length

  const handleNext = () => {
    if (!catAnswered) { alert('Por favor responde todas las preguntas de esta sección.'); return }
    if (cat < CATEGORIES.length - 1) setCat(c => c + 1)
    else onSubmit(answers)
  }

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      <header className="bg-white border-b border-gray-100 px-6 py-4 flex items-center gap-4">
        <button onClick={onBack} className="p-2 text-gray-500 bg-gray-100 rounded-xl">
          <ArrowLeft size={20} />
        </button>
        <div className="flex-1">
          <h1 className="font-bold text-gray-900 text-base">Evaluación NOM-035</h1>
          <p className="text-xs text-gray-500">Factores de riesgo psicosocial</p>
        </div>
        <span className="text-xs font-bold text-gray-400">{totalAnswered}/{allQ.length}</span>
      </header>

      {/* Progress */}
      <div className="h-1 bg-gray-200">
        <div className="h-1 bg-blue-600 transition-all" style={{ width: `${(totalAnswered / allQ.length) * 100}%` }} />
      </div>

      {/* Category tabs */}
      <div className="flex overflow-x-auto px-4 py-3 gap-2 bg-white border-b border-gray-100">
        {CATEGORIES.map((c, i) => (
          <button key={i} onClick={() => setCat(i)}
            className={`shrink-0 px-3 py-1.5 rounded-full text-[11px] font-bold transition-all ${
              i === cat ? 'bg-blue-700 text-white' : 'bg-gray-100 text-gray-500'}`}>
            {i + 1}. {c.title}
          </button>
        ))}
      </div>

      <main className="flex-1 overflow-y-auto p-6 space-y-6 pb-28">
        <h2 className="font-bold text-gray-800">{currentCat.title}</h2>
        {currentCat.questions.map((q, qi) => {
          const globalIdx = startIdx + qi
          return (
            <div key={qi} className="bg-white rounded-2xl p-4 border border-gray-100 shadow-sm">
              <p className="text-sm text-gray-700 font-medium mb-3 leading-relaxed">
                <span className="text-blue-600 font-bold">{globalIdx + 1}. </span>{q}
              </p>
              <div className="grid grid-cols-5 gap-1">
                {OPTIONS.map(opt => {
                  const selected = answers[globalIdx] === opt.value
                  return (
                    <button key={opt.value} type="button"
                      onClick={() => setAnswers(prev => ({ ...prev, [globalIdx]: opt.value }))}
                      className={`flex flex-col items-center p-2 rounded-xl transition-all text-center ${
                        selected ? 'bg-blue-700 text-white' : 'bg-gray-50 text-gray-600 hover:bg-gray-100'}`}>
                      <span className="text-lg font-black">{opt.value}</span>
                      <span className="text-[8px] font-bold leading-tight mt-0.5">{opt.label}</span>
                    </button>
                  )
                })}
              </div>
            </div>
          )
        })}
      </main>

      <div className="fixed bottom-0 left-1/2 -translate-x-1/2 w-full max-w-md p-4 bg-white border-t border-gray-100">
        <button onClick={handleNext}
          className="w-full bg-blue-700 text-white py-4 rounded-2xl font-bold flex items-center justify-center gap-2 shadow-lg shadow-blue-200">
          {cat < CATEGORIES.length - 1 ? <>Siguiente sección <ChevronRight size={18} /></> : 'Enviar evaluación'}
        </button>
      </div>
    </div>
  )
}
