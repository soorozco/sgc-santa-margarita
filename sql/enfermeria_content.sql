-- ============================================================
--  Jefatura de Enfermería — Contenido de 7 Instrucciones de Trabajo
--  IT-JE-21, 33, 40, 42, 43, 44, 45
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar DESPUÉS de enfermeria_docs.sql
-- ============================================================

-- ── IT-JE-21 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Inicia aplicando las medidas precautorias y realizando higiene de manos para proceder con el manejo de la fistula arteriovenosa, finaliza con la desinstalación del equipo de la máquina de hemodiálisis.',
'Inicia aplicando las medidas precautorias y realizando higiene de manos para proceder con el manejo de la fistula arteriovenosa, finaliza con la desinstalación del equipo de la máquina de hemodiálisis.',
'[]'::jsonb,
'[]'::jsonb,
'[{"item": "Mesa de trabajo"}, {"item": "Campo estéril desechable"}, {"item": "Guante estéril desechable (2pzas) - conexión"}, {"item": "Gasa estéril 7.5 x 5cm (8pzas) - conexión"}, {"item": "Guante estéril desechable (2pzas) - desconexión"}, {"item": "Gasa estéril 7.5 x 5cm (6pzas) - desconexión"}, {"item": "Bandita adhesivo redondo (2pzas)"}, {"item": "Guante crudo desechable (4pzas)"}, {"item": "Guante estéril desechable (2pzas)"}, {"item": "Jeringa de 20ml (1pza)"}, {"item": "Jeringa 10ml (2pzas)"}, {"item": "Agujas para canulación de fistula arteriovenosa (2pzas)"}, {"item": "Cinta adherible hypafix"}, {"item": "Alcohol isopropilico 70%"}, {"item": "Microdacyn"}]'::jsonb,
'[{"no": "5.1", "responsable": "Enfermería", "actividad": "Realizar higiene de manos con agua y jabón IT-UV-01 Higiene de manos, y aplica IT-JE-18 Manejo de las medidas precautorias para el personal de hemodiálisis."}, {"no": "5.2", "responsable": "Enfermería", "actividad": "Instala al paciente en camilla o reposet asignado y realiza monitoreo de constantes vitales. IT-JE-39 Admisión, ingreso y egreso del usuario hospitalizado a la unidad de hemodiálisis. IT-JE-40 Admisión, ingreso y egreso del usuario externo a la unidad de hemodiálisis."}, {"no": "5.3", "responsable": "Enfermería", "actividad": "Verificar que el área se encuentre cerrada y evita corrientes de aire."}, {"no": "5.4", "responsable": "Enfermería", "actividad": "Prepara la mesa de trabajo y sanitiza con antiséptico (surfa safe) antes y después de procedimientos, coloca material necesario para realizar procedimiento."}, {"no": "5.5", "responsable": "Enfermería", "actividad": "Realiza lavado de manos."}, {"no": "5.6", "responsable": "Enfermería", "actividad": "Pide al paciente descubrir el área de la fistula (si requiere ayuda al paciente) da posición cómoda y asegura el sitio donde se encuentre el acceso vascular."}, {"no": "5.7", "responsable": "Enfermería", "actividad": "Realiza valoración física de la fistula o injerto, mediante observación, auscultación del soplo y palpación del trill, asegurando la posición del miembro colocándolo sobre superficie firme."}, {"no": "5.8", "responsable": "Enfermería", "actividad": "Abre el equipo de material, set de conexión estéril y agrega las 2 agujas para la punción, dos jeringas de 10 ml, dos guantes estériles, jeringa de 20 ml y prepara las cintas adhesivas hypafix para la fijación."}, {"no": "5.9", "responsable": "Enfermería", "actividad": "Calza un guante en la mano dominante y prepara el material para iniciar asepsia, carga jeringa de 20ml con solución salina y coloca por debajo del área de la fistula el campo estéril desechable."}, {"no": "5.10", "responsable": "Enfermería", "actividad": "Vierte en tres gasas 7.5 x 5cm alcohol isopropilico y en tres gasas más 7.5 x 5cm el antiséptico y se coloca el segundo guante."}, {"no": "5.11", "responsable": "Enfermería", "actividad": "Inicia al aseo de la fistula con las gasas impregnadas con alcohol, realizando movimientos circulares del centro a la periferia, abarcando todo el cuerpo de la fistula, hasta completar tres tiempos y desecha, permitiendo que el alcohol seque solo."}, {"no": "5.12", "responsable": "Enfermería", "actividad": "Realiza la asepsia con las gasas impregnadas con antiséptico, de igual manera en movimientos circulares del centro a la periferia, hasta completar tres tiempos y deja actuar el antiséptico el tiempo especificado por el fabricante, y con gasa seca retira el excedente."}, {"no": "5.13", "responsable": "Enfermería", "actividad": "Se retira y desecha primer par de guantes estériles, y se calza un segundo par, mientras se focaliza el área de anastomosis en caso de fistula autóloga o sitio quirúrgico para injertos protésicos."}, {"no": "5.14", "responsable": "Enfermería", "actividad": "Se inicia con la punción arterial tomando como referencia la anastomosis o sitio quirúrgico, para realizarla a 3cm de distancia y dirigida hacia dichos puntos, a 25 grados de inclinación si es autóloga y 45 grados si es protésica, y observa flujo sanguíneo, conecta jeringa de 10ml y succiona para probar permeabilidad."}, {"no": "5.15", "responsable": "Enfermería", "actividad": "Realiza la punción venosa en la parte superior de la fistula en sentido de la circulación hacia el corazón, observando que exista flujo sanguíneo, conecta la segunda jeringa de 10 ml probando permeabilidad."}, {"no": "5.16", "responsable": "Enfermería", "actividad": "Realiza técnica de fijación de forma inicial por la parte posterior de la aguja y después por las aletillas, evitando girar las agujas antes de la fijación y corrobora la correcta función de las punciones con la jeringa de 20ml pre-llenada antes de conectar a las líneas del circuito extracorpóreo."}, {"no": "5.17", "responsable": "Enfermería", "actividad": "Conecta las extensiones de las agujas al circuito extracorpóreo cubriendo las uniones con gasa estéril 7.5 x 5cm y fija las líneas del circuito para inmovilizarlas."}, {"no": "5.18", "responsable": "Enfermería", "actividad": "Notifica al médico tratante en caso de observar disfunción de flujo, flujo insuficiente, infiltraciones o molestia en sitios."}, {"no": "5.19", "responsable": "Enfermería", "actividad": "Procede al inicio del tratamiento hemodiálisis IT-JE-26 Intervención de enfermería en el tratamiento de hemodiálisis."}, {"no": "5.20", "responsable": "Enfermería", "actividad": "Valora el estado del paciente durante el procedimiento, mantiene vigilancia del estado de las punciones, verifica permeabilidad y flujo con la máquina, así como constantes vitales del paciente."}, {"no": "5.21", "responsable": "Enfermería", "actividad": "Finaliza sesión, notifica al usuario que se procederá a la desconexión, verifica el retorno sanguíneo del circuito extracorpóreo con solución salina al 0.9% en circuito cerrado y cierre de clamps, verificando que no existan corrientes de aire antes de la desconexión."}, {"no": "5.22", "responsable": "Enfermería", "actividad": "Realiza higiene de manos IT-UV-01 Higiene de manos con agua y jabón, abre el equipo de desconexión estéril y cierra las pinzas de las extensiones de las agujas."}, {"no": "5.23", "responsable": "Enfermería", "actividad": "Calza un par de guantes estériles y desconecta las líneas del circuito de las extensiones de las agujas, toma una gasa estéril seca 7.5 x 5cm retira la aguja proximal y hace hemostasia, procede misma técnica con la aguja distal."}, {"no": "5.24", "responsable": "Enfermería", "actividad": "Realiza hemostasia con el dedo medio e índice de cada mano en cada sitio punción, durante un tiempo de 10 a 15 minutos, o hasta que se confirme la hemostasia; valora que no exista sangrado posterior a ese tiempo y coloca banditas adhesivas."}, {"no": "5.25", "responsable": "Enfermería", "actividad": "Realiza higiene de manos con solución alcoholada, se calza guantes crudos y procede a la desinstalación del equipo de hemodiálisis. PR-JE-08 Manejo de RPBI."}, {"no": "5.26", "responsable": "Enfermería", "actividad": "Observaciones: Puede apoyarse de almohadas para dar una posición cómoda y segura para el usuario sobre la extremidad a usarse, evitando fatiga por posición forzada. No se recomienda técnica de ojal o punción focalizada en injerto arteriovenoso. No debe saltarse prueba de permeabilidad y función de punciones. Si se observa disminución de flujo o infiltraciones, debe valorarse retiro de aguja y nueva punción, notificando siempre al médico tratante."}]'::jsonb,
'[{"riesgo": "Fístula arteriovenosa infiltrada por punción incorrecta", "barrera": "Valoración eficiente de la anatomía de la fistula arteriovenosa. Aplicar técnica de punción adecuada. Verificar flujo sanguíneo."}, {"riesgo": "Acceso vascular con datos de infección", "barrera": "Mantener técnica de barrera máxima al manipular la fistula y las líneas. Uso de antisépticos adecuados y limpieza eficiente de piel y conectores."}, {"riesgo": "Desconexión accidental de las líneas hemáticas", "barrera": "Fijación correcta de las líneas durante la sesión de hemodiálisis."}]'::jsonb,
'[{"nombre": "Secretaria de salud (2018) Manual para el cuidado estandarizado de enfermería a la persona con acceso vascular para hemodiálisis", "codigo": "No aplica"}, {"nombre": "Higiene de manos con agua y jabón", "codigo": "IT-UV-01"}, {"nombre": "Manejo de medidas precautorias", "codigo": "IT-JE-18"}, {"nombre": "Intervención de enfermería en el tratamiento de hemodiálisis", "codigo": "IT-JE-26"}, {"nombre": "Admisión, ingreso y egreso del usuario hospitalizado a la unidad de hemodiálisis", "codigo": "IT-JE-39"}, {"nombre": "Admisión, ingreso y egreso del usuario externo a la unidad de hemodiálisis", "codigo": "IT-JE-40"}, {"nombre": "Manejo de residuos peligrosos biológicos infecciosos", "codigo": "PR-JE-08"}]'::jsonb,
'[{"version":"01","fecha":"Julio 2021","descripcion":"Alta de documento","realizado":"Toledo Casas Gerardo","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"Agosto 2024","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"03","fecha":"Septiembre 2025","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Juan Carlos Vanegas Reyes"}]'::jsonb,
'Lic. Juan Carlos Vanegas Reyes', 'Jefatura de enfermería',
'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'
FROM documents d WHERE d.code = 'IT-JE-21'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
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

