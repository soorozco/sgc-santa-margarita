-- ============================================================
--  Calidad — Contenido de 3 Procedimientos
--  PR-CA-05, PR-CA-06, PR-CA-07
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar DESPUÉS de calidad_docs.sql
-- ============================================================

-- ── PR-CA-05 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Establecer, documentar y mantener un procedimiento sistemático, accesible y verificable para la recepción, registro, clasificación, investigación, resolución y retroalimentación de quejas, sugerencias y felicitaciones de pacientes, familiares y usuarios externos e internos.',
'Aplica a todas las áreas y servicios del hospital, a todas las expresiones de insatisfacción (quejas), propuestas de mejora (sugerencias) y reconocimientos (felicitaciones) dirigidas al Hospital, independientemente del canal de recepción (presencial, teléfono, correo electrónico, formulario web, redes sociales u otros medios oficiales).',
'[{"termino": "Felicitación", "definicion": "Reconocimiento o manifestación de satisfacción positiva hacia el personal, un servicio o la institución, que deberá registrarse y usarse como insumo para evaluación de desempeño y buenas prácticas."}, {"termino": "Queja", "definicion": "Expresión de insatisfacción manifestada por un usuario, paciente, familiar o tercero respecto a un servicio, atención, conducta, proceso o resultado proporcionado por el Hospital, que requiere evaluación, respuesta y, en su caso, acciones correctivas."}, {"termino": "Resolución", "definicion": "Estado final del registro cuando se han implementado y verificado las acciones correspondientes, se ha proporcionado respuesta al usuario y se cuenta con evidencia documental del cierre."}, {"termino": "Retroalimentación al usuario", "definicion": "Comunicación clara, respetuosa y documentada dirigida al emisor con resultados de la investigación, acciones tomadas y, cuando corresponda, disculpa institucional o medidas de compensación."}, {"termino": "Sugerencia", "definicion": "Propuesta de mejora, idea o recomendación presentada por usuarios internos o externos destinada a optimizar procesos, servicios, infraestructura, comunicación o atención al paciente."}, {"termino": "Usuario", "definicion": "Persona que recibe servicios del Hospital: paciente, familiar, acompañante o representante legal; incluye también actores externos que interactúan con la institución (proveedores, aseguradoras, etc.)."}]'::jsonb,
'[{"tipo": "Actualización", "descripcion": "Jefa o Jefe de Calidad."}, {"tipo": "Ejecución", "descripcion": "Personal de todas las áreas del hospital."}, {"tipo": "Supervisión", "descripcion": "Directora General."}]'::jsonb,
'[]'::jsonb,
'[{"no": "5.1", "responsable": "Usuaria o usuario y/o familiar", "actividad": "Presenta su felicitación, sugerencia o queja en el buzón digital, en la administración del hospital o directamente con personal del área de calidad. Cuando así sea, será orientada(o) de acuerdo a la problemática en cuestión, brindando dentro de lo posible, solución inmediata y registrando en el buzón digital. Si el canal de recepción es por vía telefónica, correo electrónico o algún otro medio, una vez recibidas se procederá al registro en el buzón digital."}, {"no": "5.2", "responsable": "Personal de la jefatura de calidad", "actividad": "Verifica diariamente el buzón digital la existencia o no de quejas, sugerencias o felicitaciones."}, {"no": "5.3", "responsable": "Personal de la jefatura de calidad", "actividad": "Revisa las solicitudes de atención registradas en la Bitácora de Seguimiento de felicitaciones, sugerencias y quejas, para realizar la investigación correspondiente."}, {"no": "5.4", "responsable": "Personal de la jefatura de calidad", "actividad": "Investiga la queja, sugerencia o felicitación haciendo una revisión inicial en el expediente clínico para verificar la información y corroborar los datos de la o el usuario, así como cualquier otro documento relacionado con la atención. Posteriormente, se contacta vía telefónica en caso de no estar presente el usuario en el hospital; si se encuentra dentro de las instalaciones se aborda personalmente para obtener detalles adicionales sobre la situación ocurrida. En caso necesario se realizan entrevistas al personal del servicio o a la jefa o jefe del área para el análisis y seguimiento. Una vez completada la investigación, registra los datos en la bitácora de seguimiento y determina si la solicitud es procedente."}, {"no": "5.5", "responsable": "Personal de la jefatura de calidad", "actividad": "En todos los casos, son procedentes, con excepción de: solicitud con lenguaje soez o vulgar; solicitud que exhibe predilecciones político-partidistas; solicitud ilegible, sin datos de identificación o con datos falsos; solicitud cuyo contenido no corresponde a un servicio del hospital; solicitudes registradas por el personal que generó la atención."}, {"no": "5.6", "responsable": "Personal de la jefatura de calidad", "actividad": "Determina la urgencia o gravedad de su intervención. Identifica casos que requieran atención urgente e inmediata y los señala en la Bitácora de Seguimiento. Prioriza todas las quejas y sugerencias en atención urgente u ordinaria, con hasta noventa días naturales para su resolución. Si se identifica un posible evento adverso, cuasifalla o centinela, lo registra en la plataforma institucional de incidentes clínicos."}, {"no": "5.7", "responsable": "Jefa o jefe de calidad", "actividad": "Genera oficio o correo electrónico de la solicitud procedente dirigido a la jefa o jefe del servicio involucrado, con copia a la jefatura de capital humano cuando aplique y a la dirección correspondiente. Incluye la descripción de la solicitud y el personal involucrado, cuidando los datos personales del usuario."}, {"no": "5.8", "responsable": "Jefa o jefe del área, departamento o servicio", "actividad": "Realiza las acciones correspondientes para la resolución de la queja conforme a su análisis e implementa acciones para que dicha situación no vuelva a ocurrir, notificándose por oficio o correo electrónico a la Jefatura de Calidad. En caso de sugerencia, analiza su viabilidad."}, {"no": "5.9", "responsable": "Personal de la jefatura de calidad", "actividad": "Realiza la resolución de la solicitud dentro de los plazos señalados y la asienta en la Bitácora de seguimiento para su notificación. La resolución responderá a los términos planteados e incluirá: la gestión realizada, la decisión tomada sobre el asunto y el tiempo en que se ejecutarán acciones."}, {"no": "5.10", "responsable": "Personal de la jefatura de calidad", "actividad": "Notifica a la o el usuario el resultado de la gestión de manera personal, telefónica o por correo electrónico."}, {"no": "5.11", "responsable": "Jefa o jefe de calidad", "actividad": "Propone acciones preventivas y/o correctivas para la mejora continua, establece estrategias con tiempos y responsables específicos con base en el análisis de los datos, y las presenta en el Comité de calidad y seguridad del paciente."}]'::jsonb,
'[{"riesgo": "Solicitudes con datos erróneos o falsos.", "barrera": "Investigación de las solicitudes de atención a través de expediente clínico, entrevista con el usuario e investigación en campo."}, {"riesgo": "Usuaria o usuario que no pueda acceder al buzón digital.", "barrera": "Recepción de solicitudes de manera personal, vía telefónica y/o vía correo electrónico, para posteriormente ser verificadas."}, {"riesgo": "Solicitud no atendida.", "barrera": "Revisión diaria del buzón digital."}]'::jsonb,
'[{"nombre": "Lineamiento para el uso de la Herramienta SUG Atención y Orientación al Usuario de los Servicios de Salud, Secretaría de Salud", "codigo": "No aplica"}, {"nombre": "Formato para realizar sugerencias, quejas o felicitaciones", "codigo": "FT-CA-24"}]'::jsonb,
'[{"version": "1", "fecha": "8 Julio 2022", "descripcion": "Alta del documento", "realizado": "Mtra. Ana Cecilia Zarate Bautista", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "2", "fecha": "19 Octubre 2022", "descripcion": "Modificación del documento", "realizado": "Mtra. Ana Cecilia Zarate Bautista", "aprobado": "Mtra. Ana Cecilia Zarate Bautista"}, {"version": "3", "fecha": "3 Marzo 2025", "descripcion": "Actualización del proceso, implementación del buzón digital y bitácora de seguimiento de solicitudes", "realizado": "Dra. Giselle Ivette De la Torre García", "aprobado": "Hna. María de Jesús García Castro"}]'::jsonb,
'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
'Hna. María de Jesús Gómez Flores',  'Directora Administrativa',
'Hna. María de Jesús García Castro', 'Directora General'
FROM documents d WHERE d.code = 'PR-CA-05'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
  definiciones        = EXCLUDED.definiciones,
  responsabilidades   = EXCLUDED.responsabilidades,
  material_equipo     = EXCLUDED.material_equipo,
  desarrollo          = EXCLUDED.desarrollo,
  gestion_riesgos     = EXCLUDED.gestion_riesgos,
  referencias         = EXCLUDED.referencias,
  control_cambios     = EXCLUDED.control_cambios,
  elaborado_por       = EXCLUDED.elaborado_por,
  cargo_elaboro       = EXCLUDED.cargo_elaboro,
  revisado_por        = EXCLUDED.revisado_por,
  cargo_reviso        = EXCLUDED.cargo_reviso,
  autorizado_por      = EXCLUDED.autorizado_por,
  cargo_autorizo      = EXCLUDED.cargo_autorizo;

