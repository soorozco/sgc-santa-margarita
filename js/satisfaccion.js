// ─── Satisfacción de Pacientes — Cláusula 9.1.2 ──────────────

let _user    = null
let _profile = null
let _role    = null
let _surveys = []      // all loaded
let _filtered= []      // after filters
let _page    = 1
const PAGE_SIZE = 20
let _chartTrend = null
let _ctype   = ''      // current comment type selection in new form

// ── Rating map ────────────────────────────────────────────────
const RATING = { 'Excelente':5, 'Bueno':4, 'Regular':3, 'Malo':2, 'Pésimo':1 }
const RATING_LABEL = { 5:'Excelente', 4:'Bueno', 3:'Regular', 2:'Malo', 1:'Pésimo' }

// ── Questions config ──────────────────────────────────────────
const QUESTIONS = [
  { key:'q_tramites_ingreso',   label:'Trámites de ingreso' },
  { key:'q_info_normas',        label:'Información sobre normas del hospital' },
  { key:'q_tiempo_espera',      label:'Tiempo de espera para atención' },
  { key:'q_atencion_enfermeria',label:'Atención y cuidados de enfermería' },
  { key:'q_atencion_medico',    label:'Atención del personal médico' },
  { key:'q_privacidad',         label:'Confidencialidad y privacidad' },
  { key:'q_higiene',            label:'Higiene y limpieza del hospital' },
  { key:'q_vigilancia',         label:'Vigilancia interna del hospital' },
  { key:'q_alimentos',          label:'Calidad de los alimentos' },
  { key:'q_servicio_general',   label:'Servicio general durante la estadía' },
  { key:'q_tramites_egreso',    label:'Trámites de egreso (alta)' },
]

const METRIC_KEY = {
  general:    'q_servicio_general',
  enfermeria: 'q_atencion_enfermeria',
  medico:     'q_atencion_medico',
  alimentos:  'q_alimentos',
  higiene:    'q_higiene',
}

// ── Init ──────────────────────────────────────────────────────
async function initSat() {
  try {
    const auth = await requireAuth()
    if (!auth) return
    _user    = auth.user
    _profile = auth.profile
    _role    = auth.profile?.roles?.name || 'lector'
    setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
    setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
    const el = document.getElementById('current-date')
    if (el) el.textContent = new Date().toLocaleDateString('es-MX',
      { weekday:'long', day:'numeric', month:'long', year:'numeric' })

    // Show "Nueva Encuesta" only to writers
    const canWrite = ['administrador','responsable_calidad','editor'].includes(_role)
    const btn = document.getElementById('btn-new-enc')
    if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'

    buildRatingQuestions()
    setTodayDate()
    await loadSurveys()
  } catch (err) {
    console.error('[SAT] initSat error:', err)
  }
}

// ── Load all surveys from Supabase ────────────────────────────
async function loadSurveys() {
  showTableLoading()
  const { data, error } = await db
    .from('satisfaction_surveys')
    .select('*')
    .order('survey_date', { ascending: false })
    .limit(2000)

  if (error) { showTableError(error.message); return }
  _surveys = data || []
  buildAreaFilter()
  buildMonthFilter()
  applyFilters()
  renderKPIs()
  renderScoresPanel()
  updateChart()
  renderComments()
}

// ── Filters ───────────────────────────────────────────────────
function applyFilters() {
  const q     = (document.getElementById('search-input')?.value || '').toLowerCase().trim()
  const area  = document.getElementById('f-area')?.value  || ''
  const month = document.getElementById('f-month')?.value || ''
  const rec   = document.getElementById('f-rec')?.value   || ''
  const ctype = document.getElementById('f-ctype')?.value || ''

  _filtered = _surveys.filter(s => {
    if (area && s.area !== area) return false
    if (rec  && s.would_recommend !== (rec === 'SI')) return false
    if (ctype && (s.comment_type || '').toUpperCase() !== ctype) return false
    if (month) {
      const ym = (s.survey_date || '').substring(0,7)
      if (ym !== month) return false
    }
    if (q) {
      const txt = [s.patient_name, s.doctor_name, s.room_number, s.area, s.comments]
        .filter(Boolean).join(' ').toLowerCase()
      if (!txt.includes(q)) return false
    }
    return true
  })

  _page = 1
  renderTable()
  document.getElementById('enc-count').textContent =
    _filtered.length + ' encuesta' + (_filtered.length !== 1 ? 's' : '') + ' encontrada' + (_filtered.length !== 1 ? 's' : '')
}

