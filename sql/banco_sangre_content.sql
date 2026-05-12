-- ============================================================
--  BANCO DE SANGRE — Contenido de 19 Instrucciones de Trabajo
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar DESPUÉS de banco_sangre_docs.sql
--  en Supabase → SQL Editor
--
--  GRANT ALL ON document_content TO anon, authenticated;
-- ============================================================

-- ── IT-BS-02 · Fraccionamiento ────────────────────────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica al proceso de fraccionamiento de sangre total, desde la recepción de la unidad hasta la obtención, etiquetado y almacenamiento de los hemocomponentes: concentrado eritrocitario, plasma fresco congelado y concentrado plaquetario, en el Banco de Sangre del Hospital Santa Margarita.',

'[{"item":"Centrífuga refrigerada"},{"item":"Extractor de plasma"},{"item":"Selladora de bolsas (sealer)"},{"item":"Bolsas dobles o triples con anticoagulante CPDA-1"},{"item":"Balanza calibrada"},{"item":"Termómetro calibrado"},{"item":"Gradilla"},{"item":"Guantes, bata y cubrebocas"},{"item":"Marcador indeleble"},{"item":"Etiquetas de hemocomponentes"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar la identidad de la unidad: código de donación, grupo ABO/Rh, fecha de extracción y fecha de caducidad."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Inspeccionar visualmente la integridad de la bolsa: ausencia de fugas, turbidez anormal o coágulos. Rechazar si hay alteraciones."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar la bolsa en la centrífuga refrigerada, equilibrando con otra bolsa de peso similar."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar a los parámetros establecidos (velocidad, temperatura y tiempo según protocolo del equipo)."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Retirar la bolsa de la centrífuga sin resuspender los eritrocitos."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar la bolsa en el extractor de plasma y abrir el tubo de comunicación hacia la bolsa satélite."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Extraer el plasma hacia la bolsa satélite, dejando 5-10 mL de plasma sobre la capa leucoplaquetaria."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Sellar el tubing de comunicación y separar las bolsas."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Etiquetar cada hemocomponente: código, grupo ABO/Rh, fecha de extracción, caducidad, volumen y condiciones de almacenamiento."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Congelar el plasma fresco congelado a -18°C o menor dentro de las primeras 8 horas post-extracción."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Almacenar el concentrado eritrocitario a 1-6°C y el concentrado plaquetario a 20-24°C en agitación continua."},{"no":"12","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar el fraccionamiento en la bitácora: hemocomponentes obtenidos, volúmenes y destino."}]'::jsonb,

'[{"riesgo":"Contaminación de hemocomponentes durante el proceso","barrera":"Usar técnica aséptica estricta; sellar correctamente todos los tubings antes de separar las bolsas."},{"riesgo":"Error de etiquetado que ocasione transfusión incompatible","barrera":"Verificación doble del etiquetado antes de almacenar la unidad."},{"riesgo":"Fraccionamiento fuera de tiempo (plasma no fresco)","barrera":"Registrar hora de extracción y procesar dentro de las 8 horas; desechar si se excede el tiempo."}]'::jsonb,

'[{"nombre":"Bitácora de Fraccionamiento","codigo":"FT-BS-01"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"27/05/2019","descripcion":"Alta de documento","realizado":"Dr. Mario Iván Pérez Rivas","aprobado":""},{"version":"2","fecha":"14/09/2020","descripcion":"Actualización del documento","realizado":"QFB Bertha Rocío Pacas Pérez","aprobado":""},{"version":"3","fecha":"02/12/2022","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"4","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"5","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-02'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-06 · Hemoclasificación Técnica en Tubo ─────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica a la determinación del grupo sanguíneo ABO y factor RhD mediante técnica en tubo, tanto en donadores como en pacientes del Banco de Sangre, abarcando desde la preparación de la muestra hasta el registro del resultado.',

'[{"item":"Tubos de ensayo 10×75 mm"},{"item":"Gradilla"},{"item":"Centrífuga serológica"},{"item":"Antisuero Anti-A"},{"item":"Antisuero Anti-B"},{"item":"Antisuero Anti-D (IgM)"},{"item":"Solución salina al 0.9%"},{"item":"Micropipetas y puntas desechables"},{"item":"Marcador"},{"item":"Lupa o espejo cóncavo de lectura"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Identificar la muestra del paciente o donador y verificar que cumpla con los requisitos de calidad."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Preparar suspensión de eritrocitos al 3-5% en solución salina lavando una vez la muestra."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Rotular los tubos: Anti-A, Anti-B y Anti-D."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar 1 gota del antisuero correspondiente en cada tubo."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 1 gota de la suspensión eritrocitaria al 3-5% en cada tubo."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Mezclar suavemente cada tubo."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar a 1000 rpm por 15 segundos (o parámetros validados del equipo)."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Resuspender suavemente el botón eritrocitario e interpretar: aglutinación = positivo; suspensión homogénea = negativo."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Interpretar el grupo ABO y Rh con base en los resultados de los tres tubos."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar el resultado en el formato y bitácora correspondientes."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"En caso de discrepancias (groupeo directo e inverso no concordantes), investigar la causa antes de reportar."}]'::jsonb,

'[{"riesgo":"Resultado falso negativo por exceso de eritrocitos","barrera":"Respetar la proporción antisuero:eritrocitos establecida; verificar que la suspensión sea al 3-5%."},{"riesgo":"Contaminación cruzada entre muestras","barrera":"Usar material desechable por muestra; nunca reutilizar puntas o tubos."},{"riesgo":"Error de identificación de la muestra","barrera":"Verificar dos identificadores del paciente antes de procesar."}]'::jsonb,

'[{"nombre":"Bitácora de Grupos Sanguíneos","codigo":"FT-BS-02"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"27/05/2019","descripcion":"Alta de documento","realizado":"Dr. Mario Iván Pérez Rivas","aprobado":""},{"version":"2","fecha":"14/09/2020","descripcion":"Actualización del documento","realizado":"QFB Bertha Rocío Pacas Pérez","aprobado":""},{"version":"3","fecha":"02/12/2022","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"4","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"5","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-06'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-07 · Hemoclasificación en Tarjeta de Gel ───────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica a la determinación del grupo sanguíneo ABO y factor RhD mediante tarjeta de gel, como método de confirmación o alternativo a la técnica en tubo, en donadores y pacientes del Banco de Sangre.',

'[{"item":"Tarjetas de gel ABO/Rh (marca vigente en uso)"},{"item":"Centrífuga para tarjetas de gel"},{"item":"Diluyente para eritrocitos"},{"item":"Micropipetas de 10 µL y 50 µL"},{"item":"Puntas desechables"},{"item":"Baño María a 37°C (si aplica según el fabricante)"},{"item":"Marcador"},{"item":"Muestra de sangre del paciente/donador"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Identificar la tarjeta de gel con los datos del paciente o donador (nombre, código, fecha)."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Preparar suspensión eritrocitaria al 0.8% en diluyente del fabricante."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Retirar el sello de aluminio de los microtubos a utilizar."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Dispensar 10 µL de la suspensión eritrocitaria en cada microtubo indicado."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Si la tarjeta requiere antisuero externo, dispensar la cantidad indicada por el fabricante."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Incubar si lo requiere la tarjeta (temperatura y tiempo según instructivo del fabricante)."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar en la centrífuga para tarjetas a la velocidad y tiempo establecidos por el fabricante."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Leer e interpretar resultados: pellet compacto en el fondo = negativo (0); aglutinados en la superficie o distribuidos en el gel = positivo (1+ a 4+)."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Determinar el grupo ABO y Rh con base en los resultados de cada microtubo."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar el resultado en el formato y bitácora correspondientes."}]'::jsonb,

