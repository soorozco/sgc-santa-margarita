-- ══════════════════════════════════════════════════════════════════
-- Verificacion de vigencia de NOMs — LOTE 3 (82 restantes)
-- Hospital Santa Margarita · Informacion Documentada (documentos externos)
--
-- Resultado: 55 vigentes, 27 desactualizadas.
-- Consultado en DOF y Catalogo Nacional de Normas (SINEC). Fecha = HOY.
-- Con esto quedan verificadas las 112 NOMs externas.
-- No cambia el 'status' (Estado). Match por code. Re-ejecutable.
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- NOM-005-STPS-1998  (DE-NOM-112)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun STPS; ratificada tras la 4a revision quinquenal (2019). El PROY-NOM-005-STPS-2017 no ha sido publicado como definitivo.',
  auto_check_url    = 'https://asinom.stps.gob.mx/upload/noms/Nom-005.pdf',
  auto_check_at     = now()
WHERE code = 'DE-NOM-112';

-- NOM-179-SSA1-1998  (DE-NOM-082)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada y sustituida por NOM-179-SSA1-2020 (DOF 22/10/2020), Agua para uso y consumo humano, control de la calidad.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5603318&fecha=22%2F10%2F2020',
  auto_check_at     = now()
WHERE code = 'DE-NOM-082';

-- NOM-004-STPS-1999  (DE-NOM-026)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun STPS; ratificada tras la 4a revision quinquenal (2019). El PROY-NOM-004-STPS-2020 no ha sido publicado como norma definitiva.',
  auto_check_url    = 'https://asinom.stps.gob.mx/upload/noms/Nom-004.pdf',
  auto_check_at     = now()
WHERE code = 'DE-NOM-026';

-- NOM-030-SSA2-1999  (DE-NOM-053)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Modificada y sustituida por NOM-030-SSA2-2009, Prevencion, deteccion, diagnostico, tratamiento y control de la hipertension arterial sistemica (DOF 2009).',
  auto_check_url    = 'https://vlex.com.mx/vid/deteccion-hipertension-arterial-sistemica-222718634',
  auto_check_at     = now()
WHERE code = 'DE-NOM-053';

-- NOM-027-SSA2-1999  (DE-NOM-048)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Modificada y sustituida por NOM-027-SSA2-2007, Para la prevencion y el control de la lepra (DOF 18/04/2008; modif. 31/08/2009).',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5100764&fecha=29/07/2009',
  auto_check_at     = now()
WHERE code = 'DE-NOM-048';

-- NOM-029-SSA2-1999  (DE-NOM-051)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada mediante aviso publicado en el DOF el 08/07/2024; norma para vigilancia, prevencion y control de la leptospirosis en el humano.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5732619&fecha=08/07/2024',
  auto_check_at     = now()
WHERE code = 'DE-NOM-051';

-- NOM-031-SSA2-1999  (DE-NOM-055)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Version 1999 superada; incluida entre NOM canceladas y existe PROY-NOM-031-SSA2-2014 para atencion a la salud de la infancia.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5417151&fecha=25/11/2015',
  auto_check_at     = now()
WHERE code = 'DE-NOM-055';

-- NOM-006-STPS-2000  (DE-NOM-028)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-006-STPS-2014 (DOF 11/09/2014) y luego por NOM-006-STPS-2023 (DOF 07/03/2024), hoy vigente.',
  auto_check_url    = 'https://www.stps.gob.mx/bp/secciones/dgsst/normatividad/normas/nom-006.pdf',
  auto_check_at     = now()
WHERE code = 'DE-NOM-028';

-- NOM-011-STPS-2001  (DE-NOM-033)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun STPS/Catalogo Nacional; ruido en centros de trabajo, sin norma sustituta publicada.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-011-stps-2001/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-033';

-- NOM-039-SSA2-2002  (DE-NOM-065)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-039-SSA2-2014 (DOF 01/06/2017), que dejo sin efectos la version 2002.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5485035&fecha=01/06/2017',
  auto_check_at     = now()
WHERE code = 'DE-NOM-065';

