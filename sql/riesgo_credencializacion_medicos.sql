-- ══════════════════════════════════════════════════════════════════
-- Riesgo: Médicos sin credencialización vigente o expediente incompleto
-- Proceso: Dirección Médica (estratégico)
-- Probabilidad: 2 (Poco probable) | Impacto: 5 (Muy alto)
-- Ejecutar en: Supabase SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── PASO 1: Si ya ejecutaste la versión anterior, esto limpia ch-06
--            de Recursos Humanos y Capacitación (seguro si no existe)
UPDATE risk_processes
SET
  risks = (
    SELECT COALESCE(jsonb_agg(r), '[]'::jsonb)
    FROM jsonb_array_elements(risks) r
    WHERE r->>'id' != 'ch-06'
  ),
  updated_at = now()
WHERE name = 'Recursos Humanos y Capacitación';

-- ── PASO 2: Crear el proceso "Dirección Médica" si no existe ──────
INSERT INTO risk_processes (name, process_type, process_owner, description, sort_order, risks)
SELECT
  'Dirección Médica',
  'estrategico',
  'Director Médico',
  'Gestión de la práctica médica institucional: credencialización de médicos adscritos, supervisión del desempeño clínico, cumplimiento de normativa sanitaria y estándares de calidad de la atención médica.',
  3,
  '[]'::jsonb
WHERE NOT EXISTS (
  SELECT 1 FROM risk_processes WHERE name = 'Dirección Médica'
);

-- ── PASO 3: Agregar el riesgo dm-01 al proceso Dirección Médica ───
UPDATE risk_processes
SET
  risks = risks || jsonb_build_array(
    jsonb_build_object(
      'id',          'dm-01',
      'type',        'riesgo',
      'description', 'Médicos adscritos que ejercen sin credencialización vigente o con expediente médico incompleto',
      'cause',       'Ausencia de proceso formal de credencialización y falta de verificación periódica de cédulas profesionales, títulos, certificados de especialidad y permisos sanitarios de los médicos adscritos al hospital',
      'effect',      'Responsabilidad legal e institucional grave: médicos no habilitados ejerciendo funciones clínicas; sanciones de COFEPRIS y SSJ; afectación directa a la seguridad del paciente; riesgo de demandas por mala praxis y pérdida de certificación ISO 9001:2015',
      'probability', 2,
      'impact',      5,
      'action_plan', 'Implementar proceso formal de credencialización médica: expediente individual con cédula profesional, título, certificado de especialidad, constancia de no antecedentes penales, seguro de responsabilidad civil vigente y convenio de adscripción firmado. Verificar cédulas en RENAP y portal SEP. Crear lista maestra de médicos con fechas de vigencia. No autorizar inicio de actividades sin expediente 100% completo. Revisión semestral de vigencias.',
      'responsible', 'Director Médico',
      'due_date',    '2026-06-30',
      'status',      'identificado'
    )
  ),
  updated_at = now()
WHERE name = 'Dirección Médica'
  AND NOT EXISTS (
    SELECT 1
    FROM jsonb_array_elements(risks) r
    WHERE r->>'id' = 'dm-01'
  );

-- ── Verificación ──────────────────────────────────────────────────
SELECT
  p.name                        AS proceso,
  r->>'id'                      AS id,
  r->>'description'             AS descripcion,
  (r->>'probability')::int      AS probabilidad,
  (r->>'impact')::int           AS impacto,
  (r->>'probability')::int
    * (r->>'impact')::int       AS nivel_riesgo,
  r->>'status'                  AS estatus
FROM risk_processes p,
     jsonb_array_elements(p.risks) r
WHERE p.name = 'Dirección Médica';