'[{"riesgo":"Centrifugación inadecuada que dificulta la lectura","barrera":"Verificar y validar los parámetros de la centrífuga para tarjetas al inicio de cada jornada."},{"riesgo":"Uso de tarjeta caducada con reactivos degradados","barrera":"Verificar fecha de caducidad de cada tarjeta antes de usar; no utilizar lotes vencidos."},{"riesgo":"Burbujas en el gel que interfieren con la lectura","barrera":"Evitar agitar la tarjeta antes de centrifugar; no pipetear directamente sobre el gel."}]'::jsonb,

'[{"nombre":"Bitácora de Grupos Sanguíneos","codigo":"FT-BS-02"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"27/05/2019","descripcion":"Alta de documento","realizado":"Dr. Mario Iván Pérez Rivas","aprobado":""},{"version":"2","fecha":"14/09/2020","descripcion":"Actualización del documento","realizado":"QFB Bertha Rocío Pacas Pérez","aprobado":""},{"version":"3","fecha":"02/12/2022","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"4","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"5","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-07'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-08 · Determinación de Subgrupos A ──────────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica a la determinación de subgrupos del antígeno A (A1 y A2/débil) mediante lectina Anti-A1 en técnica de tubo, en pacientes o donadores con grupo sanguíneo A o AB, para definir la compatibilidad transfusional cuando existen anticuerpos anti-A1.',

'[{"item":"Lectina Anti-A1 (Dolichos biflorus)"},{"item":"Solución salina al 0.9%"},{"item":"Tubos de ensayo 10×75 mm"},{"item":"Centrífuga serológica"},{"item":"Micropipetas y puntas desechables"},{"item":"Gradilla"},{"item":"Marcador"},{"item":"Células control A1 y A2 (controles positivo y negativo)"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Confirmar que el paciente o donador sea grupo A o AB antes de proceder con la determinación de subgrupos."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Preparar suspensión de eritrocitos del paciente al 3-5% en solución salina."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Rotular tres tubos: problema, control A1 positivo y control A2 negativo."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar 1 gota de lectina Anti-A1 en cada tubo."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 1 gota de la suspensión eritrocitaria correspondiente a cada tubo."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Mezclar y dejar reposar 5 minutos a temperatura ambiente."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar a 1000 rpm por 15 segundos."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Resuspender suavemente y leer: aglutinación = subgrupo A1; sin aglutinación = subgrupo A2 o débil."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar que los controles sean válidos antes de reportar el resultado del paciente."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar el resultado en el expediente del paciente/donador y en la bitácora, anotando las implicaciones transfusionales."}]'::jsonb,

'[{"riesgo":"Resultado erróneo por controles inválidos","barrera":"Verificar el comportamiento de los controles A1 y A2 en cada sesión; no reportar si los controles fallan."},{"riesgo":"Error de interpretación en reacciones débiles","barrera":"Leer bajo buena iluminación y, si es necesario, bajo lupa; reportar como débil si la aglutinación es menor de 1+."}]'::jsonb,

'[{"nombre":"Bitácora de Grupos Sanguíneos","codigo":"FT-BS-02"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"27/05/2019","descripcion":"Alta de documento","realizado":"Dr. Mario Iván Pérez Rivas","aprobado":""},{"version":"2","fecha":"14/09/2020","descripcion":"Actualización del documento","realizado":"QFB Bertha Rocío Pacas Pérez","aprobado":""},{"version":"3","fecha":"02/12/2022","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"4","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"5","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-08'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-10 · Rastreo de Anticuerpos Irregulares ────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica desde la obtención de la muestra del paciente o donador hasta la interpretación y registro del resultado del rastreo de anticuerpos irregulares (RAI), mediante tres técnicas: tarjeta de gel, solución salina y albúmina bovina.',

'[{"item":"Panel de células de rastreo (2-3 células de antígenos conocidos)"},{"item":"Tarjetas de gel para prueba de antiglobulina indirecta"},{"item":"Centrífuga para tarjetas de gel"},{"item":"Centrífuga serológica"},{"item":"Solución salina al 0.9%"},{"item":"Albúmina bovina al 22%"},{"item":"Suero de Coombs poliespecífico (antiglobulina humana)"},{"item":"Tubos de ensayo 10×75 mm"},{"item":"Baño María a 37°C"},{"item":"Micropipetas y puntas desechables"},{"item":"Suero o plasma del paciente"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Identificar la muestra del paciente y verificar datos en la solicitud."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar la fecha de las células de rastreo y que los antígenos estén correctamente documentados."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"TÉCNICA TARJETA DE GEL — Identificar la tarjeta de gel IAT con los datos del paciente."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Preparar suspensión de células de rastreo al 0.8% en diluyente. Dispensar 50 µL de suero del paciente en cada microtubo."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 10 µL de la suspensión de células de rastreo correspondiente en cada microtubo."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Incubar la tarjeta 15 minutos a 37°C."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar en centrífuga para tarjetas. Leer e interpretar (0 a 4+)."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"TÉCNICA SALINA — Rotular tubos por cada célula de rastreo. Colocar 2 gotas de suero del paciente en cada tubo."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 1 gota de suspensión de células de rastreo al 3-5% en salina. Centrifugar (IS) y leer fase inmediata."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Incubar a 37°C por 30-60 minutos. Centrifugar y leer fase 37°C."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Lavar los tubos 3-4 veces con solución salina. Añadir 2 gotas de antiglobulina humana (AHG)."},{"no":"12","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar (1000 rpm × 15 seg). Leer fase AHG (fase de Coombs)."},{"no":"13","responsable":"QFB / Técnico en Banco de Sangre","actividad":"TÉCNICA ALBÚMINA — Colocar 2 gotas de suero del paciente. Añadir 2 gotas de albúmina bovina al 22%."},{"no":"14","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 1 gota de suspensión de células de rastreo al 3-5%. Incubar a 37°C por 15 minutos."},{"no":"15","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar y leer fase albúmina. Lavar y agregar AHG si el protocolo lo requiere."},{"no":"16","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Interpretar los resultados de las tres técnicas. RAI positivo en cualquier fase requiere identificación de anticuerpos."},{"no":"17","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar todos los resultados en la bitácora y en el formato FT-BS-03. Notificar al médico si el RAI es positivo."}]'::jsonb,

'[{"riesgo":"Falso negativo por temperatura o tiempo de incubación inadecuados","barrera":"Monitorear el baño María al inicio de cada sesión; respetar estrictamente los tiempos establecidos."},{"riesgo":"Reacción débil no detectada (anticuerpo de baja potencia)","barrera":"Leer bajo buena iluminación con lupa; repetir en caso de duda; usar todas las técnicas indicadas."},{"riesgo":"Error de identificación de la muestra del paciente","barrera":"Verificar dos identificadores en la muestra y en la solicitud antes de procesar."}]'::jsonb,

'[{"nombre":"Bitácora de Grupos Sanguíneos","codigo":"FT-BS-02"},{"nombre":"Formato de Rastreo de Anticuerpos","codigo":"FT-BS-03"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"27/05/2019","descripcion":"Alta de documento","realizado":"Dr. Mario Iván Pérez Rivas","aprobado":""},{"version":"2","fecha":"14/09/2020","descripcion":"Actualización del documento","realizado":"QFB Bertha Rocío Pacas Pérez","aprobado":""},{"version":"3","fecha":"02/12/2022","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"4","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"5","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-10'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-11 · Identificación de Anticuerpos Irregulares ─────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica cuando el rastreo de anticuerpos irregulares (RAI) resulta positivo, procediendo a la identificación del anticuerpo mediante panel de 10 a 16 células de antígenos conocidos, para determinar su especificidad y las implicaciones transfusionales.',

