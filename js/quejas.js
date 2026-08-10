// ─── Quejas, Sugerencias y Felicitaciones — FT-CA-24 ────────────

let _user      = null
let _profile   = null
let _role      = null
let _allQJ     = []
let _filteredQJ= []
let _depts     = []
let _currentQJId = null
let _editMode  = false
let _pendingFiles = []   // imágenes elegidas pero aún no subidas
let _editAdjuntos = []   // imágenes ya guardadas (al editar)
const QJ_BUCKET = 'quejas-adjuntos'

// ── Init ─────────────────────────────────────────────────────────
async function initQuejas() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  renderUserInfo()
  setCurrentDate()
  await loadDepts()
  populateDeptSelect()
  populateQjAreas()
  await loadQuejas()
  setupFilters()
  applyRoleUI()
}

function renderUserInfo() {
  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
}

function setCurrentDate() {
  const el = document.getElementById('current-date')
  if (el) el.textContent = new Date().toLocaleDateString('es-MX', {
    weekday: 'long', day: 'numeric', month: 'long', year: 'numeric'
  })
}

async function loadDepts() {
  const { data } = await db.from('departments')
    .select('id,name').eq('is_active', true).order('name')
  _depts = data || []
}

function populateDeptSelect() {
  const sel = document.getElementById('nq-departamento')
  if (!sel) return
  const opts = '<option value="">— Seleccionar —</option>' +
    _depts.map(d => `<option value="${esc(d.name)}">${esc(d.name)}</option>`).join('')
  sel.innerHTML = opts
}

// ── Catálogo de habitaciones (Edificio/Área → Habitación) ─────────
// Usa HSM_ROOMS_BY_AREA de js/areas-catalogo.js. Se guarda un solo
// texto en la columna 'habitacion': el código de habitación si se
// eligió una, o el nombre del área si no.
function populateQjAreas() {
  const sel = document.getElementById('nq-area')
  if (!sel || typeof HSM_AREAS === 'undefined') return
  sel.innerHTML = '<option value="">— Edificio / Área —</option>' +
    HSM_AREAS.map(a => `<option value="${esc(a)}">${esc(a)}</option>`).join('')
}

function onQjAreaChange() {
  const area = document.getElementById('nq-area')?.value || ''
  const sel  = document.getElementById('nq-hab')
  if (!sel) return
  const rooms = (typeof HSM_ROOMS_BY_AREA !== 'undefined' && HSM_ROOMS_BY_AREA[area]) || []
  sel.innerHTML = '<option value="">— Sin habitación específica —</option>' +
    rooms.map(r => `<option value="${esc(r)}">${esc(r)}</option>`).join('')
}

// Reconstruye los dos menús a partir del texto guardado (para editar
// o para valores que vienen del formulario de Google). Si el valor no
// está en el catálogo, se conserva tal cual como opción para no perderlo.
function qjSetLocation(value) {
  populateQjAreas()
  const selA = document.getElementById('nq-area')
  const selH = document.getElementById('nq-hab')
  if (!selA || !selH) return
  const v = String(value || '').trim()

  if (!v) { selA.value = ''; onQjAreaChange(); return }

  // ¿Es un código de habitación conocido?
  const area = typeof hsmAreaDeHabitacion === 'function' ? hsmAreaDeHabitacion(v) : ''
  if (area) {
    selA.value = area
    onQjAreaChange()
    selH.value = v
    return
  }
  // ¿Es el nombre de un área?
  if (typeof HSM_AREAS !== 'undefined' && HSM_AREAS.includes(v)) {
    selA.value = v
    onQjAreaChange()
    return
  }
  // Valor libre heredado: consérvalo como opción de área para no perderlo.
  const opt = document.createElement('option')
  opt.value = v; opt.textContent = v
  selA.appendChild(opt)
  selA.value = v
  onQjAreaChange()
}

// Lee la ubicación elegida: habitación si hay, si no el área.
function qjGetLocation() {
  const area = document.getElementById('nq-area')?.value.trim() || ''
  const hab  = document.getElementById('nq-hab')?.value.trim() || ''
  return hab || area || ''
}

// ── Imágenes adjuntas ────────────────────────────────────────────
const QJ_MAX_MB = 10

function onQjFilesSelected(input) {
  const files = Array.from(input.files || [])
  for (const f of files) {
    if (!f.type.startsWith('image/')) {
      showToast(`"${f.name}" no es una imagen y se omitió.`, 'red'); continue
    }
    if (f.size > QJ_MAX_MB * 1024 * 1024) {
      showToast(`"${f.name}" pesa más de ${QJ_MAX_MB} MB y se omitió.`, 'red'); continue
    }
    _pendingFiles.push(f)
  }
  input.value = ''            // permite volver a elegir el mismo archivo
  renderQjAdjuntosForm()
}

function removePendingAdj(i) {
  _pendingFiles.splice(i, 1)
  renderQjAdjuntosForm()
}

// Dibuja, en el formulario, las imágenes ya guardadas (editar) + las nuevas.
async function renderQjAdjuntosForm() {
  const cont = document.getElementById('nq-adjuntos')
  if (!cont) return
  cont.innerHTML = ''

  // Ya guardadas (modo edición)
  for (const a of _editAdjuntos) {
    const div = document.createElement('div')
    div.className = 'qj-adj'
    div.innerHTML = `<img alt="${esc(a.file_name || '')}">
      <button type="button" class="qj-adj-x" title="Eliminar" onclick="deleteExistingAdj('${a.id}')">
        <i class="fa-solid fa-xmark"></i></button>`
    cont.appendChild(div)
    const url = await qjSignedUrl(a.file_path)
    if (url) div.querySelector('img').src = url
    div.querySelector('img').onclick = () => url && window.open(url, '_blank')
  }

  // Nuevas (aún no subidas)
  _pendingFiles.forEach((f, i) => {
    const div = document.createElement('div')
    div.className = 'qj-adj'
    const url = URL.createObjectURL(f)
    div.innerHTML = `<img src="${url}" alt="${esc(f.name)}">
      <button type="button" class="qj-adj-x" title="Quitar" onclick="removePendingAdj(${i})">
        <i class="fa-solid fa-xmark"></i></button>`
    div.querySelector('img').onclick = () => window.open(url, '_blank')
    cont.appendChild(div)
  })
}

async function qjSignedUrl(path) {
  try {
    const { data } = await db.storage.from(QJ_BUCKET).createSignedUrl(path, 3600)
    return data?.signedUrl || null
  } catch (e) { return null }
}

async function loadAdjuntos(quejaId) {
  const { data } = await db.from('quejas_adjuntos')
    .select('id,file_path,file_name,mime_type')
    .eq('queja_id', quejaId)
    .order('uploaded_at', { ascending: true })
  return data || []
}

