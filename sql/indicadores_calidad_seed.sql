-- ═══════════════════════════════════════════════════════════════
-- Seed: Fichas de Indicadores de Calidad — HSM-ID-52 a HSM-ID-73
-- Fuente: Indicadores Calidad - Indicadores.csv
-- Proceso: Calidad · Reporta: Dra. Giselle De la Torre
-- ═══════════════════════════════════════════════════════════════
-- Columnas de quality_indicators usadas:
--   code, name, unit, formula, description, origin,
--   limit_low_text, limit_mid_text, limit_high_text,
--   measurement_frequency, target_value, min_acceptable,
--   is_higher_better, responsible_department_id,
--   responsible_position, is_active
-- ═══════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_dept_id UUID;
  v_user    UUID;
BEGIN
  -- Obtener departamento Calidad
  SELECT id INTO v_dept_id FROM public.departments
  WHERE name ILIKE '%calidad%' LIMIT 1;

  -- Obtener usuario responsable
  SELECT id INTO v_user FROM auth.users
  WHERE email = 'omar.orozco@gmail.com' LIMIT 1;

  -- ── HSM-ID-52 ·  Seguimiento a Acciones Correctivas/Preventivas ──
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-52') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-52',
      'Seguimiento a las Acciones Correctivas / Preventivas',
      '%',
      '(Acciones correctivas con seguimiento / Total de acciones correctivas abiertas durante el mes) × 100',
      'Grado de cumplimiento en la implementación, seguimiento y cierre oportuno de las acciones correctivas y preventivas derivadas de auditorías internas y externas, análisis de eventos adversos, quejas, no conformidades y oportunidades de mejora, con el fin de asegurar la mejora continua y la eficacia del Sistema de Gestión de la Calidad.',
      'Operativo',
      '75%', '87.5%', '100%',
      'mensual', 100, 75,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-53 · Proyectos de Mejora ─────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-53') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-53',
      'Proyectos de Mejora',
      '#',
      '4 proyectos por semestre',
      'Evalúa el número de proyectos de mejora realizados, autorizados e implementados en la unidad hospitalaria, orientados a optimizar procesos, fortalecer la seguridad del paciente, mejorar la calidad de la atención y elevar la eficiencia operativa, en alineación con los objetivos estratégicos institucionales.',
      'Normativo',
      '2 proyectos', '3 proyectos', '4 proyectos',
      'anual', 4, 2,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-54 · Atención y seguimiento de quejas y sugerencias ──
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-54') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-54',
      'Atención y seguimiento de quejas y sugerencias',
      '%',
      '(Quejas y sugerencias con atención y seguimiento / Total de quejas y sugerencias) × 100',
      'Mide la capacidad institucional para atender, analizar, dar seguimiento y cerrar oportunamente las quejas y sugerencias presentadas por pacientes, familiares y usuarios, garantizando una respuesta formal, documentada y orientada a la mejora de la calidad y seguridad de la atención.',
      'Normativo',
      '75%', '87.5%', '100%',
      'mensual', 100, 75,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-55 · Cumplimiento de sesiones COCASEP ────────────────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-55') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-55',
      'Cumplimiento de las sesiones del COCASEP',
      '%',
      '(Sesiones realizadas / Número de sesiones programadas) × 100',
      'Evalúa el cumplimiento en la programación y realización de las sesiones del Comité de Calidad y Seguridad del Paciente (COCASEP) según el calendario anual de sesiones.',
      'Operativo',
      '90%', '95%', '100%',
      'mensual', 100, 90,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-56 · Número de eventos centinela ─────────────────────
  -- Menor es mejor: meta = 0, límite inferior (alarma) = 5
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-56') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-56',
      'Número de eventos centinela',
      '#',
      'Cantidad de eventos centinela en el período',
      'Cuantifica los eventos centinela ocurridos en la unidad hospitalaria durante un periodo determinado.',
      'Operativo',
      '> 5 (alerta)', '< 5, > 2 (precaución)', '< 2 (meta)',
      'mensual', 0, 5,
      FALSE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-57 · Número de eventos adversos ──────────────────────
  -- Menor es mejor
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-57') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-57',
      'Número de eventos adversos',
      '#',
      'Cantidad de eventos adversos en el período',
      'Cuantifica los eventos adversos ocurridos en la unidad hospitalaria durante un periodo determinado.',
      'Operativo',
      '> 20 (alerta)', '< 10, > 5 (precaución)', '< 5 (meta)',
      'mensual', 0, 20,
      FALSE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-58 · Satisfacción general de pacientes y familiares ──
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-58') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-58',
      'Satisfacción general de pacientes y familiares',
      '%',
      '(Pacientes y familiares satisfechos / Total de pacientes y familiares entrevistados) × 100',
      'Evalúa el nivel de satisfacción global de pacientes y familiares respecto a la atención recibida, considerando aspectos clínicos, administrativos, trato digno, comunicación, oportunidad y condiciones del entorno hospitalario, como insumo clave para la mejora continua de los servicios.',
      'Normativo',
      '< 80%', '80–89%', '≥ 90%',
      'mensual', 100, 80,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-59 · Satisfacción de Médicos ─────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-59') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-59',
      'Satisfacción de Médicos',
      '%',
      '(Médicos satisfechos con los servicios del hospital / Total de médicos entrevistados) × 100',
      'Mide el nivel de satisfacción de los médicos respecto a la funcionalidad de los servicios hospitalarios, procesos administrativos, disponibilidad de recursos, apoyo institucional y condiciones para la atención de sus pacientes, con el fin de fortalecer la relación médico-hospital y la calidad asistencial.',
      'Operativo',
      '85%', '90%', '95%',
      'anual', 95, 85,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-60 · Satisfacción por atención del personal médico ───
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-60') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-60',
      'Satisfacción del usuario por la atención del personal médico',
      '%',
      '(Pacientes y familiares satisfechos con la atención médica / Total de pacientes y familiares entrevistados) × 100',
      'Evalúa la percepción del usuario sobre la calidad de la atención brindada por el personal médico, incluyendo trato humano, comunicación clara, confianza, respeto y resolución de sus necesidades de salud durante el proceso de atención.',
      'Operativo',
      '< 80%', '80–89%', '≥ 90%',
      'mensual', 100, 80,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-61 · Satisfacción con tiempo de espera ───────────────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-61') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-61',
      'Satisfacción del usuario con el tiempo de espera para su atención',
      '%',
      '(Pacientes y familiares satisfechos con el tiempo de espera / Total de pacientes y familiares entrevistados) × 100',
      'Mide la percepción del usuario respecto a los tiempos de espera para recibir la atención.',
      'Operativo',
      '< 80%', '80–89%', '≥ 90%',
      'mensual', 100, 80,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-62 · Satisfacción por atención de enfermería ─────────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-62') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-62',
      'Satisfacción del usuario por la atención y cuidados de enfermería',
      '%',
      '(Pacientes y familiares satisfechos con la atención de enfermería / Total de pacientes y familiares entrevistados) × 100',
      'Indicador que evalúa la percepción del usuario sobre la calidad de la atención y cuidados proporcionados por el personal de enfermería, considerando aspectos como trato digno, oportunidad, seguridad, comunicación, continuidad del cuidado y apoyo durante su estancia hospitalaria.',
      'Operativo',
      '< 80%', '80–89%', '≥ 90%',
      'mensual', 100, 80,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-63 · Satisfacción con el servicio de alimentos ───────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-63') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-63',
      'Satisfacción del usuario con el servicio de alimentos',
      '%',
      '(Pacientes y familiares satisfechos con el servicio de alimentos / Total de pacientes y familiares entrevistados) × 100',
      'Indicador que mide el nivel de satisfacción de los usuarios respecto al servicio de alimentos proporcionado por la unidad hospitalaria, considerando aspectos como calidad, sabor, temperatura, presentación, oportunidad en la entrega y cumplimiento de dietas indicadas, como parte del apoyo integral a la atención del paciente.',
      'Operativo',
      '< 80%', '80–89%', '≥ 90%',
      'mensual', 100, 80,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-64 · Satisfacción con la limpieza del hospital ───────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-64') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-64',
      'Satisfacción del cliente en la limpieza del hospital',
      '%',
      '(Pacientes y familiares satisfechos con la limpieza del hospital / Total de pacientes y familiares entrevistados) × 100',
      'Indicador que evalúa la percepción del usuario sobre la limpieza y orden de las áreas hospitalarias, incluyendo áreas clínicas, administrativas y de uso común, como un elemento clave para la seguridad del paciente, la prevención de infecciones y la imagen institucional.',
      'Operativo',
      '< 80%', '80–89%', '≥ 90%',
      'mensual', 100, 80,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-65 · Satisfacción relacionada a vigilancia interna ───
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-65') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-65',
      'Satisfacción del cliente relacionada a la vigilancia interna',
      '%',
      '(Pacientes y familiares satisfechos con la vigilancia interna / Total de pacientes y familiares entrevistados) × 100',
      'Indicador que mide la percepción de los usuarios respecto al servicio de vigilancia interna, considerando aspectos como seguridad, trato, control de accesos, orientación y respuesta ante situaciones de riesgo, contribuyendo a un entorno hospitalario seguro y confiable.',
      'Operativo',
      '< 80%', '80–89%', '≥ 90%',
      'mensual', 100, 80,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-66 · Regresaría o recomendaría el hospital ───────────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-66') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-66',
      'Regresaría o recomendaría el hospital',
      '%',
      '(Pacientes y familiares que regresarían o recomendarían el hospital / Total de pacientes y familiares entrevistados) × 100',
      'Mide la lealtad y disposición de los usuarios para regresar o recomendar el hospital, como indicador de percepción global de la calidad y satisfacción con la experiencia de atención.',
      'Operativo',
      '< 80%', '80–89%', '≥ 90%',
      'mensual', 100, 80,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-67 · Revisiones y actualizaciones de protocolos ──────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-67') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-67',
      'N° de revisiones y actualizaciones en protocolos y procedimientos en relación a la lista maestra',
      '#',
      '(Documentos revisados/actualizados en el período / Total de documentos vigentes en la lista maestra) × 100',
      'Indicador que cuantifica las revisiones y actualizaciones efectuadas a los protocolos y procedimientos institucionales en relación con la lista maestra vigente, con el propósito de asegurar la actualización normativa, la estandarización de procesos y la mejora continua del Sistema de Gestión de la Calidad.',
      'Operativo',
      NULL, NULL, '100%',
      'mensual', 100, NULL,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-68 · Número de Quejas ────────────────────────────────
  -- Menor es mejor: meta = 0
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-68') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-68',
      'Número de Quejas',
      '#',
      'Cantidad de quejas recibidas en el período',
      'Indicador que mide la cantidad de quejas recibidas por parte de pacientes, familiares o usuarios durante un periodo determinado, relacionadas con la atención clínica, administrativa o de apoyo.',
      'Operativo',
      '≥ 10 (alerta)', '5–9 (precaución)', '0–4 (meta)',
      'mensual', 0, 10,
      FALSE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-69 · Número de Felicitaciones ────────────────────────
  -- Mayor es mejor: meta = 1 o más
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-69') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-69',
      'Número de Felicitaciones',
      '#',
      'Cantidad de felicitaciones recibidas en el período',
      'Indicador que cuantifica las felicitaciones recibidas por la institución, servicios o personal, como reconocimiento a la calidad de la atención, el trato humano y las buenas prácticas implementadas.',
      'Operativo',
      '0 (por debajo de meta)', '1 (mínimo)', '≥ 1 (meta)',
      'mensual', 1, 1,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-70 · Seguimiento a Proyectos de Mejora ───────────────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-70') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-70',
      'Seguimiento a Proyectos de Mejora',
      '%',
      '(Proyectos de mejora con seguimiento activo / Total de proyectos de mejora registrados) × 100',
      'Indicador que mide el grado de avance y cumplimiento de los proyectos de mejora implementados en la unidad hospitalaria, orientados a fortalecer la calidad de los procesos, la seguridad del paciente y la eficiencia operativa, conforme a los objetivos estratégicos institucionales.',
      'Operativo',
      '75%', '88%', '100%',
      'mensual', 100, 75,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-71 · Cumplimiento de acuerdos COCASEP ────────────────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-71') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-71',
      'Cumplimiento de acuerdos de las sesiones del COCASEP',
      '%',
      '(Acuerdos del COCASEP implementados / Total de acuerdos establecidos en el período) × 100',
      'Indicador que evalúa el nivel de cumplimiento de los acuerdos establecidos durante las sesiones del Comité de Calidad y Seguridad del Paciente (COCASEP), verificando su implementación, seguimiento y cierre oportuno, como mecanismo de gobernanza y mejora continua en materia de calidad y seguridad.',
      'Operativo',
      '75%', '88%', '100%',
      'mensual', 100, 75,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-72 · Cumplimiento de auditorías planificadas ─────────
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-72') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-72',
      'Cumplimiento de auditorías planificadas ejecutadas en el período',
      '%',
      '(Auditorías ejecutadas en el período / Total de auditorías planificadas para el período) × 100',
      'Indicador que mide el grado de cumplimiento en la ejecución de auditorías internas y externas programadas en el periodo evaluado, asegurando la verificación sistemática de los procesos, el cumplimiento normativo y la identificación de oportunidades de mejora.',
      'Operativo',
      '80%', '90%', '100%',
      'trimestral', 100, 80,
      TRUE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

  -- ── HSM-ID-73 · Número de Cuasifallas ───────────────────────────
  -- Menor es mejor (cuasifallas son precursores de eventos adversos)
  IF NOT EXISTS (SELECT 1 FROM public.quality_indicators WHERE code = 'HSM-ID-73') THEN
    INSERT INTO public.quality_indicators (
      code, name, unit, formula, description, origin,
      limit_low_text, limit_mid_text, limit_high_text,
      measurement_frequency, target_value, min_acceptable,
      is_higher_better, responsible_department_id, responsible_position, is_active, created_by
    ) VALUES (
      'HSM-ID-73',
      'Número de Cuasifallas',
      '#',
      'Cantidad de cuasifallas reportadas en el período',
      'Cuantifica las cuasifallas ocurridas en la unidad hospitalaria durante un periodo determinado. Las cuasifallas son incidentes que no llegaron a afectar al paciente pero tienen el potencial de causar daño si no se gestionan. Su reporte activo es un indicador de cultura de seguridad.',
      'Operativo',
      '> 20 (alerta)', '< 10, > 5 (precaución)', '< 5 (meta)',
      'mensual', 0, 20,
      FALSE, v_dept_id, 'Dra. Giselle De la Torre', TRUE, v_user
    );
  END IF;

END $$;

-- ── Verificar resultado ───────────────────────────────────────
SELECT code, name, unit, measurement_frequency,
       target_value, min_acceptable, is_higher_better,
       limit_low_text, limit_high_text
FROM public.quality_indicators
WHERE code LIKE 'HSM-ID-5%' OR code LIKE 'HSM-ID-6%' OR code LIKE 'HSM-ID-7%'
ORDER BY code;
