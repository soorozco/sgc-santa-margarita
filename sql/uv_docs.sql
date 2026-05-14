-- ============================================================
--  UV — Unidad de Vigilancia Epidemiológica
--  Documentos: 20 IT + 23 PR = 43 total
--  Hospital Santa Margarita · SGC ISO 9001:2015
-- ============================================================

-- 1. Departamento UV
INSERT INTO departments (code, name, description)
VALUES ('UV', 'Unidad de Vigilancia Epidemiológica', 'Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)')
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name;

-- 2. IT Documents
INSERT INTO documents (code, name, type, version, status, issue_date,
  elaboro_nombre, elaboro_cargo, reviso_nombre, reviso_cargo,
  autorizo_nombre, autorizo_cargo, department_id)
SELECT d.code, d.name, d.type::document_type, d.ver, 'vigente'::document_status,
  d.fecha::date,
  'Dr. Esteban González Díaz',
  'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
  d.aut_n, d.aut_c,
  (SELECT id FROM departments WHERE code = 'UV')
FROM (VALUES
  ('IT-UV-02','INSTRUCCIÓN DE TRABAJO PARA LA HIGIENE DE MANOS QUIRÚRGICO CERO CEPILLOS','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-05','INSTRUCCIÓN DE TRABAJO PARA LA COLOCACIÓN DE LA BATA COMO BARRERA DE SEGURIDAD','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-06','INSTRUCCIÓN DE TRABAJO PARA LA COLOCACIÓN DE MASCARILLA FACIAL (CUBREBOCAS)','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-07','INSTRUCCIÓN DE TRABAJO PARA LA COLOCACIÓN DE LENTES DE PROTECCIÓN','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-08','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES POR CONTACTO (TARJETA AMARILLA)','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-09','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES AÉREAS POR MICROGOTAS (TARJETA AZUL)','IT','03','2025-10-02','Dr. José Gonzalo Vázquez Camacho','Dirección Médica'),
  ('IT-UV-10','INSTRUCCIÓN DE TRABAJO PARA CALZADO DE GUANTES TÉCNICA ABIERTA','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-11','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES POR GOTAS (TARJETA VERDE)','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-12','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES ESTÁNDAR (TARJETA ROJA)','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-13','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES POR VECTOR (TARJETA ROSA)','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-14','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES INVERSA (TARJETA LILA)','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-15','ESTUDIO DE SOMBRA DE HIGIENE DE MANOS','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-16','NOTIFICACIÓN DE CASOS NUEVOS DE ENFERMEDADES AL SISTEMA ÚNICO DE INFORMACIÓN PARA LA VIGILANCIA EPIDEMIOLÓGICA (SUIVE)','IT','02','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-17','INSTRUCCIÓN DE VIGILANCIA EPIDEMIOLÓGICA ACTIVA','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-18','SUPERVISIÓN DE LAS MEDIDAS PRECAUTORIAS HOSPITALARIAS','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-19','SUPERVISIÓN DEL USO Y DESECHO DE PUNZOCORTANTES','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-20','INSTRUCCIÓN PARA SUPERVISIÓN DE REFRIGERADORES DE MEDICAMENTOS','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-22','INSTRUCCIÓN DE TRABAJO PARA LA SUPERVISIÓN DE ÁREAS Y PROCESOS','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-23','INSTRUCCIÓN DE TRABAJO PARA LA DETECCIÓN DE INFECCIONES ASOCIADAS A LA ATENCIÓN DE SALUD (IAAS)','IT','03','2025-10-02','Hna. María de Jesús García Castro','Dirección General'),
  ('IT-UV-24','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES POR MICROORGANISMOS MULTIDROGORRESISTENTES (MDRO) (TARJETA NARANJA)','IT','02','2025-10-02','Dr. José Gonzalo Vázquez Camacho','Dirección Médica')
) AS d(code,name,type,ver,fecha,aut_n,aut_c)
ON CONFLICT (code) DO UPDATE SET
  name=EXCLUDED.name, version=EXCLUDED.version, status=EXCLUDED.status,
  issue_date=EXCLUDED.issue_date, elaboro_nombre=EXCLUDED.elaboro_nombre,
  elaboro_cargo=EXCLUDED.elaboro_cargo, reviso_nombre=EXCLUDED.reviso_nombre,
  reviso_cargo=EXCLUDED.reviso_cargo, autorizo_nombre=EXCLUDED.autorizo_nombre,
  autorizo_cargo=EXCLUDED.autorizo_cargo;

UPDATE documents SET department_id=(SELECT id FROM departments WHERE code='UV')
WHERE code IN ('IT-UV-02','IT-UV-05','IT-UV-06','IT-UV-07','IT-UV-08','IT-UV-09','IT-UV-10','IT-UV-11','IT-UV-12','IT-UV-13','IT-UV-14','IT-UV-15','IT-UV-16','IT-UV-17','IT-UV-18','IT-UV-19','IT-UV-20','IT-UV-22','IT-UV-23','IT-UV-24');

-- 3. PR Documents
INSERT INTO documents (code, name, type, version, status, issue_date,
  elaboro_nombre, elaboro_cargo, reviso_nombre, reviso_cargo,
  autorizo_nombre, autorizo_cargo, department_id)
SELECT d.code, d.name, d.type::document_type, d.ver, 'vigente'::document_status,
  d.fecha::date,
  'Dr. Esteban González Díaz',
  'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',
  'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
  'Dr. José Gonzalo Vázquez Camacho', 'Dirección Médica',
  (SELECT id FROM departments WHERE code = 'UV')
