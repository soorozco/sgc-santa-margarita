-- ═══════════════════════════════════════════════════════════════
-- Seed: Registros de Auditorías Internas 2025-2026
-- Hospital Santa Margarita — SGC ISO 9001:2015
-- Ejecutar DESPUÉS de: auditorias_internas_setup.sql
--                      ai_columns_migration.sql
--                      plan_anual_setup.sql
-- ═══════════════════════════════════════════════════════════════
-- Los hallazgos están basados en los registros del
-- Formulario de Notificación de Incidentes de la Atención
-- Clínica (122 reportes Jul-2025 → May-2026).
-- ═══════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_id UUID;
BEGIN

-- ──────────────────────────────────────────────────────────────
-- AI-2025-001 · Quirófano · Mayo 2025
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2025-001') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2025-001', 'programada',
    'Dra. Giselle De la Torre',
    '2025-05-14', '2025-05-14',
    'Procesos quirúrgicos, esterilización, seguridad del paciente e infraestructura',
    'Dra. Giselle De la Torre',
    '["Quirófano"]',
    'completada',
    'hallazgos_menores',
    'La auditoría al área de Quirófano identificó oportunidades de mejora en la documentación preoperatoria y en la verificación del equipamiento de esterilización. No se detectaron no conformidades mayores. Se recomienda reforzar el protocolo de lista de verificación quirúrgica (OMS) y estandarizar el registro de tiempos de proceso.',
    '2025-11-01',
    '[
      {"type":"NC_menor","clause":"§8.5","description":"Lista de verificación quirúrgica (OMS) no completada en 2 de 5 expedientes revisados; se omitieron los campos de confirmación de alergias y lateralidad.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.5","description":"Registros de esterilización con datos incompletos: falta lote y fecha de caducidad en 3 paquetes. No se cumple trazabilidad §7.5.3.","status":"abierto"},
      {"type":"Observacion","clause":"§6.1","description":"El equipo de quirófano no cuenta con un análisis documentado de riesgos operacionales actualizado para el período 2025.","status":"abierto"}
    ]',
    '[
      {"clause":"§4.1","question":"¿El área conoce el contexto y las partes interesadas que la afectan?","result":"SI","type":"Observacion"},
      {"clause":"§5.1","question":"¿La Dirección demuestra liderazgo y compromiso con el SGC en el área?","result":"SI","type":null},
      {"clause":"§6.1","question":"¿Existen acciones para gestionar riesgos y oportunidades en el área?","result":"NO","type":"NC_menor"},
      {"clause":"§7.1.5","question":"¿Los equipos y dispositivos están calibrados y con registros vigentes?","result":"SI","type":null},
      {"clause":"§7.5","question":"¿La información documentada (registros) es completa y trazable?","result":"NO","type":"NC_menor"},
      {"clause":"§8.5","question":"¿Se aplica la lista de verificación quirúrgica (OMS) en todos los procedimientos?","result":"NO","type":"NC_menor"},
      {"clause":"§9.1","question":"¿Se monitorean indicadores de desempeño del área?","result":"SI","type":null},
      {"clause":"§10.2","question":"¿Se gestionan y documentan las no conformidades y acciones correctivas?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"b","formacion_sgc":"mb","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"mb","actitud_claridad":"mb","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2025-001","descripcion":"Completar lista de verificación quirúrgica OMS en el 100% de procedimientos","responsable":"Jefe de Quirófano","fecha_compromiso":"2025-07-15","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-002","descripcion":"Actualizar registros de esterilización con lote y caducidad según §7.5.3","responsable":"Encargada de CEYE","fecha_compromiso":"2025-06-30","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2025-06-30","puntos_fuertes":"Personal quirúrgico comprometido. Infraestructura adecuada. Equipamiento vigente.","potencial_mejora":"Estandarización de registros documentales y completud de lista de verificación OMS.","quejas":"Sin quejas registradas durante el período auditado.","auditorias_previas":"Primera auditoría formal al área bajo el nuevo SGC ISO 9001:2015.","revision_sistema":"Pendiente inclusión de hallazgos en la próxima Revisión por la Dirección.","valoracion":"satisfactorio"}'
  );
  -- Vincular con plan anual
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2025-001'
  ) WHERE year = 2025 AND month = 5 AND area = 'Quirófano';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2025-002 · Cocina / Nutrición · Julio 2025
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2025-002') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2025-002', 'programada',
    'Dra. Giselle De la Torre',
    '2025-07-10', '2025-07-10',
    'Procesos de cocina, inocuidad alimentaria y nutrición clínica',
    'Dra. Giselle De la Torre',
    '["Cocina / Nutrición"]',
    'completada',
    'hallazgos_mayores',
    'La auditoría detectó fallas relevantes en el proceso de verificación de dietas antes de su entrega: una cuasi falla documentada el 19-Jul-2025 (lácteos a paciente con intolerancia) y fallos de comunicación con enfermería que permitieron entregar dieta a un paciente ya dado de alta. Se emiten NC mayores por ausencia de doble verificación y falta de protocolo actualizado.',
    '2026-06-01',
    '[
      {"type":"NC_mayor","clause":"§8.5","description":"El 19-Jul-2025 se suministraron lácteos a paciente con intolerancia documentada. El personal de nutrición corrigió el error al momento de la entrega, pero no existe un protocolo escrito de doble verificación antes de despachar las bandejas (cuasi falla reportada).","status":"abierto"},
      {"type":"NC_mayor","clause":"§7.5","description":"El proceso de recepción y confirmación de listado de pacientes activos no se valida con el sistema de indicaciones médicas. El 1-Sep-2025 se entregó cena a un paciente ya dado de alta por falta de cruce de información con enfermería.","status":"abierto"},
      {"type":"NC_menor","clause":"§8.4","description":"El proveedor de insumos no es evaluado periódicamente; no se documentan criterios de selección ni evaluación de desempeño de proveedores externos de alimentos.","status":"abierto"},
      {"type":"Observacion","clause":"§6.1","description":"No se ha realizado análisis de peligros HACCP formal para el servicio de nutrición clínica, aumentando el riesgo de inocuidad alimentaria.","status":"abierto"}
    ]',
    '[
      {"clause":"§4.1","question":"¿El área conoce el contexto y las partes interesadas que la afectan?","result":"SI","type":null},
      {"clause":"§6.1","question":"¿Existen acciones para gestionar riesgos e inocuidad alimentaria?","result":"NO","type":"NC_mayor"},
      {"clause":"§7.5","question":"¿La documentación de indicaciones dietéticas es validada antes de la entrega?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.4","question":"¿Los proveedores de insumos alimenticios están evaluados y controlados?","result":"NO","type":"NC_menor"},
      {"clause":"§8.5","question":"¿Existe un procedimiento de doble verificación de dietas antes de la entrega?","result":"NO","type":"NC_mayor"},
      {"clause":"§9.1","question":"¿Se monitorean indicadores de satisfacción e inocuidad del servicio?","result":"NO","type":"NC_menor"},
      {"clause":"§10.2","question":"¿Las cuasi fallas y eventos adversos nutricionales se registran y analizan?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"b","formacion_sgc":"b","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"b","actitud_claridad":"b","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2025-003","descripcion":"Implementar protocolo de doble verificación de dietas (dietista + enfermería) previo a despacho","responsable":"Encargada de Cocina","fecha_compromiso":"2025-09-01","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-004","descripcion":"Establecer procedimiento de cruce de alta de pacientes con listado de dietas en tiempo real","responsable":"Encargada de Cocina / Jefa de Enfermería","fecha_compromiso":"2025-09-01","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-005","descripcion":"Documentar y ejecutar evaluación semestral de proveedores de insumos alimenticios","responsable":"Encargada de Cocina","fecha_compromiso":"2025-10-15","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2025-09-01","puntos_fuertes":"Disposición del personal para reportar cuasi fallas. Infraestructura de cocina en condiciones higiénicas adecuadas.","potencial_mejora":"Protocolos de verificación de dietas, comunicación con enfermería y evaluación de proveedores.","quejas":"Una cuasi falla documentada (lácteos a px con intolerancia, 19-Jul-2025).","auditorias_previas":"No se tienen registros de auditorías previas al área.","revision_sistema":"Hallazgos incluidos en seguimiento trimestral de calidad.","valoracion":"con_observaciones"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2025-002'
  ) WHERE year = 2025 AND month = 7 AND area = 'Cocina / Nutrición';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2025-003 · Quirófano (Seguimiento) · Agosto 2025
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2025-003') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2025-003', 'seguimiento',
    'Dra. Giselle De la Torre',
    '2025-08-21', '2025-08-21',
    'Seguimiento de hallazgos mayo 2025 · Manejo de dispositivos invasivos y trazabilidad de resultados diagnósticos',
    'Dra. Giselle De la Torre',
    '["Quirófano"]',
    'completada',
    'hallazgos_mayores',
    'La auditoría de seguimiento evidenció que los hallazgos NC-2025-001 y NC-2025-002 tienen avance parcial. Adicionalmente se documentaron tres eventos adversos relevantes durante agosto que afectan directamente los procesos auditados: desplazamiento de CVC por sutura rota sin notificación oportuna (30-Jul), mala manipulación de nefrostomías por enfermería (13-14-Ago) y retraso >10 h en reporte de RM urgente (26-Ago). Se mantiene resultado con hallazgos mayores.',
    '2025-11-01',
    '[
      {"type":"NC_mayor","clause":"§8.5","description":"30-Jul-2025: Desplazamiento de CVC (Herminio Morales) por sutura rota; la enfermera a cargo observó fuga desde la mañana pero no reportó, resultando en pérdida de nutrición parenteral y medicación durante horas. Falla en monitorización y reporte oportuno de dispositivos invasivos.","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"13-14-Ago-2025: Personal de enfermería manipuló nefrostomías de paciente (José C. Ochoa) sin consultar al médico tratante, obtuvo muestra hemática, no reportó al equipo médico y despinzó sin indicación. La intervención llegó gracias a la alerta de la familiar. Grave falla en protocolos de procedimientos invasivos y comunicación §8.5.1.","status":"abierto"},
      {"type":"NC_mayor","clause":"§7.5","description":"26-Ago-2025: RM de cráneo urgente (sospecha de EVC) realizada a las 21:00 h sin reporte radiológico hasta las 07:22 h del día siguiente (>10 h). No existe protocolo de tiempo máximo de reporte para estudios urgentes ni escalamiento definido.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.5","description":"Avance parcial en NC-2025-001 y NC-2025-002 de mayo 2025: la lista de verificación OMS mejoró a 80% de completud, pero los registros de esterilización siguen sin trazabilidad de lote en el 30% de los casos.","status":"abierto"}
    ]',
    '[
      {"clause":"§7.5","question":"¿Los registros de dispositivos invasivos (CVC, nefrostomías) están actualizados y son trazables?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿El personal conoce y aplica el protocolo de monitorización y reporte de dispositivos?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿Existe protocolo documentado para procedimientos de toma de muestras especiales (nefrostomías)?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.7","question":"¿Los hallazgos de mayo 2025 (NC-2025-001, NC-2025-002) muestran acciones correctivas evidenciables?","result":"SI","type":null},
      {"clause":"§9.1","question":"¿Se monitorea el tiempo de reporte de estudios de imagen urgentes?","result":"NO","type":"NC_menor"},
      {"clause":"§10.2","question":"¿Los eventos adversos del área se analizan causalmente y se registran acciones?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"b","formacion_sgc":"b","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"mb","actitud_claridad":"b","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2025-006","descripcion":"Difundir y capacitar al personal en protocolo de monitorización y reporte de dispositivos invasivos (CVC, sondas, nefrostomías)","responsable":"Jefe de Quirófano / Jefa de Enfermería","fecha_compromiso":"2025-10-15","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-007","descripcion":"Establecer tiempo máximo de reporte de estudios urgentes (imagen/laboratorio) con protocolo de escalamiento","responsable":"Jefe de Imagenología","fecha_compromiso":"2025-10-01","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2025-10-15","puntos_fuertes":"Mejora parcial en lista de verificación OMS. Cultura de reporte de eventos adversos en aumento.","potencial_mejora":"Protocolos de dispositivos invasivos, reporte de estudios urgentes y cultura de comunicación médico-enfermería.","quejas":"Tres eventos adversos relevantes documentados en agosto 2025 con afectación directa al área.","auditorias_previas":"Seguimiento de AI-2025-001 (mayo 2025). NC-2025-001 y NC-2025-002 con avance parcial.","revision_sistema":"Hallazgos trasladados a la Dirección Médica para reforzamiento de protocolos.","valoracion":"con_observaciones"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2025-003'
  ) WHERE year = 2025 AND month = 8 AND area = 'Quirófano';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2025-004 · Farmacia Hospitalaria · Septiembre 2025
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2025-004') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2025-004', 'programada',
    'Dra. Giselle De la Torre',
    '2025-09-18', '2025-09-18',
    'Preparación, dispensación, control de caducidades y medicamentos de alto riesgo',
    'Dra. Giselle De la Torre',
    '["Farmacia Hospitalaria"]',
    'completada',
    'hallazgos_mayores',
    'La auditoría a Farmacia Hospitalaria identificó múltiples no conformidades mayores relacionadas con el control de medicamentos: administración de medicamento incorrecto por ilegibilidad de prescripción (rifampicina/rifaximina, 30-Jul-2025), dosis de medicamento errada por omisión de doble verificación (Amiodarona 200 mg no administrada, 14-Ago-2025), administración de solución Hartmann a velocidad incorrecta (6-Sep-2025) y administración de medicamento equivocado LASA (fluconazol por cilostazol, 11-Sep-2025). Se requieren acciones correctivas urgentes.',
    '2025-12-01',
    '[
      {"type":"NC_mayor","clause":"§8.5","description":"30-Jul-2025: Prescripción ilegible de médico tratante causó que se administrara rifaximina en lugar de rifampicina. Enfermería consultó a médicos de guardia que intentaron contactar al tratante sin éxito, y dieron indicación errónea. No existe protocolo de validación de prescripciones ilegibles §8.5.1.","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"14-Ago-2025: Omisión de Amiodarona 200 mg VO en cambio de indicaciones. La indicación de transición no fue comunicada ni verificada entre turnos. El médico de guardia desconocía el motivo de la omisión. Falla en proceso de conciliación de medicamentos §8.5.","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"6-Sep-2025: Solución Hartmann 1000 cc indicada para 24 h fue administrada en ~3 h. Grave error de velocidad de infusión sin doble verificación de bomba/cálculo de goteo. Falta de protocolo de administración de soluciones §8.5.1.","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"11-Sep-2025: Administración de fluconazol en lugar de cilostazol (error LASA - Look-Alike Sound-Alike). Personal no aplicó los 10 correctos de enfermería. No existe lista de medicamentos LASA disponible en el servicio §8.5.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.5","description":"Los registros de administración de medicamentos en hojas de enfermería presentan inconsistencias: marcas como administrado sin evidencia de aplicación real (caso losartán/amlodipino, 9-Sep-2025).","status":"abierto"}
    ]',
    '[
      {"clause":"§7.5","question":"¿Los registros de administración de medicamentos son completos y trazables?","result":"NO","type":"NC_menor"},
      {"clause":"§8.4","question":"¿Los procesos de dispensación de farmacia cumplen los requisitos del cliente interno?","result":"NO","type":"NC_menor"},
      {"clause":"§8.5","question":"¿Existe y se aplica el protocolo de los 10 correctos de enfermería para medicación?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿Existe lista de medicamentos LASA disponible en el área de dispensación?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿El proceso de conciliación de medicamentos se ejecuta en cada cambio de turno?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.7","question":"¿Los errores de medicación se documentan, analizan y generan acciones correctivas?","result":"SI","type":null},
      {"clause":"§9.1","question":"¿Se mide la tasa de errores de medicación como indicador de desempeño?","result":"NO","type":"NC_menor"},
      {"clause":"§10.2","question":"¿Existe un proceso formal de análisis de causa raíz para eventos de medicación?","result":"NO","type":"NC_mayor"}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"b","formacion_sgc":"mb","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"mb","actitud_claridad":"mb","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2025-008","descripcion":"Implementar y capacitar en protocolo de validación de prescripciones ilegibles con protocolo de confirmación directa con médico tratante","responsable":"Jefa de Farmacia / Jefa de Enfermería","fecha_compromiso":"2025-11-15","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-009","descripcion":"Publicar lista de medicamentos LASA en área de dispensación y en central de enfermería. Capacitar al personal en identificación y manejo.","responsable":"Jefa de Farmacia","fecha_compromiso":"2025-11-01","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-010","descripcion":"Establecer protocolo de conciliación de medicamentos en cada cambio de turno con firma de verificación","responsable":"Jefa de Enfermería","fecha_compromiso":"2025-11-15","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-011","descripcion":"Definir indicador de tasa de errores de medicación y reportarlo mensualmente al SGC","responsable":"Responsable de Calidad","fecha_compromiso":"2025-12-01","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2025-11-15","puntos_fuertes":"Personal reporta los incidentes al área de calidad de forma oportuna. Farmacia con control de caducidades al día.","potencial_mejora":"Protocolos de los 10 correctos, lista LASA, conciliación de medicamentos y registro de administración.","quejas":"Cuatro eventos adversos de medicación documentados en julio-septiembre 2025, dos de ellos con resultado Leve.","auditorias_previas":"Primera auditoría formal a Farmacia Hospitalaria.","revision_sistema":"Se solicita inclusión urgente en agenda de Revisión por la Dirección por gravedad de hallazgos.","valoracion":"con_observaciones"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2025-004'
  ) WHERE year = 2025 AND month = 9 AND area = 'Farmacia Hospitalaria';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2025-005 · Urgencias · Octubre 2025
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2025-005') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2025-005', 'programada',
    'Dra. Giselle De la Torre',
    '2025-10-23', '2025-10-23',
    'Triage, tiempos de atención, protocolos de urgencia y seguridad del paciente',
    'Dra. Giselle De la Torre',
    '["Urgencias"]',
    'completada',
    'hallazgos_mayores',
    'La auditoría a Urgencias detectó hallazgos mayores relacionados con seguridad del paciente: tres caídas documentadas (6-Oct y 19-Oct-2025, dos con daño moderado), error de medicación grave durante evento convulsivo por falta de protocolo farmacéutico en urgencias (8-Oct, midazolam por diazepam), y paciente con dispositivo urinario ocluido más de 8 horas sin atención (19-Oct, daño Grave). Se emiten no conformidades mayores en gestión de riesgos y protocolos de urgencia.',
    '2026-02-01',
    '[
      {"type":"NC_mayor","clause":"§6.1","description":"6-Oct-2025: Paciente angloparlante (Darrell Bushnell) sin familiar sufrió dos caídas documentadas al ir al baño. No existe protocolo de evaluación de riesgo de caídas para pacientes con barrera de idioma ni sistema de apoyo nocturno para adultos mayores sin acompañante.","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"8-Oct-2025: Durante evento convulsivo, enfermería administró midazolam en lugar de diazepam al abrir el carro rojo sin filtro de farmacia. Se omitió el registro en hoja de enfermería. No existe protocolo de acceso controlado a medicamentos de emergencia con doble verificación §8.5.","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"19-Oct-2025 (resultado Grave): Paciente con cistoclisis presentó gasto urinario nulo durante más de 8 horas por obstrucción de sonda. La eventualidad no fue reportada en tiempo y forma al médico de guardia ni al tratante. Sin acciones inmediatas durante un turno completo.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.1","description":"19-Oct-2025: Caída de paciente geriátrica en baño; se notificó primero al médico tratante que a enfermería. No existe protocolo claro de escalamiento y comunicación para eventos de caída §7.1.","status":"abierto"},
      {"type":"Observacion","clause":"§8.2","description":"Paciente con manejo de vía aérea (2-Oct-2025): personal de inhaloterapia modificó tratamiento sin indicación médica ni notificación. Requiere reforzamiento de delimitación de roles y competencias en urgencias.","status":"abierto"}
    ]',
    '[
      {"clause":"§6.1","question":"¿Existe evaluación de riesgo de caídas documentada para todos los pacientes en urgencias?","result":"NO","type":"NC_mayor"},
      {"clause":"§7.1","question":"¿El personal conoce el protocolo de escalamiento y comunicación ante caídas?","result":"NO","type":"NC_menor"},
      {"clause":"§8.5","question":"¿Existe protocolo de acceso a medicamentos de emergencia con doble verificación farmacéutica?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿Se monitorea la funcionalidad de dispositivos de los pacientes (sondas, drenajes) en cada turno?","result":"NO","type":"NC_mayor"},
      {"clause":"§9.1","question":"¿Se miden los tiempos de atención y respuesta en urgencias como indicadores clave?","result":"SI","type":null},
      {"clause":"§10.2","question":"¿Los eventos adversos en urgencias se analizan con causa raíz y generan acciones correctivas?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"b","formacion_sgc":"b","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"b","actitud_claridad":"b","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2025-012","descripcion":"Implementar escala de evaluación de riesgo de caídas (Morse o Downton) para todos los pacientes al ingreso a urgencias y hospitalización","responsable":"Jefe de Urgencias / Jefa de Enfermería","fecha_compromiso":"2025-12-15","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-013","descripcion":"Establecer protocolo de acceso a medicamentos de emergencia (carro rojo) con filtro obligatorio de farmacia y doble verificación","responsable":"Jefa de Farmacia / Jefe de Urgencias","fecha_compromiso":"2025-12-01","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-014","descripcion":"Definir ronda de verificación de dispositivos invasivos (sondas, drenajes) al menos cada 4 horas con registro en hoja de enfermería","responsable":"Jefa de Enfermería","fecha_compromiso":"2025-12-01","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2025-12-15","puntos_fuertes":"Alta tasa de reporte de eventos adversos. Personal de urgencias proactivo en notificación.","potencial_mejora":"Protocolos de caídas, medicamentos de emergencia, monitorización de dispositivos y comunicación entre turnos.","quejas":"Tres caídas documentadas (2 moderadas, 1 con Grave por obstrucción de sonda) en octubre 2025.","auditorias_previas":"Primera auditoría formal al servicio de Urgencias.","revision_sistema":"Se recomienda presentación de hallazgos en Comité de Seguridad del Paciente y Revisión por la Dirección.","valoracion":"con_observaciones"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2025-005'
  ) WHERE year = 2025 AND month = 10 AND area = 'Urgencias';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2025-006 · Admisión · Noviembre 2025
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2025-006') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2025-006', 'programada',
    'Dra. Giselle De la Torre',
    '2025-11-20', '2025-11-20',
    'Procesos administrativos, admisión y alta de pacientes',
    'Dra. Giselle De la Torre',
    '["Admisión"]',
    'completada',
    'hallazgos_mayores',
    'La auditoría a Admisión identificó fallas graves en la transmisión de información clínica al momento del egreso y traslado de pacientes: un paciente postquirúrgico entregado inestable con Glasgow <13 al piso sin indicaciones del anestesiólogo (8-Nov-2025, resultado Grave), y una sobredosis de heparina 10x la dosis indicada en paciente de bypass femoro-poplíteo por error de dispensación nocturno (11-Nov-2025, resultado Grave). Los procesos de alta y traslado no cuentan con verificación sistemática documentada.',
    '2026-01-01',
    '[
      {"type":"NC_mayor","clause":"§8.5","description":"8-Nov-2025 (resultado Grave): Paciente posquirúrgico (J. Asunción González) entregado a hospitalización con Glasgow deteriorado, hipertensión y desaturación. El anestesiólogo no dejó indicaciones al salir de recuperación. El médico tratante, contactado dos veces, no atendió correctamente la comunicación clínica. El paciente llegó a piso inestable sin protocolo de entrega estructurado (SBAR).","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"11-Nov-2025 (resultado Grave): Paciente de bypass femoro-poplíteo (Ventura Sánchez Benita) recibió 50,000 UI de heparina en lugar de 5,000 UI indicadas (error 10x). La enfermera nocturna tomó dos frascos de 5,000 UI/mL 10 mL de farmacia y administró el frasco completo dos veces. No hubo verificación farmacéutica nocturna ni doble chequeo de dosis.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.5","description":"El proceso de admisión no valida sistemáticamente las alergias documentadas. El 15-Ago-2025 se perdió la hoja de indicaciones inicial de una paciente y se indicaron nuevos medicamentos sin verificar alergias previas, resultando en reacción alérgica a cefalotina (Moderado).","status":"abierto"},
      {"type":"Observacion","clause":"§8.2","description":"Los criterios de alta médica y los pasos de egreso no están estandarizados; diferentes médicos comunican el alta por distintos canales (WhatsApp, verbal, sello), lo que genera confusión en admisión y enfermería.","status":"abierto"}
    ]',
    '[
      {"clause":"§7.5","question":"¿Los registros de alergias del paciente se verifican al ingreso y en cada cambio de medicación?","result":"NO","type":"NC_menor"},
      {"clause":"§8.2","question":"¿El proceso de alta está estandarizado con criterios y pasos documentados?","result":"NO","type":"Observacion"},
      {"clause":"§8.5","question":"¿Existe protocolo SBAR o equivalente para la entrega de pacientes entre servicios?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿Las dosis de medicamentos de alto riesgo (heparina, insulina) tienen doble verificación obligatoria?","result":"NO","type":"NC_mayor"},
      {"clause":"§9.1","question":"¿Se monitorea el tiempo de admisión y de proceso de alta?","result":"SI","type":null},
      {"clause":"§10.2","question":"¿Los eventos relacionados con admisión generan acciones correctivas documentadas?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"b","formacion_sgc":"b","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"b","actitud_claridad":"b","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2025-015","descripcion":"Implementar protocolo SBAR para entrega de pacientes en todos los traslados (Urgencias→Piso, Quirófano→Recuperación→Piso)","responsable":"Jefa de Admisión / Jefe de Urgencias / Jefe de Quirófano","fecha_compromiso":"2026-01-31","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-016","descripcion":"Establecer doble verificación OBLIGATORIA para medicamentos de alto riesgo (heparina, insulina, anticoagulantes) con firma de dos personas","responsable":"Jefa de Farmacia / Jefa de Enfermería","fecha_compromiso":"2025-12-15","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-017","descripcion":"Documentar y difundir proceso de alta estandarizado con verificación de alergias documentadas al ingreso","responsable":"Jefa de Admisión","fecha_compromiso":"2026-01-15","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2026-01-31","puntos_fuertes":"Personal administrativo de admisión con buena disposición. Sistema de registro de pacientes actualizado.","potencial_mejora":"Protocolo SBAR de entrega de pacientes, verificación de alergias, doble verificación de medicamentos de alto riesgo.","quejas":"Dos eventos Graves en noviembre 2025: entrega de paciente inestable y sobredosis de heparina 10x.","auditorias_previas":"Primera auditoría formal al área de Admisión.","revision_sistema":"Hallazgos reportados a Dirección Médica como prioritarios por su gravedad.","valoracion":"con_observaciones"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2025-006'
  ) WHERE year = 2025 AND month = 11 AND area = 'Admisión';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2025-007 · Quirófano · Noviembre 2025
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2025-007') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2025-007', 'programada',
    'Dra. Giselle De la Torre',
    '2025-11-27', '2025-11-27',
    'Procesos quirúrgicos, esterilización, seguridad e infraestructura. Revisión de hallazgos previos.',
    'Dra. Giselle De la Torre',
    '["Quirófano"]',
    'completada',
    'hallazgos_mayores',
    'La auditoría de noviembre a Quirófano documenta avances en la lista de verificación OMS (cumplimiento al 90%) y trazabilidad de esterilización. Sin embargo, dos eventos graves del 8 y 11 de noviembre ocurridos en el área de recuperación posquirúrgica revelan fallas en el proceso de egreso de pacientes y en la dispensación de medicamentos de alto riesgo (heparina 10x). Se cierran NC-2025-001 y NC-2025-002; se abren nuevas NC relacionadas con el proceso de recuperación posquirúrgica.',
    '2026-04-01',
    '[
      {"type":"NC_mayor","clause":"§8.5","description":"8-Nov-2025 (Grave): Proceso de egreso de recuperación posquirúrgica sin protocolo de entrega estructurado. El anestesiólogo no dejó indicaciones al retirarse; el médico tratante no atendió adecuadamente las dos llamadas del personal de recuperación. El paciente llegó hemodinámicamente inestable al piso (Glasgow deteriorado, TA 210/108, desaturación 83%).","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"11-Nov-2025 (Grave): Error de dosis de heparina (50,000 UI aplicadas en lugar de 5,000 UI) en paciente de bypass femoro-poplíteo; ocurrido en el período posquirúrgico inmediato. Farmacia dispensó sin verificación de la concentración (5,000 UI/mL × 10 mL = 50,000 UI). Sin doble verificación de dosis.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.5","description":"Equipos de monitoreo en área de recuperación: oxímetros con lecturas inconsistentes entre sí (14-Nov-2025). Se detectaron 4 dispositivos dando lecturas discordantes de SpO2 sin un protocolo de verificación cruzada ni calibración documentada.","status":"abierto"},
      {"type":"Observacion","clause":"§8.7","description":"NC-2025-001 (lista de verificación OMS): CERRADA — cumplimiento al 90%. NC-2025-002 (trazabilidad de esterilización): CERRADA — registros completos en el 95% de los casos.","status":"cerrado"}
    ]',
    '[
      {"clause":"§7.1.5","question":"¿Los dispositivos de monitoreo en recuperación están calibrados y con registros vigentes?","result":"NO","type":"NC_menor"},
      {"clause":"§8.5","question":"¿Existe protocolo documentado de egreso de recuperación posquirúrgica con criterios de Aldrete?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿Las dosis de medicamentos de alto riesgo en el período posquirúrgico tienen doble verificación?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.7","question":"¿Las NC-2025-001 y NC-2025-002 de mayo 2025 muestran cierre evidenciable?","result":"SI","type":null},
      {"clause":"§9.1","question":"¿Se monitorea el tiempo en recuperación y los criterios de egreso?","result":"SI","type":null},
      {"clause":"§10.2","question":"¿Los eventos posquirúrgicos adversos generan análisis causal documentado?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"mb","formacion_sgc":"mb","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"mb","actitud_claridad":"mb","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2025-018","descripcion":"Implementar escala de Aldrete como criterio obligatorio y documentado de egreso de recuperación posquirúrgica","responsable":"Jefe de Anestesiología / Jefe de Quirófano","fecha_compromiso":"2026-02-01","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-019","descripcion":"Programa de calibración y verificación cruzada de oxímetros y monitores cardíacos en recuperación","responsable":"Encargado de Mantenimiento Biomédico","fecha_compromiso":"2026-01-31","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2026-02-01","puntos_fuertes":"Cierre exitoso de NC-2025-001 y NC-2025-002. Lista de verificación OMS en 90%. Trazabilidad de esterilización mejorada.","potencial_mejora":"Protocolo de egreso de recuperación posquirúrgica, doble verificación de medicamentos de alto riesgo en pabellón.","quejas":"Dos eventos Graves en recuperación posquirúrgica (noviembre 2025).","auditorias_previas":"AI-2025-001 (mayo 2025) y AI-2025-003 (agosto 2025). NC-2025-001/002 cerradas.","revision_sistema":"Progreso satisfactorio en hallazgos previos. Nuevas NC relacionadas con recuperación posquirúrgica.","valoracion":"con_observaciones"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2025-007'
  ) WHERE year = 2025 AND month = 11 AND area = 'Quirófano';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2025-008 · Farmacia Hospitalaria · Diciembre 2025
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2025-008') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2025-008', 'programada',
    'Dra. Giselle De la Torre',
    '2025-12-11', '2025-12-11',
    'Preparación, dispensación, control de caducidades, medicamentos de alto riesgo y cadena de frío',
    'Dra. Giselle De la Torre',
    '["Farmacia Hospitalaria"]',
    'completada',
    'hallazgos_mayores',
    'La segunda auditoría a Farmacia documenta que las NC-2025-008 a NC-2025-011 tienen avance insuficiente. Nuevos eventos del período incluyen: desabasto de medicamento controlado sin respuesta oportuna de farmacia (2-Dic), proceso de receta en carbonato de calcio con actitud no colaborativa del personal (3-Dic), administración de ceftriaxona por orden verbal a paciente con alergia conocida (5-Dic) y administración de Kabivent (alto riesgo) por vía incorrecta con doble verificación deficiente (16-Dic). Se refuerzan NC mayores.',
    '2026-07-01',
    '[
      {"type":"NC_mayor","clause":"§8.5","description":"5-Dic-2025: Ceftriaxona 1 g IV administrada por orden verbal del anestesiólogo en quirófano a paciente con alergia conocida a cefalosporinas (interrogada por enfermería al ingreso). El proceso de verificación de alergias no se aplica en el circuito quirúrgico. La paciente presentó reacción alérgica que requirió hidrocortisona 500 mg. §8.5 / §7.5.","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"16-Dic-2025: Kabivent (nutrición parenteral, medicamento de alto riesgo) administrado por vía central cuando estaba indicado periférico. La etiqueta de la bolsa tenía un nombre diferente al de la hoja de enfermería. Doble verificación no realizada correctamente. El error se detectó hasta 24 h después con edema en brazo del paciente §8.5.","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.4","description":"2-Dic-2025: Desabasto de medicamento controlado sin respuesta de farmacia durante turno vespertino. Personal de enfermería notificó con anticipación sin obtener respuesta. No existe protocolo de gestión de desabasto ni listado de medicamentos de reserva crítica.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.5","description":"3-Dic-2025: Personal de farmacia se negó a contactar al médico tratante para receta de carbonato de calcio, argumentando que no es su función. El personal de guardia fue interrumpido con actitudes no colaborativas. No existe procedimiento claro de responsabilidades de comunicación entre farmacia y médicos §7.5.","status":"abierto"},
      {"type":"NC_menor","clause":"§8.7","description":"Las acciones correctivas NC-2025-008 a NC-2025-011 de septiembre 2025 tienen avance menor al 50% sin justificación documentada del retraso.","status":"abierto"}
    ]',
    '[
      {"clause":"§7.5","question":"¿Existe y se aplica el proceso de verificación de alergias antes de dispensar en quirófano?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.4","question":"¿Existe protocolo de gestión de desabasto de medicamentos críticos?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿Los medicamentos de alto riesgo (Kabivent, heparina, insulina) tienen doble verificación documentada?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿Se prohíben las órdenes verbales para medicamentos de alto riesgo o pacientes con alergias conocidas?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.7","question":"¿Las NC de septiembre 2025 tienen avance documentado ≥80%?","result":"NO","type":"NC_menor"},
      {"clause":"§9.1","question":"¿Se reporta mensualmente la tasa de errores de medicación al SGC?","result":"NO","type":"NC_menor"},
      {"clause":"§10.2","question":"¿Los eventos adversos de medicación generan análisis causal y acciones correctivas documentadas?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"b","formacion_sgc":"mb","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"mb","actitud_claridad":"mb","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2025-020","descripcion":"Implementar pulsera de alerta de alergia y verificación OBLIGATORIA antes de cualquier medicación en quirófano, incluso por orden verbal","responsable":"Jefa de Farmacia / Jefe de Quirófano","fecha_compromiso":"2026-02-15","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-021","descripcion":"Crear y difundir protocolo de gestión de desabasto: lista de medicamentos críticos, reserva de 72 h, notificación inmediata al médico de guardia","responsable":"Jefa de Farmacia","fecha_compromiso":"2026-02-01","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-022","descripcion":"Acelerar implementación de NC-2025-008 a NC-2025-011 con evidencia documental al área de calidad antes del 31-Ene-2026","responsable":"Jefa de Farmacia","fecha_compromiso":"2026-01-31","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2026-02-15","puntos_fuertes":"Farmacia con buena gestión de caducidades. Registros de temperatura de cadena de frío completos.","potencial_mejora":"Verificación de alergias en circuito quirúrgico, gestión de desabasto, protocolos de medicamentos de alto riesgo.","quejas":"Cuatro incidencias relevantes en diciembre 2025, incluyendo reacción alérgica por ceftriaxona y error de Kabivent.","auditorias_previas":"AI-2025-004 (septiembre 2025). NC-2025-008 a NC-2025-011 con avance insuficiente.","revision_sistema":"Se requiere presentación urgente a Dirección por recurrencia de errores de medicación de alto riesgo.","valoracion":"con_observaciones"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2025-008'
  ) WHERE year = 2025 AND month = 12 AND area = 'Farmacia Hospitalaria';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2025-009 · Imagenología / Laboratorio · Diciembre 2025
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2025-009') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2025-009', 'programada',
    'Dra. Giselle De la Torre',
    '2025-12-18', '2025-12-18',
    'Calidad en procesos diagnósticos, trazabilidad de resultados y registros de laboratorio e imagen',
    'Dra. Giselle De la Torre',
    '["Imagenología / Laboratorio"]',
    'completada',
    'hallazgos_menores',
    'La auditoría a Imagenología y Laboratorio documentó tiempos de respuesta inaceptables en estudios urgentes y omisiones en la toma de muestras. El electrocardiografo de planta baja lleva más de un mes fuera de servicio, y el de Urgencias sin papel por varios días (16-Dic-2025). Laboratorio omitió toma de muestras solicitadas al ingreso de paciente con insuficiencia respiratoria (8-Dic-2025). Se documentan NC menores; no se detectaron NC mayores en este ciclo.',
    '2026-08-01',
    '[
      {"type":"NC_menor","clause":"§7.1.5","description":"16-Dic-2025: Electrocardiografo de planta baja fuera de servicio por más de un mes; el de Urgencias sin papel por varios días. Médico tratante tuvo que solicitar el equipo de Terapia Intensiva para realizar ECG STAT, retrasando la atención. No existe protocolo de mantenimiento preventivo ni plan de contingencia para equipos de diagnóstico §7.1.5.","status":"abierto"},
      {"type":"NC_menor","clause":"§8.5","description":"8-Dic-2025: Laboratorio no realizó toma de muestras de ingreso a paciente con insuficiencia respiratoria solicitadas desde las 12:48. Las pruebas rápidas de COVID e influenza se procesaron dos veces. El personal de laboratorio no comunicó la omisión proactivamente. Retraso en diagnóstico de paciente en estado crítico.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.5","description":"9-Oct-2025: Resultado de sodio sérico requerido a las 02:30 h no disponible a las 05:00 h por \"exceso de carga laboral\" del único técnico nocturno. No existe procedimiento de escalamiento cuando el tiempo de procesamiento excede el límite clínico §7.5.","status":"abierto"},
      {"type":"Observacion","clause":"§9.1","description":"Múltiples reportes de retrasos >8 h en interpretación de estudios de imagen urgentes (TAC, RM, Rx) por un solo radiólogo disponible fuera de horario. Se recomienda establecer un SLA (Service Level Agreement) para tiempos de reporte de estudios urgentes.","status":"abierto"}
    ]',
    '[
      {"clause":"§7.1.5","question":"¿Los equipos de imagen y laboratorio cuentan con programa de mantenimiento preventivo documentado?","result":"NO","type":"NC_menor"},
      {"clause":"§7.1.5","question":"¿Existe plan de contingencia para equipo de diagnóstico fuera de servicio?","result":"NO","type":"NC_menor"},
      {"clause":"§7.5","question":"¿Los resultados de laboratorio urgentes se reportan dentro del tiempo definido?","result":"NO","type":"NC_menor"},
      {"clause":"§8.5","question":"¿Existe protocolo de toma y procesamiento de muestras urgentes con tiempos definidos?","result":"NO","type":"NC_menor"},
      {"clause":"§9.1","question":"¿Se monitorea el tiempo de reporte de estudios de imagen urgentes (SLA)?","result":"NO","type":"Observacion"},
      {"clause":"§10.2","question":"¿Las omisiones y retrasos documentados generan acciones correctivas?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"b","formacion_sgc":"b","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"b","actitud_claridad":"b","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2025-023","descripcion":"Implementar programa de mantenimiento preventivo para electrocardiógrafos y equipos de diagnóstico con plan de contingencia","responsable":"Encargado de Mantenimiento Biomédico","fecha_compromiso":"2026-02-28","evidencia":"","status":"pendiente"},
      {"nc":"NC-2025-024","descripcion":"Definir tiempos máximos de procesamiento de muestras urgentes (laboratorio) y de reporte de imagen (radiología) con protocolo de escalamiento","responsable":"Jefe de Imagenología / Jefe de Laboratorio","fecha_compromiso":"2026-02-28","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2026-02-28","puntos_fuertes":"Personal de laboratorio con disposición de reportar incidencias. Equipos de imagen en general funcionando adecuadamente.","potencial_mejora":"Mantenimiento preventivo de equipos, tiempos de reporte, personal suficiente en turno nocturno.","quejas":"Retraso diagnóstico documentado en octubre y diciembre 2025. ECG sin equipo disponible.","auditorias_previas":"Primera auditoría formal a Imagenología / Laboratorio.","revision_sistema":"Hallazgos incluidos en plan de mejora 2026 del SGC.","valoracion":"satisfactorio"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2025-009'
  ) WHERE year = 2025 AND month = 12 AND area = 'Imagenología / Laboratorio';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2026-001 · Admisión · Enero 2026
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2026-001') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2026-001', 'programada',
    'Dra. Giselle De la Torre',
    '2026-01-22', '2026-01-22',
    'Procesos administrativos §7.5 · Admisión y alta de pacientes · Verificación de alergias',
    'Dra. Giselle De la Torre',
    '["Admisión"]',
    'completada',
    'hallazgos_mayores',
    'La auditoría de seguimiento a Admisión evidencia avance insuficiente en las NC de noviembre 2025. Nuevos eventos relevantes: reinicio de Kabivent suspendido por enfermería que hizo caso omiso a la indicación del médico tratante (3-Ene), administración de metoclopramida a paciente alérgica (4-Ene, sin daño), confusión de KPO4 con KCl (electrolito de alto riesgo, Moderado, 13-Ene) y transfusión iniciada con resultados del paciente equivocado (5-Dic-2025, por error de comunicación). Se refuerzan NC mayores.',
    '2026-07-01',
    '[
      {"type":"NC_mayor","clause":"§8.5","description":"13-Ene-2026 (resultado Moderado): Enfermero preparó infusión de KCl (cloruro de potasio) en lugar de KPO4 (fosfato de potasio, indicado por médico tratante). El error se detectó 1 hora después de iniciada la infusión. El KCl es medicamento de alto riesgo; el error causó náuseas y vómitos al paciente. No existe protocolo de doble verificación de electrolitos de alto riesgo §8.5.","status":"abierto"},
      {"type":"NC_mayor","clause":"§7.5","description":"5-Dic-2025: Se enviaron resultados de laboratorio de paciente incorrecto al médico tratante, quien indicó una transfusión de paquete globular que fue cancelada cuando un médico de guardia detectó el error de nombre. Grave falla de trazabilidad e identificación de muestras §7.5.3.","status":"abierto"},
      {"type":"NC_menor","clause":"§8.5","description":"4-Ene-2026: Se administró metoclopramida a paciente alérgica; al ingreso, el familiar que acompañaba en ese momento reportó una alergia que no había sido declarada previamente. No existe un proceso de actualización dinámica de alergias durante la estancia §8.5.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.5","description":"3-Ene-2026: Enfermería ignoró la indicación expresa del médico tratante de suspender Kabivent al término del frasco y reinició uno nuevo. La indicación estaba disponible en foto y por escrito. Falla en revisión de indicaciones vigentes en cada turno §7.5.","status":"abierto"},
      {"type":"NC_menor","clause":"§8.7","description":"Las NC-2025-015 a NC-2025-017 (noviembre 2025, protocolo SBAR y verificación de alergias) tienen avance documentado insuficiente al momento de la auditoría.","status":"abierto"}
    ]',
    '[
      {"clause":"§7.5","question":"¿Los procesos de identificación de pacientes y muestras tienen mecanismos de doble verificación?","result":"NO","type":"NC_mayor"},
      {"clause":"§7.5","question":"¿Las indicaciones médicas vigentes son revisadas en cada cambio de turno por enfermería?","result":"NO","type":"NC_menor"},
      {"clause":"§8.5","question":"¿Los electrolitos de alto riesgo (KCl, KPO4, NaCl concentrado) tienen preparación con doble verificación?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿El registro de alergias se actualiza durante la estancia cuando el paciente o familiar aporta nueva información?","result":"NO","type":"NC_menor"},
      {"clause":"§8.7","question":"¿Las NC-2025-015 a NC-2025-017 tienen avance documentado y evidenciable ≥70%?","result":"NO","type":"NC_menor"},
      {"clause":"§9.1","question":"¿Se monitorean indicadores de seguridad del paciente en admisión?","result":"SI","type":null},
      {"clause":"§10.2","question":"¿Los eventos adversos de admisión generan acciones correctivas con seguimiento?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"b","formacion_sgc":"mb","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"mb","actitud_claridad":"b","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2026-001","descripcion":"Implementar protocolo de doble verificación OBLIGATORIA para electrolitos concentrados (KCl, KPO4, NaCl 17.7%) con etiquetado de alto riesgo en farmacia","responsable":"Jefa de Farmacia / Jefa de Enfermería","fecha_compromiso":"2026-03-15","evidencia":"","status":"pendiente"},
      {"nc":"NC-2026-002","descripcion":"Implementar proceso de doble identificación de muestras de laboratorio (pulsera + etiqueta + confirmación verbal) para evitar errores de paciente","responsable":"Jefe de Laboratorio","fecha_compromiso":"2026-03-01","evidencia":"","status":"pendiente"},
      {"nc":"NC-2026-003","descripcion":"Reactivar y certificar avance de NC-2025-015 (SBAR), NC-2025-016 (alto riesgo) y NC-2025-017 (alergias) con evidencia documental antes del 28-Feb-2026","responsable":"Jefa de Admisión / Responsable de Calidad","fecha_compromiso":"2026-02-28","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2026-03-15","puntos_fuertes":"Personal de admisión atento a cambios de indicaciones. Sistema de registro de pacientes funcional.","potencial_mejora":"Doble verificación de electrolitos de alto riesgo, identificación de muestras, actualización dinámica de alergias.","quejas":"Error de KCl/KPO4 (Moderado), transfusión por resultados de paciente incorrecto, reinicio de Kabivent suspendido.","auditorias_previas":"AI-2025-006 (noviembre 2025). NC-2025-015 a NC-2025-017 con avance insuficiente.","revision_sistema":"Hallazgos reportados al Comité de Seguridad del Paciente y a Revisión por la Dirección Q1-2026.","valoracion":"con_observaciones"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2026-001'
  ) WHERE year = 2026 AND month = 1 AND area = 'Admisión';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2026-002 · Urgencias · Febrero 2026
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2026-002') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2026-002', 'programada',
    'Dra. Giselle De la Torre',
    '2026-02-26', '2026-02-26',
    'Seguimiento hallazgos 2025 · Triage, tiempos y protocolos de urgencia · Seguridad perioperatoria',
    'Dra. Giselle De la Torre',
    '["Urgencias"]',
    'completada',
    'hallazgos_menores',
    'La segunda auditoría a Urgencias documenta avance en las NC de octubre 2025 (NC-2025-012, NC-2025-013, NC-2025-014). Se detectan NC menores nuevas: gasa olvidada en área anal durante cirugía de cadera (18-Feb, 22 h sin retiro), omisión de registros de enfermería en una paciente hospitalizada (18-Feb) y administración de ceftriaxona a paciente alérgica durante cirugía por falla de comunicación entre anestesióloga y enfermería (20-Feb, Moderado). La enfermera en urgencias no respondió oportunamente a edema pulmonar agudo (15-Mar, sin daño).',
    '2026-08-01',
    '[
      {"type":"NC_menor","clause":"§8.5","description":"18-Feb-2026: Gasa colocada en área anal durante cirugía de cadera (paciente García Yepiz) para control de evacuaciones; la enfermera en recuperación no ejecutó la indicación verbal del médico tratante de retirarla al egreso. La gasa permaneció 22 horas. Falla en comunicación y verificación de indicaciones post-procedimiento §8.5.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.5","description":"18-Feb-2026: Paciente asegurada (JP-09) sin pase de ronda de enfermería nocturno, sin toma de signos vitales, sin reporte de enfermería y sin registro en hoja de dieta. La omisión fue detectada en el turno matutino. Falla grave en la documentación clínica continua §7.5.","status":"abierto"},
      {"type":"NC_menor","clause":"§8.5","description":"20-Feb-2026 (resultado Moderado): Paciente García Yepiz recibió ceftriaxona IV en quirófano, siendo alérgica a cefalosporinas según hoja de enfermería. La anestesióloga tenía registrada alergia a sulfas en su hoja. Discordancia no resuelta; paciente presentó reacción alérgica tratada con dexametasona §8.5 / §7.5.","status":"abierto"},
      {"type":"Observacion","clause":"§8.7","description":"NC-2025-012 (caídas), NC-2025-013 (carro rojo) y NC-2025-014 (dispositivos): muestran avance del 60-70%. Se documentan capacitaciones realizadas pero sin evidencia completa de implementación en todos los turnos.","status":"abierto"}
    ]',
    '[
      {"clause":"§7.5","question":"¿Los registros de enfermería (pase de ronda, signos vitales) se realizan en todos los pacientes y turnos?","result":"NO","type":"NC_menor"},
      {"clause":"§8.5","question":"¿Las indicaciones postoperatorias verbales se transcriben y verifican en el proceso de egreso de recuperación?","result":"NO","type":"NC_menor"},
      {"clause":"§8.5","question":"¿La información de alergias está unificada en todos los documentos del expediente (enfermería, médico, anestesia)?","result":"NO","type":"NC_menor"},
      {"clause":"§8.7","question":"¿Las NC-2025-012 a NC-2025-014 tienen implementación verificable en todos los turnos?","result":"NO","type":"Observacion"},
      {"clause":"§9.1","question":"¿Se monitorea el tiempo de respuesta de enfermería ante urgencias documentadas?","result":"SI","type":null},
      {"clause":"§10.2","question":"¿Los eventos adversos de urgencias generan análisis causal y corrección documentada?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"mb","formacion_sgc":"mb","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"mb","actitud_claridad":"mb","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2026-004","descripcion":"Unificar el registro de alergias en un documento único del expediente clínico; enfermería, médico tratante y anestesia deben verificar y firmar el mismo campo de alergias","responsable":"Responsable de Calidad / Jefe de Urgencias","fecha_compromiso":"2026-04-30","evidencia":"","status":"pendiente"},
      {"nc":"NC-2026-005","descripcion":"Complementar la evidencia de implementación de NC-2025-012 a NC-2025-014 en todos los turnos con actas de capacitación firmadas","responsable":"Jefe de Urgencias / Jefa de Enfermería","fecha_compromiso":"2026-04-15","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2026-04-30","puntos_fuertes":"Avance significativo en NC de octubre 2025. Cultura de reporte bien establecida en urgencias.","potencial_mejora":"Unificación de registro de alergias, documentación completa de enfermería, comunicación postoperatoria.","quejas":"Gasa olvidada 22 h, omisión de registros nocturnos y reacción alérgica por discordancia en expediente (Feb 2026).","auditorias_previas":"AI-2025-005 (octubre 2025). NC-2025-012 a NC-2025-014 con avance 60-70%.","revision_sistema":"Progreso aceptable. Se requiere completar evidencia de implementación antes de próxima auditoría.","valoracion":"satisfactorio"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2026-002'
  ) WHERE year = 2026 AND month = 2 AND area = 'Urgencias';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2026-003 · Enfermería / Hospitalización · Marzo 2026
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2026-003') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2026-003', 'programada',
    'Dra. Giselle De la Torre',
    '2026-03-26', '2026-03-26',
    'Cuidados de enfermería, registros clínicos, procedimientos y seguridad del paciente §8.5',
    'Dra. Giselle De la Torre',
    '["Enfermería / Hospitalización"]',
    'completada',
    'hallazgos_mayores',
    'Primera auditoría formal a Enfermería y Hospitalización, el mes con mayor número de eventos adversos del período analizado (25 reportes). Los hallazgos más graves incluyen: muerte de paciente ventilado (26-Mar-2026) relacionada con apagado del ventilador sin verificación de signos vitales; error LASA de cefotaxima por cefuroxima (25-Mar, medicamento de alto riesgo no preparado); administración de albúmina por vía de norepinefrina causando colapso hemodinámico en dos oportunidades (4-Mar y 6-Mar, una Moderada); y múltiples omisiones de medicamentos y glucemias. Se emiten NC mayores en 4 cláusulas.',
    '2026-09-01',
    '[
      {"type":"NC_mayor","clause":"§8.5","description":"26-Mar-2026 (resultado MUERTE): Enfermera Sandy apagó el ventilador mecánico de paciente (León Huerta, 79 años, cuidados paliativos) al interpretar erróneamente una indicación telefónica del médico interconsultante, cuando el paciente aún presentaba frecuencia cardíaca y respiratoria en monitor. No existe protocolo escrito de retiro de soporte vital ni de doble verificación médica antes de apagar dispositivos críticos. §8.5 §10.2","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"4-Mar y 6-Mar-2026 (Moderada): Enfermero administró albúmina por la misma vía de norepinefrina en bomba de infusión continua, causando bolo accidental de norepinefrina (hipertensión 160/100) seguido de hipotensión (55/30 → 35/20) al quedar la vía con residuo de albúmina. Evento altamente mortal según los reportes. El error se repitió dos días después en el mismo servicio §8.5.","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"25-Mar-2026: Error LASA — enfermera preparó cefotaxima en lugar de cefuroxima (Look-Alike Sound-Alike). El error fue detectado antes de su administración. No existe lista de medicamentos LASA disponible en el servicio de hospitalización ni verificación al preparar antibióticos §8.5.","status":"abierto"},
      {"type":"NC_mayor","clause":"§7.2","description":"Múltiples omisiones de medicamentos documentadas a lo largo de marzo 2026: dexametasona (5-Mar y 7-Mar), eritropoyetina (6-Mar), glucemias capilares (17-Mar), antibióticos (18-Mar), medicamento suspendido administrado (21-Mar). Patrón sistemático de falta de verificación de hojas de enfermería. Indica deficiencia en formación y supervisión §7.2.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.5","description":"Múltiples registros de enfermería incompletos o erróneos: frecuencia respiratoria de 17 registrada como frecuencia cardíaca (30-Ene-2026), toma de laboratoriales firmada como realizada sin haberse hecho (14-Mar), indicaciones de toma de muestra a las 6 am transcritas como AM sin hora específica. Patrón recurrente de llenado deficiente de documentación clínica §7.5.","status":"abierto"},
      {"type":"NC_menor","clause":"§9.1","description":"No existe indicador de tasa de omisión de medicamentos por turno ni mecanismo de supervisión diferencial por turno (el turno nocturno B presenta el mayor número de incidencias). Sin datos para la Revisión por la Dirección §9.1.","status":"abierto"}
    ]',
    '[
      {"clause":"§7.2","question":"¿El personal de enfermería cuenta con competencias verificadas para el manejo de dispositivos críticos (ventiladores, bombas)?","result":"NO","type":"NC_mayor"},
      {"clause":"§7.2","question":"¿Existe programa de capacitación continua documentado para el personal de enfermería?","result":"NO","type":"NC_mayor"},
      {"clause":"§7.5","question":"¿Los registros de enfermería (administración, signos vitales, evolución) son completos y precisos?","result":"NO","type":"NC_menor"},
      {"clause":"§8.5","question":"¿Existe protocolo escrito de retiro o apagado de soporte vital con doble verificación médica?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿Existe lista de medicamentos LASA en el servicio de hospitalización y se aplica en la preparación?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿Las vías de acceso vascular están etiquetadas y el personal conoce el protocolo de incompatibilidades?","result":"NO","type":"NC_mayor"},
      {"clause":"§9.1","question":"¿Existe indicador de tasa de omisión de medicamentos y supervisión diferencial por turno?","result":"NO","type":"NC_menor"},
      {"clause":"§10.2","question":"¿Los eventos adversos se analizan con causa raíz y se generan acciones preventivas?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"b","formacion_sgc":"b","formacion_iso19011":"b","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"b","actitud_claridad":"b","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2026-006","descripcion":"Elaborar e implementar protocolo escrito de retiro de soporte vital con doble verificación médica obligatoria (dos médicos presentes o confirmación directa y documentada)","responsable":"Dirección Médica / Responsable de Calidad","fecha_compromiso":"2026-05-15","evidencia":"","status":"pendiente"},
      {"nc":"NC-2026-007","descripcion":"Publicar lista de medicamentos LASA en todas las áreas de preparación de enfermería y capacitar al personal en identificación visual y verbal","responsable":"Jefa de Enfermería / Jefa de Farmacia","fecha_compromiso":"2026-05-01","evidencia":"","status":"pendiente"},
      {"nc":"NC-2026-008","descripcion":"Implementar protocolo de incompatibilidades de vías IV con etiquetado obligatorio de cada lumen (nombre del medicamento + concentración)","responsable":"Jefa de Enfermería","fecha_compromiso":"2026-05-01","evidencia":"","status":"pendiente"},
      {"nc":"NC-2026-009","descripcion":"Desarrollar programa de capacitación trimestral para enfermería: 10 correctos, LASA, registros clínicos, manejo de dispositivos. Con evaluación escrita y acta de capacitación.","responsable":"Jefa de Enseñanza / Jefa de Enfermería","fecha_compromiso":"2026-06-30","evidencia":"","status":"pendiente"},
      {"nc":"NC-2026-010","descripcion":"Establecer indicador de tasa de omisión de medicamentos por turno con revisión semanal por supervisión de enfermería","responsable":"Jefa de Enfermería","fecha_compromiso":"2026-05-31","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2026-05-15","puntos_fuertes":"Alta cultura de reporte de eventos adversos. Personal comprometido con la notificación. Intervenciones oportunas de médicos de guardia evitaron consecuencias peores en la mayoría de los casos.","potencial_mejora":"Protocolos de soporte vital, manejo de vías IV, lista LASA, registros clínicos y programa de capacitación continua.","quejas":"25 eventos adversos en marzo 2026, incluyendo 1 muerte vinculada a manejo de ventilador y colapso hemodinámico por error de vía IV.","auditorias_previas":"Primera auditoría formal al área de Enfermería / Hospitalización.","revision_sistema":"URGENTE: hallazgos presentados a Dirección Médica y Comité de Seguridad del Paciente. Se solicita Revisión Extraordinaria por la Dirección.","valoracion":"con_observaciones"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2026-003'
  ) WHERE year = 2026 AND month = 3 AND area = 'Enfermería / Hospitalización';
