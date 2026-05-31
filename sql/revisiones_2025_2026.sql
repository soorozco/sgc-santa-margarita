-- ═══════════════════════════════════════════════════════════════
-- Revisiones por la Dirección — ISO 9001:2015 §9.3
-- Hospital Santa Margarita — SGC
-- RD-2025-002 : 19 de diciembre de 2025 (H2 2025)
-- RD-2026-001 : 29 de mayo de 2026 (H1 2026)
--
-- ¿Con qué frecuencia se hacen?
-- ISO 9001:2015 exige al menos UNA por año.
-- En hospitales con certificación activa, la práctica habitual
-- es DOS anuales (semestral). Algunos con seguimiento trimestral
-- hacen 4. Para Hospital Santa Margarita se documenta:
--   RD-2025-001 Sep 30 2025 (ya existente — H1 2025)
--   RD-2025-002 Dic 19 2025 (este archivo   — H2 2025)
--   RD-2026-001 May 29 2026 (este archivo   — H1 2026)
-- Próxima programada: RD-2026-002 Nov 28 2026
--
-- Ejecutar DESPUÉS de: rd_migration_ft_ca32.sql
--                      ac_internas_seed.sql
--                      acciones_correctivas_seed.sql
-- ═══════════════════════════════════════════════════════════════

-- ──────────────────────────────────────────────────────────────
-- RD-2025-002 · Segundo Semestre 2025
-- Fecha: 19 de diciembre de 2025
-- Contexto clave:
--   · Auditoría externa ISO 9001:2015 (nov 2025): NC1-NC3, DV1-DV7
--   · Auditorías internas AI-2025-001 a AI-2025-009 completadas
--   · Dos eventos Graves en noviembre (heparina 10×, px inestable)
--   · Avance en satisfacción: 90.1% (meta ≥ 90%) — objetivo cumplido
-- ──────────────────────────────────────────────────────────────
INSERT INTO management_reviews (
  folio, period, review_date, next_review_date,
  location, status,
  improvement_opportunities, previous_actions_summary,
  internal_external_changes,
  user_satisfaction_results, user_satisfaction_followup,
  stakeholder_internal_results, stakeholder_external_results, stakeholder_followup,
  previous_objectives_summary, audits_corrective_summary,
  resources_current_situation, resources_future_intentions,
  risk_effectiveness_summary, actions_to_take,
  attendees, outputs, form_data
) VALUES (
  'RD-2025-002',
  'Segundo Semestre 2025',
  '2025-12-19',
  '2026-05-31',
  'Sala de Juntas, Hospital Santa Margarita GDL',
  'COMPLETADA',

  -- improvement_opportunities
  'La Alta Dirección revisó el desempeño del SGC del segundo semestre 2025. El período estuvo marcado por la auditoría externa ISO 9001:2015 (noviembre 2025) que identificó 3 No Conformidades y 7 Desviaciones, y por dos eventos adversos graves en el área de hospitalización durante noviembre. Se cumplió por primera vez la meta de satisfacción ≥ 90%. Se aprueba un plan de acción inmediato para protocolos de medicamentos de alto riesgo y comunicación clínica estructurada.',

  -- previous_actions_summary
  '1. Encuesta digital en tablets hospitalización — COMPLETADO (dic 2025): 340 respuestas H2 2025.
2. Adquisición 2 monitores urgencias — COMPLETADO (nov 2025): instalados y operando.
3. Actualización PR-CA-05 con firma electrónica — EN PROCESO (75%): pendiente validación TI.
4. Programa reforzamiento registros enfermería Q4 2025 — COMPLETADO (dic 2025): 2 sesiones, 52 participantes.
5. Reunión COFEPRIS previa a auditoría — COMPLETADO (oct 2025).',

  -- internal_external_changes
  'Cambios internos: Implementación del módulo SGC-Web de Auditorías Internas (jul 2025). Se completaron 9 auditorías internas programadas (áreas: Quirófano ×3, Cocina, Farmacia ×2, Urgencias, Admisión, Imagenología). Se detectaron dos eventos adversos Graves en noviembre vinculados a comunicación médico-enfermería y error de medicación. Alta demanda urgencias +23% vs H1 2025.

Cambios externos: Auditoría de certificación ISO 9001:2015 (nov 2025) — resultado: RECOMENDADA CON OBSERVACIONES. Se mantiene certificación, con 3 NCs y 7 desviaciones a atender. Nuevas disposiciones COFEPRIS sobre trazabilidad de medicamentos controlados (circular nov 2025). Actualización de la NOM-016-SSA3-2012 sobre establecimientos de salud.',

  -- user_satisfaction_results
  'Satisfacción global H2 2025: 90.1% (meta ≥ 90%) — META CUMPLIDA POR PRIMERA VEZ. Total encuestas: 340 (digital 68%, papel 32%). Satisfacción por área: Urgencias 86.3% (↑14 pp vs H1), Hospitalización 91.7%, Quirófano 93.2%, Nutrición 88.4%. Quejas formales: 5 en el período; 5 resueltas. Tiempo promedio de resolución: 2.8 días hábiles.',

  -- user_satisfaction_followup
  '1) Mantener la encuesta digital con envío automático por WhatsApp al alta del paciente (enero 2026).
2) Reforzar área de Urgencias: satisfacción 86.3%, aún por debajo de la meta.
3) Implementar botón de calificación rápida en tabletas de centralización de enfermería.
Meta H1 2026: ≥ 91%.',

  -- stakeholder_internal_results
  'Retroalimentación de auditores internos: Se completaron los 9 procedimientos programados 2025. Personal de farmacia y enfermería señaló la necesidad urgente de protocolos para medicamentos de alto riesgo. Comité de Seguridad del Paciente reportó aumento en la tasa de notificación de eventos adversos (+35% vs 2024) — señal positiva de cultura de seguridad.',

  -- stakeholder_external_results
  'Certificadora BSI: RECOMENDADA CON OBSERVACIONES — certificación mantenida. 3 NCs (gestión de riesgos §6.1, evaluación proveedores §8.4.1, §8.4.3) y 7 desviaciones a cerrar en 90 días. COFEPRIS: sin observaciones en visita de verificación. Proveedor de equipos médicos: entrega de 2 monitores urgencias en tiempo.',

  -- stakeholder_followup
  'Plan de cierre de NCs de auditoría externa (NC1-NC3) antes del 28-Feb-2026.
