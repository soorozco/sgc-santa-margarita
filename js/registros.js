// ─── Control de Registros (Formatos FT) — Cláusula 7.5 ──────────

let _user            = null
let _profile         = null
let _role            = null
let _allRegs         = []
let _filteredRegs    = []
let _depts           = []
let _personal        = []
let _currentId       = null
let _currentPdfUrl   = null
let _currentPdfName  = null
let _coverage        = {}   // { 'FT-CH-02': { count: 2, refs: [{code,name,type}] } }

// ── Helpers ─────────────────────────────────────────────────────
function setText(id, val) {
  const el = document.getElementById(id)
  if (el) el.textContent = val
}
function setVal(id, val) {
  const el = document.getElementById(id)
  if (el) el.value = val
}
function esc(str) {
  if (str == null) return ''
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
}
function fmtDate(str) {
  if (!str) return '—'
  const [y, m, d] = str.split('T')[0].split('-')
  return `${d}/${m}/${y}`
}
function sLabel(s) {
  return { vigente:'Vigente', borrador:'Borrador', en_revision:'En Revisión',
           en_aprobacion:'En Aprobación', obsoleto:'Obsoleto' }[s] || s || '—'
}
function sPill(s) {
  return { vigente:'pill--vigente', borrador:'pill--borrador',
           en_revision:'pill--revision', en_aprobacion:'pill--aprobacion',
           obsoleto:'pill--obsoleto' }[s] || ''
}
function resetBtn(btn, html) {
  if (btn) { btn.disabled = false; btn.innerHTML = html }
}
function showToast(msg, type) {
  const el = document.getElementById('toast')
  if (!el) return
  el.textContent = msg
  el.className   = `toast toast--${type} show`
  clearTimeout(el._t)
  el._t = setTimeout(() => el.classList.remove('show'), 3500)
}

// ── Init ─────────────────────────────────────────────────────────
async function initRegistros() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')

  const dateEl = document.getElementById('current-date')
  if (dateEl) dateEl.textContent = new Date().toLocaleDateString('es-MX', {
    weekday: 'long', day: 'numeric', month: 'long', year: 'numeric'
  })

  await Promise.all([loadDepts(), loadPersonal()])
  populateFilters()
  await loadRegistros()
  loadCoverage()   // carga en segundo plano, sin bloquear
  applyRoleUI()
}

// ── Catálogos ────────────────────────────────────────────────────
async function loadDepts() {
  const { data } = await db.from('departments')
    .select('id,code,name').eq('is_active', true).order('name')
  _depts = data || []
}

async function loadPersonal() {
  const { data } = await db.from('personal')
    .select('codigo,nombre,puesto,departamento')
    .eq('activo', true)
    .order('nombre')
  _personal = data || []
}

function populateFilters() {
  // Dept filter in toolbar
  const fDept = document.getElementById('f-dept')
  if (fDept) {
    const opts = _depts.map(d =>
      `<option value="${d.id}">${esc(d.name)}</option>`).join('')
    fDept.innerHTML = `<option value="">Todos los departamentos</option>${opts}`
  }

  // Dept select in new modal
  const nDept = document.getElementById('new-dept')
  if (nDept) {
    const opts = _depts.map(d =>
      `<option value="${d.id}">${esc(d.name)}</option>`).join('')
    nDept.innerHTML = `<option value="">— Sin asignar —</option>${opts}`
  }

  populatePersonalSelects()
}

function populatePersonalSelects() {
  const blank = '<option value="">— Sin asignar —</option>'
  const opts = blank + _personal.map(p =>
    `<option value="${esc(p.nombre)}">${esc(p.nombre)}${p.puesto ? ' — ' + esc(p.puesto) : ''}</option>`
  ).join('')

  ;['edit-elaborated-by','edit-reviewed-by','edit-authorized-by',
    'new-elaborated-by', 'new-reviewed-by', 'new-authorized-by'].forEach(id => {
    const sel = document.getElementById(id)
    if (sel) sel.innerHTML = opts
  })
}

