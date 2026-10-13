// ─── Jornadas Médicas — Inscritos (panel admin) ─────────────────────
// Lee de la tabla jornadas_participantes (el rol autenticado tiene SELECT).

let _part = []            // participantes
let _tallerName = {}      // num -> nombre

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
  setText('sb-user-name', auth.profile?.full_name || auth.user.email.split('@')[0])
  setText('sb-user-role', auth.profile?.roles?.display_name || 'Usuario')
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
  if (d) {
    setText('k-total', d.registrados)
    setText('k-total-sub', 'de ' + d.cupo_total + ' de cupo')
    setText('k-rest', d.lugares_restantes)
    const enTall = (d.talleres || []).reduce((a, t) => a + (t.ocupados || 0), 0)
    const cupoTall = (d.talleres || []).reduce((a, t) => a + (t.cupo || 0), 0)
    setText('k-tall', enTall)
    setText('k-tall-sub', 'de ' + cupoTall + ' lugares')
    ;(d.talleres || []).forEach(t => { _tallerName[t.num] = t.nombre })
  }

  if (parts.error) {
    $('jm-count').textContent = 'Error al cargar: ' + parts.error.message
    $('jm-body').innerHTML = `<tr><td colspan="17" class="jm-empty">No se pudieron cargar los inscritos.</td></tr>`
    return
  }
  _part = parts.data || []
  renderTabla()
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
