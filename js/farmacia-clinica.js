// ─── Bitácora de Pacientes — Farmacia Clínica ────────────────────

let _user    = null
let _profile = null
let _role    = null
let _pacientes = []
let _notas     = []   // enlaces de turno
let _editId    = null // paciente en edición
let _notaPacId = null // paciente al que se agrega enlace

// ── Init ────────────────────────────────────────────────────────
async function init() {
  const auth = await requireAuth()
  if (!auth?.user) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  requirePermission(_profile, 'farmacia_clinica')

  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
  const dateEl = document.getElementById('current-date')
  if (dateEl) dateEl.textContent = new Date().toLocaleDateString('es-MX',
    { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })

  await loadData()
}

function setText(id, v) { const el = document.getElementById(id); if (el) el.textContent = v }
function setVal(id, v)  { const el = document.getElementById(id); if (el) el.value = v }
function esc(s) {
  return String(s ?? '').replace(/[&<>"']/g, c =>
    ({ '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;' }[c]))
}
function openM(id)  { document.getElementById(id)?.classList.add('open') }
function closeM(id) { document.getElementById(id)?.classList.remove('open') }
function hoy() { return new Date().toISOString().split('T')[0] }

// ── Cargar datos ────────────────────────────────────────────────
async function loadData() {
  const [pRes, nRes] = await Promise.all([
    db.from('pharmacy_clinical_patients').select('*').order('hab', { ascending: true }),
    db.from('pharmacy_clinical_notes').select('*').order('fecha', { ascending: false })
      .order('created_at', { ascending: false }).limit(600),
  ])

  const tbody = document.getElementById('censo-body')
  if (pRes.error) {
    if (tbody) tbody.innerHTML = `<tr><td colspan="9" style="text-align:center;color:#991b1b;padding:22px">
      Error: ${esc(pRes.error.message)}${pRes.error.message.includes('pharmacy_clinical')
        ? ' — falta ejecutar la migración sql/farmacia_clinica_setup.sql en Supabase' : ''}</td></tr>`
    return
  }
  _pacientes = pRes.data || []
  _notas     = nRes.data || []
  renderCenso()
}

// ── Censo ───────────────────────────────────────────────────────
function renderCenso() {
  const tbody = document.getElementById('censo-body')
  if (!tbody) return
  const verAltas = document.getElementById('chk-altas')?.checked

  const lista = _pacientes.filter(p => verAltas ? true : p.activo !== false)
  setText('censo-count', `${lista.filter(p => p.activo !== false).length} paciente${lista.length !== 1 ? 's' : ''} activos`)

  if (!lista.length) {
    tbody.innerHTML = `<tr><td colspan="9" style="text-align:center;color:#9ca3af;padding:26px">
      Sin pacientes — usa "Ingresar paciente" para registrar el primero.</td></tr>`
    return
  }

  const f = hoy()
  const notaHoy = (pid, turno) =>
    _notas.find(n => n.patient_id === pid && n.fecha === f && n.turno === turno)

  tbody.innerHTML = lista.map(p => {
    const alta = p.activo === false
    const turnos = ['M', 'V', 'N'].map(t => {
      const n = notaHoy(p.id, t)
      return n
        ? `<span title="${esc(n.nota)} — ${esc(n.autor || '')}" style="cursor:help;color:#0f766e;font-weight:800">${t}</span>`
        : `<span style="color:#d1d5db">${t}</span>`
    }).join(' · ')

    return `<tr style="${alta ? 'opacity:.55' : ''}">
      <td><strong>${esc(p.hab)}</strong>${alta ? '<div style="font-size:.68rem;color:#9ca3af">ALTA</div>' : ''}</td>
      <td style="max-width:180px">${esc(p.paciente)}</td>
      <td>${fmtFecha(p.fecha_ingreso)}</td>
      <td style="max-width:200px">${esc(p.diagnostico || '—')}
        ${p.comorbilidades ? `<div style="font-size:.72rem;color:#9ca3af">${esc(p.comorbilidades)}</div>` : ''}</td>
      <td style="max-width:170px">${p.alergias && !/^(negadas?|no|ninguna)\.?$/i.test(p.alergias.trim())
        ? `<span style="color:#b91c1c;font-weight:700"><i class="fa-solid fa-triangle-exclamation"></i> ${esc(p.alergias)}</span>`
        : `<span style="color:#9ca3af">${esc(p.alergias || '—')}</span>`}</td>
      <td style="text-align:center">${p.conciliacion
        ? '<span class="pill-ok"><i class="fa-solid fa-check"></i></span>'
        : '<span class="pill-alert">Pendiente</span>'}</td>
      <td style="text-align:center;font-size:.8rem">${p.ram && !/^(sin ram|no|ninguna)\.?$/i.test(p.ram.trim())
        ? `<span style="color:#b91c1c;font-weight:700" title="${esc(p.ram)}">Sí ⚠️</span>`
        : '<span style="color:#9ca3af">No</span>'}</td>
      <td style="text-align:center;letter-spacing:1px">${turnos}</td>
      <td style="text-align:center;white-space:nowrap">
        <button class="btn-action" onclick="verDetalle('${p.id}')" title="Ver expediente y enlaces"><i class="fa-solid fa-eye"></i></button>
        ${!alta ? `
          <button class="btn-action" style="margin-left:6px" onclick="openNota('${p.id}')" title="Agregar enlace de turno"><i class="fa-solid fa-comment-medical"></i></button>
          <button class="btn-action" style="margin-left:6px" onclick="openPaciente('${p.id}')" title="Editar"><i class="fa-solid fa-pencil"></i></button>
          <button class="btn-action del" onclick="darAlta('${p.id}')" title="Dar de alta"><i class="fa-solid fa-person-walking-arrow-right"></i></button>
        ` : ''}
      </td>
    </tr>`
  }).join('')
}

function fmtFecha(f) {
  if (!f) return '—'
  return new Date(f + 'T12:00:00').toLocaleDateString('es-MX',
    { day: '2-digit', month: 'short', year: 'numeric' })
}

// ── Alta / edición de paciente ──────────────────────────────────
function openPaciente(id = null) {
  _editId = id
  const p = id ? _pacientes.find(x => x.id === id) : null
  setText('pac-title', p ? `Editar — ${p.hab} · ${p.paciente}` : 'Ingresar paciente')
  setVal('p-hab',      p?.hab || '')
  setVal('p-ingreso',  p?.fecha_ingreso || hoy())
  setVal('p-nombre',   p?.paciente || '')
  setVal('p-dx',       p?.diagnostico || '')
  setVal('p-comorb',   p?.comorbilidades || '')
  setVal('p-alergias', p?.alergias || '')
  setVal('p-ram',      p?.ram || '')
  const chk = document.getElementById('p-conciliacion')
  if (chk) chk.checked = !!p?.conciliacion
  openM('modal-pac')
}

async function guardarPaciente() {
  const hab     = document.getElementById('p-hab')?.value.trim().toUpperCase()
  const ingreso = document.getElementById('p-ingreso')?.value
  const nombre  = document.getElementById('p-nombre')?.value.trim()

  if (!hab)     { toast('La habitación es obligatoria.', 'red'); return }
  if (!ingreso) { toast('La fecha de ingreso es obligatoria.', 'red'); return }
  if (!nombre)  { toast('El nombre del paciente es obligatorio.', 'red'); return }

  // Evitar dos pacientes activos en la misma habitación
  const ocupada = _pacientes.find(p =>
    p.hab === hab && p.activo !== false && p.id !== _editId)
  if (ocupada && !confirm(`La habitación ${hab} ya tiene un paciente activo (${ocupada.paciente}). ¿Registrar de todos modos?`)) return

  const payload = {
    hab,
    fecha_ingreso: ingreso,
    paciente: nombre,
    diagnostico:    document.getElementById('p-dx')?.value.trim() || null,
    comorbilidades: document.getElementById('p-comorb')?.value.trim() || null,
    alergias:       document.getElementById('p-alergias')?.value.trim() || null,
    conciliacion:   !!document.getElementById('p-conciliacion')?.checked,
    ram:            document.getElementById('p-ram')?.value.trim() || null,
  }

  const btn = document.getElementById('btn-save-pac')
  btn.disabled = true

  let error
  if (_editId) {
    ;({ error } = await db.from('pharmacy_clinical_patients').update(payload).eq('id', _editId))
  } else {
    payload.activo = true
    payload.created_by = _user.id
    payload.created_by_name = _profile?.full_name || _user.email
    ;({ error } = await db.from('pharmacy_clinical_patients').insert(payload))
  }

  btn.disabled = false
  if (error) { toast('Error al guardar: ' + error.message, 'red'); return }
  toast(_editId ? 'Paciente actualizado.' : 'Paciente ingresado al censo.', 'green')
  closeM('modal-pac')
  await loadData()
}

async function darAlta(id) {
  const p = _pacientes.find(x => x.id === id)
  if (!p) return
  if (!confirm(`¿Dar de alta a ${p.paciente} (${p.hab})? Saldrá del censo activo pero su historial se conserva.`)) return
  const { error } = await db.from('pharmacy_clinical_patients')
    .update({ activo: false, alta_at: new Date().toISOString() }).eq('id', id)
  if (error) { toast('Error: ' + error.message, 'red'); return }
  toast('Paciente dado de alta.', 'green')
  await loadData()
}

// ── Enlaces de turno ────────────────────────────────────────────
function openNota(pacId) {
  _notaPacId = pacId
  const p = _pacientes.find(x => x.id === pacId)
  setText('nota-title', `Enlace de turno — ${p?.hab} · ${p?.paciente}`)
  setVal('n-fecha', hoy())
  setVal('n-nota', '')
  // Sugerir turno según la hora
  const h = new Date().getHours()
  setVal('n-turno', h < 14 ? 'M' : h < 21 ? 'V' : 'N')
  openM('modal-nota')
}

async function guardarNota() {
  const nota = document.getElementById('n-nota')?.value.trim()
  if (!nota) { toast('Escribe la nota de enlace.', 'red'); return }

  const btn = document.getElementById('btn-save-nota')
  btn.disabled = true

  const { error } = await db.from('pharmacy_clinical_notes').insert({
    patient_id: _notaPacId,
    fecha: document.getElementById('n-fecha')?.value || hoy(),
    turno: document.getElementById('n-turno')?.value || 'M',
    nota,
    autor: _profile?.full_name || _user.email,
    created_by: _user.id,
  })

  btn.disabled = false
  if (error) { toast('Error al guardar: ' + error.message, 'red'); return }
  toast('Enlace registrado.', 'green')
  closeM('modal-nota')
  await loadData()
}

// ── Detalle / expediente ────────────────────────────────────────
function verDetalle(id) {
  const p = _pacientes.find(x => x.id === id)
  if (!p) return
  const notas = _notas.filter(n => n.patient_id === id)
  const turnoNombre = { M: 'Matutino', V: 'Vespertino', N: 'Nocturno' }

  const notasHtml = notas.length
    ? notas.map(n => `
      <div style="border-left:3px solid #5eead4;padding:8px 12px;margin-bottom:10px;background:#f8fafc;border-radius:0 8px 8px 0">
        <div style="font-size:.72rem;font-weight:700;color:#0f766e">
          ${fmtFecha(n.fecha)} · ${turnoNombre[n.turno] || n.turno}
          <span style="color:#9ca3af;font-weight:500"> — ${esc(n.autor || '')}</span>
        </div>
        <div style="font-size:.86rem;margin-top:3px;white-space:pre-wrap">${esc(n.nota)}</div>
      </div>`).join('')
    : '<div style="color:#9ca3af;font-size:.84rem">Sin enlaces registrados.</div>'

  setText('det-title', `${p.hab} — ${p.paciente}`)
  document.getElementById('det-body').innerHTML = `
    <div class="det-grid">
      <div><label>Fecha de ingreso</label>${fmtFecha(p.fecha_ingreso)}</div>
      <div><label>Estado</label>${p.activo === false
        ? `Dado de alta ${p.alta_at ? '· ' + new Date(p.alta_at).toLocaleDateString('es-MX') : ''}`
        : 'Activo en censo'}</div>
      <div><label>Diagnóstico</label>${esc(p.diagnostico || '—')}</div>
      <div><label>Comorbilidades</label>${esc(p.comorbilidades || '—')}</div>
      <div><label>Alergias</label>${esc(p.alergias || '—')}</div>
      <div><label>RAM</label>${esc(p.ram || 'Sin RAM')}</div>
      <div><label>Conciliación</label>${p.conciliacion ? '✔ Realizada' : '✘ Pendiente'}</div>
      <div><label>Registró</label>${esc(p.created_by_name || '—')}</div>
    </div>
    <div class="det-sep">Enlaces de turno (${notas.length})</div>
    ${notasHtml}`
  openM('modal-det')
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
