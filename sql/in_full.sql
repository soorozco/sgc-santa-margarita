-- ============================================================
--  Intendencia — Registro y contenido digital de documentos IN
--  Hospital Santa Margarita · SGC ISO 9001:2015
-- ============================================================

-- ── Asegurar columnas extendidas en documents ────────────────
ALTER TABLE documents ADD COLUMN IF NOT EXISTS issue_date      date;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS elaboro_nombre  text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS elaboro_cargo   text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS reviso_nombre   text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS reviso_cargo    text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS autorizo_nombre text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS autorizo_cargo  text;

-- Asegurarse que el departamento Intendencia exista
INSERT INTO departments (code, name, is_active)
VALUES ('IN', 'Intendencia', true)
ON CONFLICT (code) DO NOTHING;

-- ═══ REGISTRAR DOCUMENTOS ═══

-- IT-IN-01
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-IN-01', 'Instrucción de Trabajo para el Aseo Exhaustivo en Habitaciones (Área Crítica)',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '2', 'vigente', 'Jefatura de Intendencia',
  '2024-06-17',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Enf. Claudia Filiberta Rivera Ortega',  'Jefatura de Intendencia',
  'Lic. Maria Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-IN-02
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-IN-02', 'Instrucción de Trabajo para la Limpieza y Desinfección de Baños',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '3', 'vigente', 'Jefatura de Intendencia',
  '2024-06-17',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Enf. Claudia Filiberta Rivera Ortega',  'Jefatura de Intendencia',
  'Lic. Maria Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-IN-03
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-IN-03', 'Instrucción de Trabajo para Limpieza y Desinfección de Camas',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '2', 'vigente', 'Jefatura de Intendencia',
  '2024-06-17',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Enf. Claudia Filiberta Rivera Ortega',  'Jefatura de Intendencia',
  'Lic. Maria Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-IN-04
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-IN-04', 'Instrucción de Trabajo para la Limpieza de Áreas No Críticas',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '2', 'vigente', 'Jefatura de Intendencia',
  '2024-06-17',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Enf. Claudia Filiberta Rivera Ortega',  'Jefatura de Intendencia',
  'Lic. Maria Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-IN-05
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-IN-05', 'Instrucción de Trabajo para Limpieza Exhaustiva',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '3', 'vigente', 'Jefatura de Intendencia',
  '2024-06-17',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Enf. Claudia Filiberta Rivera Ortega',  'Jefatura de Intendencia',
  'Lic. Maria Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-IN-06
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-IN-06', 'Instrucción de Trabajo para la Limpieza Rutinaria en Habitaciones',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '2', 'vigente', 'Jefatura de Intendencia',
  '2024-06-17',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Seguridad e Higiene y Medio Ambiente',
  'Enf. Claudia Filiberta Rivera Ortega',  'Jefatura de Intendencia',
  'Lic. Maria Elena Martínez Alvarado',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-IN-07
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-IN-07', 'Instrucción de Trabajo para la Limpieza y Desinfección de Refrigeradores de Medicamentos',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '2', 'obsoleto', 'Jefatura de Intendencia',
  '2024-02-14',
  'Lic. Rosa Isela López Astorga', 'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-IN-08
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-IN-08', 'Instrucción de Trabajo para la Supervisión de Limpieza de Áreas',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '1', 'obsoleto', 'Jefatura de Intendencia',
  '2022-04-08',
  'I.A. Alizbeydi Vázquez Serafín', 'Jefatura de Intendencia',
  'Doc. Manuel Cortés Gutiérrez',  'Jefatura de Epidemiología',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;
-- IT-IN-09
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  'IT-IN-09', 'Instrucción de Trabajo para Limpieza y Desinfección de Áreas (Ordinaria)',
  (SELECT id FROM document_types WHERE code_prefix = 'IT'),
  (SELECT id FROM departments     WHERE code = 'IN'),
  '3', 'obsoleto', 'Jefatura de Intendencia',
  '2024-02-14',
  'Lic. Rosa Isela López Astorga', 'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa',
  'Lic. Rosa Isela López Astorga',  'Dirección Administrativa'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = 'IN')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;

-- ═══ CARGAR CONTENIDO DIGITAL ═══

