// ─── Bitácora de Entrega de Turno — Farmacia Central ─────────────

let _user    = null
let _profile = null
let _role    = null
let _logs    = []

// Rangos aceptables (del formato oficial)
const RANGOS = {
  't-refa': { min: 2,  max: 8,   label: 'T° Refrigerador A', unidad: '°C' },
  't-refb': { min: 2,  max: 8,   label: 'T° Refrigerador B', unidad: '°C' },
  't-farm': { min: 15, max: 25,  label: 'T° Farmacia',       unidad: '°C' },
  't-hum':  { min: 0,  max: 65,  label: '% Humedad relativa', unidad: '%' },
}

const SERVICIOS = [
  { key: 'rayos_x',      label: 'Suministro a Rayos X' },
  { key: 'quirofano',    label: 'Suministro a Quirófano' },
  { key: 'controlados',  label: 'Suministro de controlados' },
  { key: 'hemodialisis', label: 'Suministro a Hemodiálisis' },
  { key: 'casas_madres', label: 'Suministro a casas de madres' },
  { key: 'otros',        label: 'Otros' },
]

const INVENTARIO = [
  { key: 'controlados',  label: 'Controlados',  desc: 'Conteo físico coincide con sistema' },
  { key: 'altocosto',    label: 'Alto costo',   desc: 'Identificados, coincide con sistema a conteo físico' },
  { key: 'caducados',    label: 'Caducados',    desc: 'Vigencia menor a 1 mes reportados y/o separados' },
  { key: 'antibioticos', label: 'Antibióticos', desc: 'Registro en bitácora y resguardo de receta' },
]

// ── Init ────────────────────────────────────────────────────────
async function init() {
  const auth = await requireAuth()
  if (!auth?.user) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  requirePermission(_profile, 'farmacia_bitacora')

  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
  const dateEl = document.getElementById('current-date')
  if (dateEl) dateEl.textContent = new Date().toLocaleDateString('es-MX',
    { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })

  buildTraspasos()
  setVal('f-fecha', new Date().toISOString().split('T')[0])

  // Validación de rangos en vivo
  Object.keys(RANGOS).forEach(id => {
    document.getElementById(id)?.addEventListener('input', checkRangos)
  })
  // Resaltar checklist al marcar
  INVENTARIO.forEach(i => {
    const chk = document.getElementById(`c-${i.key}`)
    chk?.addEventListener('change', () =>
      document.getElementById(`row-${i.key}`)?.classList.toggle('checked', chk.checked))
  })

  await loadLogs()
}