-- ── IT-JE-33 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Inicia con la indicación medica de un medicamento vía oftálmica y finaliza al registrar la administración en la hoja de enfermería.',
'Inicia con la indicación medica de un medicamento vía oftálmica y finaliza al registrar la administración en la hoja de enfermería.',
'[]'::jsonb,
'[]'::jsonb,
'[{"item": "Guantes limpios"}, {"item": "Gasas chicas estériles"}, {"item": "Medicación"}, {"item": "Apósitos"}, {"item": "Para irrigación: suero salino estéril o agua inyectable"}, {"item": "Hoja de registros clínicos de enfermería"}]'::jsonb,
'[{"no": "5.1", "responsable": "Enfermería", "actividad": "Corrobora indicación médica sobre la administración de medicamentos vía oftálmica."}, {"no": "5.2", "responsable": "Enfermería", "actividad": "Confirma frecuencia de instilaciones y el ojo a tratar; para identificar el ojo se suele utilizar OD (ojo derecho), OI (ojo izquierdo), AO (ambos ojos)."}, {"no": "5.3", "responsable": "Enfermería", "actividad": "Corrobora con el medico si la información no es clara o percibe alguna discrepancia."}, {"no": "5.4", "responsable": "Enfermería", "actividad": "Solicita medicamento y material al área de farmacia."}, {"no": "5.5", "responsable": "Enfermería", "actividad": "Preparar la dosis revisando las instrucciones del medicamento (Si es necesario)."}, {"no": "5.6", "responsable": "Enfermería", "actividad": "Aplica los correctos en la administración de medicamentos y acciones esenciales para la seguridad del paciente. PR-JE-04 MISP.4 Procedimientos correctos. PR-JE-03 MISP.2 Mejorar la seguridad de los medicamentos de alto riesgo. FT-JE-20 cartel AESP."}, {"no": "5.7", "responsable": "Enfermería", "actividad": "Identifica al paciente. PR-JE-01 MISP.1 Identificar correctamente a los pacientes y corrobora alergias del paciente."}, {"no": "5.8", "responsable": "Enfermería", "actividad": "Organiza el material y prepara al paciente."}, {"no": "5.9", "responsable": "Enfermería", "actividad": "Aplica los 10 correctos en la administración de medicamentos."}, {"no": "5.10", "responsable": "Enfermería", "actividad": "Explica el procedimiento al paciente."}, {"no": "5.11", "responsable": "Enfermería", "actividad": "Ayuda al paciente a adoptar una posición cómoda, decúbito dorsal o fowler con la cabeza inclinada un poco hacia atrás."}, {"no": "5.12", "responsable": "Enfermería", "actividad": "Realiza higiene de manos IT-UV-01 Higiene de manos con agua y jabón."}, {"no": "5.13", "responsable": "Enfermería", "actividad": "Realiza limpia de ojo y las pestañas: se coloca guantes, humedece una gasa estéril con suero estéril para irrigación, limpia desde el canto interno hasta el canto externo del ojo y desecha. Si es necesario, repite los pasos usando una gasa nueva."}, {"no": "5.14", "responsable": "Enfermería", "actividad": "Pide al paciente que mire para arriba, disminuyendo la probabilidad de que parpadee."}, {"no": "5.15", "responsable": "Enfermería", "actividad": "Expone el saco conjuntival inferior, coloca el pulgar o los dedos de la mano no dominante en el hueso malar del paciente, y tira suavemente de la piel de la mejilla."}, {"no": "5.16", "responsable": "Enfermería", "actividad": "Instila el número de gotas indicado en el tercio externo del saco conjuntival inferior."}, {"no": "5.17", "responsable": "Enfermería", "actividad": "Mantiene el cuentagotas a una distancia de 1 a 2 cm por encima del saco conjuntival inferior. Si el dispensador toca al paciente, se considerará contaminado. Dejar la tapa boca arriba para evitar contaminación."}, {"no": "5.18", "responsable": "Enfermería", "actividad": "Pide al paciente que cierre los ojos suavemente sin apretar los párpados."}, {"no": "5.19", "responsable": "Enfermería", "actividad": "Presionar el conducto nasolagrimal con una gasa después de instilar un líquido para evitar que vaya hacia las vías nasales."}, {"no": "5.20", "responsable": "Enfermería", "actividad": "Limpia y seca con una gasa estéril los párpados, desde el canto interno del ojo hacia el externo para eliminar el exceso de medicamento."}, {"no": "5.21", "responsable": "Enfermería", "actividad": "Aplica una compresa ocular si es necesario."}, {"no": "5.22", "responsable": "Enfermería", "actividad": "Valora la respuesta del paciente inmediatamente después de la instilación o de la irrigación, y más tarde, en el momento en el que la instilación debe haber actuado."}, {"no": "5.23", "responsable": "Enfermería", "actividad": "Rotula y resguarda medicamento en casillero o refrigerador según corresponda al tipo de medicamento."}, {"no": "5.24", "responsable": "Enfermería", "actividad": "Realizar el registro correspondiente."}]'::jsonb,
'[{"riesgo": "Medicamento mal administrado por error en la indicación médica", "barrera": "Revisar la indicación medica previo a la administración y aclarar con el medico cualquier duda."}, {"riesgo": "Medicamento mal administrado por omisión en la aplicación de los correctos", "barrera": "Aplicar los correctos de la administración de medicamentos que apliquen al preparar y al administrar."}, {"riesgo": "Contaminar vial del medicamento por mal manejo", "barrera": "Respetar la distancia recomendada entre el vial y la zona a administrar, cuidando que nunca tengan contacto."}]'::jsonb,
'[{"nombre": "MISP.1 Identificar correctamente a los pacientes", "codigo": "PR-JE-01"}, {"nombre": "MISP.2 Mejorar la seguridad de los medicamentos de alto riesgo", "codigo": "PR-JE-03"}, {"nombre": "MISP.4 Procedimientos correctos", "codigo": "PR-JE-04"}, {"nombre": "Cartel AESP", "codigo": "FT-JE-20"}, {"nombre": "Higiene de manos con agua y jabón", "codigo": "IT-UV-01"}]'::jsonb,
'[{"version":"01","fecha":"Julio 2021","descripcion":"Alta de documento","realizado":"Toledo Casas Gerardo","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"Agosto 2024","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"03","fecha":"Septiembre 2025","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Juan Carlos Vanegas Reyes"}]'::jsonb,
'Lic. Juan Carlos Vanegas Reyes', 'Jefatura de enfermería',
'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'
FROM documents d WHERE d.code = 'IT-JE-33'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
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