-- Contenido: IT-IN-01
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Esta actividad inicia cuando el personal de intendencia toma el vale de aseo correspondiente a la habitación y termina cuando realiza su higiene de manos, posterior a la desinfección de su material.', 'Esta actividad inicia cuando el personal de intendencia toma el vale de aseo correspondiente a la habitación y termina cuando realiza su higiene de manos, posterior a la desinfección de su material.',
  '[]'::jsonb, '[]'::jsonb,
  '["Vale de aseo", "Carro de limpieza", "2 escobas (habitación y baño)", "Recogedor", "2 trapeadores (etiquetados por área y exclusivo para baño)", "4 cubetas (roja, amarilla, verde y azul)", "Guantes (rojos, amarillos, verdes y azules)", "4 trapos (rojo, amarillo, verde y azul)", "Cepillo para baño de mango largo", "2 fibras (1 lavabo y 1 para el WC)", "2 palanganas", "Bolsas medianas y/o jumbo", "Bolsas de camiseta", "Jabón en polvo", "Desinfectante", "Aromatizante", "Atomizador con alcohol", "Suministro de insumos: jabón de manos, papel higiénico y sanitas", "Equipo de protección personal"]'::jsonb, '[{"no": "1", "responsable": "Auxiliar de Intendencia", "actividad": "Consultar el vale de control para preparación de habitaciones y/o cubículos emitidos por el área de epidemiología y corroborar que el vale corresponda a la habitación y esté firmado. Nota: En dado caso que no coincida o exista duda, dirigirse con su supervisora o el personal de epidemiología para la confirmación de aseo."}, {"no": "2", "responsable": "Auxiliar de Intendencia", "actividad": "Acerca el carro de limpieza a la habitación con el material e insumos necesarios. Nota: si se trata de un aseo supervisado/nebulizado o cultivo deberá usar obligatoriamente equipo de protección personal (bata quirúrgica de manga larga, cubrebocas y cofia)."}, {"no": "3", "responsable": "Auxiliar de Intendencia", "actividad": "Realizar la limpieza exhaustiva en la habitación. Ver instrucción de trabajo para limpieza exhaustiva (IT-IN-05)."}, {"no": "4", "responsable": "Auxiliar de Intendencia", "actividad": "Registrar la fecha y hora en el vale de aseo y firmar."}, {"no": "5", "responsable": "Auxiliar de Intendencia", "actividad": "Realizar la técnica de higiene de manos."}, {"no": "6", "responsable": "Auxiliar de Intendencia", "actividad": "Informa a la supervisora en turno que se ha realizado la limpieza de la habitación para su revisión."}, {"no": "7", "responsable": "Supervisora en turno", "actividad": "Acude a la habitación solicitada y realiza la revisión de la misma, corroborando que la limpieza y desinfección del área se haya realizado correctamente. Registrar en el formato de Supervisión de intendencia. Nota: si encuentra detalles de suciedad le informa a la auxiliar para su corrección."}, {"no": "8", "responsable": "Supervisora en turno", "actividad": "Firma el vale de control para preparación de habitaciones y/o cubículos una vez que haya verificado la limpieza correcta de la habitación y lo deposita en el tarjetero correspondiente de la habitación."}, {"no": "9", "responsable": "Supervisora en turno", "actividad": "Informa que se ha realizado la limpieza de la habitación."}]'::jsonb, '[{"riesgo": "No realizar adecuadamente la limpieza exhaustiva de la habitación.", "barrera": "Capacitación al personal sobre las técnicas de limpieza y desinfección de áreas."}, {"riesgo": "Falta de insumos.", "barrera": "Verificar constantemente el stock de insumos."}]'::jsonb,
  '[{"nombre": "Vale de control para preparación de habitaciones y/o cubículos", "codigo": "FT-UV-16"}, {"nombre": "Instrucción de trabajo para limpieza exhaustiva", "codigo": "IT-IN-05"}, {"nombre": "Hoja de supervisión de intendencia", "codigo": "FT-IN-11"}]'::jsonb, '[{"version": "01", "fecha": "18/06/2021", "descripcion": "Alta de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "17/06/2024", "descripcion": "Modificación de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'IT-IN-01'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-IN-02
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Esta actividad inicia cuando el personal de intendencia realiza la limpieza y desinfección del baño y termina cuando suministra insumos.', 'Esta actividad inicia cuando el personal de intendencia realiza la limpieza y desinfección del baño y termina cuando suministra insumos.',
  '[]'::jsonb, '[]'::jsonb,
  '["Kit de limpieza exclusivo para baños: cubeta, guantes y trapo color rojo", "Trapeador exclusivo para baño", "Cepillo para baño", "Cepillo de mango largo", "2 fibras (WC y lavabo)", "Palangana", "Bolsas de camiseta", "Jabón en polvo", "Desinfectante", "Aromatizante", "Atomizador con alcohol", "Suministro de insumos: jabón de manos, papel higiénico y sanitas"]'::jsonb, '[{"no": "1", "responsable": "Auxiliar de Intendencia", "actividad": "Retira basura, accesorios y suministros de baño. Preparar su dilución desinfectante en la cubeta correspondiente."}, {"no": "2", "responsable": "Auxiliar de Intendencia", "actividad": "Lavado y desinfección de WC. Si no hará uso de quita sarro, iniciar con el paso 2.4. 2.1 Aplicar el quita sarro y dejar actuar 5 minutos. 2.2 Tallar con fibra y cepillo las superficies. 2.3 Enjuagar con agua limpia y dejar transcurrir 10 minutos. 2.4 Aplicar detergente y tallar con fibra y cepillo. 2.5 Enjuagar con agua limpia. 2.6 Aplicar desinfectante y tallar con fibra y cepillo, luego retirar con agua. 2.7 Limpiar excesos de agua con el trapo exclusivo para baños."}, {"no": "3", "responsable": "Auxiliar de Intendencia", "actividad": "Lavado y desinfección de lavabo. Se aplicará quita sarro sólo si es necesario. 3.1 Aplicar quita sarro excepto en partes cromadas, dejar actuar 5 minutos. 3.2 Tallar con fibra. 3.3 Enjuagar y dejar transcurrir 10 minutos. 3.4 Aplicar detergente, tallar y enjuagar. 3.5 Repetir con desinfectante. 3.6 Limpiar excesos de agua."}, {"no": "4", "responsable": "Auxiliar de Intendencia", "actividad": "Lavado y desinfección del área de regadera. 4.1 Aplicar quita sarro donde sea necesario (excepto partes cromadas), dejar actuar 5 minutos. 4.2 Tallar con fibra. 4.3 Enjuagar y dejar transcurrir 10 minutos. 4.4 Aplicar detergente y tallar con cepillo de mango largo. 4.5 Enjuagar y repetir con desinfectante. 4.6 Enjuagar para retirar residuos."}, {"no": "5", "responsable": "Auxiliar de Intendencia", "actividad": "Lavado y desinfección de paredes y pisos. 5.1 Aplicar detergente en paredes y piso. 5.2 Tallar paredes de arriba hacia abajo, manchas difíciles en forma circular. 5.3 Tallar pisos de adentro hacia afuera en zigzag. 5.4 Retirar con agua y aplicar dilución desinfectante repitiendo el proceso. 5.5 Enjuagar y limpiar excesos de agua."}, {"no": "6", "responsable": "Auxiliar de Intendencia", "actividad": "Limpiar espejos y vidrios."}, {"no": "7", "responsable": "Auxiliar de Intendencia", "actividad": "Trapear con aromatizante todo el piso del baño."}, {"no": "8", "responsable": "Auxiliar de Intendencia", "actividad": "Lavar los cestos de basura y una vez secos colocarlos en su lugar con bolsa limpia."}, {"no": "9", "responsable": "Auxiliar de Intendencia", "actividad": "Suministra los insumos necesarios para el baño: papel higiénico, sanitas, jabón de manos."}, {"no": "10", "responsable": "Auxiliar de Intendencia", "actividad": "Si el baño es de uso público o personal, registrar su limpieza."}]'::jsonb, '[{"riesgo": "Baños antihigiénicos con faltante de insumos.", "barrera": "Verificación y supervisión continua por el personal correspondiente."}, {"riesgo": "Intoxicación por productos de limpieza.", "barrera": "Supervisión de actividad y etiquetado de sustancias en base al Sistema Globalmente Armonizado."}]'::jsonb,
  '[{"nombre": "Aseo de baños", "codigo": "FT-IN-01"}]'::jsonb, '[{"version": "01", "fecha": "12/05/2021", "descripcion": "Alta de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "09/01/2023", "descripcion": "Modificación de documento", "realizado": "Lic. Graciela Gutiérrez Galizonga", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "03", "fecha": "17/06/2024", "descripcion": "Modificación de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'IT-IN-02'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-IN-03
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Esta actividad inicia una vez que el personal de intendencia verifica que la cama se encuentra libre de ropa sucia y finaliza cuando se ha limpiado y desinfectado en su totalidad.', 'Esta actividad inicia una vez que el personal de intendencia verifica que la cama se encuentra libre de ropa sucia y finaliza cuando se ha limpiado y desinfectado en su totalidad.',
  '[]'::jsonb, '[]'::jsonb,
  '["Carrito de limpieza", "Material de limpieza exclusivo para cama y colchón (cubeta, guantes y franela verde)", "Desinfectante (hipoclorito de sodio al 0.5%)"]'::jsonb, '[{"no": "1", "responsable": "Auxiliar de Intendencia", "actividad": "Acerca el carrito de limpieza con el material e insumos necesarios para realizar la limpieza de la cama y colchón. Utilizar el material correspondiente al color verde (exclusivo cama y colchón)."}, {"no": "2", "responsable": "Auxiliar de Intendencia", "actividad": "Preparar una dilución desinfectante de hipoclorito de sodio al 0.5% en el contenedor correspondiente (38 ml de hipoclorito al 13% por litro de agua, o 83 ml al 6%)."}, {"no": "3", "responsable": "Auxiliar de Intendencia", "actividad": "Con técnicas seguras, moverá y recargará el colchón sobre los barandales de la cama para proceder a limpiarla."}, {"no": "4", "responsable": "Auxiliar de Intendencia", "actividad": "Se inicia limpiando todas las superficies de la cama con el trapo humedecido con desinfectante en el siguiente orden: 1. Cabecera, 2. Base superior e inferior, 3. Motores de elevación y articulación, 4. Piecera, 5. Ruedas, 6. Barandales."}, {"no": "5", "responsable": "Auxiliar de Intendencia", "actividad": "Limpiar el colchón pasando el trapo humedecido con solución desinfectante por todo el espacio sin omitir nada y repetir con el extremo opuesto."}, {"no": "6", "responsable": "Auxiliar de Intendencia", "actividad": "Eliminar los excesos de agua pasando una vez más el trapo por ambos lados."}, {"no": "7", "responsable": "Auxiliar de Intendencia", "actividad": "En caso de que el colchón sea de esponja y se le pueda retirar el forro, deberá retirarlo y lavarlo en la lavandería."}]'::jsonb, '[{"riesgo": "Proliferación de bacterias por la limpieza inadecuada de cama y colchón.", "barrera": "Capacitación, verificación y supervisión continua de limpieza por personal correspondiente."}, {"riesgo": "Falta de insumos de limpieza.", "barrera": "Supervisión de abasto en las distintas áreas y en stock."}]'::jsonb,
  '[]'::jsonb, '[{"version": "01", "fecha": "14/02/2022", "descripcion": "Alta de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "17/06/2024", "descripcion": "Modificación de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'IT-IN-03'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-IN-04
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Esta instrucción de trabajo da inicio cuando el personal de intendencia realiza la limpieza de un área no crítica (oficinas, almacenes, áreas de descanso, patios o cualquier área sin riesgo de contaminación) y termina cuando el personal le firma de conformidad.', 'Esta instrucción de trabajo da inicio cuando el personal de intendencia realiza la limpieza de un área no crítica (oficinas, almacenes, áreas de descanso, patios o cualquier área sin riesgo de contaminación) y termina cuando el personal le firma de conformidad.',
  '[]'::jsonb, '[]'::jsonb,
  '["Carro de limpieza", "2 escobas (oficinas y baño)", "Recogedor", "2 trapeadores (oficinas y baño)", "Cubetas (roja y azul)", "Guantes (rojos y azules)", "2 franelas (rojo y azul)", "Cepillo para baño de mango largo", "2 fibras (lavabo y WC)", "2 palanganas", "Bolsas medianas y/o jumbo", "Bolsas de camiseta", "Jabón en polvo", "Desinfectante", "Aromatizante", "Atomizador con alcohol", "Suministro de insumos: jabón de manos, papel higiénico y sanitas"]'::jsonb, '[{"no": "1", "responsable": "Auxiliar de Intendencia", "actividad": "Acerca el carrito de limpieza al área (oficina, pasillos, escaleras, consultorios, etc.) con el material e insumos necesarios."}, {"no": "2", "responsable": "Auxiliar de Intendencia", "actividad": "Retira la basura de los contenedores y la deposita en la bolsa de recolección correspondiente. Nota: Deberá colocar el letrero de precaución en caso de limpiar pasillos, patios o escaleras."}, {"no": "3", "responsable": "Auxiliar de Intendencia", "actividad": "Usar el material clasificado por color exclusivamente para esta zona. 3.1 Preparar la dilución desinfectante. 3.2 Eliminar el polvo de superficies de muebles, paredes, puertas, etc. 3.3 Realizar un barrido general. 3.4 Trapear primero con dilución desinfectante y posteriormente con solución aromatizante. Nunca mezclar los productos químicos."}, {"no": "4", "responsable": "Auxiliar de Intendencia", "actividad": "En caso de que el área cuente con baño, realizar la limpieza adecuada conforme a la instrucción IT-IN-02."}, {"no": "5", "responsable": "Auxiliar de Intendencia", "actividad": "Surtirá de insumos (sanitas, jabón para manos, papel higiénico) en caso de que lo requiera el área."}, {"no": "6", "responsable": "Auxiliar de Intendencia", "actividad": "Solicita al personal del área que le firme de conformidad. Registro de limpieza rutinaria (FT-IN-08)."}]'::jsonb, '[{"riesgo": "Omitir la limpieza rutinaria de las áreas.", "barrera": "Registro de conformidad en bitácoras y supervisión."}, {"riesgo": "Intoxicación por productos de limpieza.", "barrera": "Etiquetado de sustancias en base al Sistema Globalmente Armonizado."}, {"riesgo": "Falta de insumos de higiene en las áreas.", "barrera": "Supervisión de abasto en las distintas áreas."}]'::jsonb,
  '[{"nombre": "Instrucción de trabajo para la limpieza y desinfección de baños", "codigo": "IT-IN-02"}, {"nombre": "Registro de limpieza ordinaria", "codigo": "FT-IN-08"}]'::jsonb, '[{"version": "01", "fecha": "14/02/2022", "descripcion": "Alta de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "17/06/2024", "descripcion": "Modificación de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'IT-IN-04'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-IN-05
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Esta instrucción de trabajo da inicio cuando el personal de intendencia realiza la limpieza exhaustiva de un área y termina cuando el personal le firma de conformidad.', 'Esta instrucción de trabajo da inicio cuando el personal de intendencia realiza la limpieza exhaustiva de un área y termina cuando el personal le firma de conformidad.',
  '[]'::jsonb, '[]'::jsonb,
  '["Carro de limpieza", "2 escobas", "Recogedor", "2 trapeadores", "Cubetas", "Guantes", "Trapos de limpieza", "Cepillo para baño de mango largo", "2 fibras (lavabo y WC)", "2 palanganas", "Bolsas medianas y/o jumbo", "Bolsas de camiseta", "Jabón en polvo", "Desinfectante", "Aromatizante", "Atomizador con alcohol", "Suministro de insumos: jabón de manos, papel higiénico y sanitas"]'::jsonb, '[{"no": "1", "responsable": "Auxiliar de Intendencia", "actividad": "Antes de iniciar, tener en cuenta los principios básicos de limpieza: De arriba hacia abajo (techos, lámparas, paredes, suelo); De adentro hacia afuera; De lo limpio a lo sucio; Del centro a la periferia. En caso de encontrar fluidos corporales o materia orgánica, inactivar con hipoclorito de sodio al 1.0% dejando actuar 10 minutos y posteriormente remover."}, {"no": "2", "responsable": "Auxiliar de Intendencia", "actividad": "Recorrer todos los muebles al centro del área de ser necesario."}, {"no": "3", "responsable": "Auxiliar de Intendencia", "actividad": "Preparar la dilución desinfectante en cada uno de los contenedores en base al área a desinfectar."}, {"no": "4", "responsable": "Auxiliar de Intendencia", "actividad": "Con la franela humedecida en dilución desinfectante, eliminar el polvo y suciedad de paredes (usando cepillo de mango largo para zonas superiores, de arriba hacia abajo) y zonas de contacto con el paciente (tomas de oxígeno, recetario, tripié), usando el material exclusivo para cada zona."}, {"no": "5", "responsable": "Auxiliar de Intendencia", "actividad": "Con otra franela humedecida en dilución desinfectante, eliminar el polvo y suciedad de las superficies de muebles, puertas, objetos, ventanas y electrodomésticos con el material de limpieza exclusivo para esta zona."}, {"no": "6", "responsable": "Auxiliar de Intendencia", "actividad": "Realizar la limpieza de cama y colchón conforme a la instrucción IT-IN-03."}, {"no": "7", "responsable": "Auxiliar de Intendencia", "actividad": "Realizar un barrido general por toda el área con la escoba exclusiva para esa zona."}, {"no": "8", "responsable": "Auxiliar de Intendencia", "actividad": "Realizar la limpieza del baño si lo hay, siguiendo la instrucción IT-IN-02."}, {"no": "9", "responsable": "Auxiliar de Intendencia", "actividad": "Una vez lavado y desinfectado el baño, trapear el área faltante con dilución desinfectante y posteriormente con solución aromatizante."}, {"no": "10", "responsable": "Auxiliar de Intendencia", "actividad": "Lavar los cestos de basura y una vez secos colocarlos en su lugar con la bolsa limpia correspondiente."}]'::jsonb, '[{"riesgo": "Limpieza y desinfección inadecuada.", "barrera": "Verificación y supervisión de limpieza por personal correspondiente."}, {"riesgo": "Intoxicación por productos de limpieza.", "barrera": "Etiquetado de sustancias en base al Sistema Globalmente Armonizado."}, {"riesgo": "Falta de insumos de limpieza.", "barrera": "Supervisión de abasto en las distintas áreas y en stock."}]'::jsonb,
  '[{"nombre": "Instrucción de trabajo para la limpieza y desinfección de baños", "codigo": "IT-IN-02"}, {"nombre": "Instrucción de trabajo para la limpieza y desinfección de camas", "codigo": "IT-IN-03"}]'::jsonb, '[{"version": "01", "fecha": "12/05/2021", "descripcion": "Alta de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "09/01/2023", "descripcion": "Modificación de documento", "realizado": "Lic. Graciela Gutiérrez Galizonga", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "03", "fecha": "17/06/2024", "descripcion": "Modificación de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'IT-IN-05'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-IN-06
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Esta actividad inicia cuando el personal de intendencia ingresa a una habitación con paciente para realizar la limpieza diaria y termina cuando el familiar del paciente firma de conformidad.', 'Esta actividad inicia cuando el personal de intendencia ingresa a una habitación con paciente para realizar la limpieza diaria y termina cuando el familiar del paciente firma de conformidad.',
  '[]'::jsonb, '[]'::jsonb,
  '["Carro de limpieza", "2 escobas (habitación y baño)", "Recogedor", "2 trapeadores (habitación y baño)", "Cubetas (amarilla y azul)", "Guantes (amarillos y azules)", "2 franelas (amarillo y azul)", "Cepillo para baño de mango largo", "2 fibras (lavabo y WC)", "2 palanganas", "Bolsas medianas y/o jumbo", "Bolsas de camiseta", "Jabón en polvo", "Desinfectante", "Aromatizante", "Atomizador con alcohol", "Suministro de insumos: jabón de manos, papel higiénico y sanitas"]'::jsonb, '[{"no": "1", "responsable": "Auxiliar de Intendencia", "actividad": "Acerca el carrito de limpieza a la habitación con los materiales e insumos necesarios."}, {"no": "2", "responsable": "Auxiliar de Intendencia", "actividad": "Avisa al paciente y/o familiares de su intención de ingresar tocando la puerta e informa que realizará la limpieza."}, {"no": "3", "responsable": "Auxiliar de Intendencia", "actividad": "Retira la basura de los contenedores y la deposita en la bolsa de recolección correspondiente."}, {"no": "4", "responsable": "Auxiliar de Intendencia", "actividad": "Revisa si hay fluidos corporales en el piso. En caso de haberlos, cubrir con solución de hipoclorito de sodio al 1.0% durante 10 minutos y cubrir con papel para posteriormente removerlos."}, {"no": "5", "responsable": "Auxiliar de Intendencia", "actividad": "Limpieza de habitación: 5.1 Realizar la limpieza de muebles y objetos. 5.2 Realizar un barrido general. 5.3 Trapear con solución aromatizante. Usar el material clasificado por color exclusivamente para esta zona."}, {"no": "6", "responsable": "Auxiliar de Intendencia", "actividad": "Limpieza de baño: 6.1 Limpiar espejo, porta sanitas y accesorios. 6.2 Barrer el baño. 6.3 Tallar el lavabo con fibra. 6.4 Enjuagar. 6.5 Limpiar con franela. 6.6 Limpiar el inodoro con cepillo. 6.7 Enjuagar. 6.8 Trapear con solución aromatizante. Usar el material clasificado por color exclusivo para el baño."}, {"no": "7", "responsable": "Auxiliar de Intendencia", "actividad": "Surtirá de insumos (sanitas, jabón para manos, papel higiénico) en caso de requerirlo."}, {"no": "8", "responsable": "Auxiliar de Intendencia", "actividad": "Solicita al paciente o familiar que le firme de conformidad con el servicio realizado. Registro de limpieza rutinaria (FT-IN-08)."}]'::jsonb, '[{"riesgo": "Omisión de limpieza rutinaria a la habitación generando inconformidad del paciente o familiar.", "barrera": "Registro de conformidad de limpieza rutinaria realizada."}, {"riesgo": "Intoxicación por productos de limpieza.", "barrera": "Etiquetado de sustancias en base al Sistema Globalmente Armonizado."}, {"riesgo": "Falta de insumos de higiene en las habitaciones.", "barrera": "Inventario constante y stock suficiente de insumos."}]'::jsonb,
  '[{"nombre": "Registro de limpieza ordinaria", "codigo": "FT-IN-08"}]'::jsonb, '[{"version": "01", "fecha": "08/04/2022", "descripcion": "Alta de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "02", "fecha": "17/06/2024", "descripcion": "Modificación de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate"}]'::jsonb