function updateCargo(selectEl, cargoId) {
  const name   = selectEl.value
  const person = _personal.find(p => p.nombre === name)
  const el     = document.getElementById(cargoId)
  if (el) el.textContent = person?.puesto || ''
}

// ── Cobertura (qué documentos referencian cada FT) ──────────────
async function loadCoverage() {
  const { data, error } = await db.rpc('get_ft_coverage')
  _coverage = {}   // inicializar siempre, aunque sea vacío
  if (error || !data) {
    console.warn('loadCoverage error:', error)
    // Marcar todos los registros con null para mostrar "N/D" en lugar de "Calculando…"
    _allRegs.forEach(r => { if (!(_coverage[r.code])) _coverage[r.code] = null })
    renderTable()
    return
  }
  data.forEach(row => {
    _coverage[row.ft_code] = {
      count: Number(row.ref_count),
      refs:  Array.isArray(row.refs) ? row.refs : []
    }
  })
  renderTable()
}

function covBadge(code) {
  const cov = _coverage[code]
  if (cov === undefined) {
    return `<span class="badge-cov badge-cov--loading" title="Calculando…">—</span>`
  }
  if (cov === null) {
    return `<span class="badge-cov badge-cov--loading" title="No disponible">N/D</span>`
  }
  if (cov.count === 0) {
    return `<span class="badge-cov badge-cov--none" title="No aparece en ningún PR o IT">Sin ref.</span>`
  }
  const tip = cov.refs.map(r => `${r.code}`).join(' · ')
  return `<span class="badge-cov badge-cov--ok" title="${esc(tip)}">
    <i class="fa-solid fa-check"></i> ${cov.count}
  </span>`
}

function applyRoleUI() {
  const canWrite = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)
  const btn = document.getElementById('btn-new-reg')
  if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'
}

// ── Cargar registros ─────────────────────────────────────────────
async function loadRegistros() {
  const tbody = document.getElementById('reg-tbody')
  if (tbody) tbody.innerHTML = `
    <tr><td colspan="7" class="table-empty">
      <i class="fa-solid fa-spinner fa-spin"></i>
      <strong>Cargando formatos…</strong>
    </td></tr>`

  const { data, error } = await db
    .from('documents')
    .select('*, document_types(id,code_prefix,name), departments(id,code,name)')
    .eq('document_types.code_prefix', 'FT')
    .not('document_types', 'is', null)
    .order('code', { ascending: true })

  if (error) {
    if (tbody) tbody.innerHTML =
      `<tr><td colspan="7" class="table-empty" style="color:var(--red)">
        <i class="fa-solid fa-circle-exclamation"></i>
        <strong>Error al cargar: ${esc(error.message)}</strong>
      </td></tr>`
    return
  }

  // Filtrar solo FT por si acaso el filtro de join no es suficiente
  _allRegs = (data || []).filter(d => d.document_types?.code_prefix === 'FT')

  document.getElementById('content-area').style.display = 'block'
  applyFilters()  // respeta los filtros activos en vez de resetear la vista
}

// ── Filtros ──────────────────────────────────────────────────────
function applyFilters() {
  const q      = (document.getElementById('search-input')?.value || '').toLowerCase().trim()
  const dept   = document.getElementById('f-dept')?.value   || ''
  const status = document.getElementById('f-status')?.value || ''
  const ret    = document.getElementById('f-ret')?.value    || ''

  _filteredRegs = _allRegs.filter(r => {
    const txt = `${r.code} ${r.name}`.toLowerCase()
    const matchQ    = !q      || txt.includes(q)
    const matchDept = !dept   || r.department_id === dept
    const matchSt   = !status || r.status === status
    const matchRet  = !ret    ||
      (ret === 'sin' && r.retention_years == null) ||
      (ret === 'con' && r.retention_years != null)
    return matchQ && matchDept && matchSt && matchRet
  })

  updateKPIs()
  renderTable()
}