Plan de cierre de Desviaciones externas (DV1-DV7) antes del 28-Feb-2026.
Presentar avance de acciones a BSI en febrero 2026.',

  -- previous_objectives_summary
  'Satisfacción ≥ 90%: 90.1% — CUMPLIDO ✓
NCs mayores en auditoría interna ≤ 3: 8 NCs mayores — NO CUMPLIDO (acciones en proceso)
Capacitación 100%: 93% — PARCIAL
Tiempo respuesta quejas ≤ 5 días: 2.8 días — CUMPLIDO ✓
Documentos vigentes ≥ 95%: 96.8% — CUMPLIDO ✓
Errores de medicación notificados: 14 eventos H2 2025 — indicador nuevo, sin meta base aún',

  -- audits_corrective_summary
  'AI-2025-001 Quirófano (may): NC-2025-001 y NC-2025-002 — CERRADAS (verificadas ago 2025)
AI-2025-002 Cocina (jul): NC-2025-003 a NC-2025-005 — 2 CERRADAS, 1 EN PROCESO
AI-2025-003 Quirófano seguimiento (ago): NC-2025-006 y NC-2025-007 — EN PROCESO
AI-2025-004 Farmacia (sep): NC-2025-008 a NC-2025-011 — EN PROCESO (prioritarias)
AI-2025-005 Urgencias (oct): NC-2025-012 a NC-2025-014 — EN PROCESO (prioritarias)
AI-2025-006 Admisión (nov): NC-2025-015 a NC-2025-017 — ABIERTAS (recientes)
AI-2025-007 Quirófano (nov): NC-2025-018 y NC-2025-019 — ABIERTAS (recientes)
AI-2025-008 Farmacia (dic): NC-2025-020 a NC-2025-022 — ABIERTAS (recientes)
AI-2025-009 Imagenología (dic): NC-2025-023 y NC-2025-024 — ABIERTAS (recientes)
EXTERNA: NC1 (§6.1), NC2 (§8.4.1), NC3 (§8.4.3): EN PROCESO (40-60% avance)',

  -- resources_current_situation
  'Plantilla: 152 empleados (33 médicos, 67 enfermeras/os, 52 administrativos/soporte). 2 contratos eventuales cubiertos en urgencias. Infraestructura: 45 camas al 84% ocupación (+6 pp vs H1). Nuevos monitores urgencias instalados. SGC-Web módulos activos: Documentos, Auditorías, NCs, Revisión por la Dirección, Eventos Adversos, Indicadores.',

  -- resources_future_intentions
  'Q1 2026: Adquisición baumanómetros pediátricos para todos los pisos ($48,000 — aprobado). Completar PR-CA-05 firma electrónica. Implementar SBAR como registro obligatorio en traslados. Q2 2026: Capacitación externa en gestión de riesgos clínicos (consultor externo). Renovación de contrato proveedor farmacéutico principal.',

  -- risk_effectiveness_summary
  'Bajo: 54%  Medio: 33%  Alto: 13%
Riesgos altos nuevos identificados: (1) Error de medicación de alto riesgo — nivel Alto por eventos de nov 2025; protocolo de doble verificación en implementación. (2) Comunicación deficiente médico-enfermería en traslados — protocolo SBAR aprobado para Q1 2026. Riesgo sobresaturación urgencias: mantenido como Medio; protocolo de desvío operativo.',

  -- actions_to_take
  '1. Implementar protocolo SBAR de entrega de pacientes antes del 31-Ene-2026 (Jefa Admisión)
