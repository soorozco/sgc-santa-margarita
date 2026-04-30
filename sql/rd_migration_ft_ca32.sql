-- ══════════════════════════════════════════════════════════════════
-- MIGRACIÓN: Revisión por la Dirección — FT-CA-32 Ver 2
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── 1. Agregar columnas que faltan ────────────────────────────────
ALTER TABLE management_reviews
  ADD COLUMN IF NOT EXISTS location         TEXT    DEFAULT 'Sala de Juntas, Hospital Santa Margarita',
  ADD COLUMN IF NOT EXISTS next_review_date DATE,
  ADD COLUMN IF NOT EXISTS attendees        JSONB   DEFAULT '[]',
  ADD COLUMN IF NOT EXISTS outputs          JSONB   DEFAULT '[]',
  ADD COLUMN IF NOT EXISTS form_data        JSONB   DEFAULT '{}';

-- ── 2. RPC: Crear nueva revisión ──────────────────────────────────
CREATE OR REPLACE FUNCTION create_management_review(
  p_review_number     text,
  p_period            text,
  p_review_date       date,
  p_next_review_date  date    DEFAULT NULL,
  p_location          text    DEFAULT 'Sala de Juntas, Hospital Santa Margarita',
  p_created_by        uuid    DEFAULT NULL
)
RETURNS uuid
LANGUAGE plpgsql SECURITY DEFINER
AS $$
DECLARE v_id uuid;
BEGIN
  INSERT INTO management_reviews (
    folio, period, review_date, next_review_date, location,
    status, prepared_by, attendees, outputs, form_data
  ) VALUES (
    p_review_number, p_period, p_review_date, p_next_review_date, p_location,
    'PLANIFICADA', p_created_by, '[]', '[]', '{}'
  ) RETURNING id INTO v_id;
  RETURN v_id;
END;
$$;
GRANT EXECUTE ON FUNCTION create_management_review(text,text,date,date,text,uuid) TO authenticated;

-- ── 3. RPC: Actualizar revisión (sincroniza JSONB + columnas planas) ──
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
LANGUAGE plpgsql SECURITY DEFINER
AS $$
BEGIN
  UPDATE management_reviews SET
    status                      = p_status,
    location                    = p_location,
    next_review_date            = p_next_review_date,
    improvement_opportunities   = p_general_conclusions,
    attendees                   = p_attendees,
    outputs                     = p_outputs,
    form_data                   = p_form_data,
    -- Sincronizar columnas planas desde form_data
    internal_external_changes   = CONCAT(
                                    'Cambios internos: ', COALESCE(p_form_data->>'changes_internal',''),
                                    E'\n\nCambios externos: ', COALESCE(p_form_data->>'changes_external','')
                                  ),
    user_satisfaction_results   = COALESCE(p_form_data->>'desemp_3a_results', ''),
    user_satisfaction_followup  = COALESCE(p_form_data->>'desemp_3a_plan',    ''),
    stakeholder_internal_results= COALESCE(p_form_data->>'desemp_3b_results', ''),
    stakeholder_followup        = COALESCE(p_form_data->>'desemp_3b_plan',    ''),
    resources_current_situation = COALESCE(p_form_data->>'recursos_current',  ''),
    resources_future_intentions = COALESCE(p_form_data->>'recursos_future',   ''),
    risk_effectiveness_summary  = CONCAT(
                                    'Bajo: ',  COALESCE(p_form_data->>'riesgos_bajo',''),  '%  ',
                                    'Medio: ', COALESCE(p_form_data->>'riesgos_medio',''), '%  ',
                                    'Alto: ',  COALESCE(p_form_data->>'riesgos_alto',''),  '%',
                                    E'\n', COALESCE(p_form_data->>'riesgos_measures','')
                                  ),
    actions_to_take             = p_general_conclusions,
    updated_at                  = now()
  WHERE id = p_id;
END;
$$;
GRANT EXECUTE ON FUNCTION update_management_review(uuid,text,text,date,text,jsonb,jsonb,jsonb,jsonb) TO authenticated;

