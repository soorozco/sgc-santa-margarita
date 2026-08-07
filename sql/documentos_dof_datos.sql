-- ══════════════════════════════════════════════════════════════════
-- Documentos externos — datos de Publicacion DOF y Norma vigente
-- Hospital Santa Margarita · Informacion Documentada
--
-- Llena dof_fecha, dof_proyecto y norma_vigente de las 112 NOMs,
-- consultado en DOF y Catalogo Nacional (SINEC). Match por code.
-- Requiere haber corrido antes: sql/documentos_dof.sql
-- No borra nada. Re-ejecutable. Ejecutar en: Supabase -> SQL Editor
-- ══════════════════════════════════════════════════════════════════

UPDATE public.documents SET
  dof_fecha     = '15/08/2008',
  dof_proyecto  = '',
  norma_vigente = 'NOM-003-SCT/2008'
WHERE code = 'DE-NOM-023';
UPDATE public.documents SET
  dof_fecha     = '16/01/1995',
  dof_proyecto  = '',
  norma_vigente = 'Sin sustituta (cancelada)'
WHERE code = 'DE-NOM-041';
UPDATE public.documents SET
  dof_fecha     = '03/10/1994',
  dof_proyecto  = '',
  norma_vigente = 'NOM-009-SSA2-2013'
WHERE code = 'DE-NOM-031';
UPDATE public.documents SET
  dof_fecha     = '27/02/1995',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-073';
UPDATE public.documents SET
  dof_fecha     = '24/02/1995',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-072';
UPDATE public.documents SET
  dof_fecha     = '10/01/1996',
  dof_proyecto  = '',
  norma_vigente = 'Sin sustituta (cancelada)'
WHERE code = 'DE-NOM-070';
UPDATE public.documents SET
  dof_fecha     = '06/01/1995',
  dof_proyecto  = '',
  norma_vigente = 'NOM-007-SSA2-2016'
WHERE code = 'DE-NOM-029';
UPDATE public.documents SET
  dof_fecha     = '07/11/1994',
  dof_proyecto  = '',
  norma_vigente = 'Sin sustituta (cancelada)'
WHERE code = 'DE-NOM-043';
UPDATE public.documents SET
  dof_fecha     = '12/12/1995',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-076';
UPDATE public.documents SET
  dof_fecha     = '19/10/1995',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-078';
UPDATE public.documents SET
  dof_fecha     = '16/01/1995',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-036';
UPDATE public.documents SET
  dof_fecha     = '18/01/1996',
  dof_proyecto  = '',
  norma_vigente = 'NOM-127-SSA1-2021'
WHERE code = 'DE-NOM-079';
UPDATE public.documents SET
  dof_fecha     = '05/10/2000',
  dof_proyecto  = '',
  norma_vigente = 'NOM-016-SSA2-2012'
WHERE code = 'DE-NOM-038';
UPDATE public.documents SET
  dof_fecha     = '01/07/1996',
  dof_proyecto  = '',
  norma_vigente = 'Sin sustituta (cancelada)'
WHERE code = 'DE-NOM-074';
UPDATE public.documents SET
  dof_fecha     = '01/07/1996',
  dof_proyecto  = '',
  norma_vigente = 'Sin sustituta (cancelada)'
WHERE code = 'DE-NOM-075';
UPDATE public.documents SET
  dof_fecha     = '04/10/1995',
  dof_proyecto  = '',
  norma_vigente = 'NOM-251-SSA1-2009'
WHERE code = 'DE-NOM-077';
UPDATE public.documents SET
  dof_fecha     = '06/01/1997',
  dof_proyecto  = '',
  norma_vigente = 'NOM-001-SEMARNAT-2021'
WHERE code = 'DE-NOM-017';
UPDATE public.documents SET
  dof_fecha     = '03/06/1998',
  dof_proyecto  = '',
  norma_vigente = 'NOM-002-SEMARNAT-1996'
