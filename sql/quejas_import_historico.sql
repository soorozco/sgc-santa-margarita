-- ══════════════════════════════════════════════════════════════════
-- Importación histórica de Quejas — Seguimiento de Buzón
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Importa 154 registros históricos (folios CA25xx) con su ciclo
-- completo: datos de captura + seguimiento (columna JSON 'seguimiento').
-- Requiere antes: sql/quejas_seguimiento_setup.sql
--
-- Status: 'Cerrada'→cerrado, 'No concluida'→en_proceso; los demás quedan
-- 'cerrado' por ser históricos (reabre manualmente los que sigan abiertos).
-- Re-ejecutable: NO duplica (omite folios ya existentes). origen='historico'
-- (el robot de sincronización no los toca). Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2501', '2025-03-03', 'queja', 'ZAIRA ESMERALDA ANDRADE REYES', '116',
       '3334044343', 'sclub7_zaira@hotmail.com', 'Urgencias', 'Personal Médico',
       'Ayer en la noche traje a mi papa a urgencias porque se cayo y traia fracturadas las costillas de la 3 a la 9 , lo traje aqui por ser un hospital de tercer nivel desde anoche me dijeron que ya venia el medico Fernando Murillo y nunca llego todo el dia de hoy diciendome que ya viene y nada, un enfermero me hizo el favor de pasarme su numero de telefono del medico ,le hable y me dijo que toda la informacion se la habian dado mal que lo mandaron al hospital chapalita a ver a mi papa y a la habitacion 216 informacion totalmente incorrecta estamos muy molestos con la falta de profesionalismo del hospital , el doctor dijo que mandaria a un colega y espero en verdad llegue y puedan atender a mi papa como se debe y que cada cuenta economicamente y trae mucho dolor.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Urgente", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Comunicación efectiva", "origen_seg": "Físico", "revision_expediente": "NO", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "ZAIRA ESMERALDA ANDRADE REYES", "investigacion": "Error en el número del médico, falta de comunicación efectiva", "investiga": "Administración", "medio_notificacion": "Personal", "fecha_notificacion": "2025-03-03", "persona_notifica": "Administración", "resolucion": "Paciente atendido por médico tratante", "fecha_resolucion": "2025-03-03", "notif_solicitante": "SI", "fecha_notif_solicitante": "2025-03-03", "observaciones": "Atendida directamente por administración"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2501');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2502', '2025-03-12', 'queja', 'Miguel Barrera Ureña', 'UP 10',
       '55 3835 2585', '@', 'Enfermería', 'Personal de enfermería',
       'Familiar refiere tuvo una mala experiencia con personal de enfermería a su ingreso hace dos días, menciona enfermería del turno vespertino no se presentó nunca para atender a su paciente hasta el cambio de turno. Fue cuando se presentó el enfermero de la noche, Daniel, a quien agradece sus atenciones y el servicio bien dado.

Además, comentó el servicio de dietas (cocina) para su paciente no fue el adecuado, ya que esta tiene una edad de 96 años y usa placa, y no cuenta con dentadura, y esta no fue la adecuada para su paciente.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Comunicación efectiva", "origen_seg": "Buzón", "fecha_validacion": "2025-03-12", "hora_validacion": "4:00:00 p.m.", "revision_expediente": "SI", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "NO", "recibe_llamada": "No aplica", "investigacion": "No fue posible tener comunicación con el paciente o familiar, se le llamo en 3 ocasiones y no se obtuvo respuesta. En expediente si se cuenta con la atención por parte de enfermería en los registros clínicos del mismo, el personal comenta si presentarse con el paciente.", "investiga": "Giselle De la Torre", "medio_notificacion": "No realizada", "persona_notifica": "No aplica", "resolucion": "Sin respuesta para la resolución", "fecha_resolucion": "2025-03-12", "notif_solicitante": "NO", "observaciones": "Familiar/paciente no contesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2502');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2503', '2025-03-11', 'queja', 'EFREN RAMIREZ MORIN', '5  JUAN PABLO II',
       '3331595006', 'bryanmaydequeen@gmail.com', 'Enfermería', 'Personal de enfermería',
       'Guadalajara, Jalisco, Mexico, a 13 de marzo de 2025

Hospital Santa Margarita
Calle Garibaldi 880, Jesús, 44200 Guadalajara, Jal.

Áreas de Dirección y Calidad, Dra. Giselle de la Torre:  
( ENVIO FOTOGRAFIAS DE EVIDENCIA AL NUMERO WHATSAPP YA QUE NO DEJO ADJUNTARLAS SU SERVIDOR POR ESPACIO)

Por este medio le hago llegar mi Queja con relación a su personal médicos de guardia y enfermería responsables de atender al paciente: Salvador Baltazar Ramirez Arias en la habitación numero 5 (Juan Pablo II) el día 11 de marzo del presente año, en los que hubo negligencia en los cuidados que deberían de seguir con el paciente. Aun cuando el Dr. Armando Cueva Martínez. Dejo claras indicaciones de mantener disponible el suministro del líquido necesario para su limpieza interna, ambas bolsas se encontraban vacías, tuvimos que ir a pedirles que las resurtieran, la falta de monitoreo en las necesidades del paciente se siguieron presentando, la bolsa donde se desaloja el agua que esta realizando esta limpieza interna, (colocada en la parte inferior de la cama) se llenó por completo y por el mismo peso se rompió el sujetador cayendo al piso fue del modo que nos percatamos que estaba completamente llena, tuvimos que ir con enfermería para pedirles que la vaciaran, a lo que nos auxilió al parecer la supervisora de enfermería que estaba ahí en su base o modulo por que el enfermero de la mañana nos dio la impresión estaba muy ocupado con otras habitaciones, incluso nosotros familiares del paciente tuvimos que ayudarle a esta enfermera supervisora a detenerle dicha bolsa para que pudiera vaciarla en el urinario, esto generó que algo del líquido con sanguaza se tirara en el piso, posteriormente fue evidente la falta de comunicación entre todo su personal, cuando finalmente el enfermo que estaba ocupado regresa a atender al paciente, no tenía conocimiento de lo sucedido con la bolsa que se llenó ni del porque estaba esa agua con sanguaza tirada en el piso, nos dijeron que enviarían a su personal de aseo , pero cuando llega tampoco sabía a qué iba, nos preguntaba qué era lo que necesitábamos…
Cuando el Dr. que realizó la cirugía hace su visita al paciente aproximadamente 10 de la noche, se percata que tenía sangrado, producto del descuido anteriormente mencionado en el que al estar la bolsa inferior llena y no dar paso a la liberación del líquido  que se está suministrando, causo una distención que genero ese sangrado que posteriormente causo coágulos que el Dr. tuvo que dedicar tiempo para extraerlos, el Dr. les llamó la atención por que dicha bolsa estaba sujetada de una manera inapropiada con algo improvisado

 
a lo que les requirió se hiciera el reemplazo de esta bolsa, después de realizada la intervención del Doctor, 
 

la habitación quedo sucia en piso y en la mesa de alimentos, se les pidió que vinieran a limpiar la habitación y eso no sucedió hasta la mañana del día siguiente, después de que se retira el Doctor,

 

mi Papa empieza a tener dolores muy fuertes, se pide asistencia al enfermero, y de manera muy desatinada se ríe haciendo el comentario de que porque que no se puso mal cuando el Doctor aún estaba ahí..., se le hace la observación de que no se riera y que hiciera algo al respecto, se les pide que intervenga el médico de guardia, pero después de un rato seguían sin enviarlo, tuve que ir a su módulo de enfermería  y la Dra.  Paola Nuñez  no hizo por pararse de su lugar para revisar al paciente, con una total actitud de indiferencia, solo decía que era normal por que lo acababan de manipular, mi Papa sigue presentando fuertes dolores para lo que se le pidió nuevamente a la Dra.  Paola Nuñez que por favor lo revisara, se dirige a la habitación a la fuerza con una actitud negativa, sin entrar completamente a la habitación, mira de reojo y de manera apática, sigue con su mismo argumento de que es normal por que lo manipularon y que ella no puede hacer nada, nosotros tuvimos que comunicarnos con su médico tratante quien realizo la cirugía, para reportarle el malestar que estaba presentando mi Papa, ya que esta Doctora de guardia no pudo hacer eso. Está situación vuelve a propiciar que mi Papá tuviera coágulos y espasmos en su vejiga por ello el dolor tan intenso y es que el Doctor Armando Cueva Martínez debe acudir de nuevo al hospital a las 12 pm de la noche del mismo 11 de marzo para  extraer el liquido manualmente de su vejiga y liberarlo del líquido.

Pongo a su consideración lo sucedido y cuento con que tomará cartas en el asunto.

Atentamente,
 
Efrén Ramirez Morín 
(Familiar del señor Salvador Baltazar Ramirez Arias)', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Jefatura de Calidad", "fecha_validacion": "2025-03-11", "hora_validacion": "11:54:00 a.m.", "revision_expediente": "SI", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "EFREN RAMIREZ MORIN", "investigacion": "Se entrevista personalmente al paciente y a los hijos, recabando la información, se sigue con contacto vía whats app", "investiga": "Giselle De la Torre", "medio_notificacion": "Personal", "persona_notifica": "Giselle De la Torre", "resolucion": "Paciente egresado sin complicaciones", "fecha_resolucion": "2025-03-13", "notif_solicitante": "SI"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2503');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2504', '2024-03-18', 'queja', 'Sra Alicia', 'Sin Número',
       '3322656386', NULL, 'Urgencias', 'Otros',
       'Es un servicio muy decadente la atención pésima no tienen material adecuado y el poco que tienen de muy baja calidad.', 'historico', 'cerrado', '{"procede": "No", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2024-03-18", "hora_validacion": "4:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "No aplica", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Sin datos", "investigacion": "No existen datos de contacto", "investiga": "Giselle De la Torre", "medio_notificacion": "No realizada", "persona_notifica": "No aplica", "resolucion": "No procede, debido a que no se cuenta con datos", "fecha_resolucion": "2024-03-18", "notif_solicitante": "NO", "observaciones": "Sin datos"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2504');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2505', '2025-03-26', 'felicitacion', 'Susana Rubio Camacho', 'ambulatorio',
       '3310432372', NULL, 'Hemodiálisis', 'Personal de enfermería',
       'quiero felicitar al personal de enfermería por su atención y compromiso , y al personal de intendencia por mantener tan limpias las áreas.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2025-03-26", "hora_validacion": "4:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "NO", "recibe_llamada": "No aplica", "investigacion": "No fue posible tener comunicación con el paciente o familiar, se le llamo en 3 ocasiones y no se obtuvo respuesta.", "investiga": "Giselle De la Torre", "medio_notificacion": "No realizada", "persona_notifica": "No aplica", "resolucion": "Sin respuesta para la resolución", "fecha_resolucion": "2025-03-26", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2505');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2507', '2025-04-14', 'felicitacion', 'Miguel Felipe Ordaz Godinez', '116',
       '3931671118', '18940166mfog@gmail.com', 'Banco de Sangre', 'Personal de enfermería',
       'Fui donador de sangre y el personal del área se porto de manera explendida conmigo tuve una mala experiencia en una donación anterior y está vez fue muy diferente excelente atención si donaría de nuevo', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2025-04-30", "hora_validacion": "2:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "SI", "recibe_llamada": "Miguel Felipe Ordaz Godinez", "investigacion": "Buen trato en banco de sangre", "investiga": "Giselle De la Torre", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "Se envia felicitación", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2507');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2508', '2025-04-09', 'queja', 'Ara Arceo', 'NA',
       '3312636529', NULL, 'Intendencia', 'Personal de Intendencia',
       'Para reportar

1.⁠ ⁠Los baños de urgencias son usados cómo baños públicos.

Intenté usar el de damas y me encontré con un señor (hombre) vaciando su bolsa de orina t haciendo un desmadre, con los pantalaboes a medio bajar o subir. 

Y LA PUERTA ABIERTA cosa mas violenta y desagradable


No tengo porque entrar a un sitio seguro y encontrarme con esa escena

Reporté a la chica del mostrador, quien  muy amablemente, puso cara "¿de que quiere que yo haga?"

Pues que le digas al inútil del tipo de seguridad que revise lo que pasa a unos pasos, vaya y revise.

Por si fuera poco, solicito usar otro baño, me indican que estan disponible en 1 y 2 nivel. Decido ir al 2 nivel... Vaya cosa!!!


Apestoso a huevo de días!!

A mal aseado, a mil usos en una jornada... A que son insuficientes los servicios del baño 🤮🤮🤮

Mal lavado, en fin, tengo necesidad de usarlo. Lo uso, trato de lavarme las manos y no joda... El despachador jabón tiene jabón y no funciona la bomba

En verdad no hay quien supervise esto!!', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Áreas administrativas", "origen_seg": "Otros medios", "fecha_validacion": "2025-04-09", "hora_validacion": "11:30:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Mensaje", "intentos_llamada": "No aplica", "respuesta_llamada": "SI", "recibe_llamada": "Ara Arceo", "investigacion": "Baño sucios", "investiga": "Giselle De la Torre", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "Limpieza de baños con retroalimnetación por parte de seguridad e higiene", "notif_solicitante": "SI"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2508');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2506', '2025-03-16', 'queja', 'Yadira Vanessa Jauregui', '117',
       '3316009809', NULL, 'Enfermería', 'Personal de enfermería',
       'Mi hermana llegó en ayuno. Confió en la referencia y entró con dolor y continuó con dolor.
El hematoma continuó igual. ¿Cómo manejaría el dolor?
Mi hermana no tenía medicamento. Faltó el dolor el Adoch.

Yo se lo hice saber a la enfermera. Necesitaba algo para el dolor y ella fue y después
la doctora dijo: “ya se lo pusimos”, pero ya no pusieron nada de medicamento.
Fue un tratamiento que no funcionó. Yo pedí hablar con el doctor de mi hermana
por teléfono y le expliqué cómo estaba, y él me dijo que la enfermera
le dijo que ya se lo habían puesto y se salió por el voz.

O sea, si yo no veo cómo reaccionó mi hermana, era muy fácil que con todo el dolor se la llevaran.
No funcionó darle seguimiento a ese caso porque no sabíamos por qué estaba así.
Eso causó también la falta de fármaco y de otro enfoque.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "fecha_validacion": "2025-04-30", "hora_validacion": "2:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "SI", "recibe_llamada": "Rubi Jauregui (Hermana de la paciente)", "investigacion": "Mala atención por parte del personal de enfermería", "investiga": "Giselle De la Torre", "medio_notificacion": "Personal", "persona_notifica": "Giselle De la Torre", "resolucion": "Se retroalimenta a la jefatura de enfermería", "notif_solicitante": "SI"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2506');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2509', '2025-04-29', 'queja', 'Edith', 'Juan Pablo 6',
       '1234567890', NULL, 'Hospitalización', 'Personal de admisión, Personal de Cocina, Médico Tratante',
       'Al ingreso el médico tratante nos estafo, nos cobro mucho, no hubo mejoría en la paciente, tuvo una urgencia en la cual se puso grave y tenia que pasarla a terapia intensiva, me comentaron que sino pagaba no la pasaban a la terapia, pague 40 mil pesos después de eso regrese y ya no había ningún personal ni medico ni de enfermería, nadie me podia ayudar, tuve que ir a la terapia intensiva a buscar ayuda para que pasaran a mi esposa, despues las señoritas de admisión me sacaron de la habitación porque ya no tenia derecho de estar ahi eran las 23:00 hrs no soy de aqui y no sabia a donde irme, el unico que me ayudo fue el vigilante, ya tengo casi 2 meses aqui, la comida no tiene sabor, ya no me la como, no es buena la comida no tiene sabor.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Moderado", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Jefatura de Calidad", "fecha_validacion": "2025-04-29", "hora_validacion": "5:00:00 p.m.", "revision_expediente": "SI", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Esposo de manera presencial", "investigacion": "Ya redactado", "investiga": "Giselle De la Torre", "medio_notificacion": "Personal", "fecha_notificacion": "2025-05-06", "persona_notifica": "Giselle De la Torre", "resolucion": "Se retroalimenta a la jefatura de enfermería", "fecha_resolucion": "2025-05-20", "notif_solicitante": "SI", "fecha_notif_solicitante": "2025-05-20"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2509');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2510', '2025-04-24', 'queja', 'Alma Delia Navarro Mendez', 'Quirofano',
       '3310900437', NULL, 'Facturación', 'Otros',
       'En el área de contaduría no dan seguimiento, llamas a facturación, se mandan los datos al numero que vienen en la factura electrónica pero en este no responden. Se llama al numero del hospital al area correspondiente pero nada más mencionan al atender que no esta el personal que realiza las facturas, también dicen compartir los datos para seguimiento, sin embargo 4 dias después no tenemos respuesta.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Gasto de bolsillo", "subclasificacion": "Facturación", "origen_seg": "Otros medios", "fecha_validacion": "2025-04-29", "hora_validacion": "5:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Mensaje", "intentos_llamada": "No aplica", "respuesta_llamada": "SI", "recibe_llamada": "Alma Delia Navarro Mendez", "investigacion": "No coincide numero de telefono con la paciente", "investiga": "Giselle De la Torre", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "Refacturación de las facturas citadas.", "notif_solicitante": "SI"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2510');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2511', '2025-04-24', 'queja', 'María Elena Ruíz Velasco Velez', 'amb',
       '3316955712', 'maelv@yahoo.com.mx', 'Facturación', 'Otros',
       'En septiembre del 2024 estuvo hospitalizada mi madre en 3 ocasiones con ustedes, emitieron las facturas en tiempo y forma, sin mebargo, ahora que presento mi declaración con pena me entero que las facturas están mal elaboradas por lo que no tuve mi deducción correspondiente. Solicito de la manera más atenta se me refacture, las facturas con errores son: FA22114, quedo a sus órdenes.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Gasto de bolsillo", "subclasificacion": "Facturación", "origen_seg": "Otros medios", "fecha_validacion": "2025-04-29", "hora_validacion": "5:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "SI", "recibe_llamada": "María Elena Ruíz Velasco Velez", "investigacion": "Ya redactado", "investiga": "Giselle De la Torre", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "Refacturación de las facturas citadas.", "notif_solicitante": "SI"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2511');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2512', '2025-04-14', 'queja', 'Adriana Gomez Moreno', 'hemnodialisis',
       '1234567890', NULL, 'Hemodiálisis', 'Personal de enfermería',
       'Por medio de la presente y a quien corresponda expongo mi mala experiencia que he tenido ultimamente en el area de hemodialis, en las ultimas sesiones me ha tocado la atencion de varios enfermeras principianmtes las cualesevidentemente no cuentan con la experiencia necesaria para llevar a cabo un tratamiento tan delicado como es la hemodialis, esto me ha puesto a considerar seguir con mi tratamiento en este hospital, ya que supuestamente me ofrecieron uns ervicio totalmente profesional, el cual evidemtemente no lo es ya que a lo largo de las semanas han ido llegando practicantes y por lo cual exijo se me atienda solo personal realmente capacitado ya que en el costo no existe una relacion justa emtre precio calidad en el servicio, al contrario deja mucho que desear, espero esta queja llegue a los directivos correspondientes y se solucione mi molestia, de lo contrario me vere en la estricta necesidad de buscar otra opcion no sin hacer publica ante redes sociales y medios necesarios de la mala atencion que ultimamente se brinda al apciente en este hospital ya que con esto se pone en riesgo la vida de nosotros como pacientes. 
