-- ══════════════════════════════════════════════════════════════════
-- Cocina y Comedor (CC) — Alta de Documentos SGC
-- Hospital Santa Margarita · ISO 9001:2015 · Cláusula §7.5
--
-- Contenido:
--   PASO 1 → Crear departamento CC
--   PASO 2 → 7 Procesos  (PR-CC-01 … PR-CC-08)
--   PASO 3 → 9 Instrucciones de Trabajo (IT-CC-01 … IT-CC-11)
--   PASO 4 → 14 Formatos (FT-CC-01 … FT-CC-19) + FT-ALM-01
--   PASO 5 → 1 Reglamento (RG-CC-01)
--
-- Custodio: Jefa de Cocina y Comedor
-- Retención formatos: 6 meses → Archivo muerto
-- ══════════════════════════════════════════════════════════════════


-- ══ PASO 1: Departamento CC ═══════════════════════════════════════
INSERT INTO departments (code, name)
VALUES ('CC', 'Cocina y Comedor')
ON CONFLICT (code) DO NOTHING;


-- ══ PASO 2: Procesos (PR-CC) ══════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position, description
)
SELECT
  v.code, v.name,
  (SELECT id FROM document_types WHERE code_prefix = 'PR' LIMIT 1),
  (SELECT id FROM departments     WHERE code = 'CC'        LIMIT 1),
  '01', 'vigente', 'Jefa de Cocina y Comedor',
  v.description
FROM (VALUES

  ('PR-CC-01',
   'Proceso para la Recepción de Materia Prima',
   'Establece los criterios, actividades y responsables para la recepción e inspección de materia prima, verificando condiciones organolépticas, temperatura, fecha de caducidad y documentación del proveedor.'),

  ('PR-CC-02',
   'Proceso de Solicitud, Recepción y Almacenamiento de Materia Prima',
   'Define el flujo completo desde la solicitud de insumos al proveedor, su recepción bajo criterios de calidad sanitaria, hasta el almacenamiento ordenado con el sistema PEPS en el área de cocina.'),

  ('PR-CC-03',
   'Proceso de Abastecimiento de Alimentos para Pacientes, Familiares y Brigadistas durante Contingencias',
   'Establece las actividades y responsables para garantizar el suministro continuo de alimentos al personal, pacientes y familiares en situaciones de emergencia o contingencia hospitalaria.'),

  ('PR-CC-04',
   'Proceso de Toma de Muestras al Personal de Dietas',
   'Define el procedimiento para la toma de muestras microbiológicas (exudados, coprocultivos) al personal del área de dietas, como medida de vigilancia sanitaria y control de riesgos alimentarios.'),

  ('PR-CC-06',
   'Proceso de Calendarización de Capacitación al Personal en Buenas Prácticas de Manejo de Alimentos',
   'Establece la planificación, ejecución y seguimiento del programa de capacitación obligatoria en buenas prácticas de manufactura, higiene personal y manejo seguro de alimentos.'),

  ('PR-CC-07',
   'Proceso de Toma de Muestras de Alimentos',
   'Define el procedimiento para la toma, identificación, conservación y envío de muestras testigo de alimentos preparados, garantizando la trazabilidad ante eventos de enfermedad transmitida por alimentos.'),

  ('PR-CC-08',
   'Proceso de Limpieza y Desinfección de Insumos',
   'Establece las actividades, productos autorizados, concentraciones y frecuencias para la limpieza y desinfección correcta de insumos, utensilios y superficies del área de cocina.')

) AS v(code, name, description)
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  description       = EXCLUDED.description,
  updated_at        = now();


-- ══ PASO 3: Instrucciones de Trabajo (IT-CC) ══════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position, description
)
SELECT
  v.code, v.name,
  (SELECT id FROM document_types WHERE code_prefix = 'IT' LIMIT 1),
  (SELECT id FROM departments     WHERE code = 'CC'        LIMIT 1),
  '01', 'vigente', 'Jefa de Cocina y Comedor',
  v.description