// Sube las imágenes pendientes de una queja ya guardada.
async function uploadPendingFiles(quejaId) {
  if (!_pendingFiles.length) return { ok: true, subidas: 0 }
  let subidas = 0
  for (const f of _pendingFiles) {
    const ext  = (f.name.split('.').pop() || 'jpg').toLowerCase().replace(/[^a-z0-9]/g, '')
    const path = `${quejaId}/${Date.now()}_${Math.random().toString(36).slice(2, 7)}.${ext}`
    const { error: upErr } = await db.storage.from(QJ_BUCKET)
      .upload(path, f, { cacheControl: '3600', upsert: false, contentType: f.type })
    if (upErr) return { ok: false, error: upErr.message, subidas }
    const { error: rowErr } = await db.from('quejas_adjuntos').insert({
      queja_id: quejaId, file_path: path, file_name: f.name,
      file_size_bytes: f.size, mime_type: f.type, uploaded_by: _user.id,
    })
    if (rowErr) return { ok: false, error: rowErr.message, subidas }
    subidas++
  }
  return { ok: true, subidas }
}

async function deleteExistingAdj(id) {
  const a = _editAdjuntos.find(x => x.id === id)
  if (!a) return
  if (!confirm('¿Eliminar esta imagen?')) return
  await db.storage.from(QJ_BUCKET).remove([a.file_path])
  const { error } = await db.from('quejas_adjuntos').delete().eq('id', id)
  if (error) { showToast('No se pudo eliminar: ' + error.message, 'red'); return }
  _editAdjuntos = _editAdjuntos.filter(x => x.id !== id)
  renderQjAdjuntosForm()
  showToast('Imagen eliminada.', 'green')
}

function applyRoleUI() {
  const canWrite = ['administrador','responsable_calidad','jefe_departamento','recepcion'].includes(_role)
  const btn = document.getElementById('btn-new-qj')
  if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'
}

// ── Cargar registros ─────────────────────────────────────────────
async function loadQuejas() {
  showLoading()
  const { data, error } = await db
    .from('quejas')
    .select('*')
    .order('fecha', { ascending: false })

  if (error) { showError(error.message); return }
  _allQJ = data || []
  llenarDeptos()
  populateClasifSelect()
  applyFilters()
}

// ── Departamentos que existen en los datos ────────────────────────
function llenarDeptos() {
  const sel = document.getElementById('f-depto')
  if (!sel) return
  const actual = sel.value
  const deptos = [...new Set(_allQJ.map(r => r.departamento).filter(Boolean))]
    .sort((a, b) => a.localeCompare(b, 'es'))
  sel.innerHTML = '<option value="">Todos</option>' +
    deptos.map(d => `<option value="${esc(d)}">${esc(d)}</option>`).join('')
  sel.value = actual
}

// ── Periodo (preajustes → Desde/Hasta) ────────────────────────────
function onPeriodoChange() {
  const p = document.getElementById('f-periodo')?.value || 'todo'
  const desde = document.getElementById('f-desde')
  const hasta = document.getElementById('f-hasta')
  if (!desde || !hasta) return
  if (p === 'custom') { applyFilters(); return }
  if (p === 'todo') { desde.value = ''; hasta.value = ''; applyFilters(); return }

  const hoy = new Date(), y = hoy.getFullYear(), m = hoy.getMonth()
  let d1, d2
  switch (p) {
    case 'mes':    d1 = new Date(y, m, 1);      d2 = new Date(y, m + 1, 0); break
    case 'mes-1':  d1 = new Date(y, m - 1, 1);  d2 = new Date(y, m, 0);     break
    case '3m':     d1 = new Date(y, m - 2, 1);  d2 = new Date(y, m + 1, 0); break
    case '6m':     d1 = new Date(y, m - 5, 1);  d2 = new Date(y, m + 1, 0); break
    case '12m':    d1 = new Date(y, m - 11, 1); d2 = new Date(y, m + 1, 0); break
    case 'anio':   d1 = new Date(y, 0, 1);      d2 = new Date(y, 11, 31);   break
    case 'anio-1': d1 = new Date(y - 1, 0, 1);  d2 = new Date(y - 1, 11, 31); break
    default: return
  }
  desde.value = isoFecha(d1)
  hasta.value = isoFecha(d2)
  applyFilters()
}

function onFechaManual() {
  const sel = document.getElementById('f-periodo')
  if (sel) sel.value = 'custom'
  applyFilters()
}

