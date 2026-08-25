-- ══════════════════════════════════════════════════════════════════
-- Ficha de documentos externos — NOM-035-STPS-2018 y NOM-036-1-STPS-2018
-- Hospital Santa Margarita · Información Documentada
-- Llena la ficha (external_meta) de las dos NOM. No borra nada. Re-ejecutable.
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

UPDATE public.documents SET
  external_meta = '{"tipo_doc_externo": "Norma oficial / ley / reglamento", "emisor": "Secretaría del Trabajo y Previsión Social (STPS)", "proceso": "Seguridad y salud en el trabajo", "medio": "Electrónico", "aplica_sgc": "Sí", "requisito_iso": "7.5.3.2 Control de información documentada externa", "resp_uso": "Jefatura de Capital Humano", "resp_resguardo": "Jefatura de Calidad", "met_identificacion": "Leyenda \"Documento Externo\" + emisor (STPS) + clave y fecha de publicación en DOF", "met_control_cambios": "Revisión periódica del DOF y del Catálogo Nacional de Normas (SINEC); actualización en la matriz de documentos externos", "periodicidad": "Cuando aplique", "retencion": "Mientras se encuentre vigente", "disposicion": "Se conserva mientras esté vigente; se sustituye al publicarse una nueva versión", "ubicacion": "Drive institucional / Normatividad STPS", "codigo_externo": "NOM-035-STPS-2018", "fecha_emision": "2018-10-23", "url_fuente": "https://www.dof.gob.mx/nota_detalle.php?codigo=5541828&fecha=23/10/2018", "uso_previsto": "Identificar, analizar y prevenir los factores de riesgo psicosocial y promover un entorno organizacional favorable en el personal del hospital."}'::jsonb,
  source_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5541828&fecha=23/10/2018'
WHERE code = 'DE-NOM-013';

UPDATE public.documents SET
  external_meta = '{"tipo_doc_externo": "Norma oficial / ley / reglamento", "emisor": "Secretaría del Trabajo y Previsión Social (STPS)", "proceso": "Seguridad y salud en el trabajo", "medio": "Electrónico", "aplica_sgc": "Sí", "requisito_iso": "7.5.3.2 Control de información documentada externa", "resp_uso": "Jefatura de Capital Humano", "resp_resguardo": "Jefatura de Calidad", "met_identificacion": "Leyenda \"Documento Externo\" + emisor (STPS) + clave y fecha de publicación en DOF", "met_control_cambios": "Revisión periódica del DOF/SINEC. Nota: tuvo ACUERDO de modificación publicado en el DOF (2024); verificar texto vigente.", "periodicidad": "Cuando aplique", "retencion": "Mientras se encuentre vigente", "disposicion": "Se conserva mientras esté vigente; se sustituye al publicarse una nueva versión", "ubicacion": "Drive institucional / Normatividad STPS", "codigo_externo": "NOM-036-1-STPS-2018", "fecha_emision": "2018-11-23", "url_fuente": "https://dof.gob.mx/normasOficiales/7468/stps11_C/stps11_C.html", "uso_previsto": "Identificar, analizar, prevenir y controlar los factores de riesgo ergonómico por manejo manual de cargas para prevenir alteraciones a la salud del personal."}'::jsonb,
  source_url    = 'https://dof.gob.mx/normasOficiales/7468/stps11_C/stps11_C.html'
WHERE code = 'DE-NOM-014';

-- Verificación
SELECT code, external_meta->>'codigo_externo' AS clave, external_meta->>'emisor' AS emisor, source_url
FROM public.documents WHERE code IN ('DE-NOM-013','DE-NOM-014');