Quedo a sus ordenes y pendiente a la solucion de mi queja.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Atención recibida", "origen_seg": "Otros medios", "fecha_validacion": "2025-04-24", "hora_validacion": "3:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Adriana Gomez Moreno", "investigacion": "No quiere que la atienda el personal nuevo, solicita ser atendidos pro Griselda y cristhian y son problema. Se revisa con hemodialisis y hubo cambio de marca de aposito", "investiga": "Omar Orozco", "medio_notificacion": "Llamada telefónica", "persona_notifica": "Giselle De la Torre", "resolucion": "Se habla con enefermería el cual asignan a personal para la atencion del paciente, así como se habla con compras para el cammbio de marca de aposito (primafix por hypafix)", "notif_solicitante": "SI"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2512');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2515', '2025-05-01', 'felicitacion', 'Rosa Elena Díaz Sánchez', '115',
       '3326338069', NULL, 'Personal Médico', 'Médico Tratante',
       'La doctora Barcelona Jiménez es una ecxelente médico que te ayuda en realidad a darte más calidad de vida', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2025-05-03", "hora_validacion": "5:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "SI", "recibe_llamada": "Rosa Elena Díaz Sánchez", "investigacion": "Se corrobora la felicitación", "investiga": "Giselle De la Torre", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2515');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2516', '2025-05-07', 'felicitacion', 'Victor Avalos Herrera', 'Juan Pablo 6',
       '3314133436', 'victoravalosherrera@hotmail.com', 'Seguros', 'Personal de enfermería, Médico Tratante, Personal de seguros',
       'Enhorabuena mi felicitación y reconocimiento a todo el equipo medicina interna/ rehabilitación/ nutrición/ personal del hospital enfermería y camilleria/personal de la aseguradora que su mayor interés es la mejoría de la paciente. Dirección médica del hospital que ha coordinado y agilizado todos los insumos y gestiones necesarias en la atención. Si omití alguien les pido una disculpa pero son muchos', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Otros medios", "fecha_validacion": "2025-05-07", "hora_validacion": "5:00:00 p.m.", "revision_expediente": "SI", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Edith", "investigacion": "Se corrobora la felicitación", "investiga": "Giselle De la Torre", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2516');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2517', '2025-05-09', 'queja', 'Lia Isabella Ortega Diego', 'Pediadtría 5',
       '3343719457', NULL, 'Enfermería', 'Personal de enfermería, Personal de admisión',
       'Acude familiar de la paciente menor de edad, informa por la atención, tiene meses de nacida y se desespera con el catéter vía IV. Además, refiere que no se le administró medicamento ni suero. Sin embargo, al solicitar al personal de información que le desvincularan, el personal de rayos refirió que se haría una vez liquidada la cuenta y con pase de salida.

El masculino expresa su inconformidad mencionando que por ello dio un anticipo, por lo que además de tratarse de una bebé o niña, debería cambiar el protocolo ya que estos, por estar inconformes, se quieren arrancar el material.

Al solicitar a administración la autorización para desvincularla, se le reitera al familiar que el procedimiento correcto es que al alta médica y cierre de cuenta liquidando, se entrega pase para que se pueda preparar al paciente, de lo contrario no es posible.', 'historico', 'cerrado', '{"procede": "No", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Seguridad", "origen_seg": "Otros medios", "fecha_validacion": "2025-05-09", "hora_validacion": "4:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "NO", "recibe_llamada": "No aplica", "investigacion": "No contesta el familiar, sin embargo no procede, ya que esta establecido ya el procedmiento del hospital.", "investiga": "Giselle De la Torre", "medio_notificacion": "No realizada", "persona_notifica": "No aplica", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2517');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2518', '2025-05-09', 'queja', 'Marco ( apellido no legible )', '112',
       '3512545484', NULL, 'Enfermería', 'Personal de enfermería',
       'No pudieron sacar toma de sangre en una sola vez, posteriormente llegó otra enfermera.

No entendieron indicación del doctor para alimentos y nunca corroboraron, tuve que hacerlo directamente , después de los exámenes . Pasaron casi 3 horas reiteré varias veces y nadie supo.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Comunicación efectiva", "origen_seg": "Encuesta", "fecha_validacion": "2025-05-09", "hora_validacion": "5:00:00 p.m.", "revision_expediente": "SI", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "NO", "recibe_llamada": "No aplica", "investigacion": "Se revisan indicaciones medicas", "investiga": "Omar Orozco", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "Se otorga la dieta, se realiza la conciliacion de medicamentos", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2518');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2519', '2025-05-09', 'queja', 'Salma Valeria Ruiz Sotelo', 'NA',
       '1234567890', NULL, 'Personal Médico', 'Médico Tratante',
       'Estaba en el área de Ceye llegó el Dr. Juan José Ramírez a solicitar que se esterilizara una caja de instrumental, se realiza la inspección de la caja y observé que requería lavado, procedí a hacerlo. Después volvió el Dr. Ramírez a agendar una cirugía por ventanilla externa de Ceye, le atendí y se retiró. Para lo cual yo proseguir lavando y secando la caja que dejó al inicio. Por último volvió a querer ingresar a Ceye pidiendo en orden bata y equipo de protección para ingresar, procedí a dárselo, ordena ser amarrado de su bata y le asistí. Paso al área de material estéril. Donde estaba mi compañero Mauricio, él le apoyó y el Dr. Ramirez ordenó lo que necesitaba de material e hizo el comentario “Ah los estás lavando es que si estaba sucio y yo les dije que lo lavaron y no lo hicieron” a lo que yo le comenté “tal vez les dio miedo lavar la sierra gigli “ él dijo cual miedo fue por …” yo dijo “no si lo debemos lavar con cuidado porque está peligrosa, yo tenía pendiente de cortarme un dedo” el dijo cual miedo”que” “que te cortaste un dedo” y yo “no que tenía pendiente de cortarme uno” y procedió a reír y golpear mi cara del lado izquierdo. Yo le dije que porque lo hacía y comentó que no era su intención que le disculpara le comenté que nadie le dio el derecho de hacerlo me pidió nuevamente disculpas y no acepté y se retiró. Durante el acto dentro de Ceye estaba mi compañero Mauricio y un compañero de sistemas.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Otros medios", "fecha_validacion": "2025-05-12", "hora_validacion": "12:30:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Salma", "investigacion": "Se entrevista a la enfermera, se revisa video del os hechos", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/02/2025", "resolucion": "se cita al medico a traves del director medico para exhortar el trato del personal medico al personal de enfermería", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2519');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2520', '2025-05-09', 'felicitacion', 'Jaime Arturo Gonzalez Santillan', '7 Gine',
       '12345667', NULL, 'Hospitalización', 'Personal de enfermería, Médicos de guardia, Personal de Intendencia, Otros',
       'Solo agradecer al personal de enfermeria por su excelente atención y calidad humana no tenemos palabras para ese agradecimiento , medicos de guardia muy preparados mil gracias  MIL GRACIAS ENFERMERA alma t/nocturno , Edgar t/ matutino , Daniel t/nocturno, Vianey t/nocturno, Gaby t/matutino , alondra t/vespertino ( Excelentes Personas).
El personal de intendencia muy atentos y preparados mil gracias.
El personal de nutrición mis agradecimientos.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "fecha_validacion": "2025-05-12", "hora_validacion": "5:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "SI", "recibe_llamada": "Jaime Arturo Gonzalez Santillan", "investigacion": "Se corrobora la felicitación", "investiga": "Giselle De la Torre", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2520');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2521', '2025-05-09', 'queja', 'Luz Maria Mayorga', '112',
       '11111111', NULL, 'Administración', 'Otros',
       'El dia de hoy 12/05/2025, la supervisora de enfermería con mala actitud resolvio un cobro indebido en la cuenta de unas panales.
No hay documento que indique de la prohibición de uso de pañales externos.
Se observo problemas de comunicación entre enfermeras y médicos internos.
La enfermera diana y camilleros excelente.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Gasto de bolsillo", "subclasificacion": "Cobros injustificados", "origen_seg": "Buzón", "fecha_validacion": "2025-05-12", "revision_expediente": "NO", "llamada_entrevista": "No aplica", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Sin datos de contacto", "investigacion": "Sin datos de contacto", "investiga": "No aplica", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2521');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2522', '2025-05-09', 'felicitacion', 'Pablo Castillo', '1',
       '1111111111', NULL, 'Hospitalización', 'Médico Tratante',
       'El Dr. Carlos Soto y Dr. Manuel Aguilar Excelente', 'historico', 'cerrado', '{"procede": "No", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "hora_validacion": "No aplica", "revision_expediente": "NO", "llamada_entrevista": "No aplica", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Sin datos de contacto", "investigacion": "Sin datos de contacto", "investiga": "No aplica", "medio_notificacion": "No realizada", "persona_notifica": "No aplica", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2522');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2523', '2025-05-04', 'felicitacion', 'luis hector ramirez l', '113',
       '11111111111', NULL, 'Intendencia', 'Personal de Intendencia',
       'personal de limpieza muy amables, muy limpio y atentas felicidades', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "hora_validacion": "No aplica", "revision_expediente": "NO", "llamada_entrevista": "No aplica", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Sin datos de contacto", "investigacion": "Sin datos de contacto", "investiga": "No aplica", "medio_notificacion": "No realizada", "persona_notifica": "No aplica", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2523');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2513', '2025-04-24', 'queja', 'Maria Eloisa', 'JP 05',
       '1111111111', NULL, 'Hospitalización', 'Otros',
       'El vigilante persona mayor es muy prepotente y grosero', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "hora_validacion": "3:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "No aplica", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "No aplica", "investigacion": "Sin datos de contacto", "investiga": "Giselle De la Torre", "medio_notificacion": "Personal", "persona_notifica": "Giselle De la Torre", "resolucion": "Se habla con vigilante de empesa exerna y se notifica a seguridad e higiene", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2513');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2514', '2025-04-24', 'queja', 'Jose Arturo Montes', '16',
       '11111111', NULL, 'Hospitalización', 'Otros',
       'La persiana un poco dañada de la parte inferior, evitando una total privacidad. Mi paciente no se pudo bañar el baño esta super pequeño, y casi no salia agua, tal vez regadera tapada.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Infraestructura", "origen_seg": "Encuesta", "hora_validacion": "3:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "No aplica", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "No aplica", "investigacion": "Sin datos de contacto", "investiga": "Giselle De la Torre", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "Implementacion del check list de habitaciones", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2514');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2524', '2025-05-16', 'sugerencia', 'Ricardo', 'Sala de endoscopia',
       '6192099007', 'r180415@gmail.com', 'Administración', 'Otros',
       'En la sala de espera hay un teléfono que nunca dejó de alertar de llamada entrante… si urgía… pobre gente.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Comunicación efectiva", "origen_seg": "Buzón", "fecha_validacion": "2025-05-16", "hora_validacion": "3:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "NO", "recibe_llamada": "No hubo respuesta", "investigacion": "Sin respuesta a los intentos de llamada", "investiga": "Giselle De la Torre", "medio_notificacion": "No realizada", "persona_notifica": "No aplica", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2524');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2525', '2025-05-17', 'queja', 'Jorge Felix Jurado', 'Cama 13',
       '111111111111', NULL, 'Enfermería', 'Personal de enfermería, Personal de cajas',
       'Tengo un paciente Jorge Felix Jurado Cama 13 el cual cual fue internado el pasado 14 de Mayo se interna con Dx. de Cirrosis Hepatica, y trombocitopenia severa 3000 plaquetas, y se indica Tromboc hoy dia 17 y solo ha recibido 2 dosis de medicamento por la gravedad del paciente y la importancia de las dosis solicito tener mayor cuidado con estos pacientes.
Nota : Ademas se detectan 25 errores en los cobros del paciente, los cuales fueron insumos y materiales no utilizados.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Urgente", "gravedad": "Bajo", "clasificacion": "Medicamentos", "subclasificacion": "Cobros injustificados", "origen_seg": "Otros medios", "fecha_validacion": "2025-05-22", "hora_validacion": "3:00:00 p.m.", "revision_expediente": "SI", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "SI", "recibe_llamada": "medico tratante", "investigacion": "Se coorbora la omision de dosis y se revisan los cobros", "investiga": "Giselle De la Torre", "medio_notificacion": "Personal", "persona_notifica": "Giselle De la Torre", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2525');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2526', '2025-05-23', 'queja', 'Maria Isabel Nuño Bañuelos', 'gine 5',
       '3339572963', NULL, 'Enfermería', 'Personal de enfermería',
       'El jueves 22 de mayo entre 1 y 2 de la mañana pasaron de urgencia a quirófano y al llegar a la habitación despues de la cirugía le entregaron en una bolsa negra la ropa de la paciente, posteriormente pregunta sobre las placas dentales de la paciente, de las cuales le comentan que no estan, le hablan al camillero que los llevo a la habitación preguntandole sobre las placas el cual comenta que las estaban en un guante en la mesa puente de la habitación, el familiar comenta que en la mesa no habia nada, volvio a preguntar a enfermería y le comentaron que no estaban que probablemente se fueron a la basura, revisaron la basura que se habia generado hasta el momento en la habitación y no habia nada, continuo insistiendo y no obtuvo respuesta.

Además personal de enfermería no explican los procedimientos, no le comunican que medicamento aplican o para que sirve, cuando le llaman al personal de enfermería, tardan de 10 a 30 min en acudir al llamado.

El personal de enfermería lastiman a la paciente al aspirarla por la traqueostomía, parece que no están capacitadas, a diferencia del personal de inhaloterapia las cuales lo hacen con cuidado y se nota la diferencia.

Como antecedente el 1 mayo estuvo hospitalizada la paciente y una enfermera de complexion robusta no quiso nebulizar a la paciente y solo habia 2 personal de enfermería en la central lo cual no asistian al llamado de manera oportuna refiriendo que porque era festivo no habia personal.', 'historico', 'en_proceso', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Visita", "fecha_validacion": "2025-05-23", "hora_validacion": "3:00:00 p.m.", "revision_expediente": "SI", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Maria Isabel Nuño Bañuelos", "investigacion": "Se entevista personalmente con la paciente y familiar, se entrevista a personal de enfermería y camillería, no hay evidencia del resguardo de la protesis dental", "investiga": "Giselle De la Torre", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "Pasa a cobro de la protesis dental", "notif_solicitante": "SI"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2526');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2527', '2025-05-23', 'queja', 'Francisco Javier Esquivel Ramos', 'suite 3',
       '11111111111', NULL, 'Alimentación', 'Personal de Cocina',
       'En las indicaciones médicas esta registrada dieta blanda sin irritantes, sin grasa, no citricos, sin embargo al paciente le han llevado de alimentos: piña, agua de limon y comida con grasa entre otros.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Visita", "fecha_validacion": "2025-05-23", "hora_validacion": "4:00:00 p.m.", "revision_expediente": "SI", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Francisco Javier Esquivel Ramos", "investigacion": "Se entrevista al paciente y familiar y se corroboran con los alimentos", "investiga": "Giselle De la Torre", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "Se cambia el menu para la cena del paciente", "notif_solicitante": "SI"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2527');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2528', '2025-05-28', 'queja', 'X', 'X',
       '3310933174', 'neideru@hotmail.com', 'Laboratorio Clínico', 'Otros',
       'El día de ayer salió un cultivo de aspirado bronquial positivo a aspergilo de UTI 1, y se le dio un mal manejo a la caja donde se cultiva dicha muestra, ya que una química comentó que la jefa no le había puesto un papel llamado parafilm para evitar se esparza dicho hongo y pudiera afectarnos, el día de hoy la química que se dio cuenta le puso dicho embalaje para evitar contagiarnos del mismo… esta caja a su vez fue enviada a otro laboratorio para identificación de qué tipo de aspergilo es yaque el médico tratante lo solicitó para darle tratamiento a su paciente… pero no es la primera vez que se pone en riesgo la salud de todos los que laboramos en laboratorio por negligencia de dicha persona, no se vale.🥲 Hago dicha queja ya que yo hice la solicitud al otro laboratorio para que vinieran por dicha muestra y me hicieron hincapié como debíamos enviar la muestra que debía estar bien sellada con dicho papel parafilm y fue cuando la química en turno dijo “si, ya lo hice porque ya te la sabes que diario es lo mismo y ella no entiende, aquí nos arriesga a todos incluso a ella. 🥲', 'historico', 'cerrado', '{"procede": "No", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Proceso", "origen_seg": "Buzón", "fecha_validacion": "2025-05-28", "hora_validacion": "4:00:00 p.m.", "revision_expediente": "NO", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Neiredu", "investigacion": "Se entrevista a la recepcionista del área, la jefa del laboratorio y la quimica, sin embaro si se realizo el proceso como se realiza institucionalmente", "investiga": "Giselle De la Torre", "medio_notificacion": "Correo", "persona_notifica": "Giselle De la Torre", "resolucion": "Proceso correcto", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2528');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2529', '2025-06-09', 'sugerencia', 'Marisela Tejeda', '112',
       '3315181814', 'mtejedalopez@gmail.com', 'Cafetería', 'Personal de Cocina',
       'Creo que se debe dejar de calentar el agua en el microondas.... Y dejar de usar los vasos de unicel en el microondas.... Ya que el aparato actúa en razón a rayos fuertes.... Y lo que le produce los rayos  al unicel produce desprendimiento de tóxicos  en los alimentos que se calientan ... Optaría por usar vidrio para calentar y ya vaciar al vaso de para preparar el café o té.... (Sinceramente el recalentar los alimentos en el microondas es dáñino) les pediría investigar ..  y dar el mejor manejo de alimentos en el microondas.... Gracias', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Equipo y mobiliario", "origen_seg": "Buzón", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "No aplica", "investigacion": "No aplica", "investiga": "No aplica", "medio_notificacion": "Personal", "persona_notifica": "Giselle De la Torre", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2529');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2530', '2025-06-10', 'queja', 'Georgina Garcia', 'JP-02',
       '3315522234', NULL, 'Intendencia', 'Personal de Intendencia',
       'El día de ayer martes tuve un ingreso el familiar pidió habitación intermedia que viene siendo JP pero en el sistema no se podía asignar esa habitación porque no estaba liberada y era la única habitación disponible, antes se podía liberar y se asignaba pero ahora hay una nueva modalidad que solo la encargada de Intendencia de la mañana hace esa función , la cual no está al tanto de liberar habitación o de capacitar a su personal para que cuando ella no haga su actividad otra persona de su área lo realice, siempre pasa lo mismo en el turno de la noche hemos negado habitaciones porque no están liberadas o porque antes del cambio de turno no realizaron el cambio en el censo y las dejaron listas, espero y esta queja tenga el alcance que queremos, como resultado que quiten ese conflicto de las habitaciones y que por un "mejor manejo" todo se les esté saliendo de las manos y no puedan con esa tarea asignada, en fin la solución que tuvimos se tuvo que pedir apoyo de sistemas y ellos liberaron la habitacion.', 'historico', 'cerrado', '{"procede": "No", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Áreas administrativas", "origen_seg": "Otros medios", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "No aplica", "investigacion": "Queja de procesos internos entre tecnologias de informacion y admision", "investiga": "Giselle De la Torre", "medio_notificacion": "Personal", "persona_notifica": "Giselle De la Torre", "resolucion": "Se ralizan ajustes en el censo de los pacientes", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2530');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2511', '2025-06-18', 'queja', 'ma elena de leon ruiz velazco', 'NA',
       '3316955712', NULL, 'Administración', 'Otros',
       'Facturaron con error a pesar de que se les proporcionaron todos los datos requeridos y por ese motivo el SAT no me realizo la devolucion el personal de cobranza ante quien expuse la  queja quedó de refcaturar pero hasta el momento no lo han realizado desde abril