function isoFecha(d) {
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`
}

// ── Filtros ───────────────────────────────────────────────────────
function setupFilters() { /* los eventos van inline en el HTML */ }

function applyFilters() {
  const q      = (document.getElementById('search-input')?.value || '').toLowerCase().trim()
  const tipo   = document.getElementById('f-tipo')?.value   || ''
  const status = document.getElementById('f-status')?.value || ''
  const depto  = document.getElementById('f-depto')?.value  || ''
  const origen = document.getElementById('f-origen')?.value || ''
  const prio   = document.getElementById('f-prioridad')?.value || ''
  const grav   = document.getElementById('f-gravedad')?.value  || ''
  const clasif = document.getElementById('f-clasif')?.value    || ''
  const desde  = document.getElementById('f-desde')?.value  || ''
  const hasta  = document.getElementById('f-hasta')?.value  || ''

  _filteredQJ = _allQJ.filter(r => {
    const f = r.fecha || ''
    const s = r.seguimiento || {}
    if (tipo   && r.tipo   !== tipo)   return false
    if (status && r.status !== status) return false
    if (depto  && r.departamento !== depto) return false
    if (origen && (r.origen || 'manual') !== origen) return false
    if (prio   && s.priorizacion  !== prio)   return false
    if (grav   && s.gravedad      !== grav)   return false
    if (clasif && s.clasificacion !== clasif) return false
    if (desde  && (!f || f < desde)) return false
    if (hasta  && (!f || f > hasta)) return false
    if (q) {
      const txt = `${r.folio || ''} ${r.nombre_paciente || ''} ${r.nombre_presenta || ''} ${r.descripcion || ''} ${r.departamento || ''}`.toLowerCase()
      if (!txt.includes(q)) return false
    }
    return true
  })

  renderChips()
  renderKPIs()
  renderCharts()
  renderTable(_filteredQJ)
}

function clearFilters() {
  ;['f-tipo','f-status','f-depto','f-origen','f-prioridad','f-gravedad','f-clasif','f-desde','f-hasta','search-input']
    .forEach(id => { const el = document.getElementById(id); if (el) el.value = '' })
  const p = document.getElementById('f-periodo'); if (p) p.value = 'todo'
  applyFilters()
}

// Llena el filtro de Clasificación con los valores presentes en los datos
function populateClasifSelect() {
  const sel = document.getElementById('f-clasif')
  if (!sel) return
  const vals = [...new Set(_allQJ.map(r => r.seguimiento && r.seguimiento.clasificacion).filter(Boolean))].sort()
  const actual = sel.value
  sel.innerHTML = '<option value="">Todas</option>' +
    vals.map(v => `<option value="${esc(v)}">${esc(v)}</option>`).join('')
  if (actual) sel.value = actual
}

function renderChips() {
  const el = document.getElementById('qj-chips')
  if (!el) return
  const desde = document.getElementById('f-desde')?.value || ''
  const hasta = document.getElementById('f-hasta')?.value || ''
  const chips = []
  chips.push(desde || hasta
    ? `<span class="qj-chip"><i class="fa-solid fa-calendar-days"></i> ${
        desde ? fmtDate(desde) : 'inicio'} — ${hasta ? fmtDate(hasta) : 'hoy'}</span>`
    : `<span class="qj-chip"><i class="fa-solid fa-calendar-days"></i> Todo el histórico</span>`)
  ;[['f-tipo','Tipo'],['f-status','Estado'],['f-depto','Depto'],['f-origen','Origen']]
    .forEach(([id, etq]) => {
      const v = document.getElementById(id)?.value
      if (v) chips.push(`<span class="qj-chip">${etq}: ${esc(v)}</span>`)
    })
  chips.push(`<span class="qj-chip-count">${_filteredQJ.length} de ${_allQJ.length}</span>`)
  el.innerHTML = chips.join('')
}

// ── KPIs (sobre lo filtrado) ──────────────────────────────────────
function renderKPIs() {
  const b = _filteredQJ
  const cnt = t => b.filter(r => r.tipo === t).length
  setText('cnt-total',        b.length)
  setText('cnt-queja',        cnt('queja'))
  setText('cnt-sugerencia',   cnt('sugerencia'))
  setText('cnt-felicitacion', cnt('felicitacion'))
  setText('cnt-pendiente',    b.filter(r => r.status === 'pendiente').length)
  setText('cnt-resueltas',    b.filter(r => ['resuelto','cerrado'].includes(r.status)).length)
}

// ── Render tabla ──────────────────────────────────────────────────
function renderTable(rows) {
  const tbody = document.getElementById('qj-tbody')
  const count = document.getElementById('qj-count')
  if (count) count.textContent = `${rows.length} registro${rows.length !== 1 ? 's' : ''}`
  if (!tbody) return

  if (rows.length === 0) {
    tbody.innerHTML = `
      <tr><td colspan="8" class="table-empty">
        <i class="fa-solid fa-folder-open"></i>
        <strong>Sin registros</strong>
        No hay resultados con los filtros seleccionados.
      </td></tr>`
    return
  }

  const canWrite = ['administrador','responsable_calidad','jefe_departamento','recepcion'].includes(_role)

  tbody.innerHTML = rows.map(r => `
    <tr>
      <td><span class="qj-folio qj-folio-${r.tipo}">${esc(r.folio)}</span>${
        r.origen === 'hoja'
          ? ' <span class="qj-tag-form" title="Llegó por el formulario web">web</span>'
          : ''}</td>
      <td style="white-space:nowrap">${fmtDate(r.fecha)}</td>
      <td class="center">${tipoPill(r.tipo)}</td>
      <td>${esc(r.nombre_paciente || r.nombre_presenta || '—')}</td>
      <td>${esc(r.departamento || '—')}</td>
      <td><span class="qj-desc" title="${esc(r.descripcion || '')}">${esc(r.descripcion || '—')}</span></td>
      <td class="center">${statusPill(r.status)}</td>
      <td class="center">
        <div class="action-btns">
          <button onclick="openDetail('${r.id}')" class="btn-action" title="Ver detalle">
            <i class="fa-solid fa-eye"></i>
          </button>
          ${canWrite ? `
          <button onclick="openEditQJFromTable('${r.id}')" class="btn-action blue" title="Editar">
            <i class="fa-solid fa-pencil"></i>
          </button>` : ''}
        </div>
      </td>
    </tr>`).join('')
}

// ══════════════════════════════════════════════════════════════════
// GRÁFICAS — se recalculan con lo que dejaron los filtros
// ══════════════════════════════════════════════════════════════════
const _qjCharts = {}
const QJ_COLOR = {
  queja: '#eb6834', sugerencia: '#2a78d6', felicitacion: '#1baf7a',
}
const QJ_STATUS_COLOR = {
  pendiente: '#eda100', en_proceso: '#2a78d6', resuelto: '#1baf7a', cerrado: '#8b908c',
}
const QJ_STATUS_LBL = {
  pendiente: 'Pendiente', en_proceso: 'En proceso', resuelto: 'Resuelto', cerrado: 'Cerrado',
}
const QJ_TIPO_LBL = { queja: 'Quejas', sugerencia: 'Sugerencias', felicitacion: 'Felicitaciones' }

function qjCaja(id) { return document.querySelector(`.qj-box[data-chart="${id}"]`) }
function qjPrep(id) {
  const c = qjCaja(id); if (!c) return null
  if (_qjCharts[id]) { _qjCharts[id].destroy(); delete _qjCharts[id] }
  c.innerHTML = `<canvas id="${id}"></canvas>`
  return document.getElementById(id)
}
function qjVacio(id, msg) {
  const c = qjCaja(id)
  if (_qjCharts[id]) { _qjCharts[id].destroy(); delete _qjCharts[id] }
  if (c) c.innerHTML = `<div class="qj-box-vacio">${msg}</div>`
}

function renderCharts() {
  if (typeof Chart === 'undefined') return
  qjChartTipo()
  qjChartStatus()
  qjChartDepto()
  qjChartTendencia()
  qjChartPrioridad()
  qjChartGravedad()
  qjChartClasif()
}

function qjContar(campo) {
  const c = {}
  _filteredQJ.forEach(r => { const k = r[campo]; if (k) c[k] = (c[k] || 0) + 1 })
  return c
}

// Cuenta por un campo del seguimiento (columna JSON)
function qjContarSeg(key) {
  const c = {}
  _filteredQJ.forEach(r => { const k = r.seguimiento && r.seguimiento[key]; if (k) c[k] = (c[k] || 0) + 1 })
  return c
}

// Distribución por tipo (dona)
function qjChartTipo() {
  const c = qjContar('tipo')
  const claves = Object.keys(c).sort((a, b) => c[b] - c[a])
  if (!claves.length) { qjVacio('ch-tipo', 'Sin registros en el periodo'); return }
  const total = _filteredQJ.length
  const cv = qjPrep('ch-tipo'); if (!cv) return
  _qjCharts['ch-tipo'] = new Chart(cv, {
    type: 'doughnut',
    data: {
      labels: claves.map(k => `${QJ_TIPO_LBL[k] || k} — ${c[k]} (${Math.round(c[k] / total * 100)}%)`),
      datasets: [{ data: claves.map(k => c[k]),
                   backgroundColor: claves.map(k => QJ_COLOR[k] || '#8b908c'),
                   borderWidth: 2, borderColor: '#fff' }],
    },
    options: { responsive: true, maintainAspectRatio: false, cutout: '58%',
      plugins: { legend: { position: 'bottom', labels: { boxWidth: 12, padding: 10, font: { size: 11 } } } } },
  })
  const quejas = c['queja'] || 0
  setText('ch-tipo-sub', total ? `${Math.round(quejas / total * 100)}% son quejas` : '')
}

// Estado de atención (barras horizontales)
function qjChartStatus() {
  const orden = ['pendiente','en_proceso','resuelto','cerrado']
  const c = qjContar('status')
  const presentes = orden.filter(k => c[k])
  if (!presentes.length) { qjVacio('ch-status', 'Sin registros en el periodo'); return }
  const total = _filteredQJ.length
  const cv = qjPrep('ch-status'); if (!cv) return
  _qjCharts['ch-status'] = new Chart(cv, {
    type: 'bar',
    data: {
      labels: presentes.map(k => QJ_STATUS_LBL[k]),
      datasets: [{ label: 'Registros', data: presentes.map(k => c[k]),
                   backgroundColor: presentes.map(k => QJ_STATUS_COLOR[k]), borderRadius: 5 }],
    },
    options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false,
      plugins: { legend: { display: false },
        tooltip: { callbacks: { label: i => ` ${i.raw} (${Math.round(i.raw / total * 100)}%)` } } },
      scales: { x: { beginAtZero: true, ticks: { precision: 0 } } } },
  })
  const sinAtender = c['pendiente'] || 0
  setText('ch-status-sub', total ? `${sinAtender} pendiente${sinAtender !== 1 ? 's' : ''} de atención` : '')
}

// Departamentos más señalados (top 10, barras horizontales)
function qjChartDepto() {
  const c = qjContar('departamento')
  const top = Object.keys(c).sort((a, b) => c[b] - c[a]).slice(0, 10)
  if (!top.length) { qjVacio('ch-depto', 'Sin departamentos en el periodo'); return }
  const cv = qjPrep('ch-depto'); if (!cv) return
  _qjCharts['ch-depto'] = new Chart(cv, {
    type: 'bar',
    data: {
      labels: top.map(k => k.length > 26 ? k.slice(0, 26) + '…' : k),
      datasets: [{ label: 'Registros', data: top.map(k => c[k]),
                   backgroundColor: '#2a78d6', borderRadius: 5 }],
    },
    options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false,
      plugins: { legend: { display: false },
        tooltip: { callbacks: { title: i => top[i[0].dataIndex] } } },
      scales: { x: { beginAtZero: true, ticks: { precision: 0 } }, y: { ticks: { font: { size: 11 } } } } },
  })
}

// Tendencia por mes, apilada por tipo
function qjChartTendencia() {
  const fechas = _filteredQJ.map(r => r.fecha).filter(Boolean).sort()
  if (!fechas.length) { qjVacio('ch-tend', 'Sin registros en el periodo'); setText('ch-tend-sub', ''); return }

  const cubos = {}  // mes → {queja, sugerencia, felicitacion}
  _filteredQJ.forEach(r => {
    const ym = (r.fecha || '').slice(0, 7)
    if (!ym) return
    if (!cubos[ym]) cubos[ym] = { queja: 0, sugerencia: 0, felicitacion: 0 }
    if (r.tipo in cubos[ym]) cubos[ym][r.tipo]++
  })
  const meses = qjRellenarMeses(Object.keys(cubos).sort()).slice(-24)
  const cv = qjPrep('ch-tend'); if (!cv) return
  _qjCharts['ch-tend'] = new Chart(cv, {
    type: 'bar',
    data: {
      labels: meses.map(qjFmtMes),
      datasets: ['queja','sugerencia','felicitacion'].map(t => ({
        label: QJ_TIPO_LBL[t], data: meses.map(m => (cubos[m] || {})[t] || 0),
        backgroundColor: QJ_COLOR[t], borderRadius: 3, stack: 'x',
      })),
    },
    options: { responsive: true, maintainAspectRatio: false,
      plugins: { legend: { position: 'bottom', labels: { boxWidth: 12, padding: 10, font: { size: 11 } } } },
      scales: { x: { stacked: true }, y: { stacked: true, beginAtZero: true, ticks: { precision: 0 } } } },
  })
  setText('ch-tend-sub', `${meses.length} mes${meses.length !== 1 ? 'es' : ''}`)
}

// Priorización (Ordinaria / Urgente)
const QJ_PRIO_COLOR = { 'Ordinaria': '#8b908c', 'Urgente': '#dc2626' }
function qjChartPrioridad() {
  const c = qjContarSeg('priorizacion')
  const orden = ['Urgente', 'Ordinaria'].filter(k => c[k])
  const otras = Object.keys(c).filter(k => !['Urgente','Ordinaria'].includes(k))
  const claves = orden.concat(otras)
  if (!claves.length) { qjVacio('ch-prio', 'Sin datos de priorización en el periodo'); return }
  const total = claves.reduce((s, k) => s + c[k], 0)
  const cv = qjPrep('ch-prio'); if (!cv) return
  _qjCharts['ch-prio'] = new Chart(cv, {
    type: 'bar',
    data: { labels: claves,
      datasets: [{ label: 'Registros', data: claves.map(k => c[k]),
        backgroundColor: claves.map(k => QJ_PRIO_COLOR[k] || '#2a78d6'), borderRadius: 5 }] },
    options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false,
      plugins: { legend: { display: false },
        tooltip: { callbacks: { label: i => ` ${i.raw} (${Math.round(i.raw / total * 100)}%)` } } },
      scales: { x: { beginAtZero: true, ticks: { precision: 0 } } } },
  })
  setText('ch-prio-sub', c['Urgente'] ? `${c['Urgente']} urgente${c['Urgente'] !== 1 ? 's' : ''}` : '')
}

// Gravedad para el usuario (rampa de severidad, ordenada)
const QJ_GRAV_ORDEN = ['Sin daño', 'Bajo', 'Moderado', 'Grave']
const QJ_GRAV_COLOR = { 'Sin daño': '#1baf7a', 'Bajo': '#eda100', 'Moderado': '#eb6834', 'Grave': '#dc2626' }
function qjChartGravedad() {
  const c = qjContarSeg('gravedad')
  const claves = QJ_GRAV_ORDEN.filter(k => c[k])
  if (!claves.length) { qjVacio('ch-grav', 'Sin datos de gravedad en el periodo'); return }
  const total = claves.reduce((s, k) => s + c[k], 0)
  const cv = qjPrep('ch-grav'); if (!cv) return
  _qjCharts['ch-grav'] = new Chart(cv, {
    type: 'bar',
    data: { labels: claves,
      datasets: [{ label: 'Registros', data: claves.map(k => c[k]),
        backgroundColor: claves.map(k => QJ_GRAV_COLOR[k]), borderRadius: 5 }] },
    options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false,
      plugins: { legend: { display: false },
        tooltip: { callbacks: { label: i => ` ${i.raw} (${Math.round(i.raw / total * 100)}%)` } } },
      scales: { x: { beginAtZero: true, ticks: { precision: 0 } } } },
  })
  const graves = (c['Moderado'] || 0) + (c['Grave'] || 0)
  setText('ch-grav-sub', graves ? `${graves} moderada(s)/grave(s)` : '')
}

// Clasificación (top 10, barras horizontales, un color)
function qjChartClasif() {
  const c = qjContarSeg('clasificacion')
  const top = Object.keys(c).sort((a, b) => c[b] - c[a]).slice(0, 10)
  if (!top.length) { qjVacio('ch-clasif', 'Sin datos de clasificación en el periodo'); return }
  const cv = qjPrep('ch-clasif'); if (!cv) return
  _qjCharts['ch-clasif'] = new Chart(cv, {
    type: 'bar',
    data: { labels: top.map(k => k.length > 26 ? k.slice(0, 26) + '…' : k),
      datasets: [{ label: 'Registros', data: top.map(k => c[k]),
        backgroundColor: '#2a78d6', borderRadius: 5 }] },
    options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false,
      plugins: { legend: { display: false },
        tooltip: { callbacks: { title: i => top[i[0].dataIndex] } } },
      scales: { x: { beginAtZero: true, ticks: { precision: 0 } }, y: { ticks: { font: { size: 11 } } } } },
  })
}

function qjRellenarMeses(claves) {
  if (claves.length < 2) return claves
  const out = []
  let [y, m] = claves[0].split('-').map(Number)
  const [fy, fm] = claves[claves.length - 1].split('-').map(Number)
  while (y < fy || (y === fy && m <= fm)) {
    out.push(`${y}-${String(m).padStart(2, '0')}`)
    m++; if (m > 12) { m = 1; y++ }
  }
  return out.length > 60 ? claves : out
}
function qjFmtMes(ym) {
  const [y, m] = ym.split('-')
  const M = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic']
  return `${M[+m - 1]} ${y.slice(2)}`
}

// ── Modal helpers ─────────────────────────────────────────────────
function openModal(id)  { document.getElementById(id)?.classList.add('open') }
function closeModal(id) { document.getElementById(id)?.classList.remove('open') }

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.modal-overlay').forEach(overlay => {
    overlay.addEventListener('click', e => {
      if (e.target === overlay) overlay.classList.remove('open')
    })
  })
})

// ── Modal: NUEVO / EDITAR ─────────────────────────────────────────
// Folio: bloqueado por defecto (autogenerado); el lápiz lo desbloquea.
function lockFolio() {
  const inp = document.getElementById('nq-folio')
  const btn = document.getElementById('btn-edit-folio')
  if (!inp) return
  inp.setAttribute('readonly', '')
  inp.style.background = '#f1f5f9'
  inp.style.color = 'var(--txt3)'
  if (btn) { btn.innerHTML = '<i class="fa-solid fa-pen"></i>'; btn.title = 'Editar folio manualmente' }
}

function toggleFolioEdit() {
  const inp = document.getElementById('nq-folio')
  const btn = document.getElementById('btn-edit-folio')
  if (!inp) return
  if (inp.hasAttribute('readonly')) {
    // Desbloquear para captura manual
    inp.removeAttribute('readonly')
    inp.style.background = '#fff'
    inp.style.color = 'var(--txt1)'
    inp.focus(); inp.select()
    if (btn) { btn.innerHTML = '<i class="fa-solid fa-lock"></i>'; btn.title = 'Bloquear folio' }
  } else {
    lockFolio()
  }
}

async function openNewQJ() {
  _editMode    = false
  _currentQJId = null

  // Limpiar campos
  const fields = ['nq-nombre','nq-telefono','nq-personal',
                  'nq-descripcion','nq-presenta','nq-recibe','nq-calidad']
  fields.forEach(id => setVal(id, ''))
  setVal('nq-tipo', '')
  setVal('nq-departamento', '')
  qjSetLocation('')
  _pendingFiles = []
  _editAdjuntos = []
  renderQjAdjuntosForm()
  setVal('nq-fecha', new Date().toISOString().split('T')[0])
  setVal('nq-folio', '')
  lockFolio()

  // Título del modal
  const ttl = document.getElementById('modal-new-ttl')
  if (ttl) ttl.innerHTML = 'Registrar Solicitud <small>Recepción de felicitaciones, sugerencias o quejas — FT-CA-24</small>'

  // Abrir modal de inmediato
  openModal('modal-new-qj')

  // Generar folio sugerido en segundo plano (no bloqueante)
  try {
    const { count } = await db.from('quejas').select('id', { count: 'exact', head: true })
    const year = new Date().getFullYear()
    const num  = String((count || 0) + 1).padStart(2, '0')
    setVal('nq-folio', `QJ-${year}-${num}`)
  } catch (e) {
    // Si no se pudo sugerir, se deja vacío: el usuario lo escribe o el
    // trigger de Supabase lo genera al guardar.
    setVal('nq-folio', '')
  }
}

function openEditQJFromTable(id) {
  _currentQJId = id
  _editMode    = true
  const r = _allQJ.find(x => x.id === id)
  if (!r) return

  setVal('nq-fecha',        r.fecha || '')
  setVal('nq-folio',        r.folio || '')
  lockFolio()
  setVal('nq-nombre',       r.nombre_paciente || '')
  setVal('nq-tipo',         r.tipo || '')
  qjSetLocation(r.habitacion || '')
  setVal('nq-telefono',     r.telefono || '')
  _pendingFiles = []
  loadAdjuntos(id).then(a => { _editAdjuntos = a; renderQjAdjuntosForm() })
  setVal('nq-departamento', r.departamento || '')
  setVal('nq-personal',     r.personal_involucrado || '')
  setVal('nq-descripcion',  r.descripcion || '')
  setVal('nq-presenta',     r.nombre_presenta || '')
  setVal('nq-recibe',       r.nombre_recibe || '')
  setVal('nq-calidad',      r.nombre_calidad || '')

  const ttlEdit = document.getElementById('modal-new-ttl')
  if (ttlEdit) ttlEdit.innerHTML = `Editar — ${esc(r.folio)} <small>${tipoLabel(r.tipo)}</small>`

  openModal('modal-new-qj')
}

async function submitNewQJ() {
  const btn         = document.getElementById('btn-save-qj')
  const fecha       = document.getElementById('nq-fecha')?.value
  const folio       = document.getElementById('nq-folio')?.value.trim()
  const nombre      = document.getElementById('nq-nombre')?.value.trim()
  const tipo        = document.getElementById('nq-tipo')?.value
  const habitacion  = qjGetLocation()
  const telefono    = document.getElementById('nq-telefono')?.value.trim()
  const departamento= document.getElementById('nq-departamento')?.value
  const personal    = document.getElementById('nq-personal')?.value.trim()
  const descripcion = document.getElementById('nq-descripcion')?.value.trim()
  const presenta    = document.getElementById('nq-presenta')?.value.trim()
  const recibe      = document.getElementById('nq-recibe')?.value.trim()
  const calidad     = document.getElementById('nq-calidad')?.value.trim()

  if (!fecha)       { showToast('La fecha es obligatoria.', 'red'); return }
  if (!tipo)        { showToast('Selecciona el tipo de solicitud.', 'red'); return }
  if (!descripcion) { showToast('La descripción es obligatoria.', 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const payload = {
    fecha, folio: folio || null,
    nombre_paciente:      nombre      || null,
    tipo,
    habitacion:           habitacion  || null,
    telefono:             telefono    || null,
    departamento:         departamento|| null,
    personal_involucrado: personal    || null,
    descripcion,
    nombre_presenta:      presenta    || null,
    nombre_recibe:        recibe      || null,
    nombre_calidad:       calidad     || null,
    updated_at:           new Date().toISOString()
  }

  let error, quejaId = _currentQJId
  if (_editMode && _currentQJId) {
    ;({ error } = await db.from('quejas').update(payload).eq('id', _currentQJId))
  } else {
    payload.status     = 'pendiente'
    payload.created_by = _user.id
    let data
    ;({ data, error } = await db.from('quejas').insert(payload).select('id').single())
    quejaId = data?.id
  }

  if (error) {
    btn.disabled = false
    btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar'
    showToast('Error al guardar: ' + error.message, 'red'); return
  }

  // Subir las imágenes pendientes (la queja ya existe)
  if (quejaId && _pendingFiles.length) {
    btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Subiendo imágenes…'
    const res = await uploadPendingFiles(quejaId)
    if (!res.ok) {
      showToast(`La solicitud se guardó, pero una imagen falló: ${res.error}`, 'red')
    }
  }
  _pendingFiles = []

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar'

  showToast(_editMode ? 'Registro actualizado.' : 'Solicitud registrada correctamente.', 'green')
  closeModal('modal-new-qj')
  await loadQuejas()
}

// ── Modal: DETALLE ────────────────────────────────────────────────
// ── Seguimiento y gestión (ciclo completo del buzón) ─────────────
// Los campos se guardan en la columna JSON quejas.seguimiento.
const SEG_GRUPOS = [
  { titulo: 'Validación y clasificación', campos: [
    { k: 'procede',         l: 'Procede',           t: 'select', o: ['SI','No'] },
    { k: 'categoria',       l: 'Categoría',         t: 'select', o: ['Queja','Sugerencia','Felicitación'] },
    { k: 'priorizacion',    l: 'Priorización',      t: 'select', o: ['Ordinaria','Urgente'] },
    { k: 'gravedad',        l: 'Gravedad para el usuario', t: 'select', o: ['Sin daño','Bajo','Moderado','Grave'] },
    { k: 'clasificacion',   l: 'Clasificación',     t: 'select', o: ['Atención al usuario','Capacidad instalada','Gasto de bolsillo','Medicamentos','Otro'] },
    { k: 'subclasificacion',l: 'Subclasificación',  t: 'select', o: ['Trato digno','Proceso','Infraestructura','Comunicación efectiva','Áreas administrativas','Facturación','Seguridad','Cobros injustificados','Equipo y mobiliario','Medicamentos','Atención recibida','Alimentos','Tiempo de espera','Otro'] },
    { k: 'origen_seg',      l: 'Origen',            t: 'select', o: ['Encuesta','Buzón','Físico','Otros medios','Visita','Jefatura de Calidad'] },
    { k: 'fecha_validacion',l: 'Fecha de validación', t: 'date' },
    { k: 'hora_validacion', l: 'Hora de validación', t: 'time' },
  ]},
  { titulo: 'Investigación', campos: [
    { k: 'revision_expediente', l: 'Revisión de expediente', t: 'select', o: ['SI','NO','No aplica'] },
    { k: 'llamada_entrevista',  l: 'Llamada / entrevista',   t: 'select', o: ['Llamada','Entrevista','No aplica'] },
    // Se muestran solo si es Llamada
    { k: 'intentos_llamada',    l: 'Intentos de llamada (máx 3)', t: 'intentos', showWhen: { key: 'llamada_entrevista', values: ['Llamada'] } },
    { k: 'respuesta_llamada',   l: 'Respuesta a la llamada', t: 'select', o: ['SI','NO','No aplica'], showWhen: { key: 'llamada_entrevista', values: ['Llamada'] } },
    // Se muestran solo si es Entrevista
    { k: 'recibe_llamada',      l: 'Quién recibe / entrevistado', t: 'text', showWhen: { key: 'llamada_entrevista', values: ['Entrevista'] } },
    { k: 'investiga',           l: 'Quién realiza la investigación', t: 'text', showWhen: { key: 'llamada_entrevista', values: ['Entrevista'] } },
    // Siempre visible
    { k: 'investigacion',       l: 'Investigación (detalle)', t: 'textarea' },
  ]},
  { titulo: 'Notificación al área', campos: [
    { k: 'medio_notificacion', l: 'Medio de notificación', t: 'select', o: ['Oficio','Llamada','Mensaje de texto','Correo electrónico','Personal','No realizada'] },
    { k: 'fecha_notificacion', l: 'Fecha de notificación', t: 'date' },
    { k: 'persona_notifica',   l: 'Persona que notifica',  t: 'text' },
    { k: 'numero_oficio',      l: 'Número de oficio (ver Oficios)', t: 'text' },
  ]},
  { titulo: 'Resolución y cierre', campos: [
    { k: 'resolucion',            l: 'Resolución', t: 'textarea' },
    { k: 'fecha_resolucion',      l: 'Fecha de resolución', t: 'date' },
    { k: 'notif_solicitante',     l: 'Notificación al solicitante', t: 'select', o: ['SI','NO','No aplica'] },
    { k: 'fecha_notif_solicitante', l: 'Fecha de notificación al solicitante', t: 'date' },
    { k: 'observaciones',         l: 'Observaciones', t: 'textarea' },
  ]},
]

function segCampoHtml(c, val) {
  const v = val == null ? '' : String(val)
  const id = 'seg-' + c.k
  // Atributos para mostrar/ocultar según otro campo (llamada/entrevista)
  const sw = c.showWhen
    ? ` data-sw-key="${esc(c.showWhen.key)}" data-sw-vals="${esc(c.showWhen.values.join('|'))}"`
    : ''

  let inner, full = false
  if (c.t === 'select') {
    // Conservar un valor histórico aunque no esté en la lista de opciones
    const known = c.o.includes(v)
    const opts = ['<option value="">—</option>']
      .concat(c.o.map(o => `<option value="${esc(o)}"${o === v ? ' selected' : ''}>${esc(o)}</option>`))
    if (v && !known) opts.push(`<option value="${esc(v)}" selected>${esc(v)}</option>`)
    inner = `<label>${esc(c.l)}</label><select id="${id}">${opts.join('')}</select>`
  } else if (c.t === 'textarea') {
    full = true
    inner = `<label>${esc(c.l)}</label><textarea id="${id}" rows="2">${esc(v)}</textarea>`
  } else if (c.t === 'intentos') {
    const n = parseInt(v, 10) || 0
    const boxes = [1, 2, 3].map(i =>
      `<label class="seg-int" title="Llamada ${i}"><input type="checkbox" data-i="${i}"${i <= n ? ' checked' : ''}><i class="fa-solid fa-phone"></i></label>`).join('')
    inner = `<label>${esc(c.l)}</label>
      <div class="seg-intentos" data-seg="${c.k}" onchange="segIntentos(event, this)">${boxes}</div>`
  } else {
    const type = c.t === 'date' ? 'date' : c.t === 'time' ? 'time' : 'text'
    inner = `<label>${esc(c.l)}</label><input type="${type}" id="${id}" value="${esc(v)}">`
  }
  return `<div class="seg-f${full ? ' seg-f-full' : ''}" id="segwrap-${c.k}"${sw}>${inner}</div>`
}

// Muestra/oculta los campos condicionales según su campo controlador
function segApplyConditions() {
  document.querySelectorAll('#dq-gestion-form [data-sw-key]').forEach(el => {
    const ctrl = document.getElementById('seg-' + el.dataset.swKey)
    const vals = (el.dataset.swVals || '').split('|')
    el.style.display = (ctrl && vals.includes(ctrl.value)) ? '' : 'none'
  })
}

// Casillas de intentos: secuenciales (marcar la i llena 1..i; desmarcar deja 1..i-1)
function segIntentos(e, cont) {
  const i = +e.target.dataset.i
  const nivel = e.target.checked ? i : i - 1
  cont.querySelectorAll('input').forEach(inp => { inp.checked = (+inp.dataset.i) <= nivel })
}

function renderGestion(seg) {
  const cont = document.getElementById('dq-gestion-form')
  if (!cont) return
  seg = seg || {}
  cont.innerHTML = SEG_GRUPOS.map(g => `
    <div class="seg-grupo">
      <div class="seg-grupo-t">${esc(g.titulo)}</div>
      <div class="seg-grid">${g.campos.map(c => segCampoHtml(c, seg[c.k])).join('')}</div>
    </div>`).join('')

  // Campos condicionales (llamada / entrevista): re-evaluar al cambiar el control
  const ctrlKeys = [...new Set([...cont.querySelectorAll('[data-sw-key]')].map(e => e.dataset.swKey))]
  ctrlKeys.forEach(k => {
    const s = document.getElementById('seg-' + k)
    if (s) s.addEventListener('change', segApplyConditions)
  })
  segApplyConditions()
}

async function saveSeguimiento() {
  if (!_currentQJId) return
  const seg = {}
  SEG_GRUPOS.forEach(g => g.campos.forEach(c => {
    let v = ''
    if (c.t === 'intentos') {
      const cont = document.querySelector(`.seg-intentos[data-seg="${c.k}"]`)
      const n = cont ? cont.querySelectorAll('input:checked').length : 0
      v = n ? String(n) : ''
    } else {
      const el = document.getElementById('seg-' + c.k)
      v = el ? el.value.trim() : ''
    }
    if (v) seg[c.k] = v
  }))
  const btn = document.getElementById('btn-save-gestion')
  if (btn) { btn.disabled = true; btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…' }
  const { error } = await db.from('quejas')
    .update({ seguimiento: seg, updated_at: new Date().toISOString() })
    .eq('id', _currentQJId)
  if (btn) { btn.disabled = false; btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar seguimiento' }
  if (error) {
    if (/seguimiento/.test(error.message)) {
      showToast('Falta ejecutar la migración sql/quejas_seguimiento_setup.sql en Supabase.', 'red')
    } else {
      showToast('Error al guardar: ' + error.message, 'red')
    }
    return
  }
  // Actualiza el registro en memoria para no perder lo capturado
  const r = _allQJ.find(x => x.id === _currentQJId)
  if (r) r.seguimiento = seg
  showToast('Seguimiento guardado.', 'green')
}

async function openDetail(id) {
  _currentQJId = id
  const r = _allQJ.find(x => x.id === id)
  if (!r) return

  setText('dq-folio-ttl',    r.folio)
  setText('dq-tipo-ttl',     tipoLabel(r.tipo))
  setText('dq-folio',        r.folio)
  setText('dq-fecha',        fmtDate(r.fecha))
  setText('dq-tipo',         tipoLabel(r.tipo))
  setText('dq-status',       statusLabel(r.status))
  setText('dq-nombre',       r.nombre_paciente   || '—')
  setText('dq-habitacion',   r.habitacion        || '—')
  setText('dq-telefono',     r.telefono          || '—')
  setText('dq-departamento', r.departamento      || '—')
  setText('dq-personal',     r.personal_involucrado || '—')
  setText('dq-descripcion',  r.descripcion       || '—')
  setText('dq-presenta',     r.nombre_presenta   || '—')
  setText('dq-recibe',       r.nombre_recibe     || '—')
  setText('dq-calidad',      r.nombre_calidad    || '—')

  const canManage = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)

  // Barra de estado
  const bar = document.getElementById('dq-status-bar')
  if (bar && canManage && r.status !== 'cerrado') {
    bar.innerHTML = `
      <div class="status-action-bar">
        <p><i class="fa-solid fa-circle-dot" style="margin-right:6px"></i>
           Estado actual: <strong>${statusLabel(r.status)}</strong></p>
        <div class="btns">
          ${r.status === 'pendiente'  ? `<button class="btn-primary" onclick="quickStatus('en_proceso')"><i class="fa-solid fa-play"></i> Iniciar proceso</button>` : ''}
          ${r.status === 'en_proceso' ? `<button class="btn-primary" onclick="quickStatus('resuelto')"><i class="fa-solid fa-check"></i> Marcar resuelto</button>` : ''}
          ${r.status === 'resuelto'   ? `<button class="btn-secondary" onclick="quickStatus('cerrado')"><i class="fa-solid fa-lock"></i> Cerrar</button>` : ''}
        </div>
      </div>`
  } else if (bar) {
    bar.innerHTML = ''
  }

  // Botón editar
  const btnEdit = document.getElementById('btn-edit-qj')
  if (btnEdit) btnEdit.style.display = canManage ? 'inline-flex' : 'none'

  // Seguimiento
  await loadNotas(id)

  // Panel de nota (solo managers)
  const notaWrap = document.getElementById('dq-nota-wrap')
  if (notaWrap) notaWrap.style.display = canManage ? 'block' : 'none'
  setVal('dq-nota-text', '')
  setVal('dq-new-status', '')

  renderDetailAdjuntos(id)

  // Seguimiento y gestión (solo Calidad/managers)
  const gestWrap = document.getElementById('dq-gestion-wrap')
  if (gestWrap) gestWrap.style.display = canManage ? 'block' : 'none'
  if (canManage) renderGestion(r.seguimiento || {})

  openModal('modal-detail-qj')
}

// Miniaturas (solo lectura) en el modal de detalle.
async function renderDetailAdjuntos(quejaId) {
  const wrap = document.getElementById('dq-adjuntos-wrap')
  const cont = document.getElementById('dq-adjuntos')
  if (!wrap || !cont) return
  cont.innerHTML = ''
  const adj = await loadAdjuntos(quejaId)
  if (!adj.length) { wrap.style.display = 'none'; return }
  wrap.style.display = 'block'
  for (const a of adj) {
    const div = document.createElement('div')
    div.className = 'qj-adj'
    div.innerHTML = `<img alt="${esc(a.file_name || '')}">`
    cont.appendChild(div)
    const url = await qjSignedUrl(a.file_path)
    if (url) {
      const img = div.querySelector('img')
      img.src = url
      img.onclick = () => window.open(url, '_blank')
    }
  }
}

function openEditQJ() {
  closeModal('modal-detail-qj')
  openEditQJFromTable(_currentQJId)
}

async function quickStatus(newStatus) {
  if (!_currentQJId) return
  const { error } = await db.from('quejas')
    .update({ status: newStatus, updated_at: new Date().toISOString() })
    .eq('id', _currentQJId)
  if (error) { showToast('Error: ' + error.message, 'red'); return }
  showToast('Estado actualizado.', 'green')
  closeModal('modal-detail-qj')
  await loadQuejas()
}

// ── Notas de seguimiento ─────────────────────────────────────────
async function loadNotas(qjId) {
  const wrap = document.getElementById('dq-seguimiento-wrap')
  const list = document.getElementById('dq-seguimiento-list')
  if (!wrap || !list) return

  const { data } = await db
    .from('quejas_notas')
    .select('*, author:created_by(full_name)')
    .eq('queja_id', qjId)
    .order('created_at', { ascending: true })

  if (!data || data.length === 0) {
    wrap.style.display = 'none'
    return
  }

  wrap.style.display = 'block'
  list.innerHTML = data.map(n => `
    <div class="nota-item">
      <div class="nota-meta">
        <strong>${esc(n.author?.full_name || '—')}</strong> ·
        ${fmtDateTime(n.created_at)}
        ${n.status_change ? `<span class="nota-status-change"><i class="fa-solid fa-arrow-right"></i> ${statusLabel(n.status_change)}</span>` : ''}
      </div>
      <div class="nota-texto">${esc(n.nota)}</div>
    </div>
  `).join('')
}

async function submitNota() {
  const btn   = document.getElementById('btn-nota')
  const texto = document.getElementById('dq-nota-text')?.value.trim()
  const statusSel = document.getElementById('dq-new-status')
  const newStatus = statusSel?.value || null

  // Se permite guardar con nota, con cambio de estado, o ambos.
  if (!texto && !newStatus) {
    showToast('Escribe una nota o selecciona un nuevo estado.', 'red'); return
  }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i>'

  // Si solo se cambia el estado (sin nota), se deja constancia en el historial.
  const statusLbl = newStatus && statusSel.selectedOptions[0]
    ? statusSel.selectedOptions[0].textContent.trim() : ''
  const notaPayload = {
    queja_id:      _currentQJId,
    nota:          texto || `Estado cambiado a "${statusLbl}"`,
    status_change: newStatus || null,
    created_by:    _user.id
  }

  const { error: notaErr } = await db.from('quejas_notas').insert(notaPayload)
  if (notaErr) {
    showToast('Error al guardar nota: ' + notaErr.message, 'red')
    btn.disabled = false
    btn.innerHTML = '<i class="fa-solid fa-paper-plane"></i> Guardar nota'
    return
  }

  if (newStatus) {
    await db.from('quejas')
      .update({ status: newStatus, updated_at: new Date().toISOString() })
      .eq('id', _currentQJId)
  }

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-paper-plane"></i> Guardar nota'
  setVal('dq-nota-text', '')
  setVal('dq-new-status', '')

  showToast('Nota guardada.', 'green')
  await loadNotas(_currentQJId)
  await loadQuejas()

  // Refrescar barra de estado si cambió el status
  if (newStatus) {
    const r = _allQJ.find(x => x.id === _currentQJId)
    if (r) { r.status = newStatus; openDetail(_currentQJId) }
  }
}

// ── Exportar CSV ─────────────────────────────────────────────────
function exportCSV() {
  const rows = _filteredQJ.length > 0 ? _filteredQJ : _allQJ
  if (rows.length === 0) { showToast('No hay registros para exportar.', 'red'); return }

  const headers = ['Folio','Fecha','Tipo','Nombre','Habitación','Teléfono',
                   'Departamento','Personal','Descripción','Presentó','Recibió','Calidad','Estado']
  const csv = [headers, ...rows.map(r => [
    r.folio, r.fecha, tipoLabel(r.tipo),
    r.nombre_paciente || '', r.habitacion || '', r.telefono || '',
    r.departamento || '', r.personal_involucrado || '', r.descripcion || '',
    r.nombre_presenta || '', r.nombre_recibe || '', r.nombre_calidad || '',
    statusLabel(r.status)
  ])].map(row => row.map(c => `"${String(c).replace(/"/g,'""')}"`).join(',')).join('\n')

  const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8;' })
  const a = document.createElement('a')
  a.href = URL.createObjectURL(blob)
  a.download = `QuejasYSugerencias_${new Date().toISOString().split('T')[0]}.csv`
  a.click()
  showToast('CSV exportado.', 'green')
}