// ── KPIs ──────────────────────────────────────────────────────
function renderKPIs() {
  const n = _surveys.length
  document.getElementById('kpi-total').textContent = n
  document.getElementById('kpi-total-sub').textContent = 'encuestas registradas'

  // Overall satisfaction = avg of q_servicio_general
  const vals = _surveys.map(s => s.q_servicio_general).filter(v => v != null && v > 0)
  const avg  = vals.length ? (vals.reduce((a,b)=>a+b,0)/vals.length) : 0
  document.getElementById('kpi-sat').innerHTML =
    avg.toFixed(2) + '<span class="kpi-unit"> / 5</span>'

  // Recommend %
  const recYes = _surveys.filter(s => s.would_recommend === true).length
  const recPct = n ? Math.round((recYes/n)*100) : 0
  document.getElementById('kpi-rec').innerHTML =
    recPct + '<span class="kpi-unit">%</span>'
  document.getElementById('kpi-rec-sub').textContent = recYes + ' de ' + n + ' pacientes'

  // Quejas & sugerencias
  const quejas = _surveys.filter(s => (s.comment_type||'').toUpperCase() === 'QUEJA').length
  const sugs   = _surveys.filter(s => (s.comment_type||'').toUpperCase() === 'SUGERENCIA').length
  document.getElementById('kpi-quejas').textContent = quejas
  document.getElementById('kpi-sug').textContent    = sugs
}

// ── Scores panel (dimension bars) ────────────────────────────
function renderScoresPanel() {
  const panel = document.getElementById('scores-panel')
  if (!panel) return

  const rows = QUESTIONS.map(q => {
    const vals = _surveys.map(s => s[q.key]).filter(v => v != null && v > 0)
    const avg  = vals.length ? vals.reduce((a,b)=>a+b,0)/vals.length : 0
    const pct  = (avg/5)*100
    const cls  = pct >= 80 ? 'green' : pct >= 60 ? 'orange' : 'blue'
    return `
    <div class="score-row">
      <div class="score-lbl" title="${esc(q.label)}">${esc(q.label)}</div>
      <div class="score-bar-wrap">
        <div class="score-bar-fill ${cls}" style="width:${pct.toFixed(1)}%"></div>
      </div>
      <div class="score-pct">${avg > 0 ? avg.toFixed(1) : '—'}</div>
    </div>`
  }).join('')

  panel.innerHTML = rows
}

// ── Trend chart ───────────────────────────────────────────────
function updateChart() {
  const metric  = document.getElementById('chart-metric')?.value || 'general'
  const colKey  = METRIC_KEY[metric] || 'q_servicio_general'

  // Group by YYYY-MM
  const byMonth = {}
  _surveys.forEach(s => {
    const ym = (s.survey_date||'').substring(0,7)
    if (!ym) return
    if (!byMonth[ym]) byMonth[ym] = []
    if (s[colKey] != null && s[colKey] > 0) byMonth[ym].push(s[colKey])
  })

  const labels = Object.keys(byMonth).sort()
  const avgs   = labels.map(ym => {
    const arr = byMonth[ym]
    return arr.length ? parseFloat((arr.reduce((a,b)=>a+b,0)/arr.length).toFixed(2)) : null
  })
  const counts = labels.map(ym => byMonth[ym].length)

  const fmtLabel = ym => {
    const [y,m] = ym.split('-')
    const months = ['','Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic']
    return months[parseInt(m)] + ' ' + y.slice(2)
  }

  if (_chartTrend) _chartTrend.destroy()
  const ctx = document.getElementById('chart-trend')
  if (!ctx) return

  _chartTrend = new Chart(ctx, {
    type:'line',
    data:{
      labels: labels.map(fmtLabel),
      datasets:[{
        label:'Promedio',
        data: avgs,
        borderColor:'#2563eb',
        backgroundColor:'rgba(37,99,235,.08)',
        borderWidth:2.5,
        pointRadius:4,
        pointBackgroundColor:'#2563eb',
        tension:.3,
        fill:true
      },{
        label:'Encuestas',
        data: counts,
        borderColor:'#94a3b8',
        backgroundColor:'transparent',
        borderWidth:1.5,
        borderDash:[4,3],
        pointRadius:3,
        tension:.3,
        yAxisID:'y2'
      }]
    },
    options:{
      responsive:true, maintainAspectRatio:false,
      plugins:{ legend:{ display:true, position:'top',
        labels:{ font:{size:11}, boxWidth:12 } },
        tooltip:{ callbacks:{ label: ctx => ctx.datasetIndex===0
          ? ' Promedio: ' + ctx.parsed.y : ' Encuestas: ' + ctx.parsed.y }
        }
      },
      scales:{
        y:{ min:1, max:5, ticks:{ stepSize:.5, font:{size:11} },
            grid:{ color:'rgba(0,0,0,.05)' } },
        y2:{ position:'right', grid:{display:false},
             ticks:{ font:{size:10}, color:'#94a3b8' } },
        x: { ticks:{ font:{size:11} }, grid:{color:'rgba(0,0,0,.04)'} }
      }
    }
  })
}

