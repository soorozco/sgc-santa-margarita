// ─── Bitácora de Control de Dispensación de Medicamentos Controlados ──

let _user    = null
let _profile = null
let _role    = null
let _movs    = []   // todos los movimientos (ascendente para calcular balance)

// Catálogo del formato oficial (BITACORA CONTROLADOS FARMACIA CENTRAL)
const MEDICAMENTOS = [
  'Fentanilo (Fenodid) 0.25mg',
  'Fentanilo (Fenodid) 0.5mg',
  'Morfina (Graten) 2.5mg',
  'Morfina (Graten) 50mg',
  'Midazolam (Relacum) 5mg',
  'Midazolam (Relacum) 15mg',
  'Midazolam (Relacum) 50mg',
  'Buprenorfina (Brospina) 0.3mg caja c/6 amp',
  'Parche Buprenorfina (Soloro 7) 5mcg/h',
  'Parche Buprenorfina (Soloro 7) 10mcg/h',
  'Diazepam (Relazepam) 10mg/ml sol. iny.',
  'Clonazepam (Kriadex) 2mg tabletas',
  'Clonazepam (Kriadex) 2.5mg gotas',
  'Alprazolam (Pisalpra) 0.25mg',
  'Alprazolam (Pisalpra) 0.5mg',
]

// ── Init ────────────────────────────────────────────────────────
async function init() {
  const auth = await requireAuth()
  if (!auth?.user) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  requirePermission(_profile, 'farmacia_dispensacion')

  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
  const dateEl = document.getElementById('current-date')
  if (dateEl) dateEl.textContent = new Date().toLocaleDateString('es-MX',
    { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })

  // Poblar selects de medicamentos
  const opts = MEDICAMENTOS.map(m => `<option value="${esc(m)}">${esc(m)}</option>`).join('')
  document.getElementById('f-med').innerHTML = `<option value="">— Seleccionar —</option>${opts}`
  document.getElementById('filtro-med').innerHTML = `<option value="">Todos los medicamentos</option>${opts}`

  setVal('f-fecha', new Date().toISOString().split('T')[0])
  toggleTipo()
  await loadMovs()
}

