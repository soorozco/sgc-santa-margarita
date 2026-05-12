-- ============================================================
--  REHABILITACIÓN — Vista digital de 4 Procedimientos
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar DESPUÉS de rehabilitacion_docs.sql
--
--  Bloque de autorización común:
--    Elaboró:  Dra. Fernanda Toro Sashida       / Jefa de Rehabilitación
--    Revisó:   Dra. Giselle Ivette De la Torre  / Jefa de Calidad
--    Autorizó: Dr. José Gonzalo Vázquez Camacho / Director Médico
--
--  Control de cambios idéntico en los 4 documentos:
--    v01 16/11/2018 — Alta (Tec. Elizabeth Madrid Maciel / Dra. Fernanda Toro Sashida)
--    v02 20/01/2023 — Modificación
--    v03 23/09/2025 — Actualización del formato
-- ============================================================

-- ── PR-RE-01  Electroterapia ──────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Prever, entrenar y tratar los músculos, tendones, ligamentos y nervios, buscando una finalidad terapéutica de relajación, desinflación y fortalecimiento.',

'Este documento aplica para todos los pacientes usuarios del servicio de rehabilitación y terapia física, externos e internos. Inicia cuando el paciente ingresa al área de rehabilitación y se procede a la identificación del mismo y termina una vez que el paciente concluye el tratamiento indicado.',

'[{"termino":"Electroterapia","definicion":"Es un tratamiento de fisioterapia que utiliza corrientes eléctricas para estimular diversas áreas del cuerpo con fines terapéuticos."},{"termino":"Electroestimulador","definicion":"Aparato que utiliza impulsos eléctricos controlados para contraer músculos y estimular nervios."},{"termino":"Corriente","definicion":"Flujo de partículas con carga eléctrica (generalmente electrones) a través de un material conductor."}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Enfermería de rehabilitación"},{"tipo":"4.2 Ejecución","descripcion":"Enfermería de rehabilitación"},{"tipo":"4.3 Supervisión","descripcion":"Dirección médica"}]'::jsonb,

'[{"no":"5.1","responsable":"Médico","actividad":"Elaboración de expediente clínico."},{"no":"5.2","responsable":"Médico","actividad":"Valoración al paciente e indicación del tratamiento."},{"no":"5.3","responsable":"Médico","actividad":"Explicación del tratamiento (consiste en duración, posibles eventos adversos y vestimenta)."},{"no":"5.4","responsable":"Médico","actividad":"Deriva el paciente a la enfermería."},{"no":"5.5","responsable":"Personal de Enfermería de Rehabilitación","actividad":"Recibe al paciente y procede a la identificación correcta por medio del Nombre, Edad y Fecha de nacimiento."},{"no":"5.6","responsable":"Personal de Enfermería de Rehabilitación","actividad":"Verificación del diagnóstico e indicaciones."},{"no":"5.7","responsable":"Personal de Enfermería de Rehabilitación","actividad":"Preparación del cubículo con el equipo indicado, como también brindarle bata de hospital."},{"no":"5.8","responsable":"Personal de Enfermería de Rehabilitación","actividad":"Aplicación del tratamiento explicando al paciente la sensación y efectos que se pudieran suscitar."},{"no":"5.9","responsable":"Personal de Enfermería de Rehabilitación","actividad":"Monitorización continua al paciente por si hubiese alguna incomodidad o reacción durante el tratamiento."},{"no":"5.10","responsable":"Personal de Enfermería de Rehabilitación","actividad":"Una vez concluida la aplicación de los aparatos de electro estímulo se indica al usuario que ya se puede vestir e incorporar."},{"no":"5.11","responsable":"Personal de Enfermería de Rehabilitación","actividad":"Se agenda la próxima cita."}]'::jsonb,

'[{"riesgo":"Paciente incorrecto.","barrera":"Identificación correcta del paciente por medio de Nombre, edad y fecha de nacimiento."},{"riesgo":"Tratamiento incorrecto.","barrera":"Verificación de indicaciones y tratamientos."},{"riesgo":"Quemaduras por tipo de corrientes.","barrera":"Revisión constante en aplicación de electro estímulos."},{"riesgo":"Contracción muscular por frecuencia alta.","barrera":"Nivelar la frecuencia del electroestimulador, evitando que llegue a niveles altos."},{"riesgo":"Dudas del paciente en cuanto a tratamiento y reacciones al mismo.","barrera":"Explicación al paciente del tratamiento y de posibles reacciones musculares."}]'::jsonb,

'[{"nombre":"Norma oficial mexicana NOM-004-SSA3-2012, del expediente clínico","codigo":"No Aplica"}]'::jsonb,

