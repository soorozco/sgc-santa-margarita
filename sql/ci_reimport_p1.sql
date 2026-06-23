-- ============================================================
--  Reimportar incidentes clínicos — 118 registros
--  Hospital Santa Margarita · SGC ISO 9001:2015
-- ============================================================

-- ── Limpiar importaciones anteriores del CSV ──
DELETE FROM clinical_incidents
WHERE reported_at IN (
  '2025-07-21 18:49:32+00',
  '2025-07-24 17:18:16+00',
  '2025-07-30 09:07:38+00',
  '2025-07-31 09:10:58+00',
  '2025-08-11 12:25:25+00',
  '2025-08-12 07:55:44+00',
  '2025-08-13 11:36:36+00',
  '2025-08-14 08:27:17+00',
  '2025-08-14 16:16:58+00',
  '2025-08-15 09:41:30+00',
  '2025-08-26 07:24:13+00',
  '2025-09-02 13:14:20+00',
  '2025-09-03 14:14:17+00',
  '2025-09-06 16:04:34+00',
  '2025-09-09 20:30:57+00',
  '2025-09-11 12:24:42+00',
  '2025-09-12 12:46:40+00',
  '2025-09-12 12:51:36+00',
  '2025-09-12 12:54:27+00',
  '2025-09-12 13:04:51+00',
  '2025-09-23 09:53:48+00',
  '2025-09-30 09:11:09+00',
  '2025-10-03 06:56:26+00',
  '2025-10-06 08:39:15+00',
  '2025-10-06 09:59:35+00',
  '2025-10-08 22:55:03+00',
  '2025-10-09 06:09:55+00',
  '2025-10-11 19:06:32+00',
  '2025-10-19 18:29:06+00',
  '2025-10-19 20:07:50+00',
  '2025-11-03 15:51:31+00',
  '2025-11-06 14:20:11+00',
  '2025-11-06 14:48:47+00',
  '2025-11-08 21:02:29+00',
  '2025-11-08 22:36:26+00',
  '2025-11-11 12:48:20+00',
  '2025-11-14 08:42:40+00',
  '2025-11-15 13:36:21+00',
  '2025-12-02 19:59:11+00',
  '2025-12-03 13:43:52+00',
  '2025-12-05 09:00:28+00',
  '2025-12-05 12:50:21+00',
  '2025-12-08 17:04:35+00',
  '2025-12-16 11:43:59+00',
  '2025-12-16 23:44:05+00',
  '2025-12-18 15:20:12+00',
  '2025-12-30 15:14:15+00',
  '2025-12-30 15:18:33+00',
  '2026-01-03 10:17:45+00',
  '2026-01-05 00:43:17+00',
  '2026-01-13 18:35:47+00',
  '2026-01-22 21:56:11+00',
  '2026-01-23 08:26:40+00',
  '2026-01-30 12:20:52+00',
  '2026-01-30 15:42:01+00',
  '2026-02-13 06:42:24+00',
  '2026-02-18 14:00:28+00',
  '2026-02-19 13:03:00+00',
  '2026-02-19 13:16:54+00',
  '2026-02-20 09:08:08+00',
  '2026-02-20 19:09:40+00',
  '2026-03-04 11:13:51+00',
  '2026-03-06 07:38:52+00',
  '2026-03-06 13:30:12+00',
  '2026-03-07 12:30:14+00',
  '2026-03-07 12:35:38+00',
  '2026-03-07 12:40:37+00',
  '2026-03-08 07:44:40+00',
  '2026-03-11 13:57:46+00',
  '2026-03-13 15:39:23+00',
  '2026-03-14 20:10:41+00',
  '2026-03-15 06:14:01+00',
  '2026-03-16 15:53:37+00',
  '2026-03-18 15:22:23+00',
  '2026-03-21 10:36:16+00',
  '2026-03-21 11:25:13+00',
  '2026-03-21 11:31:32+00',
  '2026-03-21 12:03:21+00',
  '2026-03-21 13:11:13+00',
  '2026-03-21 13:14:53+00',
  '2026-03-21 13:17:44+00',
  '2026-03-21 13:56:02+00',
  '2026-03-25 10:21:01+00',
  '2026-03-25 13:18:45+00',
  '2026-03-25 13:28:15+00',
  '2026-03-27 07:56:16+00',
  '2026-04-01 08:07:21+00',
  '2026-04-01 14:58:28+00',
  '2026-04-03 10:01:58+00',
  '2026-04-06 13:46:16+00',
  '2026-04-06 13:59:33+00',
  '2026-04-07 12:08:54+00',
  '2026-04-07 15:01:28+00',
  '2026-04-08 13:54:41+00',
  '2026-04-08 20:29:00+00',
  '2026-04-09 16:42:05+00',
  '2026-04-20 12:31:00+00',
  '2026-04-20 12:39:38+00',
  '2026-04-21 14:32:11+00',
  '2026-04-21 14:47:47+00',
  '2026-04-22 07:15:51+00',
  '2026-04-22 16:07:43+00',
  '2026-04-22 16:11:11+00',
  '2026-04-22 16:16:57+00',
  '2026-04-22 16:21:48+00',
  '2026-04-22 16:32:40+00',
  '2026-04-22 17:13:42+00',
  '2026-04-29 07:49:43+00',
  '2026-04-29 07:55:06+00',
  '2026-04-29 15:59:07+00',
  '2026-04-29 16:03:37+00',
  '2026-05-06 12:43:34+00',
  '2026-05-08 11:17:28+00',
  '2026-05-09 11:00:23+00',
  '2026-05-09 11:48:16+00',
  '2026-05-14 14:21:14+00',
  '2026-05-15 13:46:16+00',
  '2026-05-19 16:57:20+00'
);

-- ── Insertar registros corregidos ──
-- [1] Ma. Dolores Galindo | 19/7/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-07-21 18:49:32+00', 'Ma. Dolores Galindo', '2025-07-19', 'Femenino',
  '2025-07-19', '12:00', 'Hospitalización',
  'Cuasi Falla', 'Nutrición', 'Sin Daño',
  'Se suministra inicialmente al paciente lácteos, pero el personal de nutrición se percata del error y cambian la dieta por un sándwich.', 'Falta de apego a las indicaciones medicas', 'Comunicación deficiente en el equipo, Formación o supervisión inadecuadas',
  'El paciente o familiar alertó del error', 'Se notifica al área de nutrición para que revise el caso , especifico del paciente y las causas que provocaron la cuasifalla.', NULL
);

-- [2] Noemi Rodríguez | 22/7/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-07-24 17:18:16+00', 'Noemi Rodríguez', '2025-07-23', 'Femenino',
  '2025-07-22', '22:30', 'Urgencias',
  'Cuasi Falla', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Sin Daño',
  'La hoja de consumo de urgencias que llena el personal de enfermería no detalla , la presentación de los medicamentos, lo cual es un obstáculo para la trazabilidad y verificación de la idoneidad de la terapéutica.', 'Datos incompletos en los registros clínicos', 'Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'Se notifica al área de calidad , de la incidencia.', NULL
);

-- [3] MARIA TOSCANO HERNANDEZ | 29/7/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-07-30 09:07:38+00', 'MARIA TOSCANO HERNANDEZ', '3939-12-08', 'Femenino',
  '2025-07-29', '22:00', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Leve',
  'El día de ayer a las 21:30 se reciben indicaciones nuevas para la paciente, indicándole rifampicina. Enfermeria no entiende la escritura y preguntan a médicos de guardia si es rifampicina o rifaximina, los cuales a las 23:39hrs se comunican con medico tratante via whatsapp y llamada para preguntarle pero no se obtiene respuesta. Medicos de guardia dan indicacion de rifaximina y a las 22:00hrs se le administra una tableta. Hoy a las 8:37hrs se comunica enfermeria para avisar que medico tratante esta en central y refiere que es rifampicina, asi mismo se comunica con nosotros via whatsapp para informarnos.', 'No se entendió la escritura del medico tratante', 'Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal', 'Medico tratante solicita que se comience a administrar rifampicina y se descarte rifaximina', 'https://drive.google.com/open?id=1xkMGnXQ6XVnpOWPw7sypvcR8Lj-qEQq8, https://drive.google.com/open?id=1Ank420zk_T8GNJ0CULg8Qh2pEzzg5Z3n, https://drive.google.com/open?id=1RFFx1UOfNm4GBIz2fUg6pJtO1ekZmxh1, https://drive.google.com/open?id=1KByfgT-YAm_-VNXZz5bO_QT4RVmUHLO0'
);

-- [4] MORALES MERCADO HERMINIO | 30/7/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-07-31 09:10:58+00', 'MORALES MERCADO HERMINIO', '3945-08-11', 'Masculino',
  '2025-07-30', '13:43', 'Hospitalización',
  'Evento Adverso', 'Dispositivos / Equipos Médicos', 'Leve',
  'DURANTE LA CURACION DEL PACIENTE HERMINIO CLINICA DE CATETERES REPORTA QUE EL CVC DEL PACIENTE ESTA FUERA, ESE DIA NO SE MOVILIZO EL PACIENTE Y LA ENFERMERA ENCARGADA DEL PACIENTE REFIERE QUE DESDE LA MAÑANA NOTO QUE SE ESTABA DIRANDO LA SOLUCION BASE PERO NO LO REPORTO. AL MOMENTO DE LA CURACION TODA LA CAMA ESTABA EMPAPADA Y CONTINUABAN PASANDOSE POR LA VIA LAS SOLUCIONES, MEDICAMENTOS Y NUTRICION PARENTERAL. EL MEDICO TRATANTE PIDIO RX DE TORAX Y SE SUSPENDIERON TODOS LOS MEDICAMENTOS HASTA LA RECOLOCACCION DEL CVC.', 'DESDE UN DIA ANTERIOR POR LA MOVILIZACION A REPOSET DEL PACIENTE PUDE SALIRSE EL CVC POR QUE TENIA UNA SUTURA ROTA.', 'Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'RECOLOCACCION DEL CVC', 'https://drive.google.com/open?id=1jmTif3rDsc-6DlVS5U_5f0AnvW9H3fcb'
);

