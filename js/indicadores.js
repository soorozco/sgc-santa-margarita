// ─── Indicadores de Calidad — Cláusula 9.1 ────────────────────

let _user        = null
let _profile     = null
let _role        = null
let _allInd      = []
let _depts       = []
let _currentInd  = null
let _measurements= []
let _miniChart   = null

// ── Init ────────────────────────────────────────────────────────
async function initIndicadores() {
  try {
    const auth = await requireAuth()
    if (!auth) return
    _user    = auth.user
    _profile = auth.profile
    _role    = auth.profile?.roles?.name || 'lector'

    renderUserInfo()
    setCurrentDate()
    await loadDepts()
    populateDeptFilter()
    await loadIndicadores()
    setupFilters()
    applyRoleUI()
  } catch (err) {
    console.error('[SGC] initIndicadores error:', err)
  }
}

function renderUserInfo() {
  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
}
function setCurrentDate() {
  const el = document.getElementById('current-date')
  if (el) el.textContent = new Date().toLocaleDateString('es-MX',
    { weekday:'long', day:'numeric', month:'long', year:'numeric' })
}

// ── Catálogos ───────────────────────────────────────────────────
async function loadDepts() {
  const { data } = await db.from('departments')
    .select('id,code,name').eq('is_active', true).order('name')
  _depts = data || []
}
function populateDeptFilter() {
  const opts = _depts.map(d => '<option value="' + d.id + '">' + esc(d.name) + '</option>').join('')
  const fDept   = document.getElementById('f-dept')
  const newDept = document.getElementById('new-dept')
  if (fDept)   fDept.innerHTML   = '<option value="">Todos los procesos</option>' + opts
  if (newDept) newDept.innerHTML = '<option value="">— General —</option>' + opts
}
function applyRoleUI() {
  const canWrite = ['administrador','responsable_calidad'].includes(_role)
  const btn = document.getElementById('btn-new-ind')
  if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'
}

// ── Auto-código ──────────────────────────────────────────────────
async function autoGenerateCode() {
  const { data } = await db.from('quality_indicators')
    .select('code').like('code', 'HSM-ID-%')
    .order('code', { ascending: false }).limit(50)
  let maxNum = 0
  if (data) {
    data.forEach(row => {
      if (row.code) {
        const m = row.code.match(/HSM-ID-(\d+)/)
        if (m) maxNum = Math.max(maxNum, parseInt(m[1]))
      }
    })
  }
  return 'HSM-ID-' + (maxNum + 1)
}

// ── Load indicadores ────────────────────────────────────────────
async function loadIndicadores() {
  showLoading()
  const { data, error } = await db
    .from('quality_indicators')
    .select('*, dept:responsible_department_id(id,name)')
    .order('code', { ascending: true })

  if (error) { showError(error.message); return }

  const ids = (data || []).map(i => i.id)
  let lastMap = {}

  if (ids.length > 0) {
    const { data: meas } = await db
      .from('indicator_measurements')
      .select('indicator_id, value, measurement_date')
      .in('indicator_id', ids)
      .order('measurement_date', { ascending: false })

    if (meas) {
      meas.forEach(m => {
        if (!lastMap[m.indicator_id]) lastMap[m.indicator_id] = m
      })
    }
  }

  _allInd = (data || []).map(ind => ({
    ...ind,
    _last: lastMap[ind.id] || null
  }))

  applyFilters()
}

// ── Semáforo ────────────────────────────────────────────────────
function getSemaforo(ind, value) {
  if (value === null || value === undefined) return 'sin-datos'
  const target = ind.target_value
  const min    = ind.min_acceptable
  const higher = ind.is_higher_better !== false
  if (target === null || target === undefined) return 'sin-datos'
  if (higher) {
    if (value >= target) return 'verde'
    if (min !== null && min !== undefined && value >= min) return 'amarillo'
    return 'rojo'
  } else {
    if (value <= target) return 'verde'
    if (min !== null && min !== undefined && value <= min) return 'amarillo'
    return 'rojo'
  }
}

function semaforoIcon(s) {
  return { verde:'fa-circle-check', amarillo:'fa-circle-exclamation',
           rojo:'fa-circle-xmark', 'sin-datos':'fa-circle-question' }[s] || 'fa-circle-question'
}

