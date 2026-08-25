-- ══════════════════════════════════════════════════════════════════
-- Crear documento externo — Ley Federal de Protección a la Propiedad Industrial
-- Hospital Santa Margarita · Información Documentada
--
-- Se registra como DE — Documento Externo, codigo DE-LEY-020 (el siguiente
-- libre). Solo inserta si no existe ya (evita duplicados). Re-ejecutable.
-- Departamento: Calidad. Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

INSERT INTO public.documents
  (code, name, document_type_id, department_id, status, current_version,
   custodian_position, elaborated_by, reviewed_by, elaboration_date,
   retention_years, storage_type, source_url, description, external_meta,
   dof_fecha, dof_proyecto, norma_vigente,
   is_current, last_verified_at, verified_by,
   auto_check_status, auto_check_note, auto_check_url, auto_check_at,
   created_at, updated_at)
SELECT
  'DE-LEY-020',
  'Ley Federal de Protección a la Propiedad Industrial',
  '6fd21460-542a-4d6a-887f-413722dde649',   -- tipo DE
  '96ecf661-d00d-4f52-ab75-a562c1564c7a',   -- depto Calidad
  'vigente', 'Vigente',
  'Responsable de Calidad', 'Congreso de la Unión', 'Dra. Giselle De la Torre',
  CURRENT_DATE, 2, ARRAY['electronico'],
  'https://www.dof.gob.mx/nota_detalle.php?codigo=5596010&fecha=01/07/2020',
  'Marco legal para la protección de la propiedad industrial (marcas, patentes, avisos y nombres comerciales). Abrogó la Ley de la Propiedad Industrial de 1991.',
  '{"tipo_doc_externo": "Norma oficial / ley / reglamento", "emisor": "Congreso de la Unión (publicada en el DOF)", "proceso": "Propiedad intelectual / Asuntos jurídicos institucionales", "codigo_externo": "LFPPI — DOF 01/07/2020 (en vigor 05/11/2020)", "fecha_emision": "2020-07-01", "medio": "Electrónico", "url_fuente": "https://www.dof.gob.mx/nota_detalle.php?codigo=5596010&fecha=01/07/2020", "uso_previsto": "Marco legal para la protección de la propiedad industrial (marcas, avisos y nombres comerciales) de la institución.", "resp_uso": "Dirección / Asuntos jurídicos", "resp_resguardo": "Jefatura de Calidad", "aplica_sgc": "Sí", "requisito_iso": "7.5.3.2 Control de información documentada externa", "met_identificacion": "Leyenda \"Documento Externo\" + emisor + fecha de publicación en DOF", "met_control_cambios": "Revisión periódica del DOF; actualización en la matriz de documentos externos", "periodicidad": "Cuando aplique", "retencion": "Mientras se encuentre vigente", "disposicion": "Se conserva mientras esté vigente; se sustituye al publicarse una reforma", "ubicacion": "Drive institucional / Marco legal"}'::jsonb,
  '01/07/2020', '', 'La misma',
  true, now(), 'Verificacion automatica (DOF)',
  'vigente',
  'Vigente. Publicada en DOF 01/07/2020, en vigor 05/11/2020; abrogo la Ley de la Propiedad Industrial de 1991.',
  'https://www.dof.gob.mx/nota_detalle.php?codigo=5596010&fecha=01/07/2020', now(),
  now(), now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.documents WHERE code = 'DE-LEY-020'
     OR name ILIKE '%Federal de Protección a la Propiedad Industrial%'
);

-- Verificación
SELECT code, name, status, external_meta->>'emisor' AS emisor, dof_fecha
FROM public.documents WHERE name ILIKE '%Propiedad Industrial%';
