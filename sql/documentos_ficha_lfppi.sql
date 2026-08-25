-- ══════════════════════════════════════════════════════════════════
-- Ficha del documento externo — Ley Federal de Protección a la Propiedad Industrial (LFPPI)
-- Hospital Santa Margarita · Información Documentada
--
-- La encuentra por NOMBRE (no borra nada, re-ejecutable). Si al correr dice
-- 'UPDATE 1' quedó bien; si dice más de 1, avisa para acotarlo por código.
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

UPDATE public.documents SET
  external_meta     = '{"tipo_doc_externo": "Norma oficial / ley / reglamento", "emisor": "Congreso de la Unión (publicada en el DOF)", "proceso": "Propiedad intelectual / Asuntos jurídicos institucionales", "codigo_externo": "LFPPI — DOF 01/07/2020 (en vigor 05/11/2020)", "fecha_emision": "2020-07-01", "medio": "Electrónico", "url_fuente": "https://www.dof.gob.mx/nota_detalle.php?codigo=5596010&fecha=01/07/2020", "uso_previsto": "Marco legal para la protección de la propiedad industrial (marcas, avisos y nombres comerciales) de la institución.", "resp_uso": "Dirección / Asuntos jurídicos", "resp_resguardo": "Jefatura de Calidad", "aplica_sgc": "Sí", "requisito_iso": "7.5.3.2 Control de información documentada externa", "met_identificacion": "Leyenda \"Documento Externo\" + emisor + fecha de publicación en DOF", "met_control_cambios": "Revisión periódica del DOF; actualización en la matriz de documentos externos", "periodicidad": "Cuando aplique", "retencion": "Mientras se encuentre vigente", "disposicion": "Se conserva mientras esté vigente; se sustituye al publicarse una reforma", "ubicacion": "Drive institucional / Marco legal"}'::jsonb,
  source_url        = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5596010&fecha=01/07/2020',
  dof_fecha         = '01/07/2020',
  dof_proyecto      = '',
  norma_vigente     = 'La misma',
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 01/07/2020, en vigor 05/11/2020; abrogo la Ley de la Propiedad Industrial de 1991.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5596010&fecha=01/07/2020',
  auto_check_at     = now()
WHERE name ILIKE '%Propiedad Industrial%';

-- Verificación (revisa que sea la fila correcta)
SELECT code, name, external_meta->>'emisor' AS emisor, dof_fecha, auto_check_status
FROM public.documents WHERE name ILIKE '%Propiedad Industrial%';