WHERE code = 'DE-NOM-022';
UPDATE public.documents SET
  dof_fecha     = '29/10/1999',
  dof_proyecto  = '',
  norma_vigente = 'NOM-005-SSA3-2018'
WHERE code = 'DE-NOM-081';
UPDATE public.documents SET
  dof_fecha     = '12/04/2000',
  dof_proyecto  = '',
  norma_vigente = 'NOM-008-SSA3-2017'
WHERE code = 'DE-NOM-080';
UPDATE public.documents SET
  dof_fecha     = '02/02/1999',
  dof_proyecto  = 'PROY-NOM-005-STPS-2017 pub. DOF 22/06/2017, sin concluir',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-112';
UPDATE public.documents SET
  dof_fecha     = '24/09/2001',
  dof_proyecto  = '',
  norma_vigente = 'NOM-179-SSA1-2020'
WHERE code = 'DE-NOM-082';
UPDATE public.documents SET
  dof_fecha     = '31/05/1999',
  dof_proyecto  = 'PROY-NOM-004-STPS-2020 pub. DOF 08/02/2021, sin concluir',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-026';
UPDATE public.documents SET
  dof_fecha     = '17/01/2001',
  dof_proyecto  = '',
  norma_vigente = 'NOM-030-SSA2-2009'
WHERE code = 'DE-NOM-053';
UPDATE public.documents SET
  dof_fecha     = '17/01/2001',
  dof_proyecto  = '',
  norma_vigente = 'NOM-027-SSA2-2007'
WHERE code = 'DE-NOM-048';
UPDATE public.documents SET
  dof_fecha     = '02/02/2001',
  dof_proyecto  = '',
  norma_vigente = 'Sin sustituta (cancelada)'
WHERE code = 'DE-NOM-051';
UPDATE public.documents SET
  dof_fecha     = '09/02/2001',
  dof_proyecto  = 'PROY-NOM-031-SSA2-2014 (DOF 25/11/2015), sin concluir',
  norma_vigente = 'Sin sustituta (cancelada)'
WHERE code = 'DE-NOM-055';
UPDATE public.documents SET
  dof_fecha     = '09/03/2001',
  dof_proyecto  = '',
  norma_vigente = 'NOM-006-STPS-2023'
WHERE code = 'DE-NOM-028';
UPDATE public.documents SET
  dof_fecha     = '17/04/2002',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-033';
UPDATE public.documents SET
  dof_fecha     = '19/09/2003',
  dof_proyecto  = '',
  norma_vigente = 'NOM-039-SSA2-2014'
WHERE code = 'DE-NOM-065';
UPDATE public.documents SET
  dof_fecha     = '27/10/2003',
  dof_proyecto  = '',
  norma_vigente = 'NOM-034-SSA2-2013'
WHERE code = 'DE-NOM-059';
UPDATE public.documents SET
  dof_fecha     = '15/09/2004',
  dof_proyecto  = '',
  norma_vigente = 'NOM-027-SSA3-2013'
WHERE code = 'DE-NOM-084';
UPDATE public.documents SET
  dof_fecha     = '21/07/2003',
  dof_proyecto  = '',
  norma_vigente = 'NOM-037-SSA2-2012'
WHERE code = 'DE-NOM-063';
UPDATE public.documents SET
  dof_fecha     = '27/11/2002',
  dof_proyecto  = '',
  norma_vigente = 'NOM-008-SE-2021'
WHERE code = 'DE-NOM-030';
UPDATE public.documents SET
  dof_fecha     = '17/02/2003',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-008';
UPDATE public.documents SET
  dof_fecha     = '18/09/2003',
  dof_proyecto  = '',
  norma_vigente = 'Sin sustituta (cancelada)'
WHERE code = 'DE-NOM-064';
UPDATE public.documents SET
  dof_fecha     = '21/07/2003',
  dof_proyecto  = '',
  norma_vigente = 'NOM-032-SSA2-2014'
WHERE code = 'DE-NOM-057';
UPDATE public.documents SET
  dof_fecha     = '15/09/2006',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-086';