FROM documents d WHERE d.code = 'IT-IN-06'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-IN-07
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Esta instrucción de trabajo da inicio cuando el personal de intendencia realiza la limpieza de refrigeradores y finaliza una vez que hace el registro de la actividad.', 'Esta instrucción de trabajo da inicio cuando el personal de intendencia realiza la limpieza de refrigeradores y finaliza una vez que hace el registro de la actividad.',
  '[]'::jsonb, '[]'::jsonb,
  '["2 paños limpios", "1 paquete mediano de gasa estéril", "Solución detergente (agua con jabón neutro)", "Solución desinfectante (Alpet D2)", "Atomizador"]'::jsonb, '[{"no": "1", "responsable": "Auxiliar de Intendencia", "actividad": "Preparar una solución detergente de agua y jabón neutro. Nota: Realizar esta instrucción cada viernes del último mes o según la necesidad del equipo."}, {"no": "2", "responsable": "Auxiliar de Intendencia", "actividad": "Humedecer un paño limpio con la solución detergente y limpiar a profundidad las superficies internas del refrigerador con movimientos en zigzag y de arriba hacia abajo."}, {"no": "3", "responsable": "Auxiliar de Intendencia", "actividad": "Humedecer el otro paño limpio con agua para retirar en su totalidad los excesos del detergente."}, {"no": "4", "responsable": "Auxiliar de Intendencia", "actividad": "Con un atomizador, esparcir la solución desinfectante (Alpet D2) en todas las superficies internas del refrigerador y dejar que actúe por 2 minutos."}, {"no": "5", "responsable": "Auxiliar de Intendencia", "actividad": "Retirar los residuos de la solución desinfectante con una gasa estéril haciendo movimientos en zigzag y de arriba hacia abajo."}, {"no": "6", "responsable": "Auxiliar de Intendencia", "actividad": "Registrar la actividad realizada en FT-FH-22 Registro de limpieza y desinfección de refrigeradores para medicamentos."}]'::jsonb, '[{"riesgo": "Contaminación bacteriana por la incorrecta desinfección del equipo.", "barrera": "Capacitación al personal sobre la técnica correcta de limpieza y desinfección."}, {"riesgo": "Daños a la salud por el manejo incorrecto de sustancias.", "barrera": "Capacitación al personal sobre el correcto manejo de sustancias químicas."}, {"riesgo": "Falta de insumos.", "barrera": "Inventario constante de los insumos de limpieza y desinfección."}]'::jsonb,
  '[{"nombre": "Registro de limpieza y desinfección de refrigeradores para medicamentos", "codigo": "FT-FH-22"}]'::jsonb, '[{"version": "01", "fecha": "08/04/2022", "descripcion": "Alta de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate Bautista"}, {"version": "02", "fecha": "14/02/2024", "descripcion": "Modificación de documento", "realizado": "Lic. Rosa Isela López Astorga", "aprobado": "Mtra. Ana Cecilia Zárate Bautista"}]'::jsonb