-- [5] FLORES LARA ALFREDO | 11/8/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-08-11 12:25:25+00', 'FLORES LARA ALFREDO', '3942-08-18', 'Masculino',
  '2025-08-11', '04:00', 'Hospitalización',
  'Cuasi Falla', 'Documentación / Comunicación', 'Leve',
  '-QUIEN REALIZA REPORTE: DRA ELISA-

-INGRESA PACIENTE EL DIA DE AYER POR URGENCIAS DIRECTAMENTE A HEMODIALISIS, AL SALIR DE HEMODIALISIS SE RECIBE PACIENTE EN PISO, AL ENTREGAR PACIENTE E INDICACIONES SE RECIBE POR PARTE DE ENFERMERIA CON INDICACIONES DE URGENCIAS, MEDICO DE GUARDIA TRANSCRIBE INDICACIONES DE URGENCIAS (LAS CUALES NO ERA LAS INDICADAS YA QUE MEDICO YA HABIA DEJADO INDIACIONES NUEVAS). 
-EL DIA DE HOY AL RECIBIR AL PACIENTE, ME PONGO EN CONTACTO CON EL MEDICO TRATANTE PARA DARLE EVOLUCION DE SU PACIENTE Y PREGUNTA ACERCA DE UNA INDIACION, ME PERCATO QUE NO ESTA TRANSCRITA POR LO QUE ACUDE A REVISAR EL EXPEDIENTE Y ME DOY CUENTA QUE  NO ESTABAN TRANSCRITAS CORRECTAMENTE, ME ACERCO A ENFERMERIA Y LE COMENTO QUE QUE INDICACIONES LE ENTREGARON Y ME MENCIONA QUE LAS QUE ESTABAN MAL', 'ENFERMERIA:
-FALTA DE ATENCION A LA HORA DE ENTREGA DE "INDICACIONES ACTUALIZADAS" POR PARTE DE MEDICO TRATANTE
-A LA HORA DE ENTREGAR PACIENTE REVISAR QUE SEAN ADECUADAD LAS INDICACION

MEDICO DE GUARDIA:
-AL LLEGAR EL PACIENTE A HABITACION REVISAR TODO EL EXPEDIENTE PARA CORROBORAR LA TRASCRIPCION DE INDICACIONES MEDICAS, EN CASO DE DUDA COMUNICARSE CON MEDICO TRATANTE PARA EVITAR ERRORES EN TRANSCIPCION.', 'Protocolos inadecuados o inexistentes',
  'Intervención oportuna de otro personal', '-SOLUCION:
ME COMUNICO CON MEDICO TRATANTE Y CORROBORO DIRECTAMENTE INDICACIONES, POR LO QUE SE CORRIGEN. AGREGANDO SOLUCION BASE Y GLUCONATO DE CALCIO
SIN EVENTUALIDADES PARA EL PACIENTE.', NULL
);

-- [6] MARIA DE JESUS JIMENEZ MACIAS | 12/8/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-08-12 07:55:44+00', 'MARIA DE JESUS JIMENEZ MACIAS', '3935-02-21', 'Femenino',
  '2025-08-12', '21:00', 'Hospitalización',
  'Evento Adverso', 'Proceso de Diagnóstico (Ej: retraso diagnóstico)', 'Sin Daño',
  '--QUIEN REALIZA EL REPORTE: DRA ELISA VILLA--

SE SOLICITA TAC DE CRANEO POR PARTE DEL DR JULIO BRIZUELA ( INTERCONSULTANTE DE LA PACIENTE YA QUE EL MEDICO TRATANTE ES EL DR LEOPOLDO LAMAS) YA QUE LA PACIENTE PRESENTA UN CUADRO DE HIPOTENSION Y ALTERACION DEL ESTADO NEUROLOGICO, SE ENVIA APROXIMADAMENTE A LAS 21 HRS,LA TAC ESTA REPORTADA EN EL SISTEMA A LAS 21:30 HRS; SIN EMBARGO SON LAS 7:40 DE LA MAÑANA DEL 12.08.25 Y AUN NO HAY REPORTE DE LA TAC, SIENDO UNA SOLICITUD DE "URGENCIA" POR EL ESTADO NEUROLOGICO DE LA PACIENTE.', 'YA HAN HABIDO VARIAS OCASIONES EN LAS QUE LOS EXAMENES DE GABINETE TARDAN >8HRS EN REPORTARSE.', 'Equipo no disponible o defectuoso',
  'Intervención oportuna de otro personal', 'COMUNICARME CON DIRECCION MEDICA PARA QUE SOLICITE DIRECTAMENTE AL JEFE DE DEPARTAMENTO LA INTERPRETACION DEL ESTUDIO.', 'https://drive.google.com/open?id=1tKiaSXAoQrYtzjkQVd_qdYkYRLvhq-fi, https://drive.google.com/open?id=1S-Nb2UR_fQx2WIAUJ0Hd_3F-FLMdmDKy, https://drive.google.com/open?id=1kBlMmYiryhIPGpFzu7Klizxt5EeiCDjd'
);

-- [7] Ochoa González José Cristóbal | 13/8/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-08-13 11:36:36+00', 'Ochoa González José Cristóbal', '3938-01-12', 'Masculino',
  '2025-08-13', '10:25', 'Hospitalización',
  'Evento Adverso', 'Proceso de Diagnóstico (Ej: retraso diagnóstico)', 'Leve',
  'Se pinza la nefrostomia del paciente para una toma de EGO, al despinzar el gasto es hematurico. Se envía muestra a laboratorio que pide que se repita por qué solo es sangre. No se reporta a médicos tratantes hasta que la familiar se comunica directamente.', 'Omisión de reporte de eventualidad, mal toma de muestra', 'Barreras de comunicación (idioma, cognición)',
  'El paciente o familiar alertó del error', 'Acude médico tratante a valoración del paciente', 'https://drive.google.com/open?id=1rjpD63gjQPYKRlVRsQsd8NLT2oG3wush, https://drive.google.com/open?id=1eqKAYoWk4U0jkIJnjN7DD309PFT5_N0j'
);

-- [8] Ocho González José Cristobal | 13/8/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-08-14 08:27:17+00', 'Ocho González José Cristobal', '3948-01-12', 'Masculino',
  '2025-08-13', '12:00', 'Hospitalización',
  'Cuasi Falla', 'Procedimiento Clínico / Invasivo (Ej: cirugía en sitio equivocado)', 'Sin Daño',
  'Por la mañana el médico indica toma de EGO a un paciente portador de 2 nefrostomias y una sonda foley, su enfermera recibe la indicación. Pinza la nefrostomia derecha para toma de la muestra pero después al tomar la muestra es hematica, laboratorio la regresa por que no es posible procesarla. La enfermera a cargo le pregunta a su supervisora de piso, a su jefa de enseñanza y nadie le da respuesta o le presta atención. No se avisa a médico tratante ni a médicos de guardia, es interconsultate quien se comunica con médicos de guardia debido a que la familiar le avisó. Sin indicación, sin preguntar, la enfermera despinza nefrostomia derecha y vuelve a punzar nefrostomia izquierda para toma de muestra y se va a desayunar. En comedor le avisa a la supervisora de otro piso lo que está pasando y ella avisa a médicos de guardia, quien se entera en ese momento que pinzó las nefrostomias para la toma de muestra. Se comunica a médico tratante quien comenta que eso no se debe hacer. Se le indica a la enfermera cancelar toma de EGO pero médico interconsultate comenta que la muestra debía ser tomada de la sonda urinaria. Después de unas hora de despinzar, la orina vuelve a ser clara.', 'Falta de conocimiento de los procedimientos y de comunicación al no preguntar a tratantes o médicos encargados sobre cómo y de dónde querían que se tomara la muestra.', 'Barreras de comunicación (idioma, cognición), Protocolos inadecuados o inexistentes, Formación o supervisión inadecuadas',
  'El paciente o familiar alertó del error', 'Médico tratante dio indicación para evitar mal manipulación de las nefrostomias', 'https://drive.google.com/open?id=1jaE2act0Tu1KCxQvpjyAli5cPITBnuA7, https://drive.google.com/open?id=1Foqsxdib_in4ta06oJJQif0LAcceUq3N, https://drive.google.com/open?id=1KE9qNgzNIxVeq23uO9MikHOAyjTb6iS5'
);

-- [9] Maria Martha Ofelia Barragan | 7/8/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-08-14 16:16:58+00', 'Maria Martha Ofelia Barragan', '2025-08-07', 'Femenino',
  '2025-08-07', '15:50', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Leve',
  'Departamento de JP II Habitación 15 paciente Maria Martha Ofelia Barragan, se realizo el cambio de indicaciones suspender infusión de Amiodarona al termino y posteriormente dar inicio Amiodarona 200 mg VO c/24 la cual no se administro al paciente, la cual se corrobora con medico de guardia si habia presentado algún inconveniente por la omisión la cual responden desconocer el motivo de su administración.', 'No', 'Comunicación deficiente en el equipo',
  'Doble chequeo por parte del personal', 'Ninguna', NULL
);