FA 22114 MONTO 31444.43 error forma d epago en luigar de pago trajeta puso por definir y FA 22214 MONTO 7932.49 CFDI intereses por credito hipotecario.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Gasto de bolsillo", "subclasificacion": "Facturación", "origen_seg": "Buzón", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "NO", "recibe_llamada": "No aplica", "investigacion": "Seguimiento de queja de folio  CA2511", "investiga": "Giselle De la Torre", "medio_notificacion": "Personal", "persona_notifica": "Giselle De la Torre", "resolucion": "En seguimiento por contabilidad", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2511');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2532', '2025-06-01', 'felicitacion', 'Gabriela Trejo', 'Terapia intensiva',
       '3331579362', 'Gabriela.trejo@jaliscoedu.mx', 'Intendencia', 'Personal de Intendencia',
       'Durante su jornada varias veces realiza sus actividades y al pendiente de los baños y sus áreas le llaman lucero', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Infraestructura", "origen_seg": "Buzón", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "NO", "recibe_llamada": "No aplica", "investigacion": "No contesta la llamada", "investiga": "Giselle De la Torre", "medio_notificacion": "No realizada", "persona_notifica": "Giselle De la Torre", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2532');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2533', '2025-08-30', 'queja', 'Francisco Orozco', '5 JP',
       '+18327130988', 'orozcohouston@yahoo.com', 'Quirófano', 'Personal de enfermería',
       'Durante el proceso de Admisión a quirófano, recuperación y traslado a cuarto estuve al pendiente al menos 10 veces, entre 8:00 am y 1:30 pm Todas las personas a las que les pedí información, muy atentas. Después de la 1:00 pm al preguntar si mi esposa ya iba a ser trasladada al cuarto, me informan: hace rato está en cuarto!!

Cómo es posible que nadie de quirófano y nadie de sección cuartos me informe? Mi esposa estuvo sola alrededor de una hora y NADIE me notificó!!!

El resto de mi experiencia con el personal, en especial la persona de Admisión (Srita. Gaby) se ha portado de maravilla. Lástima que tenga que quejarme por pésima respuesta de enfermería sobre el momento de traslado a cuarto.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Comunicación efectiva", "origen_seg": "Buzón", "fecha_validacion": "2025-08-30", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "NO", "recibe_llamada": "No aplica", "investigacion": "No contesta la llamada", "investiga": "Giselle De la Torre", "medio_notificacion": "No realizada", "persona_notifica": "No aplica", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2533');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2537', '2025-09-03', 'queja', 'MARIA ISABEL PLASCENCIA LUNA', '13',
       '3314990102', 'NOEMILUNA70225@GMAIL.COM', 'Enfermería', 'Personal de enfermería',
       'SE PORTO MUY DESPOTA A LA HORA QUE MI HERMANA ESTABA EN QUIROFANO Y GROSERA. Y TAMBIEN AL MOMENTO QUE LE ESTABAN DICIENDO QUE MI HERMANA TRAIA DOLOR Y QUERIAMOS QUE LA PASARAN A CUARTO Y ELLA SOLO NOS TRAIA VUELTA Y VUELTA Y TUBO QUE SUBIR PERSONAL DE ADMISION Y LA MUCHACHA MUY AMABLE ELLA NOS SOLUCIONO EL PROBLEMA', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Otros medios", "hora_validacion": "12:52", "revision_expediente": "SI", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "SI", "recibe_llamada": "Isabel Plascencia", "investigacion": "Se investiga caso la enfermera no se presenta por su nombre se notifica al medico tratante y el apoya para el tramite y disminuciond el dolor", "investiga": "Giselle De la Torre", "medio_notificacion": "Personal", "persona_notifica": "Giselle De la Torre", "resolucion": "se HABLA CON EL PERSONAL DE ENFERMERIA", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2537');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2538', '2025-09-03', 'queja', 'ELENA TORRES MOSQUEDA', '218',
       '3312115911', NULL, 'Quirófano', 'Otros',
       'LESION EN DOS DEDOS DE LA MANO IZQUIERDA COMENTA LA PACIENTE QUE AL SALIR DE QUIROFNAO LA GOLPEARON EN LA PUERTA DEL QUIROFANO', 'historico', 'cerrado', '{"procede": "No", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Seguridad", "origen_seg": "Otros medios", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "NO", "recibe_llamada": "No respondio", "investigacion": "Se captura como incidente clinico", "investiga": "Giselle De la Torre", "medio_notificacion": "No realizada", "persona_notifica": "No aplica", "resolucion": "Paciente sin daño", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2538');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2534', '2025-08-31', 'sugerencia', 'Verónica rubio', 'Intendencia',
       '33 50025663', 'Vero.rubio.barba@gmail.com', 'Administración', 'Otros',
       'Solo sugerir se nos tome en cuentra al personal  nocturno  para el festejo relacionado cada mes de cumpleaños, queremos nuestro pedazo de pastel .gracias', 'historico', 'cerrado', '{"procede": "No", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Áreas administrativas", "origen_seg": "Buzón", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "No aplica", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "No aplica", "investigacion": "No aplica", "investiga": "Giselle De la Torre", "medio_notificacion": "Mensaje de texto", "persona_notifica": "Giselle De la Torre", "resolucion": "No aplica", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2534');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2542', '2025-10-03', 'queja', 'Sofia Haro', '11',
       '3334704493', NULL, 'Enfermería', 'Otros',
       'Familiar del paciente muy prepotente, refiere insatisfacción con la atención, se ofrece todos los cuidados, pero inconforme, de una manera un tanto agresiva verbalmente sin utilizar antisonantes, exigiendo cosas no de buena manera', 'historico', 'cerrado', '{"procede": "No", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2025-10-04", "hora_validacion": "18:00", "revision_expediente": "NO", "llamada_entrevista": "No aplica", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "No aplica", "investigacion": "No es queja de paciente, se deriva a direccion medica", "investiga": "Giselle De la Torre", "medio_notificacion": "No realizada", "persona_notifica": "No aplica", "resolucion": "Derivacion a direccion medica", "fecha_resolucion": "2025-10-04", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2542');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2531', '2025-06-03', 'queja', 'MARIA FERNANDA CEDILLO GUZ MAN', '113',
       '3310451540', NULL, 'Personal Médico', 'Personal de enfermería',
       'SIENDO APROXIMADAMENTE LAS 21:OO HRS DEL DIA MARTES TRES DEL PRESENTE MES Y AÑO, EM TRASLADE EN COMPAÑIA DE M IHIJA MARIA FERNANDA CEDILLO GUZMAN, EN ESTE HOSPITAL SANTA MARGARITA, CON DOMICILIO EN GARIALDI 880 LUGAR DONDE ACUDI PARA QUE MI HIJA MARIA FERNANDA RECIBIERA ATENCION MEDICA YA ESTANDO FUIMOS RECIBIDOS POR UNA DOCTRA DE GUARDIA QUIEN SE DESEMPEÑA COMO URGENCIOLOGA, MISMA QUIEN SUMINISTRO MEDICAMENTO CORRESPONIDNETE A SU CRITERIO. YA QUE M IHIJA FERNANDA TRAIA MOLESTIAS ABDMONINALES MISMAS QUE NO SE QUITARON YA SIENDO APROX 23:30 ACUDIO LA DRA EVELIN SUAREZ DE QUIEN ME QUEJO POR DAR UN PRONOSTICO ERRORNEO, MANIFIESTO Y QUIEN DIJO SER GINECOLOGA DE DICHO NOSOCOMIO QUIEN PROCEDIO A ATENDER A MI HIJA FERNANDA, POSTERIORMENTE DE LA EXPLORACION FISICA NOS PASO EN UNO DE LOS OCNSULTORIOS QUE ELLA ATIENDE A SUS PACIENTES, REALIZANDO ECOSONOGRAMA Y COMO RESULTADO SEÑALO QUE MI HIJA TENIA UNA INFECCION VAGINAL, YA AL SIGUIENTE DIA 4 DE JUNIODE ESTE AÑO, SIENDO APROX LAS 9 AM, EN AMBULANCIA NOS MANDO SACAR UN ESTUDIO ABDOMINAL FUERA DEL HOSPITAL, ASI LAS COSAS SE LE ENTREGO EN MENOS DE 2 HRS EL RESULTADO DEL ESTUDIOY FUE HASTA COMO A LAS 21:OO HRS QUE IS DIO EL RESULTADOCONCLUYENDO QUE I HIJATRAIA PIEDRAS EN EL RIÑONY ES AHI DONDE INTERVINE EL DOCTOR DE QUIEN ME QUEJO DE NOMBRE JOSE SAMUEL PARGA RAMIREZ  PERSONA QUE MANIFESTO SER UROLOGO QUIEN SE ENTREVISTO CONUN SERVIDOR EN LA HABITACION 113, QUIEN DIJO QUE EL 5 DE JUNIO A LAS 10:00 HRS MI HIJA YA ESTABA PROGRAMADA PARA ENTRAR A XIRUGIA DE LAS PIEDRAS QUE TRAIA EN EL RIÑON, ASI LAS COSAS UN AVEZ QUE MI HIJA FUE INTERVEMIDA LA ENVIO DIRECTAMENTE A SU HABITACION SIN MEDIAR PALABRA ALHUNA CON SU SERVIDOR MUBHO MENOF CON FAMILIRES QUE AHI SE ENCONTRABAN LO CUAL FUE MUY MOLESTO PARA NOSOTROS, ASI LAS COSAS EL Dr. JOSE MANUEL PARGA RAMIREZ NUNCA TUVOLA MOLESTIA DE ENTREVISTARSE CON ALGUNO DE NOSOTROS, PARA PLATICAR SPBRE LAS MOLESTIAS GRAVES QUE MI HIJA SENTIA, ASI DURO  HASTA EL DIA 7 MAYO', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Comunicación efectiva", "origen_seg": "Otros medios", "hora_validacion": "11:01:00 a.m.", "revision_expediente": "SI", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "SI", "recibe_llamada": "jose de jesus cedillo", "investigacion": "Falta de informes del medico tratante", "investiga": "Giselle De la Torre", "medio_notificacion": "Personal", "persona_notifica": "Giselle De la Torre", "resolucion": "Se cambia de medico tratante por parte de Direccion Medica, se asigna como urologo al Dr. Nishimura", "notif_solicitante": "SI"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2531');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2535', '2025-08-04', 'queja', 'Brodle B Perkings', 'uci',
       '111111', NULL, 'Alimentación', 'Personal de Cocina',
       'Buenos dias.
Quisiera hacer notar mi molestia y de la familia.
Mi suegro el Sr. Jose Cristobal Ochoa Gonzalez tuvo cirugía hace un par de dias de extraccion de vejiga y próstata invasiva, se encuentra delicado en terapia intensiva.
Como se les ocurre darle de comer carne en su jugo?
Obvio se puso muy mal el día de ayer lunes 04/08/25
Por favor necesito saber quien tomo esa decisión de darle de comer algo, tan pesado y solicitarles que tengan mas cuidado con su alimentación.

Gracias por su atención

Brodle B.Perkings', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Otros medios", "fecha_validacion": "2025-08-05", "hora_validacion": "15:00", "revision_expediente": "SI", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "SI", "recibe_llamada": "Brodle B Perkings", "investigacion": "Se investiga con la cocina, las cuales muestran evidencia de las dietas del paciente, no evolucioando al paciente nutricionalmente ya que de ayuno lo brincan a normal, siendo que en un principio si se envio la dieta correcta sin embargo el paciente no le gusto y se le hizo cambio de la misma", "investiga": "Giselle De la Torre", "medio_notificacion": "Mensaje de texto", "persona_notifica": "Giselle De la Torre", "resolucion": "El familiar solicito acudir a calidad, se le dio cita sin embargo no se presento. Hay evidencias de las dietas enviadas al paciente", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2535');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2536', '2025-08-15', 'queja', 'juan carlos venegas', 'NA',
       '111111', NULL, 'Cafetería', 'Personal de Cocina',
       'En la comida de cafeteria me salio un pelo en el platillo a las 16:00 hrs.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Otros medios", "fecha_validacion": "2025-08-15", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Juan Carlos", "investigacion": "Se investiga con cocina", "investiga": "Giselle De la Torre", "medio_notificacion": "Mensaje de texto", "persona_notifica": "Giselle De la Torre", "resolucion": "Se hablo con el personal de cocina y el afectado", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2536');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2539', '2025-09-19', 'queja', 'sergio barajas', 'NA',
       '3334555473', NULL, 'Rayos X', 'Otros',
       'Buenos dias espero que la incoformidad que presento ante las autoridades proceda de forma adecuada y conveniente oara la imagen del mismo. el tecnico llamado julio de la jornada de fin de semna y dias festivos deja bastante que desear como empleado y peor aun da mal trato a pacientes y al personal a mi cargo en RDN. tome la decision de bajar la cantidad o flujo de pacientes a enviar dicho hospital a estudios. de resonancia, proceidmientos derivaciones biopsias y nefrostomias. realice nuevos ocnvenios con otrso hospitales, me faltaria hoja para las quejas, esto es a grandes rasgos.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Otros medios", "hora_validacion": "18:20", "revision_expediente": "NO", "llamada_entrevista": "Llamada", "intentos_llamada": "SI", "respuesta_llamada": "SI", "recibe_llamada": "Micel y Sergio", "investigacion": "Se envia por whats app la evidencia de los sucesos de las diferentes quejas que tiene la empresa", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/11/2025", "resolucion": "Se da de baja al tecnico radiologo", "notif_solicitante": "SI"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2539');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2540', '2025-09-23', 'queja', 'GARCIA GARCIA MARIA ANGELA', 'JP14',
       '1111', NULL, 'Enfermería', 'Personal de enfermería, Otros',
       'Aplicación de medicamento caducado en la herida de la paciente', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Medicamentos", "subclasificacion": "Medicamentos", "origen_seg": "Otros medios", "hora_validacion": "14:00", "revision_expediente": "SI", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Dr. Federico Vazquez", "investigacion": "Se entrego el medicamento caducado de farmacia, enfermería no aplico los 5 correctos y no ser realizo la revision de caducidades en farmacia", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/12/2025", "resolucion": "Se levantan actas administrativas", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2540');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2541', '2025-09-26', 'queja', 'Paciente', 'gine',
       '111111', NULL, 'Enfermería', 'Personal de enfermería',
       'ministración de un medicamento con supuesto error de medicación relacionada a la dosis a un paciente atendida en este Hospital y que, conforme a los primeros registros, se produjo por omisión de la verificación del medicamento entregado.
