-- ============================================================
-- Seed de Contexto Organizacional — MA-CA-01 Ver. 6
-- Cláusula 4 ISO 9001:2015 — Hospital Santa Margarita
-- Ejecutar en Supabase → SQL Editor
-- Solo inserta si la tabla está vacía (seguro ejecutar varias veces)
-- ============================================================

-- ══════════════════════════════════════════════════════════════
-- 1. ALCANCE Y EXCLUSIONES (sgc_context)
-- ══════════════════════════════════════════════════════════════
INSERT INTO public.sgc_context (
  scope_declaration,
  scope_justification,
  exclusions
)
SELECT
  'El Sistema de Gestión de la Calidad del Hospital Santa Margarita aplica a la prestación de servicios de atención médico-quirúrgica integrales y servicios auxiliares de diagnóstico, tratamiento y paramédicos brindados en sus instalaciones de Guadalajara, Jalisco.',
  'El alcance fue definido considerando las cuestiones externas e internas del contexto organizacional (§4.1), los requisitos de las partes interesadas (§4.2), y los productos y servicios de la organización. El alcance se mantiene como información documentada y está disponible para las partes interesadas pertinentes.',
  '[{"clause":"8.3 — Diseño y desarrollo de los productos y servicios","justification":"El Hospital Santa Margarita no realiza actividades de diseño y desarrollo de productos o servicios propios. Los servicios que se ofrecen están definidos conforme a los lineamientos y disposiciones oficiales emitidos por la Secretaría de Salud, las autoridades sanitarias competentes y las políticas institucionales. El hospital se dedica a la prestación, supervisión y mejora continua de los servicios de atención médica, docencia e investigación, dentro del marco de los procesos ya establecidos, sin generar diseños originales o desarrollos de nuevos productos o servicios."}]'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.sgc_context LIMIT 1);