'[{"item":"Panel de identificación de anticuerpos (10-16 células con antígenos conocidos)"},{"item":"Hoja de trabajo del panel (ficha antigénica)"},{"item":"Suero de Coombs poliespecífico (AHG)"},{"item":"Solución salina al 0.9%"},{"item":"Albúmina bovina al 22%"},{"item":"Tubos de ensayo 10×75 mm"},{"item":"Centrífuga serológica"},{"item":"Baño María a 37°C"},{"item":"Micropipetas y puntas desechables"},{"item":"Suero o plasma del paciente"},{"item":"Tarjetas de gel IAT (si aplica)"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Confirmar que el RAI del paciente sea positivo y recuperar la muestra adecuada para identificación."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Seleccionar el panel de identificación con la ficha antigénica actualizada."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Preparar suspensión eritrocitaria al 3-5% en salina para cada célula del panel."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Rotular tubos numerados del 1 al N (una serie por técnica: salina y AHG)."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar 2 gotas de suero del paciente en cada tubo."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 1 gota de suspensión de la célula correspondiente del panel en cada tubo."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar y leer fase IS (inmediata en salina)."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir albúmina bovina al 22% e incubar a 37°C por 30-60 minutos. Centrifugar y leer fase 37°C."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Lavar los tubos 3-4 veces con solución salina. Añadir 2 gotas de AHG. Centrifugar y leer fase AHG."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar los resultados de reactividad (0, 1+, 2+, 3+, 4+, MF) en la hoja de trabajo del panel."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Analizar el patrón de reactividad comparando con los antígenos de cada célula: aplicar la regla de exclusión e inclusión (mínimo 3 positivos y 3 negativos concordantes)."},{"no":"12","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Identificar el anticuerpo por su especificidad (anti-D, anti-E, anti-c, anti-K, anti-Jka, etc.)."},{"no":"13","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Si se sospecha anticuerpo múltiple, realizar técnicas adicionales (enzimas, dithiothreitol) según criterio del responsable."},{"no":"14","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar el resultado en el expediente del paciente, en la bitácora y en el formato correspondiente. Notificar al médico las implicaciones transfusionales."}]'::jsonb,

'[{"riesgo":"Identificación incorrecta del anticuerpo por panel insuficiente","barrera":"Usar panel con al menos 10 células; si el patrón es complejo, enviar muestra a banco de referencia."},{"riesgo":"Anticuerpos múltiples no detectados","barrera":"Analizar cuidadosamente el patrón de reactividad; realizar adsorciones o técnicas de fraccionamiento si es necesario."}]'::jsonb,

'[{"nombre":"Formato de Identificación de Anticuerpos","codigo":"FT-BS-03"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"27/05/2019","descripcion":"Alta de documento","realizado":"Dr. Mario Iván Pérez Rivas","aprobado":""},{"version":"2","fecha":"14/09/2020","descripcion":"Actualización del documento","realizado":"QFB Bertha Rocío Pacas Pérez","aprobado":""},{"version":"3","fecha":"02/12/2022","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"4","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"5","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-11'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-14 · Prueba de Compatibilidad Mayor ─────────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica a la prueba de compatibilidad mayor entre el suero o plasma del paciente receptor y los eritrocitos del donador, antes de la transfusión de cualquier hemocomponente que contenga eritrocitos, para detectar anticuerpos clínicamente significativos.',

'[{"item":"Muestra del paciente receptor (suero o plasma)"},{"item":"Segmento de tubing de la unidad del donador"},{"item":"Tubos de ensayo 10×75 mm"},{"item":"Solución salina al 0.9%"},{"item":"Albúmina bovina al 22% o LISS"},{"item":"Suero de Coombs poliespecífico (AHG)"},{"item":"Centrífuga serológica"},{"item":"Baño María a 37°C"},{"item":"Micropipetas y puntas desechables"},{"item":"Tarjetas de gel IAT (como método alternativo)"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar los datos del paciente en la solicitud y en la muestra (nombre, NSS o expediente, grupo sanguíneo, RAI previo)."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Seleccionar la unidad del donador compatible en grupo ABO y Rh con el paciente."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Obtener eritrocitos del donador a partir del segmento de tubing de la unidad. Preparar suspensión al 3-5% en salina."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Rotular los tubos: IS (suero frío), 37°C y AHG."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar 2 gotas de suero del paciente en cada tubo."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 1 gota de suspensión eritrocitaria del donador en cada tubo."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar IS (1000 rpm × 15 seg). Resuspender y leer fase inmediata."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir albúmina o LISS. Incubar a 37°C por 15-30 minutos. Centrifugar y leer fase 37°C."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Lavar los tubos 3-4 veces con solución salina. Añadir 2 gotas de AHG."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar (1000 rpm × 15 seg). Resuspender y leer fase AHG."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Interpretar: compatible = todas las fases negativas (sin aglutinación ni hemólisis). Incompatible = cualquier fase positiva."},{"no":"12","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Etiquetar la unidad como COMPATIBLE o INCOMPATIBLE. Si es incompatible, seleccionar otra unidad y repetir el proceso."},{"no":"13","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar los resultados en la bitácora de compatibilidades y en el formato FT-BS-04. Entregar la unidad compatible al servicio solicitante."}]'::jsonb,

'[{"riesgo":"Error de identificación paciente-unidad con posible reacción transfusional hemolítica","barrera":"Verificación doble de la identidad del paciente y del código de la unidad antes de liberar."},{"riesgo":"Resultado falso compatible por técnica incorrecta","barrera":"Respetar estrictamente tiempos, temperaturas y número de lavados; verificar controles."}]'::jsonb,

'[{"nombre":"Formato de Prueba de Compatibilidad","codigo":"FT-BS-04"},{"nombre":"Bitácora de Compatibilidades","codigo":"FT-BS-05"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"27/05/2019","descripcion":"Alta de documento","realizado":"Dr. Mario Iván Pérez Rivas","aprobado":""},{"version":"2","fecha":"14/09/2020","descripcion":"Actualización del documento","realizado":"QFB Bertha Rocío Pacas Pérez","aprobado":""},{"version":"3","fecha":"02/12/2022","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"4","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"5","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-14'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-15 · Prueba de Compatibilidad Menor ─────────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica a la prueba de compatibilidad menor entre el plasma del donador y los eritrocitos del paciente receptor, para detectar anticuerpos en el plasma del donador que puedan ser clínicamente significativos para el receptor.',

'[{"item":"Plasma del donador (obtenido del segmento de tubing)"},{"item":"Eritrocitos del paciente receptor"},{"item":"Tubos de ensayo 10×75 mm"},{"item":"Solución salina al 0.9%"},{"item":"Centrífuga serológica"},{"item":"Baño María a 37°C"},{"item":"Micropipetas y puntas desechables"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Obtener plasma del donador a partir del segmento de tubing de la unidad a transfundir."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Preparar suspensión de eritrocitos del paciente receptor al 3-5% en solución salina."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Rotular el tubo como ''Compatibilidad Menor''."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar 2 gotas de plasma del donador en el tubo."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 1 gota de suspensión eritrocitaria del paciente."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar IS (1000 rpm × 15 seg). Resuspender y leer fase inmediata."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Incubar a 37°C por 15 minutos. Centrifugar y leer fase 37°C."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Interpretar: compatible = sin aglutinación ni hemólisis en ninguna fase. Incompatible = aglutinación o hemólisis."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar el resultado en el formato de compatibilidades y en la bitácora correspondiente."}]'::jsonb,