// ── Helpers ───────────────────────────────────────────────────────
function tipoPill(tipo) {
  const icons = { queja:'fa-face-angry', sugerencia:'fa-lightbulb', felicitacion:'fa-star' }
  const icon  = icons[tipo] || 'fa-comment'
  return `<span class="pill-tipo pill-${tipo}">
    <i class="fa-solid ${icon}"></i> ${tipoLabel(tipo)}
  </span>`
}

function tipoLabel(t) {
  return { queja:'Queja', sugerencia:'Sugerencia', felicitacion:'Felicitación' }[t] || t || '—'
}

function statusPill(s) {
  return `<span class="pill-status pill-${s}">${statusLabel(s)}</span>`
}

function statusLabel(s) {
  return { pendiente:'Pendiente', en_proceso:'En Proceso', resuelto:'Resuelto', cerrado:'Cerrado' }[s] || s || '—'
}

function fmtDate(d) {
  if (!d) return '—'
  return new Date(d + 'T12:00:00').toLocaleDateString('es-MX',
    { day: '2-digit', month: 'short', year: 'numeric' })
}

function fmtDateTime(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('es-MX',
    { day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' })
}

function setText(id, val) {
  const el = document.getElementById(id)
  if (el) el.textContent = val ?? '—'
}

function setVal(id, val) {
  const el = document.getElementById(id)
  if (el) el.value = val ?? ''
}

function esc(str) {
  if (!str) return ''
  return String(str)
    .replace(/&/g,'&amp;').replace(/</g,'&lt;')
    .replace(/>/g,'&gt;').replace(/"/g,'&quot;')
}

function showLoading() {
  const tbody = document.getElementById('qj-tbody')
  if (tbody) tbody.innerHTML = `
    <tr><td colspan="8" style="text-align:center;padding:48px;color:var(--txt3)">
      <i class="fa-solid fa-spinner fa-spin" style="font-size:1.5rem"></i>
    </td></tr>`
  setText('qj-count', 'Cargando…')
}

function showError(msg) {
  const tbody = document.getElementById('qj-tbody')
  if (tbody) tbody.innerHTML = `
    <tr><td colspan="8" class="table-empty">
      <i class="fa-solid fa-circle-exclamation" style="color:var(--red)"></i>
      <strong>Error al cargar</strong>${esc(msg)}
    </td></tr>`
}

function showToast(msg, color = 'green') {
  const old = document.getElementById('sgc-toast')
  if (old) old.remove()
  const bg = color === 'green' ? '#16a34a' : color === 'red' ? '#dc2626' : '#2563eb'
  const t = document.createElement('div')
  t.id = 'sgc-toast'
  t.style.cssText = `position:fixed;bottom:28px;right:28px;z-index:9999;
    background:${bg};color:#fff;padding:13px 22px;border-radius:12px;
    font-size:0.857rem;font-weight:600;font-family:var(--font);
    box-shadow:0 8px 28px rgba(0,0,0,.22);max-width:380px;line-height:1.4;`
  t.textContent = msg
  document.body.appendChild(t)
  setTimeout(() => t.remove(), 3800)
}

// ── Arrancar ──────────────────────────────────────────────────────
initQuejas()