-- NOM-034-SSA2-2002  (DE-NOM-059)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-034-SSA2-2013 (DOF 24/06/2014) para prevencion y control de defectos al nacimiento.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5349816&fecha=24/06/2014',
  auto_check_at     = now()
WHERE code = 'DE-NOM-059';

-- NOM-206-SSA1-2002  (DE-NOM-084)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-027-SSA3-2013 (DOF 04/09/2013) sobre servicios de urgencias, que dejo sin efectos la version 2002.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5312893&fecha=04/09/2013',
  auto_check_at     = now()
WHERE code = 'DE-NOM-084';

-- NOM-037-SSA2-2002  (DE-NOM-063)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Modificada/sustituida por NOM-037-SSA2-2012 (dislipidemias), publicada en DOF el 13/07/2012.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5259329&fecha=13/07/2012',
  auto_check_at     = now()
WHERE code = 'DE-NOM-063';

-- NOM-008-SCFI-2002  (DE-NOM-030)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada por NOM-008-SE-2021 (Sistema general de unidades de medida), publicada en DOF el 29/12/2023.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-008-scfi-2002/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-030';

-- NOM-087-SEMARNAT-SSA1-2002  (DE-NOM-008)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional (SINEC/platiica); revision sistematica del 20/04/2023 confirmo su vigencia, sin sustitucion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-087-semarnat-ssa1-2002/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-008';

-- NOM-038-SSA2-2002  (DE-NOM-064)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-038-SSA2-2010 (deficiencia de yodo), DOF 21/04/2011; esa version fue cancelada despues (aviso 08/07/2024).',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-038-ssa2-2010/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-064';

-- NOM-032-SSA2-2002  (DE-NOM-057)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-032-SSA2-2014 (enfermedades por vector), DOF 16/04/2015, previa NOM-032-SSA2-2010.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-032-ssa2-2014/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-057';

-- NOM-229-SSA1-2002  (DE-NOM-086)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional (SINEC/platiica); revision sistematica del 08/02/2024 confirmo su vigencia.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-229-ssa1-2002/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-086';

-- NOM-205-SSA1-2002  (DE-NOM-083)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada/sustituida por la NOM-026-SSA3-2012, Para la practica de la cirugia mayor ambulatoria (DOF 07/08/2012).',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5262609&fecha=07/08/2012',
  auto_check_at     = now()
WHERE code = 'DE-NOM-083';

-- NOM-209-SSA1-2002  (DE-NOM-085)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada/sustituida por la NOM-029-SSA3-2012, cirugia oftalmologica con laser excimer (DOF 02/08/2012).',
  auto_check_url    = 'https://www.gob.mx/cms/uploads/attachment/file/35895/NOM-029-SSA3-2012.pdf',
  auto_check_at     = now()
WHERE code = 'DE-NOM-085';

-- NOM-233-SSA1-2003  (DE-NOM-087)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun el Catalogo de Normalizacion (Estado: Vigente). Publicada DOF 15/09/2004, sin sustitucion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-233-ssa1-2003/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-087';

-- NOM-234-SSA1-2003  (DE-NOM-088)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por la serie NOM-033 (NOM-033-SSA3-2018 y actual NOM-033-SSA-2023) sobre campos clinicos y educacion en salud.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5364816&fecha=21/10/2014',
  auto_check_at     = now()
WHERE code = 'DE-NOM-088';

-- NOM-237-SSA1-2004  (DE-NOM-089)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada/sustituida por la NOM-034-SSA3-2013, atencion medica prehospitalaria (DOF 23/09/2014).',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5361072&fecha=23/09/2014',
  auto_check_at     = now()
WHERE code = 'DE-NOM-089';

-- NOM-052-SEMARNAT-2005  (DE-NOM-069)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF; clasificacion e identificacion de residuos peligrosos, sin norma sustituta posterior.',
  auto_check_url    = 'https://www.dof.gob.mx/normasOficiales/1055/SEMARNA/SEMARNA.htm',
  auto_check_at     = now()
WHERE code = 'DE-NOM-069';

-- NOM-046-SSA2-2005  (DE-NOM-067)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Modificación a puntos 6.4.2.7, 6.4.2.8, 6.6.1 y 6.7.2.9 publicada en DOF 24/03/2016; conserva la misma clave.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5430957&fecha=24%2F03%2F2016',
  auto_check_at     = now()