-- ══════════════════════════════════════════════════════════════
-- 2. ANÁLISIS FODA (swot_analyses)
-- ══════════════════════════════════════════════════════════════
INSERT INTO public.swot_analyses (
  strengths,
  weaknesses,
  opportunities,
  threats,
  analysis_date
)
SELECT
  -- FORTALEZAS
  '["Imagen, trayectoria y prestigio institucional en la atención médica privada.",
    "Capacidad resolutiva para la atención de pacientes ambulatorios, quirúrgicos y hospitalizados.",
    "Oferta de diversas especialidades médicas que fortalecen la captación y continuidad de pacientes.",
    "Equipo electromédico y tecnología hospitalaria que permiten brindar atención oportuna y segura.",
    "Compromiso de la alta dirección con la mejora continua, calidad y seguridad del paciente.",
    "Atención personalizada, trato digno y humanizado al paciente y su familia.",
    "Competitividad en precios frente a otros hospitales privados de mayor escala.",
    "Ubicación geográfica favorable para la referencia de pacientes.",
    "Capacidad de generar ingresos directos por servicios privados, procedimientos quirúrgicos y hospitalización.",
    "Avance en la implementación y fortalecimiento del Sistema de Gestión de Calidad bajo enfoque ISO 9001:2015.",
    "Mayor sensibilización institucional hacia la gestión de riesgos, eventos adversos, quejas y satisfacción del usuario.",
    "Existencia de áreas estratégicas para el control operativo: farmacia hospitalaria, enfermería, admisión, quirófano, urgencias, imagenología y hospitalización."]',
  -- DEBILIDADES
  '["Variabilidad en la señalética institucional y necesidad de homologación visual en áreas clínicas, administrativas y de atención al usuario.",
    "Sistematización parcial de procesos, con áreas que requieren mayor estandarización documental y operativa.",
    "Necesidad de reforzar el proceso de triage, priorización clínica y trazabilidad de la atención en urgencias.",
    "Competencias heterogéneas en personal no clínico respecto a atención al usuario, seguridad del paciente, confidencialidad y procesos institucionales.",
    "Antigüedad del inmueble, con requerimientos continuos de mantenimiento preventivo, correctivo y adecuaciones normativas.",
    "Comunicación interna no siempre efectiva entre turnos, áreas clínicas, áreas administrativas y servicios de apoyo.",
    "Rotación del personal de enfermería y necesidad de fortalecer estrategias de retención, inducción, capacitación y supervisión.",
    "Recursos financieros limitados frente a hospitales privados de mayor infraestructura y posicionamiento comercial.",
    "Necesidad de fortalecer la cultura de reporte, análisis y seguimiento de incidentes, eventos adversos y cuasifallas.",
    "Variabilidad en el cumplimiento documental de expedientes clínicos, registros de enfermería, consentimientos informados y formatos institucionales.",
    "Oportunidad de mejora en la evaluación, selección y reevaluación de proveedores críticos.",
    "Necesidad de fortalecer indicadores por servicio, tableros de control, análisis de causa raíz y acciones correctivas documentadas.",
    "Dependencia de algunos procesos manuales que limitan la trazabilidad, oportunidad y análisis de información."]',
  -- OPORTUNIDADES
  '["Incremento en la demanda de servicios de salud privada derivado de la saturación, tiempos de espera e insatisfacción en algunos sectores del sistema público.",
    "Crecimiento de la población con seguros de gastos médicos mayores y convenios institucionales.",
    "Fortalecimiento de convenios con aseguradoras, empresas, médicos tratantes y redes de referencia.",
    "Posibilidad de consolidar la certificación o recertificación de calidad como diferenciador competitivo.",
    "Implementación progresiva de expediente clínico electrónico, tableros digitales e indicadores automatizados.",
    "Desarrollo de estrategias de experiencia del paciente, satisfacción del usuario y gestión de quejas como valor agregado institucional.",
    "Mayor posicionamiento mediante campañas de comunicación, reputación digital y promoción de especialidades estratégicas.",
    "Profesionalización del personal mediante programas de capacitación continua en calidad, seguridad del paciente, normatividad y trato digno.",
    "Estandarización de procesos críticos conforme a ISO 9001:2015, Normas Oficiales Mexicanas y estándares del Consejo de Salubridad General.",
    "Fortalecimiento de la gestión de riesgos clínicos, administrativos, operativos, financieros y reputacionales.",
    "Aprovechamiento de avances tecnológicos accesibles para mejorar productividad, control de insumos, seguridad medicamentosa y continuidad de la atención.",
    "Desarrollo de alianzas académicas, médicas y empresariales que favorezcan captación de pacientes y mejora operativa."]',
  -- AMENAZAS
  '["Competencia creciente de hospitales privados, clínicas especializadas y centros quirúrgicos ambulatorios en la zona metropolitana de Guadalajara.",
    "Incremento sostenido en costos de medicamentos, material de curación, insumos quirúrgicos, mantenimiento y servicios subrogados.",
    "Retraso en pagos por parte de aseguradoras, convenios o clientes particulares, afectando flujo financiero.",
    "Inseguridad de la zona o percepción de riesgo que pudiera impactar la confianza de pacientes, familiares y colaboradores.",
    "Eventos naturales, contingencias epidemiológicas, pandemias o emergencias sanitarias que alteren la operación hospitalaria.",
    "Cambios regulatorios o incremento en exigencias por parte de autoridades sanitarias, protección civil, COFEPRIS/COPRISJAL y otros entes verificadores.",
    "Riesgo reputacional derivado de quejas, eventos adversos, fallas en identificación del paciente, tiempos de espera o comunicación deficiente.",
    "Escasez o rotación de talento especializado en enfermería, farmacia, áreas críticas y personal médico.",
    "Presión económica por actualización tecnológica, mantenimiento de infraestructura y cumplimiento normativo.",
    "Dependencia de proveedores críticos y riesgo de desabasto de medicamentos, insumos o servicios indispensables.",
    "Mayor exigencia de los pacientes respecto a calidad, seguridad, oportunidad, transparencia y experiencia de atención.",
    "Riesgo de sanciones, observaciones o restricciones operativas ante incumplimientos documentales, sanitarios o de seguridad hospitalaria."]',
  '2026-01-26'
WHERE NOT EXISTS (SELECT 1 FROM public.swot_analyses LIMIT 1);

-- ══════════════════════════════════════════════════════════════
-- 3. PARTES INTERESADAS (interested_parties)
-- ══════════════════════════════════════════════════════════════
-- Agrega columnas faltantes si la tabla fue creada antes de la versión actual del JS
ALTER TABLE public.interested_parties
  ADD COLUMN IF NOT EXISTS needs             TEXT,
  ADD COLUMN IF NOT EXISTS expectations      TEXT,
  ADD COLUMN IF NOT EXISTS monitoring_method TEXT;