-- [10] BECERRA BARRAGAN, KAREN  NAYELI | 15/8/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-08-15 09:41:30+00', 'BECERRA BARRAGAN, KAREN  NAYELI', '3994-11-03', 'Femenino',
  '2025-08-15', '09:00', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Moderado',
  'EL DÍA DE HOY LA PACIENTE INGRESA A CARGO DEL DR. GERARDO HERRERA Y COMO INTERCONSULTANTE EL DR. ENRIQUE UREÑA, EL CUAL EN PREVIA VALORACIÓN MÉDICA LE DA SU HOJA DE INDICACIONES CON LA QUE SERÁ INGRESADA EL DÍA DE HOY. A SU ARRIBO LA HOJA DE INDICACIONES SE PIERDE POR LO QUE SE LLAMA AL DR. GERARDO HERRERA QUIEN DEJA NUEVAS INDICACIONES (OMEPRAZOL, CEFALOTINA Y BUTILHIOSCINA). SE INICIA CON OMEPRAZOL, POSTERIORMENTE LA CEFALOTINA LA CUAL GENERA REACCIÓN ALÉRGICA CON RASH, ERITEMA GENERALIZADO, DOLOR ABDOMINAL Y CEFALEA, LA PACIENTE LE NOTIFICA A LA ENFERMERA A CARGO (MARÍA MAGDALENA SILVA) LA CUAL JAMÁS NOTIFICA A MÉDICOS DE GUARDIA, Y ADMINISTRA BUTILHIOSCINA, CON APARENTE MEJORÍA DE LOS SÍNTOMAS PERO AUN SIN DESAPARECER DEL TODO. ACUDO A REALIZAR INGRESO Y LA PACIENTE ME COMENTA LO SUCEDIDO. MIENTRAS PERMANECÍA EN HABITACIÓN EXPLORANDO A LA PACIENTE, LLEGA EL DR.ENRIQUE UREÑA QUIEN SE PERCATA DEL EVENTO SUCEDIDO Y ACUDE A CORROBORAR QUE FUE LO QUE PASO.', 'NO REPORTA A MEDICO DE GUARDIA EVENTUALIDADES Y TAMPOCO SE COMUNICA CON MEDICO TRATANTE PARA RESOLVER LA EVENTUALIDAD, POR LO QUE PONE EN RIESGO EL ESTADO DEL PACIENTE.', 'Comunicación deficiente en el equipo, Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal, El paciente o familiar alertó del error', 'SE COMUNICA CON MEDICO INTERCONSULTATE QUIEN DA INDICACIONES', NULL
);

-- [11] AVILA ESCOBEDO, ALFONSO | 25/8/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-08-26 07:24:13+00', 'AVILA ESCOBEDO, ALFONSO', '3947-08-10', 'Femenino',
  '2025-08-25', '22:00', 'Hospitalización',
  'Evento Adverso', 'Proceso de Diagnóstico (Ej: retraso diagnóstico)', 'Moderado',
  'SE SOLICITA RM DE CRANEO POR MEDICO TRATANTE POR SOSPECHA DE EVENTO CEREBROVASCULAR A LAS 20:30HRS, SE TOMA LA IMAGEN A LAS 21 HRS Y LO SUBEN A SISTEMA A LAS 21:29; DESDE ENTONCES NO HAY REPORTE POR PARTE DE MEDICO RADIOLOGO HASTA EL MOMENTO DEL REPORTE 7:22AM 26.08.25', '.', 'Comunicación deficiente en el equipo',
  'Doble chequeo por parte del personal', 'HASTA EL DIA DE HOY A LA ENTREGA DE MEDICOS SE OBSERVA QUE NO HAY REPORTE', 'https://drive.google.com/open?id=1m28vDOI5BgQbAA7PY0K5_fasUT4g2qL1, https://drive.google.com/open?id=1HMi9rVAFy5mg7TcWekIdTXUSB85_tbSa'
);

-- [12] Salvador Huerta García | 1/9/0025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-09-02 13:14:20+00', 'Salvador Huerta García', '2054-05-23', 'Masculino',
  '2025-09-01', '18:00', 'Hospitalización',
  'Cuasi Falla', 'Nutrición', 'Sin Daño',
  'El equipo de dietas del hospital llegó a central de enfermería del área de Juan Pablo II para entrega de la cena unos minutos antes de las 18:00 hrs, y le pidió a la enfermera Angélica que les recibiera las dietas, en dicha recepción la enfermera asegura que el paciente de JP6, Salvador, fue dado de alta ya, por lo que ya no era necesario entregarle su cena, se firmo la hoja de dietas y se entregaron las dietas correspondientes. Posterior a ello, a las 19:30 hrs enfermeria se comunica al área de dietas para comentar que al paciente se le habia dejado sin cenar, por lo que se le explica a su enfermera que fue porque habia salido de alta segun la enfermera que recibió las cenas. Se resolvio y se le llevo en ese instante al paciente su dieta correspondiente.', 'Falta de cumplimiento en el proceso de recepción de dietas con los datos actualizados y confirmados de cada uno de los pacientes', 'Comunicación deficiente en el equipo, Equipo no disponible o defectuoso, Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'El area de dietas hará incapie a enfermeria en que se confirmen los datos e indicaciones exactas de cada paciente con base en la información con la que cuenta la tabla de indicaciones y expediente', NULL
);

-- [13] GARCÍA HERNÁNDEZ GLORIA ANGELICA | 2/9/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-09-03 14:14:17+00', 'GARCÍA HERNÁNDEZ GLORIA ANGELICA', '3971-06-17', 'Femenino',
  '2025-09-02', '23:00', 'Hospitalización',
  'Cuasi Falla', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Leve',
  'Paciente que ingresa a piso a las 22:33 con el diagnóstico de Pie Diabético, la indicación pide realizar RX de pie. Se toman laborotorios y se pasan medicamentos. A las 7am acude médico interconsultante y pide ver la Radiografía de la paciente ya que desea valorar probable osteomielitis para realizar cambios al tratamiento y poder valorar probable intervención quirúrgica. La radiografía no se tomó desde su ingreso en todo el turno nocturno. La doctora se tuvo que retirar sin poder realizar en ese momento cambios debido a la omisión de la toma de la radiografía por el enfermero en turno Irving y el supervisor de turno Jafet Meza.', 'Omisión de indicación', 'Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'Se toma Radiografía lo más pronto posible y se envía a número personal de tratante para valoración', 'https://drive.google.com/open?id=1jc_b86OF9YsRmxSfz0s6gTNlJn0yRplD, https://drive.google.com/open?id=1KrMyTqmw7lNuP0_UxvkgQ9sITK1o_57h'
);

-- [14] JIMENEZ GOMEZ, REBECA | 6/9/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-09-06 16:04:34+00', 'JIMENEZ GOMEZ, REBECA', '3958-11-20', 'Femenino',
  '2025-09-06', '16:00', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Sin Daño',
  'SE INDICA SOLUCION HARTMANN 1000CC P/24HRS, Y SE ADMINISTRA APROX EN 3 HRS', '.', 'Comunicación deficiente en el equipo, Protocolos inadecuados o inexistentes, Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'TOMA DE SIGNOS VITALES,', NULL
);

-- [15] SOLIS CASTILLO, SERGIO | 9/9/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-09-09 20:30:57+00', 'SOLIS CASTILLO, SERGIO', '3966-09-11', 'Masculino',
  '2025-09-09', '11:00', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Leve',
  'En el turno vespertino se reportan signos vitales a Dra Niza Villaseñor, TA 169/61, FC 90, SAT 95, TEMP 37.2 GLUCEMIA 140. Cuestiona si se le administro el amlodipino PRN a lo que se responde que a las 11am (captura 1), ella menciona que estaba presente cuando le dieron la dosis extra de losartan que esta indicada (captura de indicaciones) pero no el amlodipino, losartan extra no marcado como administrado en hoja de enfermería pero si el amlodipino (foto de hoja de enfermería). 
Dra Niza esta segura que se administro losartan dosis extra pero no estamos seguros que se administrara amlodipino.', 'Falta de atencion de parte de enfermeria, se pudo solucionar pero no es correcto marcar o no marcar como administrados los medicamentos. Porque en casos como este que necesitamos usar los PRN, no tenemos la certeza de que se le administrara en la mañana.', 'Fatiga / Sobrecarga de trabajo del personal, Comunicación deficiente en el equipo, Personal insuficiente, Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'INFORMAR A MEDICA TRATANTE Y SUPERVISION DE ENFERMERIA', 'https://drive.google.com/open?id=1ESGMsGGGBg0LgSkVx3SKIk4sx2-qGaFw, https://drive.google.com/open?id=1drvqaIIuRnyqbo8dmAih9Fvc203LR93P, https://drive.google.com/open?id=1zqQNCdNpjMQ5ZPCSMO8vlUgpK7q7Ot8W, https://drive.google.com/open?id=1UWplt6oHiciJxX8UvTp_2rKKhLfBJjfb, https://drive.google.com/open?id=1B2O65S1TIyITLBc_s0ZLrIGP_nfHwvzs'
);

-- [16] Maria Guarro Gonzalez | 11/9/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-09-11 12:24:42+00', 'Maria Guarro Gonzalez', '3931-06-06', 'Femenino',
  '2025-09-11', '01:40', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Sin Daño',
  'Error en la lectura de el medicamento escrito, lo que ocasiona administración de medicamento incorrecta, fluconazon en lugar de cilistazol', 'Mala práctica al llevar a cabo los 10 correctos de enfermería', 'Barreras de comunicación (idioma, cognición), Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'Se notificación a médico tratante la situación y se continúa con medicación correcta', NULL
);

-- [17] Elena Torres Mosqueda | 3/9/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-09-12 12:46:40+00', 'Elena Torres Mosqueda', '2001-01-01', 'Femenino',
  '2025-09-03', '00:00', 'Hospitalización',
  'Evento Adverso', 'Procedimiento Clínico / Invasivo (Ej: cirugía en sitio equivocado)', 'Leve',
  'lesion en dos dedos de la mano izquierda comenta la paciente que al salir del quirofano la golpearon en la puerta del quirofano', 'desconoce', 'Protocolos inadecuados o inexistentes',
  'El paciente o familiar alertó del error', 'ninguna', NULL
);

-- [18] Rosalba Andrade Garcia | 29/8/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-09-12 12:51:36+00', 'Rosalba Andrade Garcia', '3956-08-23', 'Femenino',
  '2025-08-29', '11:00', 'Hospitalización',
  'Evento Adverso', 'Procedimiento Clínico / Invasivo (Ej: cirugía en sitio equivocado)', 'Leve',
  'paciente recibe alimentacion por sonda nasograstrica alimento complementario viernes por la noche solo retiran bolsa mas no realizan limpieza y se obstruye la sonda', 'falta de capacitacion, decsuido del personal', 'Protocolos inadecuados o inexistentes',
  'El paciente o familiar alertó del error', 'limpieza y destaponamiento sin lograr el objetivo', NULL
);

-- [19] xxxxxxx | 23/8/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-09-12 12:54:27+00', 'xxxxxxx', '2001-01-01', 'Masculino',
  '2025-08-23', '09:20', 'Hospitalización',
  'Evento Adverso', 'Caídas', 'Leve',
  'entro a la cafeterioa y se me viene la puerta encima cayendo en la espalda y en el brazo izquierdo', 'falta de mamntenimiento', 'Equipo no disponible o defectuoso',
  'Intervención oportuna de otro personal', '2 personas lo levantaron', NULL
);