'[{"riesgo":"No detectar anticuerpo hemolizante en plasma del donador","barrera":"Observar cuidadosamente el tono del sobrenadante en busca de hemólisis (color rojizo); este hallazgo debe reportarse como incompatible."},{"riesgo":"Error de identificación de la muestra del receptor","barrera":"Verificar dos identificadores del paciente antes de preparar la suspensión eritrocitaria."}]'::jsonb,

'[{"nombre":"Formato de Prueba de Compatibilidad","codigo":"FT-BS-04"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"27/05/2019","descripcion":"Alta de documento","realizado":"Dr. Mario Iván Pérez Rivas","aprobado":""},{"version":"2","fecha":"14/09/2020","descripcion":"Actualización del documento","realizado":"QFB Bertha Rocío Pacas Pérez","aprobado":""},{"version":"3","fecha":"02/12/2022","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"4","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"5","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-15'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-17 · Control de Calidad de Hemocomponentes ─────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica al control de calidad de los hemocomponentes producidos en el Banco de Sangre: concentrado eritrocitario, concentrado plaquetario, plasma fresco congelado y crioprecipitado, conforme a los parámetros establecidos en la NOM-253-SSA1-2012.',

'[{"item":"Hemoglobinómetro o equipo de biometría hemática"},{"item":"Balanza analítica calibrada"},{"item":"Microcentrífuga para hematócrito"},{"item":"Tubos capilares y sellador de cera"},{"item":"Lector de hematócrito"},{"item":"Contador de células (para plaquetas)"},{"item":"pH-metro calibrado"},{"item":"Termómetro calibrado"},{"item":"Material de muestreo estéril (agujas, jeringas)"},{"item":"Hoja de registro de control de calidad mensual"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Seleccionar aleatoriamente las unidades a controlar de acuerdo con el plan de muestreo mensual establecido (mínimo 1% de la producción)."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"CC CONCENTRADO ERITROCITARIO — Pesar la unidad y calcular el volumen neto."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Tomar muestra aséptica del concentrado eritrocitario. Determinar hematócrito (Hct): debe ser 65-80%."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Determinar hemoglobina por unidad (deben ser ≥ 40 g/unidad)."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar ausencia de hemólisis, coágulos o turbidez anormal de forma visual."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"CC CONCENTRADO PLAQUETARIO — Pesar y registrar el volumen de la unidad."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Realizar recuento de plaquetas (debe ser ≥ 5.5 × 10^10 por unidad para pool; ≥ 3 × 10^11 para aféresis)."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Medir pH al final del almacenamiento (debe ser ≥ 6.4). Verificar ausencia de agregados."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"CC PLASMA FRESCO CONGELADO — Verificar que la congelación sea a -18°C o menor (por registros del ultracongelador)."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Revisar el aspecto post-descongelación: color amarillo pálido, sin partículas. Registrar volumen (≥ 200 mL)."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"CC CRIOPRECIPITADO — Verificar congelación y condiciones de almacenamiento."},{"no":"12","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Revisar el aspecto y registrar el volumen. Determinar actividad de Factor VIII si el equipo lo permite."},{"no":"13","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar todos los resultados en el formato mensual de Control de Calidad de Hemocomponentes."},{"no":"14","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Comparar los resultados con las especificaciones de la NOM-253-SSA1-2012. Documentar no conformidades si existen y emitir acción correctiva."}]'::jsonb,

'[{"riesgo":"Unidad fuera de especificación transfundida al paciente","barrera":"Separar de inmediato las unidades no conformes y etiquetarlas como ''NO APTA PARA TRANSFUSIÓN''; reportar al responsable."},{"riesgo":"Contaminación durante el muestreo para control de calidad","barrera":"Usar técnica aséptica estricta; utilizar agujas y jeringas estériles desechables para obtener la muestra."}]'::jsonb,

'[{"nombre":"Formato de Control de Calidad de Hemocomponentes","codigo":"FT-BS-10"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"27/05/2019","descripcion":"Alta de documento","realizado":"Dr. Mario Iván Pérez Rivas","aprobado":""},{"version":"2","fecha":"14/09/2020","descripcion":"Actualización del documento","realizado":"QFB Bertha Rocío Pacas Pérez","aprobado":""},{"version":"3","fecha":"02/12/2022","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"4","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"5","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-17'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-18 · Determinación de Autocontrol ──────────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica a la determinación del autocontrol, incubando el suero del paciente con sus propios eritrocitos, para detectar la presencia de autoanticuerpos o anticuerpos que puedan unirse a los eritrocitos autólogos, como complemento al rastreo de anticuerpos irregulares.',

'[{"item":"Muestra del paciente (suero y eritrocitos del mismo tubo)"},{"item":"Solución salina al 0.9%"},{"item":"Suero de Coombs poliespecífico (AHG)"},{"item":"Albúmina bovina al 22%"},{"item":"Tubos de ensayo 10×75 mm"},{"item":"Centrífuga serológica"},{"item":"Baño María a 37°C"},{"item":"Micropipetas y puntas desechables"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Separar el suero y los eritrocitos del mismo tubo del paciente."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Lavar los eritrocitos autólogos 3 veces con solución salina (1000 rpm × 1 min cada lavado)."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Preparar suspensión de eritrocitos autólogos al 3-5% en solución salina."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Rotular el tubo como ''Autocontrol''."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar 2 gotas del suero del propio paciente en el tubo."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 1 gota de la suspensión de eritrocitos autólogos."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Centrifugar IS (1000 rpm × 15 seg). Leer e interpretar fase inmediata."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir albúmina bovina al 22%. Incubar a 37°C por 15-30 minutos. Centrifugar y leer fase 37°C."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Lavar 3-4 veces con salina. Añadir 2 gotas de AHG. Centrifugar y leer fase AHG."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Interpretar: autocontrol positivo en fase AHG sugiere autoanticuerpo caliente (anti-IgG), o anticuerpo previo unido a eritrocitos."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar el resultado del autocontrol junto al resultado del RAI. Correlacionar con el diagnóstico clínico del paciente y notificar al médico si el autocontrol es positivo."}]'::jsonb,

'[{"riesgo":"Autocontrol positivo no correlacionado con el diagnóstico clínico","barrera":"Siempre notificar al médico el resultado positivo del autocontrol; incluir en el informe la recomendación de correlación clínica."},{"riesgo":"Lavado insuficiente de eritrocitos autólogos que genera falso positivo","barrera":"Realizar mínimo 3 lavados completos con decantación total del sobrenadante antes de preparar la suspensión."}]'::jsonb,

'[{"nombre":"Formato de Rastreo de Anticuerpos","codigo":"FT-BS-03"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"27/05/2019","descripcion":"Alta de documento","realizado":"Dr. Mario Iván Pérez Rivas","aprobado":""},{"version":"2","fecha":"14/09/2020","descripcion":"Actualización del documento","realizado":"QFB Bertha Rocío Pacas Pérez","aprobado":""},{"version":"3","fecha":"02/12/2022","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"4","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"5","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-18'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-19 · Pruebas de Tamizaje (Quimioluminiscencia) ─────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica al tamizaje de agentes infecciosos transmisibles por transfusión en donadores de sangre mediante el sistema automatizado de quimioluminiscencia (Vitros u equipo vigente), incluyendo: HBsAg, Anti-HCV, Anti-HIV 1/2 + Ag p24, VDRL/Sífilis, Anti-HTLV I/II y Anti-Trypanosoma cruzi (Chagas), conforme a la NOM-253-SSA1-2012.',

