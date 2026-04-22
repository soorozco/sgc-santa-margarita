// ─── Control de Documentos — Cláusula 7.5 ─────────────────────

let _user         = null
let _profile      = null
let _role         = null
let _allDocs      = []
let _depts        = []
let _types        = []
let _currentDocId = null

// ── Init ────────────────────────────────────────────────────────
async function initDocuments() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  renderUserInfo()
  setCurrentDate()
  await Promise.all([loadDepts(), loadDocTypes()])
  populateFilters()
  await loadDocuments()
  setupSearchFilter()
  applyRoleUI()
}

// ── User info ───────────────────────────────────────────────────
function renderUserInfo() {
  setText('sb-user-name', _profile?.full_name || _user.email.split('@')[0])
  setText('sb-user-role', _profile?.roles?.display_name || 'Usuario')
}

function setCurrentDate() {
  const el = document.getElementById('current-date')
  if (el) el.textContent = new Date().toLocaleDateString('es-MX', {
    weekday:'long', day:'numeric', month:'long', year:'numeric'
  })
}

// ── Catálogos ───────────────────────────────────────────────────
async function loadDepts() {
  const { data } = await db.from('departments')
    .select('id,code,name').eq('is_active', true).order('name')
  _depts = data || []
}

async function loadDocTypes() {
  const { data } = await db.from('document_types')
    .select('id,code_prefix,name').order('code_prefix')
  _types = data || []
}

function populateFilters() {
  const deptOpts = _depts.map(d =>
    `<option value="${d.id}">${d.name}</option>`).join('')
  const typeOpts = _types.map(t =>
    `<option value="${t.id}">${t.code_prefix} — ${t.name}</option>`).join('')

  // Toolbar filters
  const fDept = document.getElementById('f-dept')
  const fType = document.getElementById('f-type')
  if (fDept) fDept.innerHTML = `<option value="">Todos los departamentos</option>${deptOpts}`
  if (fType) fType.innerHTML = `<option value="">Todos los tipos</option>${typeOpts}`

  // New-doc modal selects
  const nDept = document.getElementById('new-dept')
  const nType = document.getElementById('new-type')
  if (nDept) nDept.innerHTML = `<option value="">— Seleccionar —</option>${deptOpts}`
  if (nType) nType.innerHTML = `<option value="">— Seleccionar —</option>${typeOpts}`
}

function applyRoleUI() {
  const canWrite = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)
  const btn = document.getElementById('btn-new-doc')
  if (btn) btn.style.display = canWrite ? 'inline-flex' : 'none'
}

// ── Load documents ──────────────────────────────────────────────
async function loadDocuments() {
  showLoading()
  const { data, error } = await db
    .from('documents')
    .select('*, document_types(id,code_prefix,name), departments(id,code,name)')
    .order('code', { ascending: true })

  if (error) { showError(error.message); return }
  _allDocs = data || []
  renderTable(_allDocs)
}

// ── Filters ─────────────────────────────────────────────────────
function setupSearchFilter() {
  ['search-input','f-dept','f-type','f-status'].forEach(id => {
    const el = document.getElementById(id)
    if (el) el.addEventListener('input', applyFilters)
  })
}

function applyFilters() {
  const q      = (document.getElementById('search-input')?.value || '').toLowerCase()
  const dept   = document.getElementById('f-dept')?.value   || ''
  const type   = document.getElementById('f-type')?.value   || ''
  const status = document.getElementById('f-status')?.value || ''

  const filtered = _allDocs.filter(d => {
    const txt = `${d.code} ${d.name} ${d.custodian_position || ''}`.toLowerCase()
    return (!q || txt.includes(q))
        && (!dept   || d.department_id    === dept)
        && (!type   || d.document_type_id === type)
        && (!status || d.status           === status)
  })
  renderTable(filtered)
}

