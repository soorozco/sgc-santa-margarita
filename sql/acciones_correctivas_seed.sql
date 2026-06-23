-- =====================================================================
-- SEED: Planes de Acción Correctiva — Auditoría Externa ISO 9001:2015
-- Hallazgos detectados: Noviembre 2025
-- 10 hallazgos: NC1-NC3, DV1-DV7
-- Idempotente: verifica por `number` antes de insertar
-- Ejecutar en Supabase SQL Editor
-- =====================================================================

DO $$
DECLARE
  v_user uuid;
BEGIN

  -- Obtener ID del usuario responsable del SGC
  SELECT id INTO v_user
  FROM auth.users
  WHERE email = 'omar.orozco@gmail.com'
  LIMIT 1;

  -- ─────────────────────────────────────────────────────────────────
  -- NC1 · Calidad · §6.1 · Gestión de Riesgos
  -- Avance: 60% → 3 de 5 actividades completadas
  -- ─────────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC1') THEN
    INSERT INTO public.planes_correctivos (
      number, detection_date, source, responsible,
      nc_description, root_cause, status, activities, created_by
    ) VALUES (
      'NC1',
      '2025-11-01',
      'Auditoría externa',
      'Jefa de Calidad',
      'NC — Proceso: Calidad (§6.1). El método implementado para la gestión de riesgos no considera un análisis integral de todos los procesos del SGC. La matriz de riesgos presentada únicamente considera 14 riesgos en total. Asimismo, los riesgos identificados en los procesos evaluados no son congruentes con las actividades realizadas (p. ej. Proceso de Admisión).',
      'La metodología de identificación y análisis de riesgos no contempló una revisión integral y transversal de todos los procesos del alcance institucional, debido a una definición limitada del criterio de análisis y la falta de una directriz estandarizada que asegure la actualización y validación periódica del mapa de riesgos por proceso.',
      'en_proceso',
      '[
        {"description":"Actualizar la matriz de riesgos conforme a los riesgos detectados en cada uno de los procedimientos documentados","responsible":"Jefa de Calidad","due_date":"2025-11-30","status":"completado","evidence":[]},
        {"description":"Realización de agrupación por categoría de los riesgos detectados","responsible":"Jefa de Calidad","due_date":"2025-11-30","status":"completado","evidence":[]},
        {"description":"Realización de la priorización del AMEF","responsible":"Jefa de Calidad","due_date":"2025-11-30","status":"completado","evidence":[]},
        {"description":"Implementar metodología integral de gestión de riesgos institucional: identificación, análisis, evaluación, tratamiento y seguimiento por proceso; vinculación con contexto, partes interesadas, objetivos de calidad y auditorías previas; criterios uniformes de probabilidad e impacto","responsible":"Jefa de Calidad","due_date":"2025-11-30","status":"en_proceso","evidence":[]},
        {"description":"Incluir en el procedimiento de revisión por la dirección la verificación anual del análisis de riesgos institucional y su actualización ante cambios organizacionales, de contexto o en los procesos","responsible":"Jefa de Calidad","due_date":"2025-12-16","status":"pendiente","evidence":[]}
      ]'::jsonb,
      v_user
    );
  END IF;

  -- ─────────────────────────────────────────────────────────────────
  -- NC2 · Compras · §8.4.1 · Evaluación de Proveedores Externos
  -- Avance: 40% → 2 de 5 actividades completadas
  -- ─────────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC2') THEN
    INSERT INTO public.planes_correctivos (
      number, detection_date, source, responsible,
      nc_description, root_cause, status, activities, created_by
    ) VALUES (
      'NC2',
      '2025-11-01',
      'Auditoría externa',
      'Encargado de Compras',
      'NC — Proceso: Compras (§8.4.1). Para las compras consideradas "no programadas" no se realiza ningún tipo de calificación del producto/servicio recibido para evaluar el desempeño del proveedor. En el área de imagenología existen procesos subcontratados sin evidencia de evaluación de los proveedores correspondientes. Hallazgo recurrente.',
      'El procedimiento institucional para la evaluación y seguimiento de proveedores externos no contempla mecanismos aplicables a todas las modalidades de adquisición, particularmente las no programadas o eventuales, ni establece controles específicos para los procesos subcontratados dentro del SGC. Omisión debida a falta de actualización metodológica del procedimiento y ausencia de integración de servicios subcontratados en el alcance operativo del sistema.',
      'en_proceso',
      '[
        {"description":"Diseñar y validar formato único de evaluación de proveedor externo, aplicable a todas las áreas","responsible":"Encargado de Compras","due_date":"2025-11-11","status":"completado","evidence":[]},
        {"description":"Actualizar el procedimiento institucional de Evaluación de Proveedores","responsible":"Encargado de Compras","due_date":"2025-11-11","status":"en_proceso","evidence":[]},
        {"description":"Integrar los procesos subcontratados al mapa de procesos institucional, asegurando su inclusión en el alcance del SGC y su seguimiento en auditorías internas","responsible":"Encargado de Compras","due_date":"2025-11-30","status":"pendiente","evidence":[]},
        {"description":"Solicitar a todas las áreas que realizan adquisiciones o subcontrataciones la relación vigente de proveedores activos y servicios externos","responsible":"Encargado de Compras","due_date":"2025-11-18","status":"pendiente","evidence":[]},
        {"description":"Realizar evaluación retroactiva del desempeño de proveedores de compras no programadas o subcontratadas de los últimos 6 meses","responsible":"Encargado de Compras","due_date":"2025-11-30","status":"pendiente","evidence":[]}
      ]'::jsonb,
      v_user
    );
  END IF;

  -- ─────────────────────────────────────────────────────────────────
  -- NC3 · Compras · §8.4.3 · Evaluación de Proveedores No Programados
  -- Avance: 40% → 2 de 5 actividades completadas
  -- ─────────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC3') THEN
    INSERT INTO public.planes_correctivos (
      number, detection_date, source, responsible,
      nc_description, root_cause, status, activities, created_by
    ) VALUES (
      'NC3',
      '2025-11-01',
      'Auditoría externa',
      'Encargado de Compras',
      'NC — Proceso: Compras (§8.4.3). Para las compras "no programadas" no se realiza calificación del producto/servicio recibido. Ejemplos de evaluaciones aplicadas: Nadro S.A.P.I. (20 compras, promedio 9.6), Insumed (6 compras, promedio 9.6). Bolsas y Empaques Herraduras fue dado de baja por mala evaluación. Se requiere formalizar el proceso para todos los proveedores.',
      'El proceso de evaluación de proveedores está implementado parcialmente, enfocado en proveedores regulares o programados, sin un mecanismo formal para compras no programadas o eventuales. El procedimiento institucional no define la obligatoriedad, periodicidad ni los responsables de calificar todos los productos y servicios adquiridos, limitando la trazabilidad del desempeño global.',
      'en_proceso',
      '[
        {"description":"Diseñar y validar formato único de evaluación de proveedor externo, aplicable a todas las áreas","responsible":"Encargado de Compras","due_date":"2025-11-11","status":"completado","evidence":[]},
        {"description":"Actualizar el Procedimiento de Evaluación de Proveedores incorporando compras no programadas","responsible":"Encargado de Compras","due_date":"2025-11-11","status":"en_proceso","evidence":[]},
        {"description":"Establecer control mensual que asegure que el 100% de los proveedores activos han sido evaluados","responsible":"Encargado de Compras","due_date":"2025-11-30","status":"pendiente","evidence":[]},
        {"description":"Realizar revisión retroactiva de todas las compras no programadas de los últimos tres meses aplicando evaluación de desempeño con el formato institucional vigente","responsible":"Encargado de Compras","due_date":"2025-11-18","status":"pendiente","evidence":[]},
        {"description":"Registrar y consolidar los resultados en la base de datos general de proveedores","responsible":"Encargado de Compras","due_date":"2025-11-30","status":"pendiente","evidence":[]}
      ]'::jsonb,
      v_user
    );
  END IF;

  -- ─────────────────────────────────────────────────────────────────
  -- DV1 · Calidad · §4.2 · Partes Interesadas (entidades gubernamentales)
  -- Avance: 50% → 2 de 4 actividades completadas
  -- ─────────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'DV1') THEN
    INSERT INTO public.planes_correctivos (
      number, detection_date, source, responsible,
      nc_description, root_cause, status, activities, created_by
    ) VALUES (
      'DV1',
      '2025-11-01',
      'Auditoría externa',
      'Jefa de Calidad',
      'DV — Proceso: Calidad (§4.2). La organización mantiene documentadas sus partes interesadas en el Manual de Organización MA-DG-01 Ver. 05, sin embargo, no se identifican las entidades gubernamentales involucradas como partes interesadas del SGC.',
      'El proceso de identificación y análisis de partes interesadas se realizó de forma parcial, considerando únicamente usuarios internos, pacientes, familiares, personal médico, proveedores y comunidad, sin incluir entidades gubernamentales, regulatorias o de supervisión sanitaria. Falta de criterio metodológico integral y de coordinación interdepartamental entre calidad, dirección y unidades responsables del cumplimiento normativo.',
      'en_proceso',
      '[
        {"description":"Convocar reunión extraordinaria de revisión del contexto organizacional con responsables de área para identificar y listar todas las entidades gubernamentales vinculadas al hospital","responsible":"Jefa de Calidad","due_date":"2025-11-11","status":"completado","evidence":[]},
        {"description":"Actualizar la matriz de partes interesadas institucional incluyendo entidades gubernamentales","responsible":"Jefa de Calidad","due_date":"2025-11-11","status":"completado","evidence":[]},
        {"description":"Incluir las actualizaciones de partes interesadas en el Manual de Organización MA-DG-01","responsible":"Jefa de Calidad","due_date":"2025-11-18","status":"en_proceso","evidence":[]},
        {"description":"Publicar la versión revisada del Manual de Organización y comunicar la actualización al personal directivo y operativo","responsible":"Jefa de Calidad","due_date":"2025-11-30","status":"pendiente","evidence":[]}
      ]'::jsonb,
      v_user
    );
  END IF;

  -- ─────────────────────────────────────────────────────────────────
  -- DV2 · Capital Humano · §7.2 · Evaluación de Eficacia de Capacitación
  -- Avance: 67% → 2 de 3 actividades completadas
  -- ─────────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'DV2') THEN
    INSERT INTO public.planes_correctivos (
      number, detection_date, source, responsible,
      nc_description, root_cause, status, activities, created_by
    ) VALUES (
      'DV2',
      '2025-11-01',
      'Auditoría externa',
      'Jefe de Capital Humano',
      'DV — Proceso: Capital Humano (§7.2 inc. c). No es clara la evaluación de eficacia para todos los cursos impartidos. Ejemplos: curso "Cálculo de nutrición parenteral" (12/mayo/2025) y curso "Elaboración y aplicación de dietas poliméricas artesanales" (27/mayo/2025) sin evidencia de evaluación de eficacia.',
      'El proceso de capacitación institucional no incluye un método estandarizado para evaluar la eficacia de todas las acciones formativas. La metodología actual se limita a verificar asistencia o satisfacción, sin medir la transferencia del conocimiento al desempeño operativo. Falta un procedimiento documentado que defina niveles, criterios y herramientas de evaluación de eficacia, así como una política de seguimiento post-capacitación.',
      'en_proceso',
      '[
        {"description":"Diseñar formato de evaluación de eficacia obligatorio posterior a cada curso o evento de capacitación","responsible":"Jefe de Capital Humano","due_date":"2025-11-30","status":"completado","evidence":[]},
        {"description":"Actualizar el Procedimiento de Capacitación y Evaluación de Competencias incluyendo niveles, criterios y herramientas de evaluación de eficacia y política de seguimiento post-capacitación","responsible":"Jefe de Capital Humano","due_date":"2025-11-30","status":"completado","evidence":[]},
        {"description":"Integrar los resultados de evaluación al Indicador Institucional de Eficacia de Capacitación","responsible":"Jefe de Capital Humano","due_date":"2025-12-16","status":"en_proceso","evidence":[]}
      ]'::jsonb,
      v_user
    );
  END IF;

  -- ─────────────────────────────────────────────────────────────────
  -- DV3 · Seguridad e Higiene · §10.2 · Acciones Correctivas por Indicadores
  -- Avance: 67% → 2 de 3 actividades completadas
  -- ─────────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'DV3') THEN
    INSERT INTO public.planes_correctivos (
      number, detection_date, source, responsible,
      nc_description, root_cause, status, activities, created_by
    ) VALUES (
      'DV3',
      '2025-11-01',
      'Auditoría externa',
      'Jefa de Calidad',
      'DV — Proceso: Seguridad e Higiene (§10.2). Aunque la organización mantiene identificados incumplimientos en los indicadores de desempeño del área de mantenimiento en el último trimestre, no se cuenta con acciones correctivas tomadas con base en la metodología definida por el SGC.',
      'El área de mantenimiento no activa el proceso institucional de acciones correctivas ante incumplimientos de indicadores, debido a la falta de integración del enfoque de mejora continua en la gestión operativa. No se ha establecido una metodología clara para vincular resultados de indicadores con la apertura de acciones correctivas, ni se ha reforzado la capacitación sobre el uso del procedimiento correspondiente.',
      'en_proceso',
      '[
        {"description":"Actualizar el procedimiento de acciones correctivas para incluir explícitamente la activación del proceso ante desviaciones de indicadores de desempeño","responsible":"Jefa de Calidad","due_date":"2025-11-30","status":"completado","evidence":[]},
        {"description":"Implementar bitácora de control mensual del desempeño de indicadores con semáforo (verde/amarillo/rojo)","responsible":"Encargada de Seguridad e Higiene","due_date":"2025-11-30","status":"completado","evidence":[]},
        {"description":"Revisar y validar en comité de calidad la ejecución y eficacia de las acciones implementadas ante indicadores fuera de rango","responsible":"Jefa de Calidad","due_date":"2025-12-16","status":"en_proceso","evidence":[]}
      ]'::jsonb,
      v_user
    );
  END IF;

  -- ─────────────────────────────────────────────────────────────────
  -- DV4 · Calidad · §7.5 · Control de Documentos de Origen Externo
  -- Avance: 25% → 1 de 4 actividades completadas
  -- ─────────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'DV4') THEN
    INSERT INTO public.planes_correctivos (
      number, detection_date, source, responsible,
      nc_description, root_cause, status, activities, created_by
    ) VALUES (
      'DV4',
      '2025-11-01',
      'Auditoría externa',
      'Jefa de Calidad',
      'DV — Proceso: Calidad (§7.5). Los manuales de equipos y otros documentos de origen externo no se encuentran identificados con un mecanismo de control como parte del SGC.',
      'El procedimiento institucional de control documental no contempla un método específico para la identificación, registro, trazabilidad y control de la documentación de origen externo. Omisión en el diseño metodológico y falta de integración del control documental con las áreas técnicas (mantenimiento e ingeniería biomédica). Ausencia de registro maestro de documentos externos.',
      'en_proceso',
      '[
        {"description":"Realizar levantamiento y revisión física de todos los instructivos, manuales y documentos externos (equipos biomédicos, sistemas, mantenimiento, laboratorio, imagenología) así como de la normatividad aplicable","responsible":"Jefa de Calidad","due_date":"2025-11-11","status":"en_proceso","evidence":[]},
        {"description":"Actualizar el procedimiento de control documental: definir documentos de origen externo, reglas de identificación, registro, custodia, actualización periódica e inclusión en Lista Maestra o registro anexo exclusivo; asignar responsables por área","responsible":"Jefa de Calidad","due_date":"2025-11-30","status":"pendiente","evidence":[]},
        {"description":"Asignar códigos de identificación de control a cada documento de origen externo","responsible":"Jefa de Calidad","due_date":"2025-11-18","status":"pendiente","evidence":[]},
        {"description":"Elaborar registro de documentos externos con: nombre, procedencia, código, ubicación y responsable de conservación","responsible":"Jefa de Calidad","due_date":"2025-11-30","status":"pendiente","evidence":[]}
      ]'::jsonb,
      v_user
    );
  END IF;

  -- ─────────────────────────────────────────────────────────────────
  -- DV5 · Dirección Médica · §8.5 · Credencialización
  -- Avance: 67% → 2 de 3 actividades completadas
  -- ─────────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'DV5') THEN
    INSERT INTO public.planes_correctivos (
      number, detection_date, source, responsible,
      nc_description, root_cause, status, activities, created_by
    ) VALUES (
      'DV5',
      '2025-11-01',
      'Auditoría externa',
      'Encargada de Credencialización',
      'DV — Proceso: Dirección Médica (§8.5). En el proceso de credencialización, la actualización de documentos (credenciales) no se encuentra registrada cuando ocurren vencimientos de documentos tales como certificación y póliza de seguros.',
      'El procedimiento del proceso de credencialización no establece un método formal para el registro, control y seguimiento de la actualización de documentos del personal (certificaciones, cédulas, pólizas, constancias). Deficiencia metodológica en el diseño del proceso y falta de integración del control de vigencias en el sistema documental del SGC; ausencia de un formato o herramienta que evidencie la trazabilidad y actualización de documentos del personal credencializado.',
      'en_proceso',
      '[
        {"description":"Actualizar el formato de credencialización (check list de integración de expediente de cuerpo médico)","responsible":"Encargada de Credencialización","due_date":"2025-11-30","status":"completado","evidence":[]},
        {"description":"Actualizar el Procedimiento de Credencialización del Personal incorporando: etapa formal de verificación y registro documental antes de emisión o renovación; listado de documentos obligatorios; responsables del seguimiento y frecuencia de revisión","responsible":"Encargada de Credencialización","due_date":"2025-11-30","status":"completado","evidence":[]},
        {"description":"Establecer alertamiento mensual o trimestral para seguimiento de documentos del personal médico próximos a vencer","responsible":"Encargada de Credencialización","due_date":"2025-12-16","status":"en_proceso","evidence":[]}
      ]'::jsonb,
      v_user
    );
  END IF;

  -- ─────────────────────────────────────────────────────────────────
  -- DV6 · Rehabilitación · §8.5 · Bitácoras de Educación
  -- Avance: 33% → 1 de 3 actividades completadas
  -- ─────────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'DV6') THEN
    INSERT INTO public.planes_correctivos (
      number, detection_date, source, responsible,
      nc_description, root_cause, status, activities, created_by
    ) VALUES (
      'DV6',
      '2025-11-01',
      'Auditoría externa',
      'Encargada de Rehabilitación',
      'DV — Proceso: Rehabilitación (§8.5). Las bitácoras de educación no documentan el nombre del paciente, dato indispensable para dar seguimiento. Ejemplo: Septiembre 15 a las 10:00 hrs solo indica "Dra. Fernanda Toro"; a las 11:30 indica "Consulta Dra. Fernanda Toro", sin identificar al paciente atendido.',
      'El formato de bitácora del proceso de Rehabilitación no contempla un campo obligatorio para el nombre o identificador del paciente, ni cuenta con un mecanismo de supervisión que verifique la completitud de los registros. Deficiencia en el diseño del formato y falta de capacitación y retroalimentación al personal sobre la importancia del registro completo para la trazabilidad del servicio.',
      'en_proceso',
      '[
        {"description":"Actualizar el formato institucional de Bitácora de Rehabilitación incorporando campos obligatorios: nombre del paciente, número de expediente y servicio","responsible":"Encargada de Rehabilitación","due_date":"2025-11-11","status":"en_proceso","evidence":[]},
        {"description":"Establecer dentro del procedimiento operativo del servicio de Rehabilitación un apartado de control y supervisión de registros con revisión mensual por el responsable del área","responsible":"Encargada de Rehabilitación","due_date":"2025-11-18","status":"pendiente","evidence":[]},
        {"description":"Implementar revisión mensual de trazabilidad de registros verificando el cumplimiento de los campos obligatorios en la bitácora","responsible":"Encargada de Rehabilitación","due_date":"2025-11-30","status":"pendiente","evidence":[]}
      ]'::jsonb,
      v_user
    );
  END IF;

  -- ─────────────────────────────────────────────────────────────────
  -- DV7 · Farmacia / Ingeniería Biomédica · §7.1.5.2 · Calibración de Termómetros
  -- Avance: 40% → 2 de 5 actividades completadas
  -- ─────────────────────────────────────────────────────────────────
  IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'DV7') THEN
    INSERT INTO public.planes_correctivos (
      number, detection_date, source, responsible,
      nc_description, root_cause, status, activities, created_by
    ) VALUES (
      'DV7',
      '2025-11-01',
      'Auditoría externa',
      'Encargado de Ingeniería Biomédica',
      'DV — Proceso: Farmacia (§7.1.5.2). En el proceso de cocina hospitalaria se cuenta con 2 refrigeradores cuyos termómetros no son calibrados con trazabilidad apropiada. En el proceso de farmacia igualmente se tienen 2 refrigeradores cuyos termómetros no han sido calibrados conforme a patrones de medición trazables a estándares nacionales o internacionales.',
      'El programa institucional de calibración y verificación de equipos de medición no incluye los termómetros de refrigeradores de cocina y farmacia dentro de su alcance operativo, debido a una falla en la identificación y registro de equipos críticos. Ausencia de un inventario maestro de equipos de medición actualizado.',
      'en_proceso',
      '[
        {"description":"Realizar levantamiento y registro de todos los termómetros existentes en los servicios de cocina y farmacia","responsible":"Encargado de Ingeniería Biomédica","due_date":"2025-11-30","status":"completado","evidence":[]},
        {"description":"Envío de termómetros a calibración según corresponda (laboratorio acreditado con trazabilidad a patrones nacionales/internacionales)","responsible":"Encargado de Ingeniería Biomédica","due_date":"2025-11-30","status":"en_proceso","evidence":[]},
        {"description":"Actualizar el Procedimiento de Control y Calibración de Equipos de Medición: incluir termómetros de cocina y farmacia, frecuencia de calibración, responsables, criterios de aceptación y control de vigencia","responsible":"Encargado de Ingeniería Biomédica","due_date":"2025-12-16","status":"pendiente","evidence":[]},
        {"description":"Crear y mantener Inventario Maestro de Equipos de Medición: código, nombre, área, ubicación, número de serie, fechas de calibración, laboratorio, responsable y estatus","responsible":"Encargado de Ingeniería Biomédica","due_date":"2025-12-16","status":"pendiente","evidence":[]},
        {"description":"Registrar certificados de calibración obtenidos y colocar etiquetas de control con fecha de calibración y próxima recalibración","responsible":"Encargado de Ingeniería Biomédica","due_date":"2025-12-16","status":"pendiente","evidence":[]}
      ]'::jsonb,
      v_user
    );
  END IF;

  RAISE NOTICE '✓ Seed de acciones correctivas completado.';

END $$;

-- ─────────────────────────────────────────────────────────────────
-- Verificación
-- ─────────────────────────────────────────────────────────────────
SELECT
  number,
  status,
  responsible,
  jsonb_array_length(activities) AS num_actividades,
  (
    SELECT count(*)
    FROM jsonb_array_elements(activities) a
    WHERE a->>'status' = 'completado'
  ) AS completadas,
  detection_date
FROM public.planes_correctivos
WHERE number IN ('NC1','NC2','NC3','DV1','DV2','DV3','DV4','DV5','DV6','DV7')
ORDER BY number;
