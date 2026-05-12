-- ============================================================
--  CAPITAL HUMANO — Vista digital de 10 Procedimientos
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar DESPUÉS de capital_humano_docs.sql
--
--  Bloque de autorización común a los 10 documentos:
--    Elaboró:   Lic. Jorge Octavio Ramírez Chávez  / Jefe de Capital Humano
--    Revisó:    Dra. Giselle Ivette De la Torre García / Jefatura de Calidad
--    Autorizó:  Hna. María de Jesús García Castro   / Dirección General
-- ============================================================

-- ── PR-CH-01  Reclutamiento y Selección ──────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Reclutar y seleccionar al personal clínico y no clínico que labora en la organización fundamentados en el análisis de la información, las recomendaciones de los responsables de las áreas y la legislación aplicable vigente.',

'Este proceso inicia cuando surge una vacante en algún departamento, debido a alguna sustitución de personal, aumento de actividad o por nueva creación y finaliza una vez quedando cubierta la vacante.

Los departamentos involucrados son: Dirección administrativa, dirección médica, enfermería, intendencia, mantenimiento, secretarias y auxiliares administrativos, imagenología, contabilidad, laboratorio, sistemas, dietas, fisioterapia, servicios farmacéuticos, banco de sangre, farmacia, epidemiología, médicos de piso y médicos urgenciólogos, y relaciones públicas.',

'[{"termino":"Reclutamiento","definicion":"Es el proceso mediante el cual una organización busca, atrae y convoca a personas potencialmente calificadas para cubrir un puesto vacante."},{"termino":"Selección","definicion":"Es el conjunto de técnicas y herramientas que permiten identificar, entre los candidatos reclutados, a la persona que mejor se ajusta al perfil del puesto y a la cultura organizacional."},{"termino":"Candidato","definicion":"Es la persona que participa en un proceso de reclutamiento y selección, presentando sus datos, experiencia y habilidades con el fin de ser considerado para ocupar un puesto dentro de la organización."},{"termino":"Entrevista","definicion":"Es una técnica de evaluación dentro del proceso de selección, que consiste en una conversación estructurada o semiestructurada entre el reclutador y el candidato."}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Jefatura del departamento de capital humano"},{"tipo":"4.2 Ejecución","descripcion":"Departamento de Capital Humano, así como los coordinadores de los distintos departamentos."},{"tipo":"4.3 Supervisión","descripcion":"Dirección administrativa"}]'::jsonb,

'[{"no":"5.1","responsable":"Jefe, coordinador o responsable de departamento","actividad":"Solicita la cobertura de la vacante al departamento de capital humano a través del formato de requisición de personal (FT-CH-02)"},{"no":"5.2","responsable":"Capital humano","actividad":"Presenta el formato de requisición a Dirección Administrativa, quien determinará si se autoriza o no la nueva posición. En caso de ser reemplazo se firma por capital humano."},{"no":"5.3","responsable":"Dirección administrativa","actividad":"Valora la requisición. De ser autorizada la cobertura firma de autorización para continuar con el proceso. Nota: De no ser autorizada la cobertura se da por terminado el proceso."},{"no":"5.4","responsable":"Capital humano","actividad":"Publica la vacante a través de los distintos medios de atracción de candidatos (Periódico, Indeed, Occ, redes sociales etc.)"},{"no":"5.5","responsable":"Capital humano","actividad":"Recibe las postulaciones de candidatos, y selecciona a los que tienen un mayor apego al perfil solicitado para ser citados a entrevista, así mismo, se descarta a quienes no reúnen los requisitos."},{"no":"5.6","responsable":"Candidato","actividad":"Se presenta en el día y hora acordada a la entrevista con su solicitud elaborada o currículo, en caso de no contar llena la solicitud interna de trabajo (FT-CH-03)."},{"no":"5.7","responsable":"Capital humano","actividad":"Entrevista: inicia con el sondeo para conocer las aspiraciones del candidato. Se le da a conocer la información detallada de la vacante (oferta económica, prestaciones, turnos, días de descanso). Nota: Si se cuenta con examen de conocimientos generales se aplica al candidato en ese momento."},{"no":"5.8","responsable":"Capital humano","actividad":"Realiza entrevista a los candidatos previamente citados, se agenda fecha y hora"},{"no":"5.9","responsable":"Capital humano","actividad":"De requerir el perfil, se envía por correo electrónico las instrucciones y el enlace de la plataforma (PSICOTEST) para evaluación psicométrica."},{"no":"5.10","responsable":"Candidato","actividad":"Se registra en la plataforma de evaluación psicométrica y aplica las evaluaciones de los diversos módulos."},{"no":"5.11","responsable":"Capital humano","actividad":"Analiza los resultados de las evaluaciones. Selecciona a los mejores candidatos y programa fecha para entrevista. Nota: Candidato que no responde en el tiempo establecido o con bajo apego al perfil queda descartado."},{"no":"5.12","responsable":"Capital Humano","actividad":"Revisa los exámenes; candidato que apruebe continúa en el proceso de selección. Nota: Candidato que no apruebe el examen será descartado del proceso"},{"no":"5.13","responsable":"Jefe, coordinador o responsable de departamento","actividad":"Realiza entrevista al candidato y llena el formato (FT-CH-42). Aprueba o no aprueba la contratación"},{"no":"5.14","responsable":"Capital humano","actividad":"Solicita referencias laborales bajo el formato (FT-CH-05) en anteriores empleos de los candidatos seleccionados. Nota: De obtener referencias no favorables se descarta al candidato."},{"no":"5.15","responsable":"Capital humano","actividad":"Requiere al candidato la documentación para su ingreso, estableciendo fecha para entrega."},{"no":"5.16","responsable":"Candidato","actividad":"Presenta documentación requerida"},{"no":"5.17","responsable":"Capital Humano","actividad":"Finaliza el proceso."}]'::jsonb,

