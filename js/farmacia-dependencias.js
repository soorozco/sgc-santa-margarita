// ─── Salidas a Madres y Casas ────────────────────────────────────
// Relación de costo de vales de dependencia: salidas de farmacia
// hacia las casas de la congregación.

let _user = null, _profile = null, _role = null
let _vales = []          // todos los vales
let _filtrados = []
let _editId = null       // id del vale en edición (null = nuevo)

// Dependencias conocidas. La captura permite escribir otras.
const DEPENDENCIAS = [
  'CASA DE ORACION',
  'CASA GENERAL',
  'CASA JUNIORAD',
  'CASA PRE-NOVISIADO',
  'HERMANAS HOSPITAL SANTA MARGARITA',
]
const ALMACENES = ['FARMACIA', 'ALMACÉN GENERAL', 'CEYE']

// ── Init ────────────────────────────────────────────────────────
async function initDep() {
  const auth = await requireAuth()
  if (!auth?.user) return
  _user = auth.user; _profile = auth.profile
  _role = auth.profile?.roles?.name || 'lector'

  requirePermission(_profile, 'farmacia_dependencias')

  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
  const dateEl = document.getElementById('current-date')
  if (dateEl) dateEl.textContent = new Date().toLocaleDateString('es-MX',
    { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })

  llenarCatalogos()
  await cargar()
}

function llenarCatalogos() {
  const dl = document.getElementById('dl-dependencias')
  if (dl) dl.innerHTML = DEPENDENCIAS.map(d => `<option value="${esc(d)}">`).join('')
  const dla = document.getElementById('dl-almacenes')
  if (dla) dla.innerHTML = ALMACENES.map(a => `<option value="${esc(a)}">`).join('')
}

// ── Carga ───────────────────────────────────────────────────────
async function cargar() {
  const tbody = document.getElementById('vales-body')
  tbody.innerHTML = fila_msg('Cargando…')

  const { data, error } = await db.from('pharmacy_dependency_vouchers')
    .select('*')
    .order('fecha', { ascending: false })
    .order('folio', { ascending: false })

  if (error) {
    tbody.innerHTML = fila_msg(
      `Error: ${esc(error.message)}` +
      (error.message.includes('pharmacy_dependency_vouchers')
        ? ' — falta ejecutar la migración sql/farmacia_dependencias_setup.sql en Supabase'
        : ''), '#991b1b')
    return
  }

  _vales = data || []
  llenarFiltroMes()
  llenarFiltroDep()
  aplicarFiltros()
}

// ── Filtros ─────────────────────────────────────────────────────
function llenarFiltroMes() {
  const sel = document.getElementById('f-mes')
  if (!sel) return
  const actual = sel.value
  const meses = [...new Set(_vales.map(v => (v.fecha || '').slice(0, 7)).filter(Boolean))].sort().reverse()
  sel.innerHTML = '<option value="">Todos los meses</option>' +
    meses.map(m => `<option value="${m}">${fmtMes(m)}</option>`).join('')
  if (meses.includes(actual)) sel.value = actual
}

function llenarFiltroDep() {
  const sel = document.getElementById('f-dep')
  if (!sel) return
  const actual = sel.value
  const deps = [...new Set(_vales.map(v => v.dependencia).filter(Boolean))].sort((a, b) => a.localeCompare(b, 'es'))
  sel.innerHTML = '<option value="">Todas las dependencias</option>' +
    deps.map(d => `<option value="${esc(d)}">${esc(d)}</option>`).join('') +
    (_vales.some(v => !v.dependencia) ? '<option value="__SIN__">(sin dependencia)</option>' : '')
  if (actual) sel.value = actual
}

function aplicarFiltros() {
  const mes = document.getElementById('f-mes')?.value || ''
  const dep = document.getElementById('f-dep')?.value || ''
  const q   = (document.getElementById('f-busca')?.value || '').toLowerCase().trim()

  _filtrados = _vales.filter(v => {
    if (mes && (v.fecha || '').slice(0, 7) !== mes) return false
    if (dep === '__SIN__') { if (v.dependencia) return false }
    else if (dep && v.dependencia !== dep) return false
    if (q) {
      const txt = [v.folio, v.dependencia, v.almacen, v.observaciones]
        .filter(Boolean).join(' ').toLowerCase()
      if (!txt.includes(q)) return false
    }
    return true
  })

  pintarKPIs()
  pintarTabla()
}

function limpiarFiltros() {
  ;['f-mes', 'f-dep', 'f-busca'].forEach(id => {
    const el = document.getElementById(id); if (el) el.value = ''
  })
  aplicarFiltros()
}