UPDATE public.documents SET
  dof_fecha     = '27/07/2004',
  dof_proyecto  = '',
  norma_vigente = 'NOM-026-SSA3-2012'
WHERE code = 'DE-NOM-083';
UPDATE public.documents SET
  dof_fecha     = '29/07/2004',
  dof_proyecto  = '',
  norma_vigente = 'NOM-029-SSA3-2012'
WHERE code = 'DE-NOM-085';
UPDATE public.documents SET
  dof_fecha     = '15/09/2004',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-087';
UPDATE public.documents SET
  dof_fecha     = '06/01/2005',
  dof_proyecto  = '',
  norma_vigente = 'NOM-033-SSA-2023'
WHERE code = 'DE-NOM-088';
UPDATE public.documents SET
  dof_fecha     = '15/06/2006',
  dof_proyecto  = '',
  norma_vigente = 'NOM-034-SSA3-2013'
WHERE code = 'DE-NOM-089';
UPDATE public.documents SET
  dof_fecha     = '23/06/2006',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-069';
UPDATE public.documents SET
  dof_fecha     = '16/04/2009',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-067';
UPDATE public.documents SET
  dof_fecha     = '20/11/2009',
  dof_proyecto  = 'PROY-NOM-045-SSA-2024 (DOF 09/07/2024, consulta publica)',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-007';
UPDATE public.documents SET
  dof_fecha     = '22/12/2008',
  dof_proyecto  = '',
  norma_vigente = 'NOM-059-SSA1-2015'
WHERE code = 'DE-NOM-071';
UPDATE public.documents SET
  dof_fecha     = '30/12/2008',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-012';
UPDATE public.documents SET
  dof_fecha     = '24/11/2008',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-021';
UPDATE public.documents SET
  dof_fecha     = '07/11/2008',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-049';
UPDATE public.documents SET
  dof_fecha     = '09/12/2008',
  dof_proyecto  = '',
  norma_vigente = 'NOM-017-STPS-2024'
WHERE code = 'DE-NOM-010';
UPDATE public.documents SET
  dof_fecha     = '25/11/2008',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-047';
UPDATE public.documents SET
  dof_fecha     = '22/12/2009',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-054';
UPDATE public.documents SET
  dof_fecha     = '31/05/2010',
  dof_proyecto  = 'Revisión sistemática 2025 recomienda modificación',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-101';
UPDATE public.documents SET
  dof_fecha     = '01/03/2010',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-090';
UPDATE public.documents SET
  dof_fecha     = '21/08/2009',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-105';
UPDATE public.documents SET
  dof_fecha     = '23/11/2010',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-100';
UPDATE public.documents SET
  dof_fecha     = '04/03/2011',
  dof_proyecto  = 'PROY de Modificacion NOM-249-SSA1-2010 (mezclas esteriles) en tramite',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-110';
UPDATE public.documents SET
  dof_fecha     = '09/12/2010',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-016';
UPDATE public.documents SET
  dof_fecha     = '10/11/2010',
  dof_proyecto  = '',
  norma_vigente = 'NOM-010-SSA-2023'
WHERE code = 'DE-NOM-032';
UPDATE public.documents SET
  dof_fecha     = '08/07/2010',
  dof_proyecto  = '',
  norma_vigente = 'NOM-003-SSA3-2016'
WHERE code = 'DE-NOM-025';
UPDATE public.documents SET
  dof_fecha     = '29/12/2011',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-052';
UPDATE public.documents SET
  dof_fecha     = '23/03/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-002';
UPDATE public.documents SET
  dof_fecha     = '27/03/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-094';
UPDATE public.documents SET
  dof_fecha     = '23/12/2011',
  dof_proyecto  = '',
  norma_vigente = 'NOM-003-SSPC-2011'
WHERE code = 'DE-NOM-024';
UPDATE public.documents SET
  dof_fecha     = '09/06/2011',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-066';
UPDATE public.documents SET
  dof_fecha     = '08/12/2011',
  dof_proyecto  = '',
  norma_vigente = 'Sin sustituta (cancelada)'
