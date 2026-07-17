// ─── Libros Electrónicos — Kardex por medicamento controlado ─────

let _user    = null
let _profile = null
let _role    = null
let _movs    = []   // movimientos del medicamento seleccionado (ascendente)

// ── Init ────────────────────────────────────────────────────────
async function init() {
  const auth = await requireAuth()
  if (!auth?.user) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  requirePermission(_profile, 'libros_electronicos')

  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
  const dateEl = document.getElementById('current-date')
  if (dateEl) dateEl.textContent = new Date().toLocaleDateString('es-MX',
    { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })

  fillMeds()
}

function setText(id, v) { const el = document.getElementById(id); if (el) el.textContent = v }
function setVal(id, v)  { const el = document.getElementById(id); if (el) el.value = v }
function esc(s) {
  return String(s ?? '').replace(/[&<>"']/g, c =>
    ({ '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;' }[c]))
}
function hoy() { return new Date().toISOString().split('T')[0] }

// ── Selector de libro ───────────────────────────────────────────
function fillMeds() {
  const grupo = document.getElementById('f-grupo')?.value || 'I'
  const sel = document.getElementById('f-med')
  if (!sel) return
  sel.innerHTML = '<option value="">— Seleccionar libro —</option>' +
    LIBROS_CATALOGO[grupo].map(m => `<option value="${esc(m)}">${esc(m)}</option>`).join('')
  renderLibro()
}

// ── Cargar y renderizar el libro ────────────────────────────────
async function renderLibro() {
  const med = document.getElementById('f-med')?.value
  const tbody = document.getElementById('libro-body')
  const btnNuevo = document.getElementById('btn-nuevo-mov')
  const balCard = document.getElementById('balance-card')
  if (btnNuevo) btnNuevo.disabled = !med

  if (!med) {
    if (tbody) tbody.innerHTML = `<tr><td colspan="13" style="text-align:center;color:#9ca3af;padding:26px">
      Selecciona el medicamento para ver su libro.</td></tr>`
    setText('libro-titulo', 'Selecciona un medicamento')
    if (balCard) balCard.style.display = 'none'
    return
  }

  setText('libro-titulo', `Libro — ${med}`)
  if (tbody) tbody.innerHTML = `<tr><td colspan="13" style="text-align:center;color:#9ca3af;padding:26px">Cargando…</td></tr>`

  const { data, error } = await db.from('pharmacy_ledger_entries')
    .select('*')
    .eq('medicamento', med)
    .order('fecha', { ascending: true })
    .order('created_at', { ascending: true })

  if (error) {
    if (tbody) tbody.innerHTML = `<tr><td colspan="13" style="text-align:center;color:#991b1b;padding:22px">
      Error: ${esc(error.message)}${error.message.includes('pharmacy_ledger_entries')
        ? ' — falta ejecutar la migración sql/libros_electronicos_setup.sql en Supabase' : ''}</td></tr>`
    return
  }

  _movs = data || []

  // Balance corrido
  let total = 0
  const rows = _movs.map(m => {
    total += (m.entrada || 0) - (m.salida || 0)
    return { ...m, _total: total }
  })

  if (balCard) {
    balCard.style.display = 'block'
    balCard.innerHTML = `Existencia actual de <strong>${esc(med)}</strong>:
      <strong style="font-size:1.2rem;${total < 0 ? 'color:#dc2626' : ''}">${total}</strong>
      &nbsp;·&nbsp; ${_movs.length} movimiento${_movs.length !== 1 ? 's' : ''} en el libro`
  }

  if (!rows.length) {
    tbody.innerHTML = `<tr><td colspan="13" style="text-align:center;color:#9ca3af;padding:26px">
      Libro sin movimientos — registra el primero con el botón de arriba.</td></tr>`
    return
  }

  const canDelete = ['administrador', 'responsable_calidad'].includes(_role)

  tbody.innerHTML = rows.slice().reverse().map(m => `<tr>
    <td>${fmtFecha(m.fecha)}</td>
    <td style="max-width:190px">${esc(m.paciente_proveedor || '—')}
      ${m.medico ? `<div style="font-size:.7rem;color:#9ca3af">Dr(a). ${esc(m.medico)}</div>` : ''}</td>
    <td>${m.fecha_nacimiento ? fmtFecha(m.fecha_nacimiento) : '—'}</td>
    <td style="max-width:130px;font-size:.78rem">${esc(m.medico || '—')}</td>
    <td style="font-size:.78rem">${esc(m.cedula_factura || '—')}</td>
    <td>${esc(m.receta || '—')}</td>
    <td>${esc(m.lote || '—')}</td>
    <td>${esc(m.cad || '—')}</td>
    <td style="text-align:center">${m.entrada != null
      ? `<span style="color:#0f766e;font-weight:700">+${m.entrada}</span>` : '—'}</td>
    <td style="text-align:center">${m.salida != null
      ? `<span style="color:#b91c1c;font-weight:700">−${m.salida}</span>` : '—'}</td>
    <td style="text-align:center;font-weight:800;${m._total < 0 ? 'color:#dc2626' : ''}">${m._total}</td>
    <td style="max-width:140px;font-size:.75rem">${esc(m.observaciones || '')}</td>
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

// ── Modal de movimiento ─────────────────────────────────────────
function openMov() {
  const med = document.getElementById('f-med')?.value
  if (!med) return
  setText('mov-title', `Registrar movimiento — ${med}`)
  ;['m-cantidad','m-pacprov','m-nacimiento','m-medico','m-receta',
    'm-direccion','m-cedula','m-lote','m-cad','m-obs'].forEach(id => setVal(id, ''))
  setVal('m-fecha', hoy())
  setVal('m-tipo', 'salida')
  toggleTipoMov()
  document.getElementById('modal-mov').classList.add('open')
}

function toggleTipoMov() {
  const tipo = document.getElementById('m-tipo')?.value
  const salidaWrap = document.getElementById('mov-salida')
  if (salidaWrap) salidaWrap.style.display = tipo === 'salida' ? '' : 'none'
  const lblPac = document.getElementById('lbl-pac')
  const lblCed = document.getElementById('lbl-cedula')
  const pac = document.getElementById('m-pacprov')
  if (tipo === 'salida') {
    if (lblPac) lblPac.innerHTML = 'Paciente <span style="color:#dc2626">*</span>'
    if (lblCed) lblCed.textContent = 'Cédula profesional'
    if (pac) pac.placeholder = 'Nombre del paciente'
  } else {
    if (lblPac) lblPac.innerHTML = 'Proveedor <span style="color:#dc2626">*</span>'
    if (lblCed) lblCed.textContent = 'No. de factura'
    if (pac) pac.placeholder = 'Ej. Laboratorios PISA S.A. de C.V.'
  }
}

async function guardarMov() {
  const med      = document.getElementById('f-med')?.value
  const fecha    = document.getElementById('m-fecha')?.value
  const tipo     = document.getElementById('m-tipo')?.value
  const cantidad = parseFloat(document.getElementById('m-cantidad')?.value)
  const pacprov  = document.getElementById('m-pacprov')?.value.trim()

  if (!med)   { toast('Selecciona el medicamento.', 'red'); return }
  if (!fecha) { toast('La fecha es obligatoria.', 'red'); return }
  if (isNaN(cantidad) || cantidad <= 0) { toast('Captura una cantidad válida.', 'red'); return }
  if (!pacprov) {
    toast(tipo === 'salida' ? 'Indica el paciente.' : 'Indica el proveedor.', 'red'); return
  }

  const payload = {
    medicamento: med,
    grupo: grupoDeMedicamento(med),
    fecha,
    entrada: tipo === 'entrada' ? cantidad : null,
    salida:  tipo === 'salida'  ? cantidad : null,
    paciente_proveedor: pacprov,
    direccion:      document.getElementById('m-direccion')?.value.trim() || null,
    cedula_factura: document.getElementById('m-cedula')?.value.trim() || null,
    lote: document.getElementById('m-lote')?.value.trim() || null,
    cad:  document.getElementById('m-cad')?.value || null,
    observaciones: document.getElementById('m-obs')?.value.trim() || null,
    created_by: _user.id,
    created_by_name: _profile?.full_name || _user.email,
  }

  if (tipo === 'salida') {
    payload.fecha_nacimiento = document.getElementById('m-nacimiento')?.value || null
    payload.medico = document.getElementById('m-medico')?.value.trim() || null
    payload.receta = document.getElementById('m-receta')?.value.trim() || null
    payload.uso    = document.getElementById('m-uso')?.value || null
    if (!payload.medico) { toast('Indica el médico.', 'red'); return }
    if (!payload.receta) { toast('Indica el número de receta.', 'red'); return }
  }

  // Verificar balance
  let total = 0
  _movs.forEach(m => { total += (m.entrada || 0) - (m.salida || 0) })
  const nuevo = total + (payload.entrada || 0) - (payload.salida || 0)
  if (nuevo < 0 && !confirm(`La existencia quedaría en ${nuevo} (negativa). ¿Registrar de todos modos?`)) return

  const btn = document.getElementById('btn-save-mov')
  btn.disabled = true
  const { error } = await db.from('pharmacy_ledger_entries').insert(payload)
  btn.disabled = false

  if (error) { toast('Error al guardar: ' + error.message, 'red'); return }
  toast('Movimiento registrado en el libro.', 'green')
  document.getElementById('modal-mov').classList.remove('open')
  await renderLibro()
}

// ── Eliminar ────────────────────────────────────────────────────
async function eliminar(id) {
  if (!confirm('¿Eliminar este movimiento del libro? El total se recalculará y desaparecerá del Registro de Recetas.')) return
  const { error } = await db.from('pharmacy_ledger_entries').delete().eq('id', id)
  if (error) { toast('Error al eliminar: ' + error.message, 'red'); return }
  toast('Movimiento eliminado.', 'green')
  await renderLibro()
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