-- [20] jose cristobal ochoa gonzalez | 19/8/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-09-12 13:04:51+00', 'jose cristobal ochoa gonzalez', '2001-01-01', 'Masculino',
  '2025-08-19', '14:11', 'Hospitalización',
  'Evento Adverso', 'Nutrición', 'Leve',
  'error en dieta lo que le ocasiono vomito y diarrea, retraso en el vaciado de bolsa de orina', 'error en dieta', 'Comunicación deficiente en el equipo',
  'El paciente o familiar alertó del error', 'cambio de dieta', NULL
);

-- [21] Garcia Garcia Maria Angelica | 17/9/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-09-23 09:53:48+00', 'Garcia Garcia Maria Angelica', '3962-12-20', 'Femenino',
  '2025-09-17', '10:00', 'Hospitalización',
  'Evento Adverso', 'Procedimiento Clínico / Invasivo (Ej: cirugía en sitio equivocado)', 'Sin Daño',
  'Se aborda cateter portacat de manera incorrecta, no se realiza asepsia, medidas esteriles y se punziona de manera incorrecta', 'Desconocimiento al realizar procedimiento', 'Barreras de comunicación (idioma, cognición), Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal', 'Retroalimentacion 
Si no se tiene el conocimiento al realizar procedimiento, se tiene que comunicar a supervision de turno', NULL
);

-- [22] Margarita Sánchez Mendoza | 30/9/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-09-30 09:11:09+00', 'Margarita Sánchez Mendoza', '3964-06-10', 'Femenino',
  '2025-09-30', '08:00', 'Hospitalización',
  'Evento Adverso', 'Nutrición', 'Sin Daño',
  'Enfermería del turno nocturno se equivocaron de dieta con la paciente del 114 sigue siendo líquida y pusieron que ya pasaba a blanda cuando en el expediente no viene la indicación de cambiar la dieta.', 'No revisan los expedientes ni indicaciones médicas/nutricionales. Tampoco la supervisora del turno revisa ese tipo de indicaciones.', 'Barreras de comunicación (idioma, cognición), Comunicación deficiente en el equipo, Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal, Uso de una lista de verificación (checklist), Doble chequeo por parte del personal', 'Cambio de la dieta', 'https://drive.google.com/open?id=1s_flINx9pDd5XCb20MuKPOVnKpb83QwF'
);

-- [23] Miguel Alvarado Hernández | 2/10/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-10-03 06:56:26+00', 'Miguel Alvarado Hernández', '2064-03-02', 'Masculino',
  '2025-10-02', '13:00', 'Hospitalización',
  'Cuasi Falla', 'Manejo de Vía Aérea / Ventilación', 'Leve',
  'El paciente Miguel paso a piso procedente de terapia intensiva con uso de puntas nasales de alto flujo, se destetan el día 1/10/25 en turno matutino y se mantienen a 8 litros por minuto, sin datos de insuficiencia respiratoria y con buena saturación. El monitor del paciente tiene falla y no marca correctamente la saturación, hasta la noche se progresa a 15 litros la mascarilla. Por la mañana del 02/10/25, se recibe paciente con mascarilla a 15 litros, sin datos de dificultad respiratoria, buen llenado capilar y buena saturación, incluso se baja a 13 litros la mascarilla. Antes de entrega de turno, personal de inhalo terapia, sin indicación médica ni notificación a tratante o médico de guardia, coloca puntas de alto flujo “mientras el paciente come, por qué está insuficiente” (asi entregó a turno vespertino y eso le dijo a familiares el personal de inhaloterapia de turno matutino) y lo entrega a turno vespertino. A las 14:30 acude médico tratante y encuentra a su paciente con puntas de alto flujo por lo que reindica progresar a mascarilla y luego a puntas nasales. Por la tarde se coloca mascarilla reservorio y durante turno vespertino se corrabora que el paciente tolera mascarilla, sin algún dato de insuficiencia.

*se adjunta foto de que el paciente tenía colocado mascarilla en turno matutino con buena saturación y de la indicación de tratante a las 14:30', 'Omisión de indicaciones y notificación a médico tratante.', 'Protocolos inadecuados o inexistentes, Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'Valoración médica y cambio nuevamente para progresar oxígeno.', 'https://drive.google.com/open?id=1jFB28C039AeUCeYFYSpVKxsnHogX6qHk, https://drive.google.com/open?id=1hbBskm853m4QnEGh6fIRfrmUTRJdHO_y'
);

-- [24] BUSHNELL, DARRELL LEE | 6/10/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-10-06 08:39:15+00', 'BUSHNELL, DARRELL LEE', '3949-08-13', 'Masculino',
  '2025-10-06', '04:15', 'Hospitalización',
  'Evento Adverso', 'Caídas', 'Moderado',
  'El paciente se levantó al baño, se resbaló al pararse del inodoro, se llamó a camillería, se mencionó la situación de urgencia, llegó ya resuelto el incidente', 'Piso mojado, el paciente estaba descalzo', 'Barreras de comunicación (idioma, cognición), Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal', 'Se apoyó al personal de enfermería por parte de medicos de guardia', NULL
);

-- [25] Bushnell Darrell Lee | 6/10/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-10-06 09:59:35+00', 'Bushnell Darrell Lee', '2025-10-06', 'Masculino',
  '2025-10-06', '04:00', 'Hospitalización',
  'Evento Adverso', 'Caídas', 'Sin Daño',
  'El paciente se levanta de la cama al baño aún cuando se le indicó no levantarse, por referir debilidad en piernas, llega al baño y al levantarse de la taza pierde fuerza en las piernas y cae.', 'Falta de comunicación. El paciente no cuenta con familiar durante el turno, siendo una causa importante, ya que es una persona adulta mayor, y que necesita apoyo de familiar', 'Condición clínica compleja del paciente, Barreras de comunicación (idioma, cognición)',
  'Intervención oportuna de otro personal, Doble chequeo por parte del personal', 'Se le llama a camilleria y no obtenemos respuesta por lo que se le habla al médico de guardia quien ayudó a levantarlo y pasarlo a cama, se revisa al paciente por parte de enfermería que no exista algún daño al paciente.', NULL
);

-- [26] POLICARPIA CHAVEZ GAMBOA | 8/10/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-10-08 22:55:03+00', 'POLICARPIA CHAVEZ GAMBOA', '3952-01-26', 'Femenino',
  '2025-10-08', '16:20', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Moderado',
  'La paciente presentó un evento convulsivo, al no tener el apoyo de farmacia durante los eventos de urgencia para aplicación de medicamentos, en este caso anticonvulsivos, por falta de un protocolo adecuado, personal de enfermería vespertino recibe la indicación de abrir carrito rojo para utilización de dichos medicamentos, sin embargo, al no tener el filtro de farmacia, se comete el error de pasar midazolam y no diazepam, se hace omisión del registro de la aplicación de medicamento en la hoja de enfermería, el tratante está enterado de la situación y queda el paciente en vigilancia estrecha', 'Falta de apoyo de farmacia para procesos de uso de medicamentos en situaciones de urgencia con los paciente en área de hospitalización, omisión de enfermería de procesos ya implementados como doble verificación para aplicación de medicamentos, por parte de un compañero o supervisor en turno', 'Condición clínica compleja del paciente, Fatiga / Sobrecarga de trabajo del personal, Comunicación deficiente en el equipo, Protocolos inadecuados o inexistentes, Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'Vigilancia', NULL
);

-- [27] LUZ ELENA AZPEITIA ÁVILA | 9/10/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-10-09 06:09:55+00', 'LUZ ELENA AZPEITIA ÁVILA', '3949-07-05', 'Femenino',
  '2025-10-09', '05:00', 'Hospitalización',
  'Evento Adverso', 'Documentación / Comunicación', 'Sin Daño',
  'Por características de la condición y padecimiento del paciente, se requiere de toma de estudios de laboratorio con horario definido según el inicio del tratamiento, por lo que se solicita toma de muestra y procesamiento para sodio sérico a las 2:30 hrs, sin embargo, al momento de solicitar los resultados, no se tiene disponibles para dar seguimiento al proceso de tratamiento, al momento de preguntar al personal de laboratorio el motivo, se menciona que por la carga laboral no le ha sido posible llevar el resultado y que en cuanto tenga oportunidad, lo llevará al expediente del paciente, se le informa de la situación pero hace caso omiso, hasta que se comunica la médico tratante del paciente pidiendo los resultados, es cuando se expiden y se notifican, esto a las 5:40 hrs', 'Exceso laboral para el personal de laboratorio, solo se cuenta con una persona para turno nocturno; falta de capacitación y conocimiento de la necesidad de tener disponibles los resultados de análisis clínicos y de imagen en tiempo y forma solicitadas', 'Fatiga / Sobrecarga de trabajo del personal, Comunicación deficiente en el equipo, Protocolos inadecuados o inexistentes, Personal insuficiente, Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'Comunicación con personal de laboratorio solicitando los resultados', NULL
);

-- [28] Roberto Bernal Lopez | 11/10/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-10-11 19:06:32+00', 'Roberto Bernal Lopez', '3945-05-12', 'Masculino',
  '2025-10-11', '19:00', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Grave',
  'Pase un medicamento en horario incorrecto', 'No me fijé en la hoja de enfermería el horario', 'Formación o supervisión inadecuadas',
  'Doble chequeo por parte del personal', 'Hablar al medico de guardia', NULL
);

