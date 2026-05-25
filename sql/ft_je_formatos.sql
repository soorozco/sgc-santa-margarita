-- ============================================================
--  Jefatura de Enfermería — Alta de 53 Formatos (FT-JE-*)
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- 1. Departamento JE (si no existe)
INSERT INTO departments (code, name)
SELECT 'JE', 'Jefatura de Enfermería'
WHERE NOT EXISTS (SELECT 1 FROM departments WHERE code = 'JE');

-- 2. Alta de 53 formatos
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'FT' LIMIT 1),
  (SELECT id FROM departments WHERE code = 'JE' LIMIT 1),
  '01', 'vigente', '2025-09-30'::date,
  'Jefatura de Enfermería',
  'Dra. Giselle Ivette De la Torre García',
  'Jefatura de Enfermería'
FROM (VALUES
  ('FT-JE-01','Hoja De Enfermeria Hospitalización'),
  ('FT-JE-02','Valoracion Inicial De Enfermería'),
  ('FT-JE-03','Hoja De Enfermería En Dialisis Peritoneal'),
  ('FT-JE-05','Hoja De Enfermeria De La Unidad De Hemodialisis'),
  ('FT-JE-06','Hoja De Enfermería Uci'),
  ('FT-JE-07','Hoja De Enfermería Ucin'),
  ('FT-JE-08','Hoja De Registro De Cateter Central'),
  ('FT-JE-09','Hoja De Enfermería Endoscopia'),
  ('FT-JE-11','Hoja De Consumo De Endoscopia Y Colonoscopia'),
  ('FT-JE-13','Hoja De Enfermeria En Quirófano'),
  ('FT-JE-15','Hoja De Urgencias Enfermeria'),
  ('FT-JE-17','Reporte De Insumos Utilizados Del Carro De Paro Por Codigo'),
  ('FT-JE-18','Hoja De Enfermería Cardio Diagnostico'),
  ('FT-JE-19','Instrumento De Evaluación Del Proceso De Lavado De Manos'),
  ('FT-JE-20','Cartel Metas Internacionales'),
  ('FT-JE-21','Tríptico De Las Metas Internacionales'),
  ('FT-JE-22','Ficha Para La Identificacion Del Paciente'),
  ('FT-JE-24','Brazalete Pediatrico'),
  ('FT-JE-25','Sello De Indicaciones Médicas Telefónicas O Verbales'),
  ('FT-JE-26','Post-operatorio De Cirugia Cardiaca'),
  ('FT-JE-27','Hoja De Anecdotario'),
  ('FT-JE-28','Censo De Supervisión Planta Baja Y Planta Alta'),
  ('FT-JE-29','Censo De Supervisión Ginecología, Pediatría, Cunero Y Ucin'),
  ('FT-JE-30','Censo De Supervisión Jp Ii, Uti, Terapia Intermedia'),
  ('FT-JE-31','Censo De Supervisión Urgencias'),
  ('FT-JE-32','Censo De Enfermeria'),
  ('FT-JE-33','Formato De Censo Diario De Pacientes (área Covid-19)'),
  ('FT-JE-34','Examen De Ingreso Enfemería General'),
  ('FT-JE-35','Educacion Al Paciente Y Familiar'),
  ('FT-JE-37','Exhaustivos De Material De Camilleria'),
  ('FT-JE-39','Productividad Servicio De Camilleria'),
  ('FT-JE-40','Registro De Enlace De Turno'),
  ('FT-JE-42','Vale De Ropa Sucia'),
  ('FT-JE-43','Vale De Instrumental Y Material O De Ropa Reusable'),
  ('FT-JE-44','Hoja De Enfermeria Cunero'),
  ('FT-JE-45','Bitacora Orden De Servicio Biomedico'),
  ('FT-JE-47','Censo Inhaloterapia'),
  ('FT-JE-48','Indicador De Prevención De Caidas A Pacientes'),
  ('FT-JE-49','Indicador De Prevención De Úlceras Por Presión'),
  ('FT-JE-50','Indicador Administración De Medicamentos Vía Oral'),
  ('FT-JE-51','Indicador Sonda Vesical Instalada'),
  ('FT-JE-52','Indicador Trato Digno'),
  ('FT-JE-53','Indicador Venoclisis Instalada'),
  ('FT-JE-55','Bitacora De Recepción De Bombas De Infusión'),
  ('FT-JE-56','Vale De Equipo Electromedico'),
  ('FT-JE-57','Solicitud De Prestamo De Expediente Clínico'),
  ('FT-JE-58','Registro De Material De Carro De Reanimación Abierto'),
  ('FT-JE-59','Registró Diario De Recepción De Carro De Reanimación Cerrado'),
  ('FT-JE-61','Control Y Registro De Temperatura De Refrigeradores En Centrales De Enfermeria'),
  ('FT-JE-62','Hoja De Enfermería De Rayos X'),
  ('FT-JE-63','Examen De Ingreso Enfermeria Auxiliar'),
  ('FT-JE-64','Hoja De Consumo De Urgencias'),
  ('FT-JE-65','Examen De Ingreso Camillería')
) AS d(code, name)
ON CONFLICT (code) DO UPDATE SET
  name            = EXCLUDED.name,
  department_id   = EXCLUDED.department_id,
  current_version = EXCLUDED.current_version,
  status          = EXCLUDED.status;

-- 3. Forzar department_id (por si el JOIN de INSERT no aplica)
UPDATE documents
SET department_id = (SELECT id FROM departments WHERE code = 'JE' LIMIT 1)
WHERE code LIKE 'FT-JE-%';

-- 4. Verificación
SELECT code, name, status
FROM documents
WHERE code LIKE 'FT-JE-%'
ORDER BY code;