function originKey(origin) {
  const map = {
    'Financiero':'financiero','Operativo':'operativo','Calidad':'calidad',
    'Seguridad':'seguridad','Recursos Humanos':'rrhh','Satisfacción':'satisfaccion'
  }
  return map[origin] || 'other'
}

// ── Filters ─────────────────────────────────────────────────────
function setupFilters() {
  ['search-input','f-dept','f-origin','f-freq','f-semaforo'].forEach(id => {
    const el = document.getElementById(id)
    if (el) {
      el.addEventListener('input',  applyFilters)
      el.addEventListener('change', applyFilters)
    }
  })
}

function applyFilters() {
  const q       = (document.getElementById('search-input')?.value || '').toLowerCase()
  const dept    = document.getElementById('f-dept')?.value    || ''
  const origin  = document.getElementById('f-origin')?.value  || ''
  const freq    = document.getElementById('f-freq')?.value    || ''
  const semaforo= document.getElementById('f-semaforo')?.value|| ''

  const filtered = _allInd.filter(ind => {
    const lastVal = ind._last?.value ?? null
    const sem     = getSemaforo(ind, lastVal)
    const txt     = ((ind.name||'') + ' ' + (ind.code||'') + ' ' +
                     (ind.dept?.name||'') + ' ' +
                     (ind.responsible_position||'') + ' ' + (ind.origin||'')).toLowerCase()
    return (!q        || txt.includes(q))
        && (!dept     || ind.responsible_department_id === dept)
        && (!origin   || ind.origin === origin)
        && (!freq     || ind.measurement_frequency === freq)
        && (!semaforo || sem === semaforo)
        && (ind.is_active !== false)
  })
  renderGrid(filtered)
}

// ── Render cards ─────────────────────────────────────────────────
function renderGrid(inds) {
  const grid  = document.getElementById('ind-grid')
  const count = document.getElementById('ind-count')
  if (count) count.textContent =
    inds.length + ' indicador' + (inds.length !== 1 ? 'es' : '') +
    ' activo' + (inds.length !== 1 ? 's' : '')
  if (!grid) return

  if (inds.length === 0) {
    grid.innerHTML = '<div class="grid-empty"><i class="fa-solid fa-chart-line"></i>' +
      '<strong>Sin indicadores</strong>No hay indicadores que coincidan con los filtros.</div>'
    return
  }

  grid.innerHTML = inds.map(function(ind) {
    const lastVal = ind._last?.value ?? null
    const sem     = getSemaforo(ind, lastVal)
    const icon    = semaforoIcon(sem)
    const unit    = ind.unit || ''
    const freqLbl = freqLabel(ind.measurement_frequency)

    const codeBadge   = ind.code   ? '<span class="ind-code">'   + esc(ind.code)   + '</span>' : ''
    const originBadge = ind.origin ? '<span class="ind-origin-badge origin-' + originKey(ind.origin) + '">' + esc(ind.origin) + '</span>' : ''

    const resp = ind.responsible_position ? esc(ind.responsible_position) : '—'
    const dept = ind.dept?.name    ? esc(ind.dept.name)     : 'General'

    // Límites — texto o fallback numérico
    var limLow, limMid, limHigh
    if (ind.limit_low_text) {
      limLow = esc(ind.limit_low_text)
    } else if (ind.min_acceptable !== null && ind.min_acceptable !== undefined) {
      limLow = esc((ind.is_higher_better !== false ? '< ' : '> ') + ind.min_acceptable + unit)
    } else { limLow = 'NA' }

    limMid = ind.limit_mid_text ? esc(ind.limit_mid_text) : '—'

    if (ind.limit_high_text) {
      limHigh = esc(ind.limit_high_text)
    } else if (ind.target_value !== null && ind.target_value !== undefined) {
      limHigh = esc((ind.is_higher_better !== false ? '≥ ' : '≤ ') + ind.target_value + unit)
    } else { limHigh = 'NA' }

    // Valor actual
    var currentHtml
    if (lastVal !== null) {
      const unitStr = unit.length <= 3 ? unit : ''
      currentHtml = '<span class="ind-current ' + sem + '">' + lastVal + unitStr + '</span>'
      if (unit.length > 3) currentHtml += ' <span class="ind-unit">' + esc(unit) + '</span>'
    } else {
      currentHtml = '<span class="ind-current sin-datos">Sin datos</span>'
    }

    const dateStr = ind._last ? '· ' + fmtDate(ind._last.measurement_date) : '· Sin medición'

    return '<div class="ind-card ' + sem + (ind.is_active===false?' ind-inactive':'') +
      '" onclick="openDetail(\'' + ind.id + '\')">' +

      '<div class="ind-card-top">' +
        '<div class="ind-card-badges">' + codeBadge + originBadge + '</div>' +
        '<div class="traffic-light ' + sem + '"><i class="fa-solid ' + icon + '"></i></div>' +
      '</div>' +

      '<div class="ind-card-name">' + esc(ind.name) + '</div>' +
      '<div class="ind-card-info"><i class="fa-solid fa-user-tie"></i> ' + resp + ' <span>· ' + dept + '</span></div>' +

      '<div class="ind-limits-row">' +
        '<span class="limit-badge lim-red">'    + limLow  + '</span>' +
        '<span class="limit-badge lim-yellow">' + limMid  + '</span>' +
        '<span class="limit-badge lim-green">'  + limHigh + '</span>' +
      '</div>' +

      '<div class="ind-card-foot2">' +
        '<div>' + currentHtml + '</div>' +
        '<span class="ind-freq-info"><i class="fa-solid fa-rotate"></i>' + freqLbl + ' ' + dateStr + '</span>' +
      '</div>' +
    '</div>'
  }).join('')
}