-- [29] Felipe Ascencio Perez | 19/10/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-10-19 18:29:06+00', 'Felipe Ascencio Perez', '3938-02-05', 'Masculino',
  '2025-10-19', '08:00', 'Hospitalización',
  'Evento Adverso', 'Dispositivos / Equipos Médicos', 'Grave',
  'Después de la entrega de turno, el compañero de enfermería notifica a médicos de guardia que el paciente tuvo una eventualidad nocturna, ya que tenía dispositivo urinario (cistoclisis), presentando gasto urinario nulo en turno nocturno, lo cual no fue notificado en tiempo y forma a médicos de guardia ni a su tratante, por lo que su especialista, durante el pase matutino, realiza proceso de desobstrucción de la sonda, logrando buena funcionalidad nuevamente; el paciente pasó más de 8 horas sin gasto urinario por una sonda ocluida sin atención a la situación', 'Falta de revisión de funcionalidad de los equipos por parte del personal; falta de notificación al personal de médicos de guardia en tiempo y forma; equipos de aparente calidad deficiente ya que de forma continua se ocluyen por el tipo de material y la forma que presentan', 'Condición clínica compleja del paciente, Comunicación deficiente en el equipo, Equipo no disponible o defectuoso, Protocolos inadecuados o inexistentes, Formación o supervisión inadecuadas',
  'Uso de una lista de verificación (checklist), Doble chequeo por parte del personal', 'Inmediatas ninguna, pasó un turno completo con dicha eventualidad', 'https://drive.google.com/open?id=1lM6Vst4LGHoCMX9QN7dL7AUOK3zyPwcd, https://drive.google.com/open?id=1O5TNl7oniPn1m2eE7YsVWBgrjYR2mcPM'
);

-- [30] Isabel valiente dominguez | 19/10/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-10-19 20:07:50+00', 'Isabel valiente dominguez', '3953-08-30', 'Femenino',
  '2025-10-19', '19:05', 'Hospitalización',
  'Evento Adverso', 'Caídas', 'Moderado',
  'Se cae paciente en el baño y se notifica primero a medico tratante antes que a enfermeria', 'Paciente geriátrica se levanta al baño, sin avisar, no hay indicios de piso mojado, se desconoce si camino con calzado, no tiene medicamento de alto riesgo que altere su estado cognitivo, no existe vía periférica con soluciones que limite sus movimientos', 'Comunicación deficiente en el equipo',
  'Uso de una lista de verificación (checklist)', 'Familiar se comunico directamente con el médico tratante y se realiza estudios de gabinete radiológicos', NULL
);

-- [31] MARÍA DE JESÚS ÍÑIGUEZ BRAVO | 3/11/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-11-03 15:51:31+00', 'MARÍA DE JESÚS ÍÑIGUEZ BRAVO', '3959-09-25', 'Femenino',
  '2025-11-03', '15:30', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Leve',
  'SE INDICA ENEMA DE LACTULOSA EN PX, SIN EMBARGO ENFERMERIA INTERPETA COMO LACTOSA EN POLVO Y DESDE EL DIA 02/11/25, SE APLICA CADA 8HRS, ''''ENEMA'''' CON LACTOSA Y AGUA, RETRASANDO EL TRATAMIENTO PARA ENCEFALOPATIA DEL PACIENTE.', 'SE INDICA ENEMA DE LACTULOSA EN PX, SIN EMBARGO ENFERMERIA INTERPETA COMO LACTOSA EN POLVO Y DESDE EL DIA 02/11/25, SE APLICA CADA 8HRS, ''''ENEMA'''' CON LACTOSA Y AGUA, RETRASANDO EL TRATAMIENTO PARA ENCEFALOPATIA DEL PACIENTE.', 'Barreras de comunicación (idioma, cognición), Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'SE CORROBORA INDICACION CON MEDICO TRATANTE, SE EXPLICA A ENFERMERIA, MOTIVO DEL PORQUE SE UTILIZA LACTULOSA Y NO LACTOSA Y EL COMO IMPACTA EN LA MEJORA DEL PX', NULL
);

-- [32] Adriana del Carmen Gomez Malta | 5/11/0025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-11-06 14:20:11+00', 'Adriana del Carmen Gomez Malta', '2061-10-18', 'Femenino',
  '2025-11-05', '17:00', 'Hospitalización',
  'Cuasi Falla', 'Comportamiento del Paciente', 'Sin Daño',
  'El día miércoles 5 de noviembre del 2025, por parte de enfermería se pidió al área de dietas una dieta completa para las 17:00 hrs para la paciente Adriana, por lo cual se le entregó en tiempo y forma, pero, a la entrega de la misma, la paciente afirmaba que su medico tratante le habían indicado líquidos, se corroboró indicación medica prescrita y se confirmo que se había pedido específicamente la dieta COMPLETA, por lo cual se le dejó tal cual la indicación.', 'Falta de comunicación efectiva por parte de medico tratante', 'Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal, Doble chequeo por parte del personal', 'Se verifico específicamente la indicación prescrita por el medico tratante', NULL
);

-- [33] Miguel Angel Moctezuma Aguilar | 2/11/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-11-06 14:48:47+00', 'Miguel Angel Moctezuma Aguilar', '2070-02-08', 'Masculino',
  '2025-11-02', '19:30', 'Hospitalización',
  'Evento Adverso', 'Comportamiento del Paciente', 'Leve',
  'El domingo 2 de noviembre del 2025, el Dr Aldo, medico de guardia, se acercó a preguntar al área de dietas si se le habían llevado "cacahuates enchilados" al paciente Miguel de Gine 2, ya que los familiares aseguraron que se le habian llevado de aqui mismo, a lo que se respondió que absolutamente no, el area no cuenta con ese insumo para pacientes y además su indicacion medica-nutricional era solo líquidos claros.', 'Muy probablemente se le paso comida y botanas de fuera al paciente, como es constante con varios pacientes', 'Protocolos inadecuados o inexistentes',
  'Intervención oportuna de otro personal', 'Por parte del área de dietas seguir las indicaciones medico-nutricionales correspondientes', 'https://drive.google.com/open?id=1vkFNROzzkM2vxdKyYv8JIf-jvfnb2FPP'
);

-- [34] J Asunción | 8/11/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-11-08 21:02:29+00', 'J Asunción', '3946-08-14', 'Masculino',
  '2025-11-08', '17:00', 'Hospitalización',
  'Evento Adverso', 'Manejo de Vía Aérea / Ventilación', 'Sin Daño',
  'Paciente POS quirúrgico con Glasgow de 3, sianotoco, marmoleo y con apenas se pasa a habitación por indicación médica, se recibe; compañero le notifica a médico de guardia del mal estado de paciente, volvemos a pasar a habitación se le toman signos vitales su saturación estaba al rededor del 37% se le vuelve a notificar a la médico de guardia para que acuda a valorar al paciente comenta que ahorita no puede, hace caso omiso y cometa que le digamos a la otra médico de guardia la cual actúa oportunamente, se le notifica a médico de urgencias y de terapia las cuales acuden se le da tratamiento y el paciente vuelve a ventilar por el mismo', 'Hipoxia', 'Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal', 'Monitorización, notificación a médicos, manejo de vía aérea, farmacoterapia y vigilancia', NULL
);

-- [35] González Alcalá J Asuncion | 8/11/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-11-08 22:36:26+00', 'González Alcalá J Asuncion', '3946-08-14', 'Masculino',
  '2025-11-08', '15:30', 'Hospitalización',
  'Evento Adverso', 'Documentación / Comunicación', 'Grave',
  '14:20 Recibí el paciente masculino en área de recuperación de quirófano en estado postquirurgico, el cual se encontraba con Glasgow 13 e hipertenso 166/90, el anestesiólogo compruebo signos vitales en monitor, procede a retirarse sin dejar indicaciones. 15:27 hrs presenta hipertensión de 210/108, y su deterioro neurologico aumenta presentando desaturación de 83%, se decide realizar la primera notificación por vía telefónica a las 15:33 a médico tratante, en la llamada se le comienza a explicar el estado hemodinámica del paciente pero médico tratante de manera cortante no permite una completa explicación del estado del paciente argumentando que era dolor, y dio la indicación de iniciar analgesia y junto con toma de presión arterial manualmente. Cuando en ningún momento se le notificó dolor de parte del paciente. 
Se inicia infusión a las 15:50 de tramadol  y posteriormente toma de presión arterial manual comprobando que la hipertensión persistía, acompañando de taquicardia y desaturando, y más deterioro neurologico . 
16:21 Después de no comprobar mejoría se realiza segunda llamada a médico tratante, el cual se le vuelve a notificar de aumento de presión arterial, y deterioro neurologico y la desaturacion. Nuevamente no permite que se le dé la explicación completa del estado del paciente, interrumpiendo mis palabras y argumentando nuevamente que era dolor, se me da la indicación de administrar clonixinato de lisina una ámpula y 1 gramo de paracetamol, le respondo a la indicación que se lo administro sin ningún problema porque todavía sigue en el área de recuperación de quirofano, a lo que el doctor responde “ya no le administres nada, mejor mándalo a su habitación y yo me comunico con los médicos de guardias”.  Se menciona nuevamente de la desaturacion del paciente, a lo que el doctor responde “súbelo a 5 litros”. Se coloca en sello de la  indicación de oxígeno a 5 litros, se plasma en hoja de enfermería a grosso modo los eventos detallados y se inicia el traslado habitacion tal como solicitó el médico tratante. 
Se entrega paciente inestable hemodinamicamente a enfermero del área de hospitalización que refiero estar a cargo del paciente, se le explicó todo el anteriormente detallado y proceden a trasladar a su habitación.', 'Fallo de comunicación', 'Condición clínica compleja del paciente, Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal, Doble chequeo por parte del personal', 'Monitorización estricta de signos vitales, farmacoterapia, oxigenoterapia, evaluación neurologica (escala de Glasgow)', 'https://drive.google.com/open?id=1c7CvPgNzhhP5MHoe7fbOa-s3c3-KNG-q, https://drive.google.com/open?id=12dW4hcUk4WHt10SgkaVh7uTUql1s2E7T, https://drive.google.com/open?id=1XEQxgoGz5Lx30ANV_MnLN2LiUbnRlL1j, https://drive.google.com/open?id=1ep68crKRCZhm7I6c85qFoqqRQnxOYYkW, https://drive.google.com/open?id=1xS1OB8Xi2E9mLSwuf78BKmd4cCR_Yv6q'
);

-- [36] Ventura Sanchez Benita | 11/11/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-11-11 12:48:20+00', 'Ventura Sanchez Benita', '3949-03-17', 'Femenino',
  '2025-11-11', '06:00', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Grave',
  'El día de ayer por la noche sale paciente de bypass femoro-popitleo, como había estado sangrando se le manda evidencia en foto al medico tratante para informarle y comenta cambio de horario de heparina de las 8pm a las 12:00hrs, la dosis es: 5,000ui. 
