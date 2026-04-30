-- ══════════════════════════════════════════════════════════════════
-- MIGRACIÓN: Revisión por la Dirección — FT-CA-32 Ver 2
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- 1. Agregar columna form_data a management_reviews
ALTER TABLE management_reviews
  ADD COLUMN IF NOT EXISTS form_data JSONB DEFAULT '{}';

-- 2. Actualizar RPC para aceptar p_form_data (parámetro con DEFAULT para no romper llamadas previas)
CREATE OR REPLACE FUNCTION update_management_review(
  p_id                  uuid,
  p_status              text,
  p_location            text,
  p_next_review_date    date,
  p_general_conclusions text,
  p_attendees           jsonb,
  p_inputs              jsonb,
  p_outputs             jsonb,
  p_form_data           jsonb DEFAULT '{}'
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  UPDATE management_reviews SET
    status              = p_status,
    location            = p_location,
    next_review_date    = p_next_review_date,
    general_conclusions = p_general_conclusions,
    attendees           = p_attendees,
    inputs              = p_inputs,
    outputs             = p_outputs,
    form_data           = p_form_data,
    updated_at          = now()
  WHERE id = p_id;
END;
$$;

GRANT EXECUTE ON FUNCTION update_management_review(uuid,text,text,date,text,jsonb,jsonb,jsonb,jsonb)
  TO authenticated;

-- ──────────────────────────────────────────────────────────────────
-- 3. SEED: Revisión RD-2025-001 — 30 de septiembre de 2025
-- ──────────────────────────────────────────────────────────────────
INSERT INTO management_reviews (
  review_number, period, review_date, next_review_date,
  location, status, general_conclusions,
  attendees, inputs, outputs, form_data
)
VALUES (
  'RD-2025-001',
  'Primer Semestre 2025',
  '2025-09-30',
  '2026-03-31',
  'Sala de Juntas, Hospital Santa Margarita GDL',
  'COMPLETADA',
  'La Alta Dirección revisó el desempeño del SGC correspondiente al primer semestre 2025. Se identificaron áreas de mejora en satisfacción del usuario y se comprometieron acciones para el siguiente período. El sistema de gestión se considera adecuado y eficaz para los propósitos del hospital.',

  '[
    {"name":"Dr. Roberto Sánchez Núñez",      "position":"Director General",          "attended":true},
    {"name":"Lic. María Elena Torres Vega",   "position":"Responsable de Calidad",    "attended":true},
    {"name":"Enf. Carmen Ruiz Lozano",        "position":"Jefatura de Enfermería",    "attended":true},
    {"name":"Lic. Adriana Gómez Herrera",     "position":"Jefatura Capital Humano",   "attended":true},
    {"name":"Dr. Luis Alberto Reyes",         "position":"Jefe de Medicina Interna",  "attended":true},
    {"name":"C.P. Jorge Mendoza Fuentes",     "position":"Administración y Finanzas", "attended":false}
  ]'::jsonb,

  '[]'::jsonb,

  '[
    {"id":"out001","type":"MEJORA",    "description":"Implementar encuesta digital de satisfacción en tablets en áreas de hospitalización y urgencias para mejorar tasa de respuesta.", "responsible":"Lic. María Elena Torres Vega","due_date":"2025-12-15","status":"EN_PROCESO"},
    {"id":"out002","type":"RECURSOS",  "description":"Gestionar adquisición de 2 monitores de signos vitales para urgencias y actualización del equipo de esterilización.", "responsible":"C.P. Jorge Mendoza Fuentes","due_date":"2025-11-30","status":"PENDIENTE"},
    {"id":"out003","type":"CAMBIO_SGC","description":"Actualizar el procedimiento PR-CA-05 de Control de Documentos para incluir firma electrónica y flujo de aprobación digital.","responsible":"Lic. María Elena Torres Vega","due_date":"2025-12-31","status":"PENDIENTE"}
  ]'::jsonb,

  '{
    "prev_actions": [
      {"description":"Actualización del Manual de Calidad v4.0",                          "responsible":"Responsable de Calidad","deadline":"2025-03-31","status":"completado"},
      {"description":"Capacitación ISO 9001:2015 a mandos medios (8 horas)",               "responsible":"Capital Humano",         "deadline":"2025-04-30","status":"completado"},
      {"description":"Implementación de seguimiento digital de NCs en sistema SGC-Web",    "responsible":"Responsable de Calidad","deadline":"2025-06-30","status":"completado"},
      {"description":"Revisión y actualización de matriz de riesgos semestral",            "responsible":"Dirección General",      "deadline":"2025-08-31","status":"en_proceso"}
    ],
    "changes_internal":  "Se incorporó nueva Jefatura de Capital Humano en enero 2025. Se actualizó el organigrama institucional. Se renovó contrato con proveedor de equipos médicos. Se inició proyecto de digitalización de expedientes clínicos.",
    "changes_external":  "Actualización de la NOM-004-SSA3-2012 con adenda publicada en febrero 2025. Auditoría de COFEPRIS programada para Q4 2025. Incremento en demanda de servicios de urgencias (+18% vs 2024). Nuevos lineamientos de la Secretaría de Salud Jalisco sobre tiempos de espera.",
    "desemp_3a_results": "Satisfacción global H1 2025: 88.4% (meta institucional ≥ 90%). Total encuestas aplicadas: 312. Principales áreas de insatisfacción: tiempo de espera en urgencias (72% satisfacción) y limpieza de áreas comunes (81%). Quejas formales recibidas: 7, de las cuales 6 fueron resueltas en el período.",
    "desemp_3a_plan":    "1) Implementar triage activo con enfermera coordinadora en urgencias para reducir tiempos de espera. 2) Reforzar supervisión de limpieza con checklist digital cada 2 horas. 3) Incrementar aplicación de encuestas a 400 por semestre. Meta para H2 2025: ≥ 91%.",
    "desemp_3b_results": "Retroalimentación interna: 3 comités reportaron adecuado funcionamiento del SGC. El personal de enfermería señaló necesidad de mayor capacitación en llenado de registros. Retroalimentación externa: proveedor principal calificó comunicación y pago como excelente. COFEPRIS indicó área de mejora en trazabilidad de equipos.",
    "desemp_3b_plan":    "Programa de reforzamiento de registros para personal de enfermería (2 sesiones de 3 horas, Q4 2025). Reunión con COFEPRIS para revisar sistema de trazabilidad de equipos médicos antes de auditoría Q4.",
    "desemp_3c": [
      {"objective":"Satisfacción del usuario ≥ 90%",                  "indicator":"% satisfacción encuestas",        "goal":"≥ 90%", "result":"88.4%",    "compliance":"parcial"},
      {"objective":"Reducir NCs mayores a ≤ 2 por auditoría",         "indicator":"N° NCs mayores en auditoría",     "goal":"≤ 2",   "result":"1",         "compliance":"cumplido"},
      {"objective":"Capacitar al 100% del personal en ISO 9001",      "indicator":"% personal capacitado",           "goal":"100%",  "result":"87%",       "compliance":"parcial"},
      {"objective":"Tiempo de respuesta a quejas ≤ 5 días hábiles",   "indicator":"Días promedio resolución queja",  "goal":"≤ 5",   "result":"3.8 días",  "compliance":"cumplido"},
      {"objective":"Documentos actualizados ≥ 95% del total vigente", "indicator":"% documentos vigentes",           "goal":"≥ 95%", "result":"97.3%",     "compliance":"cumplido"}
    ],
    "desemp_3d": [
      {"area":"Urgencias",    "type":"observacion",  "description":"Registro incompleto en bitácora de ingresos nocturnos (3 de 60 registros revisados).",         "ac_number":"AC-2025-001","status":"cerrado"},
      {"area":"Laboratorio",  "type":"nc_menor",     "description":"Calibración de equipo de hematología con 12 días de retraso respecto al programa.",            "ac_number":"AC-2025-002","status":"cerrado"},
      {"area":"Farmacia",     "type":"nc_menor",     "description":"Tres medicamentos controlados sin registro de doble firma en libro de psicotrópicos.",         "ac_number":"AC-2025-003","status":"en_proceso"},
      {"area":"Enfermería",   "type":"oportunidad",  "description":"Estandarizar verificación de expediente clínico al ingreso para reducir errores de registro.", "ac_number":"",          "status":"abierto"},
      {"area":"Imagenología", "type":"punto_fuerte", "description":"100% de estudios reportados en menos de 2 horas. Tiempo promedio: 47 minutos.",                "ac_number":"",          "status":"cerrado"}
    ],
    "recursos_current":  "Plantilla: 148 empleados (32 médicos, 64 enfermeras/os, 52 administrativos/soporte). Infraestructura: 45 camas al 78% de ocupación. Equipos médicos: 94% en buen estado. SGC-Web implementado y funcionando.",
    "recursos_future":   "Q4 2025: 2 monitores multiparamétricos para urgencias ($320,000 MXN, aprobados). Capacitación ISO 9001 avanzado para mandos medios. Pendiente autorización: 4 equipos de cómputo en admisión.",
    "riesgos_bajo":      "62",
    "riesgos_medio":     "28",
    "riesgos_alto":      "10",
    "riesgos_measures":  "Riesgos altos (10%): sobresaturación en urgencias — protocolo de desvío a hospitales de referencia activado. Riesgos medios (28%): retraso en calibración — alerta automática en SGC con 15 días de anticipación implementada. Riesgos bajos mantienen controles operativos vigentes.",
    "oportunidades":     "1. Digitalización de encuestas de satisfacción para resultados en tiempo real.\n2. Dashboard de indicadores visible en tiempo real para mandos medios.\n3. Programa de reconocimiento al personal con mejor desempeño en calidad.\n4. Explorar certificación de laboratorio clínico (NOM-166).",
    "signatories": [
      {"name":"Dr. Roberto Sánchez Núñez",    "position":"Director General",       "signed":true},
      {"name":"Lic. María Elena Torres Vega", "position":"Responsable de Calidad", "signed":true},
      {"name":"Enf. Carmen Ruiz Lozano",      "position":"Jefatura de Enfermería", "signed":true},
      {"name":"Lic. Adriana Gómez Herrera",   "position":"Jefatura Capital Humano","signed":true}
    ]
  }'::jsonb
)
ON CONFLICT (review_number) DO UPDATE SET
  period              = EXCLUDED.period,
  review_date         = EXCLUDED.review_date,
  next_review_date    = EXCLUDED.next_review_date,
  location            = EXCLUDED.location,
  status              = EXCLUDED.status,
  general_conclusions = EXCLUDED.general_conclusions,
  attendees           = EXCLUDED.attendees,
  outputs             = EXCLUDED.outputs,
  form_data           = EXCLUDED.form_data,
  updated_at          = now();

-- Verificar resultado
SELECT review_number, period, review_date, status,
       jsonb_array_length(attendees)             AS participantes,
       jsonb_array_length(outputs)               AS salidas,
       jsonb_array_length(form_data->'desemp_3c') AS objetivos,
       jsonb_array_length(form_data->'signatories') AS firmantes
FROM management_reviews
ORDER BY review_date DESC;
