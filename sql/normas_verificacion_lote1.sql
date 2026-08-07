-- ══════════════════════════════════════════════════════════════════
-- Verificacion de vigencia de NOMs — LOTE DE PRUEBA (15)
-- Hospital Santa Margarita · Informacion Documentada (documentos externos)
--
-- Actualiza la columna de 'Vigencia verificada' (auto_check_*) con el
-- resultado de consultar el DOF y el Catalogo Nacional de Normas (SINEC).
-- La fecha de verificacion se pone automaticamente a HOY (now()).
--
-- Resultado: 13 vigentes, 2 desactualizadas (NOM-018-SSA1-1993 cancelada;
-- NOM-009-SSA2-1993 sustituida por NOM-009-SSA2-2013).
--
-- No cambia el 'status' del documento; solo la verificacion del robot.
-- Re-ejecutable. Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- NOM-003-SCT  (DE-NOM-023)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional/PLATIICA y DOF (15/08/2008); revision sistematica 2018 con resultado Confirmacion. Existe proyecto de modificacion no publicado.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-003-sct-2008/',
  auto_check_at     = now()
WHERE id = '83eca4e8-25e6-42fa-9152-ff413b98f546';

-- NOM-018-SSA1-1993  (DE-NOM-041)  →  desactualizada
UPDATE public.documents SET
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Cancelada el 20/08/2009 por aviso de cancelacion de 37 NOM del Comite de Regulacion y Fomento Sanitario (DOF).',
  auto_check_url    = 'https://sidof.segob.gob.mx/notas/docFuente/5106101',
  auto_check_at     = now()
WHERE id = '1ccf9cec-ab0a-4c6d-9bcd-66202ff36f3a';

-- NOM-009-SSA2-1993  (DE-NOM-031)  →  desactualizada
UPDATE public.documents SET
  auto_check_status = 'desactualizada',
  auto_check_note   = 'Sustituida por NOM-009-SSA2-2013 ''Promocion de la salud escolar'', publicada en DOF el 09/12/2013.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5324923&fecha=09/12/2013',
  auto_check_at     = now()
WHERE id = '24a82bd4-d9fe-44d9-ae18-c24407efae50';

-- NOM-065-SSA1-1993  (DE-NOM-073)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional (SINEC/Economia); revision sistematica 07/01/2025 con resultado Confirmacion. Sin modificaciones ni sustitucion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-065-ssa1-1993/',
  auto_check_at     = now()
WHERE id = '266521ac-c70f-4d3f-ae99-224eeaf4b1e8';

-- NOM-064-SSA1-1993  (DE-NOM-072)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional (SINEC/Economia); publicada DOF 24/02/1995; revision sistematica 07/01/2025 Confirmacion. Sin cancelacion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-064-ssa1-1993/',
  auto_check_at     = now()
WHERE id = '401d6e8e-e612-44ff-8db6-37a8c52a5028';

-- NOM-251-SSA1-2009  (DE-NOM-090)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun Catalogo Nacional (SINEC/Economia) y DOF 01/03/2010; revision sistematica 07/01/2025 Confirmacion. Sin sustitucion.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-251-ssa1-2009/',
  auto_check_at     = now()
WHERE id = '9ca7b343-6a47-4081-80f8-d53182689355';

-- NOM-028-SSA2-2009  (DE-NOM-105)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente en el Catalogo Nacional de Normas; revision sistematica 20/09/2024 confirmo vigencia. Propuesta a cancelacion en PNIC 2023 (DOF 01/06/2023), no formalizada.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-028-ssa2-2009/',
  auto_check_at     = now()
WHERE id = 'c7a77a4e-e084-4de5-9e10-1724bef4c99b';

-- NOM-015-SSA2-2010  (DE-NOM-100)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente en el Catalogo Nacional de Normas; revision sistematica 26/01/2026 la mantiene sin cambios. Publicada DOF 23/11/2010. Listada en PNIC 2023 pero no cancelada.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-015-ssa2-2010/',
  auto_check_at     = now()
WHERE id = '26a7a703-9de7-4c43-b7e1-4b37176e993b';