-- ── IT-JE-40 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Inicia cuando el personal de admisión brinda información al paciente sobre los requisitos para recibir sesión de hemodiálisis, termina cuando el familiar entrega el pase de salida en el área de hemodiálisis y egresa del área.',
'Inicia cuando el personal de admisión brinda información al paciente sobre los requisitos para recibir sesión de hemodiálisis, termina cuando el familiar entrega el pase de salida en el área de hemodiálisis y egresa del área.',
'[]'::jsonb,
'[]'::jsonb,
'[{"item": "Silla de ruedas"}, {"item": "Gorro desechable"}, {"item": "Cubre boca desechable"}, {"item": "Silla reposet reclinable"}, {"item": "Báscula con rampa"}, {"item": "Termómetro de sensor digital"}, {"item": "Baumanometro y estetoscopio"}, {"item": "Oxisensor de pulso"}]'::jsonb,
'[{"no": "5.1", "responsable": "Admisión", "actividad": "Recibe llamadas telefónicas de pacientes externos que requieren el servicio de hemodiálisis. PR-JE-02 MISP 2. Mejorar la comunicación efectiva."}, {"no": "5.2", "responsable": "Admisión", "actividad": "Notifica documentación requerida para ser admitidos en el servicio de hemodiálisis, así como horarios y disponibilidad del servicio."}, {"no": "5.3", "responsable": "Admisión", "actividad": "Requisitos del servicio: 1. Indicaciones de hemodiálisis con sello o firma de médico nefrólogo con fecha no mayor a un mes. 2. Estudios de laboratorio no mayor a un mes (BH, UREA, CREAT, ES). 3. Serologías para virus de Hepatitis C, VIH y antígeno de superficie de hepatitis B, no mayor a 6 meses. En caso de programar sesión es indispensable que el paciente presente todos los requisitos."}, {"no": "5.4", "responsable": "Enfermería", "actividad": "Programa sesiones de hemodiálisis (día, mes y hora), verificando que se tenga lugar y no se empalme con otras sesiones programadas."}, {"no": "5.5", "responsable": "Enfermería", "actividad": "Informa a médico encargado del servicio, el ingreso de paciente nuevo al área, si cuenta con médico tratante o si requiere valoración médica."}, {"no": "5.6", "responsable": "Enfermería", "actividad": "Verifica asistencia de pacientes al servicio de hemodiálisis, en caso de ser de nuevo ingreso, que cuente con la documentación requerida para poder proporcionar la atención."}, {"no": "5.7", "responsable": "Enfermería", "actividad": "Llama a la sala de espera por su nombre y apellido al usuario programado para su tratamiento de hemodiálisis, recibe indicación médica, laboratorios y solicita consentimiento informado."}, {"no": "5.8", "responsable": "Enfermería", "actividad": "Una vez revisados los requisitos, da ingreso al paciente al servicio, en caso de requerir apoyo para el traslado solicita apoyo del servicio de camillería, informando el dispositivo que se requiere."}, {"no": "5.9", "responsable": "Enfermería", "actividad": "Realiza Lavado de manos IT-UV-01 Higiene de manos con agua y jabón, y aplica IT-JE-18 Manejo de medidas precautorias para el personal de hemodiálisis. Coloca al paciente en posición semifowler y se elevan miembros inferiores."}, {"no": "5.11", "responsable": "Enfermería", "actividad": "Proporciona gel alcoholado al usuario y se le enseña a realizar técnica de higiene de manos."}, {"no": "5.12", "responsable": "Enfermería", "actividad": "Coloca bata hospitalaria, gorro desechable, y cubre boca al usuario, además de aplicar las medidas precautorias. IT-JE-18 Manejo de medidas precautorias para el personal de hemodiálisis."}, {"no": "5.13", "responsable": "Enfermería", "actividad": "Realiza lavado de manos clínico IT-UV-01 Higiene de manos con agua y jabón, para proceder a la toma de signos vitales."}, {"no": "5.14", "responsable": "Enfermería", "actividad": "Toma signos vitales pre hemodiálisis al usuario y los registra en reporte de enfermería, coloca monitoreo continúo utilizando el equipo de la máquina de hemodiálisis: Presión arterial, Frecuencia cardiaca, Temperatura corporal, Frecuencia respiratoria, Saturación de oxigeno, Peso seco (si se conoce), Peso al ingreso."}, {"no": "5.15", "responsable": "Enfermería", "actividad": "Valora las condiciones del paciente, si cuenta con fistula o con catéter y si está funcional, e informa al médico si presenta alguna alteración."}, {"no": "5.16", "responsable": "Enfermería", "actividad": "Inicia tratamiento de hemodiálisis IT-JE-26 Intervención de enfermería en el tratamiento de hemodiálisis. IT-JE-20 Manejo y cuidado de acceso vascular para hemodiálisis - catéter. IT-JE-21 Manejo y cuidado de acceso vascular para hemodiálisis - FAVI."}, {"no": "5.17", "responsable": "Enfermería", "actividad": "Finalizado el tratamiento, sienta al usuario elevando respaldo y bajando miembros inferiores en silla reposet, toma una última presión arterial para el registro de enfermería y corroborar estabilidad del usuario para darle egreso y le retira gorro, cubrebocas y guante."}, {"no": "5.18", "responsable": "Enfermería", "actividad": "Asiste al paciente para ponerlo de pie si no puede por el mismo, en caso necesario pide apoyo del servicio de camillería, y se procede a obtener el peso final del paciente."}, {"no": "5.19", "responsable": "Enfermería", "actividad": "Realiza cargos de los insumos utilizados e informa a administración sobre el egreso del paciente."}, {"no": "5.20", "responsable": "Enfermería", "actividad": "Orienta al familiar para que pase al área de administración."}, {"no": "5.21", "responsable": "Enfermería", "actividad": "Recibe pase de salida y egresa al paciente del área."}]'::jsonb,
'[{"riesgo": "Paciente ingresado sin contar con los requisitos necesarios", "barrera": "Dar información precisa y clara sobre los requisitos para recibir sesión de hemodiálisis. Revisar cumplimiento de requisitos previo a ingresar al área."}, {"riesgo": "Infección adquirida por arrastre de microorganismos", "barrera": "Cumplir con higiene de manos respetando los 5 momentos. Cumplir con los protocolos para ingreso y egreso del área."}, {"riesgo": "Paciente con inestabilidad hemodinámica", "barrera": "Monitorizar signos vitales paciente y estado del paciente."}]'::jsonb,
'[{"nombre": "Manejo de medidas precautorias para el personal de hemodiálisis", "codigo": "IT-JE-18"}, {"nombre": "Manejo y cuidado de acceso vascular para hemodiálisis - catéter", "codigo": "IT-JE-20"}, {"nombre": "Manejo y cuidado de acceso vascular para hemodiálisis - FAVI", "codigo": "IT-JE-21"}, {"nombre": "Intervención de enfermería en el tratamiento de hemodiálisis", "codigo": "IT-JE-26"}, {"nombre": "MISP 2. Mejorar la comunicación efectiva", "codigo": "PR-JE-02"}, {"nombre": "Higiene de manos con agua y jabón", "codigo": "IT-UV-01"}]'::jsonb,
'[{"version":"01","fecha":"Julio 2021","descripcion":"Alta de documento","realizado":"Toledo Casas Gerardo","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"Agosto 2024","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"03","fecha":"Septiembre 2025","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Juan Carlos Vanegas Reyes"}]'::jsonb,
'Lic. Juan Carlos Vanegas Reyes', 'Jefatura de enfermería',
'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'
FROM documents d WHERE d.code = 'IT-JE-40'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
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