WHERE code = 'DE-NOM-067';

-- NOM-045-SSA2-2005  (DE-NOM-007)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente (DOF 20/11/2009). La actualización a IAAS es solo un proyecto (PROY-NOM-045-SSA-2024), aún no publicado como definitivo.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5120943&fecha=20%2F11%2F2009',
  auto_check_at     = now()
WHERE code = 'DE-NOM-007';

-- NOM-059-SSA1-2006  (DE-NOM-071)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada/sustituida por NOM-059-SSA1-2015, publicada en DOF 05/02/2016. Debe usarse la versión 2015.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5424575&fecha=05%2F02%2F2016',
  auto_check_at     = now()
WHERE code = 'DE-NOM-071';

-- NOM-025-STPS-2008  (DE-NOM-012)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente según STPS/DOF (30/12/2008), sin sustitución posterior.',
  auto_check_url    = 'https://asinom.stps.gob.mx/upload/noms/Nom-025.pdf',
  auto_check_at     = now()
WHERE code = 'DE-NOM-012';

-- NOM-001-STPS-2008  (DE-NOM-021)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente según STPS/DOF (publicada 24/11/2008), sin sustitución posterior.',
  auto_check_url    = 'https://asinom.stps.gob.mx/upload/noms/Nom-001.pdf',
  auto_check_at     = now()
WHERE code = 'DE-NOM-021';

-- NOM-027-STPS-2008  (DE-NOM-049)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente según STPS/DOF (publicada 07/11/2008), sin sustitución posterior.',
  auto_check_url    = 'https://dof.gob.mx/normasOficiales/3536/stps1/stps1.htm',
  auto_check_at     = now()
WHERE code = 'DE-NOM-049';

-- NOM-017-STPS-2008  (DE-NOM-010)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-017-STPS-2024 (EPP), publicada en DOF el 28/03/2025, vigente desde el 28/09/2025.',
  auto_check_url    = 'https://www.dof.gob.mx/normasOficiales/9496/stps/stps.html',
  auto_check_at     = now()
WHERE code = 'DE-NOM-010';

-- NOM-026-STPS-2008  (DE-NOM-047)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun STPS/DOF (publicada 25/11/2008); no existe version posterior. Colores y senales de seguridad e higiene.',
  auto_check_url    = 'https://asinom.stps.gob.mx/upload/noms/Nom-026.pdf',
  auto_check_at     = now()
WHERE code = 'DE-NOM-047';

-- NOM-030-STPS-2009  (DE-NOM-054)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (publicada 22/12/2009); sigue de aplicacion obligatoria, sin modificaciones posteriores.',
  auto_check_url    = 'https://www.dof.gob.mx/normasOficiales/3923/stps/stps.htm',
  auto_check_at     = now()
WHERE code = 'DE-NOM-054';

-- NOM-030-SSA2-2009  (DE-NOM-101)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional (revision sistematica 29/07/2025). Los PROY-NOM-030-SSA2-2017/2018 nunca se publicaron como definitivos.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-030-ssa2-2009/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-101';

-- NOM-010-SSA2-2010  (DE-NOM-032)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (publicada 10/11/2010); sin cancelacion ni sustitucion. Prevencion y control de la infeccion por VIH.',
  auto_check_url    = 'https://www.dof.gob.mx/normasOficiales/4205/salud/salud.htm',
  auto_check_at     = now()
WHERE code = 'DE-NOM-032';

-- NOM-003-SSA3-2010  (DE-NOM-025)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada/sustituida por NOM-003-SSA3-2016 (practica de hemodialisis), publicada en DOF el 20/01/2017.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5469489&fecha=20/01/2017',
  auto_check_at     = now()
WHERE code = 'DE-NOM-025';

-- NOM-029-STPS-2011  (DE-NOM-052)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun PLATIICA/DOF. Revision sistematica 2022 confirmo su vigencia sin modificaciones. Publicada DOF 29/12/2011.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-029-stps-2011/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-052';