La enfermera del turno nocturno del día de ayer (Mayra Hernández) acude a farmacia por dos frascos de heparina de 5,000ui/ml, 10ml. Aplicando a las 12 hrs todo el frasco (50mil UI) y a las 6hrs el segundo frasco (50milUI). 
El día de hoy al dar la 3ra dosis indicada se busca el frasco en farmacia y en refrigerador del piso, el cual no se encuentra. 
Se inicia la corroboración de la eventualidad de la aplicación, comentando Itzel que supervisión nocturno confirma el error.', '.', 'Protocolos inadecuados o inexistentes, Formación o supervisión inadecuadas',
  'Alarma de un dispositivo de monitoreo', '*NO HUBIERON FACTORES MITIGANTES PERO NO HAY OPCIONES DE PONER NADA Y NO PUEDO CONTINUAR SI NO SELECCIONO NADA POR LO QUE PONGO LA OPCIÓN DE LA ALARMA DE UN DISPOSITIVO PERO NO HUBIERON FACTORES MITIGANTES*



acudo con su dirección a comentarle la eventualidad, y posteriormente me comunico con medico tratante para informarle de la eventualidad.', NULL
);

-- [37] DAVID NAVARRO GUTIERREZ | 14/11/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-11-14 08:42:40+00', 'DAVID NAVARRO GUTIERREZ', '3936-01-06', 'Masculino',
  '2025-11-14', '08:00', 'Hospitalización',
  'Cuasi Falla', 'Dispositivos / Equipos Médicos', 'Sin Daño',
  'PACIENTE COMIENZA A "DESATURAR" POR LO QUE ACUDE INHALOTERAPIA AL CUARTO DE MEDICO PARA COMENTAR EL CASO. 
ACUDE MEDICO DE GUARDIA A VALORAR AL PACIENTE Y SE PERCATA QUE EN EL OXIMETRO DEL MONITOR CARDIACON DEL PACIENTE REPORTABA SPO2 90%, SE COLOCA OXIMETRO DE PB SATURANDO87%, SE COLOCA OXIMETRO DE GINE SATURANDO 40%, SE COLOCA OXIMETRO NEGRO SATURANDO 86% Y SE COLOCA EXOMETRO DE INHALOTERAPIA REPORTANDO 82%.

SE DECIDE COLOCACION DE PUNTAS NASALES POR MAYORIA DE SATURACIONES REPORTADAS <90%.', 'POR FAVOR SOLICITO LA REVISION DE TODOS LOS DISPOSITIVOS DEL HOSPITAL (BAUMANOMETROS, MONITOR CARDIACO, OXIMETROS, ETC)', 'Equipo no disponible o defectuoso',
  'Alarma de un dispositivo de monitoreo, Doble chequeo por parte del personal', 'COLOCACION DE OXIGENO', 'https://drive.google.com/open?id=1nycVutC_sSZFV3AAOEMpq-q6Muin8gPH, https://drive.google.com/open?id=1vcsqaiZ3Wm7Kxm75QaK96_Ya-hN605tV, https://drive.google.com/open?id=1140mSMEoZ7kmDmNK69qrkX1dlAWiGedZ, https://drive.google.com/open?id=1C5leEQvJHhK3C9D17zFr2E3hUk06e6kY'
);

-- [38] Diego Armando Temblador R, José Armando González Rios, Cristóbal Conde Hernández | 15/11/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-11-15 13:36:21+00', 'Diego Armando Temblador R, José Armando González Rios, Cristóbal Conde Hernández', '3981-01-01', 'Masculino',
  '2025-11-15', '13:00', 'Hospitalización',
  'Cuasi Falla', 'Documentación / Comunicación', 'Leve',
  'Las enfermeras del área de Juan Pablo segundo anotaron en las hojas de dietas a la mayoría de los Px’s, además de que se les preguntó si había alguno de aseguradora para contemplarlo y se digo que solo jp 5 y 18;si embargo al momento de llegar a central para entregar las dietas me comentan que 3 pacientes no se habían ido y que se les llevara comida por lo que se le tuvo que llevar a destiempo retrasando así su hora de comida, la cual tardó un poco más por que uno de los px tenía dieta para hepatopata y la comida no era adecuada para el por qué no se contempló en la elaboración de los alimentos por qué se había dicho que estaba de alta.', 'Mala comunicación de parte de enfermería', 'Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal', 'Preparación extra de alimentos para esos pacientes', 'https://drive.google.com/open?id=1iJrJDCcjJLkAP5XCMYHppxyJ0MamblCS'
);

-- [39] Samuel Arturo Placito Briseño | 2/12/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-12-02 19:59:11+00', 'Samuel Arturo Placito Briseño', '3976-09-15', 'Masculino',
  '2025-12-02', '14:30', 'Hospitalización',
  'Cuasi Falla', 'Infraestructura / Recursos', 'Sin Daño',
  'Desabasto de medicamento controlado se notifica al departamento de farmacia que se requiere del medicamento con anticipación sin tener respuesta durante el turno vespertino', 'Desconocido', 'Equipo no disponible o defectuoso',
  'Intervención oportuna de otro personal', 'Se notifica con anticipación y se reporta', NULL
);

-- [40] JUAN CARLOS LOPEZ MONTES | 3/12/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-12-03 13:43:52+00', 'JUAN CARLOS LOPEZ MONTES', '3982-06-24', 'Femenino',
  '2025-12-03', '13:15', 'Hospitalización',
  'Cuasi Falla', 'Documentación / Comunicación', 'Sin Daño',
  'Médico tratante solicita carbonato de calcio 1 gr VO cada 8 horas, se pone el sello con la indicación en la hora exacta, farmacia solicita receta por desabasto del material, se les informa que la indicación está anexa a expediente, acude auxiliar de farmacia y nos comenta que ellos ni químicos tienen autorización de llamar a médicos tratantes, que esa es nuestra obligación, durante el problema calla a medico de guardia, levantando la mano en la cara y dando la espalda, para dirigirse a otra médico. Cabe resaltar que no es la primera vez que químicos y personal de farmacia, no realiza sus obligaciones, comentando que solo nosotros podemos comunicarnos con médicos tratantes, aunque previamente se ha dado capacitaciones de la comunicación efectiva y como debe llevarse acabo.', 'Falta de comunicación y de responsabilidad', 'Protocolos inadecuados o inexistentes',
  'Intervención oportuna de otro personal', 'Reporte de personal hacia calidad', NULL
);

-- [41] Maria Juana Zambrano Perez | 4/12/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-12-05 09:00:28+00', 'Maria Juana Zambrano Perez', '3967-02-08', 'Femenino',
  '2025-12-04', '11:08', 'Hospitalización',
  'Evento Adverso', 'Sangre / Productos Sanguíneos', 'Sin Daño',
  'Se indica por sello de llamada telefónica, transfundir paquete globular a la paciente, posterior a los 30 minutos se cancela dicha indicación y se indica de igual manera por sello de llamada telefónica el iniciar solución *HARTAMANN 1000 PARA 2 HORAS*.', 'Se envían resultados de paciente errónea a médico tratante, cuando le médico de guardia se percata de el error en nombre de paciente, le informo y se cancela el paquete globular anteriormente indicado.', 'Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal', 'Doble verificación', 'https://drive.google.com/open?id=1VQtuWx91_N7mz9hKJiLUnnM_ZemHJxnd'
);

-- [42] Vargas Portillo María de Loa Ángeles Adriana | 5/12/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-12-05 12:50:21+00', 'Vargas Portillo María de Loa Ángeles Adriana', '3960-09-19', 'Femenino',
  '2025-12-05', '08:20', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Leve',
  'Se indica ministrar Ceftriaxona 1gr IV como Dosis Única, por orden verbal en el área de quirofano, por parte de la anestesiologa Raquel Conchas, cuando al interrogatorio previo por parte de enfermería, la paciente informo que era alérgica al antibiótico antes mencionado. 
Presenta reaccion durante evento quirúrgico, presenta reacción alérgica se administra hidrocortosona 500mg IV DU', 'La paciente presenta con reaccion', 'Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal', 'Hidrocortisona 500mg DU', 'https://drive.google.com/open?id=1QDkqInZMk6WlCv4dEVyIa3K2uSI4lpi0, https://drive.google.com/open?id=1LDN_WTBGJxFh8ZF47EkudAdpJVnlw-Cy'
);

-- [43] GILBERTO GANDARILLA GANDARILLA | 8/12/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-12-08 17:04:35+00', 'GILBERTO GANDARILLA GANDARILLA', '3938-09-19', 'Masculino',
  '2025-12-08', '16:45', 'Hospitalización',
  'Cuasi Falla', 'Proceso de Diagnóstico (Ej: retraso diagnóstico)', 'Leve',
  'Laboratorio no realiza toma de muestras para estudios de laboratorio, solicitadas desde el ingreso del paciente que fue a las 12:48 pm, el cual tuvo que haber sido tomado por el turno matutino. Además de que se proceso en dos ocasiones las pruebas rápidas de COVID e influenza. Cabe resaltar que el paciente ingresa con insuficiencia respiratoria. No es la primera vez que laboratorio comete omisiones en la toma de muestras, que se procesan mal o que incluso cometen errores en el registro de los resultados de laboratorio, lo que causa retraso en el diagnostico y abordaje del paciente, además de que siempre cuentan con mala actitud, y ante errores como los ya mencionados no se comunican con médicos tratantes, dejando la responsabilidad de sus errores a médicos de guardia.', 'No realizan sus actividades en tiempo y forma', 'Formación o supervisión inadecuadas',
  'Doble chequeo por parte del personal', 'Se solicita que se hagan los estudios lo más pronto posible. Algo que en mi opinión podría funcionar es que no solo firmen con la fecha, sino tambien con hora de toma y quien los realiza.', NULL
);