-- ── PR-CA-06 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Establecer los lineamientos y responsabilidades para la entrega, recepción, registro, y custodia de las encuestas de satisfacción del usuario con el fin de obtener información válida, confiable y oportuna sobre la experiencia del paciente y su familia, que facilite la identificación de áreas de oportunidad y la implementación de acciones de mejora continua orientadas a la calidad y seguridad de la atención.',
'Aplica a todas las encuestas de satisfacción al usuario entregadas en formato físico a pacientes al momento de su admisión hospitalaria y recibidas por el familiar o responsable en el área de caja al momento del cierre de cuenta.',
'[{"termino": "Encuesta de satisfacción", "definicion": "Instrumento estandarizado diseñado para recabar de forma sistemática la percepción, valoración y opiniones de los usuarios y sus familiares respecto a la calidad, seguridad, oportunidad y trato recibido durante la atención hospitalaria. Su propósito es generar información cuantificable y cualitativa, representativa y accionable que permita identificar fortalezas, brechas y oportunidades de mejora en los procesos asistenciales y administrativos."}]'::jsonb,
'[{"tipo": "Actualización", "descripcion": "Jefa o jefe de Calidad."}, {"tipo": "Ejecución", "descripcion": "Personal de admisión, personal de caja, personal de administración, personal de calidad, pacientes y familiares."}, {"tipo": "Supervisión", "descripcion": "Director o directora general."}]'::jsonb,
'[]'::jsonb,
'[{"no": "5.1", "responsable": "Personal de admisión", "actividad": "Entrega encuesta de satisfacción al ingreso del paciente, explicando brevemente el propósito de la misma, que debe entregarse al cierre de cuenta en el área de caja de la administración del hospital."}, {"no": "5.2", "responsable": "Paciente, familiar o representante legal", "actividad": "Contesta la encuesta de satisfacción durante o al finalizar su proceso de atención médica de hospitalización."}, {"no": "5.3", "responsable": "Familiar o representante legal del paciente", "actividad": "Entrega la encuesta de satisfacción en el área de cajas en la administración del hospital al cierre de su cuenta hospitalaria a su egreso hospitalario."}, {"no": "5.4", "responsable": "Personal de cajas de administración", "actividad": "Solicita y/o recibe la encuesta de satisfacción llenada por el usuario y la resguarda en el área. En caso de no contar con la encuesta le entrega un formato y le solicita sea contestada."}, {"no": "5.5", "responsable": "Personal de cajas de administración", "actividad": "Entrega diariamente al personal de calidad las encuestas de satisfacción recabadas el día anterior."}, {"no": "5.6", "responsable": "Personal de la jefatura de calidad", "actividad": "Recolecta las encuestas de satisfacción del usuario."}, {"no": "5.7", "responsable": "Personal de la jefatura de calidad", "actividad": "Registra en base de datos las encuestas de satisfacción recabadas."}, {"no": "5.8", "responsable": "Personal de la jefatura de calidad", "actividad": "Analiza las encuestas revisando la existencia o no de comentarios positivos o negativos. En caso de existir comentarios los deriva a las áreas involucradas. Si existe alguna queja la documenta y le da seguimiento conforme al procedimiento de gestión de quejas, sugerencias y felicitaciones PR-CA-05."}, {"no": "5.9", "responsable": "Personal de la jefatura de calidad", "actividad": "Archiva las encuestas de satisfacción en la carpeta correspondiente."}, {"no": "5.10", "responsable": "Personal de la jefatura de calidad", "actividad": "Presenta los resultados de la satisfacción del usuario en el Comité de Calidad y Seguridad del Paciente."}]'::jsonb,
'[{"riesgo": "Encuesta de satisfacción no llenada o en blanco.", "barrera": "Personal de cajas le solicita al usuario el llenado de la encuesta."}, {"riesgo": "Encuesta de satisfacción no entregada en admisión.", "barrera": "Entrega de encuesta de satisfacción por parte del personal de cajas para que sea contestada."}, {"riesgo": "Encuesta de satisfacción no entregada por el usuario.", "barrera": "Entrega de encuesta de satisfacción por parte del personal de cajas para que sea contestada."}]'::jsonb,
'[{"nombre": "Encuesta de satisfacción", "codigo": "FT-CA-33"}]'::jsonb,
'[{"version": "1", "fecha": "7 Abril 2025", "descripcion": "Documento de nueva creación", "realizado": "Dra. Giselle Ivette De la Torre García", "aprobado": "Hna. María de Jesús Gómez Flores"}]'::jsonb,
'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
'Hna. María de Jesús Gómez Flores',  'Directora Administrativa',
'Hna. María de Jesús García Castro', 'Directora General'
FROM documents d WHERE d.code = 'PR-CA-06'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
  definiciones        = EXCLUDED.definiciones,
  responsabilidades   = EXCLUDED.responsabilidades,
  material_equipo     = EXCLUDED.material_equipo,
  desarrollo          = EXCLUDED.desarrollo,
  gestion_riesgos     = EXCLUDED.gestion_riesgos,
  referencias         = EXCLUDED.referencias,
  control_cambios     = EXCLUDED.control_cambios,
  elaborado_por       = EXCLUDED.elaborado_por,
  cargo_elaboro       = EXCLUDED.cargo_elaboro,
  revisado_por        = EXCLUDED.revisado_por,
  cargo_reviso        = EXCLUDED.cargo_reviso,
  autorizado_por      = EXCLUDED.autorizado_por,
  cargo_autorizo      = EXCLUDED.cargo_autorizo;

