-- ══════════════════════════════════════════════════════════════════
-- Verificacion de vigencia de NOMs — LOTE DE PRUEBA (15)
-- Hospital Santa Margarita · Informacion Documentada (documentos externos)
--
-- Mueve el badge de la columna 'Vigencia verificada' de la tabla:
--   last_verified_at = HOY  → deja de estar 'Sin verificar'
--   is_current = false      → se pinta 'Desactualizada' (rojo)
--   is_current = true       → se pinta 'Vigente' (verde)
-- Y guarda el detalle del robot (auto_check_*: estado, nota y fuente).
--
-- Resultado: 13 vigentes, 2 desactualizadas
--   DE-NOM-041 = NOM-018-SSA1-1993  (cancelada 2009)
--   DE-NOM-031 = NOM-009-SSA2-1993  (sustituida por NOM-009-SSA2-2013)
--
-- No cambia el 'status' (Estado) del documento. Re-ejecutable.
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- NOM-003-SCT  (DE-NOM-023)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional/PLATIICA y DOF (15/08/2008); revision sistematica 2018 con resultado Confirmacion. Existe proyecto de modificacion no publicado.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-003-sct-2008/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-023';

-- NOM-018-SSA1-1993  (DE-NOM-041)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada el 20/08/2009 por aviso de cancelacion de 37 NOM del Comite de Regulacion y Fomento Sanitario (DOF).',
  auto_check_url    = 'https://sidof.segob.gob.mx/notas/docFuente/5106101',
  auto_check_at     = now()
WHERE code = 'DE-NOM-041';

-- NOM-009-SSA2-1993  (DE-NOM-031)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-009-SSA2-2013 ''Promocion de la salud escolar'', publicada en DOF el 09/12/2013.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5324923&fecha=09/12/2013',
  auto_check_at     = now()
WHERE code = 'DE-NOM-031';

-- NOM-065-SSA1-1993  (DE-NOM-073)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional (SINEC/Economia); revision sistematica 07/01/2025 con resultado Confirmacion. Sin modificaciones ni sustitucion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-065-ssa1-1993/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-073';

-- NOM-064-SSA1-1993  (DE-NOM-072)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional (SINEC/Economia); publicada DOF 24/02/1995; revision sistematica 07/01/2025 Confirmacion. Sin cancelacion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-064-ssa1-1993/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-072';

-- NOM-251-SSA1-2009  (DE-NOM-090)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional (SINEC/Economia) y DOF 01/03/2010; revision sistematica 07/01/2025 Confirmacion. Sin sustitucion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-251-ssa1-2009/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-090';

-- NOM-028-SSA2-2009  (DE-NOM-105)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente en el Catalogo Nacional de Normas; revision sistematica 20/09/2024 confirmo vigencia. Propuesta a cancelacion en PNIC 2023 (DOF 01/06/2023), no formalizada.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-028-ssa2-2009/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-105';

-- NOM-015-SSA2-2010  (DE-NOM-100)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente en el Catalogo Nacional de Normas; revision sistematica 26/01/2026 la mantiene sin cambios. Publicada DOF 23/11/2010. Listada en PNIC 2023 pero no cancelada.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-015-ssa2-2010/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-100';

-- NOM-249-SSA1-2010  (DE-NOM-110)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente en el Catalogo Nacional de Normas; publicada DOF 04/03/2011. Ha tenido modificaciones (2021) y proyecto de modificacion en tramite, pero conserva la misma clave.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-249-ssa1-2010/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-110';

-- NOM-002-STPS-2010  (DE-NOM-016)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun STPS/DOF (publicada 09/12/2010). Sin norma sustituta; sigue siendo la referencia de prevencion y proteccion contra incendios.',
  auto_check_url    = 'https://dof.gob.mx/normasOficiales/4228/stps/stps.htm',
  auto_check_at     = now()
WHERE code = 'DE-NOM-016';

-- NOM-005-SSA3-2018  (DE-NOM-093)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente (DOF 09/07/2020). OJO: su alcance es infraestructura/equipamiento para pacientes AMBULATORIOS, no atencion hospitalaria como indica el tema del hospital.',
  auto_check_url    = 'https://sidof.segob.gob.mx/notas/docFuente/5596456',
  auto_check_at     = now()
WHERE code = 'DE-NOM-093';

-- NOM-035-STPS-2018  (DE-NOM-013)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (publicada 23/10/2018, en vigor por etapas desde 2019/2020). Sin modificaciones que la sustituyan.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5541828&fecha=23/10/2018',
  auto_check_at     = now()
WHERE code = 'DE-NOM-013';

-- NOM-036-1-STPS-2018  (DE-NOM-014)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 23/11/2018. Revision sistematica 2025 con resultado de confirmacion; sin sustitucion. Catalogo oficial la marca vigente.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-036-1-stps-2018/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-014';

-- NOM-001-SSA1-2020  (DE-NOM-019)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 04/01/2021; dejo sin efectos a NOM-001-SSA1-2010. Es la version mas reciente, sin sustitucion posterior.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5609401&fecha=04/01/2021',
  auto_check_at     = now()
WHERE code = 'DE-NOM-019';

-- NOM-127-SSA1-2021  (DE-NOM-111)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 02/05/2022, en vigor desde abril 2023; sustituyo a NOM-127-SSA1-1994. Es la version mas reciente.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5650705&fecha=02/05/2022',
  auto_check_at     = now()
WHERE code = 'DE-NOM-111';

-- Verificacion
SELECT code, left(name,40) AS nom, is_current,
       last_verified_at::date AS verificado, auto_check_status
FROM public.documents
WHERE code IN ('DE-NOM-023', 'DE-NOM-041', 'DE-NOM-031', 'DE-NOM-073', 'DE-NOM-072', 'DE-NOM-090', 'DE-NOM-105', 'DE-NOM-100', 'DE-NOM-110', 'DE-NOM-016', 'DE-NOM-093', 'DE-NOM-013', 'DE-NOM-014', 'DE-NOM-019', 'DE-NOM-111')
ORDER BY is_current, code;
