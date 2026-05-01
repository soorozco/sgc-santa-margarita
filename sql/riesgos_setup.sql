-- ══════════════════════════════════════════════════════════════════
-- MÓDULO: Gestión de Riesgos y Oportunidades — Cláusula 6.1
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── 1. Tabla de procesos con riesgos JSONB ────────────────────────
CREATE TABLE IF NOT EXISTS risk_processes (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name         text        NOT NULL,
  process_type text        NOT NULL DEFAULT 'misional',
  process_owner text,
  description  text,
  risks        jsonb       NOT NULL DEFAULT '[]',
  sort_order   int         NOT NULL DEFAULT 0,
  active       boolean     NOT NULL DEFAULT true,
  created_at   timestamptz NOT NULL DEFAULT now(),
  updated_at   timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE risk_processes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated read" ON risk_processes FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated write" ON risk_processes FOR ALL TO authenticated USING (true);

GRANT SELECT, INSERT, UPDATE ON TABLE risk_processes TO authenticated;

-- ── 2. RPC: guardar riesgos de un proceso ─────────────────────────
CREATE OR REPLACE FUNCTION save_process_risks(p_data jsonb)
RETURNS void
LANGUAGE plpgsql SECURITY DEFINER
AS $$
BEGIN
  UPDATE risk_processes SET
    process_owner = COALESCE(p_data->>'process_owner', process_owner),
    description   = COALESCE(p_data->>'description',   description),
    risks         = COALESCE(p_data->'risks',           risks),
    updated_at    = now()
  WHERE id = (p_data->>'id')::uuid;
END;
$$;
GRANT EXECUTE ON FUNCTION save_process_risks(jsonb) TO authenticated;

-- ── 3. Seed: 15 procesos con riesgos pre-cargados ────────────────
-- (Ajusta nombres, responsables y riesgos según tu realidad)

INSERT INTO risk_processes (name, process_type, process_owner, description, sort_order, risks) VALUES

-- ─── ESTRATÉGICOS ───────────────────────────────────────────────
('Dirección y Planificación Estratégica', 'estrategico', 'Director General', 'Definición de la política, objetivos y estrategia institucional del hospital.', 1,
'[
  {"id":"r01","type":"riesgo","description":"Objetivos estratégicos no alineados con la capacidad operativa del hospital","cause":"Falta de análisis de contexto periódico","effect":"Incumplimiento de metas, desviación del rumbo institucional","probability":2,"impact":5,"action_plan":"Revisión semestral de objetivos con la dirección y mandos medios. Validar con análisis FODA actualizado.","responsible":"Director General","due_date":"2025-12-31","status":"en_control"},
  {"id":"r02","type":"riesgo","description":"Cambios regulatorios no incorporados oportunamente a la planeación","cause":"Ausencia de monitoreo de normativas de salud (SSJ, COFEPRIS, NOM)","effect":"Incumplimiento normativo, sanciones","probability":3,"impact":4,"action_plan":"Designar responsable de vigilancia normativa. Revisar boletines SSJ y COFEPRIS mensualmente.","responsible":"Responsable de Calidad","due_date":"2025-11-30","status":"identificado"},
  {"id":"r03","type":"oportunidad","description":"Alianzas con instituciones académicas para fortalecer competencias del personal","cause":"Proximidad a universidades y centros de salud en GDL","effect":"Mejora del nivel técnico del personal y atractivo institucional","probability":3,"impact":3,"action_plan":"Explorar convenios de residencias médicas y servicio social con UDG e ITESO.","responsible":"Jefatura Capital Humano","due_date":"2026-03-31","status":"identificado"}
]'),

('Gestión del Sistema de Calidad', 'estrategico', 'Responsable de Calidad', 'Mantenimiento, mejora y auditoría del SGC conforme a ISO 9001:2015.', 2,
'[
  {"id":"r04","type":"riesgo","description":"No conformidades recurrentes sin análisis de causa raíz efectivo","cause":"Herramientas de análisis insuficientes o falta de seguimiento","effect":"Acumulación de NCs, riesgo de pérdida de certificación","probability":3,"impact":5,"action_plan":"Implementar metodología 8D o Ishikawa en todas las NCs. Seguimiento mensual en comité de calidad.","responsible":"Responsable de Calidad","due_date":"2025-11-30","status":"en_control"},
  {"id":"r05","type":"riesgo","description":"Resistencia del personal al SGC y a los cambios derivados de auditorías","cause":"Falta de cultura de calidad, comunicación insuficiente","effect":"Baja efectividad del SGC, datos no confiables","probability":3,"impact":3,"action_plan":"Programa de sensibilización trimestral. Publicar resultados positivos del SGC internamente.","responsible":"Responsable de Calidad","due_date":"2025-12-31","status":"en_control"},
  {"id":"r06","type":"oportunidad","description":"Digitalización del SGC para seguimiento en tiempo real de indicadores y NCs","cause":"Implementación del sistema SGC-Web","effect":"Mayor visibilidad y control del desempeño del sistema","probability":5,"impact":4,"action_plan":"Continuar desarrollo del SGC-Web. Capacitar a todos los responsables de proceso.","responsible":"Responsable de Calidad","due_date":"2025-12-31","status":"en_control"}
]'),

-- ─── MISIONALES ─────────────────────────────────────────────────
('Admisión y Registro de Pacientes', 'misional', 'Jefe de Admisión', 'Recepción, registro y asignación de pacientes a los servicios hospitalarios.', 3,
'[
  {"id":"r07","type":"riesgo","description":"Errores en el registro de datos del paciente (nombre, CURP, cobertura)","cause":"Procesos manuales, falta de verificación cruzada","effect":"Retrasos en atención, problemas de facturación, riesgos de seguridad del paciente","probability":3,"impact":4,"action_plan":"Implementar doble verificación de datos en admisión. Capacitar al personal en captura correcta.","responsible":"Jefe de Admisión","due_date":"2025-11-30","status":"en_control"},
  {"id":"r08","type":"riesgo","description":"Tiempos de espera en admisión superiores a 20 minutos","cause":"Picos de demanda sin personal de refuerzo, procesos lentos","effect":"Insatisfacción del paciente, impacto en indicadores de calidad","probability":4,"impact":3,"action_plan":"Análisis de flujo de admisión. Priorizar admisión digital y pre-registro.","responsible":"Jefe de Admisión","due_date":"2025-12-31","status":"identificado"}
]'),

('Consulta Externa', 'misional', 'Jefe de Consulta Externa', 'Atención médica ambulatoria en las diferentes especialidades del hospital.', 4,
'[
  {"id":"r09","type":"riesgo","description":"Cancelación de consultas por ausentismo médico sin sustitución oportuna","cause":"Ausencias no planificadas, falta de médico sustituto","effect":"Insatisfacción del paciente, pérdida de ingresos","probability":3,"impact":3,"action_plan":"Protocolo de sustitución médica. Lista de médicos de guardia por especialidad.","responsible":"Jefe de Consulta Externa","due_date":"2025-11-30","status":"en_control"},
  {"id":"r10","type":"riesgo","description":"Expediente clínico incompleto al momento de la consulta","cause":"Falta de integración de resultados previos, sistema de información desconectado","effect":"Decisiones clínicas sin información completa, riesgo para el paciente","probability":3,"impact":4,"action_plan":"Verificación de expediente completo antes de llamar al paciente. Integrar laboratorio e imagenología al expediente.","responsible":"Jefe de Consulta Externa","due_date":"2025-12-15","status":"identificado"},
  {"id":"r11","type":"oportunidad","description":"Telemedicina para seguimiento de pacientes crónicos","cause":"Tecnología disponible y demanda de pacientes de zonas alejadas","effect":"Mayor cobertura, satisfacción del paciente, reducción de no-asistencias","probability":2,"impact":4,"action_plan":"Evaluar plataformas de telemedicina certificadas. Presentar propuesta a Dirección en Q1 2026.","responsible":"Director General","due_date":"2026-03-31","status":"identificado"}
]'),

('Urgencias y Emergencias', 'misional', 'Jefe de Urgencias', 'Atención inmediata de pacientes en situación de urgencia o emergencia médica.', 5,
'[
  {"id":"r12","type":"riesgo","description":"Saturación del servicio de urgencias por demanda superior a la capacidad","cause":"Incremento de demanda (+18% vs 2024), flujo inadecuado de altas","effect":"Retrasos en atención, riesgo para la vida del paciente, incumplimiento NOM","probability":4,"impact":5,"action_plan":"Protocolo de desvío a hospitales de referencia. Triage activo con enfermera coordinadora. Monitoreo de ocupación en tiempo real.","responsible":"Jefe de Urgencias","due_date":"2025-11-30","status":"en_control"},
  {"id":"r13","type":"riesgo","description":"Falla en la identificación correcta del paciente en urgencias","cause":"Presión asistencial, pacientes sin documentos, inconscientes","effect":"Error en tratamiento, eventos adversos graves","probability":2,"impact":5,"action_plan":"Protocolo de identificación con brazalete y doble verificación. Capacitación semestral al personal de urgencias.","responsible":"Jefe de Urgencias","due_date":"2025-11-30","status":"en_control"},
  {"id":"r14","type":"riesgo","description":"Equipos de reanimación sin mantenimiento preventivo vigente","cause":"Falta de programa de mantenimiento actualizado","effect":"Falla de equipo en emergencia, riesgo de mortalidad evitable","probability":2,"impact":5,"action_plan":"Verificación diaria de equipos críticos (desfibrilador, carro de paro). Mantenimiento preventivo trimestral documentado.","responsible":"Jefe de Mantenimiento","due_date":"2025-11-15","status":"en_control"}
]'),

('Hospitalización', 'misional', 'Jefatura de Enfermería', 'Atención integral al paciente durante su internamiento en las áreas hospitalarias.', 6,
'[
  {"id":"r15","type":"riesgo","description":"Eventos adversos por administración incorrecta de medicamentos","cause":"Errores en transcripción de indicaciones, distracción, personal con carga elevada","effect":"Daño al paciente, eventos centinela, responsabilidad legal","probability":2,"impact":5,"action_plan":"Implementar los 10 correctos de medicación. Verificación doble en medicamentos de alto riesgo. Capacitación semestral.","responsible":"Jefatura de Enfermería","due_date":"2025-11-30","status":"en_control"},
  {"id":"r16","type":"riesgo","description":"Caídas de pacientes durante la hospitalización","cause":"Movilidad reducida, ambiente inadecuado, falta de barandales","effect":"Lesiones al paciente, prolongación de estancia, responsabilidad legal","probability":3,"impact":4,"action_plan":"Escala de valoración de riesgo de caída al ingreso (Morse). Protocolo de prevención activo. Señalización de riesgo en cama.","responsible":"Jefatura de Enfermería","due_date":"2025-11-15","status":"en_control"},
  {"id":"r17","type":"riesgo","description":"Infecciones asociadas a la atención de la salud (IAAS)","cause":"Higiene de manos insuficiente, procedimientos invasivos, pacientes inmunocomprometidos","effect":"Complicaciones clínicas, estancia prolongada, incremento de costos","probability":3,"impact":4,"action_plan":"Programa de higiene de manos (OMS). Monitoreo de tasas de IAAS mensual. Comité de infecciones activo.","responsible":"Jefatura de Enfermería","due_date":"2025-12-31","status":"en_control"}
]'),

('Quirófano y Anestesiología', 'misional', 'Jefe de Quirófano', 'Realización de procedimientos quirúrgicos y manejo anestésico de pacientes.', 7,
'[
  {"id":"r18","type":"riesgo","description":"Cirugía en sitio, paciente o procedimiento incorrecto","cause":"Falta de verificación preoperatoria, comunicación inadecuada del equipo","effect":"Evento centinela, daño grave o muerte del paciente, responsabilidad legal","probability":1,"impact":5,"action_plan":"Implementar Lista de Verificación Quirúrgica OMS (Checklist) en el 100% de los procedimientos. Auditoría mensual de cumplimiento.","responsible":"Jefe de Quirófano","due_date":"2025-11-30","status":"en_control"},
  {"id":"r19","type":"riesgo","description":"Falla del equipo de anestesia durante procedimiento","cause":"Mantenimiento preventivo insuficiente o inexistente","effect":"Riesgo de muerte, evento crítico de seguridad","probability":1,"impact":5,"action_plan":"Mantenimiento preventivo trimestral certificado. Verificación preoperatoria del equipo por anestesiólogo. Protocolo de contingencia disponible.","responsible":"Jefe de Mantenimiento","due_date":"2025-11-30","status":"en_control"},
  {"id":"r20","type":"riesgo","description":"Material de sutura o instrumental sin esterilización vigente utilizado en cirugía","cause":"Desorganización en central de esterilización, etiquetado incorrecto","effect":"Infección del sitio quirúrgico, evento adverso grave","probability":2,"impact":5,"action_plan":"Verificación de vigencia de esterilización en quirófano. Trazabilidad de lotes. Auditoría interna semestral.","responsible":"Jefe de Quirófano","due_date":"2025-11-30","status":"en_control"}
]'),

('Laboratorio Clínico', 'misional', 'Jefe de Laboratorio', 'Análisis clínicos y microbiológicos para el diagnóstico y seguimiento de pacientes.', 8,
'[
  {"id":"r21","type":"riesgo","description":"Resultados de laboratorio incorrectos por falla en calibración de equipos","cause":"Programa de calibración incompleto o con retrasos","effect":"Diagnóstico erróneo, tratamiento inadecuado, daño al paciente","probability":2,"impact":5,"action_plan":"Programa de calibración y mantenimiento preventivo con alertas automatizadas. Control de calidad interno diario.","responsible":"Jefe de Laboratorio","due_date":"2025-11-15","status":"en_control"},
  {"id":"r22","type":"riesgo","description":"Intercambio o pérdida de muestras biológicas","cause":"Etiquetado incorrecto, proceso de recepción sin trazabilidad","effect":"Repetición de toma de muestra, retraso en diagnóstico","probability":2,"impact":3,"action_plan":"Sistema de trazabilidad de muestras con código de barras. Doble verificación en recepción.","responsible":"Jefe de Laboratorio","due_date":"2025-12-31","status":"identificado"},
  {"id":"r23","type":"oportunidad","description":"Acreditación del laboratorio bajo NOM-166-SSA1 para ampliar servicios de referencia","cause":"Capacidad técnica del laboratorio y demanda del mercado local","effect":"Ingresos adicionales, reconocimiento de calidad, diferenciación","probability":2,"impact":4,"action_plan":"Evaluar brechas vs NOM-166. Presentar plan de acreditación a Dirección en Q1 2026.","responsible":"Jefe de Laboratorio","due_date":"2026-06-30","status":"identificado"}
]'),

('Imagenología y Diagnóstico', 'misional', 'Jefe de Imagenología', 'Estudios de diagnóstico por imagen: rayos X, ultrasonido, tomografía.', 9,
'[
  {"id":"r24","type":"riesgo","description":"Exposición del personal a radiación ionizante por encima de límites permitidos","cause":"Falta de dosimetría, uso incorrecto de EPP, blindaje insuficiente","effect":"Daño a la salud del personal, incumplimiento NOM-229-SSA1","probability":2,"impact":5,"action_plan":"Programa de dosimetría personal trimestral. Verificación de EPP y blindaje anual. Capacitación en radioprotección.","responsible":"Jefe de Imagenología","due_date":"2025-11-30","status":"en_control"},
  {"id":"r25","type":"riesgo","description":"Retraso en entrega de resultados de imagen que afecta la toma de decisiones clínicas","cause":"Alta demanda, falta de radiólogos disponibles","effect":"Retraso en diagnóstico y tratamiento, insatisfacción","probability":3,"impact":3,"action_plan":"Meta de entrega: estudio urgente < 1h, electivo < 24h. Monitoreo mensual de tiempos.","responsible":"Jefe de Imagenología","due_date":"2025-12-31","status":"en_control"}
]'),

('Farmacia y Suministro de Medicamentos', 'misional', 'Jefe de Farmacia', 'Gestión, almacenamiento, dispensación y control de medicamentos e insumos médicos.', 10,
'[
  {"id":"r26","type":"riesgo","description":"Dispensación de medicamento incorrecto, dosis incorrecta o a paciente equivocado","cause":"Similitud de nombres de medicamentos, procesos manuales, carga de trabajo elevada","effect":"Evento adverso medicamentoso, daño al paciente","probability":2,"impact":5,"action_plan":"Implementar los 10 correctos en dispensación. Sistemas de alerta para medicamentos LASA (Look-Alike, Sound-Alike). Doble verificación en medicamentos de alto riesgo.","responsible":"Jefe de Farmacia","due_date":"2025-11-30","status":"en_control"},
  {"id":"r27","type":"riesgo","description":"Desabasto de medicamentos críticos por falla en la cadena de suministro","cause":"Proveedor único, falta de stock de seguridad","effect":"Interrupción del tratamiento, riesgo para el paciente","probability":3,"impact":4,"action_plan":"Mantener stock de seguridad de 30 días para medicamentos críticos. Tener proveedores alternativos homologados.","responsible":"Jefe de Farmacia","due_date":"2025-11-30","status":"en_control"},
  {"id":"r28","type":"riesgo","description":"Medicamentos controlados sin control de doble firma y registro en libro de psicotrópicos","cause":"Incumplimiento del procedimiento, personal no capacitado","effect":"NC en auditoría, sanciones de COFEPRIS","probability":3,"impact":4,"action_plan":"Actualizar procedimiento de control de psicotrópicos. Supervisión diaria del libro. Capacitación al personal de farmacia.","responsible":"Jefe de Farmacia","due_date":"2025-11-15","status":"en_control"}
]'),

-- ─── APOYO ──────────────────────────────────────────────────────
('Recursos Humanos y Capacitación', 'apoyo', 'Jefatura Capital Humano', 'Selección, contratación, desarrollo y gestión del personal del hospital.', 11,
'[
  {"id":"r29","type":"riesgo","description":"Contratación de personal sin verificación de competencias y documentos habilitantes","cause":"Proceso de selección apresurado, falta de procedimiento formal","effect":"Personal no competente atendiendo pacientes, riesgo legal","probability":2,"impact":5,"action_plan":"Procedimiento de selección con checklist de documentos (cédula, título, certificados). Periodo de inducción obligatorio.","responsible":"Jefatura Capital Humano","due_date":"2025-12-31","status":"en_control"},
  {"id":"r30","type":"riesgo","description":"Alta rotación de personal clave en áreas críticas","cause":"Condiciones laborales, salarios no competitivos","effect":"Pérdida de conocimiento, impacto en calidad de atención","probability":3,"impact":4,"action_plan":"Encuesta de clima laboral anual. Plan de retención para personal clave. Análisis de salarios vs mercado.","responsible":"Jefatura Capital Humano","due_date":"2026-01-31","status":"identificado"},
  {"id":"r31","type":"oportunidad","description":"Programa de desarrollo de competencias alineado al SGC para cerrar brechas","cause":"Identificación de necesidades de capacitación del SGC","effect":"Personal más competente, menor incidencia de NCs por factor humano","probability":4,"impact":4,"action_plan":"Plan anual de capacitación basado en análisis de brechas. Incluir ISO 9001, seguridad del paciente y habilidades técnicas.","responsible":"Jefatura Capital Humano","due_date":"2026-01-31","status":"identificado"}
]'),

('Mantenimiento de Infraestructura y Equipos', 'apoyo', 'Jefe de Mantenimiento', 'Mantenimiento preventivo y correctivo de instalaciones, equipos médicos y servicios generales.', 12,
'[
  {"id":"r32","type":"riesgo","description":"Falla de equipo médico durante su uso por falta de mantenimiento preventivo","cause":"Programa de mantenimiento incompleto, falta de recursos","effect":"Interrupción de servicio, riesgo para el paciente","probability":3,"impact":5,"action_plan":"Plan anual de mantenimiento preventivo por equipo. Alerta automática de vencimiento. Registro de cada mantenimiento realizado.","responsible":"Jefe de Mantenimiento","due_date":"2025-11-30","status":"en_control"},
  {"id":"r33","type":"riesgo","description":"Interrupción del suministro eléctrico sin planta de emergencia funcionando","cause":"Falla de planta de emergencia sin mantenimiento, planta con capacidad insuficiente","effect":"Interrupción de quirófano, UCI, laboratorio — riesgo de muerte","probability":2,"impact":5,"action_plan":"Prueba mensual de planta de emergencia. Mantenimiento preventivo semestral certificado. Verificar cobertura de carga crítica.","responsible":"Jefe de Mantenimiento","due_date":"2025-11-15","status":"en_control"}
]'),

('Compras y Gestión de Proveedores', 'apoyo', 'Administración', 'Adquisición de insumos, medicamentos, equipos y servicios de proveedores externos.', 13,
'[
  {"id":"r34","type":"riesgo","description":"Compra de insumos médicos o medicamentos de calidad no verificada","cause":"Ausencia de proceso de evaluación y homologación de proveedores","effect":"Uso de materiales deficientes, riesgo para el paciente, NC en auditoría","probability":3,"impact":4,"action_plan":"Implementar procedimiento de evaluación y re-evaluación anual de proveedores críticos. Lista de proveedores aprobados.","responsible":"Administración","due_date":"2025-12-31","status":"identificado"},
  {"id":"r35","type":"riesgo","description":"Desabasto de insumos críticos por dependencia de proveedor único","cause":"Falta de proveedores alternativos homologados","effect":"Interrupción de servicios, impacto en calidad de atención","probability":3,"impact":4,"action_plan":"Mantener mínimo 2 proveedores homologados para insumos críticos. Stock de seguridad de 15 días.","responsible":"Administración","due_date":"2025-12-31","status":"identificado"}
]'),

('Limpieza y Gestión Ambiental', 'apoyo', 'Jefe de Servicios Generales', 'Limpieza, desinfección y manejo de residuos peligrosos biológico-infecciosos (RPBI).', 14,
'[
  {"id":"r36","type":"riesgo","description":"Manejo inadecuado de residuos peligrosos biológico-infecciosos (RPBI)","cause":"Personal no capacitado, contenedores incorrectos, procedimiento desactualizado","effect":"Riesgo biológico para personal y pacientes, sanciones COFEPRIS/SEMARNAT","probability":3,"impact":4,"action_plan":"Capacitación semestral en manejo de RPBI. Auditoría interna trimestral. Actualizar procedimiento PR-SA-01.","responsible":"Jefe de Servicios Generales","due_date":"2025-11-30","status":"en_control"},
  {"id":"r37","type":"riesgo","description":"Contaminación cruzada por limpieza insuficiente en áreas críticas","cause":"Personal sin capacitación específica, insumos insuficientes, tiempos de limpieza reducidos","effect":"Incremento de IAAS, riesgo para pacientes hospitalizados","probability":3,"impact":4,"action_plan":"Check-list de limpieza con verificación de supervisor. Rotación de desinfectantes para evitar resistencias. Monitoreo de IAAS mensual.","responsible":"Jefe de Servicios Generales","due_date":"2025-11-30","status":"en_control"}
]'),

('Sistemas de Información', 'apoyo', 'Responsable de TI', 'Gestión y mantenimiento de los sistemas de información del hospital y el SGC.', 15,
'[
  {"id":"r38","type":"riesgo","description":"Pérdida de datos del SGC o expedientes por falla en sistemas o ciberataque","cause":"Falta de respaldos periódicos, sistemas desactualizados, ausencia de política de seguridad","effect":"Pérdida de información crítica, incumplimiento de requisitos regulatorios","probability":2,"impact":5,"action_plan":"Política de respaldo diario automático en nube. Prueba de restauración semestral. Antivirus y firewall actualizados.","responsible":"Responsable de TI","due_date":"2025-12-31","status":"identificado"},
  {"id":"r39","type":"riesgo","description":"Caída del sistema de información en horario de alta demanda","cause":"Infraestructura de servidor insuficiente, falta de redundancia","effect":"Interrupción de procesos de admisión, facturación y farmacia","probability":2,"impact":4,"action_plan":"Plan de continuidad operacional en papel para procesos críticos. Evaluar redundancia de servidor en Q1 2026.","responsible":"Responsable de TI","due_date":"2026-01-31","status":"identificado"},
  {"id":"r40","type":"oportunidad","description":"Integración de sistemas (laboratorio, farmacia, admisión) en plataforma única","cause":"Sistemas actuales funcionan en silos, sin interoperabilidad","effect":"Reducción de errores de transcripción, mejora en continuidad asistencial","probability":2,"impact":5,"action_plan":"Levantar requerimientos de integración. Evaluar soluciones HIS (Hospital Information System) en Q2 2026.","responsible":"Responsable de TI","due_date":"2026-06-30","status":"identificado"}
]')

ON CONFLICT DO NOTHING;

-- ── Verificar ─────────────────────────────────────────────────────
SELECT name, process_type,
       jsonb_array_length(risks) AS riesgos,
       sort_order
FROM risk_processes
ORDER BY sort_order;