function clearFilters() {
  setVal('search-input', '')
  setVal('f-dept',   '')
  setVal('f-status', '')
  setVal('f-ret',    '')
  _filteredRegs = _allRegs
  updateKPIs()
  renderTable()
}

// ── KPIs ─────────────────────────────────────────────────────────
function updateKPIs() {
  const depts  = new Set(_allRegs.map(r => r.department_id)).size
  const sinRet = _allRegs.filter(r => r.retention_years == null).length
  setText('kpi-total',    _allRegs.length)
  setText('kpi-depts',    depts)
  setText('kpi-sin-ret',  sinRet)
  setText('kpi-filtered', _filteredRegs.length)
}

// ── Render tabla ─────────────────────────────────────────────────
function renderTable() {
  const tbody  = document.getElementById('reg-tbody')
  const empty  = document.getElementById('empty-state')
  const count  = document.getElementById('reg-count')

  if (count) count.textContent =
    `${_filteredRegs.length} formato${_filteredRegs.length !== 1 ? 's' : ''}`

  if (_filteredRegs.length === 0) {
    if (tbody) tbody.innerHTML = ''
    if (empty) empty.style.display = 'flex'
    return
  }

  if (empty) empty.style.display = 'none'

  const canWrite = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)

  tbody.innerHTML = _filteredRegs.map(r => {
    const retLabel = r.retention_years != null
      ? `<span class="badge-ret">${r.retention_years} año${r.retention_years !== 1 ? 's' : ''}</span>`
      : `<span class="badge-ret badge-ret--sin">Sin definir</span>`

    return `
      <tr onclick="openPdfViewer('${r.id}')" style="cursor:pointer" title="Ver PDF">
        <td><span class="doc-code">${esc(r.code)}</span></td>
        <td><span class="doc-name" title="${esc(r.name)}">${esc(r.name)}</span></td>
        <td>${esc(r.departments?.name || '—')}</td>
        <td class="center"><strong>v${esc(r.current_version || '1')}</strong></td>
        <td>${retLabel}</td>
        <td class="center">${covBadge(r.code)}</td>
        <td class="center"><span class="pill ${sPill(r.status)}">${sLabel(r.status)}</span></td>
        <td class="center" onclick="event.stopPropagation()">
          <div class="action-btns">
            <button onclick="openPdfViewer('${r.id}')" class="btn-action teal" title="Ver PDF">
              <i class="fa-solid fa-file-pdf"></i>
            </button>
            <button onclick="openDetail('${r.id}')" class="btn-action" title="Ver detalle">
              <i class="fa-solid fa-eye"></i>
            </button>
            ${canWrite ? `
            <button onclick="openEdit('${r.id}')" class="btn-action blue" title="Editar">
              <i class="fa-solid fa-pencil"></i>
            </button>
            <button onclick="openUpload('${r.id}')" class="btn-action green" title="Subir PDF">
              <i class="fa-solid fa-upload"></i>
            </button>` : ''}
          </div>
        </td>
      </tr>`
  }).join('')
}

// ── Modal helpers ────────────────────────────────────────────────
function openModal(id) {
  document.getElementById(id)?.classList.add('open')
}
function closeModal(id) {
  document.getElementById(id)?.classList.remove('open')
}

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.modal-overlay').forEach(overlay => {
    overlay.addEventListener('click', e => {
      if (e.target === overlay) overlay.classList.remove('open')
    })
  })
})