-- ── PR-CA-07 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Establecer la metodología para la notificación, registro y análisis de cuasifallas, eventos adversos y centinela, mediante un sistema estandarizado que permita el análisis de la información para identificar áreas de oportunidad, implementar barreras de seguridad y prevenir su recurrencia, en el marco de la cultura de seguridad del paciente.',
'Este procedimiento inicia con la identificación de una cuasifalla, evento adverso o centinela por parte de cualquier miembro del personal y finaliza con el análisis de la información, la implementación de acciones de mejora y la retroalimentación a las áreas involucradas. Aplica a todo el personal (clínico, administrativo y de apoyo) que labora en el Hospital Santa Margarita.',
'[{"termino": "Cuasifalla", "definicion": "Situación en la que un error médico podría haber derivado en un accidente, una lesión o una enfermedad, pero que no lo hizo, ya fuera por el azar o por una intervención oportuna."}, {"termino": "Evento Adverso", "definicion": "Lesión causada por el tratamiento o por una complicación médica, no por la enfermedad de fondo, y que da lugar a una hospitalización prolongada, a una discapacidad en el momento del alta médica, o a ambas cosas."}, {"termino": "Evento Centinela", "definicion": "Incidencia imprevista en la que se produce la muerte o una lesión física o psíquica grave, o el riesgo de que se produzca. Una lesión grave comprende específicamente la pérdida de una extremidad o una función."}]'::jsonb,
'[{"tipo": "Actualización", "descripcion": "La persona titular de la Jefatura de Calidad."}, {"tipo": "Ejecución", "descripcion": "Todo el personal del Hospital Santa Margarita que identifique un incidente. El Comité de Calidad y Seguridad del Paciente (COCASEP)."}, {"tipo": "Supervisión", "descripcion": "La persona titular de la jefatura del área donde ocurre el incidente y el COCASEP o su equivalente."}]'::jsonb,
'[]'::jsonb,
'[{"no": "5.1", "responsable": "Personal del Hospital Santa Margarita", "actividad": "Identifica la ocurrencia de una cuasifalla, evento adverso o centinela durante el proceso de atención."}, {"no": "5.2", "responsable": "Personal del Hospital Santa Margarita", "actividad": "Prioriza la estabilización y atención del paciente en caso de que el incidente haya generado un daño."}, {"no": "5.3", "responsable": "Personal del Hospital Santa Margarita", "actividad": "Realiza la notificación del incidente a través del Sistema de Registro de Eventos Adversos. El registro es anónimo, voluntario, confidencial y no punitivo, y debe realizarse inmediatamente o tan pronto como sea posible tras la identificación del incidente."}, {"no": "5.4", "responsable": "COCASEP", "actividad": "Recibe y centraliza las notificaciones de todos los incidentes registrados para su posterior gestión y análisis. La participación en este sistema es aprobada por el propio comité."}, {"no": "5.5", "responsable": "COCASEP", "actividad": "Realiza el análisis del incidente según su clasificación. Para Cuasifallas y Eventos Adversos: análisis de Patrones y Tendencias al menos cada seis meses. Para Eventos Centinela: Análisis Causa-Raíz (ACR) en un periodo no mayor a 45 días desde la ocurrencia del evento."}, {"no": "5.6", "responsable": "COCASEP", "actividad": "Presenta los resultados de los análisis al cuerpo directivo y al personal del Hospital Santa Margarita en sesiones generales, con el objetivo de identificar patrones, tendencias, costos y diseñar acciones de mejora."}, {"no": "5.7", "responsable": "Jefaturas de Área y COCASEP", "actividad": "Definen e implementan las acciones y barreras de seguridad derivadas del análisis para prevenir la recurrencia de los incidentes."}, {"no": "5.8", "responsable": "COCASEP", "actividad": "Monitorea la implementación y efectividad de las estrategias de mejora definidas y realiza retroalimentación periódica a los directivos y al personal involucrado."}]'::jsonb,
'[{"riesgo": "Subregistro de incidentes por temor a represalias por parte del personal.", "barrera": "Realizar capacitación continua para fomentar una cultura de seguridad y la importancia del reporte como herramienta de aprendizaje y no de castigo."}, {"riesgo": "Análisis superficial del incidente que no identifica las causas raíz.", "barrera": "Aplicar metodologías estandarizadas para el análisis, como el Análisis Causa-Raíz para eventos centinela."}, {"riesgo": "No se implementan o no se da seguimiento a las acciones de mejora.", "barrera": "Establecer la responsabilidad del COCASEP para monitorear las estrategias de mejora y presentar los avances al cuerpo directivo."}]'::jsonb,
'[{"nombre": "Acciones Esenciales para la Seguridad del Paciente, Actualización 2023", "codigo": "AESP-2023"}]'::jsonb,
'[{"version": "01", "fecha": "30 Septiembre 2025", "descripcion": "Nueva emisión", "realizado": "Dra. Giselle Ivette De la Torre García", "aprobado": "Hna. María de Jesús Gómez Flores"}]'::jsonb,
'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
'Hna. María de Jesús Gómez Flores',  'Directora Administrativa',
'Hna. María de Jesús García Castro', 'Directora General'
FROM documents d WHERE d.code = 'PR-CA-07'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
  definiciones        = EXCLUDED.definiciones,
  responsabilidades   = EXCLUDED.responsabilidades,
  material_equipo     = EXCLUDED.material_equipo,
  desarrollo          = EXCLUDED.desarrollo,
  gestion_riesgos     = EXCLUDED.gestion_riesgos,
  referencias         = EXCLUDED.referencias,
  control_cambios     = EXCLUDED.control_cambios,
  elaborado_por       = EXCLUDED.elaborado_por,
  cargo_elaboro       = EXCLUDED.cargo_elaboro,
  revisado_por        = EXCLUDED.revisado_por,
  cargo_reviso        = EXCLUDED.cargo_reviso,
  autorizado_por      = EXCLUDED.autorizado_por,
  cargo_autorizo      = EXCLUDED.cargo_autorizo;

-- ── Verificación ─────────────────────────────────────────────
SELECT d.code, d.name,
       CASE WHEN dc.document_id IS NOT NULL THEN 'Contenido OK ✓' ELSE '⚠ Sin contenido' END AS contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code IN ('PR-CA-05','PR-CA-06','PR-CA-07')
ORDER BY d.code;