// ── Comments panel ────────────────────────────────────────────
function renderComments() {
  const ctype = document.getElementById('f-ctype')?.value || ''
  let pool = _surveys.filter(s => s.comments && s.comments.trim())
  if (ctype) pool = pool.filter(s => (s.comment_type||'').toUpperCase() === ctype)
  pool = pool.slice(0,12)

  const list = document.getElementById('comment-list')
  if (!list) return

  if (pool.length === 0) {
    list.innerHTML = '<div style="text-align:center;color:var(--txt3);padding:20px">Sin comentarios para mostrar</div>'
    return
  }

  list.innerHTML = pool.map(s => {
    const ct   = (s.comment_type||'').toUpperCase()
    const cls  = ct==='QUEJA'?'queja': ct==='SUGERENCIA'?'sugerencia': ct==='FELICITACION'?'felicitacion':''
    const bcls = ct==='QUEJA'?'badge-queja': ct==='SUGERENCIA'?'badge-sugerencia': ct==='FELICITACION'?'badge-felicitacion':'badge-categoria'
    const icon = ct==='QUEJA'?'🔴': ct==='SUGERENCIA'?'🟡': ct==='FELICITACION'?'🟢':'💬'
    return `
    <div class="comment-card ${cls}">
      <div class="comment-head">
        ${ct ? `<span class="comment-badge ${bcls}">${icon} ${ct}</span>` : ''}
        ${s.comment_category ? `<span class="badge-categoria">${esc(s.comment_category)}</span>` : ''}
        <span class="comment-patient">${esc(s.patient_name||'Anónimo')}</span>
        ${s.room_number ? `<span class="comment-room">· ${esc(s.room_number)}</span>` : ''}
        <span class="comment-meta">${fmtDate(s.survey_date)}</span>
      </div>
      <div class="comment-txt">${esc(s.comments)}</div>
      ${s.area ? `<div class="comment-area"><i class="fa-solid fa-location-dot"></i> ${esc(s.area)}</div>` : ''}
    </div>`
  }).join('')
}

// ── Table ─────────────────────────────────────────────────────
function renderTable() {
  const tbody = document.getElementById('enc-tbody')
  const start = (_page - 1) * PAGE_SIZE
  const page  = _filtered.slice(start, start + PAGE_SIZE)

  if (_filtered.length === 0) {
    tbody.innerHTML = `<tr><td colspan="9" class="table-empty">
      <i class="fa-solid fa-face-sad-tear"></i>
      <strong>Sin encuestas</strong>Sin resultados para los filtros seleccionados.</td></tr>`
    renderPagination()
    return
  }

  tbody.innerHTML = page.map(s => {
    const enf = s.q_atencion_enfermeria
    const med = s.q_atencion_medico
    const gen = s.q_servicio_general
    const ct  = (s.comment_type||'').toUpperCase()
    const rec = s.would_recommend
    return `
    <tr style="cursor:pointer" onclick="openDetail('${s.id}')">
      <td style="white-space:nowrap">${fmtDate(s.survey_date)}</td>
      <td>
        <div class="patient-name">${esc(s.patient_name||'Anónimo')}</div>
        <div class="patient-meta">${esc(s.doctor_name||'—')} · ${esc(s.room_number||'—')}</div>
      </td>
      <td><span class="area-badge">${esc(areaShort(s.area))}</span></td>
      <td class="center">${ratingBadge(enf)}</td>
      <td class="center">${ratingBadge(med)}</td>
      <td class="center">${ratingBadge(gen)}</td>
      <td class="center">${rec===true?'<span class="recommend-yes">✅ Sí</span>':rec===false?'<span class="recommend-no">❌ No</span>':'—'}</td>
      <td>${ct ? `<span class="comment-badge ${ct==='QUEJA'?'badge-queja':ct==='SUGERENCIA'?'badge-sugerencia':'badge-felicitacion'}">${ct}</span>` : '—'}</td>
      <td class="center">
        <button class="btn-action" onclick="event.stopPropagation();openDetail('${s.id}')" title="Ver detalle">
          <i class="fa-solid fa-eye"></i>
        </button>
      </td>
    </tr>`
  }).join('')

  renderPagination()
}

