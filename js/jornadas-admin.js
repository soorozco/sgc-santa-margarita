// ─── Jornadas Médicas — Inscritos (panel admin) ─────────────────────
// Lee de la tabla jornadas_participantes (el rol autenticado tiene SELECT).

let _part = []            // participantes
let _tallerName = {}      // num -> nombre
let _talleres = []        // [{num,nombre,cupo,ocupados}]
let _charts = {}          // instancias Chart.js
let _role = 'lector'
let _disp = null          // última disponibilidad

const $ = id => document.getElementById(id)
const setText = (id, t) => { const e = $(id); if (e) e.textContent = t }
const esc = s => String(s ?? '').replace(/[&<>"]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]))

function fmtFecha(d) {
  if (!d) return '—'
  const dt = new Date(d)
  return isNaN(dt) ? '—' : dt.toLocaleDateString('es-MX', { day: '2-digit', month: 'short', year: 'numeric' })
}

document.addEventListener('DOMContentLoaded', init)

async function init() {
  const auth = await requireAuth()
  if (!auth) return
  _role = auth.profile?.roles?.name || 'lector'
  setText('sb-user-name', auth.profile?.full_name || auth.user.email.split('@')[0])
  setText('sb-user-role', auth.profile?.roles?.display_name || 'Usuario')
  // El ajuste de cupos solo para admin / responsable de calidad
  if (['administrador', 'responsable_calidad'].includes(_role)) {
    const card = $('jm-admin'); if (card) card.style.display = 'block'
  }
  const el = $('current-date')
  if (el) el.textContent = new Date().toLocaleDateString('es-MX',
    { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })
  await cargar()
}

async function cargar() {
  const [disp, parts] = await Promise.all([
    db.rpc('jornadas_disponibilidad'),
    db.from('jornadas_participantes').select('*').order('created_at', { ascending: false })
  ])

  // KPIs + nombres de taller
  const d = disp.data
  _disp = d
  if (d) {
    setText('k-total', d.registrados)
    setText('k-total-sub', 'de ' + d.cupo_total + ' de cupo')
    setText('k-rest', d.lugares_restantes)
    const enTall = (d.talleres || []).reduce((a, t) => a + (t.ocupados || 0), 0)
    const cupoTall = (d.talleres || []).reduce((a, t) => a + (t.cupo || 0), 0)
    setText('k-tall', enTall)
    setText('k-tall-sub', 'de ' + cupoTall + ' lugares')
    _talleres = d.talleres || []
    _talleres.forEach(t => { _tallerName[t.num] = t.nombre })
  }

  if (parts.error) {
    $('jm-count').textContent = 'Error al cargar: ' + parts.error.message
    $('jm-body').innerHTML = `<tr><td colspan="17" class="jm-empty">No se pudieron cargar los inscritos.</td></tr>`
    return
  }
  _part = parts.data || []
  renderTabla()
  renderCharts()
  renderCupoAdmin()
}

// ── Ajustar cupos (emergente) ───────────────────────────────────────
function renderCupoAdmin() {
  if (!$('jm-admin') || $('jm-admin').style.display === 'none') return
  if (_disp) {
    setText('cupo-total-now', `${_disp.registrados} inscritos · cupo ${_disp.cupo_total}`)
    const inT = $('cupo-total-in'); if (inT && document.activeElement !== inT) inT.value = _disp.cupo_total
  }
  $('cupo-talleres').innerHTML = _talleres.map(t => `
    <div class="cupo-row">
      <div class="cupo-lbl">Taller ${t.num}: ${esc(t.nombre)}</div>
      <div class="cupo-now">${t.ocupados} inscritos · cupo ${t.cupo}</div>
      <input type="number" id="cupo-t-${t.num}" min="${t.ocupados}" value="${t.cupo}">
      <button class="jm-btn" onclick="guardarCupo('taller', ${t.num})">Actualizar</button>
    </div>`).join('')
}

async function guardarCupo(que, taller) {
  const input = que === 'total' ? $('cupo-total-in') : $('cupo-t-' + taller)
  const cupo = parseInt(input?.value)
  if (!Number.isFinite(cupo) || cupo < 1) { alert('Escribe un número válido.'); return }

  const { data, error } = await db.rpc('jornadas_set_cupo',
    { p_que: que, p_cupo: cupo, p_taller: taller ?? null })

  if (error) { alert('Error al actualizar: ' + error.message); return }
  if (!data.ok) {
    if (data.code === 'MENOR_QUE_INSCRITOS')
      alert(`No puedes poner un cupo menor a los ya inscritos (${data.inscritos}).`)
    else if (data.code === 'CUPO_INVALIDO') alert('El cupo debe ser un número mayor a 0.')
    else alert('No se pudo actualizar (' + data.code + ').')
    return
  }
  await cargar()
  alert('Cupo actualizado correctamente.')
}

// ── Gráficas ─────────────────────────────────────────────────────────
const PALETTE = ['#163a7a','#d14e2b','#1a9d6b','#c3922f','#1b98e0','#9b5de5','#ef476f','#118ab2','#8ac926','#6a4c93','#f4a261','#5b6b66']

function agrupa(fn) {
  const m = {}
  _part.forEach(p => { const k = (fn(p) || '—') + ''; m[k] = (m[k] || 0) + 1 })
  return Object.entries(m).sort((a, b) => b[1] - a[1])
}

function renderCharts() {
  if (typeof Chart === 'undefined') return
  Object.values(_charts).forEach(c => c && c.destroy()); _charts = {}

  // Cupo de talleres — barras horizontales apiladas (ocupados / disponibles)
  const tl = _talleres.map(t => `${t.num}. ${t.nombre}`)
  _charts.taller = new Chart($('ch-taller'), {
    type: 'bar',
    data: { labels: tl, datasets: [
      { label: 'Ocupados',    data: _talleres.map(t => t.ocupados || 0), backgroundColor: '#d14e2b' },
      { label: 'Disponibles', data: _talleres.map(t => Math.max((t.cupo || 0) - (t.ocupados || 0), 0)), backgroundColor: '#e5e7eb' }
    ]},
    options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false,
      scales: { x: { stacked: true, beginAtZero: true, ticks: { precision: 0 } }, y: { stacked: true } },
      plugins: { legend: { position: 'bottom' },
        tooltip: { callbacks: { afterTitle: (it) => { const t = _talleres[it[0].dataIndex]; return `${t.ocupados} de ${t.cupo} lugares` } } } } }
  })

  // Inscritos por estado — barras horizontales
  const est = agrupa(p => p.estado)
  _charts.estado = new Chart($('ch-estado'), {
    type: 'bar',
    data: { labels: est.map(x => x[0]), datasets: [{ label: 'Inscritos', data: est.map(x => x[1]), backgroundColor: '#163a7a' }] },
    options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false,
      plugins: { legend: { display: false } }, scales: { x: { beginAtZero: true, ticks: { precision: 0 } } } }
  })

  // Inscritos por profesión — dona
  const prof = agrupa(p => p.profesion)
  _charts.prof = new Chart($('ch-prof'), {
    type: 'doughnut',
    data: { labels: prof.map(x => x[0]), datasets: [{ data: prof.map(x => x[1]), backgroundColor: prof.map((_, i) => PALETTE[i % PALETTE.length]) }] },
    options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'right' } } }
  })
}