FROM documents d WHERE d.code = 'IT-IN-07'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-IN-08
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Esta actividad inicia cuando la supervisora de turno recibe la indicación de realizar la limpieza y desinfección de un área y finaliza cuando verifica que la limpieza se ha ejecutado correctamente.', 'Esta actividad inicia cuando la supervisora de turno recibe la indicación de realizar la limpieza y desinfección de un área y finaliza cuando verifica que la limpieza se ha ejecutado correctamente.',
  '[]'::jsonb, '[]'::jsonb,
  '["Vale de control para preparación de habitaciones y/o cubículos (FT-UV-16)", "Check list de limpieza de habitaciones (FT-IN-02)"]'::jsonb, '[{"no": "1", "responsable": "Auxiliar de Intendencia", "actividad": "Solicitar la revisión de la limpieza de la habitación o área a la supervisora de turno."}, {"no": "2", "responsable": "Supervisora en turno", "actividad": "Acude a la habitación solicitada y realiza la revisión verificando que la limpieza y desinfección se haya realizado correctamente. Inspecciona el área en base al FT-IN-02 revisando paredes, objetos, cama, colchón, baños, electrodomésticos, etc. 2.1 Si encontró detalles de polvo o suciedad, se los comunica al auxiliar y procede al paso 3. 2.2 Si la limpieza se realizó correctamente, continúa al paso 4."}, {"no": "3", "responsable": "Auxiliar de Intendencia", "actividad": "Corregir los detalles encontrados."}, {"no": "4", "responsable": "Supervisora en turno", "actividad": "Firma el FT-UV-16 Vale de control para preparación de habitaciones y/o cubículos como registro de la supervisión de la habitación."}]'::jsonb, '[{"riesgo": "Encontrar detalles de suciedad o polvo en el área donde se realizó la limpieza.", "barrera": "Capacitación al personal sobre la limpieza y desinfección de áreas."}]'::jsonb,
  '[{"nombre": "Checklist de limpieza de habitaciones", "codigo": "FT-IN-02"}, {"nombre": "Vale de control para preparación de habitaciones y/o cubículos", "codigo": "FT-UV-16"}]'::jsonb, '[{"version": "01", "fecha": "08/04/2022", "descripcion": "Alta de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate Bautista"}]'::jsonb