'[{"riesgo":"Tomar la entrevista como único filtro para la contratación.","barrera":"Se emplea herramienta de evaluación de conocimientos, psicométrica y práctica."},{"riesgo":"Contratar a candidatos con documentación apócrifa.","barrera":"Validación de documentación por medio de medios electrónicos."},{"riesgo":"Que el candidato proporcione información falsa de anteriores empleos (No. telefónico y supuesto patrón).","barrera":"Solicitar referencia en sus anteriores trabajos, teniendo contacto directamente con la empresa."}]'::jsonb,

'[{"nombre":"Formato de requisición","codigo":"FT-CH-02"},{"nombre":"Solicitud interna de trabajo","codigo":"FT-CH-03"},{"nombre":"Solicitud de referencias laborales","codigo":"FT-CH-05"},{"nombre":"Reporte de entrevista","codigo":"FT-CH-42"}]'::jsonb,

'[{"version":"1","fecha":"15/02/2019","descripcion":"Alta de documentos","realizado":"Daniel Cázares","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"2","fecha":"15/02/2020","descripcion":"Modificación de documento","realizado":"Melisa Jimenez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"30/03/2022","descripcion":"Modificación de documento","realizado":"Melisa Jimenez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"4","fecha":"03/06/2024","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramirez Chávez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"5","fecha":"29/09/2025","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramirez Chávez","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Lic. Jorge Octavio Ramírez Chávez', 'Jefe de Capital Humano',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CH-01'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CH-02  Ingreso de Personal ────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Establecer los lineamientos y pasos a seguir para la integración formal de un nuevo colaborador a la institución, asegurando el cumplimiento de los requisitos legales, administrativos y de seguridad.',

'Inicia cuando el reclutador solicita el listado de documentación requerida al candidato y termina cuando el candidato se presenta a laborar. Los involucrados en este proceso son los candidatos, Jefes de área y el departamento de capital humano.',

'[{"termino":"Ingreso","definicion":"Es el proceso mediante el cual una persona seleccionada formaliza su incorporación a la organización, cumpliendo con los requisitos administrativos, legales y de seguridad establecidos"},{"termino":"Documentación","definicion":"Es el conjunto de registros, identificaciones, certificados y demás requisitos en formato físico o digital que el colaborador debe presentar para formalizar su ingreso a la organización"},{"termino":"Candidato","definicion":"Es la persona que participa en un proceso de reclutamiento y selección, presentando sus datos, experiencia y habilidades con el fin de ser considerado para ocupar un puesto dentro de la organización."}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Jefatura del departamento de capital humano"},{"tipo":"4.2 Ejecución","descripcion":"Departamento de Capital Humano, así como los candidatos."},{"tipo":"4.3 Supervisión","descripcion":"Dirección administrativa"}]'::jsonb,

'[{"no":"5.1","responsable":"Capital humano","actividad":"Solicita al candidato el listado de documentación requerida para su ingreso (por medio electrónico o personalmente): solicitud o CV firmado con fotografía, constancia de último grado de estudios (copia), título y cédula, RFC con homoclave, número de seguridad social, carta de no antecedentes penales, CURP (copia), IFE (copia), acta de nacimiento (copia preferentemente vigente), acta de matrimonio, comprobante de domicilio (vigente), certificado médico de institución pública, análisis de laboratorio (tipo de sangre), 2 constancias laborales (últimos empleos), 2 cartas de recomendaciones personales, hoja retención del infonavit."},{"no":"5.2","responsable":"Candidato","actividad":"Reúne la documentación requerida. Se comunica con Capital Humano para programar fecha y hora para la entrega. Se presenta el día acordado."},{"no":"5.3","responsable":"Capital humano","actividad":"Recibe documentación COMPLETA del candidato. Toma fotografía para gafete. Arma expediente con Formato FT-CH-06 (Checklist integración de expediente y Solicitud FT-CH-02). Programa cita para firma de contrato."},{"no":"5.4","responsable":"Capital humano","actividad":"Genera el formato FT-CH-07 (Alta de Nómina), contrato eventual por 30 días, compromiso de confidencialidad, gafete, tramita tarjeta de nómina, captura ingreso en base de datos de contratos y da de alta al candidato en sistema checador."},{"no":"5.5","responsable":"Candidato","actividad":"Se presenta el día y hora acordado al departamento de capital humano."},{"no":"5.6","responsable":"Capital humano","actividad":"Entrega al candidato su contrato, compromiso de confidencialidad, gafete, uniforme y material de trabajo. Da de alta en checador (huella). Imparte inducción general a la empresa."},{"no":"5.7","responsable":"Candidato","actividad":"Firma contrato eventual de 30 días, firma compromiso de confidencialidad, firma y recibe su gafete, recibe uniforme y material de trabajo según su puesto."},{"no":"5.8","responsable":"Capital humano","actividad":"Reintegra el expediente con contrato y compromiso de confidencialidad firmados, y lo entrega a la persona encargada de nómina."},{"no":"5.9","responsable":"Nomina","actividad":"Da de alta al colaborador en los diversos sistemas (tramita alta del IMSS, tarjeta de vales). Entrega el expediente junto con alta del IMSS y tarjeta de vales al departamento de Capital Humano."},{"no":"5.10","responsable":"Candidato","actividad":"Se presenta a laborar el día acordado."},{"no":"5.11","responsable":"Capital Humano","actividad":"Finaliza proceso"}]'::jsonb,

'[{"riesgo":"El candidato no se presenta la fecha y hora acordada a entregar documentación completa.","barrera":"Capital Humano establecer claramente que, sino entrega documentos completos el día acordado, se suspenderá el proceso de ingreso."},{"riesgo":"Datos incorrectos en la documentación entregada.","barrera":"Se validan los datos de los documentos con el candidato."},{"riesgo":"Presente títulos falsificados","barrera":"Verificar cédulas con páginas oficiales"}]'::jsonb,

