// ─── Conteo de Controlados — Farmacia Central ────────────────────

let _user    = null
let _profile = null
let _role    = null
let _logs    = []
let _extraRows = 0

// Catálogo de medicamentos controlados por grupo (del formato oficial)
const GRUPOS = {
  I: [
    'Fenodid (Fentanilo) 0.25mg/5ml',
    'Fenodid (Fentanilo) 0.5mg/10ml',
    'Graten (Morfina) 2.5mg/2.5ml',
    'Graten (Morfina) 10mg/10ml',
  ],
  II: [
    'Antadona (Flumazenil) 0.5mg/5ml',
    'Brospina (Buprenorfina) 0.3mg/ml',
    'Bufigen (Nalbufina) 10mg/ml',
    'Relacum (Midazolam) 5mg/5ml',
    'Relacum (Midazolam) 15mg/3ml',
    'Relacum (Midazolam) 50mg/10ml',
    'Relazepam (Diazepam) 10mg/2ml',
    'Alprazolam 0.25mg tabletas',
    'Alprazolam 0.5mg tabletas',
    'Kriadex (Clonazepam) 2mg tabletas',
    'Kriadex (Clonazepam) 2.5mg/ml gotas',
    'Soloro 7 (Buprenorfina) 5mcg parches',
    'Soloro 7 (Buprenorfina) 10mcg parches',
  ],
  III: [
    'Anapsique (Amitriptilina) 25mg tabletas',
    'Pisazol (Tramadol) 50mg',
    'Pisazol (Tramadol) 100mg',
    'Tradol (Tramadol) 50mg',
    'Tradol (Tramadol) 100mg',
    'Supradol Duet (Tramadol/Ketorolaco) 10mg/25mg',
    'Onemer Duet (Tramadol/Ketorolaco)',
    'Tramadol gotas',
    'Tramadol / Paracetamol tabletas',
  ],
}

// ── Init ────────────────────────────────────────────────────────
async function init() {
  const auth = await requireAuth()
  if (!auth?.user) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  requirePermission(_profile, 'farmacia_controlados')

  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
  const dateEl = document.getElementById('current-date')
  if (dateEl) dateEl.textContent = new Date().toLocaleDateString('es-MX',
    { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })

  setVal('f-fecha', new Date().toISOString().split('T')[0])
  await loadLogs()
}

