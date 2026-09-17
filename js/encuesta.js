// ══════════════════════════════════════════════════════════════════
// Encuesta pública de satisfacción + Quejas/Sugerencias/Felicitaciones
// Vista de PACIENTE (QR de habitación). Sin login. Escribe con anon key.
// ══════════════════════════════════════════════════════════════════

// Mapa habitación → área (para poder filtrar en el panel por servicio)
const ROOMS_BY_AREA = {
  'Central Juan Pablo II': ['JP01','JP02','JP03','JP04','JP05','JP06','JP07','JP08','JP09','JP10','JP11','JP12','JP13','JP14','JP15','JP16','JP17'],
  'Central Planta Baja (PB)': ['PB104','PB105','PB107','PB109','PB111','PB112','PB113','PB114','PB115','PB116','PB117'],
  'Central Planta Baja (PA)': ['PA204','PA206','PA207','PA212','PA213','PA214','PA215','PA216','PA218'],
  'Central Planta Alta': ['PA202'],
  'Central Ginecología': ['GIN01','GIN02','GIN03','GIN05','GIN06','GIN07','GIN08','GIN10','GIN11','GIN13','GIN15','GIN16','GIN17'],
  'Central Pediatría': ['PED01','PED02','PED03','PED04','PED05'],
  'Master Suite': ['SU01','SU02','SU03'],
  'Quirófano': ['QX01','QX02'],
  'Unidad de Terapia Intensiva': ['UTI01','UTI02','UTI03','UTI04'],
  'Urgencias': ['ACV01'],
}
function areaDeHabitacion(hab) {
  const h = (hab || '').trim().toUpperCase()
  for (const [area, rooms] of Object.entries(ROOMS_BY_AREA)) {
    if (rooms.some(r => r.toUpperCase() === h)) return area
  }
  return null
}

// Escalas → valor 1..5 (o null en "No aplica")
const ESC6 = { 'Excelente':5, 'Bueno':4, 'Regular':3, 'Malo':2, 'Muy malo':1, 'No aplica':null }
const ESC5 = { 'Excelente':5, 'Bueno':4, 'Regular':3, 'Malo':2, 'Muy malo':1 }
const ESC5B= { 'Excelente':5, 'Buena':4, 'Regular':3, 'Mala':2, 'Muy mala':1 }