'[{"nombre":"Requisición de personal","codigo":"FT-CH-02"},{"nombre":"Checklist Integración de Expediente","codigo":"FT-CH-06"},{"nombre":"Alta de nómina","codigo":"FT-CH-07"}]'::jsonb,

'[{"version":"1","fecha":"15/02/2019","descripcion":"Alta de documentos","realizado":"Daniel Cázares","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"2","fecha":"15/02/2020","descripcion":"Modificación de documento","realizado":"Melisa Jimenez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"30/03/2022","descripcion":"Modificación de documento","realizado":"Melisa Jimenez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"4","fecha":"03/06/2024","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramirez Chávez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"5","fecha":"29/09/2025","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramirez Chávez","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Lic. Jorge Octavio Ramírez Chávez', 'Jefe de Capital Humano',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CH-02'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CH-03  Riesgo de Trabajo ──────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Actuar de una manera adecuada en el momento en que ocurra algún supuesto riesgo de trabajo dentro de la empresa, garantizando que los colaboradores den seguimiento hasta finalizar el proceso',

'Este proceso inicia en el momento en que el colaborador presenta un supuesto riesgo de trabajo (ST7) y finaliza una vez que el colaborador entrega al departamento de Capital Humano su formato de alta (ST2) y la hoja de riesgo calificada. Dentro de este proceso están involucrados todos los departamentos del hospital.',

'[{"termino":"Formato","definicion":"Documento estructurado utilizado para recopilar, registrar y estandarizar información específica sobre un proceso"},{"termino":"ST7","definicion":"Formato oficial de la Secretaría del Trabajo y Previsión Social (STPS) de México, utilizado para el registro y control de accidentes y enfermedades de trabajo"},{"termino":"ST2","definicion":"Formato oficial de la STPS de México, utilizado para reportar al Instituto Mexicano del Seguro Social (IMSS) para el reinicio de labores del colaborador."},{"termino":"Riesgo de trabajo","definicion":"Es cualquier accidente o enfermedad que ocurre con motivo o en el ejercicio del trabajo, ya sea durante la jornada laboral o en actos relacionados con las funciones del puesto"}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Jefatura del departamento de capital humano"},{"tipo":"4.2 Ejecución","descripcion":"Departamento de Capital Humano, Colaborador y Dirección General (Representante Legal)"},{"tipo":"4.3 Supervisión","descripcion":"Dirección administrativa"}]'::jsonb,

'[{"no":"5.1","responsable":"Colaborador","actividad":"Presenta supuesto riesgo de trabajo dentro de la empresa. Notifica a su jefe inmediato sobre lo sucedido"},{"no":"5.2","responsable":"Jefe inmediato","actividad":"Reporta el evento al departamento de Capital Humano y coordinador de comisión mixta de seguridad e higiene quien se encarga de dar seguimiento. Nota: En caso de que el accidente ocurra fuera del horario de Capital Humano, dirige al colaborador al área de urgencias donde se le dará la primera valoración por el médico."},{"no":"5.3","responsable":"Capital humano o jefe inmediato","actividad":"Dirige al colaborador a urgencias para valoración."},{"no":"5.4","responsable":"Médico de urgencias","actividad":"Valora al colaborador y genera su nota médica. Determina si puede tratarse internamente o es necesario acudir al IMSS e informa si puede terminar su jornada o debe retirarse. Nota: En caso de accidente por punzocortante o riesgo de infección, solicita serologías para Hepatitis B, Hepatitis C y VIH; envía al colaborador con laboratorio y notifica a epidemiología."},{"no":"5.5","responsable":"Colaborador","actividad":"Explica a Capital Humano lo sucedido y entrega copia de la nota médica de ingreso a urgencias."},{"no":"5.6","responsable":"Capital humano","actividad":"Entrega al colaborador el formato FT-CH-08 (Control de Riesgos de Trabajo). Nota: Fuera del horario de capital humano, el jefe directo entregará el formato FT-CH-08."},{"no":"5.7","responsable":"Colaborador","actividad":"Llena el formato (FT-CH-08) y lo entrega a capital humano."},{"no":"5.8","responsable":"Capital humano","actividad":"Explica claramente al colaborador el proceso a realizar en la clínica del IMSS. El colaborador no podrá reintegrarse sin entregar su formato de alta (ST2). Envía al colaborador a su clínica según indicaciones del médico de urgencias."},{"no":"5.9","responsable":"Colaborador","actividad":"Se presenta en su clínica del IMSS. Una vez iniciado el trámite, entrega a Capital Humano: Formato ST7 (recibido en su clínica), Formato de alta ST2, o Incapacidad en caso de que el IMSS la expida."},{"no":"5.10","responsable":"Capital humano","actividad":"Recibe documentación y permite reingreso únicamente si el colaborador entrega el ST2. Llena el formato ST7 en el apartado de datos complementarios para calificación de probable accidente de trabajo. Nota: Sin ST2 envía de nuevo al colaborador al IMSS para solicitarla; con incapacidad se le indica retirarse."},{"no":"5.11","responsable":"Capital humano","actividad":"Analiza el formato ST7, firma en el apartado 30) y coloca el sello de la empresa en el apartado 31)."},{"no":"5.12","responsable":"Capital humano","actividad":"Se comunica con el colaborador para entregar el formato y continuar con el proceso"},{"no":"5.13","responsable":"Comisión de seguridad e higiene","actividad":"Analiza la necesidad de investigar el accidente notificado, tomando en cuenta la magnitud y características."},{"no":"5.14","responsable":"Comisión de seguridad e higiene","actividad":"Realiza la investigación del accidente a través del mismo colaborador o testigos, recopilando datos relevantes: ¿dónde? ¿cómo? ¿por qué?"},{"no":"5.15","responsable":"Comisión de seguridad e higiene","actividad":"Con la información obtenida, complementa el formato de investigación de accidentes laborales determinando causas inmediatas y acciones correctivas para disminuir o eliminar el riesgo."},{"no":"5.16","responsable":"Colaborador","actividad":"Recibe formato. Se presenta al IMSS a medicina del trabajo y entrega el formato junto con la documentación solicitada para la calificación del riesgo. Se presenta nuevamente en la fecha acordada para recoger su riesgo ya calificado. Entrega la calificación de su riesgo a capital humano."},{"no":"5.17","responsable":"Capital humano","actividad":"Recibe calificación del riesgo. Finaliza el proceso."}]'::jsonb,