-- ── IT-JE-42 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Inicia con la indicación medica de administración de medicamento nebulizado, continua con la preparación del medicamento en el área designada para ello y termina cuando el medicamento está listo para administrase.',
'Inicia con la indicación medica de administración de medicamento nebulizado, continua con la preparación del medicamento en el área designada para ello y termina cuando el medicamento está listo para administrase.',
'[]'::jsonb,
'[]'::jsonb,
'[{"item": "Agua inyectable"}, {"item": "Solución salina al 0.9%"}, {"item": "Jeringas de 5 o 10 ml"}, {"item": "Aguja morada o amarilla"}, {"item": "Medicamento solicitado"}]'::jsonb,
'[{"no": "5.1", "responsable": "Enfermería", "actividad": "Al recibir la indicación médica de administración de medicamento nebulizado, Informa a terapia respiratoria. PR-JE-02 comunicación efectiva."}, {"no": "5.2", "responsable": "Terapia respiratoria", "actividad": "Recibe información de enfermería y acude al servicio donde se solicita la administración."}, {"no": "5.3", "responsable": "Terapia respiratoria", "actividad": "Corrobora información en las indicaciones médicas, aplica los 10 correctos en la administración de medicamentos. PR-JE-01 MISP.1 Identificar correctamente a los pacientes. Administra medicamentos al momento y establece horarios de administración."}, {"no": "5.4", "responsable": "Terapia respiratoria", "actividad": "Solicita insumos y medicamentos de farmacia."}, {"no": "5.5", "responsable": "Terapia respiratoria", "actividad": "Realiza lavado de manos IT-UV-01 higiene de manos con agua y jabón."}, {"no": "5.6", "responsable": "Terapia respiratoria", "actividad": "Verifica indicación médica y prepara el medicamento en el área limpia destinada para la preparación. IT-JE-29 Preparación, etiquetado y administración de medicamentos."}, {"no": "5.7", "responsable": "Terapia respiratoria", "actividad": "Prepara medicamentos al momento de administrar, evitar dejar medicamentos preparados por tiempo prolongado."}, {"no": "5.8", "responsable": "Terapia respiratoria", "actividad": "De ser necesario realiza dilución de medicamento, con una jeringa de 5 o 10 ml toma la cantidad requerida."}, {"no": "5.9", "responsable": "Terapia respiratoria", "actividad": "Agrega solución inyectable o salina al 0.9% según la indicación médica (2 a 4 ml)."}, {"no": "5.10", "responsable": "Terapia respiratoria", "actividad": "Si es medicamento en atomización, además de aplicar los 10 correctos en la administración de medicamentos, verificara el adecuado funcionamiento del dispositivo."}, {"no": "5.11", "responsable": "Terapia respiratoria", "actividad": "Coloca la etiqueta de identificación correspondiente al medicamento."}, {"no": "5.12", "responsable": "Terapia respiratoria", "actividad": "Evita la mezcla de fármacos en el mismo nebulizador, excepto cuando es por indicación médica y se asegura su compatibilidad y estabilidad."}, {"no": "5.13", "responsable": "Terapia respiratoria", "actividad": "Valora la integridad del medicamento durante su preparación y antes de administrarlo."}]'::jsonb,
'[{"riesgo": "Comunicación inadecuada entre el equipo multidisciplinario", "barrera": "Reforzar en enfermería la notificación oportuna a terapia respiratoria al iniciar o modificar tratamiento."}, {"riesgo": "Medicamento administrado a destiempo u omisión de la administración", "barrera": "Al ser nueva indicación sin horario de administración especifico se administra al momento."}, {"riesgo": "Medicamento contaminado por prepararse en lugar inadecuado", "barrera": "Preparar medicamento en el área de terapia respiratoria, de ser necesario podrá usar el área en las centrales de enfermería."}]'::jsonb,
'[{"nombre": "MISP.1 Identificar correctamente a los pacientes", "codigo": "PR-JE-01"}, {"nombre": "MISP.2 Comunicación Efectiva", "codigo": "PR-JE-02"}, {"nombre": "Higiene de Manos con agua y jabón", "codigo": "IT-UV-01"}, {"nombre": "Preparación, etiquetado y administración de medicamentos", "codigo": "IT-JE-29"}]'::jsonb,
'[{"version":"01","fecha":"Julio 2021","descripcion":"Alta de documento","realizado":"Toledo Casas Gerardo","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"Agosto 2024","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"03","fecha":"Septiembre 2025","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Juan Carlos Vanegas Reyes"}]'::jsonb,
'Lic. Juan Carlos Vanegas Reyes', 'Jefatura de enfermería',
'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'
FROM documents d WHERE d.code = 'IT-JE-42'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
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