function setText(id, v) { const el = document.getElementById(id); if (el) el.textContent = v }
function setVal(id, v)  { const el = document.getElementById(id); if (el) el.value = v }
function esc(s) {
  return String(s ?? '').replace(/[&<>"']/g, c =>
    ({ '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;' }[c]))
}

// ── Construcción de la tabla de conteo ──────────────────────────
function medRowHtml(i, nombre, fijo) {
  return `<tr data-row="${i}">
    <td>${fijo
      ? `${esc(nombre)}<input type="hidden" id="med-nombre-${i}" value="${esc(nombre)}">`
      : `<input type="text" id="med-nombre-${i}" placeholder="Nombre del medicamento">`}</td>
    <td><input type="number" min="0" id="med-re-${i}" oninput="calcRow(${i})" style="width:100%"></td>
    <td><input type="number" min="0" id="med-in-${i}" oninput="calcRow(${i})" style="width:100%"></td>
    <td><input type="number" min="0" id="med-sa-${i}" oninput="calcRow(${i})" style="width:100%"></td>
    <td><input type="number" min="0" id="med-en-${i}" oninput="checkDiferencias()" style="width:100%"></td>
    <td><input type="text" id="med-lote-${i}" placeholder="Lote"></td>
    <td><input type="month" id="med-cad-${i}" title="Mes de caducidad"></td>
  </tr>`
}

function buildConteo() {
  const grupo = document.getElementById('f-grupo')?.value
  const table  = document.getElementById('conteo-table')
  const vacio  = document.getElementById('conteo-vacio')
  const addBtn = document.getElementById('btn-add-med')
  const titulo = document.getElementById('conteo-titulo')
  const tbody  = document.getElementById('conteo-body')
  if (!tbody) return

  if (!grupo) {
    table.style.display = 'none'
    vacio.style.display = ''
    addBtn.style.display = 'none'
    titulo.textContent = 'Conteo — selecciona un grupo'
    return
  }

  _extraRows = 0
  tbody.innerHTML = GRUPOS[grupo].map((m, i) => medRowHtml(i, m, true)).join('')
  table.style.display = ''
  vacio.style.display = 'none'
  addBtn.style.display = ''
  titulo.textContent = `Conteo de Controlados — Grupo ${grupo}`
  checkDiferencias()
}

function addMedRow() {
  const grupo = document.getElementById('f-grupo')?.value
  if (!grupo) return
  const i = GRUPOS[grupo].length + _extraRows
  _extraRows += 1
  document.getElementById('conteo-body')
    .insertAdjacentHTML('beforeend', medRowHtml(i, '', false))
}

// EN sugerido = RE + IN − SA (editable; si difiere se marca)
function calcRow(i) {
  const re = parseFloat(document.getElementById(`med-re-${i}`)?.value)
  const inn = parseFloat(document.getElementById(`med-in-${i}`)?.value)
  const sa = parseFloat(document.getElementById(`med-sa-${i}`)?.value)
  const enEl = document.getElementById(`med-en-${i}`)
  if (!enEl) return
  if (!isNaN(re)) {
    const calc = re + (isNaN(inn) ? 0 : inn) - (isNaN(sa) ? 0 : sa)
    enEl.value = calc
  }
  checkDiferencias()
}

function rowDiferencia(i) {
  const re = parseFloat(document.getElementById(`med-re-${i}`)?.value)
  const inn = parseFloat(document.getElementById(`med-in-${i}`)?.value)
  const sa = parseFloat(document.getElementById(`med-sa-${i}`)?.value)
  const en = parseFloat(document.getElementById(`med-en-${i}`)?.value)
  if (isNaN(re) || isNaN(en)) return false
  return en !== re + (isNaN(inn) ? 0 : inn) - (isNaN(sa) ? 0 : sa)
}

function checkDiferencias() {
  let hay = false
  document.querySelectorAll('#conteo-body tr').forEach(tr => {
    const i = tr.dataset.row
    const dif = rowDiferencia(i)
    const enEl = document.getElementById(`med-en-${i}`)
    if (enEl) enEl.classList.toggle('fuera-rango', dif)
    if (dif) hay = true
  })
  const alerta = document.getElementById('conteo-alerta')
  if (alerta) alerta.style.display = hay ? 'block' : 'none'
}

// ── Guardar ─────────────────────────────────────────────────────
async function guardarConteo() {
  const fecha = document.getElementById('f-fecha')?.value
  const turno = document.getElementById('f-turno')?.value
  const grupo = document.getElementById('f-grupo')?.value
  const responsable = document.getElementById('f-responsable')?.value.trim()

  if (!fecha) { toast('La fecha es obligatoria.', 'red'); return }
  if (!turno) { toast('Selecciona el turno.', 'red'); return }
  if (!grupo) { toast('Selecciona el grupo.', 'red'); return }
  if (!responsable) { toast('Indica el responsable del conteo.', 'red'); return }

  const num = id => {
    const v = document.getElementById(id)?.value
    return v === '' || v == null ? null : parseFloat(v)
  }

  const conteos = []
  let capturados = 0
  document.querySelectorAll('#conteo-body tr').forEach(tr => {
    const i = tr.dataset.row
    const nombre = document.getElementById(`med-nombre-${i}`)?.value.trim()
    if (!nombre) return
    const fila = {
      medicamento: nombre,
      re: num(`med-re-${i}`),
      in: num(`med-in-${i}`),
      sa: num(`med-sa-${i}`),
      en: num(`med-en-${i}`),
      lote: document.getElementById(`med-lote-${i}`)?.value.trim() || null,
      cad:  document.getElementById(`med-cad-${i}`)?.value || null,
      diferencia: rowDiferencia(i),
    }
    if (fila.re != null || fila.in != null || fila.sa != null || fila.en != null || fila.lote) capturados++
    conteos.push(fila)
  })

  if (!capturados) { toast('Captura al menos un medicamento.', 'red'); return }

  const btn = document.getElementById('btn-guardar')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const { error } = await db.from('pharmacy_controlled_counts').insert({
    fecha, turno, grupo, responsable,
    conteos,
    observaciones: document.getElementById('f-obs')?.value.trim() || null,
    created_by: _user.id,
    created_by_name: _profile?.full_name || _user.email,
  })

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar conteo'

  if (error) { toast('Error al guardar: ' + error.message, 'red'); return }
  toast('Conteo registrado correctamente.', 'green')
  resetForm()
  await loadLogs()
}

function resetForm() {
  ;['f-turno','f-grupo','f-responsable','f-obs'].forEach(id => setVal(id, ''))
  setVal('f-fecha', new Date().toISOString().split('T')[0])
  buildConteo()
}

// ── Historial ───────────────────────────────────────────────────
async function loadLogs() {
  const { data, error } = await db.from('pharmacy_controlled_counts')
    .select('*')
    .order('fecha', { ascending: false })
    .order('created_at', { ascending: false })
    .limit(90)

  const tbody = document.getElementById('hist-body')
  if (!tbody) return
  if (error) {
    tbody.innerHTML = `<tr><td colspan="6" style="text-align:center;color:#991b1b;padding:22px">
      Error: ${esc(error.message)}${error.message.includes('pharmacy_controlled_counts')
        ? ' — falta ejecutar la migración sql/farmacia_controlados_setup.sql en Supabase' : ''}</td></tr>`
    return
  }
  _logs = data || []
  if (!_logs.length) {
    tbody.innerHTML = `<tr><td colspan="6" style="text-align:center;color:#9ca3af;padding:26px">
      Sin conteos registrados — captura el primero arriba.</td></tr>`
    return
  }

  const turnoPill = t => {
    const cls = t === 'Matutino' ? 'pill-mat' : t === 'Vespertino' ? 'pill-ves' : 'pill-noc'
    return `<span class="pill-turno ${cls}">${esc(t)}</span>`
  }
  const canDelete = ['administrador', 'responsable_calidad'].includes(_role)

  tbody.innerHTML = _logs.map(l => {
    const difs = (l.conteos || []).filter(c => c.diferencia).length
    return `<tr>
      <td>${fmtFecha(l.fecha)}</td>
      <td>${turnoPill(l.turno)}</td>
      <td><strong>Grupo ${esc(l.grupo)}</strong></td>
      <td>${esc(l.responsable)}</td>
      <td style="text-align:center">${difs === 0
        ? '<span class="pill-ok"><i class="fa-solid fa-check"></i> Sin diferencias</span>'
        : `<span class="pill-alert"><i class="fa-solid fa-triangle-exclamation"></i> ${difs} diferencia${difs !== 1 ? 's' : ''}</span>`}</td>
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

  const filas = (l.conteos || []).map(c => `
    <tr style="${c.diferencia ? 'background:#fef2f2' : ''}">
      <td style="padding:7px 10px;border-bottom:1px solid #f5f5f5">${esc(c.medicamento)}
        ${c.diferencia ? ' <span style="color:#dc2626" title="EN no coincide con RE+IN−SA">⚠️</span>' : ''}</td>
      <td style="text-align:center;padding:7px;border-bottom:1px solid #f5f5f5">${c.re ?? '—'}</td>
      <td style="text-align:center;padding:7px;border-bottom:1px solid #f5f5f5">${c.in ?? '—'}</td>
      <td style="text-align:center;padding:7px;border-bottom:1px solid #f5f5f5">${c.sa ?? '—'}</td>
      <td style="text-align:center;padding:7px;border-bottom:1px solid #f5f5f5;font-weight:700">${c.en ?? '—'}</td>
      <td style="padding:7px;border-bottom:1px solid #f5f5f5">${esc(c.lote || '—')}</td>
      <td style="padding:7px;border-bottom:1px solid #f5f5f5">${esc(c.cad || '—')}</td>
    </tr>`).join('')

  setText('det-title', `Conteo Grupo ${l.grupo} — ${fmtFecha(l.fecha)} · Turno ${l.turno}`)
  document.getElementById('det-body').innerHTML = `
    <div class="det-grid">
      <div><label>Responsable</label>${esc(l.responsable)}</div>
      <div><label>Registrado por</label>${esc(l.created_by_name || '—')}</div>
    </div>
    <div class="det-sep">Conteo de medicamentos</div>
    <div style="overflow-x:auto">
      <table style="width:100%;border-collapse:collapse;font-size:.82rem;min-width:560px">
        <thead><tr>
          <th style="text-align:left;padding:7px 10px;font-size:.7rem;color:#6b7280;text-transform:uppercase;border-bottom:2px solid #f0f0f0">Medicamento</th>
          <th style="padding:7px;font-size:.7rem;color:#6b7280;border-bottom:2px solid #f0f0f0">RE</th>
          <th style="padding:7px;font-size:.7rem;color:#6b7280;border-bottom:2px solid #f0f0f0">IN</th>
          <th style="padding:7px;font-size:.7rem;color:#6b7280;border-bottom:2px solid #f0f0f0">SA</th>
          <th style="padding:7px;font-size:.7rem;color:#6b7280;border-bottom:2px solid #f0f0f0">EN</th>
          <th style="text-align:left;padding:7px;font-size:.7rem;color:#6b7280;border-bottom:2px solid #f0f0f0">Lote</th>
          <th style="text-align:left;padding:7px;font-size:.7rem;color:#6b7280;border-bottom:2px solid #f0f0f0">Cad.</th>
        </tr></thead>
        <tbody>${filas}</tbody>
      </table>
    </div>
    ${l.observaciones ? `<div class="det-sep">Observaciones</div>
      <div style="font-size:.87rem;white-space:pre-wrap">${esc(l.observaciones)}</div>` : ''}
    <div style="margin-top:16px;font-size:.74rem;color:#9ca3af">
      Registrado el ${new Date(l.created_at).toLocaleString('es-MX')}
    </div>`
  document.getElementById('modal-det').classList.add('open')
}

// ── Eliminar ────────────────────────────────────────────────────
async function eliminar(id) {
  if (!confirm('¿Eliminar este conteo? Esta acción no se puede deshacer.')) return
  const { error } = await db.from('pharmacy_controlled_counts').delete().eq('id', id)
  if (error) { toast('Error al eliminar: ' + error.message, 'red'); return }
  toast('Conteo eliminado.', 'green')
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