'[{"riesgo":"El colaborador no le da seguimiento al trámite una vez que levanta el riesgo ante el IMSS.","barrera":"Explicar claramente el trámite completo que se deberá de cumplir, así como las consecuencias que tendrán en caso de no terminar el trámite."}]'::jsonb,

'[{"nombre":"Formato Control de Riesgos de Trabajo","codigo":"FT-CH-08"}]'::jsonb,

'[{"version":"1","fecha":"15/01/2019","descripcion":"Alta de documentos","realizado":"Daniel Cázares","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"2","fecha":"30/03/2022","descripcion":"Modificación de documento","realizado":"Melisa Jimenez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"03/06/2024","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramirez Chávez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"4","fecha":"29/09/2025","descripcion":"Actualización del documento","realizado":"Lic. Jorge Octavio Ramirez Chávez","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Lic. Jorge Octavio Ramírez Chávez', 'Jefe de Capital Humano',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CH-03'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CH-04  Baja del Empleado ───────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Establecer los lineamientos y controles necesarios para realizar las bajas del personal de la Compañía, con el fin de cumplir los requisitos legales y laborales.',

'Inicia en el momento que el colaborador es citado o se presenta a la oficina de Capital Humano para iniciar con el trámite de su baja ya sea por renuncia o despido. Finaliza una vez que las nóminas entregan al departamento de C.H. la baja del IMSS del colaborador. Los involucrados en este proceso son: Colaborador (Diversos departamentos del Hospital), Capital Humano, Nóminas, Dirección Administrativa.',

'[{"termino":"Renuncia","definicion":"Acto unilateral por el cual un empleado decide terminar su relación laboral con un empleador"},{"termino":"Formato de renuncia","definicion":"Documento escrito que notifica formalmente a un empleador la decisión de un empleado de dejar su puesto de trabajo"},{"termino":"Encuesta de salida","definicion":"Cuestionario que se administra a empleados que abandonan una empresa para recopilar información honesta y valiosa sobre su experiencia, las razones de su partida y su percepción general de la compañía"},{"termino":"Finiquito","definicion":"Pago que recibe un trabajador al terminar su relación laboral, liquidando las deudas pendientes y sirviendo como recibo del pago"}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Jefatura del departamento de capital humano"},{"tipo":"4.2 Ejecución","descripcion":"Colaboradores, departamento de Capital Humano, nóminas, dirección administrativa."},{"tipo":"4.3 Supervisión","descripcion":"Dirección administrativa"}]'::jsonb,

'[{"no":"5.1","responsable":"Colaborador","actividad":"Se presenta al departamento de Capital Humano ya sea porque él lo solicita o una vez que es citado por C.H. para iniciar con el trámite de su baja."},{"no":"5.2","responsable":"Capital Humano","actividad":"Realiza entrevista de salida al colaborador, según el formato FT-CH-35 (Encuesta de Salida)"},{"no":"5.3","responsable":"Capital Humano","actividad":"Realiza por escrito bajo los lineamientos requeridos la renuncia, misma que se entrega al colaborador"},{"no":"5.4","responsable":"Colaborador","actividad":"Recibe y analiza la renuncia validando que los datos sean correctos. Firma renuncia y entrega a Capital Humano su gafete, uniformes y material de trabajo. Nota: En caso de baja solicitada por la institución, el colaborador recibirá su finiquito previamente calculado por nóminas y autorizado por Dirección Administrativa."},{"no":"5.5","responsable":"Capital Humano","actividad":"Dirige a la salida al excolaborador, informándole que se le llamará en un periodo no mayor a una semana para entregar su finiquito. Nota: Capital Humano deberá dar aviso al jefe inmediato sobre la baja de su colaborador."},{"no":"5.6","responsable":"Capital Humano","actividad":"Solicita a nóminas la baja ante el IMSS y el cálculo de finiquito."},{"no":"5.7","responsable":"Nóminas","actividad":"Tramita la baja ante el IMSS, realiza el cálculo de finiquito y entrega el cálculo a Dirección Administrativa."},{"no":"5.8","responsable":"Dirección administrativa","actividad":"Analiza el cálculo del finiquito y realiza el cheque. Se comunica con Capital Humano para hacer entrega de este."},{"no":"5.9","responsable":"Capital Humano","actividad":"Se comunica con excolaborador y programa día y hora de entrega de finiquito."},{"no":"5.10","responsable":"Ex Colaborador","actividad":"Se presenta a Capital Humano en la fecha acordada. Analiza y firma su finiquito, así mismo recibe su cheque."},{"no":"5.11","responsable":"Capital Humano","actividad":"Entrega a Dirección administrativa y a nóminas el recibo de finiquito y póliza de cheque ya firmado por excolaborador."},{"no":"5.12","responsable":"Capital Humano","actividad":"Guarda en expediente recibo de finiquito y póliza."},{"no":"5.13","responsable":"Capital Humano","actividad":"Coloca el expediente en la caja de archivo (Bajas)."}]'::jsonb,