// ── Modal: Nuevo Indicador ───────────────────────────────────────
async function openNewInd() {
  const code = await autoGenerateCode()
  const fields = ['new-name','new-responsible','new-formula','new-description',
                  'new-unit','new-target','new-min','new-limit-low','new-limit-mid','new-limit-high']
  fields.forEach(id => setVal(id, ''))
  setVal('new-code', code)
  setVal('new-freq', 'mensual')
  setVal('new-higher-better', 'true')
  setVal('new-origin', '')
  const nd = document.getElementById('new-dept')
  if (nd) nd.selectedIndex = 0
  openModal('modal-new')
}

async function submitNewInd() {
  const btn  = document.getElementById('btn-save-new')
  const code = document.getElementById('new-code')?.value.trim()
  const name = document.getElementById('new-name')?.value.trim()
  const unit = document.getElementById('new-unit')?.value.trim()
  const freq = document.getElementById('new-freq')?.value
  const dept = document.getElementById('new-dept')?.value || null
  const resp = document.getElementById('new-responsible')?.value.trim() || null
  const desc = document.getElementById('new-description')?.value.trim() || null
  const formula  = document.getElementById('new-formula')?.value.trim()    || null
  const origin   = document.getElementById('new-origin')?.value             || null
  const limLow   = document.getElementById('new-limit-low')?.value.trim()  || null
  const limMid   = document.getElementById('new-limit-mid')?.value.trim()  || null
  const limHigh  = document.getElementById('new-limit-high')?.value.trim() || null
  const targetRaw= document.getElementById('new-target')?.value
  const minRaw   = document.getElementById('new-min')?.value
  const higherBetter = document.getElementById('new-higher-better')?.value === 'true'

  if (!code) { showToast('El código es obligatorio.', 'red'); return }
  if (!name) { showToast('El nombre del indicador es obligatorio.', 'red'); return }
  if (!unit) { showToast('Define la variable / unidad de medida.', 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Creando…'

  const payload = {
    code, name, unit, formula, description: desc, origin,
    limit_low_text: limLow, limit_mid_text: limMid, limit_high_text: limHigh,
    measurement_frequency:     freq,
    target_value:              targetRaw ? parseFloat(targetRaw) : null,
    min_acceptable:            minRaw    ? parseFloat(minRaw)    : null,
    is_higher_better:          higherBetter,
    responsible_department_id: dept,
    responsible_position:      resp,
    is_active:                 true,
    created_by:                _user.id
  }

  const { error } = await db.from('quality_indicators').insert(payload)
  if (error) {
    showToast('Error al crear: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Crear Indicador')
    return
  }

  showToast('Indicador "' + name + '" creado correctamente.', 'green')
  closeModal('modal-new')
  resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Crear Indicador')
  await loadIndicadores()
}

// ── Modal: Detalle ────────────────────────────────────────────────
async function openDetail(indId) {
  _currentInd = _allInd.find(i => i.id === indId)
  if (!_currentInd) return

  const ind  = _currentInd
  const unit = ind.unit || ''

  setText('detail-name',  ind.name)
  setText('detail-dept',  ind.dept?.name || 'General')
  setText('d-code',       ind.code || '—')
  setText('d-origin',     ind.origin || '—')
  setText('d-unit',       unit)
  setText('d-freq',       freqLabel(ind.measurement_frequency))
  setText('d-target',     ind.target_value !== null && ind.target_value !== undefined ? ind.target_value + ' ' + unit : '—')
  setText('d-min',        ind.min_acceptable !== null && ind.min_acceptable !== undefined ? ind.min_acceptable + ' ' + unit : '—')
  setText('d-responsible', ind.responsible_position || '—')
  setText('d-description', ind.description || 'Sin descripción registrada.')
  setText('d-formula',    ind.formula || 'Sin fórmula definida.')

  renderDetailLimits(ind)
  await loadMeasurements(indId)

  const lastVal = _measurements[0]?.value ?? null
  const sem     = getSemaforo(ind, lastVal)
  renderBigTraffic(ind, sem, lastVal)
  renderConfigForm(ind)
  renderAddMeasForm(ind)

  document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'))
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'))
  const fp = document.getElementById('tab-overview')
  const fb = document.querySelector('.tab-btn')
  if (fp) fp.classList.add('active')
  if (fb) fb.classList.add('active')

  openModal('modal-detail')
}

function renderDetailLimits(ind) {
  const el = document.getElementById('detail-limits-row')
  if (!el) return
  const low  = ind.limit_low_text
  const mid  = ind.limit_mid_text
  const high = ind.limit_high_text
  if (!low && !mid && !high) { el.innerHTML = ''; return }

  el.innerHTML =
    '<div class="detail-limits-grid">' +
      '<div class="detail-limit-item">' +
        '<div class="dl-label red">🔴 Fuera de meta (Rojo)</div>' +
        '<div class="dl-val lim-red">' + esc(low || 'NA') + '</div>' +
      '</div>' +
      '<div class="detail-limit-item">' +
        '<div class="dl-label yellow">🟡 Cerca de meta (Amarillo)</div>' +
        '<div class="dl-val lim-yellow">' + esc(mid || 'NA') + '</div>' +
      '</div>' +
      '<div class="detail-limit-item">' +
        '<div class="dl-label green">🟢 En meta (Verde)</div>' +
        '<div class="dl-val lim-green">' + esc(high || 'NA') + '</div>' +
      '</div>' +
    '</div>'
}

function renderBigTraffic(ind, sem, lastVal) {
  const unit = ind.unit || ''
  const big  = document.getElementById('big-traffic')
  const icon = semaforoIcon(sem)
  const colors = {
    verde:     { bg:'var(--green-lt)', color:'var(--green)' },
    amarillo:  { bg:'#fef3c7',        color:'#92400e' },
    rojo:      { bg:'var(--red-lt)',  color:'var(--red)' },
    'sin-datos':{ bg:'var(--gray-lt)', color:'var(--txt3)' }
  }
  const c = colors[sem] || colors['sin-datos']
  if (big) {
    big.style.background = c.bg
    big.innerHTML = '<i class="fa-solid ' + icon + '" style="color:' + c.color + '"></i>'
  }
  const labels = {
    verde:'✅ Cumpliendo la meta', amarillo:'⚠️ Cerca del mínimo aceptable',
    rojo:'❌ Por debajo del mínimo', 'sin-datos':'Sin mediciones registradas aún'
  }
  setText('big-value',  lastVal !== null ? lastVal + ' ' + unit : '—')
  setText('big-label',  labels[sem])
  setText('big-target', ind.target_value !== null && ind.target_value !== undefined ? String(ind.target_value) : '—')
  setText('big-unit',   unit)
  setText('d-last-date', _measurements[0] ? fmtDate(_measurements[0].measurement_date) : '—')
}

// ── Measurements ─────────────────────────────────────────────────
async function loadMeasurements(indId) {
  const { data } = await db
    .from('indicator_measurements')
    .select('*, profiles:measured_by(full_name)')
    .eq('indicator_id', indId)
    .order('measurement_date', { ascending: false })
    .limit(24)
  _measurements = data || []
  renderMeasTable()
  renderMiniChart()
}

function renderMeasTable() {
  const tbody = document.getElementById('meas-tbody')
  if (!tbody) return
  if (_measurements.length === 0) {
    tbody.innerHTML = '<tr><td colspan="6" style="text-align:center;padding:30px;color:var(--txt3)">Sin mediciones registradas aún</td></tr>'
    return
  }
  const ind      = _currentInd
  const unit     = ind?.unit || ''
  const canWrite = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)

  tbody.innerHTML = _measurements.map(function(m) {
    const sem = getSemaforo(ind, m.value)
    const vs  = (ind?.target_value !== null && ind?.target_value !== undefined)
      ? (m.value - ind.target_value).toFixed(1) : '—'
    const vsStr = vs !== '—'
      ? '<span style="color:' + (sem==='verde'?'var(--green)':sem==='rojo'?'var(--red)':'#d97706') + ';font-weight:600">' + (parseFloat(vs) > 0 ? '+' : '') + vs + '</span>'
      : '—'
    return '<tr>' +
      '<td>' + fmtDate(m.measurement_date) + '</td>' +
      '<td class="center"><span class="meas-val ' + sem + '">' + m.value + ' ' + unit + '</span></td>' +
      '<td class="center">' + vsStr + '</td>' +
      '<td>' + esc(m.profiles?.full_name || m.measured_by_name || '—') + '</td>' +
      '<td>' + esc(m.notes || '—') + '</td>' +
      '<td class="center">' +
        (canWrite ? '<button class="btn-action red" onclick="deleteMeasurement(\'' + m.id + '\')" title="Eliminar"><i class="fa-solid fa-trash"></i></button>' : '—') +
      '</td></tr>'
  }).join('')
}

function renderAddMeasForm(ind) {
  const wrap = document.getElementById('add-meas-wrap')
  if (!wrap) return
  const canWrite = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)
  if (!canWrite) { wrap.innerHTML = ''; return }
  wrap.innerHTML =
    '<div class="add-meas-card">' +
      '<h4><i class="fa-solid fa-plus" style="margin-right:6px"></i>Registrar nueva medición</h4>' +
      '<div class="form-row three" style="margin-bottom:0">' +
        '<div class="field"><label>Fecha <span class="req">*</span></label>' +
          '<input type="date" id="meas-date" value="' + new Date().toISOString().split('T')[0] + '"></div>' +
        '<div class="field"><label>Valor (' + esc(ind.unit||'') + ') <span class="req">*</span></label>' +
          '<input type="number" id="meas-value" placeholder="0.00" step="any"></div>' +
        '<div class="field"><label>&nbsp;</label>' +
          '<button class="btn-primary" onclick="saveMeasurement()" style="width:100%">' +
          '<i class="fa-solid fa-plus"></i> Agregar</button></div>' +
      '</div>' +
      '<div class="form-row one" style="margin-top:10px;margin-bottom:0">' +
        '<div class="field"><label>Notas / Observaciones</label>' +
          '<input type="text" id="meas-notes" placeholder="Observaciones opcionales…"></div>' +
      '</div>' +
    '</div>'
}