FROM (VALUES

  ('IT-CC-01',
   'IT: Limpieza del Área de Cocina',
   'Describe paso a paso la técnica de limpieza y desinfección del área general de cocina: superficies de trabajo, pisos, paredes, campanas y equipos, con productos, concentraciones y frecuencias.'),

  ('IT-CC-02',
   'IT: Uso de Tablas de Cocina',
   'Establece la asignación y uso correcto del sistema de código de colores de tablas de corte para prevenir la contaminación cruzada entre grupos de alimentos.'),

  ('IT-CC-04',
   'IT: Abastecimiento de Productos y Materia Prima',
   'Describe el proceso operativo para el surtido y reabasto de productos e insumos desde el almacén al área de cocina, incluyendo verificación de cantidades y condiciones de conservación.'),

  ('IT-CC-06',
   'IT: Manejo Adecuado de Trapos en Cocina',
   'Establece el uso correcto, lavado, desinfección, codificación y sustitución de trapos y franelas en las distintas áreas de cocina para evitar la contaminación cruzada.'),

  ('IT-CC-07',
   'IT: Desinfección de Frutas y Verduras',
   'Describe la técnica, los productos desinfectantes autorizados y las concentraciones para la desinfección correcta de frutas y verduras antes de su preparación o entrega al paciente.'),

  ('IT-CC-08',
   'IT: Manejo de Máquina Lavaloza',
   'Establece la operación correcta de la máquina lavaloza: carga, temperaturas de operación, productos de lavado/enjuague, limpieza del equipo y acciones ante fallas.'),

  ('IT-CC-09',
   'IT: Toma de Temperaturas de Productos Cárnicos',
   'Define la técnica de verificación, el equipo de medición y los rangos de temperatura interna de cocción aceptables para los diferentes tipos de productos cárnicos servidos al paciente.'),

  ('IT-CC-10',
   'IT: Toma de Temperatura de Congelador y Cuarto Frío',
   'Establece la frecuencia, técnica de medición y registros de temperaturas de los equipos de refrigeración y congelación para garantizar la cadena de frío de los alimentos almacenados.'),

  ('IT-CC-11',
   'IT: Manejo Higiénico de Alimentos de Pacientes',
   'Describe las prácticas de higiene personal y de proceso obligatorias durante la preparación, porcionado, identificación y distribución de alimentos a pacientes hospitalizados.')

) AS v(code, name, description)
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  description       = EXCLUDED.description,
  updated_at        = now();


-- ══ PASO 4: Formatos (FT-CC + FT-ALM) ════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  retention_months, disposition, description
)
SELECT
  v.code, v.name,
  (SELECT id FROM document_types WHERE code_prefix = 'FT' LIMIT 1),
  (SELECT id FROM departments     WHERE code = 'CC'        LIMIT 1),
  '01', 'vigente', 'Jefa de Cocina y Comedor',
  6, 'Archivo muerto',
  v.description