'[{"item":"Sistema Vitros (OrthoClinical Diagnostics) o equipo vigente"},{"item":"Reactivos de quimioluminiscencia para cada marcador infeccioso"},{"item":"Calibradores del fabricante"},{"item":"Controles internos positivo y negativo por marcador"},{"item":"Suero de donadores (tubos de tapa roja sin anticoagulante)"},{"item":"Cubetas y consumibles del equipo"},{"item":"Hoja de trabajo/registro de corrida"},{"item":"Refrigerador para conservación de reactivos a 2-8°C"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Encender el equipo Vitros y realizar las verificaciones de inicio de jornada (nivel de reactivos, temperatura, estado del equipo)."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar que los reactivos estén dentro de fecha de caducidad y que hayan sido almacenados a 2-8°C. Atemperar según indicación del fabricante."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Cargar calibradores y realizarla calibración si el equipo lo requiere o según periodicidad establecida por el fabricante."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Cargar los controles internos (positivo y negativo) para cada marcador en la corrida."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar los datos de cada donador en el sistema: código de donación, nombre, pruebas a realizar."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Cargar las muestras de los donadores en el rack del equipo en el orden registrado."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Iniciar la corrida analítica. El equipo procesa automáticamente: dispensado, incubación y lectura de la señal de quimioluminiscencia."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar la validez de los controles internos al término de la corrida (deben estar dentro de los rangos del fabricante). Si un control falla, la corrida es inválida."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Revisar los resultados: NO REACTIVO = donador apto (para ese marcador); REACTIVO = repetir por duplicado la muestra en nueva corrida."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Muestras repetidamente reactivas en duplicado: la unidad de sangre debe separarse del inventario transfusional y marcarse como NO APTA."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar todos los resultados en la bitácora de tamizaje infeccioso (FT-BS-08). Mantener la cadena de custodia de las muestras reactivas."},{"no":"12","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Notificar al médico responsable del banco de sangre todos los casos repetidamente reactivos para seguimiento del donador según protocolo."}]'::jsonb,

'[{"riesgo":"Falla del equipo durante la corrida analítica","barrera":"No liberar resultados de una corrida inválida; repetir la corrida con los controles válidos; llamar al servicio técnico si el equipo no se recupera."},{"riesgo":"Ruptura de la cadena de frío de los reactivos de quimioluminiscencia","barrera":"Registrar y monitorear la temperatura del refrigerador de reactivos; verificar temperatura al recibir cada lote nuevo de reactivos."},{"riesgo":"Unidad reactiva liberada por error para transfusión","barrera":"Verificación de dos QFBs antes de liberar cualquier unidad; el sistema debe estar configurado para bloquear unidades con resultado reactivo."}]'::jsonb,

'[{"nombre":"Manual del equipo Vitros","codigo":"Manual Vitros"},{"nombre":"Bitácora de Tamizaje Infeccioso","codigo":"FT-BS-08"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"29/11/2022","descripcion":"Alta de documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"2","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"3","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-19'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-20 · Transfusión de Urgencias ──────────────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica cuando se requiere transfundir hemocomponentes de forma urgente o de emergencia, antes de contar con el resultado completo de las pruebas pretransfusionales (grupo, rastreo de anticuerpos y prueba de compatibilidad), bajo la autorización médica por escrito y en situaciones de riesgo vital para el paciente.',

'[{"item":"Unidades de concentrado eritrocitario O negativo (para emergencia sin grupo conocido)"},{"item":"Formato de liberación de urgencia / consentimiento médico"},{"item":"Etiqueta especial ''Transfusión de Urgencia — Sin Prueba de Compatibilidad Completa''"},{"item":"Material para grupo sanguíneo básico (si el tiempo lo permite)"}]'::jsonb,

'[{"no":"1","responsable":"Médico solicitante","actividad":"Completar y firmar el formato de liberación de urgencia especificando: nombre del paciente, diagnóstico, hemocomponente solicitado y justificación de la urgencia."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Recibir el formato de liberación. Verificar que cuente con la firma del médico responsable."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Consultar si el paciente tiene grupo sanguíneo previo registrado en el sistema del banco de sangre."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Si se conoce el grupo: seleccionar y liberar una unidad ABO/Rh compatible sin esperar la prueba de compatibilidad. Continuar la prueba en paralelo."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Si NO se conoce el grupo (emergencia absoluta): liberar concentrado eritrocitario O negativo. En caso de escasez de O negativo, puede liberarse O positivo previa autorización del responsable médico."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Adjuntar a la unidad la etiqueta especial de ''Transfusión de Urgencia'', indicando que no se completaron las pruebas pretransfusionales."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar: hora de solicitud, hora de entrega, unidad entregada (código, grupo), médico que autorizó y motivo de urgencia."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Continuar procesando en paralelo las pruebas pretransfusionales con la muestra disponible o con la que se obtenga del paciente."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Si durante las pruebas en paralelo se detecta incompatibilidad, notificar de inmediato al médico para que evalúe continuar o suspender la transfusión."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Completar el registro en la bitácora de urgencias al término del proceso."}]'::jsonb,

'[{"riesgo":"Reacción transfusional hemolítica grave por liberación de unidad incompatible","barrera":"Monitoreo médico estrecho al lado del paciente durante toda la transfusión de urgencia; suspender ante cualquier signo de reacción."},{"riesgo":"Agotamiento de inventario de O negativo","barrera":"Monitorear continuamente el stock; establecer un nivel mínimo de unidades O negativo reservadas para emergencias."}]'::jsonb,

'[{"nombre":"Formato de Transfusión de Urgencias","codigo":"FT-BS-06"},{"nombre":"Bitácora de Transfusiones","codigo":"FT-BS-07"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"29/11/2022","descripcion":"Alta de documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"2","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"3","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-20'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-21 · Prueba de Brucella ────────────────────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica al tamizaje de anticuerpos contra Brucella spp. en muestras de donadores de sangre, como parte del protocolo de tamizaje infeccioso del banco de sangre, utilizando la prueba de aglutinación en tarjeta (Rosa de Bengala o Brucella card test).',

'[{"item":"Antígeno de Brucella (tarjeta o placa de vidrio, según presentación del kit)"},{"item":"Muestra de suero del donador"},{"item":"Palillos o asa desechable de plástico para mezcla"},{"item":"Placa de vidrio o cartón reactivo (si aplica)"},{"item":"Cronómetro"},{"item":"Iluminación adecuada para lectura"},{"item":"Rotador (si se dispone)"},{"item":"Controles positivo y negativo del kit"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar que el kit de Brucella esté dentro de fecha de caducidad y que haya sido almacenado a 2-8°C. Atemperar el antígeno a temperatura ambiente durante 15-30 minutos antes de usar."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar controles positivo y negativo del kit; no usar el reactivo si los controles no son válidos."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar 80 µL (aproximadamente 3 gotas) del suero del donador en el área marcada de la placa o tarjeta."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 1 gota del antígeno de Brucella junto al suero, sin mezclar aún."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Mezclar con palillo desechable en movimiento rotatorio homogéneo, distribuyendo la mezcla en toda el área marcada."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Agitar en rotador a 100 rpm durante 4 minutos (o mezcla manual continua según el kit)."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Leer el resultado inmediatamente, sin exceder 4 minutos post-mezcla, bajo buena iluminación."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Interpretar: aglutinación visible de cualquier grado = REACTIVO; suspensión homogénea sin aglutinación = NO REACTIVO."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"En caso de resultado reactivo, separar la unidad del inventario. No transfundir. Notificar al médico responsable y seguir protocolo de donador reactivo."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar el resultado en la bitácora de tamizaje infeccioso (FT-BS-08)."}]'::jsonb,

