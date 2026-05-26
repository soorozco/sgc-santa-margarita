// ─── Control de Documentos — Cláusula 7.5 ─────────────────────

let _user         = null
let _profile      = null
let _role         = null
let _allDocs      = []
let _filteredDocs = []
let _depts        = []
let _types        = []
let _personal     = []
let _currentDocId = null
let _pendingReqs  = new Set() // IDs de docs con solicitud pendiente
let _activeTab    = 'docs'   // 'docs' | 'regs'
let _coverage     = {}       // cobertura FT: { 'FT-XX-01': { count, refs } }

// ── Init ────────────────────────────────────────────────────────
async function initDocuments() {
  const auth = await requireAuth()
  if (!auth) return
  _user    = auth.user
  _profile = auth.profile
  _role    = auth.profile?.roles?.name || 'lector'

  renderUserInfo()
  setCurrentDate()
  await Promise.all([loadDepts(), loadDocTypes(), loadPersonal()])
  populateFilters()
  await loadDocuments()
  setupSearchFilter()
  applyRoleUI()
  loadPendingReqs()   // carga en segundo plano, sin bloquear

  // Mostrar nav de solicitudes solo para admin/responsable
  if (['administrador','responsable_calidad'].includes(_role)) {
    const navSol = document.getElementById('nav-solicitudes')
    if (navSol) navSol.style.display = 'flex'
    db.from('document_deactivation_requests').select('id').eq('status','pending').then(({data}) => {
      const count = data?.length || 0
      const badge = document.getElementById('badge-sol')
      if (badge && count > 0) { badge.textContent = count; badge.style.display = 'inline-flex' }
    })
  }

  // Setup tabs (solo aplica en informacion-documentada.html)
  document.querySelectorAll('.infodoc-tab').forEach(btn => {
    btn.addEventListener('click', () => switchTab(btn.dataset.tab))
  })
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

async function loadPersonal() {
  const { data } = await db.from('personal')
    .select('codigo, nombre, puesto, departamento')
    .eq('activo', true)
    .order('nombre')
  _personal = data || []
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

  // Personal selects (edit & new modals)
  populatePersonalSelects()
}

function populatePersonalSelects() {
  const blankOpt = '<option value="">— Sin asignar —</option>'
  const opts = blankOpt + _personal.map(p =>
    `<option value="${esc(p.nombre)}">${esc(p.nombre)}${p.puesto ? ' — ' + esc(p.puesto) : ''}</option>`
  ).join('')

  ;['edit-elaborated-by','edit-reviewed-by','edit-authorized-by',
    'new-elaborated-by','new-reviewed-by','new-authorized-by'].forEach(id => {
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

function applyRoleUI() {
  const canWrite  = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)
  const canReview = ['administrador','responsable_calidad'].includes(_role)

  const btnNew   = document.getElementById('btn-new-doc')
  const btnClave = document.getElementById('btn-sol-clave')
  if (btnNew)   btnNew.style.display   = canWrite  ? 'inline-flex' : 'none'
  if (btnClave) btnClave.style.display = canWrite  ? 'inline-flex' : 'none'

  if (canReview) loadCodeRequests()
}

function switchTab(tab) {
  _activeTab = tab

  // Mostrar/ocultar panel de solicitudes vs area de documentos
  const solPanel  = document.getElementById('infodoc-panel-solicitudes')
  const docsArea  = document.getElementById('infodoc-docs-area')
  const isSol     = tab === 'solicitudes'
  if (solPanel)  solPanel.style.display  = isSol ? 'block' : 'none'
  if (docsArea)  docsArea.style.display  = isSol ? 'none'  : 'block'
  if (isSol) {
    // Lazy init: solo la primera vez — reutiliza el auth ya cargado
    if (!window._solInited) {
      window._solInited = true
      // Pasar contexto para evitar segunda llamada a requireAuth()
      window._solCtx = { user: _user, profile: _profile, role: _role }
      initSolicitudesTab()
    }
    // Actualizar botones de tab
    document.querySelectorAll('.infodoc-tab').forEach(btn =>
      btn.classList.toggle('active', btn.dataset.tab === tab))
    return  // no continuar con lógica de docs/regs
  }

  // Actualizar botones de tab
  document.querySelectorAll('.infodoc-tab').forEach(btn =>
    btn.classList.toggle('active', btn.dataset.tab === tab))
  // Mostrar/ocultar filtro de tipo (solo Tab 1)
  const fTypeWrap = document.getElementById('f-type-wrap')
  if (fTypeWrap) fTypeWrap.style.display = tab === 'docs' ? '' : 'none'
  // Mostrar/ocultar filtro de retención (solo Tab 2)
  const fRetWrap = document.getElementById('f-ret-wrap')
  if (fRetWrap) fRetWrap.style.display = tab === 'regs' ? '' : 'none'
  // Cambiar label del botón Nuevo
  const btnNew = document.getElementById('btn-new-doc')
  if (btnNew) {
    btnNew.innerHTML = tab === 'regs'
      ? '<i class="fa-solid fa-plus"></i> Nuevo Formato'
      : '<i class="fa-solid fa-plus"></i> Nuevo Documento'
  }
  // Actualizar header de tabla
  const thTipo = document.getElementById('th-tipo')
  const thCustodio = document.getElementById('th-custodio')
  const thRet = document.getElementById('th-ret')
  const thCov = document.getElementById('th-cov')
  if (thTipo) thTipo.style.display = tab === 'docs' ? '' : 'none'
  if (thCustodio) thCustodio.style.display = tab === 'docs' ? '' : 'none'
  if (thRet) thRet.style.display = tab === 'regs' ? '' : 'none'
  if (thCov) thCov.style.display = tab === 'regs' ? '' : 'none'
  // Si cambia a regs y no hay cobertura, cargarla
  if (tab === 'regs' && Object.keys(_coverage).length === 0) loadCoverage()
  applyFilters()
}

// ── Solicitudes de baja pendientes ──────────────────────────────
async function loadPendingReqs() {
  const { data } = await db.from('document_deactivation_requests')
    .select('document_id').eq('status', 'pending')
  _pendingReqs = new Set((data || []).map(r => r.document_id))
  applyFilters()
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
  applyFilters()
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
  const ret    = document.getElementById('f-ret')?.value    || ''

  _filteredDocs = _allDocs.filter(d => {
    const isFT = d.document_types?.code_prefix === 'FT'
    // Filtrado por tab activo
    if (_activeTab === 'docs' && isFT)  return false
    if (_activeTab === 'regs' && !isFT) return false
    const txt = `${d.code} ${d.name} ${d.custodian_position || ''}`.toLowerCase()
    const matchRet = !ret ||
      (ret === 'sin' && d.retention_years == null) ||
      (ret === 'con' && d.retention_years != null)
    return (!q || txt.includes(q))
        && (!dept   || d.department_id    === dept)
        && (!type   || d.document_type_id === type)
        && (!status || d.status           === status)
        && matchRet
  })
  renderTable(_filteredDocs)
}

// ── Stats bar ────────────────────────────────────────────────────
function renderStats(docs) {
  const bar = document.getElementById('stats-bar')
  if (!bar) return

  // Ocultar si no hay docs o no hay filtro activo
  const q      = (document.getElementById('search-input')?.value || '').trim()
  const dept   = document.getElementById('f-dept')?.value   || ''
  const type   = document.getElementById('f-type')?.value   || ''
  const status = document.getElementById('f-status')?.value || ''
  const hasFilter = q || dept || type || status

  if (!hasFilter || docs.length === 0) {
    bar.style.display = 'none'
    return
  }
  bar.style.display = 'flex'

  // Conteo por estado
  const byStatus = {}
  docs.forEach(d => { byStatus[d.status] = (byStatus[d.status] || 0) + 1 })
  const statusLabel = {
    vigente:'Vigente', borrador:'Borrador',
    en_revision:'En revisión', en_aprobacion:'En aprobación', obsoleto:'Obsoleto'
  }
  document.getElementById('stats-status').innerHTML =
    Object.entries(byStatus)
      .sort((a, b) => b[1] - a[1])
      .map(([s, n]) =>
        `<span class="stat-chip stat-chip--${s}">
          ${statusLabel[s] || s} <span class="stat-n">${n}</span>
        </span>`
      ).join('')

  // Conteo por tipo
  const byType = {}
  docs.forEach(d => {
    const prefix = d.document_types?.code_prefix || '?'
    byType[prefix] = (byType[prefix] || 0) + 1
  })
  document.getElementById('stats-type').innerHTML =
    Object.entries(byType)
      .sort((a, b) => b[1] - a[1])
      .map(([t, n]) =>
        `<span class="stat-chip stat-chip--tipo">
          ${t} <span class="stat-n">${n}</span>
        </span>`
      ).join('')
}

// ── Render table ─────────────────────────────────────────────────
function renderTable(docs) {
  const tbody = document.getElementById('docs-tbody')
  const count = document.getElementById('doc-count')
  if (count) count.textContent =
    `${docs.length} ${_activeTab === 'regs' ? 'formato' : 'documento'}${docs.length !== 1 ? 's' : ''}`
  renderStats(docs)
  if (!tbody) return

  if (docs.length === 0) {
    tbody.innerHTML = `
      <tr><td colspan="9" class="table-empty">
        <i class="fa-solid fa-folder-open"></i>
        <strong>Sin ${_activeTab === 'regs' ? 'registros' : 'documentos'}</strong>
        Ningún documento coincide con los filtros seleccionados.
      </td></tr>`
    return
  }

  const canWrite = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)
  const isRegs = _activeTab === 'regs'

  tbody.innerHTML = docs.map(doc => {
    const canRequest = ['administrador','responsable_calidad','jefe_departamento'].includes(_role)
      && doc.status === 'vigente'
      && !_pendingReqs.has(doc.id)
      && (_role === 'administrador' || _profile?.department_id === doc.department_id)

    const retLabel = isRegs
      ? (doc.retention_years != null
          ? `<span class="badge-ret">${doc.retention_years} año${doc.retention_years !== 1 ? 's' : ''}</span>`
          : `<span class="badge-ret badge-ret--sin">Sin definir</span>`)
      : ''

    return `
    <tr>
      <td><span class="doc-code">${doc.code}</span></td>
      <td><span class="doc-name" title="${esc(doc.name)}">${esc(doc.name)}</span></td>
      ${!isRegs ? `<td><span class="doc-type-tag">${doc.document_types?.code_prefix || '—'}</span></td>` : ''}
      <td class="center"><strong>v${doc.current_version || '1'}</strong></td>
      <td>${esc(doc.departments?.name || '—')}</td>
      ${!isRegs ? `<td>${esc(doc.custodian_position || '—')}</td>` : ''}
      ${isRegs ? `<td class="center">${retLabel}</td>` : ''}
      ${isRegs ? `<td class="center">${covBadge(doc.code)}</td>` : ''}
      <td class="center"><span class="pill ${sPill(doc.status)}">${sLabel(doc.status)}</span></td>
      <td class="center">
        ${canRequest
          ? `<button onclick="openSolBaja('${doc.id}')" class="btn-sol-baja">
              <i class="fa-solid fa-arrow-down-to-line"></i> Solicitar baja
             </button>`
          : _pendingReqs.has(doc.id)
            ? `<span class="badge-sol-pending"><i class="fa-solid fa-clock"></i> Pendiente</span>`
            : `<span class="sol-na">—</span>`
        }
      </td>
      <td>
        <div class="action-btns">
          <button onclick="openDetail('${doc.id}')" class="btn-action" title="Ver detalle">
            <i class="fa-solid fa-eye"></i>
          </button>
          ${isRegs
            ? ''
            : `<button onclick="openContent('${doc.id}')" class="btn-action teal" title="Ver contenido digital">
                 <i class="fa-solid fa-book-open"></i>
               </button>`
          }
          ${canWrite
            ? isRegs
              ? `<button onclick="openEdit('${doc.id}')" class="btn-action blue" title="Editar">
                   <i class="fa-solid fa-pencil"></i>
                 </button>`
              : `<button onclick="openEdit('${doc.id}')" class="btn-action blue" title="Editar">
                   <i class="fa-solid fa-pencil"></i>
                 </button>
                 <button onclick="openUpload('${doc.id}')" class="btn-action green" title="Subir versión">
                   <i class="fa-solid fa-upload"></i>
                 </button>`
            : ''}
        </div>
      </td>
    </tr>`
  }).join('')
}

// ── Cobertura FT (cuántos procedimientos referencian cada formato) ──
async function loadCoverage() {
  const { data, error } = await db.rpc('get_ft_coverage')
  _coverage = {}
  if (error || !data) {
    console.warn('loadCoverage:', error)
    _allDocs.filter(d => d.document_types?.code_prefix === 'FT')
            .forEach(d => { _coverage[d.code] = null })
    renderTable(_filteredDocs)
    return
  }
  data.forEach(row => {
    _coverage[row.ft_code] = {
      count: Number(row.ref_count),
      refs:  Array.isArray(row.refs) ? row.refs : []
    }
  })
  renderTable(_filteredDocs)
}

function covBadge(code) {
  const cov = _coverage[code]
  if (cov === undefined) return `<span class="badge-cov badge-cov--loading" title="Calculando…">—</span>`
  if (cov === null)      return `<span class="badge-cov badge-cov--loading" title="No disponible">N/D</span>`
  if (cov.count === 0)   return `<span class="badge-cov badge-cov--none" title="No aparece en ningún PR o IT">Sin ref.</span>`
  const tip = cov.refs.map(r => r.code).join(' · ')
  return `<span class="badge-cov badge-cov--ok" title="${esc(tip)}"><i class="fa-solid fa-check"></i> ${cov.count}</span>`
}

// ── Visor PDF para Registros/Formatos ───────────────────────────
let _pdfDocId = null, _pdfUrl = null, _pdfName = null
let _detailPdfUrl  = null
let _detailPdfName = null

async function openPdfViewer(docId) {
  _pdfDocId = docId
  _pdfUrl   = null
  _pdfName  = null
  const doc = _allDocs.find(d => d.id === docId)
  if (!doc) return

  const ttlCode = document.getElementById('pdf-code-ttl')
  const ttlName = document.getElementById('pdf-name-ttl')
  if (ttlCode) ttlCode.textContent = doc.code
  if (ttlName) ttlName.textContent = doc.name

  const iframe  = document.getElementById('pdf-iframe')
  const loading = document.getElementById('pdf-loading')
  const empty   = document.getElementById('pdf-empty')
  const btnDl   = document.getElementById('btn-pdf-download')
  const btnPr   = document.getElementById('btn-pdf-print')

  if (iframe)  { iframe.src = ''; iframe.style.display = 'none' }
  if (loading) loading.style.display = 'flex'
  if (empty)   empty.style.display   = 'none'
  if (btnDl)   btnDl.style.display   = 'none'
  if (btnPr)   btnPr.style.display   = 'none'

  openModal('modal-pdf')

  const { data: versions } = await db
    .from('document_versions')
    .select('file_path,file_name,version')
    .eq('document_id', docId)
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

  _pdfUrl  = data.signedUrl
  _pdfName = latest.file_name || `${doc.code}_v${latest.version}.pdf`

  if (loading) loading.style.display = 'none'
  if (iframe)  { iframe.src = _pdfUrl; iframe.style.display = 'block' }
  if (btnDl)   btnDl.style.display = 'inline-flex'
  if (btnPr)   btnPr.style.display = 'inline-flex'
}

function downloadPdf() {
  if (!_pdfUrl) return
  const a = document.createElement('a')
  a.href = _pdfUrl; a.download = _pdfName || 'documento.pdf'; a.click()
}

function printPdf() {
  const iframe = document.getElementById('pdf-iframe')
  if (iframe?.contentWindow) iframe.contentWindow.print()
}

function downloadDetailPdf() {
  if (!_detailPdfUrl) return
  const a = document.createElement('a')
  a.href = _detailPdfUrl; a.download = _detailPdfName || 'documento.pdf'; a.click()
}

function printDetailPdf() {
  const iframe = document.getElementById('detail-pdf-iframe')
  if (iframe?.contentWindow) iframe.contentWindow.print()
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

// ── Modal: EDITAR DOCUMENTO ──────────────────────────────────────
function openEdit(docId) {
  _currentDocId = docId
  const doc = _allDocs.find(d => d.id === docId)
  if (!doc) return

  setText('edit-doc-code', doc.code)

  // Poblar selects con las mismas opciones que el modal de nuevo doc
  const deptOpts = _depts.map(d =>
    `<option value="${d.id}" ${d.id === doc.department_id ? 'selected' : ''}>${d.name}</option>`
  ).join('')
  const typeOpts = _types.map(t =>
    `<option value="${t.id}" ${t.id === doc.document_type_id ? 'selected' : ''}>${t.code_prefix} — ${t.name}</option>`
  ).join('')

  const eDept = document.getElementById('edit-dept')
  const eType = document.getElementById('edit-type')
  if (eDept) eDept.innerHTML = `<option value="">— Seleccionar —</option>${deptOpts}`
  if (eType) eType.innerHTML = `<option value="">— Seleccionar —</option>${typeOpts}`

  // Rellenar campos
  setVal('edit-code',         doc.code)
  setVal('edit-name',         doc.name)
  setVal('edit-version',      doc.current_version || '1.0')
  setVal('edit-custodian',    doc.custodian_position || '')
  setVal('edit-vigencia',     doc.retention_years || 2)
  setVal('edit-elab-date',    doc.elaboration_date || '')
  setVal('edit-desc',         doc.description || '')
  setVal('edit-status',       doc.status || 'borrador')

  // Personal selects — re-poblar y seleccionar
  populatePersonalSelects()
  setVal('edit-elaborated-by', doc.elaborated_by  || '')
  setVal('edit-reviewed-by',   doc.reviewed_by    || '')
  setVal('edit-authorized-by', doc.authorized_by  || '')

  // Mostrar cargo al abrir
  const _cargoMap = {
    'edit-elaborated-by': 'edit-elaboro-cargo',
    'edit-reviewed-by':   'edit-reviso-cargo',
    'edit-authorized-by': 'edit-autorizo-cargo'
  }
  Object.entries(_cargoMap).forEach(([selId, cargoId]) => {
    const sel    = document.getElementById(selId)
    const cargoEl= document.getElementById(cargoId)
    if (sel && cargoEl) {
      const person = _personal.find(p => p.nombre === sel.value)
      cargoEl.textContent = person?.puesto || ''
    }
  })

  openModal('modal-edit')
}

async function submitEdit() {
  const btn  = document.getElementById('btn-save-edit')
  const name = document.getElementById('edit-name')?.value.trim()
  const code = document.getElementById('edit-code')?.value.trim().toUpperCase()

  if (!name) { showToast('El nombre del documento es obligatorio.', 'red'); return }
  if (!code) { showToast('El código del documento es obligatorio.', 'red'); return }

  // Verificar código único (excluyendo el documento actual)
  const duplicate = _allDocs.find(d => d.code === code && d.id !== _currentDocId)
  if (duplicate) {
    showToast(`El código "${code}" ya está en uso por otro documento.`, 'red')
    return
  }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const payload = {
    code,
    name,
    document_type_id:  document.getElementById('edit-type')?.value      || null,
    department_id:     document.getElementById('edit-dept')?.value       || null,
    custodian_position:document.getElementById('edit-custodian')?.value.trim() || null,
    current_version:   document.getElementById('edit-version')?.value.trim()   || '1.0',
    status:            document.getElementById('edit-status')?.value     || 'borrador',
    retention_years:   parseInt(document.getElementById('edit-vigencia')?.value) || 2,
    elaboration_date:  document.getElementById('edit-elab-date')?.value  || null,
    elaborated_by:     document.getElementById('edit-elaborated-by')?.value || null,
    reviewed_by:       document.getElementById('edit-reviewed-by')?.value   || null,
    authorized_by:     document.getElementById('edit-authorized-by')?.value || null,
    description:       document.getElementById('edit-desc')?.value.trim() || null,
    updated_at:        new Date().toISOString()
  }

  let { error } = await db.from('documents')
    .update(payload)
    .eq('id', _currentDocId)

  // Si authorized_by no existe aún en la tabla, reintentar sin ese campo
  if (error && (error.message.includes('authorized_by') || error.code === '42703')) {
    const { authorized_by: _, ...payloadFallback } = payload
    const { error: err2 } = await db.from('documents')
      .update(payloadFallback)
      .eq('id', _currentDocId)
    error = err2
  }

  if (error) {
    showToast('Error al guardar: ' + error.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar Cambios')
    return
  }

  showToast(`Documento ${code} actualizado correctamente.`, 'green')
  closeModal('modal-edit')
  resetBtn(btn, '<i class="fa-solid fa-floppy-disk"></i> Guardar Cambios')
  await loadDocuments()
}

// ── Modal: SUBIR VERSIÓN ─────────────────────────────────────────
async function openUpload(docId) {
  _currentDocId = docId
  const doc = _allDocs.find(d => d.id === docId)
  if (!doc) return

  setText('upload-doc-name', `${doc.code} — ${doc.name}`)
  setVal('upload-date', new Date().toISOString().split('T')[0])
  setVal('upload-changes', '')

  // Verificar si ya hay versiones subidas para este documento
  const { data: versions } = await db.from('document_versions')
    .select('id, version').eq('document_id', docId).limit(1)

  const hint = document.getElementById('upload-version-hint')
  const curVer = doc.current_version || '1.0'

  if (!versions || versions.length === 0) {
    // Primera vez — mostrar versión actual para que la confirme o corrija
    setVal('upload-version', curVer)
    if (hint) hint.textContent =
      '⚑ Primera subida. Confirma o corrige la versión real del documento físico.'
  } else {
    // Ya hay versiones — auto-incrementar
    const nextVer = isNaN(Number(curVer))
      ? curVer
      : (Math.floor(Number(curVer)) + 1) + '.0'
    setVal('upload-version', nextVer)
    if (hint) hint.textContent = 'Versión sugerida. Puedes cambiarla si es necesario.'
  }

  clearFile()
  openModal('modal-upload')
}

function openUploadFromDetail() {
  closeModal('modal-detail')
  if (_currentDocId) openUpload(_currentDocId)
}

function openUploadFromEdit() {
  const doc = _allDocs.find(d => d.id === _currentDocId)
  if (!doc) return
  closeModal('modal-edit')
  setText('upload-pdf-doc-name', `${doc.code} — ${doc.name}`)
  clearPdfFile()
  openModal('modal-upload-pdf')
}

// ── Drag & drop del modal simplificado ────────────────────────────
function fileDragOverPdf(e) {
  e.preventDefault()
  document.getElementById('file-drop-pdf')?.classList.add('drag')
}
function fileDragLeavePdf(e) {
  document.getElementById('file-drop-pdf')?.classList.remove('drag')
}
function fileDropPdf(e) {
  e.preventDefault()
  document.getElementById('file-drop-pdf')?.classList.remove('drag')
  const file = e.dataTransfer.files[0]
  if (file) {
    const dt = new DataTransfer()
    dt.items.add(file)
    const inp = document.getElementById('upload-pdf-file')
    if (inp) inp.files = dt.files
    showPdfFileSelected(file)
  }
}
function filePdfSelected(input) {
  const file = input.files[0]
  if (file) showPdfFileSelected(file)
}
function showPdfFileSelected(file) {
  const info = document.getElementById('file-pdf-selected-info')
  if (info) {
    info.classList.add('show')
    const span = document.getElementById('file-pdf-selected-name')
    if (span) span.textContent = file.name
  }
}
function clearPdfFile() {
  const info = document.getElementById('file-pdf-selected-info')
  if (info) info.classList.remove('show')
  const bar  = document.getElementById('upload-pdf-progress')
  const fill = document.getElementById('progress-pdf-fill')
  if (bar)  bar.classList.remove('show')
  if (fill) fill.style.width = '0%'
  const inp  = document.getElementById('upload-pdf-file')
  if (inp)  inp.value = ''
}

async function submitUploadPdf() {
  const btn  = document.getElementById('btn-save-upload-pdf')
  const inp  = document.getElementById('upload-pdf-file')
  const file = inp?.files[0]
  if (!file)          { showToast('Selecciona un archivo PDF.', 'red'); return }
  if (!_currentDocId) return

  const doc     = _allDocs.find(d => d.id === _currentDocId)
  const version = doc?.current_version || '1.0'

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Subiendo…'

  const bar  = document.getElementById('upload-pdf-progress')
  const fill = document.getElementById('progress-pdf-fill')
  if (bar)  bar.classList.add('show')
  if (fill) fill.style.width = '30%'

  const ext      = file.name.split('.').pop().toLowerCase()
  const deptCode = doc?.departments?.code || 'GEN'
  const docCode  = doc?.code  || _currentDocId
  const ts       = Date.now()
  const filePath = `${deptCode}/${docCode}/v${version}_${ts}.${ext}`

  const { error: upErr } = await db.storage
    .from('sgc-documents')
    .upload(filePath, file, { cacheControl: '3600', upsert: false })

  if (upErr) {
    showToast('Error al subir el archivo: ' + upErr.message, 'red')
    resetBtn(btn, '<i class="fa-solid fa-cloud-arrow-up"></i> Subir')
    if (bar) bar.classList.remove('show')
    return
  }
  if (fill) fill.style.width = '70%'

  await db.from('document_versions').insert({
    document_id:     _currentDocId,
    version,
    change_summary:  'PDF cargado',
    change_date:     new Date().toISOString().split('T')[0],
    file_path:       filePath,
    file_name:       file.name,
    file_size_bytes: file.size,
    file_mime_type:  file.type,
    status:          'borrador',
    submitted_by:    _user.id,
    submitted_at:    new Date().toISOString()
  })

  if (fill) fill.style.width = '100%'
  setTimeout(async () => {
    showToast('PDF cargado correctamente.', 'green')
    closeModal('modal-upload-pdf')
    resetBtn(btn, '<i class="fa-solid fa-cloud-arrow-up"></i> Subir')
    clearPdfFile()
    await loadDocuments()
  }, 400)
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
  setText('d-elab-date', doc.elaboration_date ? fmtDate(doc.elaboration_date) : '—')
  setText('d-vigencia',  doc.retention_years ? `${doc.retention_years} año(s)` : '—')
  setText('d-desc',      doc.description          || '—')

  // Elaboró / Revisó / Autorizó con cargo desde personal
  const elaboroPerson   = _personal.find(p => p.nombre === doc.elaborated_by)
  const revisoPerson    = _personal.find(p => p.nombre === doc.reviewed_by)
  const autorizoPerson  = _personal.find(p => p.nombre === doc.authorized_by)
  setText('d-elaborated',       doc.elaborated_by  || '—')
  setText('d-elaborated-cargo', elaboroPerson?.puesto  || '')
  setText('d-reviewed',         doc.reviewed_by    || '—')
  setText('d-reviewed-cargo',   revisoPerson?.puesto   || '')
  setText('d-authorized',       doc.authorized_by  || '—')
  setText('d-authorized-cargo', autorizoPerson?.puesto || '')

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

  // Si es Registros/Formatos (FT), cargar PDF dentro del modal
  const isFT = doc.document_types?.code_prefix === 'FT'
  const pdfSection   = document.getElementById('detail-pdf-section')
  const pdfIframe    = document.getElementById('detail-pdf-iframe')
  const pdfLoading   = document.getElementById('detail-pdf-loading')
  const pdfEmpty     = document.getElementById('detail-pdf-empty')
  const btnDlDetail  = document.getElementById('btn-detail-download')
  const btnPrDetail  = document.getElementById('btn-detail-print')

  _detailPdfUrl  = null
  _detailPdfName = null

  if (pdfSection) pdfSection.style.display = isFT ? 'block' : 'none'
  if (btnDlDetail) btnDlDetail.style.display = 'none'
  if (btnPrDetail) btnPrDetail.style.display = 'none'

  if (isFT) {
    if (pdfIframe)  { pdfIframe.src = ''; pdfIframe.style.display = 'none' }
    if (pdfLoading) pdfLoading.style.display = 'flex'
    if (pdfEmpty)   pdfEmpty.style.display   = 'none'
  }

  openModal('modal-detail')

  // Cargar PDF en segundo plano (solo FT)
  if (isFT) {
    ;(async () => {
      const { data: vers } = await db
        .from('document_versions')
        .select('file_path, file_name, version')
        .eq('document_id', docId)
        .not('file_path', 'is', null)
        .order('created_at', { ascending: false })
        .limit(1)

      if (!vers?.length) {
        if (pdfLoading) pdfLoading.style.display = 'none'
        if (pdfEmpty)   pdfEmpty.style.display   = 'flex'
        return
      }
      const { data: signed } = await db.storage
        .from('sgc-documents')
        .createSignedUrl(vers[0].file_path, 3600)

      if (!signed?.signedUrl) {
        if (pdfLoading) pdfLoading.style.display = 'none'
        if (pdfEmpty)   pdfEmpty.style.display   = 'flex'
        return
      }
      _detailPdfUrl  = signed.signedUrl
      _detailPdfName = vers[0].file_name || `${doc.code}_v${vers[0].version}.pdf`
      if (pdfLoading) pdfLoading.style.display = 'none'
      if (pdfIframe)  { pdfIframe.src = _detailPdfUrl; pdfIframe.style.display = 'block' }
      if (btnDlDetail) btnDlDetail.style.display = 'inline-flex'
      if (btnPrDetail) btnPrDetail.style.display = 'inline-flex'
    })()
  }
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

// ── Modal: CONTENIDO DIGITAL ─────────────────────────────────────
async function openContent(docId) {
  _currentDocId   = docId
  _contentDocId   = docId
  _contentEditMode= false
  _contentData    = null
  _contentId      = null

  const doc = _allDocs.find(d => d.id === docId)
  if (!doc) return

  setText('mc-code', doc.code)
  setText('mc-name', doc.name)

  const mcBody = document.getElementById('mc-body')
  const mcAuth = document.getElementById('mc-auth-strip')
  if (mcBody) mcBody.innerHTML =
    `<p style="text-align:center;padding:48px;color:var(--txt3)">
      <i class="fa-solid fa-spinner fa-spin" style="font-size:1.5rem"></i>
    </p>`
  if (mcAuth) mcAuth.innerHTML = ''

  // Botones del footer — reset
  const canEdit = ['administrador','responsable_calidad'].includes(_role)
  const btnEdit   = document.getElementById('btn-content-edit')
  const btnCancel = document.getElementById('btn-content-cancel')
  const btnSave   = document.getElementById('btn-content-save')
  if (btnEdit)   btnEdit.style.display   = 'none'
  if (btnCancel) btnCancel.style.display = 'none'
  if (btnSave)   btnSave.style.display   = 'none'

  openModal('modal-content')

  const { data, error } = await db
    .from('document_content')
    .select('*')
    .eq('document_id', docId)
    .limit(1)

  if (error || !data || data.length === 0) {
    if (mcBody) mcBody.innerHTML = `
      <div style="text-align:center;padding:64px 20px;color:var(--txt3)">
        <i class="fa-solid fa-book-open" style="font-size:2.8rem;display:block;margin-bottom:16px;color:var(--border)"></i>
        <strong style="display:block;color:var(--txt2);margin-bottom:8px;font-size:1rem">
          Contenido digital no disponible
        </strong>
        Este documento aún no tiene vista digital registrada.<br>
        Consulta la copia física firmada en las carpetas del SGC.
      </div>`
    // Permitir crear contenido desde cero
    if (canEdit && btnEdit) {
      _contentData = {
        objetivo:'', alcance:'', definiciones:[], responsabilidades:[],
        material_equipo:[], desarrollo:[], gestion_riesgos:[],
        referencias:[], control_cambios:[],
        elaborado_por:'', cargo_elaboro:'', revisado_por:'', cargo_reviso:'',
        autorizado_por:'', cargo_autorizo:''
      }
      btnEdit.style.display = 'inline-flex'
    }
    return
  }

  _contentData = data[0]
  _contentId   = data[0].id
  renderContentModal(doc, data[0])
  renderContentAuthStrip(doc, data[0])
  if (canEdit && btnEdit) btnEdit.style.display = 'inline-flex'
}

function renderContentModal(doc, c) {
  const typePrefix = doc.document_types?.code_prefix || ''
  const isIT = typePrefix === 'IT'

  // ── Sections ──────────────────────────────────────────────────
  let html = ''

  // 1 · Objetivo (solo PR)
  if (!isIT && c.objetivo) {
    html += docSection('fa-bullseye', '1. Objetivo',
      `<p>${esc(c.objetivo)}</p>`)
  }

  // Alcance
  if (c.alcance) {
    const n = isIT ? '1' : '2'
    html += docSection('fa-expand', `${n}. Alcance`,
      `<p style="white-space:pre-line">${esc(c.alcance)}</p>`)
  }

  // 3 · Definiciones (solo PR)
  if (!isIT && c.definiciones?.length) {
    const rows = c.definiciones.map(d => `
      <tr>
        <td><strong>${esc(d.termino)}</strong></td>
        <td>${esc(d.definicion)}</td>
      </tr>`).join('')
    html += docSection('fa-book', '3. Definiciones', `
      <table class="doc-table">
        <thead><tr><th>Término</th><th>Definición</th></tr></thead>
        <tbody>${rows}</tbody>
      </table>`)
  }

  // 4 · Responsabilidades (solo PR)
  if (!isIT && c.responsabilidades?.length) {
    const rows = c.responsabilidades.map(r => `
      <tr>
        <td style="white-space:nowrap"><strong>${esc(r.tipo)}</strong></td>
        <td>${esc(r.descripcion)}</td>
      </tr>`).join('')
    html += docSection('fa-users', '4. Responsabilidades', `
      <table class="doc-table">
        <thead><tr><th>Tipo</th><th>Descripción</th></tr></thead>
        <tbody>${rows}</tbody>
      </table>`)
  }

  // 2 · Material y Equipo (solo IT)
  if (isIT && c.material_equipo?.length) {
    const items = c.material_equipo.map(m => `<li>${esc(m.item)}</li>`).join('')
    html += docSection('fa-toolbox', '2. Material y Equipo',
      `<ul class="doc-list">${items}</ul>`)
  }

  // Desarrollo
  if (c.desarrollo?.length) {
    const n = isIT ? '3' : '5'
    const rows = c.desarrollo.map(s => `
      <tr>
        <td class="center doc-step-no">${esc(s.no)}</td>
        <td style="white-space:nowrap"><strong>${esc(s.responsable)}</strong></td>
        <td>${esc(s.actividad)}</td>
      </tr>`).join('')
    html += docSection('fa-list-ol', `${n}. Desarrollo`, `
      <table class="doc-table">
        <thead><tr><th class="center" style="width:46px">No.</th><th>Responsable</th><th>Actividad</th></tr></thead>
        <tbody>${rows}</tbody>
      </table>`)
  }

  // Gestión de Riesgos
  if (c.gestion_riesgos?.length) {
    const n = isIT ? '4' : '6'
    const rows = c.gestion_riesgos.map(r => `
      <tr>
        <td>${esc(r.riesgo)}</td>
        <td>${esc(r.barrera)}</td>
      </tr>`).join('')
    html += docSection('fa-shield-halved', `${n}. Gestión de Riesgos`, `
      <table class="doc-table">
        <thead><tr><th>Riesgo</th><th>Barrera / Control</th></tr></thead>
        <tbody>${rows}</tbody>
      </table>`)
  }

  // Referencias
  if (c.referencias?.length && c.referencias[0]?.nombre !== 'No Aplica') {
    const n = isIT ? '5' : '7'
    const rows = c.referencias.map(r => `
      <tr>
        <td>${esc(r.nombre)}</td>
        <td>${esc(r.codigo)}</td>
      </tr>`).join('')
    html += docSection('fa-link', `${n}. Referencias`, `
      <table class="doc-table">
        <thead><tr><th>Nombre</th><th>Código</th></tr></thead>
        <tbody>${rows}</tbody>
      </table>`)
  }

  // Control de Cambios
  if (c.control_cambios?.length) {
    const n = isIT ? '6' : '8'
    const rows = c.control_cambios.map(cc => `
      <tr>
        <td class="center"><strong>${esc(cc.version)}</strong></td>
        <td style="white-space:nowrap">${esc(cc.fecha)}</td>
        <td>${esc(cc.descripcion)}</td>
        <td>${esc(cc.realizado)}</td>
        <td>${esc(cc.aprobado)}</td>
      </tr>`).join('')
    html += docSection('fa-clock-rotate-left', `${n}. Control de Cambios`, `
      <table class="doc-table">
        <thead><tr>
          <th class="center">Ver.</th>
          <th>Fecha</th>
          <th>Descripción</th>
          <th>Realizó</th>
          <th>Aprobó</th>
        </tr></thead>
        <tbody>${rows}</tbody>
      </table>`)
  }

  const mcBody = document.getElementById('mc-body')
  if (mcBody) mcBody.innerHTML = html ||
    `<p style="text-align:center;padding:40px;color:var(--txt3)">Sin secciones disponibles.</p>`
}

function docSection(icon, title, bodyHtml) {
  return `
    <div class="doc-section">
      <div class="doc-section-hdr">
        <i class="fa-solid ${icon}"></i>
        <span>${title}</span>
      </div>
      <div class="doc-section-body">${bodyHtml}</div>
    </div>`
}

// ── Exportar CSV ─────────────────────────────────────────────────
function exportCSV() {
  const docs = _filteredDocs.length > 0 ? _filteredDocs : _allDocs
  if (docs.length === 0) { showToast('No hay documentos para exportar.', 'red'); return }

  const rows = [
    ['Código','Nombre','Tipo','Versión','Departamento','Custodio','Estado']
  ]
  docs.forEach(d => rows.push([
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

// ── Modal: SOLICITAR BAJA ────────────────────────────────────────
function openSolBaja(id) {
  _currentDocId = id
  const doc = _allDocs.find(d => d.id === id)
  if (!doc) return
  setText('sb-doc-name', doc.name)
  setVal('sb-reason', '')
  openModal('modal-sol-baja')
}

async function submitSolBaja() {
  const reason = document.getElementById('sb-reason')?.value.trim() || null
  if (!reason) { showToast('Escribe el motivo de la solicitud.', 'red'); return }
  const btn = document.getElementById('btn-sb-submit')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Enviando…'
  const { error } = await db.from('document_deactivation_requests').insert({
    document_id:  _currentDocId,
    requested_by: _user.id,
    reason
  })
  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-paper-plane"></i> Enviar Solicitud'
  if (error) { showToast('Error al enviar solicitud.', 'red'); return }
  showToast('Solicitud enviada correctamente.', 'green')
  closeModal('modal-sol-baja')
  _pendingReqs.add(_currentDocId)
  applyFilters()
}

// ── EDICIÓN DE CONTENIDO DIGITAL ────────────────────────────────

let _contentData    = null   // objeto document_content actual
let _contentId      = null   // UUID del registro en document_content
let _contentDocId   = null   // UUID del documento
let _contentEditMode= false

// Activa modo edición en el modal de contenido
function enterContentEditMode() {
  if (!_contentData) return
  _contentEditMode = true
  document.getElementById('btn-content-edit')?.style.setProperty('display','none')
  document.getElementById('btn-content-cancel')?.style.setProperty('display','inline-flex')
  document.getElementById('btn-content-save')?.style.setProperty('display','inline-flex')

  const doc = _allDocs.find(d => d.id === _contentDocId)
  renderContentEditMode(doc, _contentData)
}

// Cancela y vuelve a modo lectura
function exitContentEditMode() {
  _contentEditMode = false
  document.getElementById('btn-content-edit')?.style.setProperty('display','inline-flex')
  document.getElementById('btn-content-cancel')?.style.setProperty('display','none')
  document.getElementById('btn-content-save')?.style.setProperty('display','none')

  const doc = _allDocs.find(d => d.id === _contentDocId)
  if (doc && _contentData) {
    renderContentModal(doc, _contentData)
    renderContentAuthStrip(doc, _contentData)
  }
}

// Render de la franja de autorización en MODO LECTURA
function renderContentAuthStrip(doc, c) {
  const mcAuth = document.getElementById('mc-auth-strip')
  if (!mcAuth) return
  mcAuth.innerHTML = `
    <div class="doc-auth-item">
      <span class="doc-auth-lbl">Versión</span>
      <span class="doc-auth-val">${esc(doc.current_version || '—')}</span>
    </div>
    <div class="doc-auth-item">
      <span class="doc-auth-lbl">Elaboró</span>
      <span class="doc-auth-val">${esc(c.elaborado_por || doc.elaborated_by || '—')}</span>
      <span class="doc-auth-sub">${esc(c.cargo_elaboro || '—')}</span>
    </div>
    <div class="doc-auth-item">
      <span class="doc-auth-lbl">Revisó</span>
      <span class="doc-auth-val">${esc(c.revisado_por || doc.reviewed_by || '—')}</span>
      <span class="doc-auth-sub">${esc(c.cargo_reviso || '—')}</span>
    </div>
    <div class="doc-auth-item">
      <span class="doc-auth-lbl">Autorizó</span>
      <span class="doc-auth-val">${esc(c.autorizado_por || '—')}</span>
      <span class="doc-auth-sub">${esc(c.cargo_autorizo || '—')}</span>
    </div>`
}

// Renderiza el modal en modo edición
function renderContentEditMode(doc, c) {
  const isIT = (doc.document_types?.code_prefix || '') === 'IT'
  const deptId = doc.department_id

  // Franja editable de autorización
  const mcAuth = document.getElementById('mc-auth-strip')
  if (mcAuth) {
    mcAuth.innerHTML = `
      <div class="doc-auth-item">
        <span class="doc-auth-lbl">Versión</span>
        <span class="doc-auth-val">${esc(doc.current_version || '—')}</span>
      </div>
      <div class="doc-auth-item edit-auth-item">
        <span class="doc-auth-lbl">Elaboró</span>
        <input class="edit-auth-input" id="ea-elaborado" value="${esc(c.elaborado_por || '')}" placeholder="Nombre">
        <input class="edit-auth-input edit-auth-sub" id="ea-cargo-elaboro" value="${esc(c.cargo_elaboro || '')}" placeholder="Cargo">
      </div>
      <div class="doc-auth-item edit-auth-item">
        <span class="doc-auth-lbl">Revisó</span>
        <input class="edit-auth-input" id="ea-revisado" value="${esc(c.revisado_por || '')}" placeholder="Nombre">
        <input class="edit-auth-input edit-auth-sub" id="ea-cargo-reviso" value="${esc(c.cargo_reviso || '')}" placeholder="Cargo">
      </div>
      <div class="doc-auth-item edit-auth-item">
        <span class="doc-auth-lbl">Autorizó</span>
        <input class="edit-auth-input" id="ea-autorizado" value="${esc(c.autorizado_por || '')}" placeholder="Nombre">
        <input class="edit-auth-input edit-auth-sub" id="ea-cargo-autorizo" value="${esc(c.cargo_autorizo || '')}" placeholder="Cargo">
      </div>`
  }

  let html = ''

  // 1. Objetivo (solo PR)
  if (!isIT) {
    html += editSection('fa-bullseye', '1. Objetivo',
      `<textarea class="edit-textarea" id="edit-objetivo" rows="3">${esc(c.objetivo || '')}</textarea>`)
  }

  // 2. Alcance
  const nAlcance = isIT ? '1' : '2'
  html += editSection('fa-expand', `${nAlcance}. Alcance`,
    `<textarea class="edit-textarea" id="edit-alcance" rows="5">${esc(c.alcance || '')}</textarea>`)

  // 3. Definiciones (solo PR)
  if (!isIT) {
    html += editSection('fa-book', '3. Definiciones',
      editArrayTable('definiciones', c.definiciones || [],
        [{ key:'termino', label:'Término', width:'30%' }, { key:'definicion', label:'Definición' }]))
  }

  // 4. Responsabilidades (solo PR)
  if (!isIT) {
    html += editSection('fa-users', '4. Responsabilidades',
      editArrayTable('responsabilidades', c.responsabilidades || [],
        [{ key:'tipo', label:'Tipo', width:'25%' }, { key:'descripcion', label:'Descripción' }]))
  }

  // 2. Material y Equipo (solo IT)
  if (isIT) {
    html += editSection('fa-toolbox', '2. Material y Equipo',
      editArrayTable('material_equipo', c.material_equipo || [],
        [{ key:'item', label:'Ítem' }]))
  }

  // Desarrollo
  const nDes = isIT ? '3' : '5'
  html += editSection('fa-list-ol', `${nDes}. Desarrollo`,
    editArrayTable('desarrollo', c.desarrollo || [],
      [{ key:'no', label:'No.', width:'60px' },
       { key:'responsable', label:'Responsable', width:'25%' },
       { key:'actividad', label:'Actividad' }]))

  // Gestión de Riesgos
  const nRiesgos = isIT ? '4' : '6'
  html += editSection('fa-shield-halved', `${nRiesgos}. Gestión de Riesgos`,
    editArrayTable('gestion_riesgos', c.gestion_riesgos || [],
      [{ key:'riesgo', label:'Riesgo' }, { key:'barrera', label:'Barrera / Control' }]))

  // Referencias — con buscador de catálogo del mismo departamento
  const nRef = isIT ? '5' : '7'
  const refsClean = (c.referencias || []).filter(r => r.nombre !== 'No Aplica')
  html += editSection('fa-link', `${nRef}. Referencias`,
    editRefsSection(refsClean, deptId))

  // Control de Cambios
  const nCC = isIT ? '6' : '8'
  html += editSection('fa-clock-rotate-left', `${nCC}. Control de Cambios`,
    editArrayTable('control_cambios', c.control_cambios || [],
      [{ key:'version', label:'Ver.', width:'55px' },
       { key:'fecha', label:'Fecha', width:'90px' },
       { key:'descripcion', label:'Descripción' },
       { key:'realizado', label:'Realizó', width:'18%' },
       { key:'aprobado', label:'Aprobó', width:'18%' }]))

  const mcBody = document.getElementById('mc-body')
  if (mcBody) mcBody.innerHTML = html
}

// Contenedor de sección editable
function editSection(icon, title, bodyHtml) {
  return `
    <div class="doc-section">
      <div class="doc-section-hdr edit-section-hdr">
        <i class="fa-solid ${icon}"></i>
        <span>${title}</span>
      </div>
      <div class="doc-section-body">${bodyHtml}</div>
    </div>`
}

// Tabla editable genérica para arrays JSON
function editArrayTable(fieldName, rows, cols) {
  const thead = cols.map(c =>
    `<th style="${c.width ? 'width:'+c.width : ''}">${c.label}</th>`
  ).join('') + '<th style="width:36px"></th>'

  const tbody = rows.map((row, i) =>
    editArrayRow(fieldName, row, cols, i)
  ).join('')

  return `
    <table class="edit-array-table" id="eat-${fieldName}">
      <thead><tr>${thead}</tr></thead>
      <tbody id="eat-body-${fieldName}">${tbody}</tbody>
    </table>
    <button class="btn-add-row" onclick="addEditRow('${fieldName}')">
      <i class="fa-solid fa-plus"></i> Agregar fila
    </button>`
}

function editArrayRow(fieldName, row, cols, idx) {
  const cells = cols.map(c => {
    const val = esc(row[c.key] || '')
    const isLong = !c.width || c.width === ''
    return `<td>${isLong
      ? `<textarea class="edit-cell-ta" data-field="${c.key}">${val}</textarea>`
      : `<input class="edit-cell-in" data-field="${c.key}" value="${val}">`
    }</td>`
  }).join('')
  return `<tr data-idx="${idx}">
    ${cells}
    <td class="center">
      <button class="btn-del-row" onclick="removeEditRow('${fieldName}', this)" title="Eliminar">
        <i class="fa-solid fa-xmark"></i>
      </button>
    </td>
  </tr>`
}

// Sección especial de Referencias con buscador de catálogo
function editRefsSection(refs, deptId) {
  // Documentos del mismo departamento — excluye únicamente los obsoletos
  // (incluye vigente, borrador, revisión, etc. para no omitir registros en proceso)
  const sameDept = _allDocs
    .filter(d => d.department_id === deptId && d.status !== 'obsoleto')
    .sort((a, b) => {
      // Formatos (FT-*) primero, luego el resto ordenado por código
      const aFT = a.code?.startsWith('FT') ? 0 : 1
      const bFT = b.code?.startsWith('FT') ? 0 : 1
      if (aFT !== bFT) return aFT - bFT
      return (a.code || '').localeCompare(b.code || '')
    })

  const refRows = refs.map((r, i) =>
    `<tr data-idx="${i}">
      <td><input class="edit-cell-in" data-field="nombre" value="${esc(r.nombre || '')}"></td>
      <td><input class="edit-cell-in" data-field="codigo" value="${esc(r.codigo || '')}"></td>
      <td class="center">
        <button class="btn-del-row" onclick="removeEditRow('referencias', this)" title="Eliminar">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </td>
    </tr>`
  ).join('')

  const deptDocs = sameDept.map(d => {
    const isFT = d.code?.startsWith('FT')
    const statusLabel = d.status !== 'vigente'
      ? `<span class="ref-cat-status">${d.status}</span>` : ''
    return `<div class="ref-catalog-item${isFT ? ' ref-catalog-item--ft' : ''}"
         onclick="addRefFromCatalog('${esc(d.code)}','${esc(d.name).replace(/'/g,"\\'")}')">
      <span class="ref-cat-code">${esc(d.code)}</span>
      <span class="ref-cat-name">${esc(d.name)}</span>
      ${statusLabel}
    </div>`
  }).join('') || `<p class="ref-cat-empty">No hay documentos activos en este departamento.</p>`

  const deptName = _depts.find(d => d.id === deptId)?.name || 'este departamento'

  return `
    <table class="edit-array-table" id="eat-referencias">
      <thead><tr><th>Nombre</th><th>Código</th><th style="width:36px"></th></tr></thead>
      <tbody id="eat-body-referencias">${refRows}</tbody>
    </table>
    <button class="btn-add-row" onclick="addEditRow('referencias')">
      <i class="fa-solid fa-plus"></i> Agregar fila vacía
    </button>

    <div class="ref-catalog-wrap">
      <div class="ref-catalog-hdr">
        <i class="fa-solid fa-folder-open"></i>
        Documentos de <strong>${esc(deptName)}</strong>
        <span class="ref-catalog-count">${sameDept.length}</span>
        <input type="text" class="ref-catalog-search" placeholder="Buscar código o nombre…"
               oninput="filterRefCatalog(this.value)">
      </div>
      <div class="ref-catalog-list" id="ref-catalog-list">
        ${deptDocs}
      </div>
    </div>`
}

// Filtro de búsqueda en el catálogo de referencias
function filterRefCatalog(q) {
  const items = document.querySelectorAll('.ref-catalog-item')
  const lq = q.toLowerCase()
  items.forEach(el => {
    const txt = el.textContent.toLowerCase()
    el.style.display = (!lq || txt.includes(lq)) ? '' : 'none'
  })
}

// Agrega un documento del catálogo como referencia
function addRefFromCatalog(code, name) {
  const tbody = document.getElementById('eat-body-referencias')
  if (!tbody) return
  const idx = tbody.querySelectorAll('tr').length
  const tr = document.createElement('tr')
  tr.dataset.idx = idx
  tr.innerHTML = `
    <td><input class="edit-cell-in" data-field="nombre" value="${esc(name)}"></td>
    <td><input class="edit-cell-in" data-field="codigo" value="${esc(code)}"></td>
    <td class="center">
      <button class="btn-del-row" onclick="removeEditRow('referencias', this)" title="Eliminar">
        <i class="fa-solid fa-xmark"></i>
      </button>
    </td>`
  tbody.appendChild(tr)
  showToast(`Referencia "${code}" agregada.`, 'green')
}

// Agrega una fila vacía a cualquier tabla editable
function addEditRow(fieldName) {
  const tbody = document.getElementById(`eat-body-${fieldName}`)
  if (!tbody) return
  const firstRow = tbody.querySelector('tr')
  if (!firstRow && fieldName === 'referencias') {
    // fila vacía para referencias
    const idx = tbody.querySelectorAll('tr').length
    const tr = document.createElement('tr')
    tr.dataset.idx = idx
    tr.innerHTML = `
      <td><input class="edit-cell-in" data-field="nombre" value=""></td>
      <td><input class="edit-cell-in" data-field="codigo" value=""></td>
      <td class="center">
        <button class="btn-del-row" onclick="removeEditRow('referencias', this)" title="Eliminar">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </td>`
    tbody.appendChild(tr)
    return
  }

  // Clonar estructura de la primera fila
  const cols = []
  if (firstRow) {
    firstRow.querySelectorAll('[data-field]').forEach(el => cols.push(el.dataset.field))
  }
  const idx = tbody.querySelectorAll('tr').length
  const tr = document.createElement('tr')
  tr.dataset.idx = idx
  const cells = cols.map(f => {
    const isLong = !['no','version','fecha','tipo','responsable','codigo'].includes(f)
    return `<td>${isLong
      ? `<textarea class="edit-cell-ta" data-field="${f}"></textarea>`
      : `<input class="edit-cell-in" data-field="${f}" value="">`
    }</td>`
  }).join('')
  tr.innerHTML = cells + `<td class="center">
    <button class="btn-del-row" onclick="removeEditRow('${fieldName}', this)" title="Eliminar">
      <i class="fa-solid fa-xmark"></i>
    </button>
  </td>`
  tbody.appendChild(tr)
}

// Elimina una fila de la tabla
function removeEditRow(fieldName, btn) {
  btn.closest('tr').remove()
}

// Lee el estado actual de una tabla editable y devuelve array de objetos
function readEditArray(fieldName) {
  const tbody = document.getElementById(`eat-body-${fieldName}`)
  if (!tbody) return []
  const result = []
  tbody.querySelectorAll('tr').forEach(tr => {
    const obj = {}
    tr.querySelectorAll('[data-field]').forEach(el => {
      obj[el.dataset.field] = el.value.trim()
    })
    // Solo incluir si tiene al menos un campo no vacío
    if (Object.values(obj).some(v => v)) result.push(obj)
  })
  return result
}

// Guarda todos los cambios en document_content
async function saveContentEdits() {
  const btn = document.getElementById('btn-content-save')
  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Guardando…'

  const refsRaw = readEditArray('referencias')
  const refs = refsRaw.length ? refsRaw : [{ nombre:'No Aplica', codigo:'No Aplica' }]

  const doc = _allDocs.find(d => d.id === _contentDocId)
  const isIT = (doc?.document_types?.code_prefix || '') === 'IT'

  const payload = {
    elaborado_por:   document.getElementById('ea-elaborado')?.value.trim()    || null,
    cargo_elaboro:   document.getElementById('ea-cargo-elaboro')?.value.trim()|| null,
    revisado_por:    document.getElementById('ea-revisado')?.value.trim()     || null,
    cargo_reviso:    document.getElementById('ea-cargo-reviso')?.value.trim() || null,
    autorizado_por:  document.getElementById('ea-autorizado')?.value.trim()   || null,
    cargo_autorizo:  document.getElementById('ea-cargo-autorizo')?.value.trim()|| null,
    alcance:         document.getElementById('edit-alcance')?.value.trim()    || null,
    definiciones:    isIT ? [] : readEditArray('definiciones'),
    responsabilidades: isIT ? [] : readEditArray('responsabilidades'),
    material_equipo: isIT ? readEditArray('material_equipo') : [],
    desarrollo:      readEditArray('desarrollo'),
    gestion_riesgos: readEditArray('gestion_riesgos'),
    referencias:     refs,
    control_cambios: readEditArray('control_cambios'),
    updated_at:      new Date().toISOString()
  }
  if (!isIT) payload.objetivo = document.getElementById('edit-objetivo')?.value.trim() || null

  let error
  if (_contentId) {
    ;({ error } = await db.from('document_content').update(payload).eq('id', _contentId))
  } else {
    payload.document_id = _contentDocId
    const { data: ins, error: insErr } = await db.from('document_content').insert(payload).select().single()
    error = insErr
    if (ins) _contentId = ins.id
  }

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar Cambios'

  if (error) { showToast('Error al guardar: ' + error.message, 'red'); return }

  // Actualizar datos locales y volver a modo lectura
  _contentData = { ..._contentData, ...payload }
  showToast('Contenido actualizado correctamente.', 'green')
  exitContentEditMode()
}

// ── SOLICITAR CLAVE NUEVA ────────────────────────────────────────

let _currentClaveReqId = null

function openSolClave() {
  setVal('sc-type', '')
  setVal('sc-dept', '')
  setVal('sc-name', '')
  setVal('sc-justification', '')
  setText('sc-code-preview', '—')

  // Poblar selects
  const blankOpt = '<option value="">— Seleccionar —</option>'
  const scType = document.getElementById('sc-type')
  const scDept = document.getElementById('sc-dept')
  if (scType) scType.innerHTML = blankOpt + _types.map(t =>
    `<option value="${t.id}">${t.code_prefix} — ${t.name}</option>`).join('')
  if (scDept) scDept.innerHTML = blankOpt + _depts.map(d =>
    `<option value="${d.id}">${d.name}</option>`).join('')

  // Pre-seleccionar departamento del usuario si tiene uno
  if (_profile?.department_id && scDept) scDept.value = _profile.department_id

  updateClavePreview()
  openModal('modal-sol-clave')
}

async function updateClavePreview() {
  const typeId = document.getElementById('sc-type')?.value
  const deptId = document.getElementById('sc-dept')?.value
  const preview = document.getElementById('sc-code-preview')
  if (!preview) return

  if (!typeId || !deptId) { preview.textContent = '—'; return }

  const type = _types.find(t => t.id === typeId)
  const dept = _depts.find(d => d.id === deptId)
  if (!type || !dept) return

  // Contar cuántos documentos de este tipo/depto existen para sugerir el siguiente número
  const { count } = await db.from('documents')
    .select('id', { count: 'exact', head: true })
    .like('code', `${type.code_prefix}-${dept.code}-%`)
  const nextNum = String((count ?? 0) + 1).padStart(2, '0')
  preview.textContent = `${type.code_prefix}-${dept.code}-${nextNum}`
}

async function submitSolClave() {
  const btn          = document.getElementById('btn-sc-submit')
  const typeId       = document.getElementById('sc-type')?.value
  const deptId       = document.getElementById('sc-dept')?.value
  const name         = document.getElementById('sc-name')?.value.trim()
  const justification= document.getElementById('sc-justification')?.value.trim()
  const suggestedCode= document.getElementById('sc-code-preview')?.textContent.trim()

  if (!typeId)   { showToast('Selecciona el tipo de documento.', 'red'); return }
  if (!deptId)   { showToast('Selecciona el departamento.', 'red'); return }
  if (!name)     { showToast('Escribe el nombre propuesto.', 'red'); return }
  if (!justification) { showToast('Escribe la justificación.', 'red'); return }

  btn.disabled = true
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Enviando…'

  const { error } = await db.from('document_code_requests').insert({
    requested_by:    _user.id,
    document_type_id:typeId,
    department_id:   deptId,
    suggested_code:  suggestedCode !== '—' ? suggestedCode : null,
    proposed_name:   name,
    justification
  })

  btn.disabled = false
  btn.innerHTML = '<i class="fa-solid fa-paper-plane"></i> Enviar Solicitud'

  if (error) { showToast('Error al enviar solicitud: ' + error.message, 'red'); return }

  showToast('Solicitud enviada. El área de Calidad la revisará pronto.', 'green')
  closeModal('modal-sol-clave')
  if (['administrador','responsable_calidad'].includes(_role)) loadCodeRequests()
}

// ── Panel de solicitudes de clave (admin) ────────────────────────

async function loadCodeRequests() {
  const panel = document.getElementById('clave-requests-panel')
  const list  = document.getElementById('clave-requests-list')
  if (!panel || !list) return

  const { data, error } = await db
    .from('document_code_requests')
    .select(`
      id, suggested_code, proposed_name, justification, created_at,
      document_types(code_prefix, name),
      departments(name),
      requester:requested_by(full_name)
    `)
    .eq('status', 'pending')
    .order('created_at', { ascending: true })

  if (error || !data || data.length === 0) {
    panel.style.display = 'none'
    return
  }

  panel.style.display = 'block'
  const badge = document.getElementById('clave-panel-badge')
  if (badge) badge.textContent = data.length

  list.innerHTML = data.map(r => `
    <div class="clave-req-row">
      <div class="clave-req-info">
        <div>
          <span class="clave-req-code">${esc(r.suggested_code || '—')}</span>
          <span class="clave-req-name">${esc(r.proposed_name)}</span>
        </div>
        <div class="clave-req-meta">
          ${esc(r.document_types?.code_prefix || '—')} ·
          ${esc(r.departments?.name || '—')} ·
          Solicitado por <strong>${esc(r.requester?.full_name || '—')}</strong> ·
          ${fmtDate(r.created_at.split('T')[0])}
        </div>
        ${r.justification ? `<div class="clave-req-meta" style="margin-top:3px;font-style:italic">"${esc(r.justification)}"</div>` : ''}
      </div>
      <button class="btn-review-clave" onclick="openReviewClave('${r.id}')">
        <i class="fa-solid fa-clipboard-check"></i> Revisar
      </button>
    </div>
  `).join('')
}

function openReviewClave(reqId) {
  _currentClaveReqId = reqId
  const list = document.getElementById('clave-requests-list')
  // Encontrar los datos del row en el DOM o re-obtenerlos
  db.from('document_code_requests')
    .select(`
      id, suggested_code, proposed_name, justification,
      document_types(code_prefix, name),
      departments(name),
      requester:requested_by(full_name)
    `)
    .eq('id', reqId)
    .single()
    .then(({ data: r }) => {
      if (!r) return
      const info = document.getElementById('rc-info-box')
      if (info) info.innerHTML = `
        <div class="rc-info-row">
          <span class="rc-info-lbl">Solicitante</span>
          <span class="rc-info-val">${esc(r.requester?.full_name || '—')}</span>
        </div>
        <div class="rc-info-row">
          <span class="rc-info-lbl">Tipo</span>
          <span class="rc-info-val">${esc(r.document_types?.code_prefix || '—')} — ${esc(r.document_types?.name || '—')}</span>
        </div>
        <div class="rc-info-row">
          <span class="rc-info-lbl">Departamento</span>
          <span class="rc-info-val">${esc(r.departments?.name || '—')}</span>
        </div>
        <div class="rc-info-row">
          <span class="rc-info-lbl">Nombre</span>
          <span class="rc-info-val">${esc(r.proposed_name)}</span>
        </div>
        ${r.justification ? `
        <div class="rc-info-row">
          <span class="rc-info-lbl">Justificación</span>
          <span class="rc-info-val" style="font-style:italic">${esc(r.justification)}</span>
        </div>` : ''}
      `
      setText('rc-requester-info', `Código sugerido: ${r.suggested_code || '—'}`)
      setVal('rc-code', r.suggested_code || '')
      setVal('rc-notes', '')
      openModal('modal-review-clave')
    })
}

async function submitReviewClave(action) {
  const btnApprove = document.getElementById('btn-rc-approve')
  const btnReject  = document.getElementById('btn-rc-reject')
  const code       = document.getElementById('rc-code')?.value.trim().toUpperCase()
  const notes      = document.getElementById('rc-notes')?.value.trim()

  if (action === 'approved' && !code) {
    showToast('Escribe el código a asignar antes de aprobar.', 'red'); return
  }
  if (action === 'approved' && _allDocs.find(d => d.code === code)) {
    showToast(`El código "${code}" ya existe en la lista maestra.`, 'red'); return
  }

  btnApprove.disabled = true
  btnReject.disabled  = true
  btnApprove.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i>'

  // Obtener datos completos de la solicitud
  const { data: req } = await db.from('document_code_requests')
    .select('*').eq('id', _currentClaveReqId).single()

  let createdDocId = null

  if (action === 'approved' && req) {
    // Crear el documento en borrador con el código asignado
    const { data: newDoc } = await db.from('documents').insert({
      code:              code,
      name:              req.proposed_name,
      document_type_id:  req.document_type_id || null,
      department_id:     req.department_id    || null,
      current_version:   '1.0',
      status:            'borrador',
      created_by:        _user.id
    }).select().single()
    createdDocId = newDoc?.id || null
  }

  // Actualizar la solicitud
  const { error } = await db.from('document_code_requests').update({
    status:              action,
    assigned_code:       action === 'approved' ? code : null,
    reviewed_by:         _user.id,
    reviewed_at:         new Date().toISOString(),
    review_notes:        notes || null,
    created_document_id: createdDocId,
    updated_at:          new Date().toISOString()
  }).eq('id', _currentClaveReqId)

  btnApprove.disabled = false
  btnReject.disabled  = false
  btnApprove.innerHTML = '<i class="fa-solid fa-check"></i> Aprobar y Crear Documento'

  if (error) { showToast('Error al guardar revisión: ' + error.message, 'red'); return }

  const msg = action === 'approved'
    ? `Clave ${code} asignada. Documento creado en borrador.`
    : 'Solicitud rechazada.'
  showToast(msg, action === 'approved' ? 'green' : 'red')
  closeModal('modal-review-clave')
  await Promise.all([loadCodeRequests(), loadDocuments()])
}

// ── Arrancar ──────────────────────────────────────────────────────
initDocuments()