'[{"version":"01","fecha":"16/11/2018","descripcion":"Alta de documento","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"},{"version":"02","fecha":"20/01/2023","descripcion":"Modificación del documento","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"},{"version":"03","fecha":"23/09/2025","descripcion":"Actualización del formato","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"}]'::jsonb,

'Dra. Fernanda Toro Sashida', 'Jefa de Rehabilitación',
'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
'Dr. José Gonzalo Vázquez Camacho', 'Director Médico'

FROM documents d WHERE d.code = 'PR-RE-01'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-RE-02  Mecanoterapia ───────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Es aumentar la resistencia al trabajar un músculo o incluso reducirla de manera que puedan realizar movilizaciones pasivas o auto-pasivas.',

'Este documento aplica para todos los pacientes usuarios del servicio de rehabilitación y terapia física, externos e internos. Inicia cuando el paciente ingresa al área de rehabilitación y se procede a la identificación del mismo y termina una vez que el paciente se le enseña su rutina de ejercicios.',

'[{"termino":"Mecanoterapia","definicion":"Técnica de rehabilitación que usa aparatos mecánicos para realizar ejercicios que mejoran la fuerza muscular, la movilidad articular y el equilibrio."},{"termino":"Ejercicio","definicion":"Cualquier actividad física que involucre el movimiento del cuerpo con el objetivo de mejorar o mantener la condición física y la salud general."},{"termino":"Lesión","definicion":"Daño o alteración anormal que se produce en un tejido u órgano del cuerpo, causado por un trauma físico (como un golpe, corte o caída), una enfermedad, o el esfuerzo repetitivo."}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Enfermería de rehabilitación"},{"tipo":"4.2 Ejecución","descripcion":"Enfermería de rehabilitación"},{"tipo":"4.3 Supervisión","descripcion":"Dirección médica"}]'::jsonb,

'[{"no":"5.1","responsable":"Médico","actividad":"Elaboración de expediente."},{"no":"5.2","responsable":"Médico","actividad":"Valoración al paciente e indicación del tratamiento."},{"no":"5.3","responsable":"Médico","actividad":"Explicación del tratamiento (consiste en duración, posibles eventos adversos y vestimenta)."},{"no":"5.4","responsable":"Médico","actividad":"Deriva el paciente a la enfermería."},{"no":"5.5","responsable":"Enfermería de rehabilitación","actividad":"Recibe al paciente y procede a la identificación correcta por medio del Nombre, Edad y Fecha de nacimiento."},{"no":"5.6","responsable":"Enfermería de rehabilitación","actividad":"Verificación del diagnóstico e indicaciones."},{"no":"5.7","responsable":"Enfermería de rehabilitación","actividad":"Preparación del cubículo con el equipo indicado (bicicleta, poleas, escaladora, barras paralelas, rampa, timones, colchonetas)."},{"no":"5.8","responsable":"Enfermería de rehabilitación","actividad":"Aplicación del tratamiento enseñando al paciente las rutinas que debe seguir pidiendo que informe en caso de existir alguna sensación de dolor o efectos que se pudieran suscitar."},{"no":"5.9","responsable":"Enfermería de rehabilitación","actividad":"Monitorización continua al paciente durante la realización de los ejercicios revisando que se ejecuten correctamente."},{"no":"5.10","responsable":"Enfermería de rehabilitación","actividad":"Una vez concluida la sesión indica al usuario que ya se puede vestir e incorporar."}]'::jsonb,

'[{"riesgo":"Paciente incorrecto.","barrera":"Identificación correcta del paciente por medio de Nombre, edad y fecha de nacimiento."},{"riesgo":"Tratamiento incorrecto.","barrera":"Revisión constante al realizar los ejercicios."},{"riesgo":"Lesiones por la mala ejecución del ejercicio.","barrera":"Enseñar al paciente y familiar la manera de realizar los ejercicios en casa."}]'::jsonb,

'[{"nombre":"Norma oficial mexicana NOM-004-SSA3-2012, del expediente clínico","codigo":"No Aplica"}]'::jsonb,

'[{"version":"01","fecha":"16/11/2018","descripcion":"Alta de documento","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"},{"version":"02","fecha":"20/01/2023","descripcion":"Modificación del documento","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"},{"version":"03","fecha":"23/09/2025","descripcion":"Actualización del formato","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"}]'::jsonb,

'Dra. Fernanda Toro Sashida', 'Jefa de Rehabilitación',
'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
'Dr. José Gonzalo Vázquez Camacho', 'Director Médico'