function setText(id, v) { const el = document.getElementById(id); if (el) el.textContent = v }
function setVal(id, v)  { const el = document.getElementById(id); if (el) el.value = v }
function esc(s) {
  return String(s ?? '').replace(/[&<>"']/g, c =>
    ({ '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;' }[c]))
}

// ── Traspasos: filas de la tabla ────────────────────────────────
function buildTraspasos() {
  const tbody = document.getElementById('tras-body')
  if (!tbody) return
  tbody.innerHTML = SERVICIOS.map(s => `
    <tr>
      <td>${s.key === 'otros'
        ? `<input type="text" id="tras-otros-desc" placeholder="Otros (especificar)">`
        : esc(s.label)}</td>
      <td style="text-align:center"><input type="checkbox" id="tras-chk-${s.key}"></td>
      <td><input type="text" id="tras-folio-${s.key}" placeholder="Folio"></td>
    </tr>`).join('')
}

// ── Validación de rangos ────────────────────────────────────────
function checkRangos() {
  let fuera = false
  Object.entries(RANGOS).forEach(([id, r]) => {
    const el = document.getElementById(id)
    if (!el) return
    const v = parseFloat(el.value)
    const mal = el.value !== '' && !isNaN(v) && (v < r.min || v > r.max)
    el.classList.toggle('fuera-rango', mal)
    if (mal) fuera = true
  })
  const alerta = document.getElementById('temp-alerta')
  if (alerta) alerta.style.display = fuera ? 'block' : 'none'
  return fuera
}

function tempsEnRango(temps) {
  if (!temps) return true
  const checks = [
    ['refa', 2, 8], ['refb', 2, 8], ['farmacia', 15, 25], ['humedad', 0, 65],
  ]
  return checks.every(([k, min, max]) => {
    const v = parseFloat(temps[k])
    return isNaN(v) || (v >= min && v <= max)
  })
}

// ── Guardar ─────────────────────────────────────────────────────
async function guardarBitacora() {
  const fecha   = document.getElementById('f-fecha')?.value
  const turno   = document.getElementById('f-turno')?.value
  const entrega = document.getElementById('f-entrega')?.value.trim()
  const recibe  = document.getElementById('f-recibe')?.value.trim()

  if (!fecha)   { toast('La fecha es obligatoria.', 'red'); return }
  if (!turno)   { toast('Selecciona el turno.', 'red'); return }
  if (!entrega) { toast('Indica quién entrega el turno.', 'red'); return }
  if (!recibe)  { toast('Indica quién recibe el turno.', 'red'); return }

  const btn = document.getElementById('btn-guardar')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const num = id => {
    const v = document.getElementById(id)?.value
    return v === '' || v == null ? null : parseFloat(v)
  }

  const temps = {
    refa:     num('t-refa'),
    refb:     num('t-refb'),
    farmacia: num('t-farm'),
    humedad:  num('t-hum'),
  }

  const inventario = {}
  INVENTARIO.forEach(i => { inventario[i.key] = !!document.getElementById(`c-${i.key}`)?.checked })
  inventario.observaciones = document.getElementById('c-obs')?.value.trim() || null

  const traspasos = SERVICIOS.map(s => ({
    key:          s.key,
    servicio:     s.key === 'otros'
                    ? (document.getElementById('tras-otros-desc')?.value.trim() || 'Otros')
                    : s.label,
    verificacion: !!document.getElementById(`tras-chk-${s.key}`)?.checked,
    folio:        document.getElementById(`tras-folio-${s.key}`)?.value.trim() || null,
  })).filter(t => t.verificacion || t.folio || (t.key === 'otros' && t.servicio !== 'Otros'))

  const payload = {
    fecha, turno, entrega, recibe,
    temps, inventario, traspasos,
    pendientes: document.getElementById('f-pendientes')?.value.trim() || null,
    created_by: _user.id,
    created_by_name: _profile?.full_name || _user.email,
  }

  const { error } = await db.from('pharmacy_shift_logs').insert(payload)

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar entrega de turno'

  if (error) {
    toast('Error al guardar: ' + error.message, 'red')
    return
  }
  toast('Entrega de turno registrada correctamente.', 'green')
  resetForm()
  await loadLogs()
}

function resetForm() {
  ;['f-turno','f-entrega','f-recibe','t-refa','t-refb','t-farm','t-hum','c-obs','f-pendientes']
    .forEach(id => setVal(id, ''))
  setVal('f-fecha', new Date().toISOString().split('T')[0])
  INVENTARIO.forEach(i => {
    const chk = document.getElementById(`c-${i.key}`)
    if (chk) chk.checked = false
    document.getElementById(`row-${i.key}`)?.classList.remove('checked')
  })
  buildTraspasos()
  checkRangos()
}

// ── Historial ───────────────────────────────────────────────────
async function loadLogs() {
  const { data, error } = await db.from('pharmacy_shift_logs')
    .select('*')
    .order('fecha', { ascending: false })
    .order('created_at', { ascending: false })
    .limit(60)

  const tbody = document.getElementById('hist-body')
  if (!tbody) return
  if (error) {
    tbody.innerHTML = `<tr><td colspan="7" style="text-align:center;color:#991b1b;padding:22px">
      Error: ${esc(error.message)}${error.message.includes('pharmacy_shift_logs')
        ? ' — falta ejecutar la migración sql/farmacia_setup.sql en Supabase' : ''}</td></tr>`
    return
  }
  _logs = data || []
  if (!_logs.length) {
    tbody.innerHTML = `<tr><td colspan="7" style="text-align:center;color:#9ca3af;padding:26px">
      Sin registros — captura la primera entrega de turno arriba.</td></tr>`
    return
  }

  const turnoPill = t => {
    const cls = t === 'Matutino' ? 'pill-mat' : t === 'Vespertino' ? 'pill-ves' : 'pill-noc'
    return `<span class="pill-turno ${cls}">${esc(t)}</span>`
  }
  const canDelete = ['administrador', 'responsable_calidad'].includes(_role)

  tbody.innerHTML = _logs.map(l => {
    const okTemps = tempsEnRango(l.temps)
    const inv = l.inventario || {}
    const invOk = INVENTARIO.every(i => inv[i.key])
    return `<tr>
      <td>${fmtFecha(l.fecha)}</td>
      <td>${turnoPill(l.turno)}</td>
      <td>${esc(l.entrega)}</td>
      <td>${esc(l.recibe)}</td>
      <td style="text-align:center">${okTemps
        ? '<span class="pill-ok"><i class="fa-solid fa-check"></i> En rango</span>'
        : '<span class="pill-alert"><i class="fa-solid fa-triangle-exclamation"></i> Fuera de rango</span>'}</td>
      <td style="text-align:center">${invOk
        ? '<span class="pill-ok"><i class="fa-solid fa-check"></i> Completo</span>'
        : '<span class="pill-alert">Pendiente</span>'}</td>
      <td style="text-align:center">
        <button class="btn-action" onclick="verDetalle('${l.id}')" title="Ver detalle"><i class="fa-solid fa-eye"></i></button>
        ${canDelete ? `<button class="btn-action del" onclick="eliminar('${l.id}')" title="Eliminar"><i class="fa-solid fa-trash"></i></button>` : ''}
      </td>
    </tr>`
  }).join('')
}

function fmtFecha(f) {
  if (!f) return '—'
  return new Date(f + 'T12:00:00').toLocaleDateString('es-MX',
    { day: '2-digit', month: 'short', year: 'numeric' })
}

// ── Detalle ─────────────────────────────────────────────────────
function verDetalle(id) {
  const l = _logs.find(x => x.id === id)
  if (!l) return
  const t = l.temps || {}
  const inv = l.inventario || {}

  const tempRow = (label, v, min, max, unidad) => {
    if (v == null) return `<div><label>${label}</label>—</div>`
    const mal = v < min || v > max
    return `<div><label>${label}</label>
      <span style="${mal ? 'color:#dc2626;font-weight:700' : ''}">${v}${unidad}
      ${mal ? ' ⚠️ fuera de rango' : ''}</span></div>`
  }

  const invRow = i => `<div><label>${i.label}</label>
    ${inv[i.key]
      ? '<span style="color:#065f46">✔ Conforme</span>'
      : '<span style="color:#991b1b">✘ No verificado</span>'} — <small style="color:#64748b">${i.desc}</small></div>`

  const trasRows = (l.traspasos || []).map(tr =>
    `<div><label>${esc(tr.servicio)}</label>
      ${tr.verificacion ? '✔ Verificado' : '—'} ${tr.folio ? ` · Folio: <strong>${esc(tr.folio)}</strong>` : ''}</div>`
  ).join('') || '<div style="color:#9ca3af;font-size:.84rem">Sin traspasos registrados</div>'

  setText('det-title', `Bitácora ${fmtFecha(l.fecha)} — Turno ${l.turno}`)
  document.getElementById('det-body').innerHTML = `
    <div class="det-grid">
      <div><label>Entrega</label>${esc(l.entrega)}</div>
      <div><label>Recibe</label>${esc(l.recibe)}</div>
    </div>
    <div class="det-sep">Temperaturas y humedad</div>
    <div class="det-grid">
      ${tempRow('T° Refrigerador A (2–8°C)', t.refa, 2, 8, '°C')}
      ${tempRow('T° Refrigerador B (2–8°C)', t.refb, 2, 8, '°C')}
      ${tempRow('T° Farmacia (15–25°C)', t.farmacia, 15, 25, '°C')}
      ${tempRow('Humedad relativa (<65%)', t.humedad, 0, 65, '%')}
    </div>
    <div class="det-sep">Inventario y medicamentos críticos</div>
    ${INVENTARIO.map(invRow).join('')}
    ${inv.observaciones ? `<div style="margin-top:8px"><label style="font-size:.7rem;font-weight:700;color:#9ca3af;text-transform:uppercase">Observaciones</label><div style="font-size:.86rem">${esc(inv.observaciones)}</div></div>` : ''}
    <div class="det-sep">Traspasos y pedidos</div>
    ${trasRows}
    <div class="det-sep">Pendientes operativos</div>
    <div style="font-size:.87rem;white-space:pre-wrap">${esc(l.pendientes || 'Sin pendientes')}</div>
    <div style="margin-top:16px;font-size:.74rem;color:#9ca3af">
      Registrado por ${esc(l.created_by_name || '—')} · ${new Date(l.created_at).toLocaleString('es-MX')}
    </div>`
  document.getElementById('modal-det').classList.add('open')
}

// ── Eliminar (solo admin / responsable de calidad) ──────────────
async function eliminar(id) {
  if (!confirm('¿Eliminar este registro de bitácora? Esta acción no se puede deshacer.')) return
  const { error } = await db.from('pharmacy_shift_logs').delete().eq('id', id)
  if (error) { toast('Error al eliminar: ' + error.message, 'red'); return }
  toast('Registro eliminado.', 'green')
  await loadLogs()
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
