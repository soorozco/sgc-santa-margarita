-- ══════════════════════════════════════════════════════════════════
-- Riesgo: Médicos sin credencialización vigente o expediente incompleto
-- Proceso: Recursos Humanos y Capacitación
-- Probabilidad: 2 (Poco probable) | Impacto: 5 (Muy alto)
-- Ejecutar en: Supabase SQL Editor
-- ══════════════════════════════════════════════════════════════════

UPDATE risk_processes
SET
  risks = risks || jsonb_build_array(
    jsonb_build_object(
      'id',          'ch-06',
      'type',        'riesgo',
      'description', 'Médicos adscritos que ejercen sin credencialización vigente o con expediente médico incompleto',
      'cause',       'Ausencia de proceso formal de credencialización y falta de verificación periódica de cédulas profesionales, títulos, certificados de especialidad y permisos sanitarios de los médicos adscritos al hospital',
      'effect',      'Responsabilidad legal e institucional grave: médicos no habilitados ejerciendo funciones clínicas; sanciones de COFEPRIS y SSJ; afectación directa a la seguridad del paciente; riesgo de demandas por mala praxis y pérdida de la certificación ISO 9001:2015',
      'probability', 2,
      'impact',      5,
      'action_plan', 'Implementar proceso formal de credencialización médica: expediente individual con cédula profesional, título, certificado de especialidad, constancia de no antecedentes penales, seguro de responsabilidad civil vigente y convenio de adscripción firmado. Verificar cédulas en RENAP y portal SEP. Crear lista maestra de médicos con fechas de vigencia. No autorizar inicio de actividades sin expediente 100% completo. Revisión semestral de vigencias y actualización de documentación.',
      'responsible', 'Jefatura Capital Humano / Director Médico',
      'due_date',    '2026-06-30',
      'status',      'identificado'
    )
  ),
  updated_at = now()
WHERE name = 'Recursos Humanos y Capacitación';

-- ── Verificación ──────────────────────────────────────────────────
SELECT
  name,
  risk->>'id'          AS id,
  risk->>'description' AS descripcion,
  (risk->>'probability')::int AS probabilidad,
  (risk->>'impact')::int      AS impacto,
  risk->>'status'      AS estatus
FROM risk_processes,
     jsonb_array_elements(risks) AS risk
WHERE name = 'Recursos Humanos y Capacitación'
ORDER BY risk->>'id';