-- [44] Sabino Alejandro Nuñez Salcedo | 15/12/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-12-16 11:43:59+00', 'Sabino Alejandro Nuñez Salcedo', '3978-04-14', 'Masculino',
  '2025-12-15', '18:00', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Leve',
  'Se administra Kabivent central cuando esta indicado periférico, el paciente no cuenta con CVC, la doble verificación no está registrada correctamente, ya que en la etiqueta de la bolsa de alimentación dice un nombre y en hoja de enfermería otro.
Cabe mencionar que es considerado medicamento de alto riesgo.', 'Enfermera a cargo de habitación Suite 03, no realiza una administración correcta de Kabivent, no realiza proceso correcto en doble verificación, el paciente presenta edema en brazo donde contaba con vía periférica.
Se percata del el error hasta el dia 16 de diciembre a las 7:00 am', 'Comunicación deficiente en el equipo, Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'Cambio de nutrición correctamente.', 'https://drive.google.com/open?id=10IY2ammmiAcuLlVot9SJBhoU05e5lvSb, https://drive.google.com/open?id=1GzUbqi2Sn8JiT6o4YMN_J3i-CaXvtDfj, https://drive.google.com/open?id=1djke4iWFrSceM6JYd_wpOvtKYHb_dwhB'
);

-- [45] JOSÉ FLORES MUÑOZ | 16/12/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-12-16 23:44:05+00', 'JOSÉ FLORES MUÑOZ', '3966-02-12', 'Masculino',
  '2025-12-16', '22:00', 'Hospitalización',
  'Cuasi Falla', 'Proceso de Diagnóstico (Ej: retraso diagnóstico)', 'Sin Daño',
  'EL MÉDICO TRATANTE SOLICITA UN ELECTROCARDIOGRAMA STAT CUANDO EL PACIENTE LLEGA A HOSPITALIZACIÓN, EL ELECTROCARDIOGRAFO DE PLANTA BAJA TIENE MÁS DE UN MES SIN FUNCIONAR POR LO QUE SE SOLICITA PRESTADO EL DE URGENCIAS PERO EL ELECTROCARDIOGRAFO DE URGENCIAS TIENE VARIOS DÍAS  SIN PAPEL PARA IMPRIMIR POR LO QUE AL FINAL ES NECESARIO PEDIR EL ELECTROCARDIOGRAFO DE TERAPIA INTENSIVA. EL MÉDICO TRATANTE AL NOTAR LA DEMORA DECIDE RETIRARSE SIN VER EL ELECTROCARDIOGRAMA IMPRESO Y SOLO TOMANDO FOTO DE LA PREVISUALIZACIÓN DEL APARATO.', '-NO CONTAR CON ELECTROCARDIÓGRAFO FUNCIONAL EN ÁREA DE HOSPITALIZACIÓN
-NO CONTAR CON PAPEL PARA ELECTROCARDIÓGRAFO EN EL ÁREA DE URGENCIAS', 'Equipo no disponible o defectuoso, Protocolos inadecuados o inexistentes',
  'Doble chequeo por parte del personal', 'PEDIR UN APARATO PRESTADO A OTRA ÁREA', NULL
);

-- [46] Ana María Escoto Villaseñor | 18/12/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-12-18 15:20:12+00', 'Ana María Escoto Villaseñor', '3934-12-31', 'Femenino',
  '2025-12-18', '13:00', 'Hospitalización',
  'Cuasi Falla', 'Documentación / Comunicación', 'Sin Daño',
  'Se le entregó al paciente una Dieta blanda en la hora de la comida del día 18-12-25, la cual fue indicada y aceptada por enfermería. A la recolección de las charolas se notifica por médicos de guardia que la dieta de la paciente no había progresado. La paciente no consumió nada de su charola de la comida por lo que no tuvo ningún efecto ni daño.', 'Falta de comunicación, atención y confirmación de las indicaciones médicas por parte de enfermería.', 'Barreras de comunicación (idioma, cognición), Comunicación deficiente en el equipo, Protocolos inadecuados o inexistentes, Personal insuficiente',
  'El paciente o familiar alertó del error', 'Retirar la charola. 
Hacer incapie a enfermería sobre la dieta del paciente.', NULL
);

-- [47] Juan Manuel Castañeda | 29/12/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-12-30 15:14:15+00', 'Juan Manuel Castañeda', '3983-11-19', 'Masculino',
  '2025-12-29', '15:00', 'Hospitalización',
  'Cuasi Falla', 'Nutrición', 'Sin Daño',
  'En la dieta de la comida de las 13 hrs se proporciono 1 gelatina la cual al percatarse el paciente como a las 15hrs se notifica a enfermería de que la gelatina tenía Moo muy visible.', 'Manejo del control de alimentos.', 'Protocolos inadecuados o inexistentes',
  'Intervención oportuna de otro personal, El paciente o familiar alertó del error', 'Cambio de aliemento', NULL
);

-- [48] juan manues castañeda | 29/12/2025
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2025-12-30 15:18:33+00', 'juan manues castañeda', '3983-11-19', 'Masculino',
  '2025-12-29', '15:00', 'Hospitalización',
  'Cuasi Falla', 'Nutrición', 'Sin Daño',
  'durante la comida el familiar notifico a enfermería a las 15:00 aproximadamente la gelatina proporcionada  manifestó hongo en aparente descomposición', 'pues hongo en la gelatina', 'Comunicación deficiente en el equipo, Protocolos inadecuados o inexistentes',
  'Intervención oportuna de otro personal, El paciente o familiar alertó del error', 'se realizo cambio de alimento.', 'https://drive.google.com/open?id=1BnjDHC3BaUIklxVFmCK6dqUO6wzvkA8n'
);

-- [49] Juan seijas | 3/1/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-01-03 10:17:45+00', 'Juan seijas', '3946-10-10', 'Masculino',
  '2026-01-03', '00:00', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Sin Daño',
  'Médico tratante acude a pase de visita el día 02/01/26 a las 19hrs y deja indicaciones anexas en foto donde indica último kabivent DC explicándoles a enfermería que al término del que tiene se suspende y ya no se reinicia. Termino de kabivent a las 24 hrs y enfermería hace caso omiso a indicación y reinicia un nuevo kabivent.', 'Falta de atención de parte de enfermería', 'Comunicación deficiente en el equipo, Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal', 'Se le comunica a tratante y se vuelve a colocar indicación', 'https://drive.google.com/open?id=1OdBQirhzj29nxMgsmHK88OS7xsD_Lw8K, https://drive.google.com/open?id=14q8ac9ppgX1PW_eCVmj3KWdlw7cnFHhN'
);

-- [50] Estela contreras pulido | 4/1/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-01-05 00:43:17+00', 'Estela contreras pulido', '3947-01-21', 'Femenino',
  '2026-01-04', '20:00', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Sin Daño',
  'Se administra metoxlopramida, la cual según informes de familiar, es alérgica, no tuvo ninguna reacción.', 'Al ingresar, los familiares, solo mencionaron alergia a metamizol, pero el familiar que estaba el dia de hoy mencionó que tambien es alérgica a la metoclopramida', 'Comunicación deficiente en el equipo',
  'El paciente o familiar alertó del error', 'Se aviso a su medico tratante y se estuvo vijalando posible reacción. 
No presento ninguna reacción, no se alteraron signos vitales.', NULL
);

-- [51] MANJARREZ ALFARO, MA. TOMASA AZUCENA | 13/1/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-01-13 18:35:47+00', 'MANJARREZ ALFARO, MA. TOMASA AZUCENA', '3937-03-07', 'Femenino',
  '2026-01-13', '16:00', 'Hospitalización',
  'Cuasi Falla', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Moderado',
  'DR FARID RODRIGUEZ A SU PASE DE VISITA A LAS 14:05HRS INDICA SOL. SALINA 0.9% + 60MEQ DE KPO4 PP IV EN BIC A 20ML/HR.
A LAS 17:03HRS ENFERMERO JONATHAN SE COMUNICA CON MEDICOS DE GUARDIA PARA INFORMAR QUE PREPARO LA SOLUCION CON 60MEQ PERO DE KCL, LA INICIO A LAS 16:00HRS Y SE DIO CUENTA A LAS 17:00HRS Y LA PAUSO. 
SE LE COMUNICA AL DR FARID LA EVENTUALIDAD Y SOLICITA QUE DE INMEDIATO SE COLOQUE LA INFUSION CORRECTA.', 'PACIENTE CON NAUSEAS Y VOMITOS QUE FUERON EN AUMENTO, SE DESCONOCE SI AUMENTARON POR LA ADMINISTRACION DE KCL.', 'Fatiga / Sobrecarga de trabajo del personal, Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal', 'SUSPENDER SOLUCION', 'https://drive.google.com/open?id=1AJ-bBASs0lTXoUXDkifLm4hJaTjIzkPP'
);

-- [52] González Vásquez Everardo | 22/1/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-01-22 21:56:11+00', 'González Vásquez Everardo', '3953-04-30', 'Masculino',
  '2026-01-22', '17:50', 'Hospitalización',
  'Cuasi Falla', 'Sangre / Productos Sanguíneos', 'Leve',
  'Paciente al cual se le indica paquete globular para 4 horas, se le inicia a las 15:33 y se termina a las 17:50. Posterior a ellos paciente comienza con fibrilacion auricular.', 'Sobrecarga al paciente', 'Condición clínica compleja del paciente, Fatiga / Sobrecarga de trabajo del personal',
  'Intervención oportuna de otro personal', 'Se le informa a médico tratante, toma de electrocardiograma', 'https://drive.google.com/open?id=1TETxPKH6IwgxEvCX_kOQTz3wk-cXZEgl, https://drive.google.com/open?id=1mz9se6fo6prClVko3kKwX_aSGamW2EJR'
);

-- [53] Espinoza Sanchez Ernesto | 21/1/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-01-23 08:26:40+00', 'Espinoza Sanchez Ernesto', '3961-08-17', 'Masculino',
  '2026-01-21', '22:30', 'Hospitalización',
  'Evento Adverso', 'Medicación / Fluidos IV (Ej: dosis incorrecta, omisión)', 'Leve',
  'Se omite la aplicación de medicación de analegesia', 'Se indica parche soloro ya que el paciente estaba con dolor constate, por la mañana se percata en enlace de turno que no se había colocado dicho parche', 'Formación o supervisión inadecuadas',
  'El paciente o familiar alertó del error', 'Se coloca en el momento', 'https://drive.google.com/open?id=1-_LmGezdAAdOBG1VJcW_NbS6DQqMv1MU, https://drive.google.com/open?id=1sB37WalM1Y9jATTbELBXscdwkZ3O8K0B, https://drive.google.com/open?id=1P3L8GEWEmMr0Sgfvl9AckYJpNJBnmJZ-'
);

