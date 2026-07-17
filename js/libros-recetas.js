// ─── Registro de Recetas — alimentado por los Libros por Medicamento ──

let _user    = null
let _profile = null
let _salidas = []

// ── Init ────────────────────────────────────────────────────────
async function init() {
  const auth = await requireAuth()
  if (!auth?.user) return
  _user    = auth.user
  _profile = auth.profile

  requirePermission(_profile, 'libros_electronicos')

  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
  const dateEl = document.getElementById('current-date')
  if (dateEl) dateEl.textContent = new Date().toLocaleDateString('es-MX',
    { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })

  await loadSalidas()
}

function setText(id, v) { const el = document.getElementById(id); if (el) el.textContent = v }
function esc(s) {
  return String(s ?? '').replace(/[&<>"']/g, c =>
    ({ '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;' }[c]))
}

// ── Cargar salidas de los libros ────────────────────────────────
async function loadSalidas() {
  const { data, error } = await db.from('pharmacy_ledger_entries')
    .select('*')
    .not('salida', 'is', null)
    .order('fecha', { ascending: false })
    .order('created_at', { ascending: false })

  const tbody = document.getElementById('reg-body')
  if (error) {
    if (tbody) tbody.innerHTML = `<tr><td colspan="7" style="text-align:center;color:#991b1b;padding:22px">
      Error: ${esc(error.message)}${error.message.includes('pharmacy_ledger_entries')
        ? ' — falta ejecutar la migración sql/libros_electronicos_setup.sql en Supabase' : ''}</td></tr>`
    return
  }
  _salidas = data || []
  renderRegistro()
}

function filtradas() {
  const grupo = document.getElementById('f-grupo')?.value || 'I'
  const mes   = document.getElementById('f-mes')?.value || ''
  return _salidas.filter(s =>
    (s.grupo || grupoDeMedicamento(s.medicamento)) === grupo &&
    (!mes || (s.fecha || '').startsWith(mes)))
}

// ── Render ──────────────────────────────────────────────────────
function renderRegistro() {
  const grupo = document.getElementById('f-grupo')?.value || 'I'
  setText('reg-titulo', `Grupo ${grupo}`)
  const tbody = document.getElementById('reg-body')
  if (!tbody) return

  const lista = filtradas()
  if (!lista.length) {
    tbody.innerHTML = `<tr><td colspan="7" style="text-align:center;color:#9ca3af;padding:26px">
      Sin recetas registradas para el Grupo ${grupo}${document.getElementById('f-mes')?.value ? ' en el mes seleccionado' : ''}.
      Se llenará automáticamente al capturar salidas en los Libros por Medicamento.</td></tr>`
    return
  }

  tbody.innerHTML = lista.map(s => `<tr>
    <td><strong>${esc(s.receta || '—')}</strong></td>
    <td>${fmtFecha(s.fecha)}</td>
    <td>${esc(s.paciente_proveedor || '—')}
      ${s.medico ? `<div style="font-size:.7rem;color:#9ca3af">Dr(a). ${esc(s.medico)} · Céd. ${esc(s.cedula_factura || '—')}</div>` : ''}</td>
    <td>${s.fecha_nacimiento ? fmtFecha(s.fecha_nacimiento) : '—'}</td>
    <td>${esc(s.uso || '—')}</td>
    <td style="text-align:center;font-weight:700">${s.salida}</td>
    <td style="max-width:220px;font-size:.8rem">${esc(s.medicamento)}</td>
  </tr>`).join('')
}

function fmtFecha(f) {
  if (!f) return '—'
  return new Date(f + 'T12:00:00').toLocaleDateString('es-MX',
    { day: '2-digit', month: 'short', year: 'numeric' })
}

// ── Exportar CSV ────────────────────────────────────────────────
function exportCSV() {
  const grupo = document.getElementById('f-grupo')?.value || 'I'
  const mes   = document.getElementById('f-mes')?.value || 'todos'
  const lista = filtradas()
  if (!lista.length) { alert('No hay registros para exportar.'); return }

  const q = v => `"${String(v ?? '').replace(/"/g, '""')}"`
  const filas = [
    ['Folio (Receta)', 'Fecha', 'Paciente', 'Fecha nacimiento', 'Uso', 'Cantidad', 'Medicamento', 'Médico', 'Cédula'].map(q).join(','),
    ...lista.map(s => [
      s.receta, s.fecha, s.paciente_proveedor, s.fecha_nacimiento || '',
      s.uso || '', s.salida, s.medicamento, s.medico || '', s.cedula_factura || '',
    ].map(q).join(',')),
  ]
  const blob = new Blob(['﻿' + filas.join('\n')], { type: 'text/csv;charset=utf-8' })
  const a = document.createElement('a')
  a.href = URL.createObjectURL(blob)
  a.download = `registro_recetas_grupo_${grupo}_${mes}.csv`
  a.click()
  URL.revokeObjectURL(a.href)
}

init()