// ── Render table ─────────────────────────────────────────────────
function renderTable(docs) {
  const tbody = document.getElementById('docs-tbody')
  const count = document.getElementById('doc-count')
  if (count) count.textContent =
    `${docs.length} documento${docs.length !== 1 ? 's' : ''}`
  if (!tbody) return

  if (docs.length === 0) {
    tbody.innerHTML = `
      <tr><td colspan="8" class="table-empty">
        <i class="fa-solid fa-folder-open"></i>
        <strong>Sin documentos</strong>
        Ningún documento coincide con los filtros seleccionados.
      </td></tr>`
    return
  }

  const canWrite = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)

  tbody.innerHTML = docs.map(doc => `
    <tr>
      <td><span class="doc-code">${doc.code}</span></td>
      <td><span class="doc-name" title="${esc(doc.name)}">${esc(doc.name)}</span></td>
      <td><span class="doc-type-tag">${doc.document_types?.code_prefix || '—'}</span></td>
      <td class="center"><strong>v${doc.current_version || '1'}</strong></td>
      <td>${esc(doc.departments?.name || '—')}</td>
      <td>${esc(doc.custodian_position || '—')}</td>
      <td class="center"><span class="pill ${sPill(doc.status)}">${sLabel(doc.status)}</span></td>
      <td>
        <div class="action-btns">
          <button onclick="openDetail('${doc.id}')" class="btn-action" title="Ver detalle">
            <i class="fa-solid fa-eye"></i>
          </button>
          ${canWrite ? `
          <button onclick="openUpload('${doc.id}')" class="btn-action green" title="Subir versión">
            <i class="fa-solid fa-upload"></i>
          </button>` : ''}
        </div>
      </td>
    </tr>
  `).join('')
}

// ── Modal helpers ────────────────────────────────────────────────
function openModal(id) {
  document.getElementById(id)?.classList.add('open')
}

function closeModal(id) {
  document.getElementById(id)?.classList.remove('open')
}

// Close on overlay click
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.modal-overlay').forEach(overlay => {
    overlay.addEventListener('click', e => {
      if (e.target === overlay) overlay.classList.remove('open')
    })
  })
})

// ── Modal: NUEVO DOCUMENTO ───────────────────────────────────────
function openNewDoc() {
  // Reset fields
  ['new-type','new-dept','new-code','new-version','new-name',
   'new-custodian','new-vigencia','new-desc','new-elab-date',
   'new-elaborated-by','new-reviewed-by'].forEach(id => {
    const el = document.getElementById(id)
    if (el) el.value = ''
  })
  setVal('new-version', '1.0')
  setVal('new-vigencia', '2')
  // Set today as elab date
  setVal('new-elab-date', new Date().toISOString().split('T')[0])
  openModal('modal-new')
}

function updateCodePreview() {
  const typeId = document.getElementById('new-type')?.value
  const deptId = document.getElementById('new-dept')?.value
  if (!typeId || !deptId) return

  const type = _types.find(t => t.id === typeId)
  const dept = _depts.find(d => d.id === deptId)
  if (!type || !dept) return

  const codeEl = document.getElementById('new-code')
  if (codeEl && !codeEl.value) {
    // Suggest code prefix: PT-ADM-
    codeEl.value = `${type.code_prefix}-${dept.code}-`
    codeEl.focus()
    // Place cursor at end
    const len = codeEl.value.length
    codeEl.setSelectionRange(len, len)
  }
}