Reporta la medico tratante administracion de 500 mg de rituximab , siendo la indicacion Rituximab 600 mg en 500 cc de solución salina 0.9% IV, premedicar 30 min antes de la administración del rituximab con hidrocortisona 100 mg + paracetamol 1 g + difenhidramina 25 mg IV o VO.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Medicamentos", "subclasificacion": "Medicamentos", "origen_seg": "Otros medios", "hora_validacion": "13:00", "revision_expediente": "SI", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Dra. Hematologa", "investigacion": "Entrega por parte de farmacia de dosis mayor a lo solicitado. Enfermería preparó el medicamento con la dosis correcta y devolvió el sobrante, esta devolución no fue registrada ni comunicada formalmente", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/13/2025", "resolucion": "Se recibe oficio por capital humano en la que refiere retroalimentacion al personal involucrado", "notif_solicitante": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2541');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2542', '2025-09-30', 'queja', 'ARTURO PADILLA LEDEZMA', 'NA',
       '3339681985', NULL, 'Quirófano', 'Otros',
       'El día 30 de septiembre a las 17:00 hrs sala2 de quirofano notifica la incormidad ya que la mesa de cirugia se movia constantemente y el aire acondicionado no presnetaba la temperatura adecuada', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Equipo y mobiliario", "origen_seg": "Otros medios", "hora_validacion": "7:45", "revision_expediente": "NO", "llamada_entrevista": "Mensaje", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Dr. Arturo Padilla", "investigacion": "Aire acondicionado ya dañado, la mesa funciona normal corroborado con biomedico", "investiga": "Giselle De la Torre", "medio_notificacion": "Mensaje de texto", "persona_notifica": "Giselle De la Torre", "resolucion": "Revisión por biomedico", "notif_solicitante": "SI"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2542');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2543', '2025-10-08', 'queja', 'Joselyn Ruiz', '105',
       '5532248780', 'joss2316@gmail.com', 'Personal Médico', 'Personal de enfermería, Médicos de guardia, Personal de Intendencia',
       'Mi abuelita ingresó por un cuadro de neumonía el domingo por la noche a urgencias, le hicimos la observación amable al personal que por favor tuvieran mucho cuidado porque ella ya no tenía venas, en vez de hablarle a un especialista decidieron usarla como alfilero y 6 personas diferentes terminaron picándola. La noche siguiente en su cuarto, la vía se tapó y solicité al especialista y por fin lo trajeron y además por gracia de Dios yo logré ver al chico que había logrado canalizarla el día anterior y le pedí ayuda y lograron canalizarla en dos vías. Al día siguiente les manifesté que tenía dolor y querían ponerle una tercer vía me negué porque ella ya no quería que la picaran, decidieron utilizar una vía bifurcada sin haber sido esta su primer opción a pesar de saber ya los deseos de nosotros. Ese mismo día yo me quedé de guardia con ella en la noche, esperando la administración de “cuidados paliativos” que me dijeron le serían aplicados alrededor de las 9 pm. A la 1 de la mañana ni cuidados ni doctores ni nada. Pedí hablar con el médico de guardia el cual nunca vino a presentarse y cuando llegó al cuarto literal entró con una actitud pésima diciendo “dígame “ , salí del cuarto y le comenté que estaba en espera de la medicación que me habían dicho que le iban a aplicar y me dijo que no le podían aplicar nada sin la autorización de su médico y como no era nada urgente que me esperara hasta el día siguiente. Que ningún doctor me iba a contestar porque era de noche y que me tenía que esperar si o si hasta que amaneciera. Alrededor de las 3 am mi abuelita empezó a estar muy inquieta, incómoda y a quejarse y le pedí al enfermero en turno que por favor le incrementara la dosis para que se calmara, me dijo que lo tenía que indicar el médico de guardia, le pedí que le dijera y obtuve la misma respuesta. No es una urgencia y sin indicaciones del médico tratante yo no puedo hacer nada, entonces para que esta!? Me dirigí a caja, les expuse la situación y a los 20 minutos a mi abuelita ya le estaban poniendo el medicamento. Desde el día lunes se reportó que el foco del baño parecía discoteca y después de 3 días de reporte hasta el día de hoy vinieron a cambiarlo. Mi abuelita lleva 3 días inconsciente, sin comer. Les he pedido que ya no traigan alimentos, los cuales ya han durado días en la mesa, pero no pueden dejar de traerlos sin indicación médica !!!!!!!! En el tiempo que mi abuelita ha estado aquí , solamente la han cambiado de sábanas dos veces !!!! Algunos enfermeros son súper descuidados y dejan basura encima de ella por horas. Las conexiones del cuarto son insuficientes para toda la apratologia que se necesita y optaron por traer una extensión sencilla y saturarla con cables. Mi abuelita entró por un cuadro de neumonía y hasta apenas ayer por la noche comenzaron a aspirarla porque no HABÍA INDICACIÓN MÉDICA DE HACERLOOOO A PESAR QUE DESDE EL DÍA QUE LLEGAMOS SE ESCUCHABA SÚPER CONGESTIOAnada!!!! Y justo apenas hoy que externe solo algunas cosas ya vinieron a limpiar y a llevarse cosas que llevaban días aquí. Y con gusto les doy la retroalimentación en persona porque dudo mucho que todas estas personas tratarían a si madre o familiar asi', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Buzón", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "Mensaje", "intentos_llamada": "SI", "respuesta_llamada": "NO", "recibe_llamada": "No contesto", "investigacion": "No hubo respuesta por parte de quien pone la queja", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2543');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2544', '2025-10-14', 'sugerencia', 'Ezequiel', '116',
       '3319153899', NULL, 'Cafetería', 'Otros',
       'Que haya un platillo variado por la noche, en ocasiones solo había sandwich, quesadillas y sincronizadas. Si hubiera un menú más variado', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Alimentos", "origen_seg": "Encuesta", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "Mensaje", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "No respondio el mensaje", "investigacion": "No respondio el mensaje", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2544');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2545', '2025-10-13', 'queja', 'Fatima Torres Sanchez', 'JP 14',
       '111111', NULL, 'Enfermería', 'Personal de enfermería',
       'El enfermero de la tarde que le toco estar al pendiente se comporta grosero, despota, le falta empatía tanto al enfermo como a las personas que acompañan. Para la labor que realiza le falta responsabilidad  comete errores y se los pasa a los del turno anterior, no quiere realizar su trabajo, le falta vocación de servicio. La sonda no me la retiraron cuando el médico, lo indico y cuando lo hicieron me dejaron el seg de plastico pegado a la pierna abierta, cuando se le pidio alcohol para remojar los sellitos para despejar dijo que eso no impedia que caminara, siendo que si lastimaba mi pierna al rozar. En todo su turno solo paso un avez y de malas estaba al cuerto sin tocar, nunca se presento, no nos dio su nombre. Que lastima que tenggan personas así laborando los enfermeros del turno de la tarde dejan mucho que desear y opacan el buen trabajo de los demas, solo mencione algunas cosas.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "Mensaje", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "No respondio el mensaje", "investigacion": "No respondio el mensaje", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2545');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2546', '2025-10-13', 'felicitacion', 'Torres Sanchez Fatima', 'JP 14',
       '1111', NULL, 'Enfermería', 'Personal de enfermería',
       'Las enfermeras que si se hicieron cargo de bebé su atención fue excelente sobre todo de las enfermeras goretti, alondra y maria luisa muchas gracias. Con respeto de los enfermeras, enfermeros de piso y sobre todo que estuvieran al pendiente de mi, las de la mañana como los de la noche gracias aunque el equipo de la mañana es excelente, gracias por su profesionalismo,', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "hora_validacion": "15:00", "revision_expediente": "NO", "llamada_entrevista": "Mensaje", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "No respondio el mensaje", "investigacion": "No respondio el mensaje", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2546');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2547', '2025-10-10', 'queja', 'Paciente', 'NA',
       '111111', NULL, 'Vigilancia', 'Personal de vigilancia',
       'En octubre 10, 2025 como a las o entre las 8:30 y 9:30  de la noche, dos hombres vestidos de negro, pasaron por el cuarto 6 y en mal modo pidio que nos retiraramos del cuarto. No se queria ir hasta que nos salieramos y los señores no se estaban fijando en la situación con el paciente. No había profesionalismo y empatía hacia la situación, paciente y familia. Eran dos hombres y solamente se dirigian con las dos mujeres en el cuarto. El señor y su colega cuestionaban a la familia en frente del paciente sin saber la condición', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "hora_validacion": "13:00", "revision_expediente": "NO", "llamada_entrevista": "No aplica", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "No cuento con numero de telefono", "investigacion": "No cuento con numero de telefono", "investiga": "Giselle De la Torre"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2547');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2548', '2025-10-23', 'sugerencia', 'EFRAIN VELZQUEZ ARANDA', '112',
       '11111', NULL, 'Vigilancia', 'Otros',
       'ME TOCO LA MALA SUERTE DEL ROBO DE AUTOPARTES DE MI CAMIONETA,, AL ESTAR ESTACIONADO POR EL AREA DE URGENCIAS, COMO SUGERENCIA PEDIR APOYO A LAS AUTORIDADES SOBRE ESTE TEMA Y TAMBIEN QUE EL HOSPITAL CUENTE CON ESTACIONAMIENTO PROPIO.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Capacidad instalada", "subclasificacion": "Infraestructura", "origen_seg": "Encuesta", "hora_validacion": "13:00", "revision_expediente": "NO", "llamada_entrevista": "No aplica", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "No cuento con numero de telefono", "investigacion": "No cuento con numero de telefono", "investiga": "Giselle De la Torre"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2548');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2549', '2025-10-26', 'queja', 'JOSE NICOLAS OLMEDO TORRES', '216',
       '3314060083', NULL, 'Hospitalización', 'Personal de enfermería',
       'EN LA MADRUGADA DEL DIA 26 DE OCTUBRE EL PERSONAL DE CONTROL Y PASILLO DE PLANTA BAJA, ESTUVIERON CON PLATICAS MUY FUERTES, SIN TOMAR EN CUENTA QUE LOS PACIENTES REQUIEREN DESCANSAR EN POCAS PALABRAS PARECIA QUE TENIAN FIESTA! AGRADECEMOS CONSIDERAR LO ANTERIOR Y TOMAR CARTAS EN EL ASUNTO.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico", "hora_validacion": "12:45", "revision_expediente": "NO"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2549');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2550', '2025-10-05', 'queja', 'FATIMA SALAZAR SANDOVAL', '115',
       '3322615625', NULL, 'Vigilancia', 'Personal de vigilancia',
       'ESTANDO EN LA HABITACION SEGURIDAD O VIGILANCIA NOS PIDE QUE NOS RETIREMOS DE LA HABITACION PORQUE 2 PERSONAS MAS QUERIAN INGRESAR SIN SER AUTORIADAS. LA FAMILIA ES LA QUE DECIDE QUIEN ENTRA Y QUIEN SALE Y SE TOMARON ATRIBUCIONES QUE NO LES CORRESPONDE, HACIENDONOS SENTIR INCOMODOS YA QUE NOS ESPERABAN AFUERA DE LA HABITACION PARA QUE SALIERAMOS. 4:30 PM LEO/NOEMI', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico", "hora_validacion": "12:45", "revision_expediente": "NO", "recibe_llamada": "Fátima Sandoval Salazar", "investigacion": "Nos dijeron que sólo podíamos estar 2 personas y que cada uno deberíamos dejar una identificación, estábamos esas personas con el paciente y llegaron a sacarnos que porque alguien más quería entrar y se esperaban ahí afuera y nos presionaban para que saliéramos. \n\nComo les comento, ellos nos tienen porque decirnos quién entra y quien sale, solo nosotros que estamos dentro decidimos a quien le damos nuestro pase porque es mi credencial la que está ahí, y la persona extra que quiera entrar pues entonces esa persona se tiene que comunicar directo con el familiar que está adentro y nosotros decidir a quien dejamos entrar o a que hora y no su personal.     [2:59 p. m., 28/10/2025] Paciente Fátima Salazar Sandoval: El tema de los vigilantes es que ellos no tenían porque pedirnos que nos retiráramos (sin importar si alguien más quería entrar o no) eso es más de lo ellos deban hacer\n[3:00 p. m., 28/10/2025] Paciente Fátima Salazar Sandoval: Fue en el turno de día se puede decir porque fue una situación en la mañana y otro en la tarde"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2550');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2551', '2025-10-05', 'queja', 'FATIMA SALAZAR SANDOVAL', '115',
       '3322615625', NULL, 'Hospitalización', 'Personal de enfermería, Otros',
       'ERA LA 1 DE LA MAÑANA Y ESTABAN HACIENDO LA LIMPIEZA DEL CUARTO VECINO HACIENDO MUCHO RUIDO, EN LA CENTRAL DE ENFERMERÍA HABIA MUCHAS RISAS, RUIDO, HABLANDO EN VOZ ALTA EN LA MADRUGADA, DESPERTANDO A LA PERSONA QUE ESTABA INTERNADA DESPUES DE UNA CIRUGÍA.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico", "hora_validacion": "12:45", "revision_expediente": "NO", "recibe_llamada": "Fátima Sandoval Salazar", "investigacion": "[2:57 p. m., 28/10/2025] Paciente Fátima Salazar Sandoval: Y con el tema de las enfermeras, los que hacían la limpieza pues era la madrugada y se escuchaban risas, que movían cosas y arrastraban y eso no dejaba dormir al paciente o nosotros como los que estábamos cuidando al paciente\n[2:58 p. m., 28/10/2025] Paciente Fátima Salazar Sandoval: Entendemos que hay cosas que no se puede evitar como una platica o pasar limpiando pero parecía como que una central de personal está cerca de esos cuartos y se escuchaba todo como estando al lado ya que a esa hora hay menos ruido"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2551');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2552', '2025-10-10', 'queja', 'PACIENTE', 'NA',
       '111111', NULL, 'Vigilancia', 'Personal de vigilancia',
       'EN OCTIBRE 10, 2025 COO A LAS O ENTRE LAS 8:30 AM Y 9:30 DE LA NOCHE, DOS HOMBRE VESTIDOS DE NEGRO PASARON POR EL CUARTO 6 Y EN MAL MODO PIDIO QUE NOS RETIRARAMOS DEL CUARTO. NO SE QUERIA IR HASTA QUE NOS SALIERAMOS Y LOS SEÑORES NO SE ESTABAN FIJANDO EN LA SITUACION CON EL PACIENTE. NO HABIA PROFESIONALISMO Y EMPATIA HACIA LA SITUACION, PACIENTE Y FAMILIA. ERAN DOS HOMBRES Y SOLAMENTE SE DIRIGIAN CON LAS DOS MEJORES EN EL CUARTO. EL SEÑOR QUE HABLABA CON LAS DOS MUJERES DEMOSTRABA UNA ACTITUD PREPOTENTE Y SIN PROFESIONALISMO Y EMPATIA. EL SEÑOR Y SU COLEGACUESTIONABAN A LA FAMILIA ENFRENTE DEL PACIENTE SIN SABER LA CONDICION DEL PACIENTE. ERA UN HOMBRE CHAPARRITO CON UNA COLA EN SU CABELLO Y EL OTRO HOMBRE ERA DE TAMAÑO MEDIANO, MORENO Y PELO CORTO.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2552');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2553', '2025-10-15', 'queja', 'JORGE RAFAEL GARCIA CUEVAS', '15',
       '3329720565', NULL, 'Administración', 'Personal de admisión',
       'LA SEÑORITA DE INGRESO MUY GROSERA NO PUEDE SER TENGAN PERSONAL ASI EN ESTE HOSPITAL ELLAS SON LA CARA DEL HOSPITAL Y TRATAR ASI A LAS PERSONAS NO SE VALE. ME GUSTARIA ALGUIEN SUPERIOR A ESTA SEÑORITA ME MARQUE Y DAR UNA SOLUCION YA QUE ESTARE VINIENDO AQUI PARA HACER MI TRATAMIENTTO SINO PARA PEDIR A MI DOCTORA ME TRATE EN OTRO HOSPITAL QUEDO ATENTO A SU RESPUESTA', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2553');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2554', '2025-10-25', 'queja', 'Sin nombre', 'Sin Numero',
       'Sin telefono', NULL, 'Vigilancia', 'Personal de vigilancia',
       'Les escribo este reporte debido al mal trato recibido de parte del área de vigilancia del hospital Santa Margarita, les redacto lo sucedido;
Cuando vine a visitar a mi familiar, llevaba conmigo a mi hija pequeña, a lo cual los vigilantes me negaron el acceso con mi pequeña hija, el problema, no es tanto que no dejaran entrar a mi hija, sino la forma en cómo se portaron con nosotros, de una forma muy prepotente y sin educación.
Espero de la manera más atenta que se tomen cartas en el asunto, para que se mejore la forma en que se trata a las personas dentro del hospital. Sobre todo, que se capacite al personal de vigilancia (en mi caso fue del turno matutino los que me recibieron) para que tengan un mejor tacto con las personas.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2554');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2555', '2025-10-27', 'queja', 'ADRIANA LOPEZ CHAVARIN', '113',
       '11111', NULL, 'Rayos X', 'Otros',
       'QUISIERA COMENTALES QUE RECIBI MIS RESULTADOS VIA WHATSSAP POR EL ESTUDIO REALIZADO HOY DE TOMOGRAFIA CON MEDIO DE CONTRASTE DEL ABDOMEN TOTAL POR POSIBLE APENDICITIS, ME LO ENVIARON SIN LA INTERPRETACION PUES NO TENIA UN CANDADO LA LIGA DONDE NO PODIA ABRIRLO DE INMEDIATO, FUI AL AERA CORRESPONDIENTE (IMAGENOLOGIA) DONDE UNA PERSONA (CABALLERO) ME PIDIO QUE LE COMUNICARA A MI DOCTOR PARA QUE AUTORIZARA EL ENVIO LO CUAL ESTOY A DISGUSTO POR ESTA SITUACION YA QUE PAGUE $9,150 POR UNA TAC 1 REGION CONTRASTE AL CUAL TENGO DERECHO DE RECIBIR DE INMEDIATO Y NO HASTA LA AUTORIZACION DEL MEDICO TRATANTE. ES POR ELLO QUE INVITO A HOSPITAL ENVIEN AL PACIENTE O DERECHOHABIENTE LOS RESULTADOS CORRESPONDIENTES SIN MAYOR PROBLEMA.
POR LO DEMAS LA ATENCION BRINDADA ESTUVO A MI ENTERA SATISFACCION.
AGRADEZCO LA ATENCION A LA PRESENTE.
TENGO PENDIENTE PORQUE EL HOSPITAL ME ENTREGUE MI RESULTADO DEL UROCULTIVO POR LO QUE LES SOLICITO ME LO ENVIEN EN CUANTO ESTE LISTO. GRACIAS', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2555');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2556', '2025-10-27', 'queja', 'MARIA GUADALUPE SEVILLA', 'JP 2, JP10',
       '111111', NULL, 'Hospitalización', 'Otros',
       'CUANDO NOS INSTALARON EN EL CUARTO JP2 NO FUNCIONABA EL LAVABO, LA CONEXION DEL OXIGENO TENIA FUGA, LA VENTANA QUE DABA A LA CALLE NO TIENE MOSQUITERO Y POR AHI TUVIMOS ENTRADA DE MOSCOS Y TUVIMOS QUE PEDIR QUE FUMIGARAN CON CITRONELA, SE PIDIO EL SERVICIO A LAS 3:00 AM Y PASARON HASTA LAS 4:30 AM EL DIA 27-10-25.
Y NOS CAMBIARON AL CUARTO JP -2 07 EL DIA 27-10-25 Y PRESENTO QUE EL BAÑO ESTA TAPADO Y AHI SIGUIO POR EL RESTO DE LA SEMANA A DIARIO VENIAN A DESTAPARLO', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2556');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2557', '2025-10-09', 'felicitacion', 'CESAR ALBERTO MARES AGUILERA', '114',
       '3333394411', NULL, 'Enfermería', 'Personal de enfermería',
       'FELICITACIONES AL GRUPO DE ENFERMERÍA POR SU CUIDADO, PROFESIONALISMO Y CALIDAD EN SU SERVICIO. FELICIDADES Y GRACIAS (CARMEN, GORETTI, ITZEL, ISRAEL Y JAZMIN)
LOS MEDICOS AGRADEZCO SU ATENCIÓN Y DEDICACIÓN ASÍ COMO SU PROFESIONALISMO Y CALIDAD EN SU SERVICIO DRA PALOMA. 
FELICITACIONES. GRACIAS', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "origen_seg": "Buzón"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2557');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2558', '2025-11-06', 'queja', 'Miguel Angel Moctezuma', '02',
       '3317912191', NULL, 'Hospitalización', 'Otros',
       'Nuestro paciente esta delicado. Ya tenemos 10 dias en el hospital y el cirujano nos recomendo este hospitala por su tranquilidad y servicios pero desde el dia uno hemos soportado ruido de mantenimiento y estamos muy inconformes. No hay PAZ, Por favor!! paz', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Infraestructura", "origen_seg": "Físico"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2558');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2559', '2025-11-21', 'queja', 'Ana Rodriguez Martinez', 'JP5',
       '111111', NULL, 'Alimentación', 'Personal de Cocina',
       'El jueves por la noche me trajeron un sándwich todo feo, aguado, como que se les quemo, solo tenia poco queso y lechuga, no sabia bueno, parecia que fue improvisado, ya que como que se les habia acabado la comida que hicieron, el viernes por la mañana me trajeron bistec sin jitomate, sin cebolla sin nada, la carne estaba dura, no estaba bueno y preferí no comerlo. Ayer me trajeron un sadwich que si estaba bueno y hoy por la mañana un pan frances con frutos rojos que estaba bueno.

El trato de mis medicos y del personal de enfermería fue bueno.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Físico", "hora_validacion": "11:00"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2559');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2560', '2025-11-22', 'felicitacion', 'Pedro Martinez Ayala', 'NA',
       '11111', NULL, 'Laboratorio Clínico', 'Otros',
       'El personal de laboratorio cuenta con mucha disposición y apertura, yo como infectologo es parte esencial el revisar el crecimiento bacteriano y la evolución de los cultivos para mi práctica profesional y siempre he contado con el apoyo del laboratorio. Muchas gracias y felicidades!', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Visita"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2560');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2561', '2025-11-09', 'queja', 'Encuesta', 'JP03',
       '111111', NULL, 'Alimentación', 'Personal de Cocina',
       'A LA COMIDA LE PUSIERON MUCHO PICANTE', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2561');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2562', '2025-11-19', 'queja', 'ENCUESTA', 'PB116',
       '11111', NULL, 'Cafetería', 'Personal de Cocina',
       'PESIMO SERVICIO Y TRATO DEL PERSONAL DE CAFETERIA EN EL HORARIO DE 8 AM A 8 PM POR LA NOCHE BUEN SERVICIO', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2562');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2563', '2025-11-14', 'queja', 'ENCUESTA', 'SD',
       '111111', NULL, 'Alimentación', 'Personal de Cocina',
       '2 CHAROLAS DE ALIMENTOS LAS RECOGIERON HASTA QUE SE SOLICITO EL SERVICIO Y LA RESPUESTA FUE TIRELO A LA BASURA SON DESECHABLES. EL PACIENTE NO COMIO Y EL CUARTO OLIA A ALIMENTO', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2563');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2564', '2025-11-24', 'queja', 'ENCUESTA', 'SD',
       '111111', NULL, 'Alimentación', 'Personal de Cocina',
       'QUE ESTEN MAS ATENTOS A LAS COMIDAS QUE SE REQUIERAN PARA EL PACIENTE. ALGUN PERSONAL QUE CAMBIE SU FORMA DE ATENDER', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2564');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2565', '2025-11-14', 'queja', 'ENCUESTA', 'JP05',
       '111111', NULL, 'Cafetería', 'Personal de Cocina',
       'PASE A DESAYUNAR A LA CAFETERIA, PEDI UN LONCHE DE UN GUISO DE CHICHARRON QUE TENIA. ESTUVE A PUNTO DE DEVOLVER EL BOCADO. MUY HORRIBLE EL GUISO. FAVOR DE PONER CUIDADO EN LOS ALIMENTOS DE LA CAFETERIA', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2565');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2566', '2025-11-05', 'sugerencia', 'ENCUESTA', 'JP06',
       '111111', NULL, 'Alimentación', 'Personal de Cocina',
       'NO HABIA NI AGUA PARA BEBER', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2566');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2567', '2025-11-05', 'sugerencia', 'Aurora Cedeño Garcia Dueñas', 'GIN13',
       '11111', NULL, 'Hospitalización', 'Otros',
       'Proporcionar algunas toallas para bañarse y alguna cobija para el acompañante.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2567');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2568', '2025-11-05', 'sugerencia', 'Fernando Arana Suarez', 'jp06',
       '1111111', NULL, 'Hospitalización', 'Otros',
       'Todo me pareció excelente, sólo un comentario como acompañante de mi marido en cuanto aquí no es facilitarán, cobija, almohada o algo para pasar un poco menos difícil anoche. Yo sé que no viene uno de vacaciones, pero no había ni agua para beber inclusive el jabón estropajo y toalla para asear a mi esposo, lo tuvimos que solventar porque en la habitación no había nada. Les agradezco su atención y una disculpa si mi sugerencia no es desagrado. Gracias. Pues hasta también último comentario. El Aire Acondicionado nunca lo pude encender Pedia la enfermera apoyo pero nunca llegó el apoyo. Gracias', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2568');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2569', '2025-11-23', 'queja', 'Eva Gonzalez Rubio', 'PB117',
       '111111', NULL, 'Hospitalización', 'Otros',
       'Estaria bien proporcionar una almohada para el familiar del paciente', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2569');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2570', '2025-11-16', 'queja', 'ENCUESTA', 'SD',
       '111111', NULL, 'Vigilancia', 'Personal de vigilancia',
       'La guardia Mujer de Urgencias es muy grosera y atiende de mala gana', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2570');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2571', '2025-11-07', 'queja', 'Sharon Medina', 'PB115',
       '111111', NULL, 'Alimentación', 'Personal de Cocina',
       'Solo vigilar mas que tipoo de alimento necesita el paciente el agua de piña no le ayudo, y las entomatadas estaban con olor feo el jitomate.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2571');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2572', '2025-11-03', 'queja', 'Ma. Antonieta Barajas', 'GIN06',
       '11111', NULL, 'Hospitalización', 'Otros',
       'Las instalaciones de la habitación tiene oportunidad de mejores. El porta papel del baño al tomarlo se caía la tapa. La regadera o mas bien la coladera del baño estaba tapada y se tiro el agua. La mayoría de las solicitudes de enfermería , limpieza y mantenimiento, podrían mejorar en cuanto al tiempo de atención. El baño de hombres quirófano esta muy peligroso. Tienen todos los servicios y la atención espiritual es buena.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Infraestructura", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2572');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2573', '2025-11-28', 'queja', 'Marisela Negrete', 'PB113',
       '11111', NULL, 'Hospitalización', 'Otros',
       'Una de las enfermeras durante la estancia se porto indiferente fue tosca con mi mama y se molesto por cambiar su pañal asi que a partir de ese momento yo lo cambiaba. Deberian de contratar personas que tengan vocacion. Este ultimo dia como mi mama ya seria dada de alta las enfermeras han venido muy poco , deberian ser mas atentas a las necesidades del paciente.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2573');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2574', '2025-11-14', 'queja', 'Paulo Cesar Flores', 'JP01',
       '111111', NULL, 'Hospitalización', 'Otros',
       'El internet no sirve', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Infraestructura", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2574');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2576', '2025-12-06', 'queja', 'ENCUESTA', 'QX',
       '11111111', NULL, 'Quirófano', 'Médico Tratante',
       'Algo muy importante que quisiera comentar ya que desde el ingreso se mencionó 2 medicamentos a los que soy alérgica, varias veces se comentó desde mi llegada y en la cirugía me aplicaron un antibiótico al cual soy alérgica, tuvieron que poner algo para contrarrestar los efectos y me pareció poco cuidado sobre el tema, ya que es algo delicado y se les había mencionado desde el inicio”', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2576');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2575', '2025-11-18', 'felicitacion', 'ENCUESTA', 'SD',
       '111111', NULL, 'Hospitalización', 'Personal de enfermería',
       'Agradecer de manera particular a las siguientes personas por su atención su calidad y calidez, felicitarlos por su gran trabajo, que lo hacen super bien, de manera agradable, muy amables, muy humildes, el trato siempre super bien. Gracias por hacer de nuestra estancia una estancia tranquila y agradable. Dios los bendiga.