// Estructura de la encuesta (10 secciones, avance lineal)
const SURVEY = [
  { titulo:'Su experiencia importa',
    intro:'En Hospital Santa Margarita nos interesa conocer su experiencia. Su opinión nos ayuda a mejorar la calidad y seguridad de nuestros servicios. La encuesta es anónima y toma unos 2 minutos. ¡Gracias por su tiempo!',
    preguntas:[
      { id:'quien',       n:1, texto:'¿Quién responde la encuesta?', tipo:'opcion', obl:true, opciones:['Paciente','Familiar o acompañante'] },
      { id:'habitacion',  n:2, texto:'Número de habitación', tipo:'texto', obl:true, ph:'Ej. JP05, PB111, GIN02…' },
    ]},
  { titulo:'Experiencia durante la atención', desc:'Califique los siguientes aspectos de su atención.',
    preguntas:[
      { id:'q_tramites_ingreso', n:3,  texto:'Facilidad y rapidez de los trámites de ingreso.', tipo:'esc', esc:ESC6, obl:true },
      { id:'q_info_normas',      n:4,  texto:'Información recibida sobre las normas y servicios del hospital.', tipo:'esc', esc:ESC6, obl:true },
      { id:'q_tiempo_espera',    n:5,  texto:'Tiempo de espera para recibir atención.', tipo:'esc', esc:ESC6, obl:true },
      { id:'q_atencion_enfermeria', n:6, texto:'Trato y cuidados brindados por enfermería.', tipo:'esc', esc:ESC6, obl:true },
      { id:'q_atencion_medico',  n:7,  texto:'Atención por parte del personal médico.', tipo:'esc', esc:ESC6, obl:true },
      { id:'q8_presento',        n:8,  texto:'¿El personal se presentó con usted y verificó su nombre antes de brindarle atención?', tipo:'opcion', obl:true, opciones:['Siempre','Casi siempre','Algunas veces','Nunca','No lo recuerda'] },
      { id:'q_privacidad',       n:9,  texto:'Respeto a su privacidad y confidencialidad.', tipo:'esc', esc:ESC6, obl:true },
      { id:'q_higiene',          n:10, texto:'Limpieza de la habitación y de las instalaciones.', tipo:'esc', esc:ESC6, obl:true },
      { id:'q_vigilancia',       n:11, texto:'Trato del personal de vigilancia.', tipo:'esc', esc:ESC6, obl:true },
    ]},
  { titulo:'Alimentos',
    preguntas:[
      { id:'q12_recibio', n:12, texto:'Durante su estancia, ¿recibió alimentos proporcionados por el hospital?', tipo:'opcion', obl:true, opciones:['Sí','No'] },
    ]},
  { titulo:'Evaluación de alimentos',
    preguntas:[
      { id:'q_alimentos',     n:13, texto:'¿Cómo calificaría la calidad de los alimentos recibidos?', tipo:'esc', esc:ESC5, obl:true },
      { id:'q14_presentacion',n:14, texto:'¿Cómo calificaría la presentación y temperatura de los alimentos?', tipo:'esc', esc:ESC5, obl:true },
    ]},
  { titulo:'Alta hospitalaria',
    preguntas:[
      { id:'q15_alta', n:15, texto:'Al momento de responder esta encuesta, ¿ya concluyó su trámite de alta hospitalaria?', tipo:'opcion', obl:true, opciones:['Sí','No'] },
    ]},
  { titulo:'Evaluación del egreso',
    preguntas:[
      { id:'q_tramites_egreso', n:16, texto:'¿Cómo calificaría la facilidad y rapidez de los trámites de egreso?', tipo:'esc', esc:ESC5, obl:true },
      { id:'q17_info_egreso',   n:17, texto:'¿Recibió información clara sobre los cuidados y recomendaciones posteriores a su egreso?', tipo:'opcion', obl:true, opciones:['Sí, completamente','Parcialmente','No','No aplica'] },
    ]},
  { titulo:'Satisfacción general',
    preguntas:[
      { id:'q_servicio_general', n:18, texto:'En general, ¿cómo calificaría la atención recibida en Hospital Santa Margarita?', tipo:'esc', esc:ESC5B, obl:true },
    ]},
  { titulo:'Oportunidad de mejora',
    preguntas:[
      { id:'q19_oportunidad', n:19, texto:'¿En qué aspecto se presentó la principal oportunidad de mejora?', tipo:'opcion', obl:true,
        opciones:['Admisión o ingreso','Tiempo de espera','Atención médica','Atención de enfermería','Información y comunicación','Limpieza','Alimentos','Vigilancia','Instalaciones','Trámite de egreso','Otro'] },
      { id:'q20_describa', n:20, texto:'Por favor, descríbanos brevemente lo ocurrido.', tipo:'textarea', obl:false },
    ]},
  { titulo:'Recomendación y comentarios',
    preguntas:[
      { id:'nps', n:21, texto:'En una escala del 0 al 10, ¿qué tan probable es que recomiende Hospital Santa Margarita?', tipo:'nps', obl:true },
      { id:'q22_agrado',   n:22, texto:'¿Qué fue lo que más le agradó de la atención?', tipo:'textarea', obl:false },
      { id:'q23_mejorar',  n:23, texto:'¿Qué considera que debemos mejorar?', tipo:'textarea', obl:false },
      { id:'q24_adicional',n:24, texto:'¿Desea compartir algún comentario o sugerencia adicional?', tipo:'textarea', obl:false },
      { id:'q25_seguimiento', n:25, texto:'¿Desea que personal del hospital se comunique con usted para dar seguimiento?', tipo:'opcion', obl:true, opciones:['Sí','No'] },
    ]},
  { titulo:'Datos para seguimiento', soloSi:{ id:'q25_seguimiento', val:'Sí' },
    preguntas:[
      { id:'q26_contacto', n:26, texto:'Para dar seguimiento, indique un teléfono o correo electrónico.', tipo:'texto', obl:true, ph:'Teléfono o correo' },
    ]},
]

let _ans  = {}   // respuestas por id
let _sec  = 0    // sección actual
let _sending = false