async function submitNewDoc() {
  const btn  = document.getElementById('btn-save-new')
  const code = document.getElementById('new-code')?.value.trim().toUpperCase()
  const name = document.getElementById('new-name')?.value.trim()
  const typeId  = document.getElementById('new-type')?.value
  const deptId  = document.getElementById('new-dept')?.value
  const custodian  = document.getElementById('new-custodian')?.value.trim()
  const vigencia   = document.getElementById('new-vigencia')?.value
  const desc       = document.getElementById('new-desc')?.value.trim()
  const elabDate   = document.getElementById('new-elab-date')?.value
  const elaboratedBy = document.getElementById('new-elaborated-by')?.value.trim()
  const reviewedBy   = document.getElementById('new-reviewed-by')?.value.trim()
  const version      = document.getElementById('new-version')?.value.trim() || '1.0'

  if (!code) { showToast('El código del documento es obligatorio.', 'red'); return }
  if (!name) { showToast('El nombre del documento es obligatorio.', 'red'); return }

  // Validar código único
  if (_allDocs.find(d => d.code === code)) {
    showToast(`El código "${code}" ya existe en la lista maestra.`, 'red')
    return
  }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const payload = {
    code,
    name,
    document_type_id:   typeId    || null,
    department_id:       deptId    || null,
    custodian_position:  custodian || null,
    description:         desc      || null,
    current_version:     version,
    status:              'borrador',
    created_by:          _user.id
  }

  // Optional fields — add if they exist in the table (fail gracefully)
  if (vigencia)     payload.retention_years   = parseInt(vigencia) || 2
  if (elabDate)     payload.elaboration_date  = elabDate
  if (elaboratedBy) payload.elaborated_by     = elaboratedBy
  if (reviewedBy)   payload.reviewed_by       = reviewedBy

  const { data, error } = await db.from('documents').insert(payload).select().single()

  if (error) {
    // If unknown column, retry with minimal payload
    if (error.message.includes('column') || error.code === '42703') {
      const { data: data2, error: err2 } = await db.from('documents').insert({
        code, name,
        document_type_id:  typeId    || null,
        department_id:      deptId    || null,
        custodian_position: custodian || null,
        description:        desc      || null,
        current_version:    version,
        status:             'borrador',
        created_by:         _user.id
      }).select().single()

      if (err2) {
        showToast('Error al crear documento: ' + err2.message, 'red')
        resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar Documento')
        return
      }
    } else {
      showToast('Error al crear documento: ' + error.message, 'red')
      resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar Documento')
      return
    }
  }

  showToast(`Documento ${code} creado correctamente.`, 'green')
  closeModal('modal-new')
  resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar Documento')
  await loadDocuments()
}

// ── Modal: SUBIR VERSIÓN ─────────────────────────────────────────
function openUpload(docId) {
  _currentDocId = docId
  const doc = _allDocs.find(d => d.id === docId)
  if (!doc) return

  setText('upload-doc-name', `${doc.code} — ${doc.name}`)

  // Suggest next version
  const curVer = doc.current_version || '1'
  const nextVer = isNaN(Number(curVer))
    ? curVer
    : String(Math.floor(Number(curVer)) + 1) + '.0'
  setVal('upload-version', nextVer)
  setVal('upload-date', new Date().toISOString().split('T')[0])
  setVal('upload-changes', '')

  clearFile()
  openModal('modal-upload')
}

function openUploadFromDetail() {
  closeModal('modal-detail')
  if (_currentDocId) openUpload(_currentDocId)
}