async function saveMeasurement() {
  const date  = document.getElementById('meas-date')?.value
  const value = parseFloat(document.getElementById('meas-value')?.value)
  const notes = document.getElementById('meas-notes')?.value.trim()
  if (!date)        { showToast('Selecciona la fecha de medición.', 'red'); return }
  if (isNaN(value)) { showToast('Ingresa un valor numérico válido.', 'red'); return }

  const { error } = await db.from('indicator_measurements').insert({
    indicator_id:     _currentInd.id,
    measurement_date: date,
    value,
    notes:            notes || null,
    measured_by:      _user.id,
    measured_by_name: _profile?.full_name || _user.email
  })
  if (error) { showToast('Error: ' + error.message, 'red'); return }

  showToast('Medición registrada correctamente.', 'green')
  setVal('meas-value', '')
  setVal('meas-notes', '')
  await loadMeasurements(_currentInd.id)
  const idx = _allInd.findIndex(i => i.id === _currentInd.id)
  if (idx > -1) _allInd[idx]._last = { value, measurement_date: date }
  const sem = getSemaforo(_currentInd, value)
  renderBigTraffic(_currentInd, sem, value)
  applyFilters()
}

async function deleteMeasurement(measId) {
  if (!confirm('¿Eliminar esta medición?')) return
  const { error } = await db.from('indicator_measurements').delete().eq('id', measId)
  if (error) { showToast('Error: ' + error.message, 'red'); return }
  _measurements = _measurements.filter(m => m.id !== measId)
  renderMeasTable()
  renderMiniChart()
  showToast('Medición eliminada.', 'green')
}