// ── KPIs ────────────────────────────────────────────────────────
function pintarKPIs() {
  const total = _filtrados.reduce((s, v) => s + num(v.total), 0)
  setText('kpi-total', money(total))
  setText('kpi-vales', _filtrados.length)

  // Dependencia con mayor importe dentro del filtro
  const porDep = {}
  _filtrados.forEach(v => {
    const k = v.dependencia || '(sin dependencia)'
    porDep[k] = (porDep[k] || 0) + num(v.total)
  })
  const top = Object.entries(porDep).sort((a, b) => b[1] - a[1])[0]
  setText('kpi-top-dep', top ? top[0] : '—')
  setText('kpi-top-monto', top ? money(top[1]) : '')

  const prom = _filtrados.length ? total / _filtrados.length : 0
  setText('kpi-promedio', money(prom))
}

// ── Tabla ───────────────────────────────────────────────────────
function pintarTabla() {
  const tbody = document.getElementById('vales-body')
  if (!_filtrados.length) {
    tbody.innerHTML = fila_msg(_vales.length
      ? 'Ningún vale coincide con los filtros.'
      : 'Todavía no hay vales capturados. Usa «Nuevo vale» para registrar el primero.')
    setText('tabla-count', '')
    return
  }

  tbody.innerHTML = _filtrados.map(v => `
    <tr>
      <td style="white-space:nowrap">${fmtFecha(v.fecha)}</td>
      <td>${v.dependencia
        ? esc(v.dependencia)
        : '<span class="sin-dato">(sin dependencia)</span>'}</td>
      <td>${esc(v.almacen || '—')}</td>
      <td style="font-variant-numeric:tabular-nums">${esc(v.folio || '—')}</td>
      <td style="text-align:right;font-weight:700;font-variant-numeric:tabular-nums">${money(v.total)}</td>
      <td class="obs">${v.observaciones ? esc(v.observaciones) : '—'}</td>
      <td style="text-align:center;white-space:nowrap">
        <button class="btn-ico" onclick="editarVale('${v.id}')" title="Editar">
          <i class="fa-solid fa-pen-to-square"></i></button>
        <button class="btn-ico del" onclick="borrarVale('${v.id}')" title="Eliminar">
          <i class="fa-solid fa-trash"></i></button>
      </td>
    </tr>`).join('')

  const total = _filtrados.reduce((s, v) => s + num(v.total), 0)
  setText('tabla-count', `${_filtrados.length} vale${_filtrados.length !== 1 ? 's' : ''} · ${money(total)}`)
}

// ── Alta / edición ──────────────────────────────────────────────
function nuevoVale() {
  _editId = null
  setText('modal-title', 'Nuevo vale de dependencia')
  setVal('v-fecha', hoy())
  setVal('v-dependencia', '')
  setVal('v-almacen', 'FARMACIA')
  setVal('v-folio', '')
  setVal('v-total', '')
  setVal('v-observaciones', '')
  abrirModal()
}

function editarVale(id) {
  const v = _vales.find(x => x.id === id)
  if (!v) return
  _editId = id
  setText('modal-title', `Editar vale ${v.folio || ''}`.trim())
  setVal('v-fecha', v.fecha || hoy())
  setVal('v-dependencia', v.dependencia || '')
  setVal('v-almacen', v.almacen || 'FARMACIA')
  setVal('v-folio', v.folio || '')
  setVal('v-total', v.total ?? '')
  setVal('v-observaciones', v.observaciones || '')
  abrirModal()
}

