-- ══════════════════════════════════════════════════════════════════
-- Verificacion de vigencia de NOMs — LOTE 2 (15)
-- Hospital Santa Margarita · Informacion Documentada (documentos externos)
--
-- Resultado: 4 vigentes, 11 desactualizadas.
-- Consultado en DOF y Catalogo Nacional de Normas (SINEC). Fecha = HOY.
-- No cambia el 'status' (Estado). Match por code. Re-ejecutable.
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- NOM-056-SSA1-1993  (DE-NOM-070)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada mediante aviso de cancelacion en el DOF (junto con NOM-039-SSA1-1993 y NOM-053-SSA1-1993). Ya no vigente.',
  auto_check_url    = 'https://sidof.segob.gob.mx/notas/docFuente/5106101',
  auto_check_at     = now()
WHERE code = 'DE-NOM-070';

-- NOM-007-SSA2-1993  (DE-NOM-029)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por la NOM-007-SSA2-2016, publicada en el DOF el 07/04/2016; esta ultima es la vigente.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5432289&fecha=07/04/2016',
  auto_check_at     = now()
WHERE code = 'DE-NOM-029';

-- NOM-019-SSA1-1993  (DE-NOM-043)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada por aviso publicado en el DOF (23/07/2009); especificaciones integradas al Suplemento de dispositivos medicos de la FEUM.',
  auto_check_url    = 'https://sidof.segob.gob.mx/notas/docFuente/5106101',
  auto_check_at     = now()
WHERE code = 'DE-NOM-043';

-- NOM-092-SSA1-1994  (DE-NOM-076)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun catalogo oficial de normalizacion; ultima revision sistematica 07/01/2025 con resultado de Confirmacion. Sin cancelacion ni sustitucion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-092-ssa1-1994/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-076';

-- NOM-112-SSA1-1994  (DE-NOM-078)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun catalogo oficial; publicada en DOF 19/10/1995, revision sistematica 03/01/2017 con Confirmacion. Sin sustitucion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-112-ssa1-1994/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-078';

-- NOM-014-SSA2-1994  (DE-NOM-036)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente; conserva la clave 1994. Tuvo modificaciones (1998 y 02/05/2007) que no cambian la clave. Revision sistematica 29/06/2022: Confirmacion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-014-ssa2-1994/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-036';

-- NOM-127-SSA1-1994  (DE-NOM-079)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-127-SSA1-2021 (Agua para uso y consumo humano), publicada en DOF el 02/05/2022, en vigor desde abril 2023.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5650705',
  auto_check_at     = now()
WHERE code = 'DE-NOM-079';

-- NOM-016-SSA2-1994  (DE-NOM-038)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-016-SSA2-2012 (vigilancia, prevencion, control del colera), publicada en DOF el 23/10/2012, con modificacion en 2015.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5274127&fecha=23/10/2012',
  auto_check_at     = now()
WHERE code = 'DE-NOM-038';

-- NOM-077-SSA1-1994  (DE-NOM-074)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada segun el Catalogo Nacional de Normas (revision sistematica 08/01/2026: resultado ''Cancelacion''). No indica norma sustituta.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-077-ssa1-1994/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-074';

-- NOM-078-SSA1-1994  (DE-NOM-075)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Catalogo oficial de normalizacion registra resultado de revision sistematica ''Cancelacion'' (08/01/2026). Ya no vigente.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-078-ssa1-1994/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-075';

-- NOM-093-SSA1-1994  (DE-NOM-077)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada y sustituida por NOM-251-SSA1-2009, Practicas de higiene para el proceso de alimentos, bebidas o suplementos.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-251-ssa1-2009/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-077';

-- NOM-001-ECOL-1996  (DE-NOM-017)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Renombrada NOM-001-SEMARNAT-1996 (2003) y sustituida por NOM-001-SEMARNAT-2021, vigente desde 11/03/2023.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5645374&fecha=11/03/2022',
  auto_check_at     = now()
WHERE code = 'DE-NOM-017';

-- NOM-002-ECOL-1996  (DE-NOM-022)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional (SINEC). Hoy se cita como NOM-002-SEMARNAT-1996 (mismo contenido, solo cambio de nombre de la dependencia). Revision de 2023 recomendo modificaciones, aun no publicadas.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-002-semarnat-1996/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-022';

-- NOM-178-SSA1-1998  (DE-NOM-081)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada y sustituida por NOM-005-SSA3-2010 (DOF 16/08/2010), luego actualizada por NOM-005-SSA3-2018.',
  auto_check_url    = 'https://dof.gob.mx/normasOficiales/4132/Salud/Salud.htm',
  auto_check_at     = now()
WHERE code = 'DE-NOM-081';

-- NOM-174-SSA1-1998  (DE-NOM-080)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada y sustituida por NOM-008-SSA3-2010 ''Para el tratamiento integral del sobrepeso y la obesidad'' (DOF 04/08/2010).',
  auto_check_url    = 'https://www.dof.gob.mx/normasOficiales/4127/Salud/Salud.htm',
  auto_check_at     = now()
WHERE code = 'DE-NOM-080';

-- Verificacion
SELECT code, left(name,40) AS nom, is_current, last_verified_at::date AS verificado, auto_check_status
FROM public.documents WHERE code IN ('DE-NOM-070', 'DE-NOM-029', 'DE-NOM-043', 'DE-NOM-076', 'DE-NOM-078', 'DE-NOM-036', 'DE-NOM-079', 'DE-NOM-038', 'DE-NOM-074', 'DE-NOM-075', 'DE-NOM-077', 'DE-NOM-017', 'DE-NOM-022', 'DE-NOM-081', 'DE-NOM-080') ORDER BY is_current, code;