2. Establecer doble verificación de medicamentos de alto riesgo antes del 15-Dic-2025 (Jefa Farmacia)
3. Verificar cierre de NCs externas (NC1-NC3) antes del 28-Feb-2026 (Responsable Calidad)
4. Instalar baumanómetros pediátricos en 4 pisos antes del 28-Feb-2026 (Administración)
5. Completar PR-CA-05 con firma electrónica antes del 31-Ene-2026 (Responsable Calidad / TI)',

  -- attendees JSONB
  '[
    {"name":"Dr. Roberto Sánchez Núñez",      "position":"Director General",              "attended":true},
    {"name":"Lic. María Elena Torres Vega",   "position":"Responsable de Calidad",        "attended":true},
    {"name":"Enf. Carmen Ruiz Lozano",        "position":"Jefatura de Enfermería",        "attended":true},
    {"name":"Lic. Adriana Gómez Herrera",     "position":"Jefatura Capital Humano",       "attended":true},
    {"name":"Dr. Luis Alberto Reyes",         "position":"Jefe de Medicina Interna",      "attended":true},
    {"name":"Dra. Giselle De la Torre",       "position":"Auditora Líder Interna",        "attended":true},
    {"name":"Farm. Rosario Peña Medina",      "position":"Jefa de Farmacia",              "attended":true},
    {"name":"C.P. Jorge Mendoza Fuentes",     "position":"Administración y Finanzas",     "attended":true},
    {"name":"Dr. Alejandro Vargas",           "position":"Jefe de Urgencias",             "attended":false}
  ]'::jsonb,

  -- outputs JSONB
  '[
    {"id":"out004","type":"MEJORA",    "description":"Implementar Protocolo SBAR (PR-GH-08) para entrega de pacientes en traslados inter-servicios. Registro obligatorio en expediente.","responsible":"Jefa de Admisión / Jefa de Enfermería","due_date":"2026-01-31","status":"COMPLETADO"},
    {"id":"out005","type":"MEJORA",    "description":"Establecer doble verificación documentada para medicamentos de alto riesgo (heparina, insulina, KCl, KPO4) con firma de dos profesionales.","responsible":"Jefa de Farmacia / Jefa de Enfermería","due_date":"2025-12-31","status":"COMPLETADO"},
    {"id":"out006","type":"RECURSOS",  "description":"Adquirir baumanómetros pediátricos para los 4 pisos de hospitalización y la sala de recuperación posquirúrgica.","responsible":"C.P. Jorge Mendoza Fuentes","due_date":"2026-02-28","status":"COMPLETADO"},
    {"id":"out007","type":"CAMBIO_SGC","description":"Cerrar NCs externas NC1, NC2 y NC3 (auditoría BSI) con evidencia documental ante la certificadora antes del 28-Feb-2026.","responsible":"Lic. María Elena Torres Vega","due_date":"2026-02-28","status":"EN_PROCESO"},
    {"id":"out008","type":"MEJORA",    "description":"Publicar lista LASA en todas las áreas de preparación de enfermería y central de cada piso. Capacitación a los 3 turnos.","responsible":"Jefa de Farmacia / Jefa de Enfermería","due_date":"2026-01-31","status":"COMPLETADO"}
  ]'::jsonb,

  -- form_data JSONB (FT-CA-32)
  '{
    "prev_actions": [
      {"description":"Encuesta digital de satisfacción en tablets en hospitalización y urgencias","responsible":"Responsable de Calidad","deadline":"2025-12-15","status":"completado"},
      {"description":"Adquisición 2 monitores de signos vitales para urgencias","responsible":"C.P. Jorge Mendoza Fuentes","deadline":"2025-11-30","status":"completado"},
      {"description":"Actualizar PR-CA-05 Control de Documentos con firma electrónica","responsible":"Responsable de Calidad","deadline":"2025-12-31","status":"en_proceso"},
      {"description":"Programa reforzamiento de registros para enfermería (2 sesiones Q4 2025)","responsible":"Jefa de Enseñanza","deadline":"2025-12-20","status":"completado"},
      {"description":"Reunión con COFEPRIS previa a auditoría para revisar trazabilidad","responsible":"Director General","deadline":"2025-10-31","status":"completado"}
    ],
    "changes_internal":  "Implementación módulo SGC-Web Auditorías Internas (jul 2025). 9 auditorías internas completadas. Dos eventos adversos Graves en noviembre. Alta demanda urgencias +23% H2 vs H1 2025.",
    "changes_external":  "Auditoría certificación ISO 9001:2015 BSI (nov 2025): RECOMENDADA CON OBSERVACIONES — 3 NCs y 7 desviaciones. Circular COFEPRIS trazabilidad medicamentos controlados (nov 2025). Actualización NOM-016-SSA3-2012.",
    "desemp_3a_results": "Satisfacción H2 2025: 90.1% (meta ≥ 90%) — CUMPLIDA. Encuestas: 340. Área menor: Urgencias 86.3%. Quejas: 5, todas resueltas en 2.8 días promedio.",
    "desemp_3a_plan":    "1) WhatsApp automático al alta. 2) Reforzar Urgencias: botón calificación rápida. Meta H1 2026: ≥ 91%.",
    "desemp_3b_results": "Auditores internos: 9 procedimientos completados. Comité Seguridad: +35% reportes eventos adversos. Farmacia y enfermería: necesitan protocolos urgentes.",
    "desemp_3b_plan":    "Plan cierre NCs externas (NC1-NC3) antes 28-Feb-2026. Presentar avance a BSI en feb 2026.",
    "desemp_3c": [
      {"objective":"Satisfacción del usuario ≥ 90%",                  "indicator":"% satisfacción encuestas",       "goal":"≥ 90%","result":"90.1%",    "compliance":"cumplido"},
      {"objective":"NCs mayores internas ≤ 3 por auditoría",          "indicator":"N° NCs mayores en auditorías",   "goal":"≤ 3",  "result":"8",         "compliance":"no_cumplido"},
      {"objective":"Capacitar al 100% del personal en ISO 9001",      "indicator":"% personal capacitado",          "goal":"100%", "result":"93%",       "compliance":"parcial"},
      {"objective":"Tiempo de respuesta a quejas ≤ 5 días hábiles",   "indicator":"Días promedio resolución queja", "goal":"≤ 5",  "result":"2.8 días",  "compliance":"cumplido"},
      {"objective":"Documentos actualizados ≥ 95% del total vigente", "indicator":"% documentos vigentes",          "goal":"≥ 95%","result":"96.8%",     "compliance":"cumplido"},
      {"objective":"Tasa de errores de medicación < 5/mes (nuevo)",   "indicator":"Eventos de medicación/mes",      "goal":"< 5",  "result":"2.3/mes",   "compliance":"cumplido"}
    ],
    "desemp_3d": [
      {"area":"Quirófano",     "type":"nc_menor",   "description":"AI-2025-001: NC-2025-001 y NC-2025-002 CERRADAS (OMS 90%, esterilización 95%). Punto fuerte.","ac_number":"NC-2025-001/002","status":"cerrado"},
      {"area":"Cocina",        "type":"nc_mayor",   "description":"AI-2025-002: NC-2025-003 CERRADA (doble verificación dietas). NC-2025-005 en proceso (evaluación proveedores).","ac_number":"NC-2025-003","status":"cerrado"},
      {"area":"Farmacia",      "type":"nc_mayor",   "description":"AI-2025-004: Múltiples errores LASA y medicación. NC-2025-008 a NC-2025-011 en proceso. PRIORITARIO.","ac_number":"NC-2025-009","status":"en_proceso"},
      {"area":"Urgencias",     "type":"nc_mayor",   "description":"AI-2025-005: 3 caídas (incluida 1 Grave). NC-2025-012 y NC-2025-013 en proceso — capacitaciones completadas.","ac_number":"NC-2025-012/013","status":"en_proceso"},
      {"area":"Admisión",      "type":"nc_mayor",   "description":"AI-2025-006: Heparina 10× (Grave) y px inestable egresado (Grave). NC-2025-015 y NC-2025-016 ABIERTAS — PRIORITARIO.","ac_number":"NC-2025-015/016","status":"abierto"},
      {"area":"Imagenología",  "type":"nc_menor",   "description":"AI-2025-009: ECG sin equipo disponible, retrasos en muestras. NC-2025-023 en proceso.","ac_number":"NC-2025-023","status":"en_proceso"}
    ],
    "recursos_current":  "152 empleados. 45 camas 84% ocupación. 2 monitores nuevos urgencias. SGC-Web activo con 6 módulos operando.",
    "recursos_future":   "Baumanómetros pediátricos (aprobados, $48,000). Consultor externo gestión riesgos clínicos Q2 2026. Renovación contrato farmacéutico principal.",
    "riesgos_bajo":      "54",
    "riesgos_medio":     "33",
    "riesgos_alto":      "13",
    "riesgos_measures":  "Nuevos riesgos Altos: error medicación alto riesgo (protocolo doble verificación en proceso) y comunicación traslados (SBAR aprobado). Sobresaturación urgencias: Medio, protocolo desvío activo.",
    "oportunidades":     "1. Centralizar el registro de eventos adversos al SGC-Web para análisis estadístico mensual.\n2. Implementar dashboards de NCs en tiempo real para jefes de departamento.\n3. Programa de reconocimiento al personal con 0 incidencias por departamento.\n4. Explorar certificación de farmacia clínica en el próximo ciclo.",
    "signatories": [
      {"name":"Dr. Roberto Sánchez Núñez",    "position":"Director General",          "signed":true},
      {"name":"Lic. María Elena Torres Vega", "position":"Responsable de Calidad",    "signed":true},
      {"name":"Enf. Carmen Ruiz Lozano",      "position":"Jefatura de Enfermería",    "signed":true},
      {"name":"Dra. Giselle De la Torre",     "position":"Auditora Líder Interna",    "signed":true},
      {"name":"C.P. Jorge Mendoza Fuentes",   "position":"Administración y Finanzas", "signed":true}
    ]
  }'::jsonb
)
ON CONFLICT (folio) DO UPDATE SET
  period = EXCLUDED.period, review_date = EXCLUDED.review_date,
  next_review_date = EXCLUDED.next_review_date, location = EXCLUDED.location,
  status = EXCLUDED.status,
  improvement_opportunities = EXCLUDED.improvement_opportunities,
  previous_actions_summary = EXCLUDED.previous_actions_summary,
  internal_external_changes = EXCLUDED.internal_external_changes,
  user_satisfaction_results = EXCLUDED.user_satisfaction_results,
  user_satisfaction_followup = EXCLUDED.user_satisfaction_followup,
  stakeholder_internal_results = EXCLUDED.stakeholder_internal_results,
  stakeholder_external_results = EXCLUDED.stakeholder_external_results,
  stakeholder_followup = EXCLUDED.stakeholder_followup,
  previous_objectives_summary = EXCLUDED.previous_objectives_summary,
  audits_corrective_summary = EXCLUDED.audits_corrective_summary,
  resources_current_situation = EXCLUDED.resources_current_situation,
  resources_future_intentions = EXCLUDED.resources_future_intentions,
  risk_effectiveness_summary = EXCLUDED.risk_effectiveness_summary,
  actions_to_take = EXCLUDED.actions_to_take,
  attendees = EXCLUDED.attendees, outputs = EXCLUDED.outputs,
  form_data = EXCLUDED.form_data, updated_at = now();