// Drag & drop handlers
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
    // Create a DataTransfer to assign to input
    const dt = new DataTransfer()
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
  const info = document.getElementById('file-selected-info')
  if (info) info.classList.remove('show')
  const bar  = document.getElementById('upload-progress')
  const fill = document.getElementById('progress-fill')
  if (bar)  bar.classList.remove('show')
  if (fill) fill.style.width = '0%'
  const inp  = document.getElementById('upload-file')
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
  if (!_currentDocId) return

  const doc = _allDocs.find(d => d.id === _currentDocId)

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Subiendo…'

  // Progress bar
  const bar  = document.getElementById('upload-progress')
  const fill = document.getElementById('progress-fill')
  if (bar)  bar.classList.add('show')
  if (fill) fill.style.width = '30%'

  // Build storage path
  const ext      = file.name.split('.').pop().toLowerCase()
  const deptCode = doc?.departments?.code || 'GEN'
  const docCode  = doc?.code || _currentDocId
  const ts       = Date.now()
  const filePath = `${deptCode}/${docCode}/v${version}_${ts}.${ext}`

  // Upload file
  const { error: upErr } = await db.storage
    .from('sgc-documents')
    .upload(filePath, file, { cacheControl: '3600', upsert: false })

  if (upErr) {
    showToast('Error al subir el archivo: ' + upErr.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-cloud-arrow-up"></i> Subir Versión')
    if (bar) bar.classList.remove('show')
    return
  }

  if (fill) fill.style.width = '60%'

  // Register version in DB
  const { error: verErr } = await db.from('document_versions').insert({
    document_id:     _currentDocId,
    version,
    change_summary:  changes || null,
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
    resetBtn(btn, '<i class="fa-solid fa-cloud-arrow-up"></i> Subir Versión')
    return
  }

  if (fill) fill.style.width = '85%'

  // Update document: new version + status → en_revision
  await db.from('documents').update({
    current_version: version,
    status:          'en_revision',
    updated_at:      new Date().toISOString()
  }).eq('id', _currentDocId)

  if (fill) fill.style.width = '100%'

  setTimeout(async () => {
    showToast(`Versión ${version} subida. Documento en revisión.`, 'green')
    closeModal('modal-upload')
    resetBtn(btn, '<i class="fa-solid fa-cloud-arrow-up"></i> Subir Versión')
    clearFile()
    await loadDocuments()
  }, 400)
}

// ── Modal: DETALLE DEL DOCUMENTO ────────────────────────────────
async function openDetail(docId) {
  _currentDocId = docId
  const doc = _allDocs.find(d => d.id === docId)
  if (!doc) return

  // Header
  setText('detail-code-ttl', doc.code)
  setText('detail-name-ttl', doc.name)

  // Info grid
  setText('d-code',      doc.code)
  setText('d-type',      doc.document_types?.name || '—')
  setText('d-version',   `v${doc.current_version || '1'}`)
  setText('d-status',    sLabel(doc.status))
  setText('d-dept',      doc.departments?.name    || '—')
  setText('d-custodian', doc.custodian_position   || '—')
  setText('d-elaborated',doc.elaborated_by        || '—')
  setText('d-reviewed',  doc.reviewed_by          || '—')
  setText('d-elab-date', doc.elaboration_date ? fmtDate(doc.elaboration_date) : '—')
  setText('d-vigencia',  doc.retention_years ? `${doc.retention_years} año(s)` : '—')
  setText('d-desc',      doc.description          || '—')

  // Workflow bar
  renderWorkflow(doc.status)

  // Approval bar
  renderApprovalBar(doc)

  // Upload button visibility
  const canWrite = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)
  const btnUpVer = document.getElementById('btn-upload-ver')
  if (btnUpVer) btnUpVer.style.display = canWrite ? 'inline-flex' : 'none'

  // Version history
  await loadVersions(docId)

  openModal('modal-detail')
}

function renderWorkflow(status) {
  const steps = [
    { key: 'borrador',      label: 'Borrador',      icon: 'fa-pencil' },
    { key: 'en_revision',   label: 'En Revisión',   icon: 'fa-magnifying-glass' },
    { key: 'en_aprobacion', label: 'En Aprobación', icon: 'fa-check-to-slot' },
    { key: 'vigente',       label: 'Vigente',        icon: 'fa-circle-check' },
    { key: 'obsoleto',      label: 'Obsoleto',       icon: 'fa-box-archive' }
  ]
  const order = steps.map(s => s.key)
  const curIdx = order.indexOf(status)

  const html = steps.map((s, i) => {
    const cls   = i < curIdx ? 'done' : i === curIdx ? 'current' : ''
    const arrow = i < steps.length - 1
      ? `<span class="wf-arrow"><i class="fa-solid fa-chevron-right"></i></span>` : ''
    return `<span class="wf-step ${cls}">
      <i class="fa-solid ${s.icon}"></i>${s.label}
    </span>${arrow}`
  }).join('')

  const el = document.getElementById('detail-workflow')
  if (el) el.innerHTML = html
}