-- ── IT-JE-43 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Inicia al recolectar material reutilizable, llevarlo al área de terapia respiratoria y procesarlo, termina con el almacenamiento del mismo dentro del área.',
'Inicia al recolectar material reutilizable, llevarlo al área de terapia respiratoria y procesarlo, termina con el almacenamiento del mismo dentro del área.',
'[]'::jsonb,
'[]'::jsonb,
'[{"item": "ANTIBENZIL Jabón para uso pre quirúrgico líquido y neutro (pH 7)"}, {"item": "STERILEX (GLUTARALDEHIDO) potencializado al 10.5%"}, {"item": "Agua bidestilada"}, {"item": "Mesas de trabajo"}, {"item": "Contenedores para la preparación de soluciones"}, {"item": "Isipós"}, {"item": "Gasas"}, {"item": "Guante crudo"}, {"item": "Sabana"}, {"item": "Bolsa transparente"}]'::jsonb,
'[{"no": "5.1", "responsable": "Enfermería", "actividad": "Informa a terapia respiratoria sobre el termino de tratamiento o egreso del paciente. IT-JE-45 Desmontaje y sanitización de material y equipo."}, {"no": "5.2", "responsable": "Terapia respiratoria", "actividad": "Atiende notificación de fin de tratamiento, alta, o retiro de equipo correspondiente al servicio de terapia respiratoria. Equipo de reúso - ventiladores y altos flujos: válvulas de exhalación, membranas de exhalación, cable sensor de temperatura, calentador de cable. Otros: Toma de oxigeno, Borboteadores, Ohio nebulizador térmico."}, {"no": "5.3", "responsable": "Terapia respiratoria", "actividad": "Corrobora con enfermería y área médica, el termino de tratamiento. PR-JE-02 MISP.2 Comunicación efectiva. Cuando se descarta el oxígeno en pacientes que lo requirieron, pero continuarán hospitalizados, se esperarán 24 horas posterior al retiro del dispositivo utilizado."}, {"no": "5.4", "responsable": "Terapia respiratoria", "actividad": "Realiza lavado de manos según IT-UV-01 Lavado de manos con agua y jabón y se presenta en habitación, en caso de haber paciente aún, explica procedimiento, y realiza el retiro del equipo. PR-JE-05 Reducir el riesgo de infecciones asociadas a la atención sanitaria."}, {"no": "5.5", "responsable": "Terapia respiratoria", "actividad": "Traslada el material recolectado en bolsas de plástico trasparente hasta su área de trabajo para realizar el lavado y desinfección. Nota: equipo usado en pacientes infecto-contagioso se desecha al término de su uso, directamente en RPBI de cada área clínica."}, {"no": "5.6", "responsable": "Terapia respiratoria", "actividad": "Se coloca el equipo de protección (bata, guantes, goggles, cubre bocas) durante el desarmado y lavado del material reutilizable."}, {"no": "5.7", "responsable": "Terapia respiratoria", "actividad": "Retira previa colocación de guantes el equipo de la bolsa de plástico, lo desarma y revisa su integridad, si está en condiciones adecuadas lo sumerge en preparado con antibenzil por 40 min."}, {"no": "5.8", "responsable": "Terapia respiratoria", "actividad": "Transcurrido el tiempo se coloca guantes limpios y retira el material del antibenzil, realiza un lavado con agua corriente, revisa que no queden residuos de ningún tipo en el equipo."}, {"no": "5.9", "responsable": "Terapia respiratoria", "actividad": "Sumerge el equipo en la solución antiséptica sterilex previamente preparada, aproximadamente 30 minutos, con el fin de eliminar hongos, bacterias y virus."}, {"no": "5.10", "responsable": "Terapia respiratoria", "actividad": "Transcurrido el tiempo, procede con el retiro del material utilizando guantes limpios."}, {"no": "5.11", "responsable": "Terapia respiratoria", "actividad": "Realiza enjuague con agua bidestilada, asegurándose de no dejar residuos."}, {"no": "5.12", "responsable": "Terapia respiratoria", "actividad": "Coloca el material en la mesa de trabajo sobre la sabana para su escurrimiento y secado."}, {"no": "5.13", "responsable": "Terapia respiratoria", "actividad": "Una vez escurrido, revisa que esté completamente seco, en caso de tener residuo de agua, se limpiara con una gasa."}, {"no": "5.14", "responsable": "Terapia respiratoria", "actividad": "El material y equipo que requiera esterilización por el servicio de ceye se entregará después de ser sanitizado y desinfectado."}, {"no": "5.15", "responsable": "Terapia respiratoria", "actividad": "Realiza el empaquetado y rotula con fecha y nombre de la persona que realizó la sanitización y desinfección del equipo que no se envía a ceye (toma de oxígeno y borboteadores)."}, {"no": "5.16", "responsable": "Terapia respiratoria", "actividad": "Almacena en el espacio designado."}]'::jsonb,
'[{"riesgo": "Equipo inseguro por proceso de lavado, desinfección y almacenamiento incorrecto", "barrera": "Apego a la secuencia de actividades de lavado y desinfección. Embalaje y almacenamiento acorde al equipo."}, {"riesgo": "Equipo averiado por manejo inadecuado", "barrera": "Limpieza y desinfección acorde al equipo a tratar. No reutilizar equipo de un solo uso."}, {"riesgo": "Comunicación inadecuada entre personal de enfermería y terapia respiratoria", "barrera": "Notificación oportuna de enfermería a terapia respiratoria para el retiro de equipos."}]'::jsonb,
'[{"nombre": "NOM-045-SSA2-2005 Para la vigilancia epidemiológica, prevención y control de las infecciones nosocomiales", "codigo": "No Aplica"}, {"nombre": "Higiene de Manos con agua y jabón", "codigo": "IT-UV-01"}, {"nombre": "MISP.2 Comunicación Efectiva", "codigo": "PR-JE-02"}, {"nombre": "Reducir el riesgo de infecciones asociadas a la atención sanitaria", "codigo": "PR-JE-05"}]'::jsonb,
'[{"version":"01","fecha":"Julio 2021","descripcion":"Alta de documento","realizado":"Toledo Casas Gerardo","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"Agosto 2024","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"03","fecha":"Septiembre 2025","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Juan Carlos Vanegas Reyes"}]'::jsonb,
'Lic. Juan Carlos Vanegas Reyes', 'Jefatura de enfermería',
'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'
FROM documents d WHERE d.code = 'IT-JE-43'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
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