-- Solo inserta si la tabla está vacía
INSERT INTO public.interested_parties (name, type, needs, expectations, monitoring_method, is_active)
SELECT name, type, needs, expectations, monitoring_method, true
FROM (VALUES
  -- ── GRUPO 1: Externas — Pacientes y Proveedores ──────────────────────────
  ('Pacientes', 'externo',
   'Atención médica segura y de calidad.',
   'Seguridad en la atención; trato digno; información clara.',
   'Encuestas de satisfacción; indicadores de seguridad; registro de quejas.'),
  ('Familiares de pacientes', 'externo',
   'Comunicación oportuna y trato respetuoso durante la hospitalización.',
   'Comodidad y comunicación oportuna.',
   'Encuestas, reportes de atención y comunicación clínica.'),
  ('Atención al Usuario / Coordinación de Quejas y Sugerencias', 'externo',
   'Canales efectivos para presentar quejas, sugerencias y felicitaciones.',
   'Respuesta oportuna a quejas y mejora de la experiencia del paciente.',
   'Registro de quejas; indicadores de resolución; encuestas.'),
  ('Proveedores de insumos críticos', 'externo',
   'Procesos de compra claros, pago oportuno y evaluación justa.',
   'Pago oportuno y procesos de compra claros.',
   'Contratos, órdenes de compra y evaluación de proveedores.'),
  -- ── GRUPO 2: Internas ────────────────────────────────────────────────────
  ('Personal del hospital (en general)', 'interno',
   'Capacitación continua, ambiente laboral seguro y pago oportuno.',
   'Condiciones laborales seguras, reconocimiento y desarrollo profesional.',
   'Encuestas de clima laboral; registros de capacitación; nómina y controles de RH.'),
  ('Dirección General', 'interno',
   'Liderazgo estratégico, resultados operativos y cumplimiento normativo y financiero.',
   'Información oportuna para la toma de decisiones y cumplimiento de objetivos.',
   'Reuniones de dirección; informes trimestrales; auditorías internas.'),
  ('Dirección Médica', 'interno',
   'Supervisión clínica y calidad asistencial.',
   'Procesos clínicos estandarizados y personal médico competente.',
   'Indicadores clínicos; auditorías clínicas; seguimiento de eventos adversos.'),
  ('Junta Directiva', 'interno',
   'Gobernanza, transparencia y cumplimiento de objetivos institucionales.',
   'Rendición de cuentas y sustentabilidad institucional.',
   'Reportes anuales; actas de sesión; revisiones de desempeño.'),
  ('Jefatura de Enfermería', 'interno',
   'Cuidado seguro del paciente y gestión del personal de enfermería.',
   'Dotación de personal suficiente y capacitado; insumos disponibles.',
   'Indicadores de enfermería; registros de capacitación; auditorías de prácticas seguras.'),
  ('Jefes de Servicio (Quirófano, Urgencias, Hospitalización, Imagenología, Laboratorio)', 'interno',
   'Gestión operacional del servicio y calidad de atención.',
   'Recursos suficientes y procesos estandarizados por servicio.',
   'Reuniones de servicio; indicadores por servicio; planes de mejora.'),
  ('Médicos tratantes (externos con convenio)', 'interno',
   'Atención integral, tecnología y soporte clínico para sus pacientes.',
   'Disponibilidad de insumos, equipos y soporte administrativo.',
   'Reuniones clínicas, indicadores de calidad y disponibilidad de insumos.'),
  ('Comités internos (COCASEP, Calidad, Infecciones, Farmacia y Terapéutica, Bioética, Mortalidad)', 'interno',
   'Gobernanza técnica y revisión de indicadores clínicos y de calidad.',
   'Información oportuna para la toma de decisiones técnicas.',
   'Actas de comité; planes de mejora; seguimiento de acuerdos.'),
  ('Farmacia Hospitalaria', 'interno',
   'Suministro seguro de medicamentos y farmacovigilancia.',
   'Abasto oportuno de medicamentos y cumplimiento normativo.',
   'Registros de inventario; reconciliaciones; reportes de farmacovigilancia.'),
  ('Laboratorio Clínico', 'interno',
   'Resultados oportunos y confiables con control de calidad.',
   'Equipos calibrados, reactivos disponibles y personal capacitado.',
   'Controles internos; EQA; bitácoras de calibración.'),
  ('Imagenología', 'interno',
   'Imágenes diagnósticas oportunas y protección radiológica.',
   'Equipos funcionales y protección para el personal.',
   'Registros de control de dosis; mantenimiento; indicadores TAT.'),
  ('Central de Esterilización (CEyE)', 'interno',
   'Procesos de esterilización validados y trazabilidad.',
   'Equipos de esterilización en buen estado y suministro oportuno de material.',
   'Registros de ciclos; controles biológicos; mantenimiento de autoclaves.'),
  ('Banco de Sangre', 'interno',
   'Disponibilidad de hemocomponentes seguros y trazables.',
   'Cumplimiento de NOM-253-SSA1-2012 y abasto confiable.',
   'Unidades captadas y transfundidas; controles de calidad; reportes al CETS.'),
  ('Admisión', 'interno',
   'Proceso eficiente de admisión y manejo adecuado de datos del paciente.',
   'Sistemas de cómputo estables y procesos claros de registro.',
   'Formatos de admisión; auditorías de expediente; encuestas de satisfacción.'),
  ('Archivo Clínico / Expediente Clínico', 'interno',
   'Integridad y confidencialidad del expediente clínico.',
   'Espacio adecuado, sistemas de resguardo y acceso controlado.',
   'Auditorías MECIC/NOM-004; controles de acceso; registros de consulta.'),
  ('Recursos Humanos / Capital Humano', 'interno',
   'Cumplimiento de normatividad laboral y desarrollo de personal.',
   'Procesos de reclutamiento, inducción y capacitación estructurados.',
   'Expedientes de personal; evaluaciones de desempeño; plan anual de capacitación.'),
  ('Compras', 'interno',
   'Adquisición oportuna de insumos con calidad y al mejor costo.',
   'Requisiciones claras, presupuesto disponible y proveedores evaluados.',
   'Órdenes de compra; evaluaciones de proveedores; registros de recepción.'),
  ('Ingeniería Biomédica / Mantenimiento', 'interno',
   'Disponibilidad y seguridad de equipos biomédicos e instalaciones.',
   'Presupuesto para mantenimiento y contratos de servicio vigentes.',
   'Bitácoras de mantenimiento; contratos de servicio; verificaciones.'),
  ('Intendencia / Seguridad e Higiene', 'interno',
   'Ambiente limpio, seguro y con control de riesgos ambientales.',
   'Insumos de limpieza suficientes y personal capacitado.',
   'Checklists diarios; inspecciones; indicadores de control de infecciones.'),
  ('Tecnologías de la Información (TI)', 'interno',
   'Disponibilidad de sistemas de información y seguridad de los datos.',
   'Infraestructura tecnológica estable y soporte técnico oportuno.',
   'Registros de incidentes; respaldos; pruebas de recuperación.'),
  ('Vigilancia', 'interno',
   'Seguridad física de pacientes, visitantes y personal.',
   'Protocolos de seguridad claros y coordinación con autoridades.',
   'Registro de incidentes; rondines; coordinación con autoridades.'),
  ('Nutrición y Cocina', 'interno',
   'Atención nutricional segura y adecuada para los pacientes.',
   'Insumos de calidad y estándares sanitarios en la preparación de alimentos.',
   'Registros dietéticos; auditorías de cumplimiento; evaluación nutricional.'),
  ('Rehabilitación física', 'interno',
   'Programas de rehabilitación y continuidad asistencial.',
   'Equipos en buen estado y coordinación multidisciplinaria.',
   'Registros de sesiones; indicadores funcionales; coordinación multidisciplinaria.'),
  ('Pastoral de la salud', 'interno',
   'Acompañamiento espiritual y soporte emocional a pacientes y familias.',
   'Espacios y tiempos disponibles para el acompañamiento pastoral.',
   'Registros de acompañamientos; coordinación con salud mental.'),
  ('ISSSTE', 'interno',
   'Coordinación en atención a afiliados y gestión de convenios.',
   'Cumplimiento de protocolos y tiempos de respuesta pactados.',
   'Informes de cumplimiento; revisión de convenios.'),
  ('Dirección General de Calidad y Educación en Salud (DGCES) - SSA Federal', 'interno',
   'Implementación de lineamientos de calidad y formación en salud; evaluación de estándares.',
   'Cumplimiento de programas nacionales de calidad y seguridad del paciente.',
   'Guías técnicas; programas de capacitación; reportes de cumplimiento en calidad.'),
  ('Ayuntamiento / Dirección de Reglamentos Municipales', 'interno',
   'Licencia de funcionamiento y cumplimiento de reglamentación municipal.',
   'Renovación oportuna de permisos y cumplimiento de normatividad.',
   'Renovación de licencias e inspecciones municipales.'),
  -- ── GRUPO 3: Regulatorias y Gubernamentales ──────────────────────────────
  ('COPRISJAL (Comisión Estatal para la Protección contra Riesgos Sanitarios, Jalisco)', 'externo',
   'Verificación sanitaria estatal y cumplimiento de condiciones de operación.',
   'Cumplimiento de disposiciones sanitarias y respuesta oportuna a observaciones.',
   'Inspecciones locales; actas de verificación y cumplimiento de requerimientos.'),
  ('Consejo de Salubridad General (CSG)', 'externo',
   'Implementación de políticas y lineamientos nacionales de salud.',
   'Cumplimiento de acuerdos y estándares del CSG.',
   'Recepción de comunicados; implementación de acuerdos; reportes de cumplimiento.'),
  ('CONAMED (Comisión Nacional de Arbitraje Médico)', 'externo',
   'Gestión eficiente de quejas y conciliaciones médicas.',
   'Respuesta oportuna y resolución efectiva de controversias.',
   'Registro y seguimiento de quejas; participación en conciliaciones.'),
  ('Comisión Estatal de Derechos Humanos / CNDH', 'externo',
   'Protección de derechos de pacientes y atención de quejas.',
   'Cumplimiento de recomendaciones y planes de acción.',
   'Atención de quejas y recomendaciones; planes de cumplimiento.'),
  ('Secretaría de Salud Federal (SSA)', 'externo',
   'Cumplimiento de NOMs y lineamientos sanitarios federales; notificación de eventos.',
   'Adherencia a la normatividad federal vigente.',
   'Reportes periódicos; visitas de verificación; respuesta a observaciones.'),
  ('Secretaría de Salud del Estado de Jalisco (SSJ)', 'externo',
   'Permisos sanitarios estatales y coordinación en salud pública.',
   'Cumplimiento de reglamentación estatal y entrega oportuna de informes.',
   'Visitas de verificación estatales; entrega de documentación; seguimiento de observaciones.'),
  ('COFEPRIS (Comisión Federal para la Protección contra Riesgos Sanitarios)', 'externo',
   'Autorización sanitaria, control de insumos y farmacovigilancia.',
   'Cumplimiento de registros sanitarios y normativa de insumos.',
   'Inspecciones sanitarias; renovación de registros; respuesta a alertas.'),
  ('CETS Jalisco (Centro Estatal de la Transfusión Sanguínea)', 'externo',
   'Disponibilidad y seguridad de hemoderivados; coordinación de donación altruista.',
   'Cumplimiento de NOM-253-SSA1-2012 y reportes de donación.',
   'Registro de donaciones; convenios; reportes de stock y controles de calidad.'),
  ('Protección Civil Municipal / Estatal', 'externo',
   'Cumplimiento de medidas de seguridad y planes de emergencia.',
   'Instalaciones seguras, simulacros realizados y planes actualizados.',
   'Constancias de revisión; participación en simulacros; subsanación de observaciones.'),
  ('STPS (Secretaría del Trabajo y Previsión Social)', 'externo',
   'Cumplimiento de normas laborales y seguridad ocupacional.',
   'Condiciones laborales seguras y cumplimiento de la LFT y NOMs laborales.',
   'Inspecciones laborales e informes de cumplimiento.'),
  ('Otras instituciones de salud (referencia y contrarreferencia)', 'externo',
   'Coordinación en referencia y contrarreferencia de pacientes.',
   'Protocolos claros y comunicación oportuna en la atención compartida.',
   'Protocolos de referencia; registros de pacientes referidos y convenios.')
) AS v(name, type, needs, expectations, monitoring_method)
WHERE NOT EXISTS (SELECT 1 FROM public.interested_parties LIMIT 1);

-- ══════════════════════════════════════════════════════════════
-- Verificación
-- ══════════════════════════════════════════════════════════════
SELECT 'sgc_context'       AS tabla, COUNT(*) AS filas FROM public.sgc_context
UNION ALL
SELECT 'swot_analyses'     AS tabla, COUNT(*) AS filas FROM public.swot_analyses
UNION ALL
SELECT 'interested_parties' AS tabla, COUNT(*) AS filas FROM public.interested_parties;