-- ──────────────────────────────────────────────────────────────
-- RD-2026-001 · Primer Semestre 2026
-- Fecha: 29 de mayo de 2026
-- Contexto clave:
--   · AI-2026-001 a AI-2026-004 completadas (Ene-Abr 2026)
--   · Evento MUERTE en Enfermería (26-Mar-2026) — ventilador
--   · 25 eventos adversos en marzo — nivel sistémico en Enfermería
--   · NCs externas (NC1-NC3): cerradas en feb 2026
--   · Satisfacción H1 2026: 91.3% — meta cumplida
--   · 9 NCs cerradas de las 24 generadas por auditorías internas
-- ──────────────────────────────────────────────────────────────
INSERT INTO management_reviews (
  folio, period, review_date, next_review_date,
  location, status,
  improvement_opportunities, previous_actions_summary,
  internal_external_changes,
  user_satisfaction_results, user_satisfaction_followup,
  stakeholder_internal_results, stakeholder_external_results, stakeholder_followup,
  previous_objectives_summary, audits_corrective_summary,
  resources_current_situation, resources_future_intentions,
  risk_effectiveness_summary, actions_to_take,
  attendees, outputs, form_data
) VALUES (
  'RD-2026-001',
  'Primer Semestre 2026',
  '2026-05-29',
  '2026-11-28',
  'Sala de Juntas, Hospital Santa Margarita GDL',
  'COMPLETADA',

  -- improvement_opportunities
  'La Alta Dirección revisó el desempeño del SGC del primer semestre 2026. El período incluyó 4 auditorías internas programadas y un evento de muerte relacionado con el manejo de ventilación mecánica (26-Mar-2026) que requirió revisión extraordinaria del Comité de Seguridad del Paciente. Se aprueba un plan de fortalecimiento integral de competencias en enfermería para H2 2026. Los indicadores de satisfacción y documentación muestran cumplimiento sostenido. La Dirección instruye la implementación inmediata del protocolo de retiro de soporte vital antes del 15-Jun-2026.',

  -- previous_actions_summary
  '1. Protocolo SBAR (PR-GH-08) — COMPLETADO (28-Ene-2026): adherencia 71% al mes de mayo, en proceso.
2. Doble verificación alto riesgo — COMPLETADO procedimiento; adherencia 89% abr 2026.
3. Baumanómetros pediátricos — COMPLETADO (27-Feb-2026): 6 equipos instalados en 4 pisos.
4. NCs externas NC1, NC2, NC3 (BSI) — CERRADAS (28-Feb-2026): evidencia presentada a certificadora.
5. Lista LASA publicada en todos los pisos — COMPLETADO (nov 2025 farmacia, abr 2026 hospitalización).
6. Escala de Morse para caídas — COMPLETADO (dic 2025): 94% adherencia en may 2026.
7. Protocolo carro rojo (PR-FA-10) — COMPLETADO y CERRADO (NC-2025-013).
8. Aldrete recuperación (PR-AN-04) — COMPLETADO y CERRADO (NC-2025-018): 85% expedientes.
9. Calibración equipos — COMPLETADO y CERRADO (NC-2025-019): 90% equipos con vigencia documentada.',

  -- internal_external_changes
  'Cambios internos: 4 auditorías internas completadas (AI-2026-001 a AI-2026-004). Evento de muerte (26-Mar-2026) investigado por Comité de Seguridad del Paciente y Dirección Médica — circular emitida (DM-2026-03). Primer Semestre 2026 registró 63 eventos adversos notificados en el sistema (vs 48 H1 2025, +31% — interpretado como mayor cultura de reporte). Pico de eventos en marzo 2026: 25 en un mes.

Cambios externos: BSI confirmó cierre de NC1, NC2 y NC3 de auditoría externa — certificación ISO 9001:2015 mantenida sin condiciones. SSJ emitió lineamientos sobre gestión de eventos adversos en hospitales privados (abr 2026). Publicación de NOM-022-SSA3-2012 actualizada sobre catéteres vasculares.',

  -- user_satisfaction_results
  'Satisfacción global H1 2026: 91.3% (meta ≥ 91%) — META CUMPLIDA. Total encuestas: 398 (WhatsApp 54%, digital tablet 31%, papel 15%). Por área: Urgencias 89.1% (↑2.8 pp vs H2 2025), Hospitalización 92.4%, Quirófano 94.1%, Nutrición 90.2% (↑1.8 pp). Quejas formales: 4, 4 resueltas (tiempo promedio 2.2 días). Índice NPS: +42.',

  -- user_satisfaction_followup
  '1) Incrementar respuesta WhatsApp: automatizar recordatorio si no hay respuesta en 24 h post-alta.
2) Urgencias 89.1%: objetivo específico de mejorar comunicación médico-paciente (encuesta indica que es el principal factor de insatisfacción).
3) Iniciar programa de reconocimiento mensual al área con mayor satisfacción.
Meta H2 2026: ≥ 92%.',

  -- stakeholder_internal_results
  'Comité de Seguridad del Paciente: emitió 5 recomendaciones tras investigación del evento de muerte — protocolo soporte vital (en elaboración), definición de roles médico-enfermería, programa capacitación urgente. Auditores internos: señalaron patrones sistémicos en enfermería: omisiones de medicamentos recurrentes, registros incompletos, resistencia a directrices médicas. Jefes de departamento: 6/8 departamentos con indicadores en meta.',

  -- stakeholder_external_results
  'BSI: certificación ISO 9001:2015 MANTENIDA — cierre de NCs externas confirmado. Solicita evidencia de implementación de protocolo soporte vital en próxima visita de supervisión (nov 2026). SSJ: sin observaciones en visita de verificación. Proveedor farmacéutico: renovación de contrato con mejoras en tiempos de entrega de medicamentos de alto riesgo.',

  -- stakeholder_followup
  'Preparar informe de cierre de NCs internas prioritarias para próxima auditoría BSI (nov 2026).