const $ = id => document.getElementById(id)
const esc = s => String(s == null ? '' : s).replace(/[&<>"]/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]))

// ── Navegación de pantallas ───────────────────────────────────────
function showScreen(id) {
  document.querySelectorAll('.screen').forEach(s => s.style.display = 'none')
  $(id).style.display = 'block'
  window.scrollTo(0, 0)
}
function goHome()      { showScreen('screen-home') }
function startSurvey() { _ans = {}; _sec = 0; showScreen('screen-survey'); renderSection() }
function startQueja()  { showScreen('screen-queja') }

// ¿Se debe mostrar esta sección según respuestas previas?
function seccionAplica(i) {
  const s = SURVEY[i]
  if (!s || !s.soloSi) return !!s
  return _ans[s.soloSi.id] === s.soloSi.val
}
function siguienteSeccion(desde) {
  for (let i = desde + 1; i < SURVEY.length; i++) if (seccionAplica(i)) return i
  return -1   // no hay más → enviar
}

// ── Render de una sección ─────────────────────────────────────────
function renderSection() {
  const s = SURVEY[_sec]
  const total = SURVEY.filter((x, i) => seccionAplica(i)).length
  const idxVis = SURVEY.slice(0, _sec + 1).filter((x, i) => seccionAplica(i)).length
  const pct = Math.round((idxVis / total) * 100)

  let html = `<div class="prog"><div class="prog-bar" style="width:${pct}%"></div></div>
    <div class="prog-txt">Sección ${idxVis} de ${total}</div>
    <h2 class="sec-ttl">${esc(s.titulo)}</h2>`
  if (s.intro) html += `<p class="sec-intro">${esc(s.intro)}</p>`
  if (s.desc)  html += `<p class="sec-desc">${esc(s.desc)}</p>`

  s.preguntas.forEach(q => { html += preguntaHtml(q) })

  const esUltima = siguienteSeccion(_sec) === -1
  html += `<div class="nav">
    ${_sec > 0 ? `<button class="btn-sec" onclick="prevSection()">← Anterior</button>` : '<span></span>'}
    <button class="btn-pri" onclick="nextSection()">${esUltima ? 'Enviar encuesta' : 'Siguiente →'}</button>
  </div>`

  $('survey-body').innerHTML = html
}

function preguntaHtml(q) {
  const val = _ans[q.id]
  let campo = ''
  if (q.tipo === 'esc' || q.tipo === 'opcion') {
    const opts = q.tipo === 'esc' ? Object.keys(q.esc) : q.opciones
    campo = `<div class="opts">` + opts.map(o =>
      `<button type="button" class="opt${val === o ? ' on' : ''}" onclick="setAns('${q.id}', this)" data-v="${esc(o)}">${esc(o)}</button>`
    ).join('') + `</div>`
  } else if (q.tipo === 'nps') {
    campo = `<div class="nps">` + Array.from({length:11}, (_,i) =>
      `<button type="button" class="npsb${val === String(i) ? ' on' : ''}" onclick="setAns('${q.id}', this)" data-v="${i}">${i}</button>`
    ).join('') + `</div><div class="nps-lbl"><span>0 · Nada probable</span><span>10 · Totalmente probable</span></div>`
  } else if (q.tipo === 'textarea') {
    campo = `<textarea class="ta" oninput="_ans['${q.id}']=this.value" placeholder="Opcional…">${esc(val || '')}</textarea>`
  } else { // texto
    campo = `<input class="inp" value="${esc(val || '')}" oninput="_ans['${q.id}']=this.value" placeholder="${esc(q.ph || '')}">`
  }
  return `<div class="q" data-q="${q.id}">
    <div class="q-t">${q.obl ? '<span class="req">*</span>' : ''}${esc(q.texto)}</div>
    ${campo}
    <div class="q-err" id="err-${q.id}"></div>
  </div>`
}

function setAns(id, btn) {
  _ans[id] = btn.dataset.v
  const cont = btn.parentElement
  cont.querySelectorAll('button').forEach(b => b.classList.remove('on'))
  btn.classList.add('on')
  const err = $('err-' + id); if (err) err.textContent = ''
}

function validarSeccion() {
  let ok = true
  SURVEY[_sec].preguntas.forEach(q => {
    const err = $('err-' + q.id)
    if (err) err.textContent = ''
    if (q.obl) {
      const v = _ans[q.id]
      const vacio = v == null || String(v).trim() === ''
      if (vacio) { ok = false; if (err) err.textContent = 'Esta pregunta es obligatoria.' }
    }
  })
  if (!ok) {
    const first = $('survey-body').querySelector('.q-err:not(:empty)')
    if (first) first.scrollIntoView({ behavior:'smooth', block:'center' })
  }
  return ok
}

function prevSection() {
  for (let i = _sec - 1; i >= 0; i--) if (seccionAplica(i)) { _sec = i; renderSection(); return }
}
function nextSection() {
  if (!validarSeccion()) return
  const next = siguienteSeccion(_sec)
  if (next === -1) { enviarEncuesta(); return }
  _sec = next
  renderSection()
}

// ── Construcción del registro para satisfaction_surveys ───────────
function buildSurveyPayload() {
  const a = _ans
  const num = id => {                       // escala → 1..5 (o null)
    const q = findQ(id); if (!q || !q.esc) return null
    return a[id] != null ? q.esc[a[id]] : null
  }
  // Comentarios → bloques para el panel (positivo/negativo)
  const comments = []
  const push = (text, type, cat) => { if (text && text.trim()) comments.push({ type, category: cat || null, text: text.trim() }) }
  push(a.q22_agrado,    'POSITIVO', 'Felicitación')
  push(a.q23_mejorar,   'NEGATIVO', a.q19_oportunidad || null)
  push(a.q20_describa,  'NEGATIVO', a.q19_oportunidad || null)
  push(a.q24_adicional, null, null)
  const primary = comments[0] || null

  const nps = a.nps != null ? parseInt(a.nps, 10) : null

  return {
    survey_date:  new Date().toISOString().slice(0, 10),
    room_number:  a.habitacion || null,
    area:         areaDeHabitacion(a.habitacion),
    language:     'es',
    is_active:    true,
    // Métricas (las que usa el panel)
    q_tramites_ingreso:   num('q_tramites_ingreso'),
    q_info_normas:        num('q_info_normas'),
    q_tiempo_espera:      num('q_tiempo_espera'),
    q_atencion_enfermeria:num('q_atencion_enfermeria'),
    q_atencion_medico:    num('q_atencion_medico'),
    q_privacidad:         num('q_privacidad'),
    q_higiene:            num('q_higiene'),
    q_vigilancia:         num('q_vigilancia'),
    q_alimentos:          num('q_alimentos'),
    q_tramites_egreso:    num('q_tramites_egreso'),
    q_servicio_general:   num('q_servicio_general'),
    would_recommend:      nps != null ? nps >= 9 : null,
    // Comentarios
    comment_type:     primary ? primary.type : null,
    comment_category: primary ? primary.category : null,
    comments:         primary ? primary.text : null,
    comments_detail:  comments.length ? comments : null,
    // Detalle completo (todas las respuestas del paciente)
    respuestas_paciente: { ...a, nps },
  }
}
function findQ(id) {
  for (const s of SURVEY) { const q = s.preguntas.find(p => p.id === id); if (q) return q }
  return null
}

async function enviarEncuesta() {
  if (_sending) return
  _sending = true
  const payload = buildSurveyPayload()
  const { error } = await db.from('satisfaction_surveys').insert(payload)
  _sending = false
  if (error) { alert('No se pudo enviar. Intente de nuevo.\n\n' + error.message); return }
  showScreen('screen-gracias')
}

// ── Quejas / Sugerencias / Felicitaciones ─────────────────────────
function setTipoQueja(btn) {
  document.querySelectorAll('#qz-tipos .opt').forEach(b => b.classList.remove('on'))
  btn.classList.add('on')
  $('qz-tipo').value = btn.dataset.v
  $('qz-tipo-err').textContent = ''
}
function folioWeb() {
  const d = new Date(), p = n => String(n).padStart(2, '0')
  return `WEB-${String(d.getFullYear()).slice(2)}${p(d.getMonth()+1)}${p(d.getDate())}-${p(d.getHours())}${p(d.getMinutes())}${p(d.getSeconds())}`
}
async function enviarQueja() {
  if (_sending) return
  const tipo = $('qz-tipo').value
  const desc = $('qz-desc').value.trim()
  let ok = true
  $('qz-tipo-err').textContent = ''; $('qz-desc-err').textContent = ''
  if (!tipo) { ok = false; $('qz-tipo-err').textContent = 'Elige una opción.' }
  if (!desc) { ok = false; $('qz-desc-err').textContent = 'Por favor escribe tu mensaje.' }
  if (!ok) return

  _sending = true
  const hab = $('qz-hab').value.trim()
  const payload = {
    fecha:          new Date().toISOString().slice(0, 10),
    folio:          folioWeb(),
    tipo,
    descripcion:    desc,
    nombre_paciente:$('qz-nombre').value.trim() || null,
    nombre_presenta:$('qz-nombre').value.trim() || null,
    habitacion:     hab || null,
    departamento:   areaDeHabitacion(hab),
    telefono:       $('qz-tel').value.trim() || null,
    email:          $('qz-email').value.trim() || null,
    origen:         'web',
    status:         'pendiente',
    sincronizado:   false,
  }
  const { error } = await db.from('quejas').insert(payload)
  _sending = false
  if (error) { alert('No se pudo enviar. Intente de nuevo.\n\n' + error.message); return }
  $('gracias-qz-txt').style.display = 'block'
  showScreen('screen-gracias')
}

document.addEventListener('DOMContentLoaded', goHome)