'[{"riesgo":"Un procedimiento de baja inadecuado, una denuncia a la empresa, o no entregar los recursos de la empresa.","barrera":"Programar entrevista de salida con el colaborador. Realizar formato de renuncia firmado por el colaborador. Dejar muy claro que para entregar el cheque de finiquito se requiere entregar todo recurso de la empresa."}]'::jsonb,

'[{"nombre":"Formato de Entrevista de Salida","codigo":"FT-CH-35"}]'::jsonb,

'[{"version":"1","fecha":"15/01/2019","descripcion":"Alta de documento","realizado":"L.R.I. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"2","fecha":"30/03/2022","descripcion":"Modificación de documento","realizado":"L.R.I. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"03/06/2024","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramírez Chávez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"4","fecha":"29/09/2025","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramirez Chávez","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Lic. Jorge Octavio Ramírez Chávez', 'Jefe de Capital Humano',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CH-04'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CH-05  Inducción al Personal de Nuevo Ingreso ─────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Comprender el funcionamiento general de la organización, cómo contribuirán las responsabilidades del personal de nuevo ingreso en el cumplimiento de la misión del establecimiento y en el área o servicio a donde es asignado.',

'Este proceso inicia cuando un nuevo elemento de la plantilla entrega la totalidad de sus documentos y es su primer día laborando en la institución o bien cuando el personal es reasignado a un área o servicio en donde nunca han laborado.',

'[{"termino":"Candidato","definicion":"Es la persona que participa en un proceso de reclutamiento y selección, presentando sus datos, experiencia y habilidades con el fin de ser considerado para ocupar un puesto dentro de la organización."},{"termino":"Inducción a la empresa","definicion":"Proceso de bienvenida, orientación e integración de los nuevos empleados, brindándoles información y apoyo para adaptarse a su nuevo puesto y al entorno laboral."},{"termino":"Capacitación","definicion":"Conjunto de actividades didácticas organizadas y sistemáticas para desarrollar, complementar o perfeccionar los conocimientos, habilidades y aptitudes de los trabajadores, con el fin de mejorar su desempeño y eficiencia laboral para alcanzar los objetivos de una organización"},{"termino":"Contrato","definicion":"Acuerdo legalmente vinculante entre dos o más partes, ya sean personas o entidades, en el que se establecen obligaciones y derechos de forma voluntaria."}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Jefatura de departamento de Capital Humano."},{"tipo":"4.2 Ejecución","descripcion":"Departamento de Capital Humano, así como los coordinadores de los distintos departamentos."},{"tipo":"4.3 Supervisión","descripcion":"Dirección general"}]'::jsonb,

'[{"no":"5.1","responsable":"Capital humano","actividad":"Cita al colaborador nuevo o reasignado a la inducción dándole lugar, fecha y hora."},{"no":"5.2","responsable":"Capital humano","actividad":"Entrega de contratos y gafetes a cada uno de los colaboradores de nuevo ingreso"},{"no":"5.3","responsable":"Capital Humano","actividad":"Imparte la inducción a la empresa (Véase presentación PDF de inducción al personal clínico y no clínico)"},{"no":"5.4","responsable":"Capital Humano","actividad":"Entrega a los asistentes (colaboradores, subrogados y/o voluntarios) una lista de asistencia que deben firmar FT-CH-48"},{"no":"5.5","responsable":"Capital Humano","actividad":"Entrega de formato de evidencia de capacitación a todos los colaboradores FT-CH-25"},{"no":"5.6","responsable":"Seguridad e higiene","actividad":"Imparte recorrido por el hospital explicando cada una de las áreas donde se tendrá que laborar."},{"no":"5.7","responsable":"Jefes de departamento","actividad":"Comienza inducción al área"},{"no":"5.8","responsable":"Capital Humano","actividad":"Recaba formatos de evidencia de capacitación contestados"},{"no":"5.9","responsable":"Capital Humano","actividad":"Entrega formato de política de uniformes PL-CH-02 y se entregan uniformes al personal."},{"no":"5.10","responsable":"Capital Humano","actividad":"Registra a cada uno de los colaboradores en reloj checador."},{"no":"5.11","responsable":"Capital Humano","actividad":"Informa al personal sobre su día de descanso y área de trabajo."},{"no":"5.12","responsable":"Capital Humano","actividad":"Finaliza el proceso."}]'::jsonb,

'[{"riesgo":"No otorgar inducción por ausencia del colaborador de nuevo ingreso","barrera":"Avisar con tiempo al nuevo colaborador su fecha asignada."},{"riesgo":"No dar la información precisa y detallada de manera verbal al momento de impartir la capacitación","barrera":"Se detallan las políticas y reglamentos por cada una de las áreas que imparten su inducción."},{"riesgo":"Personal de nuevo ingreso que no encuentre su área de trabajo","barrera":"Impartir recorrido explicando las áreas para laborar"}]'::jsonb,

'[{"nombre":"Lista de asistencia","codigo":"FT-CH-48"},{"nombre":"Políticas de uniformes","codigo":"PL-CH-02"},{"nombre":"Evidencia de Capacitación","codigo":"FT-CH-25"}]'::jsonb,

'[{"version":"1","fecha":"01/12/2020","descripcion":"Actualización de documentos","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Dr. José Gonzalo Vázquez Camacho"},{"version":"2","fecha":"15/02/2021","descripcion":"Modificación de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"08/03/2022","descripcion":"Modificación de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"4","fecha":"19/06/2024","descripcion":"Modificación de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"5","fecha":"29/09/2025","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramirez Chavez","aprobado":"Dra. Giselle Ivette De la torre Garcia"}]'::jsonb,

'Lic. Jorge Octavio Ramírez Chávez', 'Jefe de Capital Humano',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CH-05'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CH-06  Solicitud de Permiso y Vacaciones ───────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Establecer claramente los pasos a seguir una vez que el colaborador solicite a su jefe inmediato algún tipo de permiso con los que cuenta la institución.',

