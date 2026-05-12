-- ============================================================
--  BANCO DE SANGRE — Alta de 19 Instrucciones de Trabajo
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
--
--  DESPUÉS de ejecutar:
--  GRANT ALL ON documents TO anon, authenticated;
--  GRANT ALL ON document_content TO anon, authenticated;
-- ============================================================

INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, elaboration_date,
  elaborated_by, reviewed_by, custodian_position
)
SELECT
  d.code, d.name,
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments WHERE code = 'BS'),
  d.ver, 'vigente', '2026-01-30'::date,
  'Dra. Viridiana Valdez Toral',
  'Dra. Giselle Ivette De la Torre García',
  'Responsable sanitario del Banco de Sangre'
FROM (VALUES
  ('IT-BS-02','Instrucción de Trabajo de Fraccionamiento','05'),
  ('IT-BS-06','Instrucción de Trabajo de Hemoclasificación Técnica en Tubo','05'),
  ('IT-BS-07','Instrucción de Trabajo de Hemoclasificación en Tarjeta de Gel','05'),
  ('IT-BS-08','Instrucción de Trabajo de Determinación de Subgrupos A','05'),
  ('IT-BS-10','Instrucción de Trabajo de Rastreo de Anticuerpos Irregulares','05'),
  ('IT-BS-11','Instrucción de Trabajo de Identificación de Anticuerpos Irregulares','05'),
  ('IT-BS-14','Instrucción de Trabajo de Prueba de Compatibilidad Mayor','05'),
  ('IT-BS-15','Instrucción de Trabajo de Prueba de Compatibilidad Menor','05'),
  ('IT-BS-17','Instrucción de Trabajo de Control de Calidad de Hemocomponentes','05'),
  ('IT-BS-18','Instrucción de Trabajo de Determinación de Autocontrol','05'),
  ('IT-BS-19','Instrucción de Trabajo de Pruebas de Tamizaje (Quimioluminiscencia)','03'),
  ('IT-BS-20','Instrucción de Trabajo de Transfusión de Urgencias','03'),
  ('IT-BS-21','Instrucción de Trabajo de Prueba de Brucella','03'),
  ('IT-BS-22','Instrucción de Trabajo de Determinación de Fenotipo del RH','03'),
  ('IT-BS-23','Instrucción de Trabajo de Prueba de Antiglobulina Directa (PAD)','03'),
  ('IT-BS-24','Instrucción de Trabajo de Toma de Muestra y Biometría Hemática','03'),
  ('IT-BS-25','Instrucción de Trabajo de Flebotomía del Donador','03'),
  ('IT-BS-26','Instrucción de Trabajo de Aféresis Plaquetaria','03'),
  ('IT-BS-31','Instrucción de Trabajo de Control de Calidad de Reactivos Hemoclasificadores','03')
) AS d(code, name, ver)
ON CONFLICT (code) DO UPDATE SET
  name               = EXCLUDED.name,
  current_version    = EXCLUDED.current_version,
  status             = EXCLUDED.status,
  elaboration_date   = EXCLUDED.elaboration_date,
  elaborated_by      = EXCLUDED.elaborated_by,
  reviewed_by        = EXCLUDED.reviewed_by,
  custodian_position = EXCLUDED.custodian_position;