// ── Mini chart ────────────────────────────────────────────────────
function renderMiniChart() {
  const ctx    = document.getElementById('chart-mini')
  const noData = document.getElementById('chart-no-data')
  if (_miniChart) { _miniChart.destroy(); _miniChart = null }
  const data = [..._measurements].reverse().slice(-12)
  if (data.length < 2) {
    if (ctx)    ctx.style.display = 'none'
    if (noData) noData.style.display = 'flex'
    return
  }
  if (ctx)    ctx.style.display = 'block'
  if (noData) noData.style.display = 'none'

  const ind    = _currentInd
  const labels = data.map(m => fmtDate(m.measurement_date))
  const values = data.map(m => m.value)
  const target = ind?.target_value
  const min    = ind?.min_acceptable

  const datasets = [{
    label: ind?.name || 'Valor', data: values,
    borderColor: '#2563eb', backgroundColor: 'rgba(37,99,235,.08)',
    tension: 0.4, fill: true,
    pointBackgroundColor: values.map(v => {
      const s = getSemaforo(ind, v)
      return s === 'verde' ? '#16a34a' : s === 'rojo' ? '#dc2626' : '#d97706'
    }),
    pointRadius: 5
  }]

  if (target !== null && target !== undefined) datasets.push({
    label: 'Meta (' + target + ')', data: Array(data.length).fill(target),
    borderColor: '#16a34a', borderDash: [5,4], borderWidth: 1.5, pointRadius: 0, fill: false
  })
  if (min !== null && min !== undefined) datasets.push({
    label: 'Mínimo (' + min + ')', data: Array(data.length).fill(min),
    borderColor: '#dc2626', borderDash: [3,3], borderWidth: 1, pointRadius: 0, fill: false
  })

  _miniChart = new Chart(ctx.getContext('2d'), {
    type: 'line', data: { labels, datasets },
    options: {
      responsive: true, maintainAspectRatio: false,
      plugins: { legend: { position:'bottom', labels:{ font:{size:11,family:'Inter'}, padding:12 } } },
      scales: {
        y: { grid:{ color:'#f1f5f9' }, ticks:{ font:{size:11} } },
        x: { grid:{ display:false },   ticks:{ font:{size:11} } }
      }
    }
  })
}