function setText(id, v) { const el = document.getElementById(id); if (el) el.textContent = v }
function setVal(id, v)  { const el = document.getElementById(id); if (el) el.value = v }
function esc(s) {
  return String(s ?? '').replace(/[&<>"']/g, c =>
    ({ '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;' }[c]))
}

// ── Tipo de movimiento ──────────────────────────────────────────
function toggleTipo() {
  const tipo = document.getElementById('f-tipo')?.value
  const wrap = document.getElementById('salida-wrap')
  if (wrap) wrap.style.display = tipo === 'salida' ? '' : 'none'
  updateBalancePreview()
}

// ── Balance ─────────────────────────────────────────────────────
function balanceDe(med) {
  let bal = 0
  _movs.forEach(m => {
    if (m.medicamento !== med) return
    bal += (m.entrada || 0) - (m.salida || 0)
  })
  return bal
}

function updateBalancePreview() {
  const med  = document.getElementById('f-med')?.value
  const tipo = document.getElementById('f-tipo')?.value
  const cant = parseFloat(document.getElementById('f-cantidad')?.value)
  const box  = document.getElementById('balance-preview')
  if (!box) return
  if (!med) { box.style.display = 'none'; return }

  const actual = balanceDe(med)
  let html = `Balance actual de <strong>${esc(med)}</strong>: <strong>${actual}</strong>`
  let bg = '#eff6ff', color = '#1d4ed8'

  if (!isNaN(cant) && cant > 0) {
    const nuevo = tipo === 'entrada' ? actual + cant : actual - cant
    html += ` &nbsp;→&nbsp; quedará en <strong>${nuevo}</strong>`
    if (nuevo < 0) {
      bg = '#fef2f2'; color = '#991b1b'
      html += ' ⚠️ El balance quedaría negativo — verifica la cantidad o registra la entrada faltante.'
    }
  }
  box.style.display = 'block'
  box.style.background = bg
  box.style.color = color
  box.innerHTML = html
}

// ── Guardar ─────────────────────────────────────────────────────
async function guardarMovimiento() {
  const fecha    = document.getElementById('f-fecha')?.value
  const med      = document.getElementById('f-med')?.value
  const tipo     = document.getElementById('f-tipo')?.value
  const cantidad = parseFloat(document.getElementById('f-cantidad')?.value)
  const personal = document.getElementById('f-personal')?.value.trim()

  if (!fecha) { toast('La fecha es obligatoria.', 'red'); return }
  if (!med)   { toast('Selecciona el medicamento.', 'red'); return }
  if (isNaN(cantidad) || cantidad <= 0) { toast('Captura una cantidad válida.', 'red'); return }
  if (!personal) { toast('Indica el personal que dispensa/registra.', 'red'); return }

  const payload = {
    fecha,
    medicamento: med,
    entrada: tipo === 'entrada' ? cantidad : null,
    salida:  tipo === 'salida'  ? cantidad : null,
    lote: document.getElementById('f-lote')?.value.trim() || null,
    cad:  document.getElementById('f-cad')?.value || null,
    personal,
    created_by: _user.id,
    created_by_name: _profile?.full_name || _user.email,
  }

  if (tipo === 'salida') {
    payload.paciente = document.getElementById('f-paciente')?.value.trim()
    payload.medico   = document.getElementById('f-medico')?.value.trim()
    payload.cedula   = document.getElementById('f-cedula')?.value.trim()
    payload.receta   = document.getElementById('f-receta')?.value.trim()
    if (!payload.paciente) { toast('Indica el paciente.', 'red'); return }
    if (!payload.medico)   { toast('Indica el médico tratante.', 'red'); return }
    if (!payload.cedula)   { toast('Indica la cédula del médico.', 'red'); return }
    if (!payload.receta)   { toast('Indica el número de receta.', 'red'); return }
  }

  // Balance resultante (se guarda como respaldo/kardex)
  const nuevoBalance = balanceDe(med) + (payload.entrada || 0) - (payload.salida || 0)
  payload.balance = nuevoBalance
  if (nuevoBalance < 0 &&
      !confirm(`El balance de "${med}" quedaría en ${nuevoBalance} (negativo). ¿Registrar de todos modos?`)) {
    return
  }

  const btn = document.getElementById('btn-guardar')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const { error } = await db.from('pharmacy_dispensing_log').insert(payload)

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Registrar movimiento'

  if (error) { toast('Error al guardar: ' + error.message, 'red'); return }
  toast('Movimiento registrado correctamente.', 'green')
  resetForm()
  await loadMovs()
}

function resetForm() {
  ;['f-med','f-cantidad','f-paciente','f-medico','f-cedula','f-receta','f-lote','f-cad','f-personal']
    .forEach(id => setVal(id, ''))
  setVal('f-fecha', new Date().toISOString().split('T')[0])
  setVal('f-tipo', 'salida')
  toggleTipo()
}

// ── Cargar movimientos ──────────────────────────────────────────
async function loadMovs() {
  const { data, error } = await db.from('pharmacy_dispensing_log')
    .select('*')
    .order('fecha', { ascending: true })
    .order('created_at', { ascending: true })

  const tbody = document.getElementById('hist-body')
  if (error) {
    if (tbody) tbody.innerHTML = `<tr><td colspan="10" style="text-align:center;color:#991b1b;padding:22px">
      Error: ${esc(error.message)}${error.message.includes('pharmacy_dispensing_log')
        ? ' — falta ejecutar la migración sql/farmacia_dispensacion_setup.sql en Supabase' : ''}</td></tr>`
    document.getElementById('balances-grid').innerHTML =
      '<div style="color:#991b1b;font-size:.86rem">No se pudieron cargar los balances.</div>'
    return
  }
  _movs = data || []
  renderBalances()
  renderHist()
  updateBalancePreview()
}

// ── Balances actuales ───────────────────────────────────────────
function renderBalances() {
  const grid = document.getElementById('balances-grid')
  if (!grid) return
  const meds = new Set(MEDICAMENTOS)
  _movs.forEach(m => meds.add(m.medicamento))

  grid.innerHTML = [...meds].map(med => {
    const bal = balanceDe(med)
    const tiene = _movs.some(m => m.medicamento === med)
    const color = bal < 0 ? '#dc2626' : bal === 0 ? '#9ca3af' : '#0f766e'
    return `<div style="border:1.5px solid ${bal < 0 ? '#fecaca' : '#e2e8f0'};border-radius:10px;padding:10px 14px;background:${bal < 0 ? '#fef2f2' : '#f8fafc'}">
      <div style="font-size:.74rem;color:#64748b;line-height:1.3">${esc(med)}</div>
      <div style="font-size:1.3rem;font-weight:800;color:${color}">${tiene ? bal : '—'}</div>
    </div>`
  }).join('')
}

// ── Kardex / historial ──────────────────────────────────────────
function renderHist() {
  const tbody = document.getElementById('hist-body')
  if (!tbody) return
  const filtro = document.getElementById('filtro-med')?.value || ''

  // Calcular balance corrido por medicamento (orden ascendente)
  const running = {}
  const rows = _movs.map(m => {
    running[m.medicamento] = (running[m.medicamento] || 0) + (m.entrada || 0) - (m.salida || 0)
    return { ...m, _bal: running[m.medicamento] }
  })

  const visibles = rows
    .filter(m => !filtro || m.medicamento === filtro)
    .reverse()   // más reciente primero
    .slice(0, 150)

  if (!visibles.length) {
    tbody.innerHTML = `<tr><td colspan="10" style="text-align:center;color:#9ca3af;padding:26px">
      Sin movimientos${filtro ? ' para este medicamento' : ''} — registra el primero arriba.</td></tr>`
    return
  }

  const canDelete = ['administrador', 'responsable_calidad'].includes(_role)

  tbody.innerHTML = visibles.map(m => `<tr>
    <td>${fmtFecha(m.fecha)}</td>
    <td style="max-width:210px">${esc(m.medicamento)}</td>
    <td style="text-align:center">${m.entrada != null
      ? `<span style="color:#0f766e;font-weight:700">+${m.entrada}</span>` : '—'}</td>
    <td style="text-align:center">${m.salida != null
      ? `<span style="color:#b91c1c;font-weight:700">−${m.salida}</span>` : '—'}</td>
    <td style="text-align:center;font-weight:800;${m._bal < 0 ? 'color:#dc2626' : ''}">${m._bal}</td>
    <td>${esc(m.paciente || '—')}${m.medico
      ? `<div style="font-size:.72rem;color:#9ca3af">Dr(a). ${esc(m.medico)} · Céd. ${esc(m.cedula || '—')}</div>` : ''}</td>
    <td>${esc(m.receta || '—')}</td>
    <td>${esc(m.lote || '—')}${m.cad ? `<div style="font-size:.72rem;color:#9ca3af">Cad: ${esc(m.cad)}</div>` : ''}</td>
    <td>${esc(m.personal || '—')}</td>
    <td style="text-align:center">${canDelete
      ? `<button class="btn-action del" onclick="eliminar('${m.id}')" title="Eliminar"><i class="fa-solid fa-trash"></i></button>`
      : '—'}</td>
  </tr>`).join('')
}

function fmtFecha(f) {
  if (!f) return '—'
  return new Date(f + 'T12:00:00').toLocaleDateString('es-MX',
    { day: '2-digit', month: 'short', year: 'numeric' })
}

// ── Eliminar ────────────────────────────────────────────────────
async function eliminar(id) {
  if (!confirm('¿Eliminar este movimiento? El balance del medicamento se recalculará.')) return
  const { error } = await db.from('pharmacy_dispensing_log').delete().eq('id', id)
  if (error) { toast('Error al eliminar: ' + error.message, 'red'); return }
  toast('Movimiento eliminado.', 'green')
  await loadMovs()
}

// ── Toast ───────────────────────────────────────────────────────
function toast(msg, color = 'green') {
  const old = document.getElementById('sgc-toast')
  if (old) old.remove()
  const bg = color === 'green' ? '#16a34a' : color === 'red' ? '#dc2626' : '#2563eb'
  const t = document.createElement('div')
  t.id = 'sgc-toast'
  t.style.cssText = `position:fixed;bottom:28px;right:28px;z-index:9999;background:${bg};color:#fff;
    padding:13px 22px;border-radius:12px;font-size:.857rem;font-weight:600;
    box-shadow:0 8px 28px rgba(0,0,0,.22);max-width:380px;line-height:1.4`
  t.textContent = msg
  document.body.appendChild(t)
  setTimeout(() => t.remove(), 3800)
}

init()
