-- ============================================================
--  UCI — Vista digital de 8 Procedimientos (PR-UCI-13..20)
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar DESPUÉS de uci_docs_13_20.sql
--
--  Control de cambios idéntico en los 8:
--    v01 18/03/2022 — Alta (Dr. Jorge Isaac Michel Gonzalez / Mtra. Ana Cecilia Zarate Bautista)
--    v02 25/03/2024 — Actualización
--  Autorización común:
--    Elaboró:  Dr. Jorge Isaac Michel González  / Jefe de Terapia Intensiva
--    Revisó:   Dr. José Gonzalo Vázquez Camacho / Director Médico
--    Autorizó: Lic. María Elena Martínez Alvarado / Dirección General
-- ============================================================

-- ── PR-UCI-13  Extubación ─────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Retirar el tubo endotraqueal al paciente bajo ventilación mecánica al haber recuperado la función respiratoria.',
'Este procedimiento se inicia con la valoración del paciente por parte del cuerpo médico, ya sea tratante o médico de guardia de terapia intensiva, la recolección del material solicitado por enfermería y la extubacion del paciente.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Equipo de aspiración: sonda, aspirador y toma de vacío."},{"item":"Equipo de oxigenación: mascarilla y fuente de oxígeno"},{"item":"Carro Rojo"},{"item":"Jeringas 10 ml"},{"item":"Tijeras"},{"item":"Gasas"}]'::jsonb,
'[{"no":"1","responsable":"Médico y Enfermera","actividad":"El médico determinará de acuerdo a la causa, la evolución, las características clínicas del paciente, la posibilidad de intentar el destete del ventilador del paciente a cargo. Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento"},{"no":"2","responsable":"Médico y Enfermera","actividad":"El paciente debe estar hemodinamicamente estable, consciente y colaborador. Previo a la extubacion el paciente debe haber pasado alguna prueba de predicción de tolerancia a extubacion y ventilación espontánea con tubo en T o con CPAP. Se explicará al paciente los pasos a seguir para su tranquilidad y colaboración. Se pondrá al paciente en sedestacion. Si es portador de sonda nasogastrica y ya no es necesario continuar con ella se deberá retirar primero. Se deben aspirar las secreciones del tubo y la boca del paciente, se cortarán las fijaciones del tubo y se desinflará el globo endotraqueal para traccionar de manera gentil el tubo hasta retirarlo de la vía aérea. Se suministrará oxígeno en mascarilla o puntas nasales como sea necesario y se mantendrá en vigilancia clínica poniendo atención en un posible fallo de extubacion y fatiga del paciente."},{"no":"3","responsable":"Enfermera","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación. Se reposicionará al paciente. Se recomienda vigilancia clínica y constantes vitales."}]'::jsonb,
'[{"riesgo":"Falla de extubacion y re intubacion endotraqueal","barrera":"Experiencia y entrenamiento del médico en el procedimiento"},{"riesgo":"Neumonía asociada a ventilación","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento"},{"riesgo":"Hipotension o hipertensión","barrera":"Vigilancia por parte del médico y enfermería de las constantes vitales, estado de alerta y patrón respiratorio para detectar de manera oportuna un fallo en la extubacion."},{"riesgo":"Broncoaspiracion","barrera":"Experiencia y entrenamiento del médico en el procedimiento"},{"riesgo":"Lesión de vía aérea","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento"}]'::jsonb,
'[{"nombre":"Proceso de extubacion","codigo":"PR-UCI-13"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Retiro de la ventilación mecánica. Guillermo David Hernandez Lopez. Medicina Crítica 2017.","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-13'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-14  Intubación Orotraqueal ────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Procedimiento que pretende introducir un tubo de respiración orotraqueal en un paciente con falla respiratoria para brindar el soporte ventilatorio hasta mejorar su estado clínico y que recobre su capacidad de respiración espontánea.',
'Este procedimiento se inicia con la valoración del paciente por parte del cuerpo médico, ya sea tratante o médico de guardia de terapia intensiva, el reconocimiento de la falla respiratoria, la recolección del material solicitado por enfermería y la intubación del paciente, asegurando la estabilidad hemodinámica y su conexión al ventilador mecánico.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Toma de oxígeno, conexión, caudalimetro provisto de agua bidestilada hasta el nivel indicado por el recipiente"},{"item":"Mascarilla de oxígeno correctamente almohadillada para que selle la nariz y la boca del paciente"},{"item":"Ventilador manual tipo ambu, bolsa de ventilación o reservo rio de oxígeno."},{"item":"Laringoscopio con sus palas de distinto tamaño"},{"item":"Toma de vacío, conexiones, aspirador, sondas de aspiración."},{"item":"Tubo oral o nasal del calibre adecuado"},{"item":"Fiador"},{"item":"Lubricante hidrosoluble"},{"item":"Cánula de guedel"},{"item":"Jeringas"},{"item":"Guantes"},{"item":"Sedante, analgésico y relajante muscular"},{"item":"Carro rojo de reanimación cardiopulmonar"},{"item":"Ventilador mecánico"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Previo a iniciar el procedimiento, el médico hablará con el paciente o con la familia a cargo para explicar los riesgos y beneficios del procedimiento y se firmará consentimiento informado."},{"no":"2","responsable":"Médico y Enfermera","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento"},{"no":"3","responsable":"Médico y Enfermera","actividad":"Se explicará el procedimiento al paciente en caso de que esté consciente para tratar de mantenerlo tranquilo. Se colocará el paciente en decúbito supino. Se mantendrá con apoyo de oxígeno y ventilación manual al paciente para mantener la oxigenación durante el procedimiento. Se aplicará el medicamento analgésico y anestésico IV primeramente y después se aplicará el relajante muscular, logrando su fácil manipulación. Se introduce el laringoscopio, con aspiración de secreciones en caso necesario. Si la orofaringe se encuentra limpia se lubrica el tubo y se aplica lidocaina, introduciéndolo en la vía aérea con o sin ayuda de un fiador. Una vez colocado se inflará el globo de seguridad y se comprobará la ventilación adecuada y simétrica en ambos hemitorax. Se fijará el tubo por parte de enfermería, junto a la cánula de guedel y en caso de tener sonda nasogastrica se fijará igualmente. Se seguirá la ventilación manual hasta programar el ventilador y posteriormente se colocará el circuito cerrado y se hará la conexión al ventilador mecánico. Se reposicionara al paciente en semifowler y se conectarán los monitores de constantes vitales y hemodinámicas para su vigilancia estrecha. Se señalizará el nivel de la arcada dentaria para evitar su desplazamiento y extracción al effector los cuidados clínicos y de enfermería como aspiración y cambio de fijadores."},{"no":"4","responsable":"Enfermera","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación. Se recomienda vigilancia clínica y constantes vitales. Se solicitará radiografía de tórax para valorar la colocación del tubo"}]'::jsonb,
'[{"riesgo":"Hipotensión","barrera":"Experiencia y entrenamiento del médico en el procedimiento"},{"riesgo":"Hipoxemia, lesión de vía aérea, intubacion difícil o imposibilidad de lograr la canulacion de vía aérea, intubacion en esófago, intubacion selectiva, estímulos vaso vagales con bradicardia e hipotension.","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento del área de trabajo redactadas en el desarrollo del procedimiento para evitar las complicaciones."},{"riesgo":"Reacciones anafilácticas a sedantes utilizados, cardio y vaso depresión.","barrera":"Experiencia y entrenamiento del médico en el procedimiento"}]'::jsonb,
'[{"nombre":"Proceso de intubacion endotraqueal","codigo":"PR-UCI-14"},{"nombre":"Consentimiento informado de intubacion endotraqueal","codigo":"No aplica"},{"nombre":"Solicitud de radiografía de tórax","codigo":"No aplica"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Secuencia rápida de intubación en el servicio de urgencias: revisión actualizada de la literatura. Javier Andrés Pineros. Universitas Medica. 2021","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-14'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-15  Monitoreo de Gasto Cardiaco ───────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Determinar de forma directa el gasto cardiaco a través de un catéter de termodilucion como parámetro de abordaje diagnóstico de choque indeterminado y/o guía de tratamiento y ajuste de medicamentos vasoactivos.',
'El procedimiento comienza con la evaluación del paciente y determinando la necesidad de medición ya sea diagnóstica o terapéutica por parte del médico tratante o de terapia intensiva, posteriormente obtener la medición a través del catéter y por último aplicar el resultado en la decisión clínica.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Evaluación del estado clínico del paciente en terapia intensiva determinando el beneficio o necesidad de realizar la medición del gasto cardiaco con objetivo de abordaje y/o tratamiento."},{"no":"2","responsable":"Médico /Enfermería","actividad":"Preparar el material y equipo de trabajo, lavarse las manos y colocarse guantes estériles y cubre bocas al manipular el catéter Asegurarse que el globo del catéter se encuentre desinflado y checar la temperatura del paciente."},{"no":"3","responsable":"Médico /Enfermería","actividad":"Pulsar el módulo de gasto cardiaco y checar que el termómetro de referencia esté sumergido en una palangana de agua fría. Calcular el gasto cardiaco tomando en cuenta que la diferencia mínima para que se calcule debe ser de 10 grados centígrados entre la temperatura sanguínea y la solución inyectada. Al iniciar las mediciones y oprimir el boton de gasto cardiaco, se debe inyectar la solución helada dentro de los siguientes 15 segundos sin sostener demasiado tiempo la jeringa en la mano para evitar calentar la solución. A los 30 segundos aparecerá en monitor un mensaje para realizar nuevamente la medición así consecutivamente enumerando las mediciones de 1 al 6 dependiendo del número de mediciones realizadas. Al concluir se pulsará tecla editar gasto cardiaco apareciendo las curvas de las mediciones expresadas en lts/min."}]'::jsonb,
'[{"riesgo":"Infección","barrera":"El procedimiento debe ser realizado por médicos con la experiencia y destreza necesaria"}]'::jsonb,
'[{"nombre":"Proceso de monitoreo de gasto cardiaco","codigo":"PR-UCI-15"},{"nombre":"MEDICIÓN INVASIVA DEL GASTO CARDÍACO EN LAS UNIDADES DE CUIDADOS CRÍTICOS. Autor*González Torrijos J. Enfermería Cardiológica. 2006","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-15'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-16  Monitoreo en Cuidados Intensivos ──────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'El paciente crítico se encuentra a menudo en un ambiente clínico cambiante. El monitoreo hemodinamico del paciente crítico tiene 4 objetivos básicos: Alertar cualquier deterioro en la función basal, observar de manera continua el comportamiento clínico, establecer pronósticos y guiar la terapéutica indicada. La monitorización incluye medidas invasivas y no invasivas, así como medidas dinámicas y estáticas. El monitoreo cardiaco nos permite analizar frecuencia, ritmo y alteraciones en las curvas del electrocardiograma que pueden alertarnos o diagnosticar algún trastorno en el funcionamiento cardiaco. El monitoreo respiratorio nos permite valorar la frecuencia, el estado ácido base, el patrón respiratorio y la saturación de oxígeno. El monitoreo hemodinamico por métodos estáticos incluyen la toma de presión arterial por brazalete como método no invasivo hasta el uso de catéter swan ganz para mediciones de presiones cardíacas y pulmonares. Los métodos dinámicos incluyen línea arterial para monitoreo de la presión arterial continua, así como mediciones de gasto cardiaco, variabilidad de pulso y variabilidad de volumen sistolico.',
'Este proceso inicia con la indicación del médico tratante o médico de turno de la terapia intensiva que recibe al paciente y que de acuerdo con el estado y el diagnóstico en el que llega, solicitará el equipo de monitoreo que sea conveniente para la atención de la persona enferma. Al tener la indicación médica el personal de enfermería solicitará y apoyará la colocación del sistema de monitoreo.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[]'::jsonb,
'[{"no":"1","responsable":"Enfermería","actividad":"Al ingreso del paciente, el personal de enfermería colocará el monitoreo básico del paciente en cuidados críticos como la sonda de pulsooximetria, el brazalete para la toma de presión arterial, la sonda urinaria para el monitoreo de la diuresis y los electrodos para la telemetría cardiaca y frecuencia respiratoria."},{"no":"2","responsable":"Médico","actividad":"En caso de que el paciente requiera algún sistema de monitoreo extra o invasivo, el médico tratante o encargado de terapia intensiva dejará la indicación escrita con todo el material necesario para la colocación."},{"no":"3","responsable":"Médico","actividad":"Previo a la colocación, se deberá explicar a familiares o tutores del paciente sobre los riesgos y beneficios del monitoreo solicitado para la firma del consentimiento informado."},{"no":"4","responsable":"Enfermería","actividad":"Una ves dada la orden y aceptado con consentimiento informado, el personal de enfermería apoyará el la solicitud del material necesario para la colocación del sistema de monitoreo."},{"no":"5","responsable":"Médico","actividad":"Una ves reunido el material, en caso de requerir un procedimiento invasivo o ser un monitoreo especializado, el médico será encargado de la colocación y calibración del equipo instalado. Así como podrá instruir al personal de enfermería para continuar con la toma de datos en la forma y frecuencia que sera necesaria."}]'::jsonb,
'[{"riesgo":"Reacciones cutáneas por contacto","barrera":"Los sistemas e instrumentos de monitoreo deben ser colocados por personal con experiencia y destreza para disminuir los riesgos que conlleva su colocación."},{"riesgo":"Materiales fomites que pueden aumentar el riesgo de colonización e infecciones.","barrera":"Así también deben ser interpretados de manera correcta para poder obtener los beneficios buscados."},{"riesgo":"Lesión uretral en caso de colocar sonda foley.","barrera":"Tanto el personal médico como el personal de enfermería deben conocer los cuidados diarios y estar al pendiente de cualquier indicio que el instrumento pueda dar que sugiera alguna de las complicaciones mencionadas."},{"riesgo":"Los instrumentos de monitoreo invasivos conllevan diferentes riesgos en su colocación y durante su mantenimiento como sangrado, lesión anatómica, riesgo de infecciones, arritmias cardiacas, reflejos vagales, entre otros que serán detallados en los procesos de colocación de cada uno de ellos.","barrera":"Los sistemas e instrumentos de monitoreo deben ser colocados por personal con experiencia y destreza para disminuir los riesgos que conlleva su colocación."}]'::jsonb,
'[{"nombre":"Prcediemiento de monitoreo en unidad de cuidados intensivos","codigo":"PR-UCI-16"},{"nombre":"Consentimiento informado para la colocación del sistema o instrumento requerido.","codigo":"FT-URG-02"},{"nombre":"MEDICIÓN INVASIVA DEL GASTO CARDÍACO EN LAS UNIDADES DE CUIDADOS CRÍTICOS. Autor*González Torrijos J. Enfermería Cardiológica. 2006","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-16'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-17  Paracentesis ───────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Drenar líquido ascitico por vía percutanea con fines diagnósticos y terapéuticos de manera eficaz.',
'Este procedimiento se inicia con la valoración del paciente por parte del cuerpo médico, ya sea tratante o médico de guardia de terapia intensiva, explicando los riesgos y con aprobación del paciente o familiar realizar el procedimiento. El médico se apoyará en enfermería para la recolección del material necesario y para su asistencia durante la paracentesis.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Ultrasonido"},{"item":"Lidocaina simple al 2%"},{"item":"Gasas"},{"item":"Guantes estériles"},{"item":"Material de asepsia (Duraprep, Cloraprep, Isodine, Clorhexidina)"},{"item":"3 Jeringas de 10 o 20 ml"},{"item":"Gel para trasductor"},{"item":"Bata quirúrgica"},{"item":"Gorro"},{"item":"Mascarilla"},{"item":"2 campos estériles"},{"item":"2 frascos de hemocultivo"},{"item":"2 a 3 tubos rojos para análisis bioquímico"},{"item":"Equipo de venopack"},{"item":"Contenedor de RPBI"},{"item":"Yelco 14 o 16"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Previo a iniciar el procedimiento, el médico hablará con el paciente o con la familia a cargo para explicar riesgos y beneficios del procedimiento y se firmará consentimiento informado. El médico a cargo del paciente iniciará el procedimiento con un rastreo ultrasonografico del abdomen evaluando las dimensiones del líquido ascitico, con el objetivo de determinar el mejor sitio de punción, así como para documentar las características del peritoneo, la presencia de engrosamiento, septos, masas o visceras que pudieran complicar el procedimiento."},{"no":"2","responsable":"Médico y Enfermería","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento"},{"no":"3","responsable":"Médico y Enfermera","actividad":"Se posicionará al paciente en decúbito supino. El médico se colocará guantes y se proporcionara por enfermería el material de aseo para limpiar el área de trabajo la cual se extiende en el abdomen anterior en especial el cuadrante inferior derecho e izquierdo dependiendo del área la cual se decidió puncionar."},{"no":"4","responsable":"Médico y Enfermería","actividad":"Enfermería apoyará al médico para vestirse con bata, gorro, mascarilla y guantes estériles. Se colocará campo estéril que delimite y aísle el área de trabajo y el material para el procedimiento. Iniciaremos cargando con lidocaina al 2% y anestesiando la zona de punción que se localiza entre el primer y segundo tercio de una línea imaginaria que se extiende de la cicatriz umbilical a la cresta iliaca derecha. En caso de tener ultrasonido se puede puncionar en cualquier zona segura observada con el transductor. Se puncionará con el yelco con aspiración continua hasta obtener retorno de líquido ascitico, posteriormente se avanzará el catéter y sacará la aguja y se colocará la línea de drenaje. Importante colocar el recipiente de RPBI para almacenar el líquido drenado."},{"no":"5","responsable":"Enfermera","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación. Se reposicionará al paciente."}]'::jsonb,
'[{"riesgo":"Infección","barrera":"El procedimiento debe ser realizado por médicos con la experiencia y destreza necesaria"},{"riesgo":"Sangrado y equimosis","barrera":"Utilizar las medidas de asepsia y antisepsia"},{"riesgo":"Dolor","barrera":"Se recomienda la técnica de punción en tiempo real ya sea en eje corto o eje largo para aumentar el porcentaje de éxito en la primera punción."},{"riesgo":"Punción visceral, vascular o vesical.","barrera":"El procedimiento debe ser realizado por médicos con la experiencia y destreza necesaria"},{"riesgo":"Descompensación hemodinámica, sepsis y muerte.","barrera":"Utilizar las medidas de asepsia y antisepsia"}]'::jsonb,
'[{"nombre":"Proceso de paracentesis","codigo":"PR-UCI-17"},{"nombre":"Consentimiento informado para la paracentesis","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Paracentesis: datos sobre la correcta utilización. Mosquera Klinger Gabriel. Universitas médica. 2018","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-17'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-18  Pericardiocentesis ────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Extraer sangre o algún otro fluido de manera percutanea del saco pericardico',
'Este procedimiento se inicia con la valoración del paciente por parte del cuerpo médico, ya sea tratante o médico de guardia de terapia intensiva, explicación de los riesgos y aprobación familiar del procedimiento. Procediendo después a realizar el procedimiento por el médico con ayuda de enfermería para la recolección del material necesario, así como su apoyo durante la pericardiocentesis.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Ultrasonido"},{"item":"Lidocaina simple al 2%"},{"item":"Gasas"},{"item":"Guantes estériles"},{"item":"Material de asepsia (Duraprep, Cloraprep, Isodine, Clorhexidina)"},{"item":"3 Jeringas de 50 ml"},{"item":"Lave de 3 vías"},{"item":"Gel para trasductor"},{"item":"Bata quirúrgica"},{"item":"Gorro"},{"item":"Mascarilla"},{"item":"Campos estériles"},{"item":"2 frascos de hemocultivo"},{"item":"2 a 3 tubos rojos para análisis bioquímico"},{"item":"Equipo de venopack"},{"item":"Contenedor de RPBI"},{"item":"Yelco 14 o 16"},{"item":"Equipo de catéter central"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Previo a iniciar el procedimiento, el médico hablará con el paciente o con la familia a cargo para explicar riesgos y beneficios del procedimiento y se firmará consentimiento informado. El médico a cargo del paciente iniciará el procedimiento con un rastreo ultrasonografico del corazón evaluando las dimensiones del líquido pericardico, con el objetivo de determinar el mejor sitio de punción, así como para documentar las características del pericardio, la presencia de engrosamiento, septos, consolidaciones que pudieran complicar el procedimiento. Finalizado el rastreo de marcará el sitio de punción."},{"no":"2","responsable":"Médico y Enfermera","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento"},{"no":"3","responsable":"Médico y Enfermera","actividad":"Se posicionará al paciente en decúbito supino. El médico se colocará guantes y se proporcionara por enfermería el material de aseo para limpiar el área de trabajo, zona xifoidea en el ángulo formado entre el apéndice xifoides y el reborde costal, con la extensión necesaria para asegurar que el procedimiento se realice de manera cómoda y libre de contaminación. Monitoreo continuo de signos vitales y ritmo cardiaco durante y posterior al procedimiento"},{"no":"4","responsable":"Médico y Enfermera","actividad":"Se recomienda hacer la punción guiada en tiempo real por usg en modo 2d, sin embargo, si no se tiene el equipo, se introduce la aguja suevamente en dirección al hombro observando la morfología del trazo electrocardiografico de V5. El yelco se introduce en aspiración continua hasta obtener retorno de líquido en la jeringa. En caso de que la aspiración del líquido sea de mucho volumen se sugiere colocar un drenaje con el equipo de catéter central con la técnica de seldinger modificado."},{"no":"5","responsable":"Enfermera","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación. Se reposicionará al paciente y se mandarán las muestras obtenidas a los análisis indicados por el médico. Se recomienda vigilancia y monitoreo cardiovascular en el periodo post pericardiocentesis."}]'::jsonb,
'[{"riesgo":"Hemotorax y Neumotorax","barrera":"Experiencia y entrenamiento del médico en el procedimiento"},{"riesgo":"Lesión de la pared cardiaca, Taponamiento cardiaco y Arritmia cardiaca.","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento"},{"riesgo":"Lesión vascular","barrera":"Utilizar ultrasonido en tiempo real"},{"riesgo":"Choque cardiogenico o hipovolemico","barrera":"Rastreo cardiaco y pulmonar al finalizar la pericardiocentesis"},{"riesgo":"Alteración del estado de alerta","barrera":"Experiencia y entrenamiento del médico en el procedimiento"},{"riesgo":"Parada cardiaca y muerte","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento"},{"riesgo":"Infección del sitio de punción y sepsis.","barrera":"Utilizar ultrasonido en tiempo real"}]'::jsonb,
'[{"nombre":"Proceso de pericardiocentesis","codigo":"PR-UCI-18"},{"nombre":"Consentimiento informado para la pericardiocentesis","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Radiografía de control","codigo":"No aplica"},{"nombre":"Guías de práctica clínica de la Sociedad Española de Cardiología en patología pericárdica. Jaime Sagristá Sauleda. Revista Española de Cardiología. 2000","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-18'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-19  Punción Lumbar ─────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Extraer líquido cefalorraquídeo con objetivo diagnóstico y/o terapéutico.',
'Este procedimiento se inicia con la valoración del paciente por parte del cuerpo médico, ya sea tratante o médico de guardia de terapia intensiva, explicación de los riesgos y aprobación familiar del procedimiento. Procediendo después a realizar el procedimiento por el médico con ayuda de enfermería para la recolección del material necesario, así como su apoyo durante la punción lumbar.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Lidocaina simple al 2%"},{"item":"Gasas"},{"item":"Guantes estériles"},{"item":"Material de asepsia (Duraprep, Cloraprep, Isodine, Clorhexidina)"},{"item":"3 tubos rojos estériles"},{"item":"Bata quirúrgica"},{"item":"Gorro"},{"item":"Mascarilla"},{"item":"Campos estériles"},{"item":"2 frascos de hemocultivo"},{"item":"Contenedor de RPBI"},{"item":"2 agujas para punción lumbar calibre 18 o 20 con estilete"},{"item":"Raquimanometro"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Previo a iniciar el procedimiento, el médico hablará con el paciente o con la familia a cargo para explicar riesgos y beneficios del procedimiento y se firmará consentimiento informado. El médico a cargo del paciente iniciará el procedimiento colocando el paciente en decúbito dorsal en posición fetal abriendo los espacios Inter vertebrales de las lumbares para determinar el mejor espacio para realizar la punción."},{"no":"2","responsable":"Médico y Enfermera","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento"},{"no":"3","responsable":"Médico y Enfermera","actividad":"Se posicionará al paciente en decúbito lateral en posición fetal con las rodillas y el mentón lo más pegadas al pecho posible. El médico se colocará guantes y se proporcionara por enfermería el material de aseo para limpiar el área de trabajo, zona lumbar en línea media e intersección con una línea perpendicular entre ambas crestas Ileanas normalmente ente L4 a L5 (zona recomendada sin embargo podría variar dependiendo de la situación anatómica de cada paciente), con la extensión necesaria para asegurar que el procedimiento se realice de manera cómoda y libre de contaminación. Monitoreo continuo de signos vitales y ritmo cardiaco durante y posterior al procedimiento"},{"no":"4","responsable":"Médico y Enfermera","actividad":"Se inicia el procedimiento anestesiando el área de punción con lidocaina en todo el trayecto de la aguja. Se avanza la aguja espinal lentamente entre los espacios lumbares perforando el ligamento amarillo y llegando al espacio del líquido cefalorraquídeo. Se retira el estilete y se recolectará el goteo de líquido cefalorraquídeo poniendo atención en las características macroscópicas del líquido obtenido. Se colocará raquimanometro para medir la presión."},{"no":"5","responsable":"Enfermera","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación. Se reposicionará al paciente en decúbito supino, se colocará apósito en el sitio de punción y se mandarán las muestras obtenidas a los análisis indicados por el médico. Se recomienda vigilancia clínica y constantes vitales."}]'::jsonb,
'[{"riesgo":"Infección del sitio de punción, meningitis y sepsis","barrera":"Experiencia y entrenamiento del médico en el procedimiento"},{"riesgo":"Cefalea post punción","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento del área de trabajo."},{"riesgo":"Arritmias cardiacas y reflejo vagal","barrera":"Experiencia y entrenamiento del médico en el procedimiento"},{"riesgo":"Dolor","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento del área de trabajo."},{"riesgo":"Reacción anafiláctica a la anestesia","barrera":"Experiencia y entrenamiento del médico en el procedimiento"},{"riesgo":"Muerte.","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento del área de trabajo."}]'::jsonb,
'[{"nombre":"Proceso de punción lumbar","codigo":"PR-UCI-19"},{"nombre":"Consentimiento informado para la punción lumbar","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Punción lumbar y medición de la presión del líquido cefalorraquídeo. Alfonso Verdua. Anuales de Pediatria Continua. 2004","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-19'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-UCI-20  Toracocentesis ─────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Drenar líquido pleural por vía percutanea con fines diagnósticos y terapéuticos de manera eficaz.',
'Este procedimiento se inicia con la valoración del paciente por parte del cuerpo médico, ya sea tratante o médico de guardia de terapia intensiva, explicación de los riesgos y aprobación familiar del procedimiento. Procediendo después a realizar el procedimiento por el médico con ayuda de enfermería para la recolección del material necesario, así como su apoyo durante la toracocentesis.',
'[]'::jsonb,
'[{"tipo":"4.1 Actualización","descripcion":"Unidad de Cuidados Intensivos"},{"tipo":"4.2 Ejecución","descripcion":"Médico tratante y/o médico de terapia intensiva"},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica"}]'::jsonb,
'[{"item":"Ultrasonido"},{"item":"Lidocaina simple al 2%"},{"item":"Gasas"},{"item":"Guantes estériles"},{"item":"Material de asepsia (Duraprep, Cloraprep, Isodine, Clorhexidina)"},{"item":"3 Jeringas de 10 o 20 ml"},{"item":"Gel para trasductor"},{"item":"Bata quirúrgica"},{"item":"Gorro"},{"item":"Mascarilla"},{"item":"2 campos estériles"},{"item":"2 frascos de hemocultivo"},{"item":"2 a 3 tubos rojos para análisis bioquímico"},{"item":"Equipo de venopack"},{"item":"Contenedor de RPBI"},{"item":"Yelco 14 o 16"}]'::jsonb,
'[{"no":"1","responsable":"Médico","actividad":"Previo a iniciar el procedimiento, el médico hablará con el paciente o con la familia a cargo para explicar riesgos y beneficios del procedimiento y se firmará consentimiento informado. El médico a cargo del paciente iniciará el procedimiento con un rastreo ultrasonografico del tórax evaluando las dimensiones del líquido pleural, con el objetivo de determinar el mejor sitio de punción, así como para documentar las características de la pleura, la presencia de engrosamiento, septos, consolidaciones que pudieran complicar el procedimiento. Finalizado el rastreo de marcará el sitio de punción."},{"no":"2","responsable":"Médico y Enfermera","actividad":"Se pedirá el material requerido al equipo de enfermería quienes serán los encargados de cargar al sistema el material y de proporcionarlo al médico que realizará el procedimiento"},{"no":"3","responsable":"Médico y Enfermera","actividad":"Se posicionará al paciente en sedestacion. El médico se colocará guantes y se proporcionara por enfermería el material de aseo para limpiar el área de trabajo la cual abarca el hemitorax posterior, con la extensión necesaria para asegurar que el procedimiento se realice de manera cómoda y libre de contaminación."},{"no":"4","responsable":"Médico y Enfermera","actividad":"Enfermería apoyará al médico que realizara el procedimiento en vestirlo con la mascarilla, bata, gorro, guantes estériles. Al vestirse, el médico colocará campo estéril en el tórax posterior que delimite aún más el área de punción y un segundo campo en la cama para colocar el material de trabajo. Se cargará lidocaina al 2% y se anestesiará en la marca de punción previamente colocada, insertando la aguja con aspiración continua por el borde superior de la costilla anestesiando de manera profunda y en retroceso en todo el trayecto de la aguja y en la piel. En otra jeringa se colocará yelco 14 o 16 donde entraremos en el punto marcado de punción y con aspiración continua introduciremos el yelco hasta obtener retorno de líquido pleural. Se deslizará el yelco y sacaremos al aguja para montar el venopack y comenzar la extracción del líquido pleural asegurándonos que el drenaje caiga en el recipiente de RPBI. En caso de que el procedimiento sea de intención diagnóstica se obtendrán las muestras necesarias para cultivo y análisis bioquímico. Se drenará aproximadamente 1000 a 1500 ml para evitar edema agudo de pulmón por re expansión. Al terminar el procedimiento sacaremos el yelco plástico y se colocará aposito con gasa. Se realizará rastreo pulmonar para descartar complicaciones."},{"no":"5","responsable":"Enfermera","actividad":"Se recogerá el material utilizado depositándose en las áreas de desecho designadas de lavandería, punzó cortantes, RPBI y basura normal para su eliminación. Se reposicionará al paciente."}]'::jsonb,
'[{"riesgo":"Hemotorax, Neumotorax y Embolia aérea.","barrera":"Experiencia y entrenamiento del médico en el procedimiento"},{"riesgo":"Lesión vascular y Arritmia cardiaca.","barrera":"Utilizar de manera estricta las indicaciones de asepsia y aislamiento."},{"riesgo":"Infecciones del sitio de salida, Infecciones del túnel o infecciones sistémicas y bacteremias.","barrera":"Se sugiere utilizar ultrasonido en tiempo real para localizar el mejor lugar y realizar la punción de manera segura, así como para realizar rastreo pulmonar al finalizar la toracocentesis para documentar neumotorax u otra complicación."},{"riesgo":"Estenosis venosa o trombosis.","barrera":"Experiencia y entrenamiento del médico en el procedimiento"}]'::jsonb,
'[{"nombre":"Proceso de colocación de marcapasos temporal venoso","codigo":"PR-UCI-20"},{"nombre":"Consentimiento informado para la colocación de marcapasos temporal venoso","codigo":"FT-URG-02"},{"nombre":"Nota de procedimiento","codigo":"No aplica"},{"nombre":"Radiografía de control","codigo":"No aplica"},{"nombre":"Actualización en el abordaje del drenaje torácico. Val-Jordán E. Sanidad a Militar. 2022","codigo":"No aplica"}]'::jsonb,
'[{"version":"01","fecha":"18/03/2022","descripcion":"Alta de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"25/03/2024","descripcion":"Actualización de documento","realizado":"Dr. Jorge Isaac Michel Gonzalez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"}]'::jsonb,
'Dr. Jorge Isaac Michel González','Jefe de Terapia Intensiva',
'Dr. José Gonzalo Vázquez Camacho','Director Médico',
'Lic. María Elena Martínez Alvarado','Dirección General'
FROM documents d WHERE d.code = 'PR-UCI-20'
ON CONFLICT (document_id) DO NOTHING;

-- ── Verificación ─────────────────────────────────────────────
SELECT d.code, d.current_version AS ver,
       CASE WHEN dc.id IS NOT NULL THEN 'Con contenido ✓' ELSE 'Sin contenido' END AS contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code BETWEEN 'PR-UCI-13' AND 'PR-UCI-20'
ORDER BY d.code;