async function guardarVale() {
  const fecha = document.getElementById('v-fecha').value
  const dep   = document.getElementById('v-dependencia').value.trim().toUpperCase()
  const alm   = document.getElementById('v-almacen').value.trim().toUpperCase()
  const folio = document.getElementById('v-folio').value.trim()
  const totalTxt = document.getElementById('v-total').value.trim()
  const obs   = document.getElementById('v-observaciones').value.trim()

  if (!fecha) { toast('Indica la fecha del vale.', 'red'); return }
  if (!dep)   { toast('Indica la dependencia que recibe.', 'red'); return }
  if (totalTxt === '') { toast('Indica el importe del vale.', 'red'); return }

  const total = Number(totalTxt)
  if (!Number.isFinite(total)) { toast('El importe no es un número válido.', 'red'); return }
  if (total < 0) { toast('El importe no puede ser negativo.', 'red'); return }

  // Aviso de folio repetido (la base también lo impide)
  if (folio && _vales.some(v => v.folio === folio && v.id !== _editId)) {
    toast(`El folio ${folio} ya está capturado.`, 'red'); return
  }

  const payload = {
    fecha, dependencia: dep, almacen: alm || 'FARMACIA',
    folio: folio || null, total,
    observaciones: obs || null,
  }

  const btn = document.getElementById('btn-guardar')
  if (btn) { btn.disabled = true; btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…' }

  let error
  if (_editId) {
    payload.updated_at = new Date().toISOString()
    ;({ error } = await db.from('pharmacy_dependency_vouchers').update(payload).eq('id', _editId))
  } else {
    payload.created_by = _user.id
    payload.created_by_name = _profile?.full_name || _user.email
    ;({ error } = await db.from('pharmacy_dependency_vouchers').insert(payload))
  }

  if (btn) { btn.disabled = false; btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar' }

  if (error) {
    toast(error.message.includes('idx_pdv_folio_unico')
      ? `El folio ${folio} ya existe en otro vale.`
      : 'No se pudo guardar: ' + error.message, 'red')
    return
  }

  cerrarModal()
  toast(_editId ? 'Vale actualizado.' : 'Vale registrado.', 'green')
  await cargar()
}

async function borrarVale(id) {
  const v = _vales.find(x => x.id === id)
  if (!v) return
  if (!confirm(`¿Eliminar el vale ${v.folio || ''} de ${v.dependencia || 'sin dependencia'} por ${money(v.total)}?\n\nEsta acción no se puede deshacer.`)) return

  const { error } = await db.from('pharmacy_dependency_vouchers').delete().eq('id', id)
  if (error) { toast('No se pudo eliminar: ' + error.message, 'red'); return }
  toast('Vale eliminado.', 'green')
  await cargar()
}

// ── Exportar ────────────────────────────────────────────────────
function exportarCSV() {
  if (!_filtrados.length) { toast('No hay vales que exportar.', 'red'); return }
  const filas = [['Fecha', 'Dependencia', 'Almacén', 'Folio', 'Total', 'Observaciones']]
  _filtrados.forEach(v => filas.push([
    v.fecha || '', v.dependencia || '', v.almacen || '',
    v.folio || '', num(v.total).toFixed(2), v.observaciones || '',
  ]))
  const total = _filtrados.reduce((s, v) => s + num(v.total), 0)
  filas.push([], ['', '', '', 'TOTAL', total.toFixed(2), ''])

  const csv = filas.map(f => f.map(c => `"${String(c).replace(/"/g, '""')}"`).join(',')).join('\n')
  const a = Object.assign(document.createElement('a'), {
    href: URL.createObjectURL(new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' })),
    download: `salidas_madres_y_casas_${hoy()}.csv`,
  })
  a.click()
  toast(`${_filtrados.length} vales exportados.`, 'green')
}

// ── Modal ───────────────────────────────────────────────────────
function abrirModal()  { document.getElementById('modal-vale').classList.add('open') }
function cerrarModal() { document.getElementById('modal-vale').classList.remove('open') }

// ── Utilidades ──────────────────────────────────────────────────
function num(v) { const n = Number(v); return Number.isFinite(n) ? n : 0 }
function money(v) {
  return num(v).toLocaleString('es-MX', { style: 'currency', currency: 'MXN' })
}
function fmtFecha(f) {
  if (!f) return '—'
  const [y, m, d] = f.split('-')
  return `${d}/${m}/${y}`
}
function fmtMes(ym) {
  const [y, m] = ym.split('-')
  const meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
                 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
  return `${meses[+m - 1]} ${y}`
}
function hoy() { return new Date().toISOString().split('T')[0] }
function fila_msg(txt, color = '#9ca3af') {
  return `<tr><td colspan="7" style="text-align:center;color:${color};padding:26px">${txt}</td></tr>`
}
function setText(id, v) { const el = document.getElementById(id); if (el) el.textContent = v }
function setVal(id, v)  { const el = document.getElementById(id); if (el) el.value = v }
function esc(s) {
  return String(s ?? '').replace(/[&<>"']/g, c =>
    ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]))
}
function toast(msg, color = 'green') {
  const t = document.getElementById('toast')
  if (!t) { alert(msg); return }
  t.textContent = msg
  t.style.background = color === 'red' ? '#dc2626' : '#0d9488'
  t.classList.add('show')
  setTimeout(() => t.classList.remove('show'), 3200)
}

document.addEventListener('DOMContentLoaded', initDep)