FROM documents d WHERE d.code = 'PR-RE-02'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-RE-03  Terapia Ocupacional ─────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Es ayudar al paciente a mejorar su autonomía en las tareas de la vida diaria, asistiendo y apoyando su desarrollo hacia una vida independiente, satisfecha y productiva por medio de actividades que ayudarán a desarrollar sus actividades funcionales, motoras y sensitivas.',

'Inicia cuando el paciente ingresa al área de terapia ocupacional y procede a la identificación del mismo, terminando cuando el paciente concluye el tratamiento.',

'[{"termino":"Sensitiva","definicion":"Experiencia que involucra y estimula uno o más de los sentidos del cuerpo, principalmente la vista, el oído, el tacto, el olfato y el gusto, aunque también pueden incluirse el equilibrio (vestibular) y la conciencia del cuerpo (propiocepción)."},{"termino":"Motora","definicion":"Capacidad del cuerpo para realizar y controlar movimientos, ya sean voluntarios (planificados) o involuntarios (automáticos)."}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Enfermería de rehabilitación"},{"tipo":"4.2 Ejecución","descripcion":"Enfermería de rehabilitación"},{"tipo":"4.3 Supervisión","descripcion":"Dirección médica"}]'::jsonb,

'[{"no":"5.1","responsable":"Médico","actividad":"Elaboración de expediente clínico."},{"no":"5.2","responsable":"Médico","actividad":"Valoración al paciente e indicación del tratamiento."},{"no":"5.3","responsable":"Médico","actividad":"Explicación del tratamiento (consiste en duración, posibles eventos adversos y vestimenta)."},{"no":"5.4","responsable":"Médico","actividad":"Deriva al paciente a enfermería."},{"no":"5.5","responsable":"Enfermería de rehabilitación","actividad":"Recibe al paciente y procede a la identificación correcta por medio del Nombre, Edad y Fecha de nacimiento."},{"no":"5.6","responsable":"Enfermería de rehabilitación","actividad":"Verificación del diagnóstico e indicaciones."},{"no":"5.7","responsable":"Enfermería de rehabilitación","actividad":"Preparación del cubículo con el equipo indicado (depende de la patología se analiza cuál será el material a trabajar como: rompecabezas, plastilina, dominó, texturas, figuras armables, detección de colores, crucigramas, ejercicios de lenguaje, etc.)."},{"no":"5.8","responsable":"Enfermería de rehabilitación","actividad":"Aplicación del tratamiento enseñando al paciente las rutinas que debe seguir."},{"no":"5.9","responsable":"Enfermería de rehabilitación","actividad":"Monitorización continua al paciente durante la realización de los ejercicios revisando que se ejecuten correctamente."},{"no":"5.10","responsable":"Enfermería de rehabilitación","actividad":"Enseñanza a usuario y familiares de ejercicios que deberán realizar en sus domicilios."},{"no":"5.11","responsable":"Enfermería de rehabilitación","actividad":"Revaloración al término de las sesiones programadas y se agenda la próxima cita en caso de continuar con el tratamiento."}]'::jsonb,

'[{"riesgo":"Paciente incorrecto.","barrera":"Identificación correcta del paciente por medio de Nombre, edad y fecha de nacimiento."},{"riesgo":"Tratamiento incorrecto.","barrera":"Verificación de indicaciones y tratamientos."},{"riesgo":"Realizar mal alguna actividad.","barrera":"Monitorear las actividades asignadas enseñando a los pacientes y familiares."}]'::jsonb,

'[{"nombre":"Norma oficial mexicana NOM-004-SSA3-2012, del expediente clínico","codigo":"No Aplica"}]'::jsonb,

'[{"version":"01","fecha":"16/11/2018","descripcion":"Alta de documento","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"},{"version":"02","fecha":"20/01/2023","descripcion":"Modificación del documento","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"},{"version":"03","fecha":"23/09/2025","descripcion":"Actualización del formato","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"}]'::jsonb,

'Dra. Fernanda Toro Sashida', 'Jefa de Rehabilitación',
'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
'Dr. José Gonzalo Vázquez Camacho', 'Director Médico'

FROM documents d WHERE d.code = 'PR-RE-03'
ON CONFLICT (document_id) DO NOTHING;

-- ── PR-RE-04  Hidroterapia ────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Ayudar al paciente a su relajación, así como tratamiento desinflamatorio y mover adherencias mejorando la funcionalidad y habilidades motrices.',

'Inicia cuando el paciente ingresa al área de rehabilitación y se procede a la identificación del mismo concluyendo con el término del tratamiento.',