// ── Config tab ───────────────────────────────────────────────────
function renderConfigForm(ind) {
  const wrap = document.getElementById('config-form-wrap')
  if (!wrap) return
  const canWrite = ['administrador','responsable_calidad'].includes(_role)

  if (!canWrite) {
    wrap.innerHTML = '<div style="text-align:center;padding:30px;color:var(--txt3)">' +
      '<i class="fa-solid fa-lock" style="font-size:2rem;display:block;margin-bottom:8px;color:var(--border)"></i>' +
      'Solo Responsable de Calidad o Administrador puede editar la configuración.</div>'
    return
  }

  const deptOpts = _depts.map(d =>
    '<option value="' + d.id + '"' + (ind.responsible_department_id===d.id?' selected':'') + '>' + esc(d.name) + '</option>'
  ).join('')

  const originOpts = ['Financiero','Operativo','Calidad','Seguridad','Recursos Humanos','Satisfacción'].map(o =>
    '<option value="' + o + '"' + (ind.origin===o?' selected':'') + '>' + o + '</option>'
  ).join('')

  const freqOpts = ['diario','semanal','mensual','trimestral','anual'].map(f =>
    '<option value="' + f + '"' + (ind.measurement_frequency===f?' selected':'') + '>' + freqLabel(f) + '</option>'
  ).join('')

  wrap.innerHTML =
    '<div class="form-row">' +
      '<div class="field"><label>Código</label>' +
        '<input type="text" id="cfg-code" value="' + esc(ind.code||'') + '"></div>' +
      '<div class="field"><label>Proceso / Departamento</label>' +
        '<select id="cfg-dept"><option value="">— General —</option>' + deptOpts + '</select></div>' +
    '</div>' +
    '<div class="form-row one"><div class="field"><label>Nombre</label>' +
      '<input type="text" id="cfg-name" value="' + esc(ind.name) + '"></div></div>' +
    '<div class="form-row">' +
      '<div class="field"><label>Reporta / Responsable</label>' +
        '<input type="text" id="cfg-resp" value="' + esc(ind.responsible_position||'') + '"></div>' +
      '<div class="field"><label>Origen / Categoría</label>' +
        '<select id="cfg-origin"><option value="">— Sin categoría —</option>' + originOpts + '</select></div>' +
    '</div>' +
    '<div class="form-row one"><div class="field"><label>Descripción</label>' +
      '<textarea id="cfg-desc" rows="2">' + esc(ind.description||'') + '</textarea></div></div>' +
    '<div class="form-row one"><div class="field"><label>Fórmula de cálculo</label>' +
      '<textarea id="cfg-formula" rows="2">' + esc(ind.formula||'') + '</textarea></div></div>' +
    '<div class="form-row three">' +
      '<div class="field"><label>Variable</label>' +
        '<input type="text" id="cfg-unit" value="' + esc(ind.unit||'') + '"></div>' +
      '<div class="field"><label>Período</label>' +
        '<select id="cfg-freq">' + freqOpts + '</select></div>' +
      '<div class="field"><label>¿Mayor = mejor?</label>' +
        '<select id="cfg-higher">' +
          '<option value="true"'  + (ind.is_higher_better!==false?' selected':'') + '>Sí</option>' +
          '<option value="false"' + (ind.is_higher_better===false?' selected':'') + '>No</option>' +
        '</select></div>' +
    '</div>' +
    '<div class="sem-sep"><i class="fa-solid fa-traffic-light"></i> Rangos del Semáforo</div>' +
    '<div class="form-row three">' +
      '<div class="field"><label style="color:var(--red)">🔴 Límite inferior (rojo)</label>' +
        '<input type="text" id="cfg-lim-low" value="' + esc(ind.limit_low_text||'') + '"></div>' +
      '<div class="field"><label style="color:#d97706">🟡 Límite medio (amarillo)</label>' +
        '<input type="text" id="cfg-lim-mid" value="' + esc(ind.limit_mid_text||'') + '"></div>' +
      '<div class="field"><label style="color:var(--green)">🟢 Meta (verde)</label>' +
        '<input type="text" id="cfg-lim-high" value="' + esc(ind.limit_high_text||'') + '"></div>' +
    '</div>' +
    '<div class="form-row">' +
      '<div class="field"><label>Meta (numérico, para cálculo)</label>' +
        '<input type="number" id="cfg-target" value="' + (ind.target_value??'') + '" step="any"></div>' +
      '<div class="field"><label>Mínimo aceptable (numérico)</label>' +
        '<input type="number" id="cfg-min" value="' + (ind.min_acceptable??'') + '" step="any"></div>' +
    '</div>' +
    '<div style="display:flex;align-items:center;justify-content:space-between;margin-top:8px">' +
      '<label class="toggle-wrap"><div class="toggle">' +
        '<input type="checkbox" id="cfg-active"' + (ind.is_active!==false?' checked':'') + '>' +
        '<div class="toggle-slider"></div></div>' +
        '<span class="toggle-label">Indicador activo</span></label>' +
      '<button class="btn-primary" onclick="saveConfig()">' +
        '<i class="fa-solid fa-floppy-disk"></i> Guardar Cambios</button>' +
    '</div>'
}