'[{"riesgo":"Falso positivo por fenómeno de prozona (anticuerpos en exceso)","barrera":"Si hay sospecha de prozona, diluir la muestra 1:4 con solución salina y repetir la prueba; un resultado reactivo en dilución confirma la positividad."},{"riesgo":"Resultado falso negativo por antígeno degradado","barrera":"Verificar la caducidad y cadena de frío del antígeno en cada sesión; no usar lotes con fecha vencida o almacenamiento inadecuado."}]'::jsonb,

'[{"nombre":"Bitácora de Tamizaje Infeccioso","codigo":"FT-BS-08"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"29/11/2022","descripcion":"Alta de documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"2","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"3","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-21'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-22 · Determinación de Fenotipo del RH ──────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica a la determinación de los antígenos del sistema Rh extendido (C, c, E, e) mediante técnica en tubo, en pacientes con requerimientos transfusionales especiales (mujeres en edad fértil, pacientes politransfundidos, anemia de células falciformes, talasemia) o en donadores seleccionados.',

'[{"item":"Antisuero Anti-C"},{"item":"Antisuero Anti-c"},{"item":"Antisuero Anti-E"},{"item":"Antisuero Anti-e"},{"item":"Solución salina al 0.9%"},{"item":"Tubos de ensayo 10×75 mm"},{"item":"Centrífuga serológica"},{"item":"Micropipetas y puntas desechables"},{"item":"Gradilla"},{"item":"Células control positivo y negativo para cada antisuero"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Confirmar el grupo ABO y Rh(D) del paciente o donador previo al fenotipaje extendido."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Preparar suspensión eritrocitaria al 3-5% en solución salina."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Rotular cuatro tubos: Anti-C, Anti-c, Anti-E, Anti-e."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar 1 gota del antisuero correspondiente en cada tubo."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 1 gota de la suspensión eritrocitaria en cada tubo."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Mezclar suavemente y centrifugar (1000 rpm × 15 seg)."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Resuspender suavemente y leer: aglutinación = positivo para ese antígeno; suspensión homogénea = negativo."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Realizar los controles positivo y negativo para cada antisuero en la misma sesión."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Interpretar y anotar el fenotipo Rh completo (ej. C+c-E-e+, C+c+E+e+)."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar el fenotipo en el expediente del paciente/donador y en el formato correspondiente (FT-BS-11). Para pacientes, incluir la implicación en la selección de unidades fenotipadas."}]'::jsonb,

'[{"riesgo":"Antisuero de baja avidez que genera resultado falso negativo","barrera":"Verificar los controles positivo y negativo de cada antisuero al inicio de cada sesión; no reportar si los controles fallan."},{"riesgo":"Errores en la transcripción del fenotipo que lleven a selección de unidad incorrecta","barrera":"Doble verificación del fenotipo registrado antes de liberar la información al sistema o al médico."}]'::jsonb,

'[{"nombre":"Formato de Fenotipo Rh","codigo":"FT-BS-11"},{"nombre":"Bitácora de Grupos Sanguíneos","codigo":"FT-BS-02"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"29/11/2022","descripcion":"Alta de documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"2","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"3","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-22'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-23 · Prueba de Antiglobulina Directa (PAD) ─────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica a la detección de inmunoglobulinas (IgG) o complemento (C3d) unidos in vivo a los eritrocitos del paciente mediante la prueba de antiglobulina directa (PAD), en casos de sospecha de anemia hemolítica autoinmune, reacción transfusional hemolítica o enfermedad hemolítica del recién nacido.',

'[{"item":"Suero de Coombs poliespecífico (anti-IgG + anti-C3d)"},{"item":"Suero de Coombs monoespecífico anti-IgG"},{"item":"Suero de Coombs monoespecífico anti-C3d"},{"item":"Solución salina al 0.9%"},{"item":"Tubos de ensayo 10×75 mm"},{"item":"Centrífuga serológica"},{"item":"Micropipetas y puntas desechables"},{"item":"Muestra del paciente en EDTA (tapa morada)"},{"item":"Células Coombs control (células IgG-sensibilizadas)"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Obtener muestra de sangre del paciente en tubo EDTA. Verificar que la muestra sea reciente (preferentemente del mismo día)."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Lavar los eritrocitos del paciente 3-4 veces con solución salina (1000 rpm × 1 min cada lavado). Decantar completamente el sobrenadante."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Preparar suspensión de eritrocitos lavados al 3-5% en solución salina."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Rotular tubos: Poliespecífico, Anti-IgG y Anti-C3d."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar 1-2 gotas de cada suero de Coombs en el tubo correspondiente."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir 1 gota de suspensión eritrocitaria en cada tubo."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Mezclar suavemente. Centrifugar (1000 rpm × 15 seg)."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Resuspender suavemente y leer: aglutinación = PAD positivo; suspensión homogénea = PAD negativo."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Añadir células Coombs control (IgG-sensibilizadas) a todos los tubos negativos. Centrifugar y verificar que aglutinen (valida que el lavado fue adecuado y el AHG es funcional)."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Interpretar y graduar la intensidad de la aglutinación (0 a 4+). Reportar la especificidad: IgG, C3d o ambos."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar el resultado en el expediente del paciente y notificar al médico para correlación clínica."}]'::jsonb,

'[{"riesgo":"Falso positivo por muestra coagulada o activación in vitro del complemento","barrera":"Usar exclusivamente muestra en EDTA; procesar dentro de las 24 horas post-extracción."},{"riesgo":"Falso negativo por lavado insuficiente (suero residual neutraliza el AHG)","barrera":"Realizar mínimo 3-4 lavados completos con decantación total; confirmar con células Coombs control en tubos negativos."}]'::jsonb,

'[{"nombre":"Bitácora de Pruebas Especiales","codigo":"FT-BS-15"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"29/11/2022","descripcion":"Alta de documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"2","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"3","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-23'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-24 · Toma de Muestra y Biometría Hemática ──────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica a la obtención de muestras sanguíneas de donadores y pacientes del Banco de Sangre mediante punción venosa, así como a la realización de biometría hemática completa, desde la verificación de la identidad del sujeto hasta el registro del resultado.',

'[{"item":"Tubos Vacutainer EDTA (tapa morada) para biometría hemática"},{"item":"Tubos Vacutainer sin anticoagulante (tapa roja) para pruebas serológicas"},{"item":"Agujas BD Vacutainer 21G o 23G"},{"item":"Holder/adaptador para Vacutainer"},{"item":"Torniquete"},{"item":"Algodón y alcohol isopropílico al 70%"},{"item":"Apósito o curita"},{"item":"Etiquetas de identificación"},{"item":"Equipo de biometría hemática (analizador automatizado)"},{"item":"Guantes de látex o nitrilo"},{"item":"Contenedor para material punzocortante"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar la identidad del donador o paciente con al menos dos identificadores (nombre completo y fecha de nacimiento, o número de expediente/código de donación)."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Explicar el procedimiento al paciente/donador y resolver dudas."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Seleccionar la vena antecubital adecuada (preferentemente fosa del codo). Colocar el torniquete 5-7 cm por encima del sitio de punción."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Desinfectar el área con algodón impregnado en alcohol isopropílico al 70% con movimiento circular de adentro hacia afuera. Dejar secar completamente."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Insertar la aguja en ángulo de 15-30° con el bisel hacia arriba. Verificar que hay flujo de sangre."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Retirar el torniquete antes de retirar el último tubo."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colectar los tubos en el orden correcto: primero el tubo rojo (sin anticoagulante), después el tubo EDTA (tapa morada)."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Invertir el tubo EDTA suavemente 8-10 veces para mezclar con el anticoagulante. NO agitar."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Retirar la aguja. Aplicar presión suave en el sitio de punción y colocar apósito."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Etiquetar de inmediato los tubos con los datos del paciente/donador: nombre, código, fecha y hora."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Procesar la biometría hemática en el analizador automatizado dentro de las 4 horas post-extracción. Verificar controles de calidad del equipo."},{"no":"12","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Revisar los resultados. En caso de valores de alarma o morfologías anormales, realizar revisión en frotis si aplica."},{"no":"13","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar los resultados en el formato de biometría hemática. Informar al médico los valores críticos de forma inmediata."}]'::jsonb,