function ratingBadge(v) {
  if (!v) return '<span style="color:var(--txt3)">—</span>'
  const cls = v>=5?'rating-5':v>=4?'rating-4':v>=3?'rating-3':v>=2?'rating-2':'rating-1'
  return `<span class="rating-badge ${cls}">${v}</span>`
}

function areaShort(area) {
  if (!area) return '—'
  return area.replace('Central ','').replace('Unidad de Terapia Intensiva','UTI')
}

function renderPagination() {
  const pag  = document.getElementById('pagination')
  const pages = Math.ceil(_filtered.length / PAGE_SIZE)
  if (pages <= 1) { pag.innerHTML=''; return }
  let html = ''
  if (_page > 1) html += `<button class="page-btn" onclick="goPage(${_page-1})"><i class="fa-solid fa-chevron-left"></i></button>`
  const start = Math.max(1, _page-2)
  const end   = Math.min(pages, _page+2)
  if (start > 1) html += `<button class="page-btn" onclick="goPage(1)">1</button>${start>2?'<span style="padding:0 4px;color:var(--txt3)">…</span>':''}`
  for (let i=start;i<=end;i++)
    html += `<button class="page-btn${i===_page?' active':''}" onclick="goPage(${i})">${i}</button>`
  if (end < pages) html += `${end<pages-1?'<span style="padding:0 4px;color:var(--txt3)">…</span>':''}<button class="page-btn" onclick="goPage(${pages})">${pages}</button>`
  if (_page < pages) html += `<button class="page-btn" onclick="goPage(${_page+1})"><i class="fa-solid fa-chevron-right"></i></button>`
  pag.innerHTML = html
}

function goPage(p) { _page = p; renderTable(); window.scrollTo(0,0) }

// ── Detail modal ──────────────────────────────────────────────
function openDetail(id) {
  const s = _surveys.find(x => x.id === id)
  if (!s) return

  setText('d-patient-name', s.patient_name || 'Paciente anónimo')
  document.getElementById('d-survey-meta').textContent =
    fmtDate(s.survey_date) + (s.area ? ' · ' + s.area : '') + (s.room_number ? ' · Hab. ' + s.room_number : '')

  // Scores grid
  const grid = document.getElementById('d-scores-grid')
  grid.innerHTML = QUESTIONS.map(q => {
    const val = s[q.key]
    const lbl = val ? RATING_LABEL[val] || val : '—'
    const cls = val>=5?'rating-5':val>=4?'rating-4':val>=3?'rating-3':val>=2?'rating-2':val>=1?'rating-1':''
    return `
    <div class="ds-item">
      <div class="ds-lbl">${esc(q.label)}</div>
      <div class="ds-val"><span class="rating-badge ${cls}" style="font-size:.786rem">${val?val+' — '+lbl:'—'}</span></div>
    </div>`
  }).join('')

  // Recommend
  const recEl = document.getElementById('d-recommend')
  recEl.innerHTML = s.would_recommend===true
    ? '<span class="recommend-yes"><i class="fa-solid fa-check-circle"></i> Sí regresaría o recomendaría el hospital</span>'
    : s.would_recommend===false
      ? '<span class="recommend-no"><i class="fa-solid fa-circle-xmark"></i> No regresaría ni recomendaría</span>'
      : '—'

  // Comment
  const cb = document.getElementById('d-comment-block')
  if (s.comments && s.comments.trim()) {
    cb.style.display = 'block'
    const ct   = (s.comment_type||'').toUpperCase()
    const bcls = ct==='QUEJA'?'badge-queja': ct==='SUGERENCIA'?'badge-sugerencia': ct==='FELICITACION'?'badge-felicitacion':''
    const card = document.getElementById('d-comment-card')
    card.className = 'comment-card ' + (ct==='QUEJA'?'queja': ct==='SUGERENCIA'?'sugerencia': ct==='FELICITACION'?'felicitacion':'')
    document.getElementById('d-comment-head').innerHTML =
      (ct ? `<span class="comment-badge ${bcls}">${ct}</span>` : '') +
      (s.comment_category ? `<span class="badge-categoria">${esc(s.comment_category)}</span>` : '')
    document.getElementById('d-comment-txt').textContent = s.comments
  } else {
    cb.style.display = 'none'
  }

  // Info tab
  setText('d-patient', s.patient_name||'—')
  setText('d-room',    s.room_number||'—')
  setText('d-doctor',  s.doctor_name||'—')
  setText('d-area',    s.area||'—')
  setText('d-date',    fmtDate(s.survey_date))
  setText('d-id',      s.external_id || s.id)

  // Reset to first tab
  document.querySelectorAll('#modal-detail .tab-btn').forEach((b,i) => b.classList.toggle('active',i===0))
  document.querySelectorAll('#modal-detail .tab-panel').forEach((p,i) => p.classList.toggle('active',i===0))

  openModal('modal-detail')
}