// ── Modal: VER DETALLE ───────────────────────────────────────────
async function openDetail(regId) {
  _currentId = regId
  const reg = _allRegs.find(r => r.id === regId)
  if (!reg) return

  // Cabecera
  setText('d-code-ttl', reg.code)
  setText('d-name-ttl', reg.name)

  // Info grid
  setText('d-code',      reg.code)
  setText('d-version',   `v${reg.current_version || '1'}`)
  setText('d-status',    sLabel(reg.status))
  setText('d-dept',      reg.departments?.name || '—')
  setText('d-retention', reg.retention_years ? `${reg.retention_years} año(s)` : '—')
  setText('d-elab-date', reg.elaboration_date ? fmtDate(reg.elaboration_date) : '—')

  // Elaboró / Revisó / Autorizó con cargo
  const elaboroPerson  = _personal.find(p => p.nombre === reg.elaborated_by)
  const revisoPerson   = _personal.find(p => p.nombre === reg.reviewed_by)
  const autorizoPerson = _personal.find(p => p.nombre === reg.authorized_by)
  setText('d-elaborated',       reg.elaborated_by  || '—')
  setText('d-elaborated-cargo', elaboroPerson?.puesto  || '')
  setText('d-reviewed',         reg.reviewed_by    || '—')
  setText('d-reviewed-cargo',   revisoPerson?.puesto   || '')
  setText('d-authorized',       reg.authorized_by  || '—')
  setText('d-authorized-cargo', autorizoPerson?.puesto || '')

  // Cobertura en el modal de detalle
  const covList = document.getElementById('d-coverage-list')
  if (covList) {
    const cov = _coverage[reg.code]
    if (!cov) {
      covList.innerHTML = `<p style="font-size:.82rem;color:var(--txt3)">Calculando…</p>`
    } else if (cov.count === 0) {
      covList.innerHTML = `
        <div class="cov-empty">
          <i class="fa-solid fa-triangle-exclamation"></i>
          Este formato no aparece referenciado en ningún procedimiento o instrucción de trabajo con contenido digital.
        </div>`
    } else {
      covList.innerHTML = cov.refs.map(r => `
        <div class="cov-ref-item">
          <span class="doc-code">${esc(r.code)}</span>
          <span class="cov-ref-name">${esc(r.name)}</span>
        </div>`).join('')
    }
  }

  // Enlace al archivo editable
  const tplWrap = document.getElementById('d-template-wrap')
  const tplLink = document.getElementById('d-template-url')
  if (reg.template_url) {
    if (tplWrap) tplWrap.style.display = 'block'
    if (tplLink) { tplLink.href = reg.template_url; tplLink.textContent = reg.template_url }
  } else {
    if (tplWrap) tplWrap.style.display = 'none'
  }

  // Botones en footer del modal
  const canWrite = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)
  const btnUp = document.getElementById('btn-upload-ver')
  const btnEd = document.getElementById('btn-edit-from-detail')
  if (btnUp) btnUp.style.display = canWrite ? 'inline-flex' : 'none'
  if (btnEd) btnEd.style.display = canWrite ? 'inline-flex' : 'none'

  // Historial de versiones
  await loadVersions(regId)

  openModal('modal-detail')
}

// ── Modal: EDITAR desde detalle ──────────────────────────────────
function openEditFromDetail() {
  closeModal('modal-detail')
  if (_currentId) openEdit(_currentId)
}

function openUploadFromDetail() {
  closeModal('modal-detail')
  if (_currentId) openUpload(_currentId)
}

// ── Historial de versiones ───────────────────────────────────────
async function loadVersions(regId) {
  const tbody = document.getElementById('versions-tbody')
  if (tbody) tbody.innerHTML =
    `<tr><td colspan="5" style="text-align:center;padding:20px;color:var(--txt3)">
      <i class="fa-solid fa-spinner fa-spin"></i> Cargando…
    </td></tr>`

  const { data } = await db
    .from('document_versions')
    .select('*, profiles:submitted_by(full_name)')
    .eq('document_id', regId)
    .order('created_at', { ascending: false })

  if (!tbody) return

  if (!data || data.length === 0) {
    tbody.innerHTML =
      `<tr><td colspan="5" style="text-align:center;padding:24px;color:var(--txt3)">
        Sin versiones subidas aún
      </td></tr>`
    return
  }

  tbody.innerHTML = data.map(v => `
    <tr>
      <td><strong>v${esc(v.version)}</strong></td>
      <td>${fmtDate(v.change_date)}</td>
      <td>${esc(v.profiles?.full_name || '—')}</td>
      <td>${esc(v.change_summary || '—')}</td>
      <td class="center">
        ${v.file_path ? `
        <button onclick="downloadFile('${esc(v.file_path)}','${esc(v.file_name || 'formato')}')"
                class="btn-action green" title="Descargar">
          <i class="fa-solid fa-download"></i>
        </button>` : '—'}
      </td>
    </tr>
  `).join('')
}