Coordinar con SSJ la presentación del plan de gestión de eventos adversos (jun 2026).
Presentar protocolo PR-DM-01 (soporte vital) a BSI como evidencia de mejora continua §10.3.',

  -- previous_objectives_summary
  'Satisfacción ≥ 91%: 91.3% — CUMPLIDO ✓
NCs mayores internas ≤ 3 por auditoría: 4 NCs mayores en AI-2026-003 (Enfermería) — NO CUMPLIDO
Capacitación 100%: 96% — PARCIAL (pendiente turno nocturno LASA)
Tiempo respuesta quejas ≤ 5 días: 2.2 días — CUMPLIDO ✓
Documentos vigentes ≥ 95%: 97.1% — CUMPLIDO ✓
Errores de medicación < 5/mes: 2.1/mes promedio H1 2026 — CUMPLIDO ✓ (mejora vs 2.3/mes H2 2025)
NCs internas cerradas: 9 de 24 generadas (37.5%) — indicador nuevo, meta H2: ≥ 60%',

  -- audits_corrective_summary
  'AI-2026-001 Admisión (ene): KCl/KPO4 Moderado, transfusión paciente equivocado. NC-2026-001/002 en proceso.
AI-2026-002 Urgencias (feb): Avance 60-70% en NCs oct 2025. NC-2025-012/013/014 CERRADAS. Nuevas NC-2026-004/005 abiertas.
AI-2026-003 Enfermería (mar — CRÍTICA): Resultado MUERTE, 25 eventos adversos, colpaso hemodinámico 2×, LASA. NC-2026-006 a NC-2026-010 abiertas y en proceso prioritario.
AI-2026-004 Quirófano (abr): NC-2025-018/019 CERRADAS. Obstáculo enfermería para paciente crítica. NC-2026-011 a NC-2026-013 abiertas.
NCs CERRADAS acumuladas (de 24 generadas): NC-2025-001/002/003/004/012/013/014/018/019 = 9 cerradas (37.5%).',

  -- resources_current_situation
  'Plantilla: 154 empleados (34 médicos, 68 enfermeras/os, 52 administrativos/soporte). Infraestructura: 45 camas al 87% ocupación (récord). Equipos: calibración al día. SGC-Web: 7 módulos activos, 63 eventos adversos registrados H1 2026, 9 NCs cerradas, plan de capacitación en seguimiento.',

  -- resources_future_intentions
  'H2 2026: Contratar consultor externo en seguridad del paciente para programa de capacitación de enfermería (presupuesto aprobado $85,000). Renovar software de administración de medicamentos con módulo de doble verificación digital. Adquirir carros de medicación con compartimentos con llave para medicamentos de alto riesgo. Auditoría externa de seguimiento BSI: nov 2026.',

  -- risk_effectiveness_summary
  'Bajo: 49%  Medio: 35%  Alto: 16%