Nayeli Antimo ( enfermera ) Turno matutino.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2575');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2576', '2025-12-08', 'queja', 'SD', '114',
       '111111', NULL, 'Quirófano', 'Otros',
       'Buenas noches por este medio quiero comunicar mi inconformidad porque estuvimos 2 1/2 sentados esperando sin informacion de nada al cual ya teniamos que haber esperado al Dr. en la habitacion. A las 4:30 hable al consultorio del Dr. y fue entonces que nos llevaron directo al procedimiento. Yo entiendo el control de la entrada del hospital pero el trato hacia la gente hay mucha de mal humor y molestia de parte del personal. Por ningún motivo quisiera causar molestia pero creí importante informarlo.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2576');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2577', '2025-12-08', 'sugerencia', 'DRA ALEA F RIOS MEDRANO', 'GINE 2',
       '111111', NULL, 'Quirófano', 'Otros',
       'FAVOR DE COLOCAR NUEVAMENTE LOS CARROS DE MATERIAL BASICO PARA ANESTESIA CON CIRCUITO/TUBOS ENDOTRAQUEALES/FARMACOS DE RESCETE/ OARA SEGURIDAD Y MAYOR RAPIDEZ A LA SOLUCION DE URGENCIAS ANESTESICAS, LAS CUALES EN CUESTION DE SEGUNDOS PUEDEN CONCUIR EN UN DESELANCE FATAL. NO ES POR COMODIDAD DEL MEDICO O LA ENFERMERA, ES POR LA SEGURIDAD DEL PACIENTE Y LA VIDA DEL PACIENTE', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Seguridad", "origen_seg": "Físico"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2577');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2578', '2025-12-18', 'queja', 'Hermelinda', '115',
       '6675200069', 'mina_iveth1993@hotmail.com', 'Vigilancia', 'Personal de vigilancia',
       'Llego la de seguridad mujer turno matutino  muy prepotente al cuarto en vez de llegar amablemente a decirnos que nomas se podía 2 personas y nomas íbamos a entregar cosas personales, no nos íbamos a quedar ya que mi hermano no podía cargar las cosas porque iva con bastón', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2578');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2579', '2025-12-17', 'queja', 'Alfonso Suarez', 'JP 14',
       '111111', NULL, 'Hospitalización', 'Personal de enfermería',
       'Lastimaron al paciente en exceso al canalizarlo. Algunos enfermeros tardaron mucho entre cada pendiente, teniendo que ir constantemente a solicitar su asistencia. Por las madrugadas hay exceso de ruidos, luces, llantas de carritos muy ruidosas. Excelente servicio de camilleros. El agua caliente en el baño tarda más de 8 minutos en salir.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2579');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2580', '2025-12-16', 'queja', 'Berenice Gonzalez Serratos', 'JP13',
       '1111111', NULL, 'Hospitalización', 'Médico Tratante',
       'Desde el día 18 de diciembre he tenido problemas con la atención brindada por parte del hospital ya que el estado de salud de mi paciente se complico estando ya dada de alta y por tal motivo tuvo que permanecer en el hospital, ya que se solicito interconsulta a neurologia, y no fue posible contactar con algún medico de dicha especialidad, nadie ni médico tratante ni de piso, tampoco enfermería acudieron a la  habitación, me parece increíble que por mis medios contacte con el especialista, la paciente se encontraba muy delicada y no queria mover a  la paciente. Sin emabrgo me quedo con una pésima impresión del hospital, NO ME VOY COMO ALTA VOLUNTARIA, ES UN ALTA OBLIGADA YA QUE EL HOSPITAL NO FUE CAPAZ DE ENCONTRAR UN MEDICO', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Moderado", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Buzón"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2580');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2581', '2025-12-24', 'queja', 'Sabino Alejandro Nuñez', 'Suite 3',
       '1111111111', NULL, 'Personal Médico', 'Médico Tratante',
       'LOS MEDICOS DE GUARDIA NUNCA ATENDIERON MI PROBLEMA DE NEUMOTORAX TUVE QUE PAGAR 4 NOCHES MAS PORQUE TUVE QUE BUSCAR POR MI CUENTA UN DOCTOR, LAS ENFERMERAS MUY AMABLES SOLO QUE UN PAR NO SABEN CANALIZAR, Y ME LASTIMARON MUCHO. EL MEDICO QUE NO VOLVIO SE LLAMA JOVANI TURNO DE LA NOCHE.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2581');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2601', '2026-01-15', 'queja', 'J Rito Marquez Gutierrez', 'JP 18',
       '111111', NULL, 'Hospitalización', 'Otros',
       'Mi papá salio de terapia intensiva a habitación de gine 10 y en cuanto llegamos se escuchaba mucho ruido y platicas del personal del hospital los cuales decian palabras inapropiadas entre ellos, para lo cual me da pena mencionarlas (hablaban de culo) y según las indicaciones del médico mi papá debe de estar lo mejor posible sin distracciones y descansando, no alcance a avisar antes a administración de que mi papá llegara a ese cuarto y solicite cambio de habitación por lo incomodo que eran las platicas.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Otros medios", "fecha_validacion": "2026-01-15", "hora_validacion": "17:00", "recibe_llamada": "Hija del paciente", "investigacion": "Comenta que se escuch en la habitación las platicas del personal, se verifica habitación de gine 10, observando que colinda la ventana con el área de camillería, además encontrando una lata de bebida energética en la ventana de la habitación por el lado de camillería.", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-01-16", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/01/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2601');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2602', '2026-01-18', 'queja', 'Emilio Mercado', 'PB 112',
       '111111', NULL, 'Administración', 'Personal de cajas',
       'Todo perfecto excepto la chica de caja Vibeck sumamente altanera, grosera y con muy poco tacto personal. 
Muy desagradable su trato, gestos en su rostro y me quiso hacer pánico escénico y no se lo permití, no con palabra literal la actitud dice mucho, más atentos con su personal.
No me gusto el servicio por ella pierden todo lo bueno que les califique y le recuerdo el cliente que paga siempre tiene la razón. Gracias', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "fecha_validacion": "2026-01-19"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2602');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2603', '2026-01-22', 'felicitacion', 'Manuel Alfredo Ortiz Barrera', '117',
       '3311479105', 'm.alfredo.ortiz@gmail.com', 'Alimentación', 'Personal de Cocina',
       'Hasta hoy la mejor comida de hospital. Toda la comida me ha encantado. Me dan dieta de nefro y la verdad es muy rica.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Buzón", "fecha_validacion": "2026-01-23"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2603');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2605', '2026-01-23', 'queja', 'Jose Carlos Guzman', 'urgencias',
       '3318246449', NULL, 'Urgencias', 'Otros',
       'Preguntar, en el interrogatorio de ingreso conteste la edad de ella y me callo de una manera poco prudente y dijo que ella deberia de contestar, posteriormente quería que yo contestara y le dije "ya cambio de opinión" entonces quien contesta. Posteriormente hubo diferencias y discusiones con la doctora, ya me iba iba (despues de pagar la cuenta) pero vi que en el documento de egreso nos califica de agresivos y me regrese a hacer este escrito, por lo que solicito que en la nota de egreso se elimine las palabras en las que nos califica como poco cooperadores y agresivos. creo que ese documento es un informe del padecimiento y el tratamiento medico y no para calificar las actitudes de los acompañantes o enfermos que obviamente llegamos preocupados por la situacion y no llegamos con la intencion de agredir al personal. Acepto mi responsabilidad de mis respuestas pero dejo claro que no inicie y no venia a cuestionar o a agredir.', 'historico', 'cerrado', '{"procede": "No", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2026-01-27", "hora_validacion": "14:00", "recibe_llamada": "Montserrat Vidal", "investigacion": "Si ya fue resuelto. Pero si me quedo con muy mal sabor de boca. Por qué algo tan sencillo lo hicieron súper complicado y sobretodo la atención del contador. gracias, y si solo que cuide de eso o sea es un hospital , va gente enferma queriendose sentir mejor y que te den un trato tan deplorable, deja mucho que desear", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-01-27", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/04/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2605');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2606', '2026-01-05', 'queja', 'Montserrat Vidal', 'Urgencias',
       '3312179712', 'ivannavidal916@gmail.com', 'Facturación', 'Otros',
       'Tienen pésimo servicio de facturación. Y el que se dice contador es un grosero, por llamada lo estuve buscando y nunca estaba y cuando por fin logré localizarlo fue un grosero! Terrible su atención y no me dejaba explicar lo que pasó, solicité mi factura como me dijeron y me la dieron 2semanas después de haberla solicitado cuando a mí me urgía para mi seguro de gastos médicos. 
Terrible atención.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico", "fecha_validacion": "2026-01-27", "hora_validacion": "14:00", "recibe_llamada": "Veronica Ortiz", "investigacion": "Mil gracias, lo más importante es motivar a todo el personal en la importancia del dolor del enfermo y más cuando son vulnerables como lo son los adultos mayores, las voces altizonantes y los jalones son agresiones qué no deben ocurrir para nadie. \nEl personal deben  contar con una preparación previa de Relaciones Humanas hacia los pacientes, como Irving y la señorita Chelis una excelente enfermera, humana trata con cariño al paciente en todas sus necesidades muy dedicada, se ve que ama su profesión. \n\n   Gracias por tomar las acciones necesarias. \n   Dónde Dios, vive el amor siempre persiste..", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-01-27", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/05/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2606');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2607', '2026-01-26', 'queja', 'Veronica Ortiz Cazarez', 'UCI',
       '3521172290', 'graficolibre@hotmail.com', 'Terapia Intensiva', 'Personal de enfermería',
       'El doctor autoriza entrar familiar a dar aliemento porque la enfermera no le da de comer en turno vespertino.  
Buenas tardes
De la manera más atenta, pido su humanidad para el trato hacia los pacientes sin importar la edad, en mi caso a mi mamá quienes una persona de edad mayor.
Se encuentra en terapia intensiva y solicito de la manera más antenta se cambie  a la señorita Fatima de su turno a su vez de no estar al frente de los cuidados de mi mamá. Su voz muy altisonante, no coinicde al ver yo a im mama muy lucida sus respuestas y la señorita fatima decir que no estava bien, que no etendia lo que se decia dio iun informe de que la paciente no comia cuando yo su hija le di de comer y poco a poco ingirio un poco de alimento.
le pedi que por una sitiacion vivida mi mama ella piemsa que el ventilador es intubacion por ello se pone nervisiosa y lo rechaza, que no le dijera que es un ventiladro que le dijera que ke van a anebulizar y ela no dijo que mi mama no entendia porque ni estaba bien para lo cual yo la vi bien somnolineta pero respondiendo todo muy coerente. Gracias por', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2026-01-27", "hora_validacion": "14:00", "recibe_llamada": "Veronica Ortiz", "investigacion": "Mil gracias, lo más importante es motivar a todo el personal en la importancia del dolor del enfermo y más cuando son vulnerables como lo son los adultos mayores, las voces altizonantes y los jalones son agresiones qué no deben ocurrir para nadie. \nEl personal deben  contar con una preparación previa de Relaciones Humanas hacia los pacientes, como Irving y la señorita Chelis una excelente enfermera, humana trata con cariño al paciente en todas sus necesidades muy dedicada, se ve que ama su profesión. \n\n   Gracias por tomar las acciones necesarias. \n   Dónde Dios, vive el amor siempre persiste..", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-01-27", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/06/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2607');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2608', '2026-01-27', 'felicitacion', 'Verónica Ortiz', 'Terapia intensiva',
       '3521172290', 'graficolibre@hotmael.com', 'Terapia Intensiva', 'Personal de enfermería, Médicos de guardia, Médico Tratante',
       'Lindo día!!
A quien corresponda

   Agradezco y felicito muy ampliamente a la señorita Chelis por su trato muy amable y humano con mi mamá la señora María Martha Cazarez Tamayo de 86 años de edad, Chelis, muy linda en su trato con ella, muy cariñosa, atenta y mucha paciencia con sus alimentos, la familia le felicita por su gran vocación de enfermera. Gracias a sus cuidados y los de Irving Solano quien sustituyó a la señorita con falta de ética profecional y humana.
  Mi mamá se ha sentido querida y eso la hace luchar por su vida, ellos le dan la confianza de que la edad no importa mientras Dios, nos permita vivir debemos de luchar por ella...
   Gracias!! Por sus lindas atenciones Hospital Santa Margarita...
   Todo lo puedo en Cristo que me fortalece... 🙏🙏🙏🙏😇😇', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Otros medios", "fecha_validacion": "2026-01-27", "hora_validacion": "14:00", "recibe_llamada": "Montserrat Vidal", "investigacion": "también como comentario felicitar a la chica de admisión en urgencias y la Dra de fines de semana la DRA Yesica Ochoa excelentes personas", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-01-27", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/07/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2608');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2609', '2026-01-06', 'felicitacion', 'Monserrat Vidal', 'NA',
       '11111111', NULL, 'Urgencias', 'Personal de admisión, Médico Tratante',
       'Quiero felicitar a la chica de admisión de urgencias y la Dra de fines de semana la Dra Yesica Ochoa excelentes personas.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "fecha_validacion": "2026-01-27", "hora_validacion": "15:00", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-01-27", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/07/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2609');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2610', '2026-01-26', 'felicitacion', 'Juan Carlos', 'Urgencias',
       '3223957666', 'juan.clop0389@gmail.com', 'Urgencias', 'Médico Tratante',
       'Queremos agradecer al dr Uriel por la atención que le dio a nuestra mamá. El trato que le dio marca la diferencia. Gracias por sus explicaciones claras y la calidad de su atención.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2026-01-28", "hora_validacion": "15:00", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-02-04", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/10/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2610');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2611', '2026-02-05', 'felicitacion', 'Rebeca Navarro Zaragoza', 'Terapia intensiva',
       '3931064581', NULL, 'Terapia Intensiva', 'Personal de enfermería, Médicos de guardia',
       'Felicitar ala enfermera Chely y al doctor Fidel por cuidar muy bien de nuestra abuelita', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-02-06", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/12/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2611');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2612', '2026-02-05', 'queja', 'Delia Garcia', '15',
       '111111', NULL, 'Enfermería', 'Personal de enfermería',
       'La atencion de los enfermeros es muy buena, solo una enfermera de el turno de la mañana del dia de hoy 5 de febrero del 2026. La cambio de pañal y la lastimo mucho, porque no lo hizo con delicadeza y la dejo muy sucia, no la limpio nada bien, la revis y la tuve que limpiar de nuevo, ojala puedan checar eso porque si a los pacientes los dejan llenos de excremento se rozan y es antihigienico.

De la enfermera Pio.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-02-06", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/11/2026", "resolucion": "se levanta incidencia no firma colaboradora", "fecha_resolucion": "2026-02-16"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2612');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'Capital humano', '2026-02-05', 'queja', 'Rubi', 'Cafeteria turno nocturno',
       '3321812213', NULL, 'Cafetería', 'Otros',
       'Es injusto que nosotras las nocturnas tenemos un menú al cual tenemos que realizar y dejar las previas,  que al final de cuentas , alimento que realizamos lo esconden mis compañeras d3l turno matutino se lo hicimos saber a mi jefa y aun asi siguen con el mismo comportamiento,  negando la comida ya sea con el pretexto que no tienen tortilla o birote siendo que desde las 7 dejamos preparado para ellas y niegan servicio hasta las 9 o 10 porque no tienen tortillas cuando después de las 6 esta abierto en donde las compran, y siempre tenemos de repuesto en la cafetería,  mi compañera maria de cocina siempre llega tarde con el pretexto que tiene permiso y no llega a recibirme y justo cuando me voy hace empieza a quejarse, ellas llegan y se ponen a desayunar con ese mismo pretexto que no tienen nada , cuando se les deja verdura cocida , hotcakes,  harina preparada , alguna carne y frijoles guisados y anteriormente era huevo de alguna forma,  también dejamos molletes sea dulce o salado..
Y para la noche a nuestra guardia se le deja lo que les sobra de otro turno o lo que nosotras anteriormente preparamos 
tambien en la noche se vende y da pena que no tenemos mas que lo que sobra. Esta imagen que mando es lo único que dejaron de cena y es lo de la tarde que les quedó, 2 birotes y mas lo del refri qué ya lo tienen apartado y aproximadamente alcanzaría para 4 0 5 personas. Cuando es enfermería, intendencia , admisión, caja administrativa,  rayos x, laboratorio, banco de sangre, urgencias,  intendencia , y no me alcanzaría.', 'historico', 'cerrado', '{"procede": "No", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-02-09", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/14/2026", "resolucion": "Se pasa a capital humano para seguimeinto"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='Capital humano');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2613', '2026-02-05', 'queja', 'Blanca Trejo', 'ambulatorio',
       '3338463038', NULL, 'Quirófano', 'Personal de enfermería, Otros',
       'La familiar del paciente refiere que el médico le comento que al termino de la cirugía el paciente sería egresado posterior a la recuperación de la anestesia sin embargo nadie le daba informes, el médico le comenta que la cirugía termino a las 12:00 hrs y que aproximadamente en 1 hora podia egresar al liquidar la cuenta; posterior a eso ya no recibio información los familiares del paciente, la familiar le pregunto a un personal de camillería y de manera amable y bromista comento que ahi seguia el paciente que no se podía ir, posterior pregunto a un personal de enfermería de CEyE sobre el paciente sin dar respuesta, pregunto a un médico sobre el estado de salud del paciente, el cual desconocía el estado y le comento que preguntará en CEyE, volvió a preguntar y le comentaron que hasta que no pagará la cuenta podrían entregarle al paciente sin dar informes del mismo, la familiar acude a administración para el pago de la cuenta vuelve a preguntar por el estado de salud el paciente; motivo por el cual solicitan la intervención del calidad, se acude al quirófano a verificar la existencia y condición del paciente el cual se encontraba en la recuperación, al momento no había personal de enfermería, se le llama para preguntar la condición del paciente, al momento se encontraban 2 pacientes en recuperación, y solo habían 2 cirugías programadas, al interrogar al personal de enfermería comenta que desde el cambio de turno a las 14:30 el paciente ya estaba egresado, desconoce lo ocurrido en el turno matutino comentando que la cirugía termino a las 12:00 y paso a recuperación a las 12:10;  se le solicito que se egresará el paciente, ya que otro familiar estaba liquidando la cuenta; por parte del personal de enfermería no hubo acompañamiento al egreso, ni otorgo indicaciones; posterior se solicita explique los cuidados al alta comentando el personal que tenian mucho trabajo, minutos despues sale el personal y explica algunos de los cuidados; se solicita personal de supervisión quien acude tiempo después sin investigar lo sucedido se comenta que se resolvió y se retira sin intervención alguna.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Tiempo de espera, Proceso, Seguridad, Comunicación efectiva", "origen_seg": "Físico", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-02-06", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/13/2026", "resolucion": "Incidencia por CH", "fecha_resolucion": "2026-02-16"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2613');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2614', '2026-02-06', 'queja', 'MARIA LUISA GARCIA SERRANO', 'URG',
       '1111111', NULL, 'Hospitalización', 'Personal de enfermería, Médicos de guardia, Otros',
       'Sucedido el día viernes 06 de Febrero 2026 16:50 hrs aprox.