async function downloadFile(filePath, fileName) {
  const { data, error } = await db.storage
    .from('sgc-documents')
    .createSignedUrl(filePath, 3600)
  if (error) { showToast('Error al generar enlace de descarga.', 'red'); return }
  const a = document.createElement('a')
  a.href = data.signedUrl; a.download = fileName; a.target = '_blank'; a.click()
}

// ── Modal: EDITAR ────────────────────────────────────────────────
function openEdit(regId) {
  _currentId = regId
  const reg = _allRegs.find(r => r.id === regId)
  if (!reg) return

  setText('edit-reg-code', reg.code)

  // Dept select
  const eDept = document.getElementById('edit-dept')
  if (eDept) {
    const opts = _depts.map(d =>
      `<option value="${d.id}" ${d.id === reg.department_id ? 'selected' : ''}>${esc(d.name)}</option>`
    ).join('')
    eDept.innerHTML = `<option value="">— Sin asignar —</option>${opts}`
  }

  setVal('edit-code',      reg.code)
  setVal('edit-version',   reg.current_version || '1')
  setVal('edit-name',      reg.name)
  setVal('edit-status',    reg.status || 'vigente')
  setVal('edit-retention',     reg.retention_years   || '')
  setVal('edit-elab-date',     reg.elaboration_date  || '')
  setVal('edit-template-url',  reg.template_url      || '')

  // Personal selects
  populatePersonalSelects()
  setVal('edit-elaborated-by', reg.elaborated_by  || '')
  setVal('edit-reviewed-by',   reg.reviewed_by    || '')
  setVal('edit-authorized-by', reg.authorized_by  || '')

  // Cargos visibles al abrir
  const cargoMap = {
    'edit-elaborated-by': 'edit-elaboro-cargo',
    'edit-reviewed-by':   'edit-reviso-cargo',
    'edit-authorized-by': 'edit-autorizo-cargo'
  }
  Object.entries(cargoMap).forEach(([selId, cargoId]) => {
    const sel = document.getElementById(selId)
    const cargoEl = document.getElementById(cargoId)
    if (sel && cargoEl) {
      const person = _personal.find(p => p.nombre === sel.value)
      cargoEl.textContent = person?.puesto || ''
    }
  })

  openModal('modal-edit')
}