FROM (VALUES

  ('FT-CC-01',
   'Bitácora de Control de Aceptación o Rechazo de Alimentos',
   'Registro de la inspección en recepción de materia prima: proveedor, producto, lote, temperatura, criterios de aceptación/rechazo y firma del responsable.'),

  ('FT-CC-02',
   'Formato de Lista de Compras Cocina',
   'Lista de requerimiento de insumos y materia prima para la programación semanal de compras del área de cocina, con cantidad, presentación y proveedor sugerido.'),

  ('FT-CC-03',
   'Formato de Orden de Compra',
   'Documento oficial de solicitud formal de compra de insumos al proveedor, con descripción, cantidades, precio unitario y autorización del responsable.'),

  ('FT-CC-05',
   'Bitácora de Almacenaje — Sistema PEPS',
   'Registro de entradas y salidas de insumos del almacén de cocina bajo el sistema Primero en Entrar, Primero en Salir (PEPS), con fecha, producto, lote y responsable.'),

  ('FT-CC-07',
   'Bitácora de Limpieza de Cocina',
   'Registro diario de actividades de limpieza y desinfección del área general de cocina: área, producto, concentración, frecuencia y firma del responsable.'),

  ('FT-CC-09',
   'Bitácora de Limpieza — Alacena de Hornos de Cocina',
   'Control de limpieza y desinfección periódica de la alacena donde se resguardan los hornos del área de cocina, con fecha, actividad realizada y firma.'),

  ('FT-CC-10',
   'Bitácora de Limpieza — Alacena de Loza de Pacientes',
   'Registro de limpieza y desinfección de la alacena de loza destinada al servicio de alimentos a pacientes hospitalizados.'),

  ('FT-CC-11',
   'Bitácora de Limpieza — Alacena Loza Cocina',
   'Control de limpieza y desinfección de la alacena de loza de uso interno en el área de cocina, con fecha, producto y responsable.'),

  ('FT-CC-12',
   'Bitácora de Limpieza — Almacén de Utensilios',
   'Registro de limpieza y desinfección del almacén de utensilios de cocina con frecuencia, producto utilizado y firma del responsable.'),

  ('FT-CC-14',
   'Bitácora de Cocción — Temperatura',
   'Registro de temperaturas internas de cocción de alimentos preparados en cocina para garantizar la inocuidad y cumplimiento de puntos críticos de control (HACCP).'),

  ('FT-CC-15',
   'Bitácora de Temperatura del Congelador',
   'Registro diario de temperatura del congelador del área de cocina en los turnos establecidos, con valores límite y acción correctiva en caso de desviación.'),

  ('FT-CC-16',
   'Formato de Requisición de Insumo',
   'Solicitud interna de insumos y materias primas al almacén de cocina: descripción del artículo, cantidad requerida, área solicitante y autorización.'),

  ('FT-CC-17',
   'Cronograma de Limpieza General de Cocina',
   'Programa periódico de limpieza profunda de todas las áreas, equipos, ductos y superficies de cocina con responsables asignados, fechas y evidencia de cumplimiento.'),

  ('FT-CC-19',
   'Código de Colores de Tablas de Cocina',
   'Referencia visual del sistema de código de colores para el uso correcto de tablas de corte por grupo de alimento, con el objetivo de prevenir la contaminación cruzada.'),

  ('FT-ALM-01',
   'Bitácora de Salida de Insumos — Almacén Cocina',
   'Registro de salidas de insumos y materia prima del almacén de cocina: fecha, producto, cantidad, área de destino, folio de requisición y firma del responsable.')

) AS v(code, name, description)
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  description       = EXCLUDED.description,
  retention_months  = EXCLUDED.retention_months,
  disposition       = EXCLUDED.disposition,
  updated_at        = now();


-- ══ PASO 5: Reglamento (RG-CC) ════════════════════════════════════
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position, description
)
SELECT
  'RG-CC-01',
  'Reglamento para Otorgamiento de Alimentos al Personal Médico',
  (SELECT id FROM document_types WHERE code_prefix = 'RG' LIMIT 1),
  (SELECT id FROM departments     WHERE code = 'CC'        LIMIT 1),
  '01', 'vigente', 'Jefa de Cocina y Comedor',
  'Establece las condiciones, criterios de elegibilidad y restricciones para el suministro de alimentos al personal médico, guardias de turno y personal autorizado del hospital.'
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  description       = EXCLUDED.description,
  updated_at        = now();


-- ══ Verificación ══════════════════════════════════════════════════
SELECT
  dt.code_prefix  AS tipo,
  d.code,
  LEFT(d.name, 55) AS nombre,
  d.current_version AS ver,
  d.status
FROM documents d
JOIN document_types dt  ON dt.id  = d.document_type_id
JOIN departments    dep ON dep.id = d.department_id
WHERE dep.code = 'CC'
ORDER BY dt.code_prefix, d.code;