'[{"riesgo":"Hematoma post-punción","barrera":"Seleccionar vena adecuada; aplicar presión suficiente en el sitio de punción hasta que cese el sangrado."},{"riesgo":"Error de identificación de muestra con riesgo de resultado erróneo","barrera":"Etiquetar los tubos al lado del paciente/donador inmediatamente después de la extracción; verificar datos antes y después de la toma."},{"riesgo":"Accidente punzocortante","barrera":"Desechar la aguja directamente al contenedor de punzocortantes sin encapuchar; usar guantes en todo momento."}]'::jsonb,

'[{"nombre":"Formato de Biometría Hemática","codigo":"FT-BS-14"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"29/11/2022","descripcion":"Alta de documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"2","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"3","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-24'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-25 · Flebotomía del Donador ────────────────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica al proceso de obtención de sangre total de donadores voluntarios calificados, desde la preparación del donador hasta el etiquetado y almacenamiento de la unidad de sangre total, dentro de las instalaciones del Banco de Sangre del Hospital Santa Margarita.',

'[{"item":"Bolsa de colecta de sangre total (doble o triple con anticoagulante CPDA-1)"},{"item":"Aguja de flebotomía 16G"},{"item":"Torniquete"},{"item":"Báscula para bolsa con mezclador"},{"item":"Antiséptico (clorhexidina al 2% o yodo-povidona)"},{"item":"Algodón y gasa estéril"},{"item":"Apósito estéril"},{"item":"Marcador y etiquetas de donación"},{"item":"Selladora de bolsas"},{"item":"Silla o camilla de flebotomía reclinable"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar que el donador haya completado y sea apto según el cuestionario de selección médica y los criterios de elegibilidad vigentes."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Asignar el código de donación. Etiquetar la bolsa, tubos de muestra piloto y el formato de donación con el código único."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Acomodar al donador en la silla de flebotomía en posición cómoda y ligeramente reclinada."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Seleccionar la vena antecubital adecuada. Colocar el torniquete 5-7 cm por encima del sitio de punción."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Realizar la desinfección del sitio de punción con antiséptico (movimiento espiral de adentro hacia afuera). Dejar actuar el tiempo indicado (al menos 30 segundos). NO tocar el área después de la desinfección."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Realizar la punción venosa con la aguja de flebotomía en ángulo de 15-30°. Verificar flujo libre de sangre hacia la bolsa."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Pedir al donador que abra y cierre el puño suavemente de forma intermitente para favorecer el flujo."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Monitorear el volumen en la báscula. El volumen objetivo es 450 mL (± 45 mL). Mezclar suavemente la bolsa con el anticoagulante durante la colecta."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Al alcanzar el volumen objetivo, sellar el tubing. Obtener muestras piloto en los tubos de prueba llenando desde el tubing antes de sellarlo."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Retirar la aguja con movimiento suave y continuo. Aplicar presión firme en el sitio de punción durante al menos 5 minutos."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Colocar apósito en el sitio de punción. Verificar que el sangrado haya cesado antes de que el donador se ponga de pie."},{"no":"12","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Llevar al donador al área de recuperación. Ofrecer hidratación y refrigerio. Monitorear por al menos 15 minutos post-donación."},{"no":"13","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Refrigerar la unidad de sangre total a 1-6°C o entregar al área de fraccionamiento según el plan de procesamiento."}]'::jsonb,

'[{"riesgo":"Reacción vasovagal del donador (mareo, lipotimia)","barrera":"Mantener al donador en posición reclinada durante y después de la donación; tener preparada solución fisiológica; no permitir que el donador se ponga de pie hasta estar estable."},{"riesgo":"Hematoma en el sitio de punción","barrera":"Aplicar presión firme mínimo 5 minutos post-punción; verificar cese del sangrado antes de liberar al donador; instruir al donador sobre cuidados del brazo."},{"riesgo":"Colecta de volumen insuficiente (< 405 mL) o excesivo (> 495 mL)","barrera":"Monitorear continuamente el peso de la bolsa en la báscula; sellar el tubing al alcanzar el rango correcto; desechar bolsas fuera de rango según protocolo."}]'::jsonb,

'[{"nombre":"Bitácora de Donaciones","codigo":"FT-BS-16"},{"nombre":"Cuestionario de Selección del Donador","codigo":"FT-BS-17"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"29/11/2022","descripcion":"Alta de documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"2","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"3","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-25'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-26 · Aféresis Plaquetaria ──────────────────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica al proceso de obtención de concentrado de plaquetas por aféresis automatizada, desde la verificación de la elegibilidad del donador hasta el etiquetado y almacenamiento del producto, utilizando el equipo de aféresis disponible en el Banco de Sangre.',

'[{"item":"Equipo de aféresis (Trima Accel, Amicus, MCS+ u equipo vigente)"},{"item":"Kit desechable estéril para aféresis plaquetaria (específico para el equipo)"},{"item":"Solución de citrato de sodio (anticoagulante)"},{"item":"Solución salina al 0.9%"},{"item":"Material para punción venosa (aguja 16G o 17G)"},{"item":"Antiséptico para desinfección del sitio de punción"},{"item":"Silla o camilla de aféresis reclinable"},{"item":"Monitor de signos vitales"},{"item":"Gluconato de calcio oral (para prevención de hipocalcemia)"},{"item":"Etiquetas de aféresis y hoja de registro"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar los criterios específicos de elegibilidad para donador de aféresis: plaquetas ≥ 150,000/µL (resultado de la biometría del día), peso ≥ 50 kg, venas adecuadas, sin medicamentos inhibidores plaquetarios en los últimos 5-7 días."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar los datos del donador en el sistema: peso, talla, hematócrito y recuento de plaquetas para que el equipo calcule el volumen de aféresis y el tiempo estimado."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Conectar el kit desechable estéril al equipo de aféresis siguiendo estrictamente el instructivo del fabricante."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Programar el equipo con los parámetros del donador (peso, hematócrito) y definir el producto deseado (dosis de plaquetas objetivo)."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Acomodar al donador en la silla reclinable. Realizar la antisepsia del sitio de punción (clorhexidina al 2%)."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Realizar la punción venosa y conectar las líneas del kit. Iniciar el procedimiento de aféresis."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Monitorear al donador durante todo el procedimiento: signos vitales, síntomas de hipocalcemia (hormigueo peribucal, tetania), posibles hematomas en el sitio de punción."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Administrar calcio oral (gluconato de calcio) preventivamente según protocolo, para contrarrestar el efecto quelante del citrato."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Al completar el programa, el equipo devuelve automáticamente los eritrocitos y la mayor parte del plasma al donador."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Retirar las líneas. Aplicar presión en el sitio de punción hasta que cese el sangrado. Llevar al donador al área de recuperación."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar el volumen y el recuento de plaquetas en el concentrado obtenido (el equipo muestra el resultado). Debe cumplir ≥ 3 × 10^11 plaquetas por unidad."},{"no":"12","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Etiquetar el concentrado de plaquetas por aféresis con: código de donación, grupo ABO/Rh, fecha de extracción, caducidad, volumen y recuento de plaquetas."},{"no":"13","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Almacenar en agitador continuo a 20-24°C. Registrar el procedimiento en la bitácora de aféresis."}]'::jsonb,