async function saveConfig() {
  if (!_currentInd) return
  const code    = document.getElementById('cfg-code')?.value.trim()
  const name    = document.getElementById('cfg-name')?.value.trim()
  const dept    = document.getElementById('cfg-dept')?.value  || null
  const resp    = document.getElementById('cfg-resp')?.value.trim()   || null
  const origin  = document.getElementById('cfg-origin')?.value        || null
  const desc    = document.getElementById('cfg-desc')?.value.trim()   || null
  const formula = document.getElementById('cfg-formula')?.value.trim()|| null
  const unit    = document.getElementById('cfg-unit')?.value.trim()
  const freq    = document.getElementById('cfg-freq')?.value
  const higher  = document.getElementById('cfg-higher')?.value === 'true'
  const limLow  = document.getElementById('cfg-lim-low')?.value.trim()  || null
  const limMid  = document.getElementById('cfg-lim-mid')?.value.trim()  || null
  const limHigh = document.getElementById('cfg-lim-high')?.value.trim() || null
  const target  = document.getElementById('cfg-target')?.value
  const min     = document.getElementById('cfg-min')?.value
  const active  = document.getElementById('cfg-active')?.checked

  if (!name) { showToast('El nombre es obligatorio.', 'red'); return }

  const { error } = await db.from('quality_indicators').update({
    code: code || null, name, formula, description: desc, origin, unit,
    limit_low_text:  limLow, limit_mid_text: limMid, limit_high_text: limHigh,
    responsible_department_id: dept, responsible_position: resp,
    measurement_frequency: freq, is_higher_better: higher,
    target_value:  target ? parseFloat(target) : null,
    min_acceptable: min   ? parseFloat(min)    : null,
    is_active:     active,
    updated_at:    new Date().toISOString()
  }).eq('id', _currentInd.id)

  if (error) { showToast('Error: ' + error.message, 'red'); return }
  showToast('Configuración guardada.', 'green')
  closeModal('modal-detail')
  await loadIndicadores()
}