'[{"termino":"Hidroterapia","definicion":"Es el uso del agua, en sus diferentes temperaturas y formas (líquido, vapor, hielo), como agente terapéutico para prevenir, tratar o aliviar enfermedades, lesiones y dolores."},{"termino":"Tina","definicion":"Equipo utilizado en fisioterapia y rehabilitación para sumergir parcial o totalmente el cuerpo en agua, frecuentemente caliente y a veces con chorros o remolinos."}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Enfermería de rehabilitación"},{"tipo":"4.2 Ejecución","descripcion":"Enfermería de rehabilitación"},{"tipo":"4.3 Supervisión","descripcion":"Dirección médica"}]'::jsonb,

'[{"no":"5.1","responsable":"Médico","actividad":"Elaboración de expediente clínico e indicación del tratamiento."},{"no":"5.2","responsable":"Médico","actividad":"Valoración al paciente e indicación del tratamiento."},{"no":"5.3","responsable":"Médico","actividad":"Explicación del tratamiento (consiste en duración, posibles eventos adversos y vestimenta)."},{"no":"5.4","responsable":"Médico","actividad":"Deriva el paciente a enfermería de rehabilitación."},{"no":"5.5","responsable":"Enfermería de rehabilitación","actividad":"Recibe al paciente y procede a la identificación correcta por medio del Nombre, Edad y Fecha de nacimiento."},{"no":"5.6","responsable":"Enfermería de rehabilitación","actividad":"Verificación del diagnóstico e indicaciones."},{"no":"5.7","responsable":"Enfermería de rehabilitación","actividad":"Preparación de las tinas con las que se llevará a cabo el tratamiento ya sean para miembros superiores o inferiores, así como de cuerpo completo."},{"no":"5.8","responsable":"Enfermería de rehabilitación","actividad":"Traslada al paciente en la grúa. Nota: Solo para pacientes que se les complica el traslado."},{"no":"5.9","responsable":"Enfermería de rehabilitación","actividad":"Se deja al paciente 20 minutos explicando el tratamiento y los efectos que se pudieran suscitar. Nota: dentro de los veinte minutos en la tina se le indicará al paciente los momentos en que tendrá que cambiar de posición."},{"no":"5.10","responsable":"Enfermería de rehabilitación","actividad":"Aplicación del tratamiento enseñando al paciente las rutinas que debe seguir."},{"no":"5.11","responsable":"Enfermería de rehabilitación","actividad":"Monitorización continua al paciente durante la realización de los ejercicios revisando que se ejecuten correctamente."},{"no":"5.12","responsable":"Enfermería de rehabilitación","actividad":"Enseñanza a usuario y familiares de ejercicios que deberán realizar en sus domicilios."},{"no":"5.13","responsable":"Médico de rehabilitación","actividad":"Revaloración al término de las sesiones programadas y se agenda la próxima cita en caso de continuar con el tratamiento."}]'::jsonb,

'[{"riesgo":"Paciente incorrecto.","barrera":"Identificación correcta del paciente por medio de Nombre, edad y fecha de nacimiento."},{"riesgo":"Tratamiento incorrecto.","barrera":"Verificación de indicaciones y tratamientos."},{"riesgo":"Tomar las medidas adecuadas para evitar una caída por piso mojado.","barrera":"Evitar riesgo de caídas utilizando franjas antiderrapantes y señalamientos de piso mojado."},{"riesgo":"Olvidar pacientes en las tinas.","barrera":"Vigilancia constante al tiempo de la ejecución del tratamiento."}]'::jsonb,

'[{"nombre":"Norma oficial mexicana NOM-004-SSA3-2012, del expediente clínico","codigo":"No Aplica"}]'::jsonb,

'[{"version":"01","fecha":"16/11/2018","descripcion":"Alta de documento","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"},{"version":"02","fecha":"20/01/2023","descripcion":"Modificación del documento","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"},{"version":"03","fecha":"23/09/2025","descripcion":"Actualización del formato","realizado":"Tec. Elizabeth Madrid Maciel","aprobado":"Dra. Fernanda Toro Sashida"}]'::jsonb,

'Dra. Fernanda Toro Sashida', 'Jefa de Rehabilitación',
'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
'Dr. José Gonzalo Vázquez Camacho', 'Director Médico'

FROM documents d WHERE d.code = 'PR-RE-04'
ON CONFLICT (document_id) DO NOTHING;

-- ── Verificación final ────────────────────────────────────────
SELECT d.code, d.current_version AS ver,
       CASE WHEN dc.id IS NOT NULL THEN 'Con contenido ✓' ELSE 'Sin contenido' END AS contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code LIKE 'PR-RE-%'
ORDER BY d.code;