FROM (VALUES
  ('PR-UV-01','PROCEDIMIENTO PARA EL ABASTECIMIENTO DE INSUMOS DE HIGIENE DE MANOS','PR','03','2025-09-30'),
  ('PR-UV-02','PROCEDIMIENTO PARA LA PREPARACIÓN DE HABITACIONES','PR','04','2025-09-30'),
  ('PR-UV-03','PROCEDIMIENTO PARA LA SUPERVISIÓN DE LA CLORACIÓN DE AGUA','PR','03','2025-09-30'),
  ('PR-UV-06','PROCEDIMIENTO DE NOTIFICACIÓN EPIDEMIOLÓGICA INMEDIATA','PR','03','2025-09-30'),
  ('PR-UV-07','PROCEDIMIENTO PARA LA NOTIFICACIÓN EPIDEMIOLÓGICA DIARIA','PR','03','2025-09-30'),
  ('PR-UV-08','PROCEDIMIENTO PARA LA CAPACITACIÓN DE HIGIENE DE MANOS POR UVEH','PR','03','2025-09-30'),
  ('PR-UV-09','PROCEDIMIENTO DE ACCIDENTES LABORALES POR RIESGOS BIOLÓGICOS','PR','03','2025-09-30'),
  ('PR-UV-10','PROCEDIMIENTO PARA LA EMISIÓN DE ALERTA EPIDEMIOLÓGICA','PR','03','2025-09-30'),
  ('PR-UV-11','PROCEDIMIENTO PARA EL AISLAMIENTO PARA PACIENTES INFECCIOSOS','PR','03','2025-09-30'),
  ('PR-UV-12','PROCEDIMIENTO PARA AISLAMIENTO PARA PACIENTES INMUNODEPRIMIDOS','PR','03','2025-09-30'),
  ('PR-UV-13','PROCEDIMIENTO DE RECURSOS DEL SISTEMA','PR','03','2025-09-30'),
  ('PR-UV-14','PROCEDIMIENTO DE ENFOQUE DEL SISTEMA','PR','04','2025-09-30'),
  ('PR-UV-15','PROCEDIMIENTO DE MEDIDAS DE PRECAUCIÓN ESTÁNDAR','PR','03','2025-09-30'),
  ('PR-UV-16','PROCEDIMIENTO DEL MANEJO ADECUADO DE RESIDUOS PELIGROSOS BIOLÓGICO-INFECCIOSOS','PR','03','2025-09-30'),
  ('PR-UV-17','PROCEDIMIENTO DE MANEJO ADECUADO DE LOS ALIMENTOS','PR','03','2025-09-30'),
  ('PR-UV-18','PROCEDIMIENTO DE ADECUACIONES, CONSTRUCCIONES Y REMODELACIONES','PR','03','2025-09-30'),
  ('PR-UV-19','PROCEDIMIENTO DE MEDICACIÓN','PR','03','2025-09-30'),
  ('PR-UV-20','PROCEDIMIENTO DEL CONTROL DEL SISTEMA','PR','03','2025-09-30'),
  ('PR-UV-21','PROCEDIMIENTO DE RECEPCIÓN, ALMACENAMIENTO, DISTRIBUCIÓN, MANEJO Y DISPOSICIÓN FINAL DE ROPA HOSPITALARIA','PR','03','2025-09-30'),
  ('PR-UV-22','TERAPIA DE REEMPLAZO RENAL CON HEMODIÁLISIS','PR','02','2025-09-30'),
  ('PR-UV-23','PROCEDIMIENTO PARA EL INGRESO DE PACIENTES CON SÍNTOMAS Y ENFERMEDADES RESPIRATORIAS','PR','02','2025-09-30'),
  ('PR-UV-24','PROCEDIMIENTO PARA LA SUPERVISIÓN DEL MUESTREO PARA DETECCIÓN DE VIBRIO CHOLERAE EN AGUA RESIDUAL Y/O POTABLE','PR','02','2025-09-30'),
  ('PR-UV-25','PROCEDIMIENTO DE TOMA DE MUESTRAS DE ALIMENTOS','PR','01','2025-09-30')
) AS d(code,name,type,ver,fecha)
ON CONFLICT (code) DO UPDATE SET
  name=EXCLUDED.name, version=EXCLUDED.version, status=EXCLUDED.status,
  issue_date=EXCLUDED.issue_date, elaboro_nombre=EXCLUDED.elaboro_nombre,
  elaboro_cargo=EXCLUDED.elaboro_cargo, reviso_nombre=EXCLUDED.reviso_nombre,
  reviso_cargo=EXCLUDED.reviso_cargo, autorizo_nombre=EXCLUDED.autorizo_nombre,
  autorizo_cargo=EXCLUDED.autorizo_cargo;

UPDATE documents SET department_id=(SELECT id FROM departments WHERE code='UV')
WHERE code IN ('PR-UV-01','PR-UV-02','PR-UV-03','PR-UV-06','PR-UV-07','PR-UV-08','PR-UV-09','PR-UV-10','PR-UV-11','PR-UV-12','PR-UV-13','PR-UV-14','PR-UV-15','PR-UV-16','PR-UV-17','PR-UV-18','PR-UV-19','PR-UV-20','PR-UV-21','PR-UV-22','PR-UV-23','PR-UV-24','PR-UV-25');

-- Verificación
SELECT code, name, version, type FROM documents
WHERE department_id=(SELECT id FROM departments WHERE code='UV')
ORDER BY type, code;