WHERE code = 'DE-NOM-058';
UPDATE public.documents SET
  dof_fecha     = '04/05/2011',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-056';
UPDATE public.documents SET
  dof_fecha     = '13/04/2011',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-011';
UPDATE public.documents SET
  dof_fecha     = '27/12/2011',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-044';
UPDATE public.documents SET
  dof_fecha     = '31/10/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-035';
UPDATE public.documents SET
  dof_fecha     = '04/01/2013',
  dof_proyecto  = '',
  norma_vigente = 'NOM-001-SSA-2023'
WHERE code = 'DE-NOM-020';
UPDATE public.documents SET
  dof_fecha     = '14/09/2012',
  dof_proyecto  = '',
  norma_vigente = 'NOM-015-SSA-2023'
WHERE code = 'DE-NOM-037';
UPDATE public.documents SET
  dof_fecha     = '15/10/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-001';
UPDATE public.documents SET
  dof_fecha     = '30/11/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-006';
UPDATE public.documents SET
  dof_fecha     = '29/11/2012',
  dof_proyecto  = '',
  norma_vigente = 'NOM-001-SEDE-2022'
WHERE code = 'DE-NOM-018';
UPDATE public.documents SET
  dof_fecha     = '30/10/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-108';
UPDATE public.documents SET
  dof_fecha     = '07/08/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-096';
UPDATE public.documents SET
  dof_fecha     = '04/01/2013',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-034';
UPDATE public.documents SET
  dof_fecha     = '26/10/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-091';
UPDATE public.documents SET
  dof_fecha     = '30/11/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-061';
UPDATE public.documents SET
  dof_fecha     = '07/01/2013',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-050';
UPDATE public.documents SET
  dof_fecha     = '28/09/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-062';
UPDATE public.documents SET
  dof_fecha     = '23/10/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-039';
UPDATE public.documents SET
  dof_fecha     = '08/01/2013',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-004';
UPDATE public.documents SET
  dof_fecha     = '21/11/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-109';
UPDATE public.documents SET
  dof_fecha     = '19/02/2013',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-040';
UPDATE public.documents SET
  dof_fecha     = '07/01/2013',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-060';
UPDATE public.documents SET
  dof_fecha     = '18/09/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-005';
UPDATE public.documents SET
  dof_fecha     = '13/07/2012',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-102';
UPDATE public.documents SET
  dof_fecha     = '17/09/2013',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-046';
UPDATE public.documents SET
  dof_fecha     = '23/09/2014',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-099';
UPDATE public.documents SET
  dof_fecha     = '12/09/2013',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-098';
UPDATE public.documents SET
  dof_fecha     = '04/09/2013',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-097';
UPDATE public.documents SET
  dof_fecha     = '13/11/2013',
  dof_proyecto  = 'Revision sistematica 2024: resultado cancelacion (sin sustituta publicada)',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-027';
UPDATE public.documents SET
  dof_fecha     = '02/09/2013',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-095';
UPDATE public.documents SET
  dof_fecha     = '04/09/2015',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-104';
UPDATE public.documents SET
  dof_fecha     = '28/04/2014',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-113';
UPDATE public.documents SET
  dof_fecha     = '11/09/2014',
  dof_proyecto  = '',
  norma_vigente = 'NOM-006-STPS-2023'
WHERE code = 'DE-NOM-015';
UPDATE public.documents SET
  dof_fecha     = '01/04/2016',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-045';
UPDATE public.documents SET
  dof_fecha     = '09/10/2015',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-042';
UPDATE public.documents SET
  dof_fecha     = 'No aplica',
  dof_proyecto  = '',
  norma_vigente = 'NOM-007-SSA3-2011'
WHERE code = 'DE-NOM-009';
UPDATE public.documents SET
  dof_fecha     = '12/08/2015',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-103';
UPDATE public.documents SET
  dof_fecha     = '19/07/2017',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-107';
UPDATE public.documents SET
  dof_fecha     = '07/04/2016',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-003';