Buenas tardes. Más que una sugerencia o comentario quiero manifestar mi QUEJA ante el servicio recibido el día de hoy. Al momento de trasladar a una paciente de su cuarto al área de urgencias para recibir un medicamento previo a su alta, cuando se presentó y aún con la información que se le brindó respecto a la situación de mi madre, persona de 74 años con marcapasos puesto y recientemente (en este hospital) y recién operada de la cadera, así presentaba dolor por mismo motivo, la movió y cambió de camilla sin cumplir con los protocolos adecuados y los cuidados necesarios para garantizar la integridad de la paciente, dando el traslado sin los cuidados adecuados generando un movimiento brusco sin cuidar la parte afectada, que hicieron gritar y llorar de dolor a mi madre. Notablemente se percató de nuestra molestia, sin embargo su indiferencia fue total. Con lo anterior se generó que la paciente generara más sufrimiento del que ya venía presentando agravando su situación, por lo anterior tuvo que permanecer una hora con medicamento y en observación en el área de urgencias. Asimismo generando retraso en la salida del hospital generando además gastos extras en la contratación privada de la ambulancia que por nuestra cuenta tuvimos programada. En lo económico no pesa en estas circunstancias, lo más valioso e importante es la actitud y el espíritu de servicio, la atención inadecuada que perjudica a la parte más importante que es la salud y el bienestar de nuestra gente que amamos.

Aunado a lo anterior, durante los 2 periodos que estuvimos en este hospital con nuestro familiar (en Enero y Febrero) se presentaron sucesos sobre todo por la noche durante el servicio, donde personal de enfermería se mostraba indiferente ante las solicitudes y apoyos que requeríamos, así como un médico de guardia que fue a atendernos por la noche con molestia ya que se observaba se encontraba dormido en su guardia a las 2:00 de la mañana.

Creo que hay muchas áreas de oportunidad en este hospital, hubo gente muy linda, muy humana con un trato asertivo , empática , amable y resolutivo, pero si nos toco la mala experiencia de encontrarnos gente sin vocacion de servicio. Gracias', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-02-06", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/15/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2614');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2615', '2026-02-08', 'queja', 'Jose Luis Raygoza', 'UCI 3',
       '111111', NULL, 'Enfermería', 'Personal de enfermería',
       'El dia de hoy nuestro familiar tuvo que pasar a terapia intensiva y anteriormente todo estaba bien hasta que se le dio la indicación a la enfermera a cargo de nosotros llamada Susana y comenzó a actuar de forma apresurada y un poco grosera, después llego la supervisora de enfermería a explicarnos el proceso a seguir e incluso la enfermera Susana se dirigio a ella de forma grosera también, lo cual hizo todavía más incomoda la situación, cuando ya nos estaba siendo dificil que nuestro familiar estuviera grave.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Otros medios", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-02-09", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/16/2026", "resolucion": "ACTA ADMINISTATRIVA", "fecha_resolucion": "2026-02-16"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2615');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2616', '2026-02-11', 'felicitacion', 'VALERIA IDHALI SOLORZANO ALEJANDRE', 'JUAN PABLO 2',
       '3335054444', NULL, 'Enfermería', 'Personal de enfermería',
       'UN JOVEN MUY AMABLE, EDUCADO, SERVICIAL, AL PENDIENTE TODO EL TIEMPO, FELICIDADES POR SU ESPIRITU DE SERVICIO. TURNO NOCHE (SALIO A LAS 7:30 DEL TURNO)', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico", "fecha_validacion": "2026-02-16", "hora_validacion": "16:00"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2616');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2617', '2026-02-17', 'queja', 'FERNANDO VELASCO', 'HEMODIALISIS',
       '11111111', NULL, 'Hemodiálisis', 'Personal de enfermería',
       'SE UTILIZARON 3 AGUJAS PARA FISTULA EL CUAL LA TERCERA SE UTILIZO POR MOTIVO DE QUE FALLARON EN UNA PUNCION POR ESO MOTIVO UTILIZARON 3 AUJAS. EL CUAL LA TERCERA EL COBRO FUE PARA MI. PERSONAL DE ENFERMERIA TURNO VESPERTINO', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta", "fecha_validacion": "2026-02-18", "hora_validacion": "18:00"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2617');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2618', '0026-02-25', 'felicitacion', 'Clarisa, Guadalupe Sierra Rangel', '107',
       '3310644939', 'clarisasierrarangel@gmail.com', 'Cafetería', 'Personal de enfermería, Personal de Cocina',
       'La atención de las dos señoras, en cafetería muy amables y principalmente su comida deliciosa, muchas gracias por eso.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2026-02-27", "hora_validacion": "15:30"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2618');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2619', '2026-02-25', 'felicitacion', 'Clsrisa Guadalupe Sierra Rangel', '107',
       '3310644939', 'Clarisasierrarangel@gmail. com', 'Enfermería', 'Personal de enfermería, Médicos de guardia, Personal de Intendencia, Médico Tratante, Otros',
       'Mi familia y yo queremos enviar una extensa felicitación a todos y cada uno de los miembros de enfermería de limpieza de la comida a los camilleros y jóvenes que nos dieron un gran apoyo al mover a mi mamá en cada momento que necesitamos, no pudimos aprendernos los nombres de todas las personas que nos atendieron, pero fue maravillosa La forma en que lo hicieron todos y cada uno de ellos. Honesta mente agradecidos por sus atenciones y servicio con tanta amabilidad, empatía y profesionalismo. Espero que no me falte nadie, pero estuvimos muy agradecidos con todos y cada uno de ustedes. Muchas gracias', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2026-02-27", "hora_validacion": "15:30"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2619');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2620', '2026-02-26', 'felicitacion', 'Clarisa, Guadalupe Sierra Rangel', '107',
       '3310644939', 'Clarisasierrarangel@gmail. com', 'Personal Médico', 'Médicos de guardia',
       'La atención del médico de guardia Emmanuel fue muy amable y profesional, muchas gracias por la atención.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2026-02-27", "hora_validacion": "15:30"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2620');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2621', '2026-02-24', 'queja', 'MARIA CLARISA RANGEL GODINEZ', '107',
       '1111111', NULL, 'Hospitalización', 'Personal de admisión, Otros',
       'Senti mucha presión de la señorita de recepción de emergencias para realizar el pago de inicio como condicionado a que solo así pasaban a mi mamá na la habitación. Me pareció poco empático además ya estaba firmado el pagaré en blanco, etc. Sugerencia: más empatia y paciencia, llega uno en mal estado con su paciente a emergencias.

El hospital muy bonito y ventilado, gracias por llevar al padre y la comunión a los enfermos. Todo su personal excelente de gran calidad humana y buena disposición. Los doctores que nos apoyaron y todo el equipo médico fueron de gran bendición. Mil gracias. Mi sugerencia es hab 107 que arreglen la puerta del baño pinatada, barnizada y chapa, que a las toallas les  pongan suavitel ya que están como lijas. y de las sabanas que me dieron para el acompañante una tenía una mancha de sagre. Las almohadas terribles, me toco una de puras bolas, otra como piedra de duras y no traen fundas. Importante cuidar esa parte.

El personal de limpieza muy gentil y amable, la nutriologa muy al pendiente de todo.

Por sus valiosas atenciones muchas gracias.

Carmen Sierra Rangel.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Infraestructura", "origen_seg": "Encuesta", "fecha_validacion": "2026-02-27", "hora_validacion": "15:30"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2621');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2622', '2026-02-27', 'felicitacion', 'MARIA CLARISA RANGEL GODINEZ', '107',
       '111111', NULL, 'Hospitalización', 'Personal de enfermería, Personal de Cocina, Médico Tratante, Personal de vigilancia, Otros',
       '"AGRADECIMIENTO" VIER 27 FEB/2026
A TODO EL PERSONAL DE ENFERMERiA, MÈDICOS, CAMiLLEROS, DE COCINA, ASEO, VIGILANCIA, ESPERANDO QUE NO ME FALTE NADIE.
- MIL GRACiAS A LA DOCTORA ALMA NAVARRETE POR SU GRAN CALIDAD HUMANA, SU EMPATÍA y PROFESIONALISMO. NOS RECiBIÓ EN EMERGENCIAS DE TAL MANERA QUE NOS TRANQUILLO, JUNTO CON OTRO MEDICO QUE ESTABA ESA MAÑANA (24 DE FEBRERO)
CON GRAN PACIENCIA Y ETICA (DISCULPE QUE NO RECUERDO SU NOMBRE)
- MIL GRACIAS A ENFERMERIA, A FATIMA ELSA, CARLOS, JOSÉ, YETZARELY, MONTSE, DAYANA, PERDON SI ALGUIEN ME FALTA
-A LOS CAMILLEROS DANY, IVAN, OSCAR, IAN, FERNANDO.
- A las amables señoritas del Aseo, Fer, Lucero y Lupita.
• A cocina por sus deliciosos alimentos, a la cafetería Igualmente, muy amables y empâticos.
- Vigilancia amables y siempre atentos.
- Las supervisoras, El personal de oxigenanación, Todos gentiles.
En fin, quisiera no olvidar a nadie
y agradecer a Todos y cada uno de ustede sus atenciones durante la estancia de mi mamá en el hospital.
Por ultimo y no menos importante la maravillosa y calida atencion de la Dra. Paloma y el Dr
Manuel Aguilar, siempre atentos, apoyando y al pendiente.

No hay palabras para agradecer su cariño y atenciones.

Atentamente
Familia Sierra Rangel
Cuarto #107
Paciente: Maria Clarisa Rangel Godinez
Gracias', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico", "fecha_validacion": "2026-02-27", "hora_validacion": "15:30"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2622');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2623', '2026-03-04', 'queja', 'DELIA ZEPEDA OLMOS', '114',
       '111111', NULL, 'Hospitalización', 'Personal de enfermería',
       'SE INFUNDIO ALBUMINA POR VIA DONDE SE ADMINISTRA NOREPINEFRINA SIN PURGARLA PREVIAMENTE LO QUE CONDICIONO UN EVENTO DE HIPERTENSIÓN Y TAQUICARDIA SUBITAS CON POSTERIOR CAIDA DE LA TA EVENTO POTENCIALMENTE MORTAL PARA LA PACIENTE.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Urgente", "gravedad": "Grave", "clasificacion": "Medicamentos", "subclasificacion": "Proceso", "origen_seg": "Físico", "fecha_validacion": "2026-03-04", "hora_validacion": "17:00", "investiga": "Omar Orozco", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-03-05", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/20/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2623');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'Capital humano', '2026-03-06', 'queja', 'Yaneth', '111',
       '3323182785', NULL, 'Enfermería', 'Personal de enfermería',
       'Queremos al jefe de vuelta 😠😠😠', 'historico', 'cerrado', '{"procede": "No", "investiga": "Giselle De la Torre"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='Capital humano');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2624', '2026-03-10', 'queja', 'jose asuncion pelayo lopez', 'UCI4',
       '111111', NULL, 'Cuidados Intensivos', 'Personal de enfermería',
       'ENFERMERÍA DEL TURNO MATUTINO COMENTO EN VOZ ALTA, SI TENDRIAN ALGUN CANDIDATO PROXIMO A MORIR Y VOLTEARON A VER AL PACIENTE. POR LO TANTO SE SOLICITA EL ALTA VOLUNTARIA.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico", "fecha_validacion": "2026-03-10", "hora_validacion": "16:30", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-03-12", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/22/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2624');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2625', '2026-03-12', 'queja', 'DIANA D CAMACHO S', 'GINE 10',
       '11111111', NULL, 'Hospitalización', 'Otros',
       'ENCONTRE UNA CUCARACHA EN EL TECHO DE LA HABITACION GINE 10 EL DIA 12 DE MARZO POR LA MADRUGADA 1:30 AM.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Infraestructura", "origen_seg": "Físico", "fecha_validacion": "2026-03-12", "hora_validacion": "16:40", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-03-12", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/23/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2625');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2626', '2026-03-09', 'queja', 'MARIA ALMA GUTIERREZ FUENTES', '117',
       '18189872111', NULL, 'Enfermería', 'Personal de enfermería',
       'Ustedes tienen una enfermera o varios enfermeros que fueron con mi hermana este lo que yo noté es de que mi hermana fue operada y yo noté de que la enfermera ni siquiera se le ayudaba a moverse de la cama a mi hermana como para como cuando usted tiene una cirugía, ¿cómo usted se va a mover en la cama? ¿Verdad? La enfermera le tiene que ayudar. ¿Estoy en lo correcto o Sí, claro. O estoy mal? Sí, claro. Ok. Entonces, ok, eso fue lo que a mí no me gustó. Yo le dije a la enfermera, le digo, ¿qué clase de enfermera es usted? Así le dije. No le dije a dónde fue a la escuela porque no quiero ir ahí. ¿Sí me entiende? O no soy grosera, pero, ¿qué clase de enfermeras tienen ustedes? No todos los enfermeros fueron así, pero no me gustó, me molestó tanto. Fue mucho dinero el que yo pagué, como para que la persona hiciera lo que hizo. El nombre de la enfermera. No, no me acuerdo del nombre de la enfermera y tampoco no quiero, no le voy, no le quiero decir, o sea, mira, no quiero porque no todos fueron igual, pero esta persona fue la de la mañana, fue la última enfermera que la atendió en la mañana. Ok. Que cuando ya la iban a sacar del hospital. Sí, sí, y yo, ok, me da mucha pena, o sea, me da pena con ella, ¿verdad? O sea, porque digo, no sé qué vayan a nosotros ustedes como que acción van a tomar, pero le digo una cosa, no me gustó, yo soy clienta del hospital, ¿ok? Ahí me gusta ir, ahí ella lo escogió ahí, yo podría haber escogido Javier de San Colinas, ¿me entiende? con el mismo precio, pero como es más cerca de mi casa, por eso se fue ahí y como siempre me ahí fue donde murió mi mamá también, o sea que ahí la atendían y ahí murió mi mamá, no que la mataron, ¿verdad? O sea, ahí murió porque pues falleció. Entonces, yo le tengo confianza al hospital, pero tampoco no se vale que usted esté pagando un montón de dinero y que pues hagan eso. Yo soy la que le ayudó a mi hermana para subir a la cama, o sea, como para haz de cuenta que se sentó en su cama y pues la tiene que subir hacia arriba, ¿no? O sea, yo no fui a la escuela de enfermería, ¿mee entienden? Yo, si yo hubiera ido a la escuela de enfermería, pues no pago una enfermera, lo hago yo, pero ahí se le está pagando a la enfermera. Y y yo sí, quiero que tome acción, ¿ok? Quiero que tome porque yo voy y Yo sí, quiero que tome acción, porque fui yo primero, va a haber otra persona, o sea, es su trabajo, si no le gusta su trabajo o no le gusta lo que hace que se dedique a tomar otra otro tipo de trabajo. Entonces, quiero que tome acción. Yo no vivo en México, yo vivo en California. Entonces yo voy a saber si ustedes tomaron acción o no, acá se vive haciendo complain, por eso que yo hago complain, porque tengo mi vida de haciendo complain, porque a mí si no me gusta algo, yo voy a llamar. Mi hermana no lo hace porque en México no sé, tal vez no se use tanto, pero aquí sí se usa y yo tengo esa manera de vivir, de estar haciendo complain lo que no me gusta Y no me gustó porque mi dinero vale aquí y donde quiera. Así es. Y no quiero ser, o sea, no me lo tome que sea, no me gusta hacer esto, no es por dinero, no es por nada de eso, lo simplemente que fue la grosería que todavía le dije y no lo hizo. No lo hizo la señora. Entonces, a qué si no le gusta su profesión, que cambie de profesión. No le dije a ella, no se lo dije porque y hubo un papel que nos dieron, pero como Yo nerviosa sea, tenía mucha ansiedad, este de que tenía que correr para un lado y para otro, no es fácil para mí, estás haciendo, yo no llené ese papel, lo tengo en bueno, no lo tengo conmigo, está en casa de mi hermana. Pero yo dije, no te preocupes, yo voy a llamar, yo voy a hacer el complain, yo lo voy a hacer.  Sí, sí, yo no la llené digo por no la llené porque tengo mucha ansiedad me dio una ansiedad muy fuerte y cuando usted tiene ansiedad, usted no puede hacer cosas, ¿me entiende? Todo el dolor en el cuerpo de lo mismo, de que miré que no, o sea, mi hermana con dolor y todo lo que hizo en la señora, o sea, yo le repito, no todos los enfermeros, simplemente stan víctima que no ayudó. De acuerdo para la cara a ella mi dinero no quiere ver caras, mi dinero quiere ver trabajo que yo estoy pagando, no estamos ahí este para no pagar. se les pagó esta centavo entonces, ¿cómo es de que ella tuvo que hacer eso? ¿Me entiende? Entonces sí, quiero que haga acción. Sí, está bien directamente este ve lo que sucedió. Igual a lo mejor ella necesita un poco más de. De capacitación Sí, de capacitación, tal vez no sé no quiero ser mala con ella que sí me molestó, Sí, porque mira, ella ni siquiera te digo así, ni siquiera movió sus manos para nada para nada y le dije yo, le dije qué le está pasando por qué no está ayudando ¿me entiendes? ¿ Porque qué no está ayudando, se quedó callada, pero no dijo nada, o sea, se quedó callada y no hizo nada. Y pues no, yo no la iba a pelear tampoco, ¿me entiendes? Yo dije, pues me la voy a guardar. Yo fui la que le ayudé a mi hermana con lo poquito que yo sé, metí mis brazos en sus la parte de axilas para empujarla hacia arriba, lo cual yo no lo puedo hacer. Y o sea, yo tengo un problema en mi cuerpo que no tengo la fuerza como para hacerlo, pero yo fui la que le ayudé porque ella no se podía mover. Entonces, ¿cómo? ¿Cómo se iba a estar en la cama hacia arriba? Y sí, sí me molestó bastante. dije, bueno, esto lo voy a lo voy a hacer ya que llegue a mi casa que estoy acá en mi casa dije, lo voy a llamar, voy a hacer una llamada y voy a hacer el reclamo porque pues no es lo que pasa, mira, no todos los enfermeros son iguales, porque ahí estuvo mi mamá y todos, mira, bien capacitados, movían a mi mamá con la sábana, yo miraba qué es lo que hacían porque una vez tiene que ver y pues lo puedes aprender. Agarraba un enfermero de de un lado y de otro y la subían con la sábana. Ella se lo entendía que llamar a alguien si no pudiera, tendría que llamar a su compañero y decirle, mira, necesito que vengas y me ayudes a mover al paciente. Digo yo que eso es lo que tendría que haber hecho. ¿me entiendes? Y ella sentía que estaba muy pesada para ella. Pues tiene compañero de verdad? de trabajo, tiene que llamar y ¿verdad? Pero no nada, no, no, no. Nomás sí me dijo, ves que como yo hablo muy fuerte, no sé si tú lo sientes también Mi voz es muy fuerte, así me dijo, señora, pero no me grite, le dije, no es que no te estoy gritando, o sea, es mi manera de hablar. O sea, yo tengo la voz muy fuerte como que estoy enojada y como que te digo las cosas muy con mucho carácter, pero es mi manera de ser, no falto el respeto, no quiero faltar el respeto a nadie porque no está bien. Para mí no, como no me gusta a mí que me lo hagan tampoco no lo hago pero sí sí me molestó bastante lo que ella hizo, o sea que ni siquiera movió ni un dedo como para. Era como que como te voy a decir una cosa, como que a ella no le gusta lo que hace, o sea, la vi desde el principio y como que no le gustaba lo que hace. Bueno, eso es lo que en mi comentario. Pero sí, quiero que tome acción y pues no sé que hagan algo al respecto porque mi hermana regresa. Mi hermana regresa y no quiero este, ¿me entiendes? No quiero va a regresar con el doctor, la van a evaluar otra vez este no sé cómo está ahorita, pero es el hospital que usamos Sí, está bien gracias por la ayuda. Muchas gracias.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Otros medios", "hora_validacion": "16:05", "recibe_llamada": "MARIA ALMA GUTIERREZ FUENTES", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-03-13", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/24/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2626');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2627', '2026-03-13', 'felicitacion', 'MARIA DEL ROSARIO GUEVARA FRANCO', 'JP 9',
       '3339527731', NULL, 'Enfermería', 'Personal de enfermería',
       'POR ESTE MEDIO QUEREMOS FELICITAR A LA ENFERMERA QUE NOS ATENDIO DURANTE EL 3ER T (13/03/26) POR SU EFEICIENCIA, CALIDEZ Y PACIENCIA Y SU AFAN DE SERVICIO, PREGUNTAMOS SU NOMBRE Y NOS DIJERON QUE ERA KARINA MORENO GRACIAS!', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2026-03-17", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-03-17", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/25/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2627');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'capital humano', '2026-03-20', 'queja', 'Alizbeydi Vázquez', 'Juan Pablo 11',
       '3326838820', NULL, 'Intendencia', 'Personal de Intendencia',
       'Actitud prepotente por parte del paciente hacia el personal de intendencia. Al ingresar a la habitación para realizar el aseo rutinario, el paciente hace comentarios desagradables y sarcásticos, minimizando las actividades del departamento de intendencia.', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='capital humano');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2628', '2026-03-23', 'queja', 'LUIS IGNACIO DELGADILLO MEDINA', 'JP 11',
       '111111111111', NULL, 'Hospitalización', 'Personal de enfermería, Personal de Cocina',
       'PESIMA COMUNICACION ENTRE PERSONAL DE ENFERMERÍA EN CUANTO EL LLENADO DE BITACORAS