-- ── IT-JE-44 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Inicia al determinar el material, equipo o ropa que se necesitara según el procedimiento a realizar, se solicita en el área de CEYE y finaliza al regresar el equipo o material de reúso limpio o la ropa sucia.',
'Inicia al determinar el material, equipo o ropa que se necesitara según el procedimiento a realizar, se solicita en el área de CEYE y finaliza al regresar el equipo o material de reúso limpio o la ropa sucia.',
'[]'::jsonb,
'[]'::jsonb,
'[{"item": "Vale de instrumental y material o ropa reusable (FT-JE-43)"}, {"item": "Instrumental y material"}, {"item": "Ropa reusable"}]'::jsonb,
'[{"no": "5.1", "responsable": "Enfermería (circulante, quirúrgica, de piso)", "actividad": "Identifica material necesario para el procedimiento que se realizará. PR-JE-04 MISP 4. Procedimientos Correctos."}, {"no": "5.2", "responsable": "Enfermería (circulante, quirúrgica, de piso)", "actividad": "Solicita el FT-JE-43 Vale de instrumental y material o ropa reusable, a la enfermera del servicio de CEYE."}, {"no": "5.3", "responsable": "Enfermera de CEYE", "actividad": "Entrega el FT-JE-43 Vale de instrumental y material o de ropa reusable, según sea el caso a la enfermera que lo solicita."}, {"no": "5.4", "responsable": "Enfermería (circulante, quirúrgica, de piso)", "actividad": "Elabora vale de instrumental y material o ropa reusable necesaria para el procedimiento a realizar."}, {"no": "5.5", "responsable": "Enfermería (circulante, quirúrgica, de piso)", "actividad": "Especifica sala o servicio donde se realizará el procedimiento, fecha, insumos necesarios, cantidad requerida, nombre y firma de la enfermera que solicita."}, {"no": "5.6", "responsable": "Enfermería (circulante, quirúrgica, de piso)", "actividad": "Corrobora que el instrumental o material requerido sea el adecuado antes de entregar el vale."}, {"no": "5.7", "responsable": "Enfermera de CEYE", "actividad": "Verifica el correcto llenado del vale, asegurándose que este completo y con datos legibles."}, {"no": "5.8", "responsable": "Enfermera de CEYE", "actividad": "Entrega el material solicitado a enfermería, realizando cotejo con el material solicitado."}, {"no": "5.9", "responsable": "Enfermería (circulante, quirúrgica, de piso)", "actividad": "Confirma realizando doble verificación con la enfermera de CEYE de cada uno de los materiales solicitados."}, {"no": "5.10", "responsable": "Enfermería (circulante, quirúrgica, de piso)", "actividad": "Comprueba la caducidad del instrumental y bultos de ropa, si es correcta continúa con el uso de este en sala, o área a utilizar."}, {"no": "5.11", "responsable": "Enfermería (circulante, quirúrgica, de piso)", "actividad": "En caso de observar algún deterioro o imperfecto en el material, que ponga en riesgo la seguridad del procedimiento, regresa el material y solicita uno en condiciones adecuadas para su uso."}, {"no": "5.12", "responsable": "Enfermera de CEYE", "actividad": "Resguarda vale de instrumental y material o de ropa reusable, hasta que se realice la entrega del material utilizado."}, {"no": "5.13", "responsable": "Enfermería (circulante, quirúrgica, de piso)", "actividad": "Al finalizar el uso del material solicitado, lo entregara a ceye completo, previamente lavado y seco, la ropa reusable se coloca en el séptico."}, {"no": "5.14", "responsable": "Enfermera de CEYE", "actividad": "Recibe material limpio, en condiciones adecuadas para su procesamiento y desecha el formato de solicitud."}]'::jsonb,
'[{"riesgo": "Material, instrumental o ropa extraviada al entregarse sin vale", "barrera": "Llenado completo y oportuno del vale para tener control de las piezas que salen de CEYE."}, {"riesgo": "Vales mal requisitados o no legibles", "barrera": "Llenar la solicitud con letra legible y con datos completos."}, {"riesgo": "Instrumental incompleto al entregar o recibir", "barrera": "Contar material al recibirlo y entregarlo en la ventanilla de CEYE."}]'::jsonb,
'[{"nombre": "MISP 4. Procedimientos Correctos", "codigo": "PR-JE-04"}, {"nombre": "Vale de instrumental y material o de ropa reusable", "codigo": "FT-JE-43"}]'::jsonb,
'[{"version":"01","fecha":"Julio 2021","descripcion":"Alta de documento","realizado":"Toledo Casas Gerardo","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"Agosto 2024","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"03","fecha":"Septiembre 2025","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Juan Carlos Vanegas Reyes"}]'::jsonb,
'Lic. Juan Carlos Vanegas Reyes', 'Jefatura de enfermería',
'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'
FROM documents d WHERE d.code = 'IT-JE-44'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
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