// ── New survey form ───────────────────────────────────────────
function buildRatingQuestions() {
  const OPTS = ['Excelente','Bueno','Regular','Malo','Pésimo']
  const container = document.getElementById('rating-questions')
  if (!container) return
  container.innerHTML = QUESTIONS.map(q => `
    <div class="rating-q-row">
      <div class="rating-q-lbl">${esc(q.label)}</div>
      <div class="rating-options">
        ${OPTS.map((o,i) => {
          const val = 5 - i
          return `<div class="rating-opt opt-${val}">
            <input type="radio" name="${q.key}" id="${q.key}_${val}" value="${val}">
            <label for="${q.key}_${val}" title="${o}">${o.charAt(0)}</label>
          </div>`
        }).join('')}
      </div>
    </div>`).join('')
}

function setTodayDate() {
  const el = document.getElementById('n-date')
  if (el) el.value = new Date().toISOString().split('T')[0]
}

function setCtype(type) {
  _ctype = type
  const btns = document.querySelectorAll('#ctype-row .ctype-btn')
  btns.forEach(b => {
    b.className = 'ctype-btn'
    if (type && b.textContent.toUpperCase().includes(type)) {
      b.classList.add('active-' + type.toLowerCase())
    } else if (!type && b.textContent.includes('Sin')) {
      b.style.fontWeight = '700'
    }
  })
  document.getElementById('ctype-detail').style.display = type ? 'block' : 'none'
}

function openNewSurvey() {
  // Reset form
  QUESTIONS.forEach(q => { document.querySelectorAll(`[name="${q.key}"]`).forEach(r => r.checked=false) })
  document.getElementById('n-patient').value  = ''
  document.getElementById('n-room').value     = ''
  document.getElementById('n-doctor').value   = ''
  document.getElementById('n-area').value     = ''
  document.getElementById('n-comment').value  = ''
  document.getElementById('n-cat').value      = ''
  const rec = document.querySelector('[name="n-rec"][value="SI"]')
  if (rec) rec.checked = true
  setCtype('')
  setTodayDate()
  openModal('modal-new')
}

async function submitNewSurvey() {
  const area = document.getElementById('n-area')?.value
  const date = document.getElementById('n-date')?.value
  if (!area) { showToast('El área/servicio es obligatoria.','red'); return }
  if (!date) { showToast('La fecha es obligatoria.','red'); return }

  const payload = {
    patient_name:  document.getElementById('n-patient')?.value.trim() || null,
    room_number:   document.getElementById('n-room')?.value.trim()    || null,
    doctor_name:   document.getElementById('n-doctor')?.value.trim()  || null,
    area,
    survey_date:   date,
    would_recommend: document.querySelector('[name="n-rec"]:checked')?.value === 'SI',
    comment_type:    _ctype || null,
    comment_category: _ctype ? (document.getElementById('n-cat')?.value || null) : null,
    comments:      document.getElementById('n-comment')?.value.trim() || null,
    created_by:    _user.id
  }

  QUESTIONS.forEach(q => {
    const checked = document.querySelector(`[name="${q.key}"]:checked`)
    payload[q.key] = checked ? parseInt(checked.value) : null
  })

  const btn = document.getElementById('btn-save-new')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const { error } = await db.from('satisfaction_surveys').insert(payload)
  if (error) {
    showToast('Error: ' + error.message, 'red')
    btn.disabled = false
    btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar Encuesta'
    return
  }

  showToast('Encuesta guardada correctamente.', 'green')
  closeModal('modal-new')
  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar Encuesta'
  await loadSurveys()
}