-- NOM-006-SSA3-2011  (DE-NOM-002)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 23/03/2012; sustituyo a la NOM-170-SSA1-1998. Sin cancelacion ni norma posterior.',
  auto_check_url    = 'https://www.gob.mx/cms/uploads/attachment/file/512097/NOM-006-SSA3-2011.pdf',
  auto_check_at     = now()
WHERE code = 'DE-NOM-002';

-- NOM-007-SSA3-2011  (DE-NOM-094)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente, pero esta clave corresponde a ''organizacion y funcionamiento de laboratorios clinicos'', no a embarazo. El tema de embarazo es la NOM-007-SSA2-2016. Revisar clave/tema.',
  auto_check_url    = 'https://www.dof.gob.mx/normasOficiales/4678/salud/salud.htm',
  auto_check_at     = now()
WHERE code = 'DE-NOM-094';

-- NOM-003-SEGOB-2011  (DE-NOM-024)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'El contenido sigue vigente pero la clave cambio: por cambio de nomenclatura pasa a NOM-003-SSPC-2011 (SEGOB a SSPC). Tuvo modificacion en DOF 15/07/2015.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-003-sspc-2011/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-024';

-- NOM-041-SSA2-2011  (DE-NOM-066)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF/PLATIICA. Sustituyo a la NOM-041-SSA2-2002. Sin cancelacion ni norma posterior localizada.',
  auto_check_url    = 'https://sidof.segob.gob.mx/notas/docFuente/5194157',
  auto_check_at     = now()
WHERE code = 'DE-NOM-066';

-- NOM-033-SSA2-2011  (DE-NOM-058)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'CANCELADA. El CCNNSN aprobo su cancelacion (13/03/2023) por considerarla obsoleta; aviso de cancelacion publicado en DOF 08/07/2024.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5732620&fecha=08/07/2024',
  auto_check_at     = now()
WHERE code = 'DE-NOM-058';

-- NOM-031-STPS-2011  (DE-NOM-056)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 04/05/2011, sin modificaciones ni sustitución posteriores. Confirmado en DOF/STPS.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5188292&fecha=04/05/2011',
  auto_check_at     = now()
WHERE code = 'DE-NOM-056';

-- NOM-019-STPS-2011  (DE-NOM-011)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 13/04/2011 (sustituyo a la de 2004), sin modificaciones posteriores.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5185903&fecha=13/04/2011',
  auto_check_at     = now()
WHERE code = 'DE-NOM-011';

-- NOM-020-STPS-2011  (DE-NOM-044)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente con la misma clave. Publicada DOF 27/12/2011; modificada por acuerdo DOF 24/03/2017 (sigue en vigor).',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5229908&fecha=27/12/2011',
  auto_check_at     = now()
WHERE code = 'DE-NOM-044';

-- NOM-012-STPS-2012  (DE-NOM-035)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 31/10/2012, sin modificaciones ni sustitucion posteriores.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5276080&fecha=31/10/2012',
  auto_check_at     = now()
WHERE code = 'DE-NOM-035';

-- NOM-001-SSA3-2012  (DE-NOM-020)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-001-SSA-2023 (DOF 19/03/2024, vigente a los 180 dias). La clave 2012 ya no es la vigente.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5720561&fecha=19/03/2024',
  auto_check_at     = now()
WHERE code = 'DE-NOM-020';

-- NOM-015-SSA3-2012  (DE-NOM-037)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-015-SSA-2023 (DOF 22/05/2023), Para la atencion medica integral a personas con discapacidad.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5689454&fecha=22/05/2023',
  auto_check_at     = now()
WHERE code = 'DE-NOM-037';

-- NOM-004-SSA3-2012  (DE-NOM-001)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 15/10/2012 (Del expediente clínico). Sin cancelacion ni sustitucion posterior.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5272787&fecha=15/10/2012',
  auto_check_at     = now()
WHERE code = 'DE-NOM-001';

-- NOM-024-SSA3-2012  (DE-NOM-006)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 30/11/2012; dejo sin efectos la NOM-024-SSA3-2010. Sin sustitucion posterior.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5280847&fecha=30/11/2012',
  auto_check_at     = now()
WHERE code = 'DE-NOM-006';