-- ── 4. SEED: RD-2025-001 — 30 de septiembre de 2025 ──────────────
INSERT INTO management_reviews (
  folio,          period,                 review_date,   next_review_date,
  location,       status,
  improvement_opportunities,
  previous_actions_summary,
  internal_external_changes,
  user_satisfaction_results,   user_satisfaction_followup,
  stakeholder_internal_results, stakeholder_external_results, stakeholder_followup,
  previous_objectives_summary,
  audits_corrective_summary,
  resources_current_situation, resources_future_intentions,
  risk_effectiveness_summary,
  actions_to_take,
  attendees,  outputs,  form_data
)
VALUES (
  'RD-2025-001',
  'Primer Semestre 2025',
  '2025-09-30',
  '2026-03-31',
  'Sala de Juntas, Hospital Santa Margarita GDL',
  'COMPLETADA',

  -- improvement_opportunities (conclusiones generales)
  'La Alta Dirección revisó el desempeño del SGC correspondiente al primer semestre 2025. Se identificaron áreas de mejora en satisfacción del usuario y se comprometieron acciones para el siguiente período. El sistema de gestión se considera adecuado y eficaz para los propósitos del hospital.',

  -- previous_actions_summary
  '1. Actualización del Manual de Calidad v4.0 — COMPLETADO (mar 2025)
2. Capacitación ISO 9001:2015 a mandos medios (8 horas) — COMPLETADO (abr 2025)
3. Implementación SGC-Web para seguimiento de NCs — COMPLETADO (jun 2025)
4. Actualización matriz de riesgos semestral — EN PROCESO (ago 2025)',

  -- internal_external_changes
  'Cambios internos: Se incorporó nueva Jefatura de Capital Humano (ene 2025). Actualización de organigrama institucional. Renovación de contrato con proveedor de equipos médicos. Inicio de proyecto de digitalización de expedientes clínicos.

Cambios externos: Actualización NOM-004-SSA3-2012 (feb 2025). Auditoría COFEPRIS programada Q4 2025. Incremento demanda urgencias +18% vs 2024. Nuevos lineamientos SSJ sobre tiempos de espera.',

  -- user_satisfaction_results
  'Satisfacción global H1 2025: 88.4% (meta ≥ 90%). Total encuestas: 312. Áreas de insatisfacción: tiempo de espera urgencias (72%) y limpieza áreas comunes (81%). Quejas formales: 7, de las cuales 6 fueron resueltas en el período.',

  -- user_satisfaction_followup
  '1) Triage activo con enfermera coordinadora en urgencias para reducir tiempos.
2) Supervisión de limpieza con checklist digital cada 2 horas.
3) Incrementar encuestas a 400 por semestre.
Meta H2 2025: ≥ 91%.',

  -- stakeholder_internal_results
  'Retroalimentación interna: 3 comités reportaron adecuado funcionamiento del SGC. Personal de enfermería señaló necesidad de mayor capacitación en llenado de registros.',

  -- stakeholder_external_results
  'Proveedor principal calificó comunicación y pago como excelente. COFEPRIS indicó área de mejora en trazabilidad de equipos médicos.',

  -- stakeholder_followup
  'Programa de reforzamiento de registros para enfermería (2 sesiones Q4 2025). Reunión con COFEPRIS antes de auditoría Q4 para revisar trazabilidad.',

  -- previous_objectives_summary
  'Satisfacción ≥ 90%: 88.4% — PARCIAL
NCs mayores ≤ 2: 1 NC mayor — CUMPLIDO
Capacitación 100%: 87% — PARCIAL
Tiempo respuesta quejas ≤ 5 días: 3.8 días — CUMPLIDO
Documentos vigentes ≥ 95%: 97.3% — CUMPLIDO',

  -- audits_corrective_summary
  'Urgencias (Observación): Registro incompleto bitácora ingresos nocturnos → AC-2025-001 CERRADO
Laboratorio (NC Menor): Calibración hematología con 12 días de retraso → AC-2025-002 CERRADO
Farmacia (NC Menor): Medicamentos controlados sin doble firma → AC-2025-003 EN PROCESO
Enfermería (Oportunidad): Estandarizar verificación expediente al ingreso → Abierto
Imagenología (Punto Fuerte): 100% estudios en < 2 horas, promedio 47 min.',

  -- resources_current_situation
  'Plantilla: 148 empleados (32 médicos, 64 enfermeras/os, 52 administrativos/soporte). Infraestructura: 45 camas al 78% ocupación. Equipos médicos: 94% en buen estado. SGC-Web implementado y en operación.',

  -- resources_future_intentions
  'Q4 2025: 2 monitores multiparamétricos urgencias ($320,000 MXN — aprobados). Capacitación ISO 9001 avanzado mandos medios. Pendiente autorización: 4 equipos cómputo en admisión.',

  -- risk_effectiveness_summary
  'Bajo: 62%  Medio: 28%  Alto: 10%
Riesgos altos: sobresaturación urgencias — protocolo desvío hospitales de referencia activado.
Riesgos medios: retraso calibración equipos — alerta automática SGC con 15 días anticipación.',

  -- actions_to_take
  '1. Implementar encuesta digital en tablets (Calidad, dic 2025)
