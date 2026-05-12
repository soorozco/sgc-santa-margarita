-- ============================================================
--  UCI — Vista digital de 12 Procedimientos (PR-UCI-01..12)
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar DESPUÉS de uci_docs.sql
--
--  Bloque de autorización común a los 12 documentos:
--    Elaboró:  Dr. Jorge Isaac Michel González  / Jefe de Terapia Intensiva
--    Revisó:   Dr. José Gonzalo Vázquez Camacho / Director Médico
--    Autorizó: Lic. María Elena Martínez Alvarado / Dirección General
--
--  Control de cambios idéntico en los 12:
--    v01 18/03/2022 — Alta (Dr. Jorge Isaac Michel Gonzalez / Mtra. Ana Cecilia Zarate Bautista)
--    v02 25/03/2024 — Actualización
--
--  Nota estructural: gestion_de_riesgos en el JSON original viene como
--  listas separadas (ponderacion_de_riesgos / barreras_de_seguridad).
--  Se transformaron a pares {riesgo, barrera} ciclando barreras cuando
--  hay más riesgos que barreras. El material por paso se capturó en
--  material_equipo.
-- ============================================================

-- ── Bloque de control_cambios reutilizable ────────────────────
-- (copiado en cada INSERT para idempotencia)

-- ── PR-UCI-01  Cardioversión ──────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Convertir las arritmias supraventriculares a ritmo sinusal y suprimir las arritmias que pueden tener un comportamiento letal.',
'Este procedimiento se inicia con el diagnóstico de la arritmia cardiaca en el contexto de un paciente hemodinamicamente inestable por parte del médico a cargo hasta la ejecución de la cardioversión y el abordaje de la causa.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Desfibrilador con EKG"},{"item":"Monitor con EKG"},{"item":"Pasta conductora"},{"item":"Electrodos"},{"item":"Carro rojo con equipo de reanimación cardiopulmonar e intubación orotraqueal completo"},{"item":"Guantes"},{"item":"Cubrebocas"},{"item":"Hoja y laringoscopio"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Diagnóstico por electrocardiograma o telemetría de la arritmia supraventricular. Evaluar el estado hemodinámico asociado a la arritmia. Al ser una emergencia médica cardiológica se dará prioridad a actuar y posteriormente avisar a la familia o realizar ambos procedimientos al mismo tiempo, desistiendo únicamente en caso de que la familia o tutor decida no continuar o que previamente se haya firmado consentimiento de no maniobras o tratamiento paliativo."},{"no":"2","responsable":"Médico y Enfermera","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de proporcionarlo al médico que realizará el procedimiento, así como incorporarse al equipo de reanimación y ayudar durante el procedimiento. Posterior a resolver la urgencia cargarán el material utilizado al sistema hospitalario. El médico con capacitación en reanimación cardiopulmonar avanzada tomará el papel de líder durante el procedimiento."},{"no":"3","responsable":"Médico y Enfermera","actividad":"Asegurar vía venosa permeable. Retirar prótesis dentales y objetos metálicos del cuerpo del paciente. Acomodar paciente en decúbito supino. En caso de que sea posible, se administrará sedación y analgesia al paciente sugiriendo midazolam 0.2 mg/kg dosis máxima 2 mg y fentanil 10 mcg/kg previa a la descarga. Monitorizar signos vitales en especial ritmo cardiaco y presión arterial para documentar reversión de la arritmia así como vigilar los datos clínicos durante el procedimiento. Conectar al paciente al monitor de cardioversion y seleccionar el modo cardioversion sincronizada. Colocar las palas en el tórax con una presión de 10 a 15 kg y seleccionar los Joules de energía inicial recomendándose 100 j en caso de un desfibrilador bifásico e ir incrementado la energía hasta 360 j. Cerrar la fuente de oxígeno durante la descarga. Presionar el botón de carga y asegurarse de que ningún integrante del equipo de reanimación esté tocando al paciente para dar la descarga. Dar la descarga eléctrica y re evaluar al paciente posteriormente determinando si su ritmo y estado hemodinamico volvió a la normalidad o requerirá una nueva descarga a una potencia eléctrica mayor."}]'::jsonb,
'[{"riesgo":"Parada cardiaca, viraje a otra arritmia cardiaca como fibrilacion, taquicardia ventricular y requerimiento de desfibrilacion y reanimación cardiopulmonar avanzada.","barrera":"Experiencia y entrenamiento del médico y equipo de reanimación cardiopulmonar avanzada."},{"riesgo":"Intubacion endotraquial.","barrera":"Utilizar de manera estricta las indicaciones de asepsia y antisepsia, así como del equipo de protección como guantes y cubre boca."},{"riesgo":"Muerte","barrera":"Experiencia y entrenamiento del médico y equipo de reanimación cardiopulmonar avanzada."},{"riesgo":"Quemadura en piel","barrera":"Utilizar de manera estricta las indicaciones de asepsia y antisepsia, así como del equipo de protección como guantes y cubre boca."}]'::jsonb,
'[{"nombre":"Consentimiento informado para cardioversion","codigo":"No aplica"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Guía ESC 2020 sobre el diagnóstico y tratamiento de la fibrilación auricular (EACTS)","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-01'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-02  Catéter Venoso Central ────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Colocar de manera segura y eficaz un acceso vascular en vena yugular, subclavia o femoral, derecha o izquierda, para la administración de líquidos, medicamentos, componentes sanguíneos, nutrición parenteral, monitoreo hemodinámico y para la toma de exámenes generales en pacientes inestables, sin accesos vasculares o para la administración de productos médicos que requieran aplicación rápida o que puedan dañar una vía periférica.',
'Este procedimiento se inicia con la valoración del paciente por parte del cuerpo médico, ya sea tratante o médico de guardia de terapia intensiva, objetivar la indicación de la colocación del catéter central, explicación de los riesgos y aprobación familiar del procedimiento, la colocación y cuidados del catéter por el cuerpo médico y de enfermería en conjunto.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Kit de colocación de catéter central de 2 o 3 lumenes"},{"item":"Ultrasonido"},{"item":"Lidocaina simple al 2%"},{"item":"Gasas"},{"item":"Guantes estériles"},{"item":"Material de asepsia (Duraprep, Cloraprep, Isodine, Clorhexidina)"},{"item":"3 Jeringas de 10 o 5 ml"},{"item":"Solución inyectable o solución salina al 0.9% bote de 100 ml"},{"item":"Gel para trasductor"},{"item":"Bata quirúrgica"},{"item":"Gorro"},{"item":"Mascarilla"},{"item":"5 campos estériles"},{"item":"Protector de transductor estéril"},{"item":"Sutura nylon 2 o 3 ceros"},{"item":"Equipo de sutura estéril"},{"item":"Parche tegaderm, Hcg o Fil"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Evaluación clínica del paciente determinando la necesidad de colocar el catéter central. El médico a cargo del paciente iniciará el procedimiento con un rastreo ultrasonografico de las venas subclavias, yugulares o femorales, dependiendo del lugar seleccionado para la colocación, para evaluar visibilidad, diámetro, profundidad, y comprensibilidad, seleccionando la zona ideal de punción y colocación."},{"no":"2","responsable":"Médico","actividad":"Se hablará con el paciente, familiar o tutor sobre los riesgos y beneficios del procedimiento y se procederá a realizar y firmar el consentimiento informado del procedimiento."},{"no":"3","responsable":"Médico y Enfermería","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material requerido y de proporcionarlo al médico que lo colocará."},{"no":"4","responsable":"Médico y Enfermera","actividad":"El médico se colocará guantes y se proporcionará por enfermería el material de aseo para limpiar la piel del área seleccionada para colocar el catéter. En pacientes con características morfológicas que sugieran un acceso venoso difícil, se recomienda limpiar de manera bilateral en caso de que se tenga que cambiar la zona de punción."},{"no":"5","responsable":"Médico y Enfermera","actividad":"El médico o la enfermera acomodaran al paciente en decúbito supino tredelemburg, con la cabeza girada al lado contrario de la vena subclavia o yugular en la que se trabajará. En caso de que la colocación sea en la vena femoral se sugiere el decúbito supino plano. La enfermera auxiliará al médico a vestirse con gorro, bata estéril y guantes quirúrgicos nuevos. El médico acomodará los campos aislando el área del cuello o ingle designada para la colocación del catéter, colocará un campo en la mesa de trabajo y usará uno más para vestir el trasductor del ultrasonido. Se cargará una jeringa con lidocaina al 2% para anestesiar la zona de punción y con la solución se purgará el catéter y la jeringa para punción. Se colocará gel transmisor dentro del protector del trasductor, se vestirá el mismo de manera estéril y se dejará listo el ultrasonido para la punción en tiempo real. Con rastreo ultrasonografico, se hará la primer punción con la jeringa con lidocaina y se anestesiará el área de punción. Posteriormente bajo visualización con transductor de hará la punción de la vena hasta obtener retorno. Se pasará guía por la aguja, cerciorando el adecuado paso de la misma en la vena en eje corto o eje largo del ultrasonido. Se pasará dilatador de tejidos blandos para finalizar colocando catéter venoso central. Al terminar la colocación se comprobarán flujos sanguíneos de todos los lúmenes, así como se realizará prueba de burbujas con solución y rastreo cardiaco para comprobar adecuada colocación de cateter. Se limpiarán los mismos y se fijará catéter con sutura o fijadores adhesivos. Por último, se limpiará la piel del paciente y se colocará el parche protector y de aislamiento del catéter central para disminuir su manipulación y el riesgo de infección del mismo."},{"no":"6","responsable":"Enfermería","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación."},{"no":"7","responsable":"Médico y Enfermería","actividad":"Se reposicionará al paciente."},{"no":"8","responsable":"Radiología","actividad":"Se tomará radiografía de control para verificar posición del catéter en caso de que no se haya realizado prueba de burbujas previamente descrita."}]'::jsonb,
'[{"riesgo":"Hemotorax","barrera":"Experiencia y entrenamiento del médico que colocará el catéter central."},{"riesgo":"Neumotorax","barrera":"Colocación con guía ultrasonografica en tiempo real."},{"riesgo":"Embolia aérea","barrera":"No introducir la guía metálica más de 20 cm en la vena yugular derecha. Maniobras para prevenir embolismo aéreo."},{"riesgo":"Lesión vascular","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento del área de trabajo redactadas en el desarrollo del procedimiento para evitar las complicaciones infecciosas."},{"riesgo":"Arritmia cardiaca","barrera":"Selección adecuada del lugar de colocación del catéter central de acuerdo a las características visualizadas durante el rastreo ultrasonografico."},{"riesgo":"Infecciones del sitio de salida, del túnel o infecciones sistémicas y bacteremias","barrera":"Experiencia y entrenamiento del médico que colocará el catéter central."},{"riesgo":"Estenosis o trombosis venosa","barrera":"Colocación con guía ultrasonografica en tiempo real."}]'::jsonb,
'[{"nombre":"Consentimiento informado para la colocación de catéter central","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Solicitud de radiografía","codigo":"No aplica"},{"nombre":"Practice Guidelines for Central Venous Access 2020 (ASA Task Force). Anesthesiology 2020","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-02'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-03  Catéter Swan Ganz ─────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Colocar de manera segura y eficaz un acceso vascular en la arteria pulmonar (Swan-Ganz), para la evaluación y manejo de pacientes críticamente enfermos o para el diagnóstico y manejo de paciente con hipertensión pulmonar o disnea inexplicable.',
'Este procedimiento se inicia con la valoración del paciente por parte del cuerpo médico, ya sea tratante o médico de guardia de terapia intensiva, objetivar la indicación de la colocación del catéter arterial pulmonar, explicación de los riesgos y aprobación familiar del procedimiento, la colocación y cuidados del catéter por el cuerpo médico y de enfermería en conjunto.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Kit de colocación de catéter central de 2 o 3 lumenes"},{"item":"Ultrasonido"},{"item":"Lidocaina simple al 2%"},{"item":"Gasas"},{"item":"Guantes estériles"},{"item":"Material de asepsia (Duraprep, Cloraprep, Isodine, Clorhexidina)"},{"item":"3 Jeringas de 10 o 5 ml"},{"item":"Solución inyectable o solución salina al 0.9% bote de 100 ml"},{"item":"Gel para trasductor"},{"item":"Bata quirúrgica"},{"item":"Gorro"},{"item":"Mascarilla"},{"item":"5 campos estériles"},{"item":"Protector de transductor estéril"},{"item":"Sutura nylon 2 o 3 ceros"},{"item":"Equipo de sutura estéril"},{"item":"Parche tegaderm, Hcg o Fil"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Evaluación clínica del paciente determinando la necesidad de colocar el catéter central. El médico a cargo del paciente iniciará el procedimiento con un rastreo ultrasonografico de las venas subclavias, yugulares o femorales, dependiendo del lugar seleccionado para la colocación, para evaluar visibilidad, diámetro, profundidad, y comprensibilidad, seleccionando la zona ideal de punción y colocación."},{"no":"2","responsable":"Médico","actividad":"Se hablará con el paciente, familiar o tutor sobre los riesgos y beneficios del procedimiento y se procederá a realizar y firmar el consentimiento informado del procedimiento."},{"no":"3","responsable":"Médico y Enfermería","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material requerido y de proporcionarlo al médico que lo colocará."},{"no":"4","responsable":"Médico y Enfermera","actividad":"El médico se colocará guantes y se proporcionará por enfermería el material de aseo para limpiar la piel del área seleccionada para colocar el catéter. En pacientes con características morfológicas que sugieran un acceso venoso difícil, se recomienda limpiar de manera bilateral en caso de que se tenga que cambiar la zona de punción."},{"no":"5","responsable":"Médico y Enfermera","actividad":"El médico o la enfermera acomodaran al paciente en decúbito supino tredelemburg. La enfermera auxiliará al médico a vestirse con gorro, bata estéril y guantes quirúrgicos nuevos. Con rastreo ultrasonografico, se realizará la punción de la vena hasta obtener retorno. Se pasará guía por la aguja y dilatador de tejidos blandos para finalizar colocando catéter venoso central. Al terminar se comprobarán flujos sanguíneos de todos los lúmenes y se realizará prueba de burbujas. Se fijará catéter con sutura o fijadores adhesivos y se colocará parche protector."},{"no":"6","responsable":"Enfermería","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación."},{"no":"7","responsable":"Médico y Enfermería","actividad":"Se reposicionará al paciente."},{"no":"8","responsable":"Radiología","actividad":"Se tomará radiografía de control para verificar posición del catéter en caso de que no se haya realizado prueba de burbujas previamente descrita."}]'::jsonb,
'[{"riesgo":"Hemotorax, Neumotorax y Embolia aérea","barrera":"Experiencia y entrenamiento del médico que colocará el catéter central."},{"riesgo":"Lesión vascular y Arritmia cardiaca","barrera":"Colocación con guía ultrasonografica en tiempo real."},{"riesgo":"Infecciones del sitio de salida, del túnel o infecciones sistémicas y bacteremias","barrera":"No introducir la guía metálica más de 20 cm en la vena yugular derecha. Maniobras para prevenir embolismo aéreo."},{"riesgo":"Estenosis venosa o trombosis","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento."}]'::jsonb,
'[{"nombre":"Consentimiento informado para la colocación de catéter vascular","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Solicitud de radiografía","codigo":"No aplica"},{"nombre":"Practice Guidelines for Central Venous Access 2020 (ASA Task Force). Anesthesiology 2020","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-03'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-04  Línea Arterial ─────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'El catéter intraarterial se coloca con la intención de tener los siguientes 4 objetivos: Monitorear de manera continua y con datos más exactos la presión arterial del paciente, obtener un acceso para la obtención de muestras sanguíneas, identificar los patrones de curva anormales y evaluar las variaciones respirofasicas en las curvas de presión para predecir respuesta a volumen.',
'El procedimiento comienza con la decisión del médico de colocar la línea arterial posterior a la evaluación del paciente y determinado la necesidad de esta, la obtención del material necesario para colocarla por parte de enfermería y la colocación de la línea arterial por el médico.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Monitor"},{"item":"Cable de interfase"},{"item":"Módulo de presión invasiva"},{"item":"Solución fisiológica 1000cc + 5000 UI de heparina"},{"item":"Trasductor de presiones"},{"item":"Infusor"},{"item":"Introductor percutaneo 5 fr"},{"item":"Micropore y benjuí"},{"item":"Vendas y gasas"},{"item":"Campos estériles, batas, guantes, cubre boca y soluciones antisépticas"},{"item":"Lidocaina simple 2%"},{"item":"Ultrasonido"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Evaluación del estado clínico del paciente en terapia intensiva determinando el beneficio de colocar una línea arterial, determinar el mejor lugar de punción ya sea periférico (arteria radial, braquial o dorsal pedia) o central (axilar o femoral) y excluyendo los motivos de contraindicación total (Infección local, test de Allen modificado anormal, alteración morfológica en piel o vascular que compliquen el procedimiento, Raynaud activo, INR >3, TPT >100, trombocitopenia <50 mil plaquetas e infusión de agente trombolitico)."},{"no":"2","responsable":"Médico","actividad":"Se hablará con el paciente, familiar o tutor sobre los riesgos y beneficios del procedimiento y se procederá a realizar y firmar el consentimiento informado del procedimiento."},{"no":"3","responsable":"Médico","actividad":"Se solicitará a enfermería el material de trabajo."},{"no":"4","responsable":"Enfermería","actividad":"Hará el pedido del material indicado por el médico que realizará el procedimiento y apoyará durante la colocación de la línea arterial."},{"no":"5","responsable":"Médico y Enfermera","actividad":"Una vez reunido el material, se iniciará aseo del área de trabajo con el agente antiséptico solicitado o disponible. Se vestirá con el equipo estéril y se colocarán campos de aislamiento. En la zona a puncionar, se colocará lidocaina simple y esperaremos 2 minutos para el efecto anestésico local. En caso de realizar la punción guiada con ultrasonido, se vestirá de manera estéril el trasductor para su manipulación. Se insertará el introductor percutaneo a 30 o 45 grados en dirección a la arteria hasta obtener retorno sanguíneo. Posteriormente se cambiará la angulacion del catéter hasta quedar casi paralelo al trayecto vascular, se introducirá unos milímetros más checando que sigamos teniendo retorno sanguíneo y por último sacar la aguja al mismo tiempo que el catéter queda dentro del vaso. Se conectará el catéter al equipo de monitoreo previamente preparado por enfermería y se fijará con sutura o con parches adhesivos."}]'::jsonb,
'[{"riesgo":"Infección","barrera":"El procedimiento debe ser realizado por médicos con la experiencia y destreza necesaria."},{"riesgo":"Edema","barrera":"Utilizar el ultrasonido para realizar la técnica de punción en tiempo real ya sea en eje corto o eje largo."},{"riesgo":"Dolor","barrera":"El procedimiento debe ser realizado por médicos con la experiencia y destreza necesaria."},{"riesgo":"Equimosis o hematoma","barrera":"Utilizar el ultrasonido para realizar la técnica de punción en tiempo real ya sea en eje corto o eje largo."},{"riesgo":"Trombosis y embolizacion","barrera":"El procedimiento debe ser realizado por médicos con la experiencia y destreza necesaria."},{"riesgo":"Fístula arteriovenosa y aneurisma","barrera":"Utilizar el ultrasonido para realizar la técnica de punción en tiempo real ya sea en eje corto o eje largo."},{"riesgo":"Lesión a nervio periférico","barrera":"El procedimiento debe ser realizado por médicos con la experiencia y destreza necesaria."}]'::jsonb,
'[{"nombre":"Consentimiento informado para la colocación de la línea arterial","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Cateterismo de la arteria radial para monitorización invasiva: evitar las complicaciones, un reto en anestesia. Katherine Chaparro Mendoza. Revista colombiana de anestesiologia. 2012","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-04'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-05  Marcapasos Cutáneo ─────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Reestablecer la integridad circulatoria y el estado hemodinámico en un paciente que de manera aguda se ven comprometidos por una frecuencia cardiaca que ha disminuido o ha aumentado de manera anómala, utilizando la estimulación eléctrica en el corazón.',
'El procedimiento comienza con la decisión del médico tratante o de terapia intensiva de colocar un marcapasos temporal posterior a la evaluación del paciente y determinado la necesidad de este, la obtención del material necesario por parte de enfermería y su colocación por el médico a cargo en ese momento.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Monitor de reanimación cardiopulmonar"},{"item":"Parches de estimulación transcutanea"},{"item":"Midazolam"},{"item":"Fentanil"},{"item":"Solución salina"},{"item":"Jabón"},{"item":"Rastrillo"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Evaluación del estado clínico del paciente en terapia intensiva determinando el beneficio de colocar un marcapasos temporal. El marcapaso cutáneo debe ser colocado únicamente en el caso de no tener la posibilidad de colocar un marcapaso venoso por falta de equipo, de personal calificado o en caso de retraso en la obtención del material necesario y que la emergencia clínica del paciente requiera de una solución rápida."},{"no":"2","responsable":"Médico","actividad":"Se hablará con el paciente, familiar o tutor sobre los riesgos y beneficios del procedimiento y se procederá a realizar y firmar el consentimiento informado del procedimiento."},{"no":"3","responsable":"Médico","actividad":"Se solicitará a enfermería el material de trabajo."},{"no":"4","responsable":"Enfermería","actividad":"Hará el pedido del material indicado por el médico que realizará el procedimiento y apoyará durante la colocación del mismo."},{"no":"5","responsable":"Médico y Enfermera","actividad":"Una vez reunido el material, se recomienda examinar el tórax del paciente y en caso de observar mucho vello se debería rasurar el área de colocación de los parches para asegurar la máxima área de contacto con la piel. Debido a la energía utilizada directamente en la piel del paciente se recomienda utilizar algún sedante y analgésico sugiriendo midazolam 0.2 mg/kg dosis máxima 2 mg y fentanil 10 mcg/kg. Se colocarán los parches de estimulación en la parte superior derecha del tórax y el otro en la zona lateral del tórax izquierdo. Se conectarán al monitor de reanimación y se seleccionará el modo de marcapasos cutáneo."}]'::jsonb,
'[{"riesgo":"Dolor e intolerancia a la terapia","barrera":"Se debe priorizar las dosis de analgesia y sedación para mejorar el porcentaje de tolerancia del paciente."},{"riesgo":"Fibrilacion ventricular y parada cardíaca","barrera":"Se debe tener a la mano el equipo de intubación y reanimación cardiopulmonar avanzada en caso de necesitarlo, así como el personal médico y de enfermería con las capacidades de atender un evento de parada cardiorrespiratoria."},{"riesgo":"Muerte","barrera":"Se debe priorizar las dosis de analgesia y sedación para mejorar el porcentaje de tolerancia del paciente."}]'::jsonb,
'[{"nombre":"Consentimiento informado para la colocación de marcapasos cutáneo","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Marcapasos transtorácico no invasivo (MCtc). Dr. Roberto Guzmán-Nuques. Medigraphic. 2017","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-05'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-06  Marcapasos Temporal Venoso ────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Reestablecer la integridad circulatoria y el estado hemodinámico en un paciente que de manera aguda se ven comprometidos por una frecuencia cardiaca que ha disminuido o ha aumentado de manera anómala, utilizando la estimulación eléctrica en el corazón.',
'El procedimiento comienza con la decisión del médico tratante o de terapia intensiva de colocar un marcapasos temporal posterior a la evaluación del paciente y determinado la necesidad de este, la obtención del material necesario por parte de enfermería y su colocación por el médico a cargo en ese momento.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Monitor"},{"item":"Generador y cables de marcapaso venoso temporal"},{"item":"Introductor percutaneo"},{"item":"Equipo de cateter venoso central"},{"item":"Gasas estériles"},{"item":"Campos estériles, batas, guantes, cubre boca y soluciones antisépticas"},{"item":"Lidocaina simple 2%"},{"item":"Ultrasonido"},{"item":"Jalea"},{"item":"Solución salina 0.9% 100 ml"},{"item":"Jeringas 10 ml"},{"item":"Equipo de reanimación cardiopulmonar avanzada"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Evaluación del estado clínico del paciente en terapia intensiva determinando el beneficio de colocar un marcapasos temporal. Durante la evaluación se debe determinar el sitio de colocación ya sea la yugular interna derecha o la vena subclavia izquierda como principales opciones. Se deben excluir las contraindicaciones como: pacientes con bradicardia bien tolerada con síntomas leves e intermitentes, bloqueo cardiaco con ritmo de escape adecuado sin alteración hemodinámica, paciente con válvula tricúspide protesica o con infarto al miocardio que recibe algún agente trombolitico o tratamiento agresivo con anticoagulacion y antiplaquetarios."},{"no":"2","responsable":"Médico","actividad":"Se hablará con el paciente, familiar o tutor sobre los riesgos y beneficios del procedimiento y se procederá a realizar y firmar el consentimiento informado del procedimiento."},{"no":"3","responsable":"Médico","actividad":"Se solicitará a enfermería el material de trabajo."},{"no":"4","responsable":"Enfermería","actividad":"Hará el pedido del material indicado por el médico que realizará el procedimiento y apoyará durante la colocación del mismo."},{"no":"5","responsable":"Médico y Enfermera","actividad":"Una vez reunido el material, se iniciará aseo del área de trabajo con el agente antiséptico solicitado o disponible. Se vestirá con el equipo estéril y se colocarán campos de aislamiento. En la zona a puncionar, se colocará lidocaina simple y esperaremos 2 minutos para el efecto anestésico local. En caso de realizar la punción guiada con ultrasonido, se vestirá de manera estéril el trasductor. Se insertará el introductor percutaneo con la técnica seldinger modificada similar a la colocación de un catéter venoso central. Una vez colocado el introductor se procederá a la introducción de los cables de marcapaso en el apex del ventrículo derecho los cuales pueden ser guiados por medio de las marcas de los cables, monitoreo electrocardiografico continuo, fluoroscopio o ecocardiograma. Al haber colocado los cables en su sitio se conectarán al generador y se programará el marcapasos."}]'::jsonb,
'[{"riesgo":"Infección del sitio de salida","barrera":"El procedimiento debe ser realizado por médicos con la experiencia y destreza necesaria."},{"riesgo":"Edema","barrera":"Utilizar medidas de asepsia y antisepsia descritas."},{"riesgo":"Dolor","barrera":"Se recomienda la técnica de punción en tiempo real guiado por ultrasonido ya sea en eje corto o eje largo."},{"riesgo":"Sangrado, equimosis y hematoma","barrera":"Es recomendable que el médico que lo coloque sepa tomar lecturas electrocardiograficas para asegurar la adecuada colocación de los cables y buen funcionamiento del marcapaso."},{"riesgo":"Trombosis y embolizacion","barrera":"En cuanto al equipo y el generador las conexiones deben ser revisadas diario por el médico y el equipo de enfermería en cada turno, así como el sitio de entrada para diagnosticar a tiempo alguna disfunción del equipo o infección asociada."},{"riesgo":"Fístula arteriovenosa y lesión vascular","barrera":"Se debe tener a la mano el equipo de intubacion y reanimación cardiopulmonar avanzada en caso de necesitarlo."},{"riesgo":"Lesión valvular, lesión cardíaca y taponamiento cardiaco","barrera":"El procedimiento debe ser realizado por médicos con la experiencia y destreza necesaria."},{"riesgo":"Pneumotorax","barrera":"Utilizar medidas de asepsia y antisepsia descritas."},{"riesgo":"Muerte","barrera":"Se recomienda la técnica de punción en tiempo real guiado por ultrasonido."}]'::jsonb,
'[{"nombre":"Consentimiento informado para la colocación de marcapasos temporal venoso","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Marcapasos transitorios intravenosos. R. Ortiz Díaz-Miguel y M.L. Gómez Grande. Medicina intensiva. 2014","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-06'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-07  Sonda Nasogástrica o Nasoyeyunal ───────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Colocación de sonda en estómago por vía nasal u oral con el objetivo de iniciar alimentación enteral al paciente seleccionado.',
'Este procedimiento se inicia con la valoración del paciente por parte del cuerpo médico, ya sea tratante o médico de guardia de terapia intensiva, explicación de los riesgos y aprobación del paciente o familiar del procedimiento. Terminando al colocar la sonda por el médico con ayuda de enfermería para iniciar la vía enteral.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Sonda nasogastrica o de alimentación nasoyeyunal de tungsteno"},{"item":"Lubricante hidrosoluble"},{"item":"Guantes"},{"item":"Fijador holister"},{"item":"Jeringa de 20 ml"},{"item":"Riñón"},{"item":"Estetoscopio"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Previo a iniciar el procedimiento, el médico hablará con el paciente o con la familia a cargo para explicar riesgos y beneficios del procedimiento y se firmará consentimiento informado."},{"no":"2","responsable":"Médico y Enfermera","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento."},{"no":"3","responsable":"Médico y Enfermera","actividad":"Se posicionará al paciente en sedestacion con ligera extensión del cuello. Medir la longitud de la sonda desde la comisura bucal hacia el lóbulo de la oreja y finalmente hasta la apofisis xifoides marcando la longitud de introducción de la sonda. Se lubricará la punta de la sonda para facilitar el paso por el orificio nasal y de manera gentil se introducirá la sonda buscando el orificio más permeable. Introducir la sonda hasta la orofaringe. En caso de que el paciente esté consciente, se pedirá que degluta la sonda al sentirla. Una vez que pasa la sonda, introducirla hasta la marca realizada en la medición previa. Probar la colocación de la sonda en vía enteral al aplicar aire a presión escuchando el paso de aire con el estetoscopio en el estómago."},{"no":"4","responsable":"Enfermera y Radiología","actividad":"Se fijará sonda para evitar su salida. Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación. Se recomienda vigilancia clínica y constantes vitales. Se tomará radiografía abdominal para verificar la posición de la sonda."}]'::jsonb,
'[{"riesgo":"Infecciones nasales y sinusitis","barrera":"Experiencia y entrenamiento del médico en el procedimiento."},{"riesgo":"Dolor","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento del área de trabajo."},{"riesgo":"Sangrado","barrera":"Experiencia y entrenamiento del médico en el procedimiento."},{"riesgo":"Náusea y vomito","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento del área de trabajo."},{"riesgo":"Cefalea","barrera":"Experiencia y entrenamiento del médico en el procedimiento."},{"riesgo":"Reacción vagal a la colocación","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento del área de trabajo."}]'::jsonb,
'[{"nombre":"Consentimiento informado para colocación de sonda nasogastrica","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Solicitud de Radiografía de tórax","codigo":"No aplica"},{"nombre":"Guía clínica de colocación y cuidados de SNG, SNY y gastrostomia en UCI. Geovanny Martinez Rojas. 2022","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-07'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-08  Sonda Vesical ──────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Vaciar el contenido de la vejiga, obtener muestra de orina de manera estéril, determinar la cantidad de orina residual después de la micción y llevar un control estricto de la diuresis horaria.',
'Este procedimiento se inicia con la valoración del paciente por parte del cuerpo médico, ya sea tratante o médico de guardia de terapia intensiva, explicación de los riesgos y aprobación del paciente o familiar del procedimiento, reunir el material necesario y finalizando al colocar la sonda.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Sonda foley del número solicitado"},{"item":"Gasas y guantes estériles"},{"item":"Jabón"},{"item":"Guantes"},{"item":"Jeringa de 10 ml cargada con agua"},{"item":"Gel lubricante en jeringa de 20 ml"},{"item":"Cistoflo"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Previo a iniciar el procedimiento, el médico hablará con el paciente o con la familia a cargo para explicar riesgos y beneficios del procedimiento y se firmará consentimiento informado."},{"no":"2","responsable":"Médico y Enfermera","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento."},{"no":"3","responsable":"Médico y Enfermera","actividad":"Se posicionará al paciente en decúbito dorsal. En caso de ser paciente femenina, se abrirán las piernas en mariposa para tener mejor vista del orificio uretral. Se limpiará el área con agua y jabón previo a la colocación de la sonda. En caso de ser paciente varón, se retrae el prepucio y se hará limpieza con agua y jabón de todo el pene. Se cambiarán guantes limpios y se introducirá la jalea en la uretra para permeabilizarla y facilitar el paso de la sonda. Se introducirá de manera gentil y sin forzar la entrada introduciendo la totalidad de la sonda para finalmente llenar el globo con los 10 ml de la solución en la jeringa. Observar el gasto urinario y fijar la sonda al muslo. Colocar la fecha de colocación en la fijación."},{"no":"4","responsable":"Enfermera","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación. Se reposicionará al paciente. Se recomienda vigilancia clínica y constantes vitales."}]'::jsonb,
'[{"riesgo":"Infección urinaria","barrera":"Experiencia y entrenamiento del médico en el procedimiento."},{"riesgo":"Lesión uretral, sangrado, vías falsas urinarias y dolor","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento."}]'::jsonb,
'[{"nombre":"Consentimiento informado para la colocación de sonda vesical","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Instalación de sonda vesical. Guia de clínica, SENETEC. 2016","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-08'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-09  Tubo Pleural ───────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Colocar un tubo de calibre adecuado en el espacio pleural, utilizando como vía una incisión en el tórax del paciente para conseguir la extracción del contenido patológico acumulado: Aire en el neumotorax, sangre en hemotorax y pus en empiema.',
'Este procedimiento se inicia con la valoración del paciente por parte del cuerpo médico, ya sea tratante o médico de guardia de terapia intensiva, explicación de los riesgos y aprobación del paciente o familiar del procedimiento, reunir el material necesario por enfermería y finalizando al colocar el tubo pleural.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Tubo pleural rígido con fiador"},{"item":"Anestésico local (lidocaina simple 2%)"},{"item":"Sedación y analgesia en caso de que el paciente esté consciente"},{"item":"Gasas, bata, campos y guantes estériles"},{"item":"Instrumental quirúrgico: curación de 7 piezas, seda sin aguja, nylon 2-0, pinzas krocher, hoja de bisturí 11 con mango"},{"item":"Antiséptico"},{"item":"Jeringa de 10 ml"},{"item":"Sistema colector de drenado (Pleurovac) con sus conexiones"},{"item":"Agua bidestilada"},{"item":"Sistema de aspiración"},{"item":"Mascarilla, cubrebocas y gorro quirúrgico"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Previo a iniciar el procedimiento, el médico hablará con el paciente o con la familia a cargo para explicar riesgos y beneficios del procedimiento y se firmará consentimiento informado."},{"no":"2","responsable":"Médico y Enfermera","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento."},{"no":"3","responsable":"Médico y Enfermera","actividad":"Se posicionará al paciente en decúbito dorsal con el brazo separado del hemitórax donde se colocará el tubo. Preparar el sistema de drenaje a colocar. Iniciar el aseo del área de trabajo con el antiséptico y gasas. Vestirse con el equipo médico quirúrgico estéril y de protección aislando también el área de trabajo con los campos. Posterior a la aplicación de anestésico local y la sedoanalgesia ligera en caso de que el paciente esté consciente, se hará la incisión transversal en el 5to espacio intercostal y línea media axilar con la hoja de bisturí, haciendo disección de los tejidos con la pinza Kelly y el dedo hasta romper la capa pleural. Se introduce tubo pleural con cuidado, pinzado con la korcher en su extremo distal dirigido apical en caso de neumotorax y postero basal en caso de líquido. En caso de empiema se sugiere intentar dejar el drenaje en medio del contenido. Conectar el tubo al sistema de drenaje y este al sistema de aspiración en caso de requerirlo. Comprobar el burbujeó y la fluidez del drenaje a través de los tubos colectores hacia la cámara de drenaje. Se sugiere la comprobación radiológica de la posición del tubo antes de la fijación. Se aplicará sutura con seda libre o nylon en bolsa de tabaco, facilitando el cierre de la herida al retirar el tubo. Se pegará el tubo al tórax. Se colocará aposito limpio."},{"no":"4","responsable":"Enfermera","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación. Se reposicionará al paciente. Se recomienda vigilancia clínica y constantes vitales."}]'::jsonb,
'[{"riesgo":"Infección en sitio de introducción del tubo, empiema y celulitis","barrera":"Experiencia y entrenamiento del médico en el procedimiento."},{"riesgo":"Hemotorax, lesión pulmonar y vascular, sangrado, hematoma","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento del área de trabajo redactadas en el desarrollo del procedimiento para evitar las complicaciones."},{"riesgo":"Dolor","barrera":"Comprobación clínica y radiológica de la colocación adecuada del tubo pleural."},{"riesgo":"Reacción de hipersensibilidad al anestésico local y sistémico","barrera":"Vigilancia por parte del médico y enfermería cada turno del funcionamiento adecuado del sistema de drenaje y aspiración."}]'::jsonb,
'[{"nombre":"Consentimiento informado para la colocación de tubo pleural","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Solicitud de radiografía de tórax","codigo":"No aplica"},{"nombre":"Manejo de los sistemas de drenaje pleural. Mauricio Velásquez. Revista Colombiana de cirugía. 2015","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-09'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-10  Cultivo de Punta de Catéter ───────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Obtener la punta de algún catéter vascular (central, línea arterial, hemodiálisis), con el fin de diagnosticar y aislar el agente infeccioso causante de la enfermedad del paciente en abordaje.',
'Este procedimiento se inicia con la necesidad de abordar el lugar y agente de infección del paciente, la obtención de la punta del catéter, su almacenamiento y traslado adecuado al laboratorio de bacteriología.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Equipo de retiro de puntos y equipo de curación"},{"item":"Gasas y guantes estériles"},{"item":"Jabón u otra sustancia antiséptica"},{"item":"Tubo estéril para almacenar y transportar la punta"},{"item":"Micropore"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Previo a iniciar el procedimiento, el médico hablará con el paciente y la familia a cargo para explicar la razón del retiro y posible recolocación del catéter y de la necesidad diagnóstica y caracterización del agente infeccioso."},{"no":"2","responsable":"Médico y Enfermera","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento."},{"no":"3","responsable":"Médico","actividad":"Quitar el aposito del catéter previo. Realizar el lavado mecánico de manos y calzarse los guantes. Limpiar con el material antiséptico el catéter y en la zona de alrededor. Retirar las suturas o fijación adhesiva del catéter y retirarlo lentamente. Hacer presión en la zona de entrada del catéter a la vena o arteria donde se encuentre el catéter por varios minutos hasta detener el sangrado. Con las tijeras o la hoja de bisturí cortar la punta de catéter para mandar un trayecto de 3 cm aproximadamente. Colocar la punta dentro del tubo estéril, cerrarlo y rotularlo con cinta adhesiva o plumón indeleble. Colocar aposito en el sitio de manipulación."},{"no":"4","responsable":"Enfermera","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación."}]'::jsonb,
'[{"riesgo":"Infección en la zona de manipulación","barrera":"Experiencia y entrenamiento del médico en el procedimiento."},{"riesgo":"Equimosis, hematoma y sangrado","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento."},{"riesgo":"Contaminación de la punta de catéter","barrera":"Experiencia y entrenamiento del médico en el procedimiento."}]'::jsonb,
'[{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"El microbiólogo y la infección asociada a catéter. Julio García Rodriguez. Revista Española de Quimioterapia 2010","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-10'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-11  Cultivo de Secreción Bronquial ────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Tomar muestra de secreciones bronquiales, almacenamiento y transporte adecuado para su procesamiento y cultivo por laboratorio de bacteriología.',
'Este procedimiento se inicia con la necesidad de abordar el lugar y agente de infección del paciente, la obtención de secreciones bronquiales, su almacenamiento y traslado adecuado al laboratorio de bacteriología.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Equipo de aspiración"},{"item":"Gasas y guantes estériles"},{"item":"Solución fisiológica estéril"},{"item":"Jeringa de 10 ml"},{"item":"Trampa de Lee"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Previo a iniciar el procedimiento, el médico hablará con el paciente y la familia a cargo para explicar la razón de obtener la muestra de secreción bronquial, la necesidad diagnóstica y caracterización del agente infeccioso."},{"no":"2","responsable":"Médico y Enfermera","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento."},{"no":"3","responsable":"Médico y Enfermera","actividad":"En caso de que el paciente no esté intubado, se pedirá al paciente dar muestra de secreción en la mañana, procurando colocarla en un vaso de recolección estéril y en ayuno. En caso de que el paciente esté intubado, se posicionará al paciente en decúbito dorsal. Se calzará los guantes estériles y se desconectará el tubo del ventilador, introduciendo la manguera de la trampa de Lee en un extremo y del otro extremo al aspirador, almacenando las secreciones en el cilindro. Se reconectara el circuito de ventilación al tubo, se rotulara el cilindro con los datos del paciente y se mandara la muestra a bacteriología."},{"no":"4","responsable":"Enfermera","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación. Se reposicionará al paciente. Se recomienda vigilancia clínica y constantes vitales."}]'::jsonb,
'[{"riesgo":"Infección asociada a ventilación","barrera":"Experiencia y entrenamiento del médico en el procedimiento."},{"riesgo":"Lesión de vía respiratoria con dolor y sangrado","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento."},{"riesgo":"Desaturacion de oxígeno y tos","barrera":"Experiencia y entrenamiento del médico en el procedimiento."}]'::jsonb,
'[{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Microbiología de secreciones bronquiales en una unidad de cuidados intensivos. Luis Javier Casanova-Cardiel. Revista médica del Instituto Mexicano del Seguro Social. 2008","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-11'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-12  Desfibrilación ─────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Despolarizacion completa del miocardio y bloqueo de arritmias ventriculares letales.',
'Este procedimiento se inicia con el diagnóstico de la arritmia cardiaca en el contexto de un paciente hemodinamicamente inestable por parte del médico a cargo hasta la ejecución de la desfibrilacion y el abordaje de la causa.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Desfibrilador con EKG"},{"item":"Monitor con EKG"},{"item":"Pasta conductora"},{"item":"Electrodos"},{"item":"Carro rojo con equipo de reanimación cardiopulmonar e intubacion orotraqueal completo"},{"item":"Guantes"},{"item":"Cubrebocas"},{"item":"Hoja y laringoscopio"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Diagnóstico por electrocardiograma o telemetría de la arritmia ventricular (fibrilacion ventricular o taquicardia ventricular con pulso inestables). Asegurar la alteración hemodinámica asociada a la arritmia. Al ser una emergencia médica cardiológica se dará prioridad a actuar y posteriormente avisar a la familia o realizar ambos procedimientos al mismo tiempo, desistiendo únicamente en caso de que la familia o tutor decida no continuar o que previamente se haya firmado consentimiento de no maniobras o tratamiento paliativo."},{"no":"2","responsable":"Médico y Enfermera","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento, así como incorporarse al equipo de reanimación y ayudar durante el procedimiento. El médico o la enfermera con capacitación en reanimación cardiopulmonar avanzada tomarán el papel de líderes durante el procedimiento."},{"no":"3","responsable":"Médico y Enfermera","actividad":"Asegurar vía venosa permeable. Retirar prótesis dentales y objetos metálicos del cuerpo del paciente. Acomodar paciente en decúbito supino. En caso de que sea posible, se administrará sedación y analgesia al paciente sugiriendo midazolam 0.2 mg/kg dosis máxima 2 mg y fentanil 10 mcg/kg previo a la descarga. Monitorizar signos vitales en especial ritmo cardiaco y presión arterial para documentar reversión de la arritmia, así como vigilar los datos clínicos durante el procedimiento. Conectar al paciente al monitor desfibrilador y seleccionar el modo desfibrilador. Colocar las palas en el tórax con una presión de 10 a 15 kg y seleccionar los J de energía inicial recomendándose 100 j en caso de un desfibrilador bifásico e ir incrementado la energía hasta 360 j. Cerrar la fuente de oxígeno durante la descarga. Presionar el botón de carga y asegurarse de que ningún integrante del equipo de reanimación esté tocando al paciente para dar la descarga. Dar la descarga eléctrica e inmediatamente iniciar maniobras de reanimación cardiopulmonar, terminar el ciclo de reanimación y revisar el ritmo cardiaco y el estado hemodinamico para determinar necesidad de: 1) Cuidados post reanimación, 2) Nueva descarga por ritmo desfibrilable, 3) Mantener reanimación cardiaca por ritmo no desfibrilable."}]'::jsonb,
'[{"riesgo":"Parada cardiaca, fibrilacion y taquicardia ventricular, desfibrilacion, reanimación cardiopulmonar avanzada","barrera":"Experiencia y entrenamiento del médico y equipo de reanimación cardiopulmonar avanzada."},{"riesgo":"Intubacion endotraquial","barrera":"Utilizar de manera estricta las indicaciones de asepsia y antisepsia."},{"riesgo":"Muerte","barrera":"Experiencia y entrenamiento del médico y equipo de reanimación cardiopulmonar avanzada."},{"riesgo":"Quemadura en piel","barrera":"Utilizar de manera estricta las indicaciones de asepsia y antisepsia."}]'::jsonb,
'[{"nombre":"Consentimiento informado para desfibrilacion","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Bases fisiológicas de la desfibrilación ventricular. Amanda Claudia Barco. Medisur. 2018","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-12'
ON CONFLICT (document_id) DO NOTHING;

-- ── Verificación final ────────────────────────────────────────
SELECT d.code, d.current_version AS ver,
       CASE WHEN dc.id IS NOT NULL THEN 'Con contenido ✓' ELSE 'Sin contenido' END AS contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code LIKE 'PR-UCI-%'
ORDER BY d.code;