'Este proceso inicia cuando un colaborador solicita a su jefe inmediato algún permiso, y finaliza una vez que se autoriza o no el permiso.',

'[{"termino":"Colaborador","definicion":"Persona que ha aceptado ser empleada para trabajar por alguna forma de pago bajo un contrato de trabajo."},{"termino":"Permiso","definicion":"Documento estructurado que se utiliza para solicitar formalmente la autorización de una persona o entidad para realizar una acción o ausentarse temporalmente, detallando la información del solicitante, el motivo, las fechas y las firmas necesarias para su aprobación."}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Departamento de Capital Humano."},{"tipo":"4.2 Ejecución","descripcion":"Departamento de Capital Humano, y colaboradores de las distintas áreas."},{"tipo":"4.3 Supervisión","descripcion":"Dirección administrativa"}]'::jsonb,

'[{"no":"5.1","responsable":"Colaborador","actividad":"Solicita a su jefe inmediato la gestión del permiso o vacaciones."},{"no":"5.2","responsable":"Colaborador","actividad":"Llena formato FT-CH-01 o FT-CH-40 (Solicitud de permiso o vacaciones) con datos completos y entrega a su jefe inmediato para su autorización."},{"no":"5.3","responsable":"Jefe inmediato","actividad":"Valora la solicitud. Autoriza o no el permiso. Firma el formato en el apartado de Nombre y Firma del Jefe de Departamento y entrega el formato firmado al colaborador. Nota: De no ser autorizado, finaliza el proceso."},{"no":"5.4","responsable":"Colaborador","actividad":"Presenta el formato autorizado por su jefe y, en caso de aplicar, por dirección administrativa al departamento de Capital Humano. Nota: Toda solicitud de Falta con goce de sueldo, el colaborador gestionará la firma con Dirección Administrativa."},{"no":"5.5","responsable":"Capital Humano","actividad":"Recibe el formato y se encarga de capturar la incidencia. Firma de recibido el formato original y entrega copia a C.H."},{"no":"5.6","responsable":"Capital Humano","actividad":"Resguarda el formato en el expediente del colaborador que lo solicitó."},{"no":"5.7","responsable":"Colaborador","actividad":"Disfruta de su permiso."}]'::jsonb,

'[{"riesgo":"El colaborador entrega el permiso al departamento de C.H fuera del tiempo establecido.","barrera":"Colocar Memorándum firmado en el área de checador, con la finalidad de que cada colaborador conozca la importancia y consecuencias de solicitar permisos fuera del tiempo establecido."}]'::jsonb,

'[{"nombre":"Solicitud de permiso","codigo":"FT-CH-01"},{"nombre":"Solicitud de vacaciones","codigo":"FT-CH-40"}]'::jsonb,

'[{"version":"1","fecha":"01/12/2020","descripcion":"Actualización de documentos","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Dr. José Gonzalo Vázquez Camacho"},{"version":"2","fecha":"15/02/2021","descripcion":"Modificación de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"08/03/2022","descripcion":"Modificación de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"4","fecha":"19/06/2024","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramírez Chávez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"5","fecha":"29/09/2025","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramirez Chavez","aprobado":"Mtra. Giselle Ivette De la torre Garcia"}]'::jsonb,

'Lic. Jorge Octavio Ramírez Chávez', 'Jefe de Capital Humano',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CH-06'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CH-07  Cuestionarios NOM-035 ──────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Aplicar de manera sistematizada los cuestionarios de la NOM-035-STPS-2018 "Factores de riesgo psicosocial en el trabajo: identificación, análisis y prevención", en todo el personal.',

'Se socializa la NOM-035 y termina en la aplicación de cuestionarios a todo el personal',

'[{"termino":"NOM-035-STPS-2018","definicion":"Norma Oficial Mexicana emitida por la Secretaría del Trabajo y Previsión Social (STPS) en México, cuyo objetivo es establecer los elementos para identificar, analizar y prevenir los factores de riesgo psicosocial en el trabajo."},{"termino":"Colaborador","definicion":"Persona que presta sus servicios a cambio de un salario en una relación de subordinación y dependencia."},{"termino":"Cuestionario","definicion":"Herramienta para identificar y analizar factores de riesgo psicosocial en el trabajo, como el estrés, la violencia laboral o la falta de control"}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Jefatura del departamento de Capital Humano"},{"tipo":"4.2 Ejecución","descripcion":"Departamento de Capital Humano, jefes de área y colaboradores"},{"tipo":"4.3 Supervisión","descripcion":"Jefatura de Calidad y dirección general."}]'::jsonb,

'[{"no":"5.1","responsable":"Jefatura de Capital Humano","actividad":"Socialización de la norma NOM-035-STPS-2018 Factores de riesgo psicosocial en el trabajo: identificación, análisis y prevención."},{"no":"5.2","responsable":"Jefes de Área","actividad":"Programar a sus equipos de trabajo sobre el día y el tiempo en el que estarán ocupados contestando el cuestionario."},{"no":"5.3","responsable":"Capital Humano","actividad":"Preparar salón de usos múltiples para dinámica de cuestionarios."},{"no":"5.4","responsable":"Colaboradores","actividad":"Presentarse, de acuerdo con lo programado, para contestar cuestionarios de la norma"},{"no":"5.5","responsable":"Capital Humano","actividad":"Reunir cuestionarios resueltos."},{"no":"5.6","responsable":"Capital Humano","actividad":"Vaciar la información"},{"no":"5.7","responsable":"Jefatura de Capital Humano","actividad":"Evaluar los resultados"},{"no":"5.8","responsable":"Jefatura de Capital Humano","actividad":"Termina el proceso"}]'::jsonb,