2. Adquirir 2 monitores urgencias (Administración, nov 2025)
3. Actualizar PR-CA-05 con firma electrónica (Calidad, dic 2025)',

  -- attendees JSONB
  '[
    {"name":"Dr. Roberto Sánchez Núñez",      "position":"Director General",          "attended":true},
    {"name":"Lic. María Elena Torres Vega",   "position":"Responsable de Calidad",    "attended":true},
    {"name":"Enf. Carmen Ruiz Lozano",        "position":"Jefatura de Enfermería",    "attended":true},
    {"name":"Lic. Adriana Gómez Herrera",     "position":"Jefatura Capital Humano",   "attended":true},
    {"name":"Dr. Luis Alberto Reyes",         "position":"Jefe de Medicina Interna",  "attended":true},
    {"name":"C.P. Jorge Mendoza Fuentes",     "position":"Administración y Finanzas", "attended":false}
  ]'::jsonb,

  -- outputs JSONB
  '[
    {"id":"out001","type":"MEJORA",    "description":"Implementar encuesta digital de satisfacción en tablets en hospitalización y urgencias.","responsible":"Lic. María Elena Torres Vega","due_date":"2025-12-15","status":"EN_PROCESO"},
    {"id":"out002","type":"RECURSOS",  "description":"Adquisición de 2 monitores de signos vitales para urgencias y actualización equipo de esterilización.","responsible":"C.P. Jorge Mendoza Fuentes","due_date":"2025-11-30","status":"PENDIENTE"},
    {"id":"out003","type":"CAMBIO_SGC","description":"Actualizar PR-CA-05 Control de Documentos para incluir firma electrónica y flujo digital.","responsible":"Lic. María Elena Torres Vega","due_date":"2025-12-31","status":"PENDIENTE"}
  ]'::jsonb,

  -- form_data JSONB (FT-CA-32 estructurado — tablas dinámicas)
  '{
    "prev_actions": [
      {"description":"Actualización del Manual de Calidad v4.0",                    "responsible":"Responsable de Calidad","deadline":"2025-03-31","status":"completado"},
      {"description":"Capacitación ISO 9001:2015 a mandos medios (8 horas)",         "responsible":"Capital Humano",         "deadline":"2025-04-30","status":"completado"},
      {"description":"Implementación seguimiento digital de NCs en SGC-Web",         "responsible":"Responsable de Calidad","deadline":"2025-06-30","status":"completado"},
      {"description":"Revisión y actualización de matriz de riesgos semestral",      "responsible":"Dirección General",      "deadline":"2025-08-31","status":"en_proceso"}
    ],
    "changes_internal":  "Se incorporó nueva Jefatura de Capital Humano (ene 2025). Actualización organigrama. Renovación contrato proveedor equipos médicos. Inicio digitalización expedientes clínicos.",
    "changes_external":  "Actualización NOM-004-SSA3-2012 (feb 2025). Auditoría COFEPRIS Q4 2025. Incremento demanda urgencias +18% vs 2024. Nuevos lineamientos SSJ tiempos de espera.",
    "desemp_3a_results": "Satisfacción global H1 2025: 88.4% (meta ≥ 90%). Encuestas: 312. Insatisfacción: tiempo espera urgencias (72%) y limpieza (81%). Quejas: 7, 6 resueltas.",
    "desemp_3a_plan":    "1) Triage activo en urgencias. 2) Checklist limpieza digital c/2 hrs. 3) Meta H2 2025: ≥ 91%.",
    "desemp_3b_results": "3 comités con adecuado funcionamiento del SGC. Enfermería requiere capacitación en registros.",
    "desemp_3b_plan":    "2 sesiones reforzamiento registros para enfermería (Q4 2025). Reunión COFEPRIS antes auditoría.",
    "desemp_3c": [
      {"objective":"Satisfacción del usuario ≥ 90%",                  "indicator":"% satisfacción encuestas",       "goal":"≥ 90%","result":"88.4%",   "compliance":"parcial"},
      {"objective":"Reducir NCs mayores a ≤ 2 por auditoría",         "indicator":"N° NCs mayores en auditoría",    "goal":"≤ 2",  "result":"1",        "compliance":"cumplido"},
      {"objective":"Capacitar al 100% del personal en ISO 9001",      "indicator":"% personal capacitado",          "goal":"100%", "result":"87%",      "compliance":"parcial"},
      {"objective":"Tiempo de respuesta a quejas ≤ 5 días hábiles",   "indicator":"Días promedio resolución queja", "goal":"≤ 5",  "result":"3.8 días", "compliance":"cumplido"},
      {"objective":"Documentos actualizados ≥ 95% del total vigente", "indicator":"% documentos vigentes",          "goal":"≥ 95%","result":"97.3%",    "compliance":"cumplido"}
    ],
    "desemp_3d": [
      {"area":"Urgencias",    "type":"observacion",  "description":"Registro incompleto en bitácora de ingresos nocturnos (3/60 registros).", "ac_number":"AC-2025-001","status":"cerrado"},
      {"area":"Laboratorio",  "type":"nc_menor",     "description":"Calibración hematología con 12 días de retraso al programa.",            "ac_number":"AC-2025-002","status":"cerrado"},
      {"area":"Farmacia",     "type":"nc_menor",     "description":"Tres medicamentos controlados sin doble firma en psicotrópicos.",         "ac_number":"AC-2025-003","status":"en_proceso"},
      {"area":"Enfermería",   "type":"oportunidad",  "description":"Estandarizar verificación expediente al ingreso para reducir errores.",  "ac_number":"",           "status":"abierto"},
      {"area":"Imagenología", "type":"punto_fuerte", "description":"100% estudios en < 2 horas. Promedio: 47 minutos.",                      "ac_number":"",           "status":"cerrado"}
    ],
    "recursos_current":  "148 empleados. 45 camas al 78% ocupación. Equipos 94% buen estado. SGC-Web operando.",
    "recursos_future":   "2 monitores urgencias $320,000 (aprobados). ISO avanzado mandos medios. 4 equipos cómputo admisión (pendiente).",
    "riesgos_bajo":      "62",
    "riesgos_medio":     "28",
    "riesgos_alto":      "10",
    "riesgos_measures":  "Altos: protocolo desvío hospitales referencia activo. Medios: alerta calibración automática 15 días anticipación.",
    "oportunidades":     "1. Digitalización encuestas para resultados en tiempo real.\n2. Dashboard indicadores visible para mandos medios.\n3. Programa reconocimiento personal con mejor desempeño.\n4. Explorar certificación laboratorio (NOM-166).",
    "signatories": [
      {"name":"Dr. Roberto Sánchez Núñez",    "position":"Director General",       "signed":true},
      {"name":"Lic. María Elena Torres Vega", "position":"Responsable de Calidad", "signed":true},
      {"name":"Enf. Carmen Ruiz Lozano",      "position":"Jefatura de Enfermería", "signed":true},
      {"name":"Lic. Adriana Gómez Herrera",   "position":"Jefatura Capital Humano","signed":true}
    ]
  }'::jsonb
)
ON CONFLICT (folio) DO UPDATE SET
  period                      = EXCLUDED.period,
  review_date                 = EXCLUDED.review_date,
  next_review_date            = EXCLUDED.next_review_date,
  location                    = EXCLUDED.location,
  status                      = EXCLUDED.status,
  improvement_opportunities   = EXCLUDED.improvement_opportunities,
  previous_actions_summary    = EXCLUDED.previous_actions_summary,
  internal_external_changes   = EXCLUDED.internal_external_changes,
  user_satisfaction_results   = EXCLUDED.user_satisfaction_results,
  user_satisfaction_followup  = EXCLUDED.user_satisfaction_followup,
  stakeholder_internal_results= EXCLUDED.stakeholder_internal_results,
  stakeholder_external_results= EXCLUDED.stakeholder_external_results,
  stakeholder_followup        = EXCLUDED.stakeholder_followup,
  previous_objectives_summary = EXCLUDED.previous_objectives_summary,
  audits_corrective_summary   = EXCLUDED.audits_corrective_summary,
  resources_current_situation = EXCLUDED.resources_current_situation,
  resources_future_intentions = EXCLUDED.resources_future_intentions,
  risk_effectiveness_summary  = EXCLUDED.risk_effectiveness_summary,
  actions_to_take             = EXCLUDED.actions_to_take,
  attendees                   = EXCLUDED.attendees,
  outputs                     = EXCLUDED.outputs,
  form_data                   = EXCLUDED.form_data,
  updated_at                  = now();

-- ── Verificar resultado ───────────────────────────────────────────
SELECT folio, period, review_date, status, location,
       jsonb_array_length(attendees)              AS participantes,
       jsonb_array_length(outputs)                AS salidas,
       jsonb_array_length(form_data->'desemp_3c') AS objetivos,
       jsonb_array_length(form_data->'signatories') AS firmantes
FROM management_reviews
ORDER BY review_date DESC;