NADIE QUISO RECOGER LA CHAROLA DE COMIDA
LA COMIDA FRIA, INVENTOS DE COMIDA SIEMPRE ME DIERON TÉ.
FALTA DE EMPATIA Y HUMANIDAD PRO PARTE DEL PERSONAL DE ENFERMRÍA AL PEDIR ALGUN FAVOR.
EL DOCTOR DE GUARDIA NO RESOLVIO
A LAS 6:00 AM TOMAN SIGNOS VITALES  Y A LOS 10 MIN VOLVIERON A ENTRAR A TOMAR LOS SIGNOS QUE PORQUE NO LOS TENIAN REPORTADOS.
SE PIDIO QUE SE TOMARA LA GLUCOSA Y NO QUISO LA ENFERMERA PORQUE NO ESTABA INDICADO, DESPUES SI LA TOMARON PORQUE SE LE PIDIO HABLAR CON EL MEDICO DE GUARDIA.
LA COMIDA ES PESIMA PORQUE INTENTAN HACER PLATILLOS GOURMET, NO TIENEN SABOR Y LOS LES SALE LA COMIDA, CAMBIARON LA COMIDA POR UN SANWICH DE JAMON PERO LLEVABA SOLO JAMON Y MORRON.
LA COMIDA LLEGA FRIA
LOS DETALLES HACEN LA DIFERENCIA, NADIE RESOLVIO.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Visita", "fecha_validacion": "2026-03-23", "hora_validacion": "18:00", "recibe_llamada": "Luis Igancio Delgadillo Medina", "investigacion": "Paiciente con 15 dias de estancia hospitalaria, inconforme con la actitud y procesos de enfermería, inconforme con alimentos, el medico tratante lo daria de alta sin embargo no acude.", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-03-24", "persona_notifica": "Giselle De la Torre"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2628');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'capital humano', '2026-03-27', 'queja', 'Ma. Del Carmen Ornelas capuchino', 'Suite 3',
       '3325542759', NULL, 'Personal Médico', 'Personal de enfermería, Médicos de guardia, Médico Tratante',
       'El día de hoy recibí paciente en cuidados paliativos y familiares ansiosos , su paciente solo estaba esperando fallecer, perdió signos vitales y solo quedó conductividad eléctrica o pulso a lo cual los familiares desesperados que por qué ya no querían la ventilación mecánica llamaron a su médico tratante o paliativista dr Farid , el cual yo escuché cuando le dijo enseguida me comunico al hospital para que le quiten la ventilación , el llamo le pregunté su nombre y me indico cerrar el oxígeno del Ohio del paciente me dijo que lo hiciera que los médicos ya subirán  y cuando entre al cuarto delante de los familiares ellos vieron que no tenía ya pulso subió el dr y le tomo un trazo con el electro y las palas a lo cual confirmo el deceso , molestos médicos de guardia y jefatura de enfermería me indicaron que yo no podía hacer dicha orden por lo cual el familiar argumento que fue su decisión. Y los médicos de guardia aseguran que el dr Farid les dijo que tuvieran cuidado que no cerrara yo el oxígeno que por qué yo lo quería cerrar entonces no comprendo su comunicación efectiva ,su desorganización y falta de capacitación en la que nos tienen no explican protocolos en vez de enseñar los mismos temas .', 'historico', 'cerrado', '{"investiga": "Giselle De la Torre"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='capital humano');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2629', '2026-03-28', 'sugerencia', 'Santiago', '1 ginecologia',
       '3320768380', 'santiagoanton553@gmail.com', 'Enfermería', 'Personal de enfermería',
       'Se tuvo un mal sabor de boca. Cuando estando en  el.cuarto con mi paciente. Una sra de 81 años. Se empezó a escuchar a enfermeros. Con enfermeras. Hablando obscenidades  y leperadas.  Al igual me asome para ver si guardan compostura y o solpresa tenía un enfermero abrazado a una enfermera por detrás me.dio y se. Quitaron rápido   pues. La verdad se notó.   L.afalta de ética. Y profesionalismo .uno entiende q son chavos pero siemtonq no es el lugar para q se expresen así esto fue en el turno nocturno.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2026-04-01", "hora_validacion": "15:00", "investiga": "Omar Orozco", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/27/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2629');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2629', '2026-03-28', 'queja', 'Carlos Santiago Anton', 'Gine 1',
       '3320768380', 'santiagoanton553@gmail.com', 'Administración', 'Personal de enfermería, Personal de Cocina, Personal de vigilancia, Otros',
       'Todo comenzó con el ingreso de mi paciente por urgencias todo bien hasta ahí, nos hacen firmar un aviso de confidencialidad. Pasamos a dejar  a mi paciente en su habitación. P la Iván a preparar para una operación.  Sucede q el día sábado 28 de marzo. Se recibe una llamada telefónica al número del hospital pidiendo informes de la paciente y este se le brinda.  A un familiar no deseable el cual se presenta el domingo 29 de marzo  se les metió  a escondidas a seguridad y la persona dio hasta el cuarto alegando   el PQ no se le había informado  nada  q ahí estaba q tuvo q llamar al hospital para saber todo. Lo cual. Me lleva a preguntarme q seguridad tiene el hospital ,  y PQ se viola la ley de privacidad  siendo que legalmente está penado por la ley. En un caso mucho más estricto y difícil imaginemos q se mete cualquier persona y hiere o ocasiona un   desastre.   Son temas para mí muy delicados. Otra queja más es del área de enfermería en 2 ocasiones.  Los mismos enfermeros abrazándose. Y acariciándose en pasillo de gine 1  ,la atención de ellos pésima. ,su vocabulario vulgar no propio de un hospital ,se le tiene q decir q hagan para que atiendan al paciente
El.personal de cocina.  Pésimo toda la semana el menú fueron tacos  de nada sirve. Que tengan un menú si el 90% del menú no hay, PQ no quieren preparar 2 veces  fui a apartar mi cena y la sra de la tarde nunca escribió  q se apartaría   la comida y la acabaron vendiendo aún estando pagado  otra cosa en la mañana toda la.aemana me dijeron q abrían a las 9am cuando una madre me dijo. Q desde las 7:30 am ya se podía vender pero nada  me voy con un pésimo sabor de boca', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Buzón", "fecha_validacion": "2026-04-01", "hora_validacion": "15:00", "investiga": "Omar Orozco", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/27/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2629');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'capital humano', '2026-04-01', 'sugerencia', 'Nayeli Antimo', 'Enfermería',
       '3317961893', NULL, 'Enfermería', 'Otros',
       'Dejarnos utilizar tenis clínicos para laborar, ya que son mas cómodos que los típicos zapatos de enfermería', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='capital humano');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2629', '2026-03-31', 'queja', 'KARINA NOEMI FERNANDEZ ZAMORA', 'Gine 1',
       '3329525686', 'lic.noemi.fdez@gmail.com', 'Enfermería', 'Personal de enfermería',
       'El enfermero Irving de Gine en el turno nocturno, al entrar a la habitación no toca, no menciona lo que le va a hacer al paciente ni el medicamento a suministrar, poca empatía con el paciente. Adicional son poco profesionales ya que no dan seguimiento a los pacientes, en nuestro caso le cambiaron la bata que uso en cirugía hasta 2 días después de salir.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2026-04-01", "hora_validacion": "15:00", "investiga": "Omar Orozco", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/27/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2629');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2629', '2026-04-01', 'felicitacion', 'KARINA NOEMI FERNANDEZ ZAMORA', 'Gine 1',
       '3329525686', 'lic.noemi.fdez@gmail.com', 'Enfermería', 'Personal de enfermería',
       'Mi felicitación y reconocimiento a la enfermera Salma de Gine 1 del turno de la mañana. Muy dedicada, empática, profesional,  simpática y atenta con mi paciente. Estuvo siempre al pendiente de lo que requería.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "fecha_validacion": "2026-04-01", "hora_validacion": "15:00", "investiga": "Omar Orozco", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/28/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2629');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2629', '2026-03-27', 'queja', 'ILDA RAFAELA PAEZ HER', 'GINE 1',
       '111111', NULL, 'Enfermería', 'Personal de enfermería',
       'EL DIA DEL INGRESO ESTABA ENFERMERIA COMO SI FUERA CIRCO LA CENTRAL DE GINE 1 LAS CHAVAS Y CHAVOS ENFERMEROS ABRAZADOS Y CON UNAS CARCAJADAS SUPER FUERTES, PLATICANDO LEPERADAS, IMPRUDENTES QUE PARA UN HOSPITAL NO ESTA BIEN, EL ENFERMERO IRVING DEL NOCTURNO DEL 31-03-26 PESIMO TRATO PESIMA ATENCION.  SE REPORTO A DIVERSAS AREAS, INVITAN A NO VOLVER NUNCA', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico", "fecha_validacion": "2026-04-01", "hora_validacion": "15:00", "investiga": "Omar Orozco", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/27/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2629');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2630', '2026-04-01', 'queja', 'J.ISAAC PEREZ', 'GINE 5',
       '1111111', NULL, 'Hospitalización', 'Personal de enfermería',
       'MI PACIENTE SE CAYO DEL QUIROFANO ANTES DE LA CIRUGIA, SE GOLPEO LA CABEZA, LE PUSIERON 3 CATETER VENOSO CENTRAL Y NO LOS USO EL PACIENTE, ME COBRARON LA SANGRE,', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Físico", "fecha_validacion": "2026-04-03", "hora_validacion": "18:00", "recibe_llamada": "Kristal Perez", "investigacion": "Se revisa expediente clinico no encontrando evidencia de la caida del paciente ni de ningun incidente en quirofano, referente a los cateteres centrales el primero estaba perforado por el cual se regresa a proveedor, el segundo cateter se evidencia que se encontraba acodado, y el tercer cateter se revisa por medico de UCI el cual esta funcional, referente a la sangre se explica que lo que se cobra es el procesamiento de los hemoderivados, refiere no tener dinero para el pago de cuenta por lo cual busca un descuento en el estado de cuenta.", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/30/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2630');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2631', '2026-04-05', 'queja', 'RAMONA ROSTRO RAMOS', '105',
       '1111111', NULL, 'Hospitalización', 'Personal de enfermería',
       'EN MI ESTADIA EN ESTE HOSPITAL EL DESPACHADOR DE AGUA EN LA SALA DE ESPERA (NO HABIA VASOS) POR LA TARDE EN LOS DESPACHADORES (NO HABIA AGUA EN EL TRANSCURSO DE TODA LA NOCHE) POR LA NOCHE LA ATENCION AL PACIENTE ES PESIMA (NO HAY ENFERMEROS SUFICIENTES PARA CUBRIR EL TURNO LA PACIENTE ESTUVO SIN ATENCION POR LARGAS HORAS. EL BAÑO POR LA NOCHE DESPIDE UN OLOR PUTRIFICANTE. EL SERVICIO DE COMIDA AL PACIENTE POR LAS TARDES (NO EXISTE) POR FALTA DE PERSONAL.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "fecha_validacion": "2026-04-06", "hora_validacion": "16:40", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/31/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2631');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2632', '2026-04-07', 'sugerencia', 'Judith Godínez Estrada', '18',
       '3321181505', NULL, 'Alimentación', 'Otros',
       'La chica que cobra en la cafetería tiene muy mala actitud y nada de empatía', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Buzón", "hora_validacion": "9:15"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2632');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2633', '2026-04-08', 'felicitacion', 'Ana Maria Ines Mann Lopez', '112',
       '3317045536', NULL, 'Personal Médico', 'Médicos de guardia',
       'Quiero felicitar a personal de guardia (medicos) ya que siempre presentan buena actitud y tienen todo en orden asi como excelente trato con pacientes y familiares.  


Dr. Arturo Barragán', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Físico", "fecha_validacion": "2026-04-13", "hora_validacion": "16:30", "fecha_notificacion": "2026-04-13", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/35/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2633');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2634', '2026-04-13', 'queja', 'Maria del Socorro Santiago Vargas', 'hemodialisis',
       '3314462457', NULL, 'Hemodiálisis', 'Personal de enfermería, Personal de Cocina',
       'Venimos a hemodialisis lunes, miercoles y viernes, no dan de comer, viene en horario de 11:00 am y salimos a las 14:30. Incluye comida pero nunca le dan su comida durante la sesión de hemodialisis, cambie de horario a las 15:00 hrs esperando que ahora si le den merienda.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Físico", "fecha_validacion": "2026-04-13", "hora_validacion": "16:30", "recibe_llamada": "Gabriela Espinoza", "investiga": "Giselle De la Torre", "fecha_notificacion": "2026-04-13", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/36/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2634');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2635', '2026-04-15', 'felicitacion', 'Cesar cornejo', 'Terapia intensiva',
       '3314398282', 'cesar.huracan19@gmail.com', 'Terapia Intensiva', 'Personal de enfermería, Médicos de guardia, Personal de Intendencia, Médico Tratante',
       'Muy buen trato de médicos de guardia, del personal de intendencia, del medico que la trata, siempre preocupándose por la salud de mi familiar, teniéndonos al tanto de todo y hasta consintiéndola aun en terapia intensiva, le ponen la música que a ella le gusta, muy buena experiencia hace el mal rato que pasamos se disminuya, muy buenas personas cheli y una personal de intendencia que nos alentó a rezar y nos dio fuerza.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2635');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2636', '2026-04-19', 'felicitacion', 'Octavio Augusto González Trejo', 'S/n',
       '3332013993', 'exteg.octavio@gmail.com', 'Urgencias', 'Personal de enfermería, Médicos de guardia, Personal de admisión, Personal de Intendencia, Médico Tratante, Personal de cajas, Personal de vigilancia',
       'Muy rápida la atención', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2636');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2637', '2026-04-26', 'queja', 'Gil Carrasco Tenorio', 'JP12',
       '--', NULL, 'Seguros', 'Personal de seguros',
       'Al salir por tema de las aseguradoras ojala y pudieran presionar un poco para que tengan mejor respuesta.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "numero_oficio": "HSMCA/36/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2637');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2638', '2026-04-26', 'queja', 'Carlos Palacios Glez', 'UTI',
       '3318957007', NULL, 'Enfermería', 'Personal de enfermería',
       'Salio papa del quirofano el sabado 25 de Abril a las 8:30 pm se lo llevaron a la terapia intensiva y mama y yo seguimos en la habitacion 117 que fue la que se asigno , a las 12:45 aproximadamente sali a pedirle a las enfermeras una cobija en dos ocasiones y no me fue dada , pertenezco a una religion donde mi forma de vestir es usar falda larga, las enfermeras de la noche nos veian diferente y por ignorarnos al pedir la cobija lo llamo una discriminacion, religiosa pido la atencion para que futuros pacientes que lleguen y vistan diferentes no pasen por esta falta de respeto. Se me pidio desalojar la habitacion a esa hora. Sin mas me despido agradeciendo la buna atencion de los doctores, y agradezco la atencion de la Lic. Gabriela Figueria', 'historico', 'cerrado', '{"procede": "No", "categoria": "Queja"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2638');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2639', '2026-05-09', 'queja', 'Carolina Magaña Macias', 'TERAPIA INTENSIVA 2',
       '3311631569', 'dracaritomm@gmail.com', 'Cuidados Intensivos', 'Otros',
       'La técnico radiólogo de la guardia del viernes regreso una paciente grave del área de choque a choque nuevamente porque no tenia el material preparado a pesar de recomendarle que la colocáramos en el área de tomografía y mientras preparara el material lo que pone en riesgo al paciente de aumentar el número de traslado', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2639');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'capital humano', '2026-05-13', 'queja', 'Andrea Lopez', 'Gine 17',
       '3322064425', NULL, 'Personal Médico', 'Médicos de guardia',
       'Medico de guardia Daniela Hernandez llego alzando la voz preguntando que estaba pasando con las indicaciones médicas, el cual le comencé a explicar la situación y que solo fue un comentario de realizar o mejorar las indicaciones con las dosis ya que enfermeria nos podemos equivocar y solo para evitar esa situacion lo comente y me respondió que para eso tenemos que leer bien y que las indicaciones de hoy asi se quedarían y no las modificaría si no hasta al dia siguiente, se molesto y se fue muy enojada el cual siento que no tuvo por que actuar de esa manera', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='capital humano');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'capital humano', '2026-05-13', 'queja', 'Goretty Miranda', 'N/a',
       'N/a', NULL, 'Enfermería', 'Personal de enfermería, Médicos de guardia',
       'La médico de Guardia Daniela Hernández, se dirige hacia el personal de enfermería de maneja muy alebrestrada, en ocasión los grita, otras veces insiste en lo que tenemos que hacer ejem. El 13 de mayo tomamos lab de una habitación y la dinámica es llamarles a laboratorio, nosotros no les insistimos en que pasen a recoger ya que sabemos los tiempos de cada área de trabajo que están ocupados, pero ella pasa y nos repite las actividades, como pedir consentimientos para algún procedimiento cuando nosotros ya sabemos que tenemos que pedirlos son detalles y maneras incorrectas de dirigirse hacia nosotros ya que trabajamos todos en equipo entre personal del personal literal. Sentimos que nos ve más como enemigos que como equipo de compañeros', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='capital humano');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'capital humano', '2026-05-14', 'sugerencia', 'Enfermería', 'N/A',
       'N/A', NULL, 'Enfermería', 'Personal de enfermería, Otros',
       'Nos gustaría que al personal de enfermería nos permitiera utilizar calzado más cómodo como tenis blancos que también cumplen con los caracteres que se solicitan en el hospital, como tipo de tela, color y anti derrapante', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='capital humano');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'capital humano', '2026-05-19', 'queja', 'Andrea morett tirado', 'URGENCIAS',
       '3310106588', 'andie_187@hotmail.com', 'Personal Médico', 'Médico Tratante',
       'El dia de hoy en el servicio de urgencias ocurrió un incidente con un medico tratante. La dra guillermina lomeli garcia,  envío a una paciente para ser valorada y abordada en nuestro servicio de urgencias adultos. La dra solicitó estudios de laboratorio, resultados, signos vitales de la paciente vía telefónica con una actitud grosera y prepotente. Siendo yo la urgenciologa a cargo de la paciente a su ingreso, se inició el abordaje diagnóstico terapéutico, a pesar de la mala actitud de la doctora guillermina, (quien se comunico vía telefónica y por mensajes, exigiendo resultados de laboratorio y contexto del paciente) se dio el tratamiento y abordaje. Se dio informes a familiares. Ella como medico tratante mando mensajes dando indicaciones como si el servicio de urgencias fuera un servicio donde solo se reciben pacientes con médicos tratantes y se siguen instrucciones de los mismos. El servicio de urgencias es la puerta de entrada al paciente para inicio de abordaje y estabilización del paciente grave según el criterio de nosotros como urgenciologos. Es una falta de respeto para mi y para el servicio de urgencias que la dra guillermina lomeli garcia exija abordaje de su paciente con actitud grosera y despectiva sin antes venir a valorarlo y dudando de nuestra funcion como urgenciologos.', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='capital humano');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'capital humano', '2026-05-20', 'felicitacion', 'Araceli', 'Terapia intensiva',
       '331040 8180', 'aracorona293@gmail.com', 'Intendencia', 'Personal de Intendencia',
       'Quiero felicitar a la señorita lucero por su buen desempeño en su trabajo es muy amable y respetuosa hacia las personas que la rodean nosotros tenemos casi 15 dias mirando su desempeño y es muy amable y mire a una compañera de.ella creo que es la supervisora de limpieza,  es despota en su forma de tratarla acababa la señorita lucero de hacer el aseo y la hizo que volviera a limpiar todo 2 veces más y no se me hizo justo que la.tratara mal en frente de mas personas que estabamos presentes lucero estaba haciendo muy bien su trabajo', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='capital humano');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'capital humano', '2026-05-15', 'queja', 'Yadira', 'Terapia',
       '33 12364578', NULL, 'Intendencia', 'Personal de Intendencia',
       'Me pareció muy grosera la gefa de intendencia y le falto el respeto a una de sus compañeras no por tener ese puesto tiene que ser grosera con las demas', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='capital humano');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2642', '2026-06-03', 'queja', 'Omar Alejandro Hernandez Flores', '109',
       '3317359365', NULL, 'Cafetería', 'Otros',
       'El dia de hoy fui a la cafeteria y la verdad muy mal servicio ya que me comentan que hasta que se desocuparan me podian atender, la que me recibio y me contesto mal fue la que estaba en la caja.', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2642');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2643', '2026-06-04', 'queja', 'Margarita Castellanos (Sergio Enrique Castellanos Perez)', 'Gine 11',
       '3338095719', NULL, 'Alimentación', 'Personal de enfermería, Personal de Cocina, Otros',
       'Moscos por la noche que no dejan dormir y peligro de infección. 