-- NOM-001-SEDE-2012  (DE-NOM-018)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional (platiica). DOF 29/11/2012. El PROY-NOM-001-SEDE-2018 no se publico como definitiva; la clave 2012 sigue vigente.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-001-sede-2012/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-018';

-- NOM-240-SSA1-2012  (DE-NOM-108)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 30/10/2012 (Instalacion y operacion de la tecnovigilancia). Sin modificaciones posteriores.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5275834&fecha=30/10/2012',
  auto_check_at     = now()
WHERE code = 'DE-NOM-108';

-- NOM-026-SSA3-2012  (DE-NOM-096)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Clave vigente (DOF 07/08/2012), pero su titulo oficial es ''Para la practica de la cirugia mayor ambulatoria'', NO el tema registrado. Verificar clave/tema.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5262609&fecha=07/08/2012',
  auto_check_at     = now()
WHERE code = 'DE-NOM-096';

-- NOM-012-SSA3-2012  (DE-NOM-034)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 04/01/2013 (Investigacion para la salud en seres humanos). Sin cancelacion ni sustitucion posterior.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5284148&fecha=04/01/2013',
  auto_check_at     = now()
WHERE code = 'DE-NOM-034';

-- NOM-253-SSA1-2012  (DE-NOM-091)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (26/10/2012) y catalogo oficial. Tuvo aclaracion en 2015; hay proyecto de modificacion 2024/revision 2025 aun no publicado como norma nueva.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-253-ssa1-2012/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-091';

-- NOM-035-SSA3-2012  (DE-NOM-061)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (30/11/2012) y catalogo oficial; revision sistematica 2018 la confirmo sin cancelacion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-035-ssa3-2012/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-061';

-- NOM-028-SSA3-2012  (DE-NOM-050)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun catalogo oficial; DOF 07/01/2013. El PROY-NOM-028-SSA3-2018 quedo solo en proyecto, no se publico norma definitiva que la sustituya.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-028-ssa3-2012/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-050';

-- NOM-036-SSA2-2012  (DE-NOM-062)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (28/09/2012) y catalogo oficial; revision sistematica 2017 la confirmo. Sustituyo a la NOM-036-SSA2-2002.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-036-ssa2-2012/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-062';

-- NOM-016-SSA2-2012  (DE-NOM-039)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (23/10/2012) y catalogo oficial; revision 2017 confirmada. Actualizo a la NOM-016-SSA2-1994 (colera).',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-016-ssa2-2012/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-039';

-- NOM-016-SSA3-2012  (DE-NOM-004)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (08/01/2013) y catalogo oficial; revision sistematica 2018 confirmo su validez, sin cancelacion ni sustitucion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-016-ssa3-2012/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-004';

-- NOM-072-SSA1-2012  (DE-NOM-109)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Publicada en DOF 21/11/2012. Catálogo Nacional la marca Vigente; existe proyecto de modificación (PROY-2025) aún no publicado, no la sustituye.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5278341&fecha=21/11/2012',
  auto_check_at     = now()
WHERE code = 'DE-NOM-109';

-- NOM-017-SSA2-2012  (DE-NOM-040)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Publicada en DOF 19/02/2013. Estado ''Vigente'' en catálogo de normalización; revisión sistematica 2018 la confirmó sin cambios.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5288225&fecha=19/02/2013',
  auto_check_at     = now()
WHERE code = 'DE-NOM-040';

-- NOM-035-SSA2-2012  (DE-NOM-060)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Perimenopausia y postmenopausia. Publicada DOF 07/01/2013. Estado ''Vigente''; revisión 2018 la confirmó. Clave SSA2, no confundir con NOM-035-STPS.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5284235&fecha=07/01/2013',
  auto_check_at     = now()
WHERE code = 'DE-NOM-060';

-- NOM-022-SSA3-2012  (DE-NOM-005)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Terapia de infusión. Publicada DOF 18/09/2012. Estado ''Vigente'' en catálogo; revisión 2017 con resultado ''Confirmación''.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5268977&fecha=18/09/2012',
  auto_check_at     = now()
WHERE code = 'DE-NOM-005';