function renderApprovalBar(doc) {
  const bar      = document.getElementById('detail-approval-bar')
  if (!bar) return

  const canApprove = ['administrador','responsable_calidad'].includes(_role)
  const canSubmit  = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)

  bar.innerHTML = ''

  if (doc.status === 'borrador' && canSubmit) {
    bar.innerHTML = `
      <div class="approve-bar">
        <p><i class="fa-solid fa-circle-info" style="margin-right:6px"></i>
           Este documento está en borrador. Envíalo a revisión para iniciar el flujo de aprobación.</p>
        <div class="btns">
          <button class="btn-primary" onclick="changeStatus('en_revision')">
            <i class="fa-solid fa-paper-plane"></i> Enviar a Revisión
          </button>
        </div>
      </div>`
  } else if (doc.status === 'en_revision' && canApprove) {
    bar.innerHTML = `
      <div class="approve-bar">
        <p><i class="fa-solid fa-magnifying-glass" style="margin-right:6px"></i>
           Documento en revisión — ¿Listo para aprobar y publicar?</p>
        <div class="btns">
          <button class="btn-secondary"
                  style="color:var(--red);border-color:var(--red)"
                  onclick="changeStatus('borrador')">
            <i class="fa-solid fa-rotate-left"></i> Regresar a Borrador
          </button>
          <button class="btn-primary" onclick="changeStatus('vigente')">
            <i class="fa-solid fa-circle-check"></i> Aprobar y Publicar
          </button>
        </div>
      </div>`
  } else if (doc.status === 'vigente' && canApprove) {
    bar.innerHTML = `
      <div class="approve-bar reject-bar">
        <p><i class="fa-solid fa-circle-check" style="margin-right:6px"></i>
           Documento vigente y publicado en la lista maestra.</p>
        <div class="btns">
          <button class="btn-secondary" style="color:var(--gray);border-color:var(--gray)"
                  onclick="changeStatus('obsoleto')">
            <i class="fa-solid fa-box-archive"></i> Marcar Obsoleto
          </button>
        </div>
      </div>`
  }
}

async function changeStatus(newStatus) {
  if (!_currentDocId) return

  const { error } = await db.from('documents')
    .update({ status: newStatus, updated_at: new Date().toISOString() })
    .eq('id', _currentDocId)

  if (error) { showToast('Error: ' + error.message, 'red'); return }

  const labels = {
    vigente:    'Documento publicado como Vigente ✅',
    en_revision:'Enviado a revisión',
    borrador:   'Regresado a borrador',
    obsoleto:   'Marcado como obsoleto'
  }
  showToast(labels[newStatus] || 'Estado actualizado', 'green')
  closeModal('modal-detail')
  await loadDocuments()
}

// ── Historial de versiones ───────────────────────────────────────
async function loadVersions(docId) {
  const tbody = document.getElementById('versions-tbody')
  if (tbody) tbody.innerHTML =
    `<tr><td colspan="5" style="text-align:center;padding:20px;color:var(--txt3)">
      <i class="fa-solid fa-spinner fa-spin"></i> Cargando…
    </td></tr>`

  const { data } = await db
    .from('document_versions')
    .select('*, profiles:submitted_by(full_name)')
    .eq('document_id', docId)
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
      <td><strong>v${v.version}</strong></td>
      <td>${fmtDate(v.change_date)}</td>
      <td>${esc(v.profiles?.full_name || '—')}</td>
      <td>${esc(v.change_summary || '—')}</td>
      <td class="center">
        ${v.file_path ? `
        <button onclick="downloadFile('${esc(v.file_path)}','${esc(v.file_name || 'documento')}')"
                class="btn-action green" title="Descargar archivo">
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
  a.href     = data.signedUrl
  a.download = fileName
  a.target   = '_blank'
  a.click()
}

// ── Exportar CSV ─────────────────────────────────────────────────
function exportCSV() {
  if (_allDocs.length === 0) { showToast('No hay documentos para exportar.', 'red'); return }

  const rows = [
    ['Código','Nombre','Tipo','Versión','Departamento','Custodio','Estado']
  ]
  _allDocs.forEach(d => rows.push([
    d.code,
    d.name,
    d.document_types?.code_prefix || '',
    d.current_version || '1',
    d.departments?.name || '',
    d.custodian_position || '',
    sLabel(d.status)
  ]))

  const csv  = rows.map(r =>
    r.map(c => `"${String(c).replace(/"/g, '""')}"`).join(',')
  ).join('\n')

  const blob = new Blob(['\ufeff' + csv], { type: 'text/csv;charset=utf-8;' })
  const a    = document.createElement('a')
  a.href     = URL.createObjectURL(blob)
  a.download = `ListaMaestraDocumentos_${new Date().toISOString().split('T')[0]}.csv`
  a.click()
  showToast('CSV exportado correctamente.', 'green')
}