async function submitEdit() {
  const btn  = document.getElementById('btn-save-edit')
  const code = document.getElementById('edit-code')?.value.trim().toUpperCase()
  const name = document.getElementById('edit-name')?.value.trim()

  if (!name) { showToast('El nombre del formato es obligatorio.', 'red'); return }
  if (!code) { showToast('El código del formato es obligatorio.', 'red'); return }

  const dup = _allRegs.find(r => r.code === code && r.id !== _currentId)
  if (dup) { showToast(`El código "${code}" ya está en uso.`, 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const payload = {
    code,
    name,
    department_id:   document.getElementById('edit-dept')?.value          || null,
    current_version: document.getElementById('edit-version')?.value.trim() || '1',
    status:          document.getElementById('edit-status')?.value         || 'vigente',
    retention_years: parseInt(document.getElementById('edit-retention')?.value) || null,
    elaboration_date:document.getElementById('edit-elab-date')?.value       || null,
    elaborated_by:   document.getElementById('edit-elaborated-by')?.value   || null,
    reviewed_by:     document.getElementById('edit-reviewed-by')?.value     || null,
    authorized_by:   document.getElementById('edit-authorized-by')?.value   || null,
    template_url:    document.getElementById('edit-template-url')?.value.trim() || null,
    updated_at:      new Date().toISOString()
  }

  let { error } = await db.from('documents')
    .update(payload)
    .eq('id', _currentId)

  // Fallback si authorized_by no existe aún
  if (error && (error.message.includes('authorized_by') || error.code === '42703')) {
    const { authorized_by: _, ...fallback } = payload
    const { error: e2 } = await db.from('documents').update(fallback).eq('id', _currentId)
    error = e2
  }

  if (error) {
    showToast('Error al guardar: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar Cambios')
    return
  }

  showToast(`Formato ${code} actualizado correctamente.`, 'green')
  closeModal('modal-edit')
  resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar Cambios')
  await loadRegistros()
}

// ── Modal: NUEVO FORMATO ─────────────────────────────────────────
function openNewReg() {
  ;['new-code','new-version','new-name','new-retention',
    'new-elab-date','new-elaborated-by','new-reviewed-by','new-authorized-by'].forEach(id => {
    const el = document.getElementById(id)
    if (el) el.value = ''
  })
  setVal('new-version', '1')
  setVal('new-status',  'vigente')
  setVal('new-elab-date', new Date().toISOString().split('T')[0])
  populatePersonalSelects()
  ;['new-elaboro-cargo','new-reviso-cargo','new-autorizo-cargo'].forEach(id => setText(id, ''))
  openModal('modal-new')
}

async function submitNew() {
  const btn  = document.getElementById('btn-save-new')
  const code = document.getElementById('new-code')?.value.trim().toUpperCase()
  const name = document.getElementById('new-name')?.value.trim()

  if (!code) { showToast('El código del formato es obligatorio.', 'red'); return }
  if (!name) { showToast('El nombre del formato es obligatorio.', 'red'); return }

  if (_allRegs.find(r => r.code === code)) {
    showToast(`El código "${code}" ya existe en la lista.`, 'red'); return
  }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  // Obtener document_type_id para FT
  const { data: typeData } = await db.from('document_types')
    .select('id').eq('code_prefix', 'FT').limit(1).single()

  const payload = {
    code,
    name,
    document_type_id: typeData?.id || null,
    department_id:    document.getElementById('new-dept')?.value          || null,
    current_version:  document.getElementById('new-version')?.value.trim() || '1',
    status:           document.getElementById('new-status')?.value         || 'vigente',
    retention_years:  parseInt(document.getElementById('new-retention')?.value) || null,
    elaboration_date: document.getElementById('new-elab-date')?.value       || null,
    elaborated_by:    document.getElementById('new-elaborated-by')?.value   || null,
    reviewed_by:      document.getElementById('new-reviewed-by')?.value     || null,
    authorized_by:    document.getElementById('new-authorized-by')?.value   || null,
    created_by:       _user.id
  }

  const { error } = await db.from('documents').insert(payload)

  if (error) {
    showToast('Error al crear formato: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-plus"></i> Crear Formato')
    return
  }

  showToast(`Formato ${code} creado correctamente.`, 'green')
  closeModal('modal-new')
  resetBtn(btn, '<i class="fa-solid fa-plus"></i> Crear Formato')
  await loadRegistros()
}

// ── Modal: SUBIR PDF ─────────────────────────────────────────────
async function openUpload(regId) {
  _currentId = regId
  const reg = _allRegs.find(r => r.id === regId)
  if (!reg) return

  setText('upload-doc-name', `${reg.code} — ${reg.name}`)
  setVal('upload-date', new Date().toISOString().split('T')[0])
  setVal('upload-changes', '')

  const { data: versions } = await db.from('document_versions')
    .select('id,version').eq('document_id', regId).limit(1)

  const hint   = document.getElementById('upload-version-hint')
  const curVer = reg.current_version || '1'

  if (!versions || versions.length === 0) {
    setVal('upload-version', curVer)
    if (hint) hint.textContent = '⚑ Primera subida. Confirma o corrige la versión real del formato físico.'
  } else {
    const nextVer = isNaN(Number(curVer))
      ? curVer
      : (Math.floor(Number(curVer)) + 1) + ''
    setVal('upload-version', nextVer)
    if (hint) hint.textContent = 'Versión sugerida. Puedes cambiarla si es necesario.'
  }

  clearFile()
  openModal('modal-upload')
}

// Drag & drop
function fileDragOver(e) {
  e.preventDefault()
  document.getElementById('file-drop')?.classList.add('drag')
}
function fileDragLeave(e) {
  document.getElementById('file-drop')?.classList.remove('drag')
}
function fileDrop(e) {
  e.preventDefault()
  document.getElementById('file-drop')?.classList.remove('drag')
  const file = e.dataTransfer.files[0]
  if (file) {
    const inp = document.getElementById('upload-file')
    const dt  = new DataTransfer()
    dt.items.add(file)
    inp.files = dt.files
    showFileSelected(file)
  }
}
function fileSelected(input) {
  const file = input.files[0]
  if (file) showFileSelected(file)
}
function showFileSelected(file) {
  const info = document.getElementById('file-selected-info')
  if (info) {
    info.classList.add('show')
    const span = document.getElementById('file-selected-name')
    if (span) span.textContent = file.name
  }
}
function clearFile() {
  document.getElementById('file-selected-info')?.classList.remove('show')
  const bar  = document.getElementById('upload-progress')
  const fill = document.getElementById('progress-fill')
  if (bar)  bar.classList.remove('show')
  if (fill) fill.style.width = '0%'
  const inp = document.getElementById('upload-file')
  if (inp)  inp.value = ''
}

async function submitUpload() {
  const btn     = document.getElementById('btn-save-upload')
  const inp     = document.getElementById('upload-file')
  const file    = inp?.files[0]
  const version = document.getElementById('upload-version')?.value.trim()
  const changes = document.getElementById('upload-changes')?.value.trim()
  const chDate  = document.getElementById('upload-date')?.value

  if (!file)    { showToast('Selecciona un archivo antes de continuar.', 'red'); return }
  if (!version) { showToast('Indica el número de versión.', 'red'); return }
  if (!_currentId) return

  const reg = _allRegs.find(r => r.id === _currentId)

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Subiendo…'

  const bar  = document.getElementById('upload-progress')
  const fill = document.getElementById('progress-fill')
  if (bar)  bar.classList.add('show')
  if (fill) fill.style.width = '30%'

  const ext      = file.name.split('.').pop().toLowerCase()
  const deptCode = reg?.departments?.code || 'GEN'
  const docCode  = reg?.code || _currentId
  const ts       = Date.now()
  const filePath = `${deptCode}/${docCode}/v${version}_${ts}.${ext}`

  const { error: upErr } = await db.storage
    .from('sgc-documents')
    .upload(filePath, file, { cacheControl: '3600', upsert: false })

  if (upErr) {
    showToast('Error al subir el archivo: ' + upErr.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-cloud-arrow-up"></i> Subir PDF')
    if (bar) bar.classList.remove('show')
    return
  }

  if (fill) fill.style.width = '60%'

  const { error: verErr } = await db.from('document_versions').insert({
    document_id:     _currentId,
    version,
    change_summary:  changes || 'Versión inicial',
    change_date:     chDate  || new Date().toISOString().split('T')[0],
    file_path:       filePath,
    file_name:       file.name,
    file_size_bytes: file.size,
    file_mime_type:  file.type,
    status:          'borrador',
    submitted_by:    _user.id,
    submitted_at:    new Date().toISOString()
  })

  if (verErr) {
    showToast('Error al registrar versión: ' + verErr.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-cloud-arrow-up"></i> Subir PDF')
    return
  }

  if (fill) fill.style.width = '85%'

  await db.from('documents').update({
    current_version: version,
    updated_at:      new Date().toISOString()
  }).eq('id', _currentId)

  if (fill) fill.style.width = '100%'

  setTimeout(async () => {
    showToast(`PDF versión ${version} subido correctamente.`, 'green')
    closeModal('modal-upload')
    resetBtn(btn, '<i class="fa-solid fa-cloud-arrow-up"></i> Subir PDF')
    clearFile()
    await loadRegistros()
  }, 400)
}

// ── Modal: VISOR DE PDF ──────────────────────────────────────────
async function openPdfViewer(regId) {
  _currentId  = regId
  _currentPdfUrl  = null
  _currentPdfName = null
  const reg = _allRegs.find(r => r.id === regId)
  if (!reg) return

  setText('pdf-code-ttl', reg.code)
  setText('pdf-name-ttl', reg.name)

  const iframe  = document.getElementById('pdf-iframe')
  const loading = document.getElementById('pdf-loading')
  const empty   = document.getElementById('pdf-empty')
  const btnDl   = document.getElementById('btn-pdf-download')
  const btnPr   = document.getElementById('btn-pdf-print')

  // Reset
  if (iframe)  { iframe.src = ''; iframe.style.display = 'none' }
  if (loading) loading.style.display = 'flex'
  if (empty)   empty.style.display   = 'none'
  if (btnDl)   btnDl.style.display   = 'none'
  if (btnPr)   btnPr.style.display   = 'none'

  openModal('modal-pdf')

  // Buscar la versión más reciente con archivo
  const { data: versions } = await db
    .from('document_versions')
    .select('file_path,file_name,version')
    .eq('document_id', regId)
    .not('file_path', 'is', null)
    .order('created_at', { ascending: false })
    .limit(1)

  if (!versions || versions.length === 0) {
    if (loading) loading.style.display = 'none'
    if (empty)   empty.style.display   = 'flex'
    return
  }

  const latest = versions[0]
  const { data, error } = await db.storage
    .from('sgc-documents')
    .createSignedUrl(latest.file_path, 3600)

  if (error || !data?.signedUrl) {
    if (loading) loading.style.display = 'none'
    if (empty)   empty.style.display   = 'flex'
    return
  }

  _currentPdfUrl  = data.signedUrl
  _currentPdfName = latest.file_name || `${reg.code}_v${latest.version}.pdf`

  if (loading) loading.style.display = 'none'
  if (iframe)  { iframe.src = _currentPdfUrl; iframe.style.display = 'block' }
  if (btnDl)   btnDl.style.display = 'inline-flex'
  if (btnPr)   btnPr.style.display = 'inline-flex'
}

function downloadCurrentPdf() {
  if (!_currentPdfUrl) return
  const a = document.createElement('a')
  a.href     = _currentPdfUrl
  a.download = _currentPdfName || 'formato.pdf'
  a.target   = '_blank'
  a.click()
}

function printCurrentPdf() {
  const iframe = document.getElementById('pdf-iframe')
  if (!iframe || !_currentPdfUrl) return
  try {
    iframe.contentWindow.print()
  } catch (e) {
    // Fallback: abre en nueva pestaña para imprimir desde ahí
    window.open(_currentPdfUrl, '_blank')
  }
}

// ── Exportar CSV ─────────────────────────────────────────────────
function exportCSV() {
  const headers = ['Código','Nombre','Departamento','Versión','Retención (años)','Estado']
  const rows = _filteredRegs.map(r => [
    r.code,
    r.name,
    r.departments?.name || '',
    r.current_version || '',
    r.retention_years || '',
    r.status || ''
  ])

  const csv = [headers, ...rows]
    .map(row => row.map(c => `"${String(c).replace(/"/g,'""')}"`).join(','))
    .join('\n')

  const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8;' })
  const url  = URL.createObjectURL(blob)
  const a    = document.createElement('a')
  a.href     = url
  a.download = `registros_${new Date().toISOString().split('T')[0]}.csv`
  a.click()
  URL.revokeObjectURL(url)
}

// ── Sidebar ──────────────────────────────────────────────────────
function toggleSidebar() {
  document.getElementById('sidebar')?.classList.toggle('open')
}

// ── Arranque ─────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', initRegistros)