// ── Export CSV ────────────────────────────────────────────────
function exportCSV() {
  const cols = ['survey_date','patient_name','room_number','doctor_name','area',
    ...QUESTIONS.map(q=>q.key),'would_recommend','comment_type','comment_category','comments']
  const header = ['Fecha','Paciente','Habitación','Médico','Área',
    ...QUESTIONS.map(q=>q.label),'Recomendaría','Tipo Comentario','Categoría','Comentarios']
  const rows = [header, ..._filtered.map(s =>
    cols.map(c => {
      const v = s[c]
      if (v === true) return 'SI'
      if (v === false) return 'NO'
      if (typeof v === 'string' && v.includes(',')) return '"' + v.replace(/"/g,'""') + '"'
      return v ?? ''
    })
  )]
  const csv  = rows.map(r => r.join(',')).join('\n')
  const blob = new Blob(['\uFEFF'+csv], {type:'text/csv;charset=utf-8'})
  const url  = URL.createObjectURL(blob)
  const a    = Object.assign(document.createElement('a'), {href:url, download:'encuestas_satisfaccion.csv'})
  a.click(); URL.revokeObjectURL(url)
}

// ── Filters init ──────────────────────────────────────────────
function buildAreaFilter() {
  const areas = [...new Set(_surveys.map(s=>s.area).filter(Boolean))].sort()
  const sel = document.getElementById('f-area')
  if (!sel) return
  const cur = sel.value
  sel.innerHTML = '<option value="">Todas las áreas</option>' +
    areas.map(a=>`<option value="${esc(a)}"${a===cur?' selected':''}>${esc(a)}</option>`).join('')
}

function buildMonthFilter() {
  const months = [...new Set(_surveys.map(s=>(s.survey_date||'').substring(0,7)).filter(Boolean))].sort().reverse()
  const sel = document.getElementById('f-month')
  if (!sel) return
  const fmtM = ym => { const [y,m]=ym.split('-'); const ms=['','Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']; return ms[parseInt(m)]+' '+y }
  sel.innerHTML = '<option value="">Todos los meses</option>' +
    months.map(ym=>`<option value="${ym}">${fmtM(ym)}</option>`).join('')
}

// ── Helpers ───────────────────────────────────────────────────
function showTableLoading() {
  document.getElementById('enc-tbody').innerHTML =
    `<tr><td colspan="9" class="table-empty"><i class="fa-solid fa-spinner fa-spin"></i><strong>Cargando…</strong></td></tr>`
}
function showTableError(msg) {
  document.getElementById('enc-tbody').innerHTML =
    `<tr><td colspan="9" class="table-empty"><i class="fa-solid fa-triangle-exclamation"></i><strong>Error al cargar</strong>${esc(msg)}</td></tr>`
}
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }
function switchTab(panelId, btn) {
  const modal = btn.closest('.modal, .layout')
  modal.querySelectorAll('.tab-btn').forEach(b=>b.classList.remove('active'))
  modal.querySelectorAll('.tab-panel').forEach(p=>p.classList.remove('active'))
  btn.classList.add('active')
  document.getElementById(panelId)?.classList.add('active')
}
function fmtDate(d) {
  if (!d) return '—'
  return new Date(d+'T12:00:00').toLocaleDateString('es-MX',{day:'2-digit',month:'short',year:'numeric'})
}
function setText(id, val) { const el=document.getElementById(id); if(el) el.textContent=val??'—' }
function esc(s) {
  if (!s) return ''
  return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}
function showToast(msg, color='green') {
  const old=document.getElementById('sgc-toast'); if(old) old.remove()
  const bg=color==='green'?'#16a34a':color==='red'?'#dc2626':'#2563eb'
  const t=document.createElement('div')
  t.id='sgc-toast'
  t.style.cssText=`position:fixed;bottom:28px;right:28px;z-index:9999;background:${bg};color:#fff;
    padding:13px 22px;border-radius:12px;font-size:.857rem;font-weight:600;font-family:var(--font);
    box-shadow:0 8px 28px rgba(0,0,0,.22);max-width:380px;line-height:1.4;`
  t.textContent=msg; document.body.appendChild(t)
  setTimeout(()=>t.remove(),3800)
}

// Close modal on overlay click
document.querySelectorAll('.modal-overlay').forEach(overlay => {
  overlay.addEventListener('click', e => { if (e.target===overlay) overlay.classList.remove('open') })
})

initSat()