END IF;

-- ──────────────────────────────────────────────────────────────
-- AI-2026-004 · Quirófano · Abril 2026
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.auditorias_internas WHERE audit_number = 'AI-2026-004') THEN
  INSERT INTO public.auditorias_internas (
    audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
    scope, lead_auditor, areas, status, audit_result, conclusion,
    next_audit_date,
    findings, checklist, evaluaciones, actuaciones, reunion_final
  ) VALUES (
    'AI-2026-004', 'programada',
    'Dra. Giselle De la Torre',
    '2026-04-23', '2026-04-23',
    'Procesos quirúrgicos, seguridad e infraestructura. Seguimiento hallazgos abril 2026 §8.5 §8.7',
    'Dra. Giselle De la Torre',
    '["Quirófano"]',
    'completada',
    'hallazgos_mayores',
    'La cuarta auditoría a Quirófano documenta avance en NC-2025-018 (escala de Aldrete) y NC-2025-019 (calibración de equipos). Se detectan NC mayores nuevas: paciente inestable (urgencia dialítica) impedida para colocación de catéter por falta de autorización de sala de rayos X y supervisión de enfermería no colaborativa (1-Abr-2026), y manejo de CVC de paciente sin técnica de barrera máxima por material insuficiente proporcionado por enfermería (3-Abr-2026). Se documenta patrón de conflicto de roles entre enfermería y médicos tratantes.',
    '2026-10-01',
    '[
      {"type":"NC_mayor","clause":"§8.5","description":"1-Abr-2026: Paciente en urgencia dialítica (Ávalos López, 64 años) fue obstaculizada para la colocación de catéter tunelizado y CVC: supervisión de enfermería se negó a autorizar sala de rayos X disponible. La paciente presentó TA 49/20 en hemodiálisis sin baumanómetro pediátrico disponible (supervisoras sin respuesta). Monitor cardíaco colocado pero apagado a las 8:06. Falla sistémica en disposición de recursos para paciente inestable §8.5 §7.1.","status":"abierto"},
      {"type":"NC_mayor","clause":"§8.5","description":"3-Abr-2026: Manejo de sitio de inserción de CVC con fuga realizado por médico de guardia sin técnica de barrera máxima, sin limpieza adecuada y con material incompleto proporcionado por enfermería. Se corrigió posteriormente, pero el primer manejo sin técnica correcta expone al paciente a infección asociada a catéter §8.5 / NOM-022.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.1","description":"1-Abr-2026: No se contaba con baumanómetro pediátrico disponible para paciente caquéctica; ninguna supervisora respondió el teléfono en turno nocturno. El hospital no tiene definido un protocolo de disponibilidad de recursos mínimos en turno nocturno para pacientes inestables §7.1.","status":"abierto"},
      {"type":"NC_menor","clause":"§7.2","description":"Patrón documentado en múltiples reportes: personal de enfermería cuestiona o se niega a ejecutar decisiones médicas (colocación de monitor cardíaco, acceso a sala de rayos X, cambio de apósito). No existe definición formal de roles y límites de competencia entre médicos y enfermería §7.2.","status":"abierto"},
      {"type":"Observacion","clause":"§8.7","description":"NC-2025-018 (Aldrete): implementada y verificada al 85%. NC-2025-019 (calibración de equipos): programa en marcha, oxímetros y monitores con calibración documentada al 90%.","status":"cerrado"}
    ]',
    '[
      {"clause":"§7.1","question":"¿Los recursos (salas, equipos, baumanómetros) están disponibles las 24 h para pacientes inestables?","result":"NO","type":"NC_menor"},
      {"clause":"§7.2","question":"¿Están definidos y documentados los roles y competencias de médicos y enfermería en procedimientos invasivos?","result":"NO","type":"NC_menor"},
      {"clause":"§8.5","question":"¿Los procedimientos de manejo de dispositivos vasculares (CVC) se realizan con técnica de barrera máxima obligatoria?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.5","question":"¿El acceso a salas de procedimientos para pacientes en urgencia está protocolizado y libre de barreras administrativas?","result":"NO","type":"NC_mayor"},
      {"clause":"§8.7","question":"¿NC-2025-018 (Aldrete) y NC-2025-019 (calibración) muestran avance ≥80% verificable?","result":"SI","type":null},
      {"clause":"§9.1","question":"¿Se monitorea la tasa de infecciones asociadas a dispositivos vasculares?","result":"SI","type":null},
      {"clause":"§10.2","question":"¿Los eventos adversos quirúrgicos generan acciones correctivas con seguimiento documentado?","result":"SI","type":null}
    ]',
    '[
      {"auditor":"Dra. Giselle De la Torre","formacion_iso9001":"mb","formacion_sgc":"mb","formacion_iso19011":"mb","formacion_otros":"na","actitud_horario":"e","actitud_preguntas":"mb","actitud_respeto":"e","actitud_manejo":"mb","actitud_claridad":"mb","resultado":"Competente"}
    ]',
    '[
      {"nc":"NC-2026-011","descripcion":"Documentar protocolo de acceso a salas de procedimientos para pacientes en urgencia (prioridad clínica sobre criterios administrativos) con firma de Dirección Médica","responsable":"Dirección Médica / Jefe de Quirófano","fecha_compromiso":"2026-06-15","evidencia":"","status":"pendiente"},
      {"nc":"NC-2026-012","descripcion":"Implementar protocolo NOM-022 de manejo de sitios de inserción de CVC con carros de procedimiento completos y verificados; capacitar a enfermería y médicos de guardia","responsable":"Jefe de Quirófano / Jefa de Enfermería","fecha_compromiso":"2026-06-30","evidencia":"","status":"pendiente"},
      {"nc":"NC-2026-013","descripcion":"Definir documento formal de delimitación de roles y competencias médico-enfermería en procedimientos invasivos, con capacitación a supervisoras de enfermería","responsable":"Dirección Médica / Jefa de Enfermería","fecha_compromiso":"2026-06-30","evidencia":"","status":"pendiente"}
    ]',
    '{"fecha_compromiso":"2026-06-30","puntos_fuertes":"Avance satisfactorio en NC-2025-018 (Aldrete 85%) y NC-2025-019 (calibración 90%). Lista de verificación OMS en 93%.","potencial_mejora":"Protocolos de acceso a salas en urgencias, técnica de barrera en CVC, disponibilidad de recursos nocturnos, delimitación de roles.","quejas":"Paciente en urgencia dialítica obstaculizada por enfermería; manejo de CVC sin técnica adecuada.","auditorias_previas":"AI-2025-001, AI-2025-003, AI-2025-007. NC previas con buen avance.","revision_sistema":"Progreso positivo en hallazgos históricos. Nuevas NC relacionadas con conflicto de roles médico-enfermería.","valoracion":"con_observaciones"}'
  );
  UPDATE public.plan_anual_auditorias SET auditoria_id = (
    SELECT id FROM public.auditorias_internas WHERE audit_number = 'AI-2026-004'
  ) WHERE year = 2026 AND month = 4 AND area = 'Quirófano';
END IF;

END $$;