// ── Tabs ─────────────────────────────────────────────────────────
function switchTab(panelId, btn) {
  document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'))
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'))
  const panel = document.getElementById(panelId)
  if (panel) panel.classList.add('active')
  if (btn)   btn.classList.add('active')
}

// ── Modal helpers ────────────────────────────────────────────────
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) {
  document.getElementById(id)?.classList.remove('open')
  if (id === 'modal-detail' && _miniChart) { _miniChart.destroy(); _miniChart = null }
}
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.modal-overlay').forEach(o => {
    o.addEventListener('click', e => {
      if (e.target === o) {
        o.classList.remove('open')
        if (_miniChart) { _miniChart.destroy(); _miniChart = null }
      }
    })
  })
})

// ── Helpers ───────────────────────────────────────────────────────
function freqLabel(f) {
  return { diario:'Diario', semanal:'Semanal', mensual:'Mensual',
           trimestral:'Trimestral', anual:'Anual' }[f] || (f || '—')
}
function fmtDate(d) {
  if (!d) return '—'
  return new Date(d + 'T12:00:00').toLocaleDateString('es-MX',
    { day:'2-digit', month:'short', year:'numeric' })
}
function setText(id, val) { const el=document.getElementById(id); if(el) el.textContent=val??'—' }
function setVal(id, val)  { const el=document.getElementById(id); if(el) el.value=val??'' }
function resetBtn(btn, html) { btn.disabled=false; btn.innerHTML=html }
function esc(str) {
  if (!str) return ''
  return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}
function showLoading() {
  const grid = document.getElementById('ind-grid')
  if (grid) grid.innerHTML = '<div class="grid-empty"><i class="fa-solid fa-spinner fa-spin" style="font-size:2rem;margin-bottom:0"></i></div>'
}
function showError(msg) {
  const grid = document.getElementById('ind-grid')
  if (grid) grid.innerHTML = '<div class="grid-empty"><i class="fa-solid fa-circle-exclamation" style="color:var(--red)"></i><strong>Error al cargar</strong>' + esc(msg) + '</div>'
}
function showToast(msg, color) {
  color = color || 'green'
  const old = document.getElementById('sgc-toast')
  if (old) old.remove()
  const bg = color==='green'?'#16a34a':color==='red'?'#dc2626':'#2563eb'
  const t  = document.createElement('div')
  t.id = 'sgc-toast'
  t.style.cssText = 'position:fixed;bottom:28px;right:28px;z-index:9999;background:' + bg +
    ';color:#fff;padding:13px 22px;border-radius:12px;font-size:.857rem;font-weight:600;' +
    'font-family:var(--font);box-shadow:0 8px 28px rgba(0,0,0,.22);max-width:380px;line-height:1.4;'
  t.textContent = msg
  document.body.appendChild(t)
  setTimeout(function(){ t.remove() }, 3800)
}

// ── Arrancar ──────────────────────────────────────────────────────
initIndicadores()