UPDATE public.documents SET
  dof_fecha     = '18/05/2018',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-106';
UPDATE public.documents SET
  dof_fecha     = '15/12/2017',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-068';
UPDATE public.documents SET
  dof_fecha     = '09/07/2020',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-093';
UPDATE public.documents SET
  dof_fecha     = '23/10/2018',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-013';
UPDATE public.documents SET
  dof_fecha     = '23/11/2018',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-014';
UPDATE public.documents SET
  dof_fecha     = '04/01/2021',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-019';
UPDATE public.documents SET
  dof_fecha     = '02/05/2022',
  dof_proyecto  = '',
  norma_vigente = 'La misma'
WHERE code = 'DE-NOM-111';

-- Verificacion
SELECT code, dof_fecha, norma_vigente, nullif(dof_proyecto,'') AS proyecto
FROM public.documents WHERE code IN ('DE-NOM-023', 'DE-NOM-041', 'DE-NOM-031', 'DE-NOM-073', 'DE-NOM-072', 'DE-NOM-070', 'DE-NOM-029', 'DE-NOM-043', 'DE-NOM-076', 'DE-NOM-078', 'DE-NOM-036', 'DE-NOM-079', 'DE-NOM-038', 'DE-NOM-074', 'DE-NOM-075', 'DE-NOM-077', 'DE-NOM-017', 'DE-NOM-022', 'DE-NOM-081', 'DE-NOM-080', 'DE-NOM-112', 'DE-NOM-082', 'DE-NOM-026', 'DE-NOM-053', 'DE-NOM-048', 'DE-NOM-051', 'DE-NOM-055', 'DE-NOM-028', 'DE-NOM-033', 'DE-NOM-065', 'DE-NOM-059', 'DE-NOM-084', 'DE-NOM-063', 'DE-NOM-030', 'DE-NOM-008', 'DE-NOM-064', 'DE-NOM-057', 'DE-NOM-086', 'DE-NOM-083', 'DE-NOM-085', 'DE-NOM-087', 'DE-NOM-088', 'DE-NOM-089', 'DE-NOM-069', 'DE-NOM-067', 'DE-NOM-007', 'DE-NOM-071', 'DE-NOM-012', 'DE-NOM-021', 'DE-NOM-049', 'DE-NOM-010', 'DE-NOM-047', 'DE-NOM-054', 'DE-NOM-101', 'DE-NOM-090', 'DE-NOM-105', 'DE-NOM-100', 'DE-NOM-110', 'DE-NOM-016', 'DE-NOM-032', 'DE-NOM-025', 'DE-NOM-052', 'DE-NOM-002', 'DE-NOM-094', 'DE-NOM-024', 'DE-NOM-066', 'DE-NOM-058', 'DE-NOM-056', 'DE-NOM-011', 'DE-NOM-044', 'DE-NOM-035', 'DE-NOM-020', 'DE-NOM-037', 'DE-NOM-001', 'DE-NOM-006', 'DE-NOM-018', 'DE-NOM-108', 'DE-NOM-096', 'DE-NOM-034', 'DE-NOM-091', 'DE-NOM-061', 'DE-NOM-050', 'DE-NOM-062', 'DE-NOM-039', 'DE-NOM-004', 'DE-NOM-109', 'DE-NOM-040', 'DE-NOM-060', 'DE-NOM-005', 'DE-NOM-102', 'DE-NOM-046', 'DE-NOM-099', 'DE-NOM-098', 'DE-NOM-097', 'DE-NOM-027', 'DE-NOM-095', 'DE-NOM-104', 'DE-NOM-113', 'DE-NOM-015', 'DE-NOM-045', 'DE-NOM-042', 'DE-NOM-009', 'DE-NOM-103', 'DE-NOM-107', 'DE-NOM-003', 'DE-NOM-106', 'DE-NOM-068', 'DE-NOM-093', 'DE-NOM-013', 'DE-NOM-014', 'DE-NOM-019', 'DE-NOM-111') ORDER BY code;
