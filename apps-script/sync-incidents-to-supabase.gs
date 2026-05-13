// ============================================================
//  Google Apps Script — Sync Incidentes Clínicos → Supabase
//  Hospital Santa Margarita · SGC ISO 9001:2015
//
//  SETUP:
//  1. En Google Sheets → Extensiones → Apps Script → pega este código
//  2. Reemplaza SUPABASE_SERVICE_KEY con tu service_role key
//     (Supabase → Project Settings → API → service_role)
//  3. Guarda y crea el trigger:
//     Apps Script → Triggers (reloj) → + Agregar trigger
//     → onFormSubmit | Del spreadsheet | Al enviar formulario
// ============================================================

const SUPABASE_URL = 'https://tdxkvvmdxnbarjsaknse.supabase.co'
const SUPABASE_KEY = 'PEGA_AQUI_TU_SERVICE_ROLE_KEY'  // ← cambiar

// ── Trigger principal ────────────────────────────────────────
function onFormSubmit(e) {
  try {
    const row  = e.namedValues          // { "Nombre del Paciente ": ["valor"], ... }
    const record = buildRecord(row)
    insertToSupabase(record)
    Logger.log('✓ Incidente enviado a Supabase: ' + JSON.stringify(record))
  } catch (err) {
    Logger.log('✗ Error: ' + err.message)
    // Opcional: enviar alerta por email
    // MailApp.sendEmail('tu@email.com', 'Error sync incidente', err.message)
  }
}

// ── Mapeo de campos del formulario → columnas de Supabase ───
function buildRecord(row) {
  function val(key) {
    const v = row[key]
    if (!v || !v[0] || v[0].trim() === '') return null
    return v[0].trim()
  }

  return {
    reported_at:          formatTimestamp(val('Marca temporal')),
    patient_name:         val('Nombre del Paciente '),   // ojo: espacio al final
    patient_dob:          formatDate(val('Fecha de Nacimiento del Paciente')),
    patient_sex:          val('Sexo del Paciente'),
    incident_date:        formatDate(val('Fecha del Incidente')),
    incident_time:        val('Hora del Incidente'),
    location:             val('Ubicación del Incidente'),
    incident_type:        val('Tipo de Incidente'),
    incident_subtype:     val('Tipo de incidente'),
    damage_level:         val('Resultado para el Paciente (Nivel de Daño)'),
    description:          val('Descripción Libre del Incidente (¿Qué pasó?)'),
    causes:               val('Causas (Análisis inicial, si se conoce)'),
    contributing_factors: val('Factores Contribuyentes (Selecciona todos los que apliquen)'),
    mitigating_factors:   val('Factores Mitigantes (¿Algo evitó que el daño fuera peor?)'),
    immediate_actions:    val('Acciones Inmediatas Tomadas'),
    attachments:          val('Información complementaria (fotografías, documentos, videos)')
  }
}

// ── Insert en Supabase vía REST API ─────────────────────────
function insertToSupabase(record) {
  const url = SUPABASE_URL + '/rest/v1/clinical_incidents'

  const options = {
    method: 'post',
    contentType: 'application/json',
    headers: {
      'apikey':        SUPABASE_KEY,
      'Authorization': 'Bearer ' + SUPABASE_KEY,
      'Prefer':        'return=minimal'
    },
    payload: JSON.stringify(record),
    muteHttpExceptions: true
  }

  const response = UrlFetchApp.fetch(url, options)
  const code     = response.getResponseCode()

  if (code !== 200 && code !== 201) {
    throw new Error('Supabase respondió ' + code + ': ' + response.getContentText())
  }
}

// ── Helpers de fecha ─────────────────────────────────────────
function formatDate(s) {
  // Convierte "d/m/yyyy" → "yyyy-mm-dd"
  if (!s) return null
  const m = s.match(/^(\d{1,2})\/(\d{1,2})\/(\d{4})/)
  if (!m) return null
  const [, d, mo, y] = m
  const yi = parseInt(y)
  if (yi < 1900 || yi > 2100) return null
  return y + '-' + mo.padStart(2,'0') + '-' + d.padStart(2,'0')
}

function formatTimestamp(s) {
  // Convierte "d/m/yyyy h:mm:ss" → ISO 8601
  if (!s) return null
  const m = s.match(/^(\d{1,2})\/(\d{1,2})\/(\d{4})\s+(\d{1,2}):(\d{2}):(\d{2})/)
  if (!m) return null
  const [, d, mo, y, h, mi, sec] = m
  return y + '-' + mo.padStart(2,'0') + '-' + d.padStart(2,'0') +
         'T' + h.padStart(2,'0') + ':' + mi + ':' + sec + '+00:00'
}

// ── Test manual (opcional) ───────────────────────────────────
// Corre esta función una vez para verificar que la conexión funciona
function testConnection() {
  const url = SUPABASE_URL + '/rest/v1/clinical_incidents?select=count'
  const options = {
    method: 'get',
    headers: {
      'apikey':        SUPABASE_KEY,
      'Authorization': 'Bearer ' + SUPABASE_KEY
    },
    muteHttpExceptions: true
  }
  const response = UrlFetchApp.fetch(url, options)
  Logger.log('Respuesta: ' + response.getResponseCode() + ' — ' + response.getContentText())
}