-- ── IT-JE-45 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Inicia al quedar sola la habitación posterior al egreso del paciente, dando manejo al equipo electromédico, retirar ropa hospitalaria, equipos, frasco y clasificar RPBI, termina cuando la habitación está lista para el aseo.',
'Inicia al quedar sola la habitación posterior al egreso del paciente, dando manejo al equipo electromédico, retirar ropa hospitalaria, equipos, frasco y clasificar RPBI, termina cuando la habitación está lista para el aseo.',
'[]'::jsonb,
'[]'::jsonb,
'[{"item": "SURFA-SAFE"}, {"item": "Franela morada"}, {"item": "Tánico de traslado"}, {"item": "Bote de basura"}, {"item": "Bolsa para RPBI"}, {"item": "Equipo electromedico usado durante la atención del paciente (bomba de infusión, pentapie, monitor de signos vitales, desfibrilador)"}]'::jsonb,
'[{"no": "5.1", "responsable": "Enfermería", "actividad": "Identifica material a desechar como basura común: frascos, equipos de infusión, pañales, gasas, etc. y lo deposita en el bote correspondiente. Notifica a terapia respiratoria sobre el alta de pacientes que recibían oxigeno suplementario."}, {"no": "5.1b", "responsable": "Terapia respiratoria", "actividad": "Retira equipos, dispositivos, humidificadores y realiza la limpieza y sanitización correspondiente a su área. IT-JE-43 Sanitización y desinfección de equipo reusable de terapia respiratoria."}, {"no": "5.2", "responsable": "Enfermería", "actividad": "Identifica y clasifica material considerado RPBI y realiza su desecho de acuerdo con PR-JE-08 Proceso para el manejo de RPBI y NOM-087-SEMARNAT-SSA1-2002."}, {"no": "5.3", "responsable": "Enfermería", "actividad": "Sigue lo mencionado en IT-JE-27 Retiro y clasificación de ropa sucia o contaminada e IT-JE-46 Manejo de ropa hospitalaria. Retira ropa sucia y la clasifica como contaminada y no contaminada. Cuenta y deposita en tánico de traslado la ropa no contaminada. Cuenta y deposita en bolsa transparente la ropa contaminada y coloca etiqueta correspondiente."}, {"no": "5.4", "responsable": "Enfermería", "actividad": "Registra en el formato FT-JE-42 vale de ropa sucia toda la ropa considerada como sucia."}, {"no": "5.5", "responsable": "Enfermería", "actividad": "Retira equipo electromédico de habitación o unidad que no queda en cultivo (bombas de infusión, monitores, oxímetro), y realiza la sanitización correspondiente con SURFA-SAFE y franela morada, posterior lo coloca en el lugar que le corresponde conectándolos a la luz."}, {"no": "5.6", "responsable": "Enfermería", "actividad": "Si la habitación o cubículo queda en cultivo, el equipo electromédico se limpia y se queda en la habitación; se retira hasta que el cultivo salga negativo."}, {"no": "5.7", "responsable": "Enfermería", "actividad": "Revisará que en la habitación no quede material por desechar o equipo (jeringas, agujas, frascos de soluciones, equipo electromédico, etc.)"}, {"no": "5.8", "responsable": "Enfermería", "actividad": "Informa al área de intendencia para proceder con la sanitización de la habitación y el mobiliario (colchón, cama, buro, tripie, mesa puente, otros) de acuerdo con el PR-UV-02 Proceso para la preparación de habitación."}]'::jsonb,
'[{"riesgo": "RPBI desechado de manera incorrecta", "barrera": "Apego al proceso para el manejo de RPBI y la NOM-087. Abastecimiento de bolsa roja y amarilla para RPBI en los diferentes servicios."}, {"riesgo": "Basura común olvidada en habitación", "barrera": "Capacitar al personal sobre la identificación y desecho correcto de frascos, equipos y pañales."}, {"riesgo": "Equipo electromedico sanitizado de manera incorrecta", "barrera": "Abastecer SURFA-SAFE y franela morada en todos los servicios. Vigilar apego a la limpieza correcta del equipo electromedico."}]'::jsonb,
'[{"nombre": "NOM-087-SEMARNAT-SSA1-2002 protección ambiental - Residuos peligrosos biológicoinfecciosos - Clasificación y especificaciones de manejo", "codigo": "No Aplica"}, {"nombre": "Proceso para el manejo de RPBI", "codigo": "PR-JE-08"}, {"nombre": "Retiro y clasificación de ropa sucia o contaminada", "codigo": "IT-JE-27"}, {"nombre": "Manejo de ropa hospitalaria", "codigo": "IT-JE-46"}, {"nombre": "Vale de ropa sucia", "codigo": "FT-JE-42"}, {"nombre": "Proceso para la preparación de habitación", "codigo": "PR-UV-02"}, {"nombre": "Sanitización y desinfección de equipo reusable de terapia respiratoria", "codigo": "IT-JE-43"}]'::jsonb,
'[{"version":"01","fecha":"Julio 2021","descripcion":"Alta de documento","realizado":"Toledo Casas Gerardo","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"02","fecha":"Agosto 2024","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Ana Cecilia Zarate Bautista"},{"version":"03","fecha":"Septiembre 2025","descripcion":"Actualización de documento","realizado":"Mendoza Garcia Mayda Guadalupe","aprobado":"Juan Carlos Vanegas Reyes"}]'::jsonb,
'Lic. Juan Carlos Vanegas Reyes', 'Jefatura de enfermería',
'Dra. Giselle Ivette De la Torre García',  'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'
FROM documents d WHERE d.code = 'IT-JE-45'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
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
       CASE WHEN dc.id IS NOT NULL THEN 'Contenido OK ✓' ELSE '⚠ Sin contenido' END AS content_status
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code IN ('IT-JE-21','IT-JE-33','IT-JE-40','IT-JE-42','IT-JE-43','IT-JE-44','IT-JE-45')
ORDER BY d.code;