'[{"riesgo":"Hipocalcemia sintomática por citrato (tetania, arritmia)","barrera":"Administrar calcio oral preventivo; monitorear síntomas durante todo el procedimiento; tener calcio IV disponible para casos graves."},{"riesgo":"Reacción vasovagal del donador","barrera":"Mantener al donador en posición reclinada; monitorear presión arterial; tener solución salina y protocolo de reanimación disponibles."},{"riesgo":"Concentrado de plaquetas por aféresis con recuento insuficiente","barrera":"Verificar que el recuento de plaquetas del donador sea adecuado antes del procedimiento; informar al responsable del banco si el producto no cumple la especificación."}]'::jsonb,

'[{"nombre":"Bitácora de Aféresis","codigo":"FT-BS-18"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"29/11/2022","descripcion":"Alta de documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"2","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"3","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-26'
ON CONFLICT (document_id) DO NOTHING;


-- ── IT-BS-31 · Control de Calidad de Reactivos Hemoclasificadores
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Esta instrucción aplica al control de calidad de los reactivos hemoclasificadores utilizados en el Banco de Sangre (Anti-A, Anti-B, Anti-D, Anti-C, Anti-c, Anti-E, Anti-e, lectina Anti-A1, suero de Coombs poliespecífico y monoespecíficos), al inicio de cada jornada de trabajo y en cada cambio de lote, para garantizar su especificidad, sensibilidad y avidez antes de su uso en muestras de pacientes y donadores.',

'[{"item":"Antisueros hemoclasificadores en uso (Anti-A, Anti-B, Anti-D, Anti-C, Anti-c, Anti-E, Anti-e)"},{"item":"Lectina Anti-A1"},{"item":"Suero de Coombs poliespecífico y monoespecíficos"},{"item":"Células control positivas de grupos sanguíneos conocidos"},{"item":"Células control negativas (grupo O)"},{"item":"Células IgG-sensibilizadas (para control del suero de Coombs)"},{"item":"Solución salina al 0.9%"},{"item":"Tubos de ensayo 10×75 mm"},{"item":"Centrífuga serológica"},{"item":"Hoja de registro de control de calidad de reactivos"}]'::jsonb,

'[{"no":"1","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Al inicio de la jornada, seleccionar todos los reactivos hemoclasificadores a utilizar durante el día."},{"no":"2","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Verificar para cada reactivo: fecha de caducidad, integridad del frasco (sin precipitados ni turbidez anormal), número de lote y condiciones de almacenamiento. Retirar del uso cualquier reactivo vencido o con alteraciones visuales."},{"no":"3","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Preparar suspensiones de células control: grupo A1 (control + para Anti-A), grupo B (control + para Anti-B), grupo O (control – universal), grupo D+ (control + para Anti-D), grupo D– (control – para Anti-D), células fenotipadas para antisueros Anti-C, Anti-c, Anti-E, Anti-e."},{"no":"4","responsable":"QFB / Técnico en Banco de Sangre","actividad":"CC ANTI-A — Colocar 1 gota de Anti-A. Añadir 1 gota de suspensión de células A1 (debe aglutinar: positivo) y 1 gota de células O (no debe aglutinar: negativo). Centrifugar y leer."},{"no":"5","responsable":"QFB / Técnico en Banco de Sangre","actividad":"CC ANTI-B — Colocar 1 gota de Anti-B. Añadir 1 gota de células B (positivo esperado) y 1 gota de células O (negativo esperado). Centrifugar y leer."},{"no":"6","responsable":"QFB / Técnico en Banco de Sangre","actividad":"CC ANTI-D — Colocar 1 gota de Anti-D. Añadir 1 gota de células D+ (positivo esperado) y 1 gota de células D– (negativo esperado). Centrifugar y leer."},{"no":"7","responsable":"QFB / Técnico en Banco de Sangre","actividad":"CC ANTISUEROS PARA FENOTIPO (Anti-C, Anti-c, Anti-E, Anti-e) — Para cada antisuero, usar células control positivo y negativo con fenotipo conocido. Colocar 1 gota de antisuero + 1 gota de suspensión control. Centrifugar y leer."},{"no":"8","responsable":"QFB / Técnico en Banco de Sangre","actividad":"CC SUERO DE COOMBS — Preparar el tubo control: colocar 1-2 gotas de AHG + 1 gota de células IgG-sensibilizadas (debe aglutinar). Colocar otro tubo con AHG + células normales lavadas (no debe aglutinar). Centrifugar y leer."},{"no":"9","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Interpretar todos los controles: el control positivo DEBE mostrar aglutinación de 2+ o mayor; el control negativo NO debe mostrar aglutinación."},{"no":"10","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Si algún control falla: retirar inmediatamente el lote del reactivo del uso clínico. Investigar la causa (caducidad, almacenamiento, contaminación). No usar el reactivo hasta resolver la no conformidad."},{"no":"11","responsable":"QFB / Técnico en Banco de Sangre","actividad":"CAMBIO DE LOTE — Al incorporar un nuevo lote de reactivo, realizar la comparación paralela: procesar controles con el lote nuevo y el lote antiguo simultáneamente; ambos deben dar resultados concordantes."},{"no":"12","responsable":"QFB / Técnico en Banco de Sangre","actividad":"Registrar en la hoja de CC de reactivos: fecha, nombre del reactivo, número de lote, fecha de caducidad, resultado del control positivo (intensidad) y negativo, y firma del responsable."}]'::jsonb,

'[{"riesgo":"Reactivo degradado usado en muestras de pacientes generando resultados erróneos","barrera":"Control de calidad obligatorio al inicio de cada jornada; retirar del uso todo reactivo con control fallido."},{"riesgo":"Introducción de lote nuevo sin validación que presente diferencias en sensibilidad","barrera":"Realizar comparación paralela (lote nuevo vs. lote antiguo) antes de cualquier uso clínico del nuevo lote."},{"riesgo":"Reactivo almacenado fuera de temperatura (2-8°C) sin detección","barrera":"Monitorear y registrar diariamente la temperatura del refrigerador de reactivos; no usar reactivos que hayan sufrido descongelación o calentamiento no controlado."}]'::jsonb,

'[{"nombre":"Hoja de Control de Calidad de Reactivos","codigo":"FT-BS-12"},{"nombre":"Bitácora de Reactivos y Lotes","codigo":"FT-BS-13"},{"nombre":"NOM-253-SSA1-2012 Disposición de Sangre Humana","codigo":"NOM-253-SSA1-2012"}]'::jsonb,

'[{"version":"1","fecha":"29/11/2022","descripcion":"Alta de documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"2","fecha":"22/01/2024","descripcion":"Actualización del documento","realizado":"QFB Martha Beatriz Juárez Mejía","aprobado":""},{"version":"3","fecha":"30/01/2026","descripcion":"Actualización del documento","realizado":"Dra. Viridiana Valdez Toral","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Dra. Viridiana Valdez Toral','Responsable sanitario del Banco de Sangre',
'Dra. Giselle Ivette De la Torre García','Jefa de calidad',
'Dr. José Gonzalo Vázquez Camacho','Director Médico'

FROM documents d WHERE d.code = 'IT-BS-31'
ON CONFLICT (document_id) DO NOTHING;


-- ── Verificación ──────────────────────────────────────────────
SELECT
  d.code,
  d.name,
  d.current_version AS version,
  CASE WHEN dc.id IS NOT NULL THEN 'Con contenido ✓' ELSE 'Sin contenido' END AS contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.department_id = (SELECT id FROM departments WHERE code = 'BS')
ORDER BY d.code;
