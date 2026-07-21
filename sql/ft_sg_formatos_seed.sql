-- ══════════════════════════════════════════════════════════════════
-- Seed: Formatos de Seguridad e Higiene (FT-SG) e Intendencia (FT-IN)
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Registra en la Lista Maestra de Registros/Formatos (pestaña
-- "Registros" de Información Documentada) los formatos del área de
-- Seguridad e Higiene, para su control conforme al § 7.5.
--
-- Tipo documento: Formato (code_prefix = 'FT')
-- Departamentos:  Seguridad e Higiene (code = 'SG') · Intendencia (code = 'IN')
--
-- Es seguro re-ejecutarlo: no duplica los códigos ya existentes.
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── Formatos de Seguridad e Higiene (FT-SG) ───────────────────────
INSERT INTO public.documents
  (code, name, document_type_id, department_id, current_version, status, custodian_position, retention_months, disposition)
SELECT v.code, v.name,
  (SELECT id FROM document_types WHERE code_prefix = 'FT' LIMIT 1),
  (SELECT id FROM departments     WHERE code = 'SG'       LIMIT 1),
  '01', 'vigente', 'Encargada de Seguridad e Higiene', 12, 'Archivo muerto'
FROM (VALUES
  ('FT-SG-01', 'Cronograma de capacitaciones'),
  ('FT-SG-04', 'Rutina de Mantenimiento correctivo'),
  ('FT-SG-08', 'Formato de trabajo de construcción, remodelación y adecuación'),
  ('FT-SG-10', 'Lista de sustancias peligrosas'),
  ('FT-SG-12', 'Ruta de RPBI'),
  ('FT-SG-13', 'Bitacora de lavado del almacén de RPBI'),
  ('FT-SG-14', 'Bitácora de almacén de RPBI'),
  ('FT-SG-15', 'Bitácora de recolección de RPBI'),
  ('FT-SG-16', 'Control de temperatura interior del refrigerador de RPBI'),
  ('FT-SG-19', 'Servicios básicos'),
  ('FT-SG-21', 'Check list Instalaciones (CSH)'),
  ('FT-SG-26', 'Gráfica de cloración del agua'),
  ('FT-SG-27', 'Bitácora de registro CRETIB'),
  ('FT-SG-28', 'Cronograma de Supervisión de áreas'),
  ('FT-SG-29', 'Supervisión de áreas'),
  ('FT-SG-30', 'Orden de Servicio de mantenimiento preventivo'),
  ('FT-SG-31', 'Bitacora de revisión de extintores'),
  ('FT-SG-32', 'Bitacora de revisión de lámparas de emergencia'),
  ('FT-SG-33', 'Programa Anual de Mantenimiento Preventivo'),
  ('FT-SG-34', 'Bitacora de control de áreas nebulizadas'),
  ('FT-SG-35', 'Bitacora de detectores de humo'),
  ('FT-SG-36', 'Check LIST habitaciones'),
  ('FT-SG-37', 'Acta de Verificación'),
  ('FT-SG-38', 'Verificación de instalaciones'),
  ('FT-SG-39', 'Servicio de mantenimiento correctivo'),
  ('FT-SG-43', 'Ingreso de pacientes a urgencias'),
  ('FT-SG-44', 'Registro del servicio de ambulancias'),
  ('FT-SG-45', 'Informe de incidencias'),
  ('FT-SG-46', 'Registro de egresos'),
  ('FT-SG-47', 'Registro de proveedores por cochera'),
  ('FT-SG-48', 'Códigos de seguridad hospitalaria'),
  ('FT-SG-49', 'Medición de cloro en agua potable'),
  ('FT-SG-50', 'Mantenimiento preventivo de compresores de aire'),
  ('FT-SG-51', 'Bitácora de lavado de carro recolector de RPBI'),
  ('FT-SG-52', 'Bitacóra de agua potable'),
  ('FT-SG-53', 'Bitacóra de caldera'),
  ('FT-SG-54', 'Bitacóra de compresor'),
  ('FT-SG-55', 'Bitacóra de gas lp'),
  ('FT-SG-56', 'Bitacóra de gases medicinales'),
  ('FT-SG-57', 'Bitacóra de ósmosis'),
  ('FT-SG-58', 'Bitacóra de planta de energía'),
  ('FT-SG-59', 'Bitacóra de capacitores'),
  ('FT-SG-60', 'Bitácora de revisión de instalaciones de Gas LP'),
  ('FT-SG-61', 'Bitácora de gases medicinales')
) AS v(code, name)
WHERE NOT EXISTS (SELECT 1 FROM public.documents d WHERE d.code = v.code);

-- ── Formatos de Intendencia (FT-IN) ───────────────────────────────
INSERT INTO public.documents
  (code, name, document_type_id, department_id, current_version, status, custodian_position, retention_months, disposition)
SELECT v.code, v.name,
  (SELECT id FROM document_types WHERE code_prefix = 'FT' LIMIT 1),
  (SELECT id FROM departments     WHERE code = 'IN'       LIMIT 1),
  '01', 'vigente', 'Encargada de Seguridad e Higiene', 12, 'Archivo muerto'
FROM (VALUES
  ('FT-IN-01', 'Bitácora de aseo de baños')
) AS v(code, name)
WHERE NOT EXISTS (SELECT 1 FROM public.documents d WHERE d.code = v.code);

-- ── Verificación ──────────────────────────────────────────────────
SELECT d.code, d.name, dep.name AS departamento
FROM public.documents d
LEFT JOIN public.departments dep ON dep.id = d.department_id
WHERE d.code LIKE 'FT-SG-%' OR d.code LIKE 'FT-IN-%'
ORDER BY d.code;