'[{"riesgo":"Los colaboradores no creen en el proceso y se rehúsan a contestar los cuestionarios.","barrera":"Planificar la socialización de la norma para que los colaboradores la conozcan."},{"riesgo":"Colaboradores que no se presenten a la dinámica de cuestionario por temor a perder tiempo de trabajo","barrera":"Aplicarlos en el menor tiempo posible"}]'::jsonb,

'[{"nombre":"NOM-035-STPS-2018 Factores de riesgo psicosocial en el trabajo: identificación, análisis y prevención","codigo":"N/A"}]'::jsonb,

'[{"version":"1","fecha":"15/01/2019","descripcion":"Alta de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Dr. José Gonzalo Vázquez Camacho"},{"version":"2","fecha":"15/01/2021","descripcion":"Modificación de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"11/03/2022","descripcion":"Modificación de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"4","fecha":"03/06/2024","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramírez Chávez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"5","fecha":"29/09/2025","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramirez Chavez","aprobado":"Dra. Giselle Ivette De la torre Garcia"}]'::jsonb,

'Lic. Jorge Octavio Ramírez Chávez', 'Jefe de Capital Humano',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CH-07'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CH-08  Capacitación ────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Elaborar un programa de capacitación del personal y determinar cuáles miembros de la organización deben recibir capacitación continua para mantener sus competencias.',

'Aplica a todas las áreas y servicios del hospital para personal de base y de nuevo ingreso',

'[{"termino":"Capacitación","definicion":"Conjunto de actividades didácticas organizadas y sistemáticas para desarrollar, complementar o perfeccionar los conocimientos, habilidades y aptitudes de los trabajadores, con el fin de mejorar su desempeño y eficiencia laboral para alcanzar los objetivos de una organización."},{"termino":"Comité de capacitación","definicion":"Organismo compuesto por representantes de trabajadores y empleadores o de diferentes áreas y niveles de la organización cuya función es diseñar, implementar, evaluar y asegurar que los programas de capacitación se alineen con los objetivos estratégicos de la empresa, con el fin de desarrollar las competencias laborales, mejorar la productividad y la calidad del empleo."},{"termino":"Presupuesto","definicion":"Conjunto de recursos económicos necesarios para planificar, ejecutar y evaluar los programas de formación de los empleados de una organización."}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Departamento de Capital Humano"},{"tipo":"4.2 Ejecución","descripcion":"Departamento de Capital Humano, Dirección administrativa"},{"tipo":"4.3 Supervisión","descripcion":"Calidad"}]'::jsonb,

'[{"no":"5.1","responsable":"Capital Humano","actividad":"Crear formatos de Detección de Necesidades de Capacitación (DNC)(FT-CH-34) y Evaluación de la capacitación"},{"no":"5.2","responsable":"Jefatura de área","actividad":"Realizan el DNC de sus áreas"},{"no":"5.3","responsable":"Capital humano","actividad":"Crear el comité de Capacitación"},{"no":"5.4","responsable":"Capital Humano","actividad":"Convocar a sesión de Comité de Capacitación"},{"no":"5.5","responsable":"Capital Humano","actividad":"Recabar información de DNC (monitorización de procesos, supervisión de los sistemas críticos, evaluaciones de desempeño, notificación y análisis de eventos adversos, centinela y cuasi fallas relacionadas con la prevención y control de infecciones, así como de la atención clínica y no clínica, accidentes de trabajo)"},{"no":"5.6","responsable":"Capital Humano","actividad":"Crear programa anual de capacitación, considerando los hallazgos, patrones y tendencias provenientes de las actividades de supervisión y monitorización"},{"no":"5.7a","responsable":"Jefatura de áreas","actividad":"Sesionan el comité y llegan a acuerdos sobre las capacitaciones"},{"no":"5.7b","responsable":"Dirección Administrativa","actividad":"Analizar y aprobar presupuesto de capacitación"},{"no":"5.8","responsable":"Capital Humano","actividad":"Coordinar tiempos, fechas y horas de capacitaciones internas y externas"},{"no":"5.9","responsable":"Capital Humano","actividad":"Evaluar capacitaciones internas y externas"},{"no":"5.10","responsable":"Capital Humano","actividad":"Realizar reporte de capacitaciones de manera bimestral"}]'::jsonb,

'[{"riesgo":"No tener presupuesto otorgado para el área de capacitación","barrera":"Sesionar comité de capacitación para planificación correcta"},{"riesgo":"Resistencia de colaboradores asistir a las capacitaciones","barrera":"Coordinar tiempos, fechas y horas de las capacitaciones de manera que no interfiera con las actividades del colaborador"},{"riesgo":"Ingreso de capacitadores sin los filtros adecuados","barrera":"Coordinar y evaluar las capacitaciones internas y externas"}]'::jsonb,

'[{"nombre":"Detección de necesidades de capacitación","codigo":"FT-CH-34"}]'::jsonb,

'[{"version":"1","fecha":"21/09/2021","descripcion":"Alta de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"2","fecha":"11/03/2022","descripcion":"Modificación de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"03/06/2024","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramírez Chávez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"4","fecha":"29/09/2025","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramirez Chavez","aprobado":"Dra. Giselle Ivette De la Torre Garcia"}]'::jsonb,

'Lic. Jorge Octavio Ramírez Chávez', 'Jefe de Capital Humano',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CH-08'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CH-09  Evaluación de Desempeño ────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Realizar la evaluación al desempeño de manera estandarizada y sistemática. A su vez definir la forma y la frecuencia de la evaluación permanente y así asegurar que la capacitación se realice cuando se necesite y que el personal pueda asumir responsabilidades nuevas o diferentes.',

'Aplica a todos los colaboradores del hospital y esta se realizará una vez al año.',