-- NOM-037-SSA2-2012  (DE-NOM-102)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Dislipidemias. Publicada DOF 13/07/2012. Estado ''Vigente''; revisión sistematica 2017 la confirmó sin cambios.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5259329&fecha=13/07/2012',
  auto_check_at     = now()
WHERE code = 'DE-NOM-102';

-- NOM-025-SSA3-2013  (DE-NOM-046)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Unidades de Cuidados Intensivos. Publicada DOF 17/09/2013. Estado ''Vigente''; revisión sistematica 2023 con resultado ''Confirmación''.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5314307&fecha=17/09/2013',
  auto_check_at     = now()
WHERE code = 'DE-NOM-046';

-- NOM-034-SSA3-2013  (DE-NOM-099)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente según DOF (23/09/2014) y catálogo de normalización; revisión sistemática 17/12/2024 confirmó su continuidad. Tema correcto: atención médica prehospitalaria.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-034-ssa3-2013/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-099';

-- NOM-030-SSA3-2013  (DE-NOM-098)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente; revisión 22/11/2023 la confirmó. Nota: su tema real es accesibilidad para personas con discapacidad en establecimientos médicos, no prestación de servicios en general.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-030-ssa3-2013/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-098';

-- NOM-027-SSA3-2013  (DE-NOM-097)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente (DOF 04/09/2013); revisión 22/11/2023 la confirmó. Nota: su tema real son servicios de urgencias, no funcionamiento de laboratorios.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-027-ssa3-2013/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-097';

-- NOM-006-SSA2-2013  (DE-NOM-027)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Formalmente vigente (DOF 13/11/2013); tema correcto. Alerta: revisión sistemática 09/01/2024 con resultado ''Cancelación'', sin norma sustituta publicada aún. Vigilar DOF.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-006-ssa2-2013/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-027';

-- NOM-019-SSA3-2013  (DE-NOM-095)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente (DOF 02/09/2013); revisión 23/09/2022 la confirmó sin modificaciones. Tema correcto: práctica de enfermería en el SNS.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-019-ssa3-2013/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-095';

-- NOM-025-SSA2-2014  (DE-NOM-104)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente (publicada DOF 04/09/2015). Sin cancelación ni sustitución. Tema correcto: unidades de atención integral hospitalaria médico-psiquiátrica.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-025-ssa2-2014/',
  auto_check_at     = now()
WHERE code = 'DE-NOM-104';

-- NOM-010-STPS-2014  (DE-NOM-113)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (publicada 28/04/2014); sin cancelacion ni norma sustituta posterior.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5342372&fecha=28/04/2014',
  auto_check_at     = now()
WHERE code = 'DE-NOM-113';

-- NOM-006-STPS-2014  (DE-NOM-015)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-006-STPS-2023 (DOF 07/03/2024, en vigor 03/09/2024); la version 2014 quedo sin efectos.',
  auto_check_url    = 'https://www.dof.gob.mx/normasOficiales/9412/stps/stps.html',
  auto_check_at     = now()
WHERE code = 'DE-NOM-015';

-- NOM-022-STPS-2015  (DE-NOM-045)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (publicada 01/04/2016); sin modificacion ni sustitucion posterior.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5435581&fecha=01/04/2016',
  auto_check_at     = now()
WHERE code = 'DE-NOM-045';

-- NOM-018-STPS-2015  (DE-NOM-042)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (publicada 09/10/2015, aclaracion 11/11/2015); sin sustitucion posterior.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5411121&fecha=09/10/2015',
  auto_check_at     = now()
WHERE code = 'DE-NOM-042';

-- NOM-166-SSA1-2015  (DE-NOM-009)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Clave incorrecta: no existe NOM-166-SSA1-2015. La NOM-166-SSA1-1997 fue sustituida por la vigente NOM-007-SSA3-2011 para labs clinicos.',
  auto_check_url    = 'https://www.dof.gob.mx/normasOficiales/4678/salud/salud.htm',
  auto_check_at     = now()
WHERE code = 'DE-NOM-009';

-- NOM-047-SSA2-2015  (DE-NOM-103)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (publicada 12/08/2015); atencion a la salud del grupo etario 10-19 anos, sin sustitucion posterior.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5403545&fecha=12/08/2015',
  auto_check_at     = now()