Fecha de entrada 2 junio se solicito ventilador y nos comentaron no tenian, estaba descompuesto, no hay agua calIente en regadera ni lavabo, limpieza tardia.
El servicio de enfermeras deficiente ya que la bomba de medicamento sonandole la alarma durante noche y hasta el miercoles en la tarde se percato la enfermera Alejandra del turno de la tarde se percato y solicito cambio de infiltrado ya que no estaba en la vena el cateter y no se habian dado cuenta.
Los alimentos llegaban tarde por la mañana, incurriendo en que no le podian dar sus pastillas a la hora de siempre. La toma de signos vitales hoy jueves 4 tardia, solicite a la enfermera en turno a que hora se los tomaria y me menciono que a las 8:00 cuando fui a preguntar al area son las 7:58 llego 8:40 atrasando la toma de medicamentos, el desayuno llego a la mismo tiempo, el enfermero llegó a poner la nebulización en el mismo momento cosa que no permití porque no habia desayunado, no le habían tomado los signos vitales, el martes le pusieron junto con el desayuno la nebulizacion (primero nebulizacion, inmediatamente el desayuno y se ahogo, nadie menciono que habia que esperar media hora, solo menciono posteriormente el Dr. Ureña.
Solicitaron por prescipcion medica un sillon mismo que por el tamaño no puedo entrar el primer dia dejandolo afuera de la habitacion, sali y me di un golpe con el, fue testigo la enfermera de nebulizaciones. 
Al dia siguiente metieron el  sillon y lo sentaron, diciendo que si cabia pero tenia su "maña" 3 horas en sillón.
Los camilleros muy amables.
Enfermera muy amable (Alejandra turno de la tarde)
Enfermera de nebulización muy amable (Turno de la mañana)
Área de cafeteria - muy amables cocineras.
La enfermera turno nocturno muy amable - guardia A
Extensión telefonica no sirve
Televisión el aparato del control no estaba a la vista, alejandra ayudo en turno vespertino.', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2643');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2644', '2026-06-01', 'queja', 'Aurelia Hernández Ríos', 'Gine 5',
       '3313592622', NULL, 'Enfermería', 'Personal de enfermería',
       'El dia 1 de junio no se le administraron los medicamentos de manera adecuada, no hubo atención de la mañana a la noche, mi familiar presento mucho dolor por la tarde y el médico considero poner un medicamento más fuerte, creyendo que si tenía los anteriores. A partir de ahi hubo complicaciones que nos llevaron a estar 3 días  más internados y la canalizaron mal en varias ocasiones, el medicamento no se administraba adecuadamente.', 'historico', 'cerrado', '{}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2644');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2641', '2026-05-31', 'sugerencia', 'Adelaida Torres Robles', 'Gine 13',
       '111111', NULL, 'Alimentación', 'Personal de Cocina',
       'Mejorar la calidad de los alimentos de los pacientes. Y de la cafeteria mejorar los alimentos y atención.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Sugerencia", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2641');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2640', '2026-05-29', 'queja', 'Guillermina Cuevas', '117',
       '111111', NULL, 'Hospitalización', 'Médicos de guardia, Otros',
       'Nunca atendió el médico de guardia con mala atención por parte de los médicos del hospital, el médico de guardia nunca visito a la llegada.

El personal de enfermería excelente.

La calidad en general del hospital mala tomando en cuenta sus costos, hospital como Bernardette es mejor precio y atención al paciente, en instalaciones y al familiar.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Encuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2640');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2641', '2026-06-15', 'queja', 'Angel Martinez Velasco', '115',
       '3320639593', NULL, 'Enfermería', 'Personal de enfermería, Otros',
       'el dia 15 de junio a las 23:00 se solicito apoyo para acomodar al paciente (mi papá) llego el especialista en inhaloterapia y explica como usar el espirometro lo cual menciono que mi papá se veia incomodo en la posición que estaba y le dije que si que estabamos esperando al camillero que mandaría el medico de guardia. Posteriormente la especialista en inhaloterapia salio por apoyo para acomodarlo y entro un enfermero (Daniel) el cual llego de un amanera prepotente azoto el barandal de la camilla y jalo las sabanas bruscamente y las recorrieron brutalmente ambos, mi papá le dijo que no era un animal, que es un humano que lo respetara y la chica de inhaloterapia burlonamente dijo cuidado tratalo bien como un niño, se salieron de la habitación y dejaron hablando solo a mi papá el cual lo dejaron incomodo y molesto por la actitud que tenian.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2641');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2642', '2026-06-17', 'sugerencia', 'Anonimo', 'Pa116',
       '3312819371', NULL, 'Cafetería', 'Otros',
       'El menú de cafetería siempre es el mismo, chilaquiles huevos , y lonches nunca hay variedad además hacen bien poquito y las 10:30 ya no tienen nada ! Deberían hacernos más menús más comida', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Proceso"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2642');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2643', '2026-06-18', 'felicitacion', 'Odette Alejandra Fabián Arciniega', '117',
       '3312293798', 'ofabianarciniega@gmail.com', 'Enfermería', 'Personal de enfermería, Médicos de guardia, Personal de admisión, Personal de Intendencia',
       'Mi papá a tenido 4 cirugías y hemos elegido este hospital, quiero felicitar el servicio de todo el hospital y en general al personal que nos ha tocado según la habitación, en especial felicito al enfermero José Guadalupe por excelente servicio al igual que todos. Nos vamos agradeciendo  las atenciones de todos', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2643');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2644', '2026-06-18', 'queja', 'Maria Lorena J', 'SUITE 2',
       '1111111', NULL, 'Vigilancia', 'Personal de vigilancia',
       'Si la persona encargada de ingreso a visitantes fue siempre muy grosera con mis amigos y familiares a pesar de estar en una suite siempre nos hostigo, vigilo y trato mal. Esta situación fue con la mujer, los vigilantes masculinos siempre nos apoyaron.
La mujer es grosera, prepotente y altanera. Atención en este punto.
Los enfermeros y camilleros son excelentes con amor a su profesión y el personal y el personal de intendencia siempre muy servicial.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2644');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2645', '2026-06-26', 'felicitacion', 'Gerardo', '13',
       '3331173816', 'garfiaspajarito@gmail.com', 'Cafetería', 'Otros',
       'Muy rica, limpia la comida', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Felicitación", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Capacidad instalada", "subclasificacion": "Proceso"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2645');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2646', '2026-06-27', 'queja', 'alfredo duoral', 'JP12',
       '1111111', NULL, 'Enfermería', 'Personal de enfermería',
       'Primer hospital donde no dan servicio de bañar al paciente, de ayudar a cambiarlo o a nada!, El hospital muy bueno, los dres excelentes pero el DEPARTAMENTO DE ENFERMERIA FATAL!!', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2646');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2647', '2026-07-08', 'queja', 'Israel Fajardo Nieto', 'PB117',
       '3323981774', NULL, 'Enfermería', 'Personal de enfermería, Personal de Intendencia',
       'Limpieza general no se realiza a habitación, no se realiza a profundidad. Hoy 8 de julio no se ha realizado la limpieza.
Enfermería 06 de julio tardo en entregar sabana en el turno nocturno se solicito 3 veces.
Tarda enfermería en acudir a servicio a habitacion hasta 1 hr 30 min en atención. 
Solicitó 2 botellas y no llega pronto.
Kit de bienvenida emntregaron hasta las 10:00 pm, y el paciente entro a las 2:00 pm.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2647');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2648', '2026-07-11', 'queja', 'Maria Magaña Ramirez', '202',
       '3325356131', NULL, 'Enfermería', 'Personal de enfermería',
       'Estoy muy molesta por el trato que le dieron ayer 11 de julio a mi mamá, pues no estubieron pendiente de su aseo.
Tuvo falta de aseo a mi mamá, ya que les pedí varias veces que me ayudarán cambiandole su pañal. (También nos pidieron que compraramos pañales).
Fue en el turno vespertino.
Los pañales no los lleve porque al final la farmacia estaba cerrada y no encontré, el motivo que me los pidieron fue porque no tenían de su talla.
Paso toda la noche con el mismo pañal hasta el día siguiente que llego el otro turno y se lo pedía a otra enfermera.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Físico", "fecha_validacion": "2026-07-11", "hora_validacion": "17:00", "revision_expediente": "SI", "llamada_entrevista": "Mensaje", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "María Magaña (hija)", "investigacion": "El día de ayer domingo 11 de julio realize una queja por la falta de aseo hacia su persona ya que les pedí varias veces que me ayudarán cambiándole su pañal.\n(También nos pidieron que compráramos pañales) Paso toda la noche con el mismo pañal hasta el día siguiente q yego el otro turno y se lo pedí a otra enfermera", "investiga": "Giselle De la Torre", "medio_notificacion": "Mensaje de texto, Oficio", "fecha_notificacion": "2026-07-14", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/72/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2648');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2649', '2026-07-13', 'queja', 'JP', 'JP 6',
       '111111', NULL, 'Enfermería', 'Personal de enfermería',
       'El viernes mi mamá le pidio a una de las enfermeras que si podian darle un baño, yo me imagino que con esponja porque mi papá ya tiene nula movilidad entonces está usando pañal y uno de los medicamentos lo hacen evacuar mucho, se le solicito que si le cambiaban el pañal y lo bañaban pero la enfermera le dijo que tenia que ser por indicacion medica, no sé si sea o no parte de los servicios que se pueden prestar o este contemplado, pero la enfermera le comentó que para hacer eso necesitaba como que una instruccion medica o autorizacion del medico para darle el baño, pues ya paso el fin de semana y me comentó mi mamá hace rato que ayer en la noche uno de los enfermeros porque mi mamá les volvio a comentar del baño y uno dijo que pues la verdad no que no era cierto, eso que necesitaba la orden del medico para darles un baño a los pacientes.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Otros medios", "fecha_validacion": "2026-07-13", "hora_validacion": "10:00", "revision_expediente": "SI", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Cuidadora", "investigacion": "le comentan a la esposa del paciente que no tiene la indicacion medica de bañar al paciente, por lo cual no se realiza el baño", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-07-14", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/73/2026"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2649');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2650', '2026-07-13', 'queja', 'ANGELICA ZAMORA DELGADO', '003',
       '11111111', NULL, 'Enfermería', 'Personal de enfermería',
       'QUE TENGAN MAS CUIDADO CON LA COMIDA YA QUE ESTAN DEMASIADOS CONDIMENTADAS Y NO ACORDE A LAS INDICACIONES MEDICAS.
EN CUANTO ALAS ENFERMERAS SE NECESITA MAS PERSONAL YA QUE SIEMPRE ESTAN A PRISA Y EN MI EXPERIENCIA ESO HIZO RETROCEDER MI PROCESO A EXCPECION DE MAYRA, FATIMA, MARIA LUISA Y ALEJANDRA QUE SIEMPRE HICIERON MUY BIEN SU TRABAJO A PESAR DE CARGA DE TRABAJO.', 'historico', 'en_proceso', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Trato digno", "origen_seg": "Encuesta", "llamada_entrevista": "No aplica", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/76/2026", "resolucion": "Carga laboral condicionando la atencion del paciente, no hay evidencia documental de la continuidad de la atención", "fecha_resolucion": "2026-08-03", "observaciones": "No es conluyente la contestación de enfermería, Cocina no dio respuesta"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2650');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2651', '2026-07-22', 'queja', 'MA REFUGIO AGUAYO SOLIS', 'GINE 10',
       '3311319790', NULL, 'Hospitalización', 'Personal de enfermería',
       'INGRESO EL DIA 20 DE JULIO PARA UN PROCEDIMIENTO DE DRENAR UN ABCESO EN CRANEO AL NO HABER HABITACION O ESO ARGUMENTARON LE ASIGNAN EN TEORIA MOMENTAMENTE UNA EN GINECOLOGIA, MISMA QUE HASTA EL DIA DE HOY NO HA CAMBIADO. EL SERVICIO DE ENFERMERIA PESIMO, ENTIENDO QUE PUEDA HABER PERSONAL EN PRACTICAS PERO DEBERIA DE SER CAPACITADO, PREGUNTE Y DICEN QUE NO SON PRACTICANTES, PEOR AUN, PUES LASTIMARON A MI SUEGRA, LA TARDANZA EN ACUDIR CUANDO SE LE LLAMA, QUEDAN EN IR EN 5 MIN Y PASAN HORAS, FUE MULTIPUNCIONADA Y AL PASO DEL MEDICAMENTO SE LO PASABAN MUY RAPIDO GENERANDO DOLOR Y MOLESTIAS, ASI COMO LE DABAN TODOS LOS MEDICAMENTOS A LA VEZ GENERANDO MALESTAR EN LA PACIENTE. AUN TIENEN LOS DESECHABLES DE LA CENA Y EL DESAYUNO SIENDO LAS 14:00 HRS NO HAN PASADO A LIMPIAR LA HABITACION, EL VOLUMEN DELA TELEVISION NO PUEDE REGULARSE Y ES HORA QUE MANTIMIENTO NO ACUDE. NO FUNCIONO ADECUADAMENTE DE LUNES A MIERCOLES.
NO ES UN HOSPITAL ECONOMICO, LAS INSTALACIONES SON HORRIBLES, NO REGRESARIA.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Ordinaria", "gravedad": "Sin daño", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Físico", "fecha_validacion": "2026-07-22", "hora_validacion": "16:00", "revision_expediente": "SI", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "recibe_llamada": "Hijo de la paciente", "investigacion": "El hijo refiere ser multipuncionada, y no pasar los medicamentos", "investiga": "Giselle De la Torre", "medio_notificacion": "Oficio", "fecha_notificacion": "2026-07-27", "persona_notifica": "Giselle De la Torre", "numero_oficio": "HSMCA/77/2026", "resolucion": "Revisión de registros clínicos de enfermería, recanalización de la paciente por infiltración, cobertura completa por parte del personal de enfermería, , se reforzará la supervisión del cumplimiento de las prácticas seguras relacionadas con la terapia de infusión, no se identicaron omisiones en la preparación y administración de los medicamentos prescritos ni evidencia de que los procedimientos fueran realizados por personal no autorizado.", "fecha_resolucion": "2026-08-03"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2651');
INSERT INTO public.quejas
  (folio, fecha, tipo, nombre_paciente, habitacion, telefono, email, departamento,
   personal_involucrado, descripcion, origen, status, seguimiento)
SELECT 'CA2652', '2026-08-01', 'queja', 'Juan Lira Marquez', 'JP04',
       '3316020089', '-', 'Enfermería', 'Personal de enfermería',
       'Familiar del paciente refiere mal trato de enfermería , ademas de incapacidad para realizar , las curaciones y procedimientos de manera adecuada , menciona que en ocasiones incluso han derramado el contenido del riñon en la habitación , o salpicando todo el baño , manifiestan de la misma manera que personal de laboratorio tomo una muestra en el tubo equivocado , y que tuvieron que repetir la toma del dia 30 de Julio ( usaron equivocadamente rojo cuando era tubo verde) , menciona que el familiar ( su padre ) ahora tiene una ulcera por presión de aprox. 2cm debido a la falta de movilidad , ademas de que en lagunas veces el personal de enfermería no colocaba correctamente el baumanometro , tiendo que repetir la medición por lecturas erroneas , y dificultad del manejo de las aminas en el paciente.', 'historico', 'cerrado', '{"procede": "SI", "categoria": "Queja", "priorizacion": "Urgente", "gravedad": "Bajo", "clasificacion": "Atención al usuario", "subclasificacion": "Proceso", "origen_seg": "Físico", "fecha_validacion": "2026-07-31", "hora_validacion": "17:00", "revision_expediente": "SI", "llamada_entrevista": "Entrevista", "intentos_llamada": "No aplica", "respuesta_llamada": "No aplica", "investiga": "Omar Orozco"}'::jsonb
WHERE NOT EXISTS (SELECT 1 FROM public.quejas WHERE folio='CA2652');

SELECT status, count(*) FROM public.quejas WHERE origen='historico' GROUP BY status ORDER BY status;