-- NOM-249-SSA1-2010  (DE-NOM-110)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente en el Catalogo Nacional de Normas; publicada DOF 04/03/2011. Ha tenido modificaciones (2021) y proyecto de modificacion en tramite, pero conserva la misma clave.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-249-ssa1-2010/',
  auto_check_at     = now()
WHERE id = '7de50583-3357-4f18-82ab-382c008c0402';

-- NOM-002-STPS-2010  (DE-NOM-016)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun STPS/DOF (publicada 09/12/2010). Sin norma sustituta; sigue siendo la referencia de prevencion y proteccion contra incendios.',
  auto_check_url    = 'https://dof.gob.mx/normasOficiales/4228/stps/stps.htm',
  auto_check_at     = now()
WHERE id = '821e1108-e89a-4e0a-aba2-11aad10bb784';

-- NOM-005-SSA3-2018  (DE-NOM-093)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente (DOF 09/07/2020). OJO: su alcance es infraestructura/equipamiento para pacientes AMBULATORIOS, no atencion hospitalaria como indica el tema del hospital.',
  auto_check_url    = 'https://sidof.segob.gob.mx/notas/docFuente/5596456',
  auto_check_at     = now()
WHERE id = '0ecb4ef9-6daf-47bb-8090-1b83590c3cb9';

-- NOM-035-STPS-2018  (DE-NOM-013)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente segun DOF (publicada 23/10/2018, en vigor por etapas desde 2019/2020). Sin modificaciones que la sustituyan.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5541828&fecha=23/10/2018',
  auto_check_at     = now()
WHERE id = 'ab7a8f73-189f-4eee-a627-e6390bf0f32f';

-- NOM-036-1-STPS-2018  (DE-NOM-014)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 23/11/2018. Revision sistematica 2025 con resultado de confirmacion; sin sustitucion. Catalogo oficial la marca vigente.',
  auto_check_url    = 'https://platiica.economia.gob.mx/normalizacion/nom-036-1-stps-2018/',
  auto_check_at     = now()
WHERE id = 'e4b35aa6-7904-4239-bbe2-c073edd54541';

-- NOM-001-SSA1-2020  (DE-NOM-019)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 04/01/2021; dejo sin efectos a NOM-001-SSA1-2010. Es la version mas reciente, sin sustitucion posterior.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5609401&fecha=04/01/2021',
  auto_check_at     = now()
WHERE id = 'eb351070-60fc-4da2-b32e-6964d82ded77';

-- NOM-127-SSA1-2021  (DE-NOM-111)  →  vigente
UPDATE public.documents SET
  auto_check_status = 'vigente',
  auto_check_note   = 'Vigente. Publicada en DOF 02/05/2022, en vigor desde abril 2023; sustituyo a NOM-127-SSA1-1994. Es la version mas reciente.',
  auto_check_url    = 'https://www.dof.gob.mx/nota_detalle.php?codigo=5650705&fecha=02/05/2022',
  auto_check_at     = now()
WHERE id = 'fdfee234-bc25-4d1e-9f15-15bd9f52617a';

-- Verificacion
SELECT code, auto_check_status, auto_check_at::date AS verificado, left(auto_check_note,60) AS nota
FROM public.documents
WHERE id IN (
  '83eca4e8-25e6-42fa-9152-ff413b98f546', '1ccf9cec-ab0a-4c6d-9bcd-66202ff36f3a', '24a82bd4-d9fe-44d9-ae18-c24407efae50', '266521ac-c70f-4d3f-ae99-224eeaf4b1e8', '401d6e8e-e612-44ff-8db6-37a8c52a5028', '9ca7b343-6a47-4081-80f8-d53182689355', 'c7a77a4e-e084-4de5-9e10-1724bef4c99b', '26a7a703-9de7-4c43-b7e1-4b37176e993b', '7de50583-3357-4f18-82ab-382c008c0402', '821e1108-e89a-4e0a-aba2-11aad10bb784', '0ecb4ef9-6daf-47bb-8090-1b83590c3cb9', 'ab7a8f73-189f-4eee-a627-e6390bf0f32f', 'e4b35aa6-7904-4239-bbe2-c073edd54541', 'eb351070-60fc-4da2-b32e-6964d82ded77', 'fdfee234-bc25-4d1e-9f15-15bd9f52617a'
) ORDER BY auto_check_status, code;