FROM documents d WHERE d.code = 'IT-IN-08'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;
-- Contenido: IT-IN-09
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  'Esta actividad inicia cuando el personal de intendencia recibe la indicación de realizar la limpieza y desinfección de un área y finaliza cuando se verifica que el aseo se ha ejecutado correctamente.', 'Esta actividad inicia cuando el personal de intendencia recibe la indicación de realizar la limpieza y desinfección de un área y finaliza cuando se verifica que el aseo se ha ejecutado correctamente.',
  '[]'::jsonb, '[]'::jsonb,
  '["Carro de aseo correspondiente al área", "2 escobas rotuladas de acuerdo al uso destinado (habitación y baño)", "1 recogedor", "2 trapeadores rotulados de acuerdo al uso destinado (habitación y baño)", "4 cubetas (roja, amarilla, verde y azul)", "4 pares de guantes (rojos, amarillos, verdes y azules)", "4 franelas (rojo, amarillo, verde y azul)", "1 cepillo para baño", "2 fibras (sanitario y lavabo)", "Detergente en polvo", "Cloro (hipoclorito de sodio)", "Aromatizante", "Bolsas", "Suministro de insumos: jabón de manos, papel higiénico y sanitas"]'::jsonb, '[{"no": "1", "responsable": "Jefatura de Intendencia", "actividad": "Genera mensualmente un FT-IN-06 cronograma de limpieza ordinaria."}, {"no": "2", "responsable": "Supervisora en turno", "actividad": "Asigna el área en la que se realizará la limpieza exhaustiva al auxiliar de intendencia en base al cronograma."}, {"no": "3", "responsable": "Supervisora en turno", "actividad": "Acude al área asignada con el material de limpieza y herramienta necesaria para realizar una limpieza exhaustiva."}, {"no": "4", "responsable": "Auxiliar de Intendencia", "actividad": "Retira la basura de los cestos y la deposita en el contenedor correspondiente. Nota: Si el área ha generado RPBI, deberá sellar la bolsa con amarre seguro y trasladarla al séptico para depositarla en el contenedor de RPBI."}, {"no": "5", "responsable": "Auxiliar de Intendencia", "actividad": "En caso de que el área cuente con ventiladores, verificará si se encuentran limpios; de lo contrario, solicitará al departamento de Mantenimiento la limpieza de los mismos."}, {"no": "6", "responsable": "Auxiliar de Intendencia", "actividad": "Recorrer los muebles al centro del área de ser necesario."}, {"no": "7", "responsable": "Auxiliar de Intendencia", "actividad": "Procede a realizar una limpieza exhaustiva al área conforme a la instrucción IT-IN-05."}, {"no": "8", "responsable": "Auxiliar de Intendencia", "actividad": "Surtirá el área de insumos (jabón de manos, papel higiénico y sanitas) en caso de que se requiera."}, {"no": "9", "responsable": "Auxiliar de Intendencia", "actividad": "Avisa a la supervisora en turno que se ha realizado la limpieza exhaustiva del área."}, {"no": "10", "responsable": "Supervisora en turno", "actividad": "Verifica que la limpieza se haya realizado correctamente. 10.1 Si encontró detalles de suciedad, los comunica al auxiliar y procede al paso 11. 10.2 Si la limpieza es correcta, continúa al paso 12."}, {"no": "11", "responsable": "Auxiliar de Intendencia", "actividad": "Corregir los detalles encontrados."}, {"no": "12", "responsable": "Supervisora en turno y Auxiliar de Intendencia", "actividad": "Registrar la actividad en FT-IN-05 Bitácora de limpieza ordinaria en áreas."}, {"no": "13", "responsable": "Auxiliar de Intendencia", "actividad": "Lavará y desinfectará en el séptico del área el material utilizado (franelas, trapeadores, etc.) para usar nuevamente."}, {"no": "14", "responsable": "Auxiliar de Intendencia", "actividad": "Finalmente se realizará la técnica de higiene de manos conforme a IT-UV-01 Instrucción de trabajo para la higiene de manos con agua y jabón."}]'::jsonb, '[{"riesgo": "El personal no realice la limpieza adecuada en las áreas.", "barrera": "Capacitación al personal de Intendencia sobre limpieza y desinfección de áreas."}, {"riesgo": "Contaminación y daño a la salud por manipulación inadecuada de Residuos Peligrosos Biológico Infecciosos (RPBI).", "barrera": "Capacitar al personal para el manejo adecuado de RPBI y el correcto uso del equipo de protección personal."}]'::jsonb,
  '[{"nombre": "Instrucción de trabajo para limpieza exhaustiva", "codigo": "IT-IN-05"}, {"nombre": "Bitácora de limpieza ordinaria en áreas", "codigo": "FT-IN-05"}, {"nombre": "Instrucción de trabajo para la higiene de manos con agua y jabón", "codigo": "IT-UV-01"}, {"nombre": "Cronograma de limpieza ordinaria", "codigo": "FT-IN-06"}]'::jsonb, '[{"version": "01", "fecha": "08/04/2022", "descripcion": "Alta de documento", "realizado": "I.A. Alizbeydi Vázquez Serafín", "aprobado": "Mtra. Ana Cecilia Zárate Bautista"}, {"version": "02", "fecha": "09/01/2023", "descripcion": "Modificación de documento", "realizado": "Lic. Enf. Graciela Gutiérrez Galinzoga", "aprobado": "Mtra. Ana Cecilia Zárate Bautista"}, {"version": "03", "fecha": "14/02/2024", "descripcion": "Modificación de documento", "realizado": "Lic. Rosa Isela López Astorga", "aprobado": "Mtra. Ana Cecilia Zárate Bautista"}]'::jsonb
FROM documents d WHERE d.code = 'IT-IN-09'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;

-- ── Verificación ─────────────────────────────────────────────
SELECT d.code, d.name, d.current_version AS ver,
       dp.code AS dept, d.status
FROM documents d
JOIN document_types dt ON dt.id = d.document_type_id
JOIN departments    dp ON dp.id = d.department_id
WHERE dp.code = 'IN'
ORDER BY d.code;