function filtrados() {
  const q = ($('jm-search')?.value || '').toLowerCase().trim()
  if (!q) return _part
  return _part.filter(p => {
    const txt = [p.folio, p.nombre, p.email, p.profesion, p.especialidad, p.estado,
      p.municipio, p.universidad, p.institucion_procedencia, p.grado_academico]
      .join(' ').toLowerCase()
    return txt.includes(q)
  })
}

function tallerTxt(p) {
  return p.taller ? `${p.taller}. ${_tallerName[p.taller] || ''}` : '—'
}

function renderTabla() {
  const rows = filtrados()
  $('jm-count').textContent = rows.length === _part.length
    ? `${_part.length} inscrito${_part.length !== 1 ? 's' : ''}`
    : `${rows.length} de ${_part.length} inscritos`

  if (!rows.length) {
    $('jm-body').innerHTML = `<tr><td colspan="17" class="jm-empty">Sin resultados.</td></tr>`
    return
  }
  $('jm-body').innerHTML = rows.map(p => `
    <tr>
      <td class="jm-folio">${esc(p.folio)}</td>
      <td>${fmtFecha(p.created_at)}</td>
      <td>${esc(p.nombre)}</td>
      <td>${esc(p.edad ?? '—')}</td>
      <td>${esc(p.sexo || '—')}</td>
      <td>${esc(p.municipio || '—')}</td>
      <td>${esc(p.estado || '—')}</td>
      <td>${esc(p.pais || '—')}</td>
      <td>${esc(p.grado_academico || '—')}</td>
      <td>${esc(p.profesion || '—')}</td>
      <td>${esc(p.especialidad || '—')}</td>
      <td>${esc(p.universidad || '—')}</td>
      <td>${esc(p.institucion_procedencia || '—')}</td>
      <td>${esc(p.email)}</td>
      <td>${esc(p.telefono || '—')}</td>
      <td class="jm-taller">${esc(tallerTxt(p))}</td>
      <td>${esc(p.medio || '—')}</td>
    </tr>`).join('')
}

function exportarCSV() {
  const rows = filtrados()
  const cols = [
    ['folio', 'Folio'], ['created_at', 'Fecha'], ['nombre', 'Nombre'], ['edad', 'Edad'],
    ['sexo', 'Sexo'], ['municipio', 'Municipio'], ['estado', 'Estado'], ['pais', 'Pais'],
    ['grado_academico', 'Grado academico'], ['profesion', 'Profesion'], ['especialidad', 'Especialidad'],
    ['universidad', 'Universidad'], ['institucion_procedencia', 'Institucion'],
    ['email', 'Correo'], ['telefono', 'Telefono'], ['taller', 'Taller'], ['medio', 'Medio']
  ]
  const cell = v => {
    const s = v == null ? '' : String(v)
    return /[",\n;]/.test(s) ? '"' + s.replace(/"/g, '""') + '"' : s
  }
  const header = cols.map(c => c[1]).join(',')
  const body = rows.map(p => cols.map(([k]) => {
    if (k === 'created_at') return cell(fmtFecha(p[k]))
    if (k === 'taller') return cell(p.taller ? `${p.taller} - ${_tallerName[p.taller] || ''}` : '')
    return cell(p[k])
  }).join(',')).join('\n')
  const csv = '﻿' + header + '\n' + body   // BOM para acentos en Excel
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' })
  const a = document.createElement('a')
  a.href = URL.createObjectURL(blob)
  a.download = `inscritos-jornadas-${new Date().toISOString().slice(0, 10)}.csv`
  a.click()
  URL.revokeObjectURL(a.href)
}