Riesgo ALTO nuevo: competencias de enfermería insuficientes (patrón sistémico detectado en 4 auditorías consecutivas) — plan de capacitación intensivo aprobado hoy. Riesgo ALTO mantenido: comunicación médico-enfermería en traslados (SBAR 71% — pendiente alcanzar 95%). Riesgo sobresaturación urgencias: elevado a Alto por 87% ocupación — se activa protocolo de gestión de camas.',

  -- actions_to_take
  '1. URGENTE — Emitir PR-DM-01 (Protocolo Retiro Soporte Vital) antes del 15-Jun-2026 (Dirección Médica)
2. Contratar consultor externo seguridad del paciente — programa capacitación enfermería H2 2026 (Dirección General, jun 2026)
3. Alcanzar adherencia SBAR ≥ 90% antes de la próxima auditoría (Jefa Admisión, ago 2026)
4. Cerrar NC-2026-007 y NC-2026-008 (LASA hospitalización, etiquetado vías IV) antes del 30-Sep-2026
5. Definir y publicar PR-DM-02 (Roles médico-enfermería en procedimientos) antes del 30-Jun-2026 (Dirección Médica)',

  -- attendees JSONB
  '[
    {"name":"Dr. Roberto Sánchez Núñez",      "position":"Director General",              "attended":true},
    {"name":"Lic. María Elena Torres Vega",   "position":"Responsable de Calidad",        "attended":true},
    {"name":"Enf. Carmen Ruiz Lozano",        "position":"Jefatura de Enfermería",        "attended":true},
    {"name":"Lic. Adriana Gómez Herrera",     "position":"Jefatura Capital Humano",       "attended":true},
    {"name":"Dr. Luis Alberto Reyes",         "position":"Jefe de Medicina Interna",      "attended":true},
    {"name":"Dra. Giselle De la Torre",       "position":"Auditora Líder Interna",        "attended":true},
    {"name":"Farm. Rosario Peña Medina",      "position":"Jefa de Farmacia",              "attended":true},
    {"name":"Dr. Alejandro Vargas",           "position":"Jefe de Urgencias",             "attended":true},
    {"name":"Dr. Ernesto Figueroa Solís",     "position":"Jefe de Anestesiología",        "attended":true},
    {"name":"C.P. Jorge Mendoza Fuentes",     "position":"Administración y Finanzas",     "attended":false}
  ]'::jsonb,

  -- outputs JSONB
  '[
    {"id":"out009","type":"MEJORA",    "description":"Emitir PR-DM-01 (Protocolo de Retiro de Soporte Vital) con doble verificación médica y documentación obligatoria antes del 15-Jun-2026.","responsible":"Dirección Médica / Responsable de Calidad","due_date":"2026-06-15","status":"EN_PROCESO"},
    {"id":"out010","type":"RECURSOS",  "description":"Contratar consultor externo en seguridad del paciente para programa intensivo de capacitación de enfermería H2 2026 ($85,000 MXN aprobados).","responsible":"C.P. Jorge Mendoza Fuentes / Jefa de Enseñanza","due_date":"2026-06-30","status":"EN_PROCESO"},
    {"id":"out011","type":"CAMBIO_SGC","description":"Definir y publicar PR-DM-02 (Delimitación de Roles Médico-Enfermería en Procedimientos Invasivos) antes del 30-Jun-2026.","responsible":"Dirección Médica / Jefa de Enfermería","due_date":"2026-06-30","status":"PENDIENTE"},
    {"id":"out012","type":"RECURSOS",  "description":"Adquirir carros de medicación con compartimento con llave para medicamentos de alto riesgo en los 4 pisos de hospitalización.","responsible":"C.P. Jorge Mendoza Fuentes","due_date":"2026-09-30","status":"PENDIENTE"},
    {"id":"out013","type":"MEJORA",    "description":"Alcanzar adherencia ≥ 90% al protocolo SBAR en todos los traslados inter-servicios antes de la auditoría de Admisión de agosto 2026.","responsible":"Jefa de Admisión","due_date":"2026-08-31","status":"PENDIENTE"}
  ]'::jsonb,

  -- form_data JSONB (FT-CA-32)
  '{
    "prev_actions": [
      {"description":"Protocolo SBAR PR-GH-08 — implementado, adherencia 71%","responsible":"Jefa de Admisión","deadline":"2026-01-31","status":"en_proceso"},
      {"description":"Doble verificación medicamentos alto riesgo PR-EN-07 v3.0","responsible":"Jefa de Farmacia / Enfermería","deadline":"2025-12-31","status":"completado"},
      {"description":"Baumanómetros pediátricos instalados en 4 pisos","responsible":"C.P. Mendoza","deadline":"2026-02-28","status":"completado"},
      {"description":"NCs externas NC1/NC2/NC3 cerradas ante BSI","responsible":"Responsable de Calidad","deadline":"2026-02-28","status":"completado"},
      {"description":"Lista LASA publicada hospitalización + farmacia","responsible":"Jefa Farmacia","deadline":"2026-04-30","status":"completado"},
      {"description":"Escala Morse caídas — 94% adherencia","responsible":"Jefa de Enfermería","deadline":"2025-12-15","status":"completado"},
      {"description":"Protocolo carro rojo PR-FA-10 — CERRADO","responsible":"Jefa de Farmacia","deadline":"2025-12-15","status":"completado"},
      {"description":"Aldrete recuperación PR-AN-04 — 85% expedientes","responsible":"Jefe de Anestesiología","deadline":"2026-02-28","status":"completado"},
      {"description":"Calibración equipos masiva — 90% con vigencia","responsible":"Mantenimiento Biomédico","deadline":"2026-02-28","status":"completado"}
    ],
    "changes_internal":  "4 auditorías internas AI-2026-001 a AI-2026-004. Evento muerte 26-Mar-2026 (AI-2026-003 Enfermería). 63 eventos adversos notificados H1 2026 (+31% cultura reporte). Pico 25 eventos marzo 2026.",
    "changes_external":  "BSI confirma cierre NCs externas — certificación mantenida sin condiciones. SSJ lineamientos gestión eventos adversos (abr 2026). NOM-022-SSA3-2012 actualizada (catéteres vasculares).",
    "desemp_3a_results": "Satisfacción H1 2026: 91.3% (meta ≥ 91%) — CUMPLIDA. Encuestas: 398. Urgencias 89.1%. Quejas: 4, resueltas 2.2 días promedio. NPS: +42.",
    "desemp_3a_plan":    "1) Recordatorio WhatsApp 24h post-alta. 2) Programa reconocimiento mensual área mayor satisfacción. Meta H2 2026: ≥ 92%.",
    "desemp_3b_results": "Comité Seguridad: 5 recomendaciones evento muerte. Auditores: patrón sistémico enfermería — omisiones y resistencia. 6/8 dptos en meta.",
    "desemp_3b_plan":    "Informe cierre NCs para BSI nov 2026. Coordinación SSJ plan eventos adversos jun 2026. PR-DM-01 como evidencia mejora continua §10.3.",
    "desemp_3c": [
      {"objective":"Satisfacción del usuario ≥ 91%",                  "indicator":"% satisfacción encuestas",       "goal":"≥ 91%", "result":"91.3%",    "compliance":"cumplido"},
      {"objective":"NCs mayores internas ≤ 3 por auditoría",          "indicator":"N° NCs mayores por auditoría",   "goal":"≤ 3",   "result":"4 (AI-003)","compliance":"no_cumplido"},
      {"objective":"Capacitar al 96% del personal (meta ajustada)",   "indicator":"% personal capacitado",          "goal":"96%",   "result":"96%",       "compliance":"cumplido"},
      {"objective":"Tiempo de respuesta a quejas ≤ 5 días hábiles",   "indicator":"Días promedio resolución queja", "goal":"≤ 5",   "result":"2.2 días",  "compliance":"cumplido"},
      {"objective":"Documentos actualizados ≥ 95% del total vigente", "indicator":"% documentos vigentes",          "goal":"≥ 95%", "result":"97.1%",     "compliance":"cumplido"},
      {"objective":"Tasa de errores de medicación < 5/mes",           "indicator":"Eventos de medicación/mes",      "goal":"< 5",   "result":"2.1/mes",   "compliance":"cumplido"},
      {"objective":"NCs internas cerradas ≥ 60% acumulado",           "indicator":"% NCs internas cerradas",        "goal":"≥ 60%", "result":"37.5%",     "compliance":"no_cumplido"}
    ],
    "desemp_3d": [
      {"area":"Admisión",      "type":"nc_mayor",   "description":"AI-2026-001: KCl/KPO4 Moderado, transfusión px incorrecto. NC-2026-001/002 en proceso. Electrolitos etiquetados.","ac_number":"NC-2026-001/002","status":"en_proceso"},
      {"area":"Urgencias",     "type":"nc_menor",   "description":"AI-2026-002: NC-2025-012/013/014 CERRADAS. Nuevas NC-2026-004/005 por registro de alergias y SBAR.","ac_number":"NC-2026-004/005","status":"abierto"},
      {"area":"Enfermería",    "type":"nc_mayor",   "description":"AI-2026-003 CRÍTICA: muerte ventilador, colapso IV ×2, LASA. NC-2026-006 a NC-2026-010 — PRIORITARIO. Plan capacitación aprobado.","ac_number":"NC-2026-006","status":"abierto"},
      {"area":"Quirófano",     "type":"nc_mayor",   "description":"AI-2026-004: NC-2025-018/019 CERRADAS (Aldrete, calibración). NC-2026-011 a NC-2026-013 nuevas (acceso salas, CVC, roles).","ac_number":"NC-2026-011","status":"abierto"},
      {"area":"Farmacia",      "type":"punto_fuerte","description":"Doble verificación alto riesgo: 89% cumplimiento sostenido. Sin nuevos eventos graves desde dic 2025.","ac_number":"","status":"cerrado"},
      {"area":"Imagenología",  "type":"nc_menor",   "description":"NC-2025-023 en proceso: programa mantenimiento preventivo implementado. Plan contingencia en revisión.","ac_number":"NC-2025-023","status":"en_proceso"}
    ],
    "recursos_current":  "154 empleados. 45 camas 87% ocupación. 9 NCs cerradas de 24. SGC-Web 7 módulos. 63 eventos adversos H1 2026 registrados.",
    "recursos_future":   "Consultor seguridad paciente $85,000 (aprobado). Carros medicación con llave alto riesgo. Módulo doble verificación digital. Auditoría BSI nov 2026.",
    "riesgos_bajo":      "49",
    "riesgos_medio":     "35",
    "riesgos_alto":      "16",
    "riesgos_measures":  "ALTO nuevo: competencias enfermería — plan capacitación intensivo aprobado. ALTO: comunicación traslados (SBAR 71%). Sobresaturación urgencias elevada a Alto: 87% ocupación — protocolo gestión camas activado.",
    "oportunidades":     "1. Software doble verificación digital integrado al sistema de medicamentos.\n2. Dashboard en tiempo real de NCs por área visible para jefes de departamento.\n3. Programa de certificación individual de competencias en enfermería (badge digital).\n4. Publicar métricas de seguridad del paciente en el portal de transparencia del hospital.",
    "signatories": [
      {"name":"Dr. Roberto Sánchez Núñez",    "position":"Director General",          "signed":true},
      {"name":"Lic. María Elena Torres Vega", "position":"Responsable de Calidad",    "signed":true},
      {"name":"Enf. Carmen Ruiz Lozano",      "position":"Jefatura de Enfermería",    "signed":true},
      {"name":"Dra. Giselle De la Torre",     "position":"Auditora Líder Interna",    "signed":true},
      {"name":"Dr. Ernesto Figueroa Solís",   "position":"Jefe de Anestesiología",    "signed":true},
      {"name":"Lic. Adriana Gómez Herrera",   "position":"Jefatura Capital Humano",   "signed":true}
    ]
  }'::jsonb
)
ON CONFLICT (folio) DO UPDATE SET
  period = EXCLUDED.period, review_date = EXCLUDED.review_date,
  next_review_date = EXCLUDED.next_review_date, location = EXCLUDED.location,
  status = EXCLUDED.status,
  improvement_opportunities = EXCLUDED.improvement_opportunities,
  previous_actions_summary = EXCLUDED.previous_actions_summary,
  internal_external_changes = EXCLUDED.internal_external_changes,
  user_satisfaction_results = EXCLUDED.user_satisfaction_results,
  user_satisfaction_followup = EXCLUDED.user_satisfaction_followup,
  stakeholder_internal_results = EXCLUDED.stakeholder_internal_results,
  stakeholder_external_results = EXCLUDED.stakeholder_external_results,
  stakeholder_followup = EXCLUDED.stakeholder_followup,
  previous_objectives_summary = EXCLUDED.previous_objectives_summary,
  audits_corrective_summary = EXCLUDED.audits_corrective_summary,
  resources_current_situation = EXCLUDED.resources_current_situation,
  resources_future_intentions = EXCLUDED.resources_future_intentions,
  risk_effectiveness_summary = EXCLUDED.risk_effectiveness_summary,
  actions_to_take = EXCLUDED.actions_to_take,
  attendees = EXCLUDED.attendees, outputs = EXCLUDED.outputs,
  form_data = EXCLUDED.form_data, updated_at = now();

-- ── Verificar resultados ──────────────────────────────────────
SELECT folio, period, review_date, status,
       jsonb_array_length(attendees)                AS participantes,
       jsonb_array_length(outputs)                  AS salidas,
       jsonb_array_length(form_data->'desemp_3c')   AS objetivos_calidad,
       jsonb_array_length(form_data->'signatories') AS firmantes
FROM management_reviews
ORDER BY review_date;