'[{"termino":"Evaluación de desempeño","definicion":"Proceso sistemático y colaborativo donde se mide el rendimiento laboral de un empleado a través de criterios predefinidos, con el fin de mejorar su desarrollo profesional, identificar áreas de oportunidad y potenciar la consecución de los objetivos empresariales."},{"termino":"Indicadores","definicion":"Métricas cuantitativas que permiten medir y evaluar de forma objetiva el rendimiento de un área, proceso, proyecto, o incluso de la organización en su conjunto, respecto al logro de sus objetivos estratégicos"}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Jefe de capital humano."},{"tipo":"4.2 Ejecución","descripcion":"Personal de reclutamiento, Jefes o encargados de área, Analista de capital humano, Jefe de capital humano y Directora General."},{"tipo":"4.3 Supervisión","descripcion":"Directora General."}]'::jsonb,

'[{"no":"5.1","responsable":"Personal de reclutamiento","actividad":"Revisa mensualmente las fechas de ingreso de los colaboradores que cumplen un año o múltiplos de este."},{"no":"5.2","responsable":"Personal de reclutamiento","actividad":"Genera una lista del personal a evaluar en el mes de su ingreso y notifica a los jefes inmediatos."},{"no":"5.3","responsable":"Jefes o encargados de área","actividad":"Realiza las evaluaciones de desempeño y brinda retroalimentación al colaborador. Al finalizar envía la información de las evaluaciones con firmas a capital humano."},{"no":"5.4","responsable":"Analista de capital humano","actividad":"Consolida los resultados de las evaluaciones de desempeño."},{"no":"5.5","responsable":"Jefe de capital humano","actividad":"Entrega un informe trimestral a dirección de las evaluaciones de los colaboradores"},{"no":"5.6","responsable":"Jefe de capital humano y Jefes o encargados de área","actividad":"Realizan un plan de vida y carrera con su personal para el desarrollo constante."},{"no":"5.7","responsable":"Directora General","actividad":"Recibe la información de los diferentes áreas y servicios hospitalarios"}]'::jsonb,

'[{"riesgo":"El jefe inmediato puede basarse en percepciones personales y no en evidencias objetivas.","barrera":"Indicaciones claras y precisas, revisión objetiva."},{"riesgo":"No aplicar la evaluación en la fecha programada por carga laboral del hospital.","barrera":"Seguimiento por parte del área de capital humano para su realización."},{"riesgo":"Desconocimiento de cómo aplicar el formato o dar retroalimentación adecuada.","barrera":"Registro de evaluadores capacitados y seguimiento de consistencia."}]'::jsonb,

'[{"nombre":"Formato de evaluación de desempeño","codigo":"FT-CH-47"}]'::jsonb,

'[{"version":"1","fecha":"21/09/2021","descripcion":"Alta de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"2","fecha":"11/03/2022","descripcion":"Modificación de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"04/07/2024","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramírez Chávez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"4","fecha":"08/08/2025","descripcion":"Actualización del formato y proceso.","realizado":"Lic. Jorge Octavio Ramirez Chávez","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Lic. Jorge Octavio Ramírez Chávez', 'Jefe de Capital Humano',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CH-09'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-CH-10  Evaluación de Clima Laboral ────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Realizar la evaluación de la calidad de clima laboral que se vive dentro de la organización, con el fin de crear estrategias de mejora.',

'Aplica a todas las áreas y servicios del hospital. Se realizará una vez al año.',

'[]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Jefatura de Capital Humano"},{"tipo":"4.2 Ejecución","descripcion":"Capital Humano"},{"tipo":"4.3 Supervisión","descripcion":"Dirección general"}]'::jsonb,

'[{"no":"5.1","responsable":"Capital Humano","actividad":"Cotiza o busca plataforma de aplicación de cuestionarios."},{"no":"5.2","responsable":"Capital Humano","actividad":"Envía correos y oficio de aplicación de encuesta de clima laboral a toda la organización."},{"no":"5.5","responsable":"Capital Humano","actividad":"Envía encuesta de clima laboral FT-CH-49."},{"no":"5.6","responsable":"Colaboradores / Capital Humano","actividad":"Colaboradores aplican encuestas y Capital Humano da seguimiento de respuestas con jefaturas y coordinaciones (plazo de 15 días)."},{"no":"5.7","responsable":"Capital Humano","actividad":"Descarga reporte de respuestas."},{"no":"5.8","responsable":"Capital Humano","actividad":"Presenta reporte de respuestas a Dirección General."},{"no":"5.9","responsable":"Dirección General","actividad":"Toma decisiones y crea estrategias para la mejora del clima organizacional."}]'::jsonb,

'[{"riesgo":"Falta de interés del personal o sesgo en las respuestas.","barrera":"Asesoramiento de Capital Humano y capacitación al personal sobre la importancia de su participación y el anonimato de la encuesta."}]'::jsonb,

'[{"nombre":"Encuesta de clima laboral","codigo":"FT-CH-49"}]'::jsonb,

'[{"version":"1","fecha":"21/09/2021","descripcion":"Alta de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"2","fecha":"11/03/2022","descripcion":"Modificación de documento","realizado":"Lic. Melisa Jiménez Castellanos","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"29/09/2025","descripcion":"Modificación de documento","realizado":"Lic. Jorge Octavio Ramirez Chavez","aprobado":"Dra. Giselle Ivette De la Torre Garcia"}]'::jsonb,

'Lic. Jorge Octavio Ramírez Chávez', 'Jefe de Capital Humano',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'

FROM documents d WHERE d.code = 'PR-CH-10'
ON CONFLICT (document_id) DO NOTHING;

-- ── Verificación final ────────────────────────────────────────
SELECT d.code, d.current_version AS ver,
       CASE WHEN dc.id IS NOT NULL THEN 'Con contenido ✓' ELSE 'Sin contenido' END AS contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code LIKE 'PR-CH-%'
ORDER BY d.code;