// ── Helpers ───────────────────────────────────────────────────────
function sPill(s) {
  return {
    borrador:'pill-gray', en_revision:'pill-orange', en_aprobacion:'pill-blue',
    vigente:'pill-green', obsoleto:'pill-red'
  }[s] || 'pill-gray'
}

function sLabel(s) {
  return {
    borrador:'Borrador', en_revision:'En Revisión', en_aprobacion:'En Aprobación',
    vigente:'Vigente', obsoleto:'Obsoleto'
  }[s] || s
}

function fmtDate(d) {
  if (!d) return '—'
  return new Date(d + 'T12:00:00').toLocaleDateString('es-MX',
    { day:'2-digit', month:'short', year:'numeric' })
}

function setText(id, val) {
  const el = document.getElementById(id)
  if (el) el.textContent = val ?? '—'
}

function setVal(id, val) {
  const el = document.getElementById(id)
  if (el) el.value = val ?? ''
}

function resetBtn(btn, html) {
  btn.disabled  = false
  btn.innerHTML = html
}

function esc(str) {
  if (!str) return ''
  return String(str)
    .replace(/&/g,'&amp;')
    .replace(/</g,'&lt;')
    .replace(/>/g,'&gt;')
    .replace(/"/g,'&quot;')
}

function showLoading() {
  const tbody = document.getElementById('docs-tbody')
  if (tbody) tbody.innerHTML = `
    <tr><td colspan="8" style="text-align:center;padding:48px;color:var(--txt3)">
      <i class="fa-solid fa-spinner fa-spin" style="font-size:1.5rem"></i>
    </td></tr>`
  const count = document.getElementById('doc-count')
  if (count) count.textContent = 'Cargando documentos…'
}

function showError(msg) {
  const tbody = document.getElementById('docs-tbody')
  if (tbody) tbody.innerHTML = `
    <tr><td colspan="8" class="table-empty">
      <i class="fa-solid fa-circle-exclamation" style="color:var(--red)"></i>
      <strong>Error al cargar</strong>
      ${esc(msg)}
    </td></tr>`
}

function showToast(msg, color = 'green') {
  const old = document.getElementById('sgc-toast')
  if (old) old.remove()

  const bg = color === 'green' ? '#16a34a'
           : color === 'red'   ? '#dc2626'
           : '#2563eb'

  const t = document.createElement('div')
  t.id = 'sgc-toast'
  t.style.cssText = `
    position:fixed;bottom:28px;right:28px;z-index:9999;
    background:${bg};color:#fff;
    padding:13px 22px;border-radius:12px;
    font-size:0.857rem;font-weight:600;font-family:var(--font);
    box-shadow:0 8px 28px rgba(0,0,0,.22);
    max-width:380px;line-height:1.4;`
  t.textContent = msg
  document.body.appendChild(t)
  setTimeout(() => t.remove(), 3800)
}

// ── Arrancar ──────────────────────────────────────────────────────
initDocuments()