WHERE code = 'DE-NOM-103';

-- NOM-220-SSA1-2016  (DE-NOM-107)  →  desactualizada
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = false,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Publicada en DOF 19/07/2017; MODIFICADA en DOF 30/09/2020 (varios numerales 8.x). La clave sigue vigente pero el texto fue actualizado; usar versión modificada.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5601541&fecha=30%2F09%2F2020',
  auto_check_at     = now()
WHERE code = 'DE-NOM-107';

-- NOM-007-SSA2-2016  (DE-NOM-003)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Publicada en DOF 07/04/2016; sustituyo a la NOM-007-SSA2-1993. Vigente sin modificaciones posteriores segun DOF.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5432289&fecha=07%2F04%2F2016',
  auto_check_at     = now()
WHERE code = 'DE-NOM-003';

-- NOM-008-SSA3-2017  (DE-NOM-106)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Publicada en DOF 18/05/2018; vigente, sin modificaciones ni cancelaciones posteriores segun DOF.',
  auto_check_url    = 'https://dof.gob.mx/nota_detalle.php?codigo=5523105&fecha=18%2F05%2F2018',
  auto_check_at     = now()
WHERE code = 'DE-NOM-106';

-- NOM-048-SSA2-2017  (DE-NOM-068)  →  vigente
UPDATE public.documents SET
  last_verified_at  = now(),
  is_current        = true,
  verified_by       = 'Verificacion automatica (DOF / Catalogo Nacional SINEC)',
  auto_check_status = 'vigente',
  auto_check_note   = 'Publicada en DOF 15/12/2017; vigente, sin modificaciones ni cancelaciones posteriores segun DOF.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5507972&fecha=15%2F12%2F2017',
  auto_check_at     = now()
WHERE code = 'DE-NOM-068';

-- Verificacion
SELECT auto_check_status, count(*) FROM public.documents
WHERE code IN ('DE-NOM-112', 'DE-NOM-082', 'DE-NOM-026', 'DE-NOM-053', 'DE-NOM-048', 'DE-NOM-051', 'DE-NOM-055', 'DE-NOM-028', 'DE-NOM-033', 'DE-NOM-065', 'DE-NOM-059', 'DE-NOM-084', 'DE-NOM-063', 'DE-NOM-030', 'DE-NOM-008', 'DE-NOM-064', 'DE-NOM-057', 'DE-NOM-086', 'DE-NOM-083', 'DE-NOM-085', 'DE-NOM-087', 'DE-NOM-088', 'DE-NOM-089', 'DE-NOM-069', 'DE-NOM-067', 'DE-NOM-007', 'DE-NOM-071', 'DE-NOM-012', 'DE-NOM-021', 'DE-NOM-049', 'DE-NOM-010', 'DE-NOM-047', 'DE-NOM-054', 'DE-NOM-101', 'DE-NOM-032', 'DE-NOM-025', 'DE-NOM-052', 'DE-NOM-002', 'DE-NOM-094', 'DE-NOM-024', 'DE-NOM-066', 'DE-NOM-058', 'DE-NOM-056', 'DE-NOM-011', 'DE-NOM-044', 'DE-NOM-035', 'DE-NOM-020', 'DE-NOM-037', 'DE-NOM-001', 'DE-NOM-006', 'DE-NOM-018', 'DE-NOM-108', 'DE-NOM-096', 'DE-NOM-034', 'DE-NOM-091', 'DE-NOM-061', 'DE-NOM-050', 'DE-NOM-062', 'DE-NOM-039', 'DE-NOM-004', 'DE-NOM-109', 'DE-NOM-040', 'DE-NOM-060', 'DE-NOM-005', 'DE-NOM-102', 'DE-NOM-046', 'DE-NOM-099', 'DE-NOM-098', 'DE-NOM-097', 'DE-NOM-027', 'DE-NOM-095', 'DE-NOM-104', 'DE-NOM-113', 'DE-NOM-015', 'DE-NOM-045', 'DE-NOM-042', 'DE-NOM-009', 'DE-NOM-103', 'DE-NOM-107', 'DE-NOM-003', 'DE-NOM-106', 'DE-NOM-068') GROUP BY auto_check_status;