-- [54] ALVAREZ MUÑOZ MIGUEL | 29/1/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-01-30 12:20:52+00', 'ALVAREZ MUÑOZ MIGUEL', '3968-02-09', 'Masculino',
  '2026-01-29', '12:07', 'Hospitalización',
  'Cuasi Falla', 'Manejo de Vía Aérea / Ventilación', 'Leve',
  'Paciente con dificultad respiratoria, portador de puntas de alto flujo a 30 litros y 90 de fio. Al chechar signos vitales en hoja de enfemeria tiene FR de 17, cuando evidentemente el paciente tiene taquipnea y en hoja de enfermeria se registra una FC de 17. Al tomarla por medico de guardia (aproximadamente a las 10 am) se corrabora una FC de 26, se avisa a enfermeria quien no registra signos nuevamente y se molesta con la observacion. Es importante la buena toma de signos en un paciente con soporte ventilatorio para poder estadificar el fracaso ventilatorio y la mortalidad del paciente, asi como saber si es momento de progresar la via ventilatoria.', 'mal toma de signos vitales y no registro', 'Comunicación deficiente en el equipo, Personal insuficiente',
  'Intervención oportuna de otro personal, Doble chequeo por parte del personal', 'Se aviso a medico tratante del error quien corrabora taquipnea y debido a condicion del paciente ofreció ventilación mecánica a paciente quien firma consentimiento de no intubación.', 'https://drive.google.com/open?id=1g7SDL626Hy1SNWDQKc9D5aqOyF59EwdY'
);

-- [55] BARAJAS RAMOS, CAMILA MONSERRAT | 30/1/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-01-30 15:42:01+00', 'BARAJAS RAMOS, CAMILA MONSERRAT', '2010-12-03', 'Femenino',
  '2026-01-30', '09:40', 'Hospitalización',
  'Cuasi Falla', 'Procedimiento Clínico / Invasivo (Ej: cirugía en sitio equivocado)', 'Sin Daño',
  'SE REALIZAN CAMBIOS EN INDICACIONES A LA PACIENTE POR ORDEN DE SU MEDICO TRATANTE, SE ACUDE A COLOCAR SELLO Y SE ESPECIFICA ESTUDIOS DE GABINETE PARA EL DIA DE MAÑANA 31/01/26, ENFERMERIA HACE CASO OMISO A DICHA INDICACION Y SOLICITA LA TAC Y LOS LABORATORIALES PARA EL DIA DE HOY. FAMILIARES LE COMUNICAN A MEDICO TRATANTE QUE SE LLEVARAN A LA PACIENTE A TAC Y ESTA MISMA SE COMUNICA CON NOSOTROS PARA INTERVENIR, SE LOGRO INTERVENIR CON TIEMPO Y NO SE REALIZO LA TAC PERO PARTE DE LOS LABORATORIALES SI SE PROCESARON.', 'COBROS EXTRAS AL PACIENTE', 'Fatiga / Sobrecarga de trabajo del personal, Protocolos inadecuados o inexistentes',
  'Intervención oportuna de otro personal', 'SE SUSPENDE Y SE METE INCIDENCIA, SE VUELVE A ACLARAR QUE SON PARA MAÑANA', 'https://drive.google.com/open?id=15LUZELlcv3LHTnys7fC3iA58F_38m8I8'
);

-- [56] Gloria coronel bernal | 12/2/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-02-13 06:42:24+00', 'Gloria coronel bernal', '3935-04-10', 'Femenino',
  '2026-02-12', '22:00', 'Hospitalización',
  'Consulta', 'Comportamiento del Paciente', 'Sin Daño',
  'Los familiares de la persona se han portado de manera hostil, ignorando peticiones y exigiendo las cosas, también se quedaron 2 personas cuando se les dijo que sólo podía estar 1, dijo que se quedó para ayudar a movilizar, cosa que no es cierto puesto que me hablaron a mí en repetidas veces para lo mismo', 'Descontento al solicitar que sólo hubiera una sola persona en habitacion', 'Condición clínica compleja del paciente',
  'Doble chequeo por parte del personal', 'Le informe a mi superior directa (jefa alma)', NULL
);

-- [57] GARCIA YEPIZ, AMANDA DEL ROSARIO | 18/2/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-02-18 14:00:28+00', 'GARCIA YEPIZ, AMANDA DEL ROSARIO', '3950-11-12', 'Femenino',
  '2026-02-18', '13:50', 'Hospitalización',
  'Cuasi Falla', 'Procedimiento Clínico / Invasivo (Ej: cirugía en sitio equivocado)', 'Sin Daño',
  'PACIENTE PASA A CIRUGIA DE CADERA EL DIA 17/02/26 DURANTE CIRUGIA PRESENTA ABUNDANTES EVACUACIONES  POR LO CUAL POR HIGIENE MEDICO TRATANTE SOLICITA COLORACION DE GASA EN ANO, SOLICITA RETIRO DE LA MISMA AL PASAR A RECUPERACION. 
EL DIA DE HOY 18/02/26 PACIENTE YA DE EGRESO REFIERE SENTIR ALGO EN ZONA ANAL, MEDICO DE GUARDIA EN TURNO REVISA Y OBSERVA QUE AUN TIENE GASA INCERTADA, SE RETIRA.', 'ENFERMERIA REPORTA EVACUACIONES DURANTE TURNO, SI HUBIERA PRESENTADO EVACUACIONES SE HUBIERAN DADO CUENTA DE DICHA GASA.', 'Fatiga / Sobrecarga de trabajo del personal, Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal', 'RETIRAR GASA E INFORMAR', NULL
);

-- [58] Garcia Yepis Amanda Rosario | 18/2/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-02-19 13:03:00+00', 'Garcia Yepis Amanda Rosario', '3950-11-12', 'Femenino',
  '2026-02-18', '12:30', 'Hospitalización',
  'Evento Adverso', 'Documentación / Comunicación', 'Leve',
  'Paciente refiere dolor abdominal y en ano, por que enfermería notofica a medico de guardia para valoración, después de valoración se informa a médico tratante el cual menciona que antes de iniciar cirugía se coloco un tapón de gasa en ano, porque la paciente estaba evacuando mucho, se da la indicación  verbal a enfermería que al egreso del paciente se retire, lo cual se omite y no se realiza un entrega de paciente correcta, se retira tapón 22 horas después de que se colocó.', 'Tapón de gasa en ano, se omite el retiro por parte de enfermería.', 'Barreras de comunicación (idioma, cognición), Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal, El paciente o familiar alertó del error', 'Se retira el tapón de gasa al momento que el médico informo que lo tenía.', NULL
);

-- [59] Stephanie Garcia Gutierrez | 18/2/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-02-19 13:16:54+00', 'Stephanie Garcia Gutierrez', '3993-03-04', 'Femenino',
  '2026-02-18', '07:00', 'Hospitalización',
  'Evento Adverso', 'Documentación / Comunicación', 'Leve',
  'No se proporciono desayuno a paciente hospitalizada.', 'Enfermería omite el registro en hoja de dieta, de paciente hospitalizada en JP 09, la cual era de aseguradora, contaba con alta a domicilio, pero aún su aseguradora no daba respuesta.
No solo se omite el registrar dieta que esto causó que no se le entregara desayuno, sino también se omitió el pase a habitación de enfermería en turno nocturno, no signos vitales, no reporte de enfermería.', 'Comunicación deficiente en el equipo, Formación o supervisión inadecuadas',
  'Intervención oportuna de otro personal, El paciente o familiar alertó del error', 'Se notifica al medico para recibir indicaciones médicas nuevas, toma de signos vitales y cuidados de enfermería en turno matutino.', 'https://drive.google.com/open?id=1cn4kJN2TCjU6OjKWErx8dUz0WJpQioGK, https://drive.google.com/open?id=1s2jC4xRINdmco4R0sYC1BxUK8u1d3B1V'
);

-- [60] PARRA CAMAÑO, ALMA GABRIELA | 20/2/2026
INSERT INTO clinical_incidents (
  reported_at, patient_name, patient_dob, patient_sex,
  incident_date, incident_time, location,
  incident_type, incident_subtype, damage_level,
  description, causes, contributing_factors,
  mitigating_factors, immediate_actions, attachments)
VALUES (
  '2026-02-20 09:08:08+00', 'PARRA CAMAÑO, ALMA GABRIELA', '3969-03-09', 'Femenino',
  '2026-02-20', '08:56', 'Hospitalización',
  'Cuasi Falla', 'Sangre / Productos Sanguíneos', 'Sin Daño',
  'MEDICO ACUDE A VALORACION EN LA MADRUGADA E INDICA LABORATORIALES A LAS 5AM TOMADOS POR EL PICC, A LAS 8:00 AM MEDICO SOLICITA LOS LABORATORIALES Y AL REVISAR EN SISTEMA NO SALEN POR LO CUAL MEDICO DE GUARDIA ACUDE A REVISAR QUE SE HAYAN TOMADO Y NO ESTAN FIRMADOS. SUPERVISION DE ENFERMERIA MENCIONA QUE TURNO NOCTURNO JUSTIFICA QUE NO SE TOMARON PORQUE SE ESTABA TRANSFUNDIENDO. 
JUSTIFICACION NO VALIDA, PORQUE NO ES CONTRAINDICACION PARA TOMA DE LABORATORIALES.', 'MEDICO INTERCONSULTANTE SOLICITA LABORATORIALES Y NO PUEDE REALIZAR AJUSTES', 'Fatiga / Sobrecarga de trabajo del personal, Comunicación deficiente en el equipo',
  'Intervención oportuna de otro personal', 'SE SOLICITA QUE SE TOMEN LABORATORIALES', 'https://drive.google.com/open?id=1qmIiejrHk9_m04Gf8DS6XWvfQkV5Eyvw'
);
