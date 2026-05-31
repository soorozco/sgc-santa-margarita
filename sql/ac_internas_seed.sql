-- ═══════════════════════════════════════════════════════════════
-- Acciones Correctivas — Auditorías Internas 2025-2026
-- Hospital Santa Margarita — SGC ISO 9001:2015 §10.2
-- Ejecutar DESPUÉS de auditorias_seed.sql
-- ═══════════════════════════════════════════════════════════════
-- Numeración correlativa de auditorías internas:
--   NC-2025-001 a NC-2025-002 : AI-2025-001 Quirófano May-2025
--   NC-2025-003 a NC-2025-005 : AI-2025-002 Cocina Jul-2025
--   NC-2025-006 a NC-2025-007 : AI-2025-003 Quirófano Ago-2025
--   NC-2025-008 a NC-2025-011 : AI-2025-004 Farmacia Sep-2025
--   NC-2025-012 a NC-2025-014 : AI-2025-005 Urgencias Oct-2025
--   NC-2025-015 a NC-2025-017 : AI-2025-006 Admisión Nov-2025
--   NC-2025-018 a NC-2025-019 : AI-2025-007 Quirófano Nov-2025
--   NC-2025-020 a NC-2025-022 : AI-2025-008 Farmacia Dic-2025
--   NC-2025-023 a NC-2025-024 : AI-2025-009 Imagenología Dic-2025
--   NC-2026-001 a NC-2026-003 : AI-2026-001 Admisión Ene-2026
--   NC-2026-004 a NC-2026-005 : AI-2026-002 Urgencias Feb-2026
--   NC-2026-006 a NC-2026-010 : AI-2026-003 Enfermería Mar-2026
--   NC-2026-011 a NC-2026-013 : AI-2026-004 Quirófano Abr-2026
-- ═══════════════════════════════════════════════════════════════

DO $$
DECLARE v_user uuid;
BEGIN
  SELECT id INTO v_user FROM auth.users WHERE email = 'omar.orozco@gmail.com' LIMIT 1;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-001 · Lista de verificación quirúrgica OMS
-- AI-2025-001 · §8.5 · CERRADO (verificado en AI-2025-007)
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-001') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-001', '2025-05-14', 'Auditoría interna',
    'Jefe de Quirófano',
    'NC Menor §8.5 — AI-2025-001 Quirófano: Lista de verificación quirúrgica (OMS) no completada en 2 de 5 expedientes revisados; se omitieron los campos de confirmación de alergias y lateralidad.',
    'El personal de enfermería circulante no tenía interiorizado el carácter obligatorio de la lista OMS. El formato impreso era de versión anterior (2022); el nuevo formato con campo de alergias no había sido difundido formalmente.',
    'cerrado',
    '[
      {"description":"Actualizar formato FT-CA-50 (Lista de Verificación Quirúrgica OMS) a versión 2025 con campo de alergias y lateralidad","responsible":"Responsable de Calidad","due_date":"2025-06-10","status":"completado","evidence":[{"name":"FT-CA-50 v2025 aprobado","type":"documento","fecha":"2025-06-08"}]},
      {"description":"Capacitación al 100% del personal de quirófano en la nueva versión de la lista OMS","responsible":"Jefe de Quirófano","due_date":"2025-06-20","status":"completado","evidence":[{"name":"Lista de asistencia capacitación OMS — Jun 2025 (18 personas)","type":"registro","fecha":"2025-06-18"}]},
      {"description":"Verificar cumplimiento durante 4 semanas consecutivas: revisión aleatoria de 5 expedientes/semana","responsible":"Jefe de Quirófano","due_date":"2025-07-18","status":"completado","evidence":[{"name":"Reporte de cumplimiento OMS sem 1-4 jun-jul 2025 (cumplimiento 95%)","type":"reporte","fecha":"2025-07-18"}]},
      {"description":"Validar cierre de NC en auditoría de seguimiento agosto 2025","responsible":"Dra. Giselle De la Torre","due_date":"2025-08-21","status":"completado","evidence":[{"name":"Acta AI-2025-003 — NC-2025-001 verificada, cumplimiento 90%","type":"acta","fecha":"2025-08-21"}]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-002 · Trazabilidad de esterilización
-- AI-2025-001 · §7.5 · CERRADO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-002') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-002', '2025-05-14', 'Auditoría interna',
    'Encargada de CEYE',
    'NC Menor §7.5 — AI-2025-001 Quirófano: Registros de esterilización con datos incompletos. Falta lote y fecha de caducidad en 3 de 10 paquetes revisados. No se cumple trazabilidad §7.5.3.',
    'El formato de registro de esterilización (FT-CE-01) no incluía campo de lote. El personal de CEYE registraba los datos de caducidad en libreta manual no integrada al expediente.',
    'cerrado',
    '[
      {"description":"Actualizar FT-CE-01 (Registro de Esterilización) incorporando campos de lote de bolsa, fecha de esterilización, fecha de caducidad y responsable","responsible":"Encargada de CEYE","due_date":"2025-06-15","status":"completado","evidence":[{"name":"FT-CE-01 v2025 — formato actualizado aprobado","type":"documento","fecha":"2025-06-12"}]},
      {"description":"Capacitar al personal de CEYE en correcto llenado del registro actualizado","responsible":"Encargada de CEYE","due_date":"2025-06-25","status":"completado","evidence":[{"name":"Lista asistencia capacitación CEYE (6 personas)","type":"registro","fecha":"2025-06-24"}]},
      {"description":"Auditoría interna de CEYE: revisión de 20 paquetes consecutivos para verificar trazabilidad completa","responsible":"Jefe de Quirófano","due_date":"2025-07-31","status":"completado","evidence":[{"name":"Reporte de auditoría CEYE jul 2025 — 98% cumplimiento","type":"reporte","fecha":"2025-07-30"}]},
      {"description":"Cierre formal de NC verificado en AI-2025-007 (noviembre 2025)","responsible":"Dra. Giselle De la Torre","due_date":"2025-11-27","status":"completado","evidence":[{"name":"Acta AI-2025-007 — NC-2025-002 CERRADA, trazabilidad 95%","type":"acta","fecha":"2025-11-27"}]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-003 · Doble verificación de dietas
-- AI-2025-002 · §8.5 · CERRADO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-003') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-003', '2025-07-10', 'Auditoría interna',
    'Encargada de Cocina',
    'NC Mayor §8.5 — AI-2025-002 Cocina: El 19-Jul-2025 se suministraron lácteos a paciente con intolerancia documentada. No existe protocolo de doble verificación antes de despachar las bandejas.',
    'El proceso de preparación y entrega de dietas no contaba con un paso formal de verificación cruzada entre el área de nutrición y enfermería. La indicación de intolerancia estaba en el expediente pero no existía un mecanismo que la conectara con el listado de dietas.',
    'cerrado',
    '[
      {"description":"Diseñar e implementar FT-NU-08 (Doble Verificación de Dietas) con firma dietista + enfermería antes de cada despacho","responsible":"Encargada de Cocina / Jefa de Enfermería","due_date":"2025-09-01","status":"completado","evidence":[{"name":"FT-NU-08 v1.0 — Protocolo doble verificación dietas aprobado","type":"documento","fecha":"2025-08-28"}]},
      {"description":"Capacitar al personal de cocina y enfermería en el nuevo protocolo de entrega de dietas","responsible":"Encargada de Cocina","due_date":"2025-09-10","status":"completado","evidence":[{"name":"Lista asistencia capacitación (22 personas, 2 sesiones)","type":"registro","fecha":"2025-09-08"}]},
      {"description":"Implementar alerta en sistema de indicaciones: campo de restricción alimentaria visible al generar listado de dietas","responsible":"Responsable de Calidad / TI","due_date":"2025-10-15","status":"completado","evidence":[{"name":"Captura de pantalla sistema con campo restricción activo","type":"registro","fecha":"2025-10-14"}]},
      {"description":"Verificación de cumplimiento: revisión de 15 días consecutivos con auditoría de 3 bandejas aleatorias/día","responsible":"Encargada de Cocina","due_date":"2025-11-01","status":"completado","evidence":[{"name":"Reporte de monitoreo oct 2025 — 100% sin incidencias","type":"reporte","fecha":"2025-11-01"}]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-006 · Monitorización y reporte de dispositivos invasivos
-- AI-2025-003 · §8.5 · EN PROCESO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-006') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-006', '2025-08-21', 'Auditoría interna',
    'Jefa de Enfermería',
    'NC Mayor §8.5 — AI-2025-003 Quirófano: Desplazamiento de CVC sin notificación oportuna (30-Jul); mala manipulación de nefrostomías sin consultar al médico tratante (13-14-Ago). Falla en monitorización y reporte de dispositivos invasivos.',
    'El personal de enfermería no contaba con un procedimiento escrito y actualizado para la supervisión periódica de dispositivos invasivos (CVC, sondas, nefrostomías). La cultura de notificación al médico tratante ante anomalías era irregular, con variabilidad entre turnos.',
    'en_proceso',
    '[
      {"description":"Elaborar y difundir PR-EN-15 (Monitorización y Reporte de Dispositivos Invasivos) con frecuencia de verificación cada 4 horas","responsible":"Jefa de Enfermería","due_date":"2025-10-15","status":"completado","evidence":[{"name":"PR-EN-15 v1.0 — Procedimiento de monitorización CVC/sondas aprobado","type":"documento","fecha":"2025-10-12"}]},
      {"description":"Capacitación obligatoria a los 3 turnos de enfermería en el procedimiento PR-EN-15","responsible":"Jefa de Enseñanza","due_date":"2025-11-01","status":"completado","evidence":[{"name":"Registros de capacitación 3 turnos — 45 enfermeros capacitados","type":"registro","fecha":"2025-10-30"}]},
      {"description":"Implementar checklist de dispositivos en hoja de ronda de enfermería (FT-EN-22)","responsible":"Jefa de Enfermería","due_date":"2025-12-01","status":"completado","evidence":[{"name":"FT-EN-22 v2025 con campo de dispositivos invasivos","type":"documento","fecha":"2025-11-28"}]},
      {"description":"Supervisión directa por Jefatura de Enfermería durante 30 días para verificar llenado del checklist","responsible":"Jefa de Enfermería","due_date":"2026-01-15","status":"en_proceso","evidence":[{"name":"Reporte parcial de supervisión ene 2026 — 78% cumplimiento","type":"reporte","fecha":"2026-01-10"}]},
      {"description":"Verificación de cierre en próxima auditoría interna (objetivo: 0 eventos por falta de monitorización)","responsible":"Dra. Giselle De la Torre","due_date":"2026-06-30","status":"pendiente","evidence":[]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-009 · Lista LASA en Farmacia
-- AI-2025-004 · §8.5 · EN PROCESO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-009') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-009', '2025-09-18', 'Auditoría interna',
    'Jefa de Farmacia',
    'NC Mayor §8.5 — AI-2025-004 Farmacia: Administración de fluconazol en lugar de cilostazol (error LASA). No existe lista de medicamentos de aspecto o nombre similar disponible en el servicio ni en central de enfermería.',
    'No se había implementado formalmente la gestión de medicamentos LASA en el hospital. La lista de medicamentos de alto riesgo en farmacia no incluía criterios de diferenciación visual ni protocolos de doble verificación específicos para LASA.',
    'en_proceso',
    '[
      {"description":"Elaborar lista institucional LASA con los medicamentos de mayor riesgo identificados en el hospital","responsible":"Jefa de Farmacia","due_date":"2025-11-01","status":"completado","evidence":[{"name":"Lista LASA hospitalaria v1.0 — 34 pares identificados","type":"documento","fecha":"2025-10-29"}]},
      {"description":"Imprimir y publicar lista LASA en área de dispensación de farmacia y en central de enfermería de cada piso","responsible":"Jefa de Farmacia","due_date":"2025-11-15","status":"completado","evidence":[{"name":"Fotografías de publicación LASA en 4 áreas del hospital","type":"registro","fecha":"2025-11-14"}]},
      {"description":"Capacitar al personal de enfermería y farmacia en identificación y manejo de medicamentos LASA","responsible":"Jefa de Enseñanza","due_date":"2025-12-01","status":"completado","evidence":[{"name":"Lista asistencia capacitación LASA — 52 personas, 4 sesiones","type":"registro","fecha":"2025-11-30"}]},
      {"description":"Implementar etiqueta diferenciadora (tall-man lettering) en el sistema de dispensación para medicamentos LASA","responsible":"Jefa de Farmacia","due_date":"2026-02-28","status":"en_proceso","evidence":[{"name":"Propuesta de etiquetado tall-man enviada a proveedor de sistema","type":"registro","fecha":"2026-01-20"}]},
      {"description":"Verificar reducción de errores LASA en los 6 meses post-implementación","responsible":"Responsable de Calidad","due_date":"2026-06-30","status":"pendiente","evidence":[]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-012 · Escala de riesgo de caídas
-- AI-2025-005 · §6.1 · CERRADO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-012') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-012', '2025-10-23', 'Auditoría interna',
    'Jefa de Enfermería',
    'NC Mayor §6.1 — AI-2025-005 Urgencias: Tres caídas documentadas en octubre 2025 (2 moderadas, 1 Grave). No existe evaluación de riesgo de caídas para pacientes con barrera de idioma ni sistema de apoyo nocturno para adultos mayores sin acompañante.',
    'La escala de valoración de riesgo de caídas no era aplicada de manera sistemática en todos los pacientes al ingreso. El proceso de identificación de pacientes en riesgo no contemplaba variables como barrera idiomática, adulto mayor sin familiar y medicamentos que alteran el equilibrio.',
    'cerrado',
    '[
      {"description":"Implementar Escala de Morse como herramienta oficial de valoración de riesgo de caídas al ingreso y cada 24 horas","responsible":"Jefa de Enfermería","due_date":"2025-12-01","status":"completado","evidence":[{"name":"Escala de Morse integrada a FT-EN-05 (Valoración de Ingreso)","type":"documento","fecha":"2025-11-28"}]},
      {"description":"Capacitación a todo el personal de enfermería en aplicación de la Escala de Morse y medidas preventivas por nivel de riesgo","responsible":"Jefa de Enseñanza","due_date":"2025-12-10","status":"completado","evidence":[{"name":"Lista asistencia capacitación caídas — 58 personas en 5 sesiones","type":"registro","fecha":"2025-12-09"}]},
      {"description":"Implementar protocolo de colocación de pulsera amarilla para pacientes con riesgo alto (Morse ≥ 45)","responsible":"Jefa de Enfermería","due_date":"2025-12-15","status":"completado","evidence":[{"name":"Fotoevidencia de implementación pulsera amarilla en 3 pisos","type":"registro","fecha":"2025-12-15"}]},
      {"description":"Instalar baranda en todos los baños de habitación doble y revisar piso antideslizante en áreas de tráfico","responsible":"Jefe de Mantenimiento","due_date":"2026-01-31","status":"completado","evidence":[{"name":"Acta de inspección y mejoras en baños — 22 habitaciones","type":"registro","fecha":"2026-01-30"}]},
      {"description":"Revisión en AI-2026-002 (Urgencias Feb 2026): 0 caídas en las 4 semanas previas a la auditoría","responsible":"Dra. Giselle De la Torre","due_date":"2026-02-26","status":"completado","evidence":[{"name":"Acta AI-2026-002 — NC-2025-012 CERRADA. Escala Morse al 94%.","type":"acta","fecha":"2026-02-26"}]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-013 · Protocolo de acceso a carro rojo
-- AI-2025-005 · §8.5 · CERRADO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-013') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-013', '2025-10-23', 'Auditoría interna',
    'Jefa de Farmacia',
    'NC Mayor §8.5 — AI-2025-005 Urgencias: Durante evento convulsivo, enfermería administró midazolam en lugar de diazepam al abrir carro rojo sin filtro de farmacia. Error de medicamento de emergencia con omisión de registro.',
    'El procedimiento de acceso al carro rojo no contemplaba doble verificación de medicamento, y farmacia no tenía presencia protocolizada para urgencias nocturnas. El personal de enfermería no tenía claridad sobre las vías de escalamiento para acceso a medicamentos de emergencia.',
    'cerrado',
    '[
      {"description":"Elaborar PR-FA-10 (Acceso y Uso de Carro Rojo de Emergencias) con doble verificación enfermería + médico de guardia","responsible":"Jefa de Farmacia / Jefe de Urgencias","due_date":"2025-12-01","status":"completado","evidence":[{"name":"PR-FA-10 v1.0 — Protocolo carro rojo con doble verificación","type":"documento","fecha":"2025-11-29"}]},
      {"description":"Instalar sello de seguridad numerado en el carro rojo con registro de apertura; el número de sello debe coincidir con la bitácora","responsible":"Jefa de Farmacia","due_date":"2025-12-01","status":"completado","evidence":[{"name":"Fotografías de carro rojo con nuevo sistema de sellado numerado","type":"registro","fecha":"2025-12-01"}]},
      {"description":"Capacitación simulacro de uso de carro rojo para enfermería y médicos de guardia (todos los turnos)","responsible":"Jefa de Enseñanza","due_date":"2025-12-15","status":"completado","evidence":[{"name":"Acta de simulacros carro rojo — 3 fechas, 4 pisos, 48 participantes","type":"registro","fecha":"2025-12-14"}]},
      {"description":"Verificación en auditoría AI-2026-002 (Urgencias Feb 2026): revisar bitácora de apertura de carro rojo de los 90 días previos","responsible":"Dra. Giselle De la Torre","due_date":"2026-02-26","status":"completado","evidence":[{"name":"Acta AI-2026-002 — NC-2025-013 CERRADA. Bitácora completa sin incidencias.","type":"acta","fecha":"2026-02-26"}]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-015 · Protocolo SBAR de entrega de pacientes
-- AI-2025-006 · §8.5 · EN PROCESO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-015') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-015', '2025-11-20', 'Auditoría interna',
    'Jefa de Admisión',
    'NC Mayor §8.5 — AI-2025-006 Admisión: Paciente posquirúrgico (8-Nov-2025, resultado Grave) entregado a hospitalización hemodinámicamente inestable sin protocolo de entrega estructurado. El anestesiólogo no dejó indicaciones al retirarse de recuperación.',
    'No existía un protocolo estandarizado de comunicación estructurada (SBAR) para la entrega de pacientes entre servicios. La responsabilidad de la entrega era ambigua entre el médico que egresa al paciente y el médico que lo recibe, especialmente en el traslado recuperación → hospitalización.',
    'en_proceso',
    '[
      {"description":"Diseñar e implementar PR-GH-08 (Protocolo SBAR de Entrega de Pacientes) para traslados Urgencias→Piso, Quirófano→Recuperación y Recuperación→Piso","responsible":"Jefa de Admisión / Responsable de Calidad","due_date":"2026-01-31","status":"completado","evidence":[{"name":"PR-GH-08 v1.0 — Protocolo SBAR aprobado por Dirección Médica","type":"documento","fecha":"2026-01-28"}]},
      {"description":"Incorporar FT-GH-15 (Hoja de Entrega SBAR) al expediente clínico como registro obligatorio en cada traslado","responsible":"Jefa de Admisión","due_date":"2026-02-15","status":"completado","evidence":[{"name":"FT-GH-15 v1.0 impresa e integrada al expediente","type":"documento","fecha":"2026-02-12"}]},
      {"description":"Capacitar a médicos de guardia, anestesiólogos y supervisoras de enfermería en protocolo SBAR","responsible":"Jefa de Enseñanza","due_date":"2026-02-28","status":"completado","evidence":[{"name":"Lista asistencia capacitación SBAR — 36 personas (médicos y enfermeras supervisoras)","type":"registro","fecha":"2026-02-26"}]},
      {"description":"Monitorear la adherencia al SBAR durante 3 meses: revisión de hojas FT-GH-15 en expedientes de traslado","responsible":"Jefa de Admisión","due_date":"2026-05-31","status":"en_proceso","evidence":[{"name":"Reporte de adherencia SBAR abr 2026 — 71% de traslados con hoja completa","type":"reporte","fecha":"2026-04-30"}]},
      {"description":"Alcanzar adherencia ≥ 95% y verificar cierre en siguiente auditoría","responsible":"Responsable de Calidad","due_date":"2026-11-30","status":"pendiente","evidence":[]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-016 · Doble verificación medicamentos alto riesgo
-- AI-2025-006 · §8.5 · EN PROCESO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-016') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-016', '2025-11-20', 'Auditoría interna',
    'Jefa de Farmacia',
    'NC Mayor §8.5 — AI-2025-006 Admisión: Sobredosis de heparina 10× la dosis indicada (11-Nov-2025, resultado Grave). La enfermera tomó dos frascos de 5,000 UI/mL 10 mL y administró el frasco completo sin doble verificación farmacéutica.',
    'El procedimiento de administración de medicamentos de alto riesgo (heparina, insulina, anticoagulantes) no exigía de forma explícita la firma de dos personas antes de la administración. El cálculo de dosis no era verificado independientemente por un segundo profesional.',
    'en_proceso',
    '[
      {"description":"Emitir lista oficial de medicamentos de alto riesgo institucionales con etiquetado diferenciado (banda roja) en farmacia y en unidades de enfermería","responsible":"Jefa de Farmacia","due_date":"2025-12-15","status":"completado","evidence":[{"name":"Lista medicamentos alto riesgo HSM v1.0 — 18 medicamentos identificados","type":"documento","fecha":"2025-12-12"}]},
      {"description":"Actualizar PR-EN-07 (Administración de Medicamentos) con sección obligatoria de doble verificación para medicamentos de alto riesgo, con firma de cálculo y firma de verificación","responsible":"Jefa de Enfermería","due_date":"2025-12-15","status":"completado","evidence":[{"name":"PR-EN-07 v3.0 — Capítulo 5: Medicamentos de Alto Riesgo con doble firma","type":"documento","fecha":"2025-12-14"}]},
      {"description":"Capacitación a todo el personal de enfermería en el protocolo de doble verificación","responsible":"Jefa de Enseñanza","due_date":"2026-01-15","status":"completado","evidence":[{"name":"Lista asistencia capacitación doble verificación (63 personas, 6 sesiones)","type":"registro","fecha":"2026-01-14"}]},
      {"description":"Auditoría sorpresa mensual: verificar que el 100% de los registros de medicamentos de alto riesgo del período cuenten con doble firma","responsible":"Jefa de Enfermería","due_date":"2026-05-31","status":"en_proceso","evidence":[{"name":"Auditoria sorpresa feb 2026: 82% cumplimiento doble firma en heparina e insulina","type":"reporte","fecha":"2026-02-28"},{"name":"Auditoria sorpresa abr 2026: 89% cumplimiento — mejora sostenida","type":"reporte","fecha":"2026-04-30"}]},
      {"description":"Alcanzar 100% de cumplimiento sostenido 3 meses consecutivos y cerrar NC","responsible":"Responsable de Calidad","due_date":"2026-08-31","status":"pendiente","evidence":[]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-018 · Escala de Aldrete en recuperación posquirúrgica
-- AI-2025-007 · §8.5 · CERRADO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-018') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-018', '2025-11-27', 'Auditoría interna',
    'Jefe de Anestesiología',
    'NC Mayor §8.5 — AI-2025-007 Quirófano: No existe protocolo documentado de egreso de recuperación posquirúrgica con criterios de Aldrete. Paciente egresado inestable a hospitalización (8-Nov-2025, Grave) sin criterios formales de alta de recuperación.',
    'El criterio de egreso de recuperación posquirúrgica dependía del juicio clínico individual del anestesiólogo, sin un instrumento estandarizado. La escala de Aldrete era conocida por el equipo médico pero no estaba formalizada como obligatoria ni como registro en el expediente.',
    'cerrado',
    '[
      {"description":"Elaborar PR-AN-04 (Criterios de Egreso de Recuperación Posquirúrgica) con Escala de Aldrete modificada como instrumento obligatorio","responsible":"Jefe de Anestesiología","due_date":"2026-01-31","status":"completado","evidence":[{"name":"PR-AN-04 v1.0 — Protocolo de egreso con Aldrete aprobado por Dirección Médica","type":"documento","fecha":"2026-01-25"}]},
      {"description":"Integrar FT-AN-12 (Registro de Aldrete) al expediente clínico posquirúrgico como registro obligatorio","responsible":"Jefe de Anestesiología / Responsable de Calidad","due_date":"2026-02-01","status":"completado","evidence":[{"name":"FT-AN-12 v1.0 impresa e integrada al expediente desde feb 2026","type":"documento","fecha":"2026-02-01"}]},
      {"description":"Capacitar a anestesiólogos y enfermería de recuperación en la escala de Aldrete y los criterios de egreso","responsible":"Jefe de Anestesiología","due_date":"2026-02-28","status":"completado","evidence":[{"name":"Lista asistencia capacitación Aldrete (14 personas: anestesiólogos y enfermería UCPA)","type":"registro","fecha":"2026-02-25"}]},
      {"description":"Verificación en AI-2026-004 (Quirófano Abr 2026): 85% de expedientes con registro de Aldrete completo","responsible":"Dra. Giselle De la Torre","due_date":"2026-04-23","status":"completado","evidence":[{"name":"Acta AI-2026-004 — NC-2025-018 CERRADA. Aldrete en 85% de expedientes (meta ≥ 80%).","type":"acta","fecha":"2026-04-23"}]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-019 · Calibración y plan de mantenimiento de equipos
-- AI-2025-007 · §7.1.5 · CERRADO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-019') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-019', '2025-11-27', 'Auditoría interna',
    'Encargado de Mantenimiento Biomédico',
    'NC Menor §7.1.5 — AI-2025-007 Quirófano: Oxímetros y monitores cardíacos en área de recuperación con lecturas inconsistentes entre sí. Cuatro dispositivos dando lecturas discordantes de SpO2 sin protocolo de verificación cruzada ni calibración documentada.',
    'El programa de mantenimiento preventivo de equipos médicos no contemplaba verificación cruzada de lecturas entre dispositivos del mismo tipo. La calibración se realizaba pero sin protocolo de verificación de concordancia entre equipos de la misma área.',
    'cerrado',
    '[
      {"description":"Implementar PR-MT-06 (Verificación Cruzada de Equipos de Monitoreo) con protocolo de comparación de lecturas al inicio de cada turno","responsible":"Encargado de Mantenimiento Biomédico","due_date":"2026-01-31","status":"completado","evidence":[{"name":"PR-MT-06 v1.0 — Protocolo verificación cruzada oxímetros y monitores","type":"documento","fecha":"2026-01-28"}]},
      {"description":"Calibrar y verificar todos los oxímetros, monitores cardíacos y baumanómetros del hospital; identificar y retirar los defectuosos","responsible":"Encargado de Mantenimiento Biomédico","due_date":"2026-02-15","status":"completado","evidence":[{"name":"Informe de calibración masiva feb 2026 — 3 oxímetros dados de baja, 2 adquiridos","type":"reporte","fecha":"2026-02-14"}]},
      {"description":"Implementar etiqueta de calibración vigente en cada equipo con fecha de próxima calibración","responsible":"Encargado de Mantenimiento Biomédico","due_date":"2026-02-28","status":"completado","evidence":[{"name":"Fotografías de equipos etiquetados en 6 áreas del hospital","type":"registro","fecha":"2026-02-27"}]},
      {"description":"Verificación en AI-2026-004 (Quirófano Abr 2026): 90% de equipos con calibración vigente y etiqueta","responsible":"Dra. Giselle De la Torre","due_date":"2026-04-23","status":"completado","evidence":[{"name":"Acta AI-2026-004 — NC-2025-019 CERRADA. Calibración documentada 90%.","type":"acta","fecha":"2026-04-23"}]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2025-023 · Mantenimiento preventivo equipos de diagnóstico
-- AI-2025-009 · §7.1.5 · EN PROCESO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2025-023') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2025-023', '2025-12-18', 'Auditoría interna',
    'Encargado de Mantenimiento Biomédico',
    'NC Menor §7.1.5 — AI-2025-009 Imagenología: Electrocardiografo de planta baja fuera de servicio por más de un mes; el de Urgencias sin papel por varios días (16-Dic-2025). Sin protocolo de mantenimiento preventivo ni plan de contingencia para equipos de diagnóstico.',
    'El programa de mantenimiento preventivo no incluía todos los equipos de diagnóstico de uso frecuente (electrocardiógrafos, equipos de laboratorio rápido). La gestión de insumos consumibles (papel, reactivos) no tenía alertas de reposición proactiva.',
    'en_proceso',
    '[
      {"description":"Actualizar el Programa Anual de Mantenimiento Preventivo para incluir todos los electrocardiógrafos, desfibriladores y equipos de imagen portátiles","responsible":"Encargado de Mantenimiento Biomédico","due_date":"2026-02-28","status":"completado","evidence":[{"name":"Programa de Mantenimiento Preventivo 2026 — 48 equipos registrados","type":"documento","fecha":"2026-02-26"}]},
      {"description":"Establecer punto de reorden para insumos consumibles de equipos de diagnóstico (papel ECG, reactivos, tiras); control en farmacia/almacén","responsible":"Jefa de Farmacia / Encargado de Compras","due_date":"2026-03-15","status":"completado","evidence":[{"name":"Registro de punto de reorden en sistema de compras — 12 insumos controlados","type":"documento","fecha":"2026-03-12"}]},
      {"description":"Definir equipo de respaldo (back-up) para cada equipo de diagnóstico crítico y documentar plan de contingencia","responsible":"Encargado de Mantenimiento Biomédico","due_date":"2026-04-30","status":"en_proceso","evidence":[{"name":"Borrador plan de contingencia electrocardiógrafos en revisión por Dirección Médica","type":"registro","fecha":"2026-04-15"}]},
      {"description":"Verificar 0 equipos fuera de servicio no documentados en próxima auditoría de Imagenología (ago 2026)","responsible":"Responsable de Calidad","due_date":"2026-08-31","status":"pendiente","evidence":[]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2026-001 · Doble verificación electrolitos de alto riesgo
-- AI-2026-001 · §8.5 · EN PROCESO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2026-001') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2026-001', '2026-01-22', 'Auditoría interna',
    'Jefa de Farmacia',
    'NC Mayor §8.5 — AI-2026-001 Admisión: Preparación de KCl en lugar de KPO4 (13-Ene-2026, Moderado). KCl es medicamento de alto riesgo. El error se detectó 1 hora después de iniciada la infusión. Sin doble verificación de electrolitos concentrados.',
    'KCl y KPO4 son electrolitos de presentación similar (solución concentrada en ampolleta) que se almacenaban uno al lado del otro en el área de preparación. El personal de enfermería no tenía obligación documentada de calcular y verificar la dilución con un segundo profesional para electrolitos concentrados.',
    'en_proceso',
    '[
      {"description":"Agregar KCl, KPO4 y NaCl 17.7% a la lista de medicamentos de alto riesgo institucional con etiqueta de doble verificación OBLIGATORIA","responsible":"Jefa de Farmacia","due_date":"2026-03-01","status":"completado","evidence":[{"name":"Lista medicamentos alto riesgo v1.1 — electrolitos concentrados incluidos con banda naranja","type":"documento","fecha":"2026-02-28"}]},
      {"description":"Separar físicamente el almacenamiento de KCl y KPO4 en farmacia y en carros de medicamentos de los pisos; agregar separador rojo y señalamiento","responsible":"Jefa de Farmacia","due_date":"2026-03-01","status":"completado","evidence":[{"name":"Fotografías de reorganización de almacenamiento de electrolitos en farmacia y 4 pisos","type":"registro","fecha":"2026-03-01"}]},
      {"description":"Capacitación a enfermería sobre diferenciación, cálculo y doble verificación de electrolitos concentrados","responsible":"Jefa de Enseñanza","due_date":"2026-03-31","status":"completado","evidence":[{"name":"Lista asistencia capacitación electrolitos alto riesgo (67 enfermeros, 5 sesiones)","type":"registro","fecha":"2026-03-28"}]},
      {"description":"Auditoría sorpresa mensual de doble verificación de electrolitos en los 4 pisos de hospitalización","responsible":"Jefa de Enfermería","due_date":"2026-06-30","status":"en_proceso","evidence":[{"name":"Auditoria sorpresa may 2026: 93% doble verificación electrolitos con firma","type":"reporte","fecha":"2026-05-15"}]},
      {"description":"Cierre formal de NC con 0 errores de electrolitos en 3 meses consecutivos","responsible":"Responsable de Calidad","due_date":"2026-09-30","status":"pendiente","evidence":[]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2026-006 · Protocolo de retiro de soporte vital
-- AI-2026-003 · §8.5 · EN PROCESO (URGENTE)
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2026-006') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2026-006', '2026-03-26', 'Auditoría interna',
    'Dirección Médica',
    'NC Mayor §8.5 — AI-2026-003 Enfermería (URGENTE): 26-Mar-2026 resultado MUERTE. Enfermera apagó ventilador mecánico de paciente en cuidados paliativos al interpretar erróneamente una indicación telefónica, cuando el paciente aún presentaba frecuencia cardíaca y respiratoria en monitor. No existe protocolo de retiro de soporte vital.',
    'El hospital no contaba con un protocolo formal y escrito para la toma de decisiones de retiro o modificación de soporte vital invasivo. La acción de apagar un ventilador se realizó por una enfermera sin presencia médica verificada, sin doble confirmación y sin protocolo de documentación del consentimiento informado de cuidados paliativos.',
    'en_proceso',
    '[
      {"description":"Elaborar PR-DM-01 (Protocolo de Retiro de Soporte Vital) con doble verificación médica obligatoria, documentación en expediente y presencia del médico tratante o de guardia","responsible":"Dirección Médica / Responsable de Calidad","due_date":"2026-05-15","status":"en_proceso","evidence":[{"name":"Borrador PR-DM-01 v0.2 en revisión por Comité de Bioética y Dirección Médica","type":"registro","fecha":"2026-05-01"}]},
      {"description":"Establecer que ninguna modificación de parámetros de ventilador mecánico puede ser realizada por enfermería sin orden médica documentada y verificada","responsible":"Dirección Médica","due_date":"2026-04-30","status":"completado","evidence":[{"name":"Circular DM-2026-03 — Prohibición de modificación de ventiladores por enfermería sin orden documentada","type":"documento","fecha":"2026-04-28"}]},
      {"description":"Capacitación urgente a todo el personal de enfermería y médico de guardia sobre límites de competencia en manejo de ventilación mecánica","responsible":"Jefa de Enseñanza","due_date":"2026-05-31","status":"en_proceso","evidence":[{"name":"Capacitación sesiones 1-3 completadas (32 de 68 personas capacitadas)","type":"registro","fecha":"2026-05-20"}]},
      {"description":"Revisión y fortalecimiento del proceso de consentimiento informado para cuidados paliativos y órdenes de no reanimación","responsible":"Comité de Bioética / Responsable de Calidad","due_date":"2026-06-30","status":"pendiente","evidence":[]},
      {"description":"Presentar evidencia de implementación completa en Revisión por la Dirección extraordinaria Q3 2026","responsible":"Responsable de Calidad","due_date":"2026-09-30","status":"pendiente","evidence":[]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2026-007 · Lista LASA en hospitalización
-- AI-2026-003 · §8.5 · EN PROCESO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2026-007') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2026-007', '2026-03-26', 'Auditoría interna',
    'Jefa de Enfermería',
    'NC Mayor §8.5 — AI-2026-003 Enfermería: 25-Mar-2026 error LASA: cefotaxima preparada en lugar de cefuroxima. La lista LASA implementada en farmacia (NC-2025-009) no se había extendido formalmente a los pisos de hospitalización.',
    'La lista LASA se había publicado en farmacia (noviembre 2025) pero el proceso de capacitación y difusión al personal de hospitalización de los 4 pisos no fue completado en todos los turnos. Los pisos nocturnos tenían menor adherencia a la verificación.',
    'en_proceso',
    '[
      {"description":"Publicar lista LASA actualizada (v1.1) en central de enfermería de cada piso, área de preparación y baño de medicación","responsible":"Jefa de Enfermería / Jefa de Farmacia","due_date":"2026-04-30","status":"completado","evidence":[{"name":"Fotografías de publicación LASA en 8 puntos de hospitalización (4 pisos × 2 áreas)","type":"registro","fecha":"2026-04-29"}]},
      {"description":"Capacitación reforzada a personal de hospitalización: 100% de los 3 turnos con examen de competencia","responsible":"Jefa de Enseñanza","due_date":"2026-05-31","status":"en_proceso","evidence":[{"name":"Sesiones completadas: 8/12. Pendiente: turno nocturno piso 3 y piso 4","type":"registro","fecha":"2026-05-22"}]},
      {"description":"Implementar obligatoriedad de verificación verbal del medicamento en voz alta (lectura de nombre en voz alta antes de preparar) para LASA","responsible":"Jefa de Enfermería","due_date":"2026-06-15","status":"pendiente","evidence":[]},
      {"description":"Auditoría de campo mensual: verificar que el personal puede identificar correctamente los medicamentos LASA del piso","responsible":"Jefa de Enfermería","due_date":"2026-09-30","status":"pendiente","evidence":[]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2026-008 · Etiquetado e incompatibilidades de vías IV
-- AI-2026-003 · §8.5 · EN PROCESO
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2026-008') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2026-008', '2026-03-26', 'Auditoría interna',
    'Jefa de Enfermería',
    'NC Mayor §8.5 — AI-2026-003 Enfermería: 4-Mar y 6-Mar-2026 (Moderado): albúmina administrada por vía de norepinefrina en bomba de infusión continua causando colapso hemodinámico en dos ocasiones. Sin etiquetado de lúmenes ni protocolo de incompatibilidades IV.',
    'El hospital no contaba con un sistema de etiquetado de lúmenes de catéteres de múltiples vías ni con un procedimiento escrito de incompatibilidades de fármacos IV. El personal de enfermería desconocía que la norepinefrina requiere vía exclusiva.',
    'en_proceso',
    '[
      {"description":"Elaborar e implementar FT-EN-25 (Etiqueta de Lumen IV) con identificación del medicamento, concentración y vía reservada para catéteres multilumen","responsible":"Jefa de Enfermería","due_date":"2026-05-01","status":"completado","evidence":[{"name":"FT-EN-25 v1.0 — Etiquetas de lumen impresas y distribuidas en los 4 pisos","type":"documento","fecha":"2026-04-30"}]},
      {"description":"Publicar tabla de incompatibilidades de fármacos IV (top 20 medicamentos de UCI/Hospitalización) en central de enfermería y área de preparación","responsible":"Jefa de Farmacia","due_date":"2026-05-15","status":"en_proceso","evidence":[{"name":"Tabla de incompatibilidades en revisión por farmacia clínica — publicación pendiente","type":"registro","fecha":"2026-05-10"}]},
      {"description":"Capacitación práctica: simulación de catéter multilumen con etiquetado correcto de lúmenes y verificación de incompatibilidades","responsible":"Jefa de Enseñanza","due_date":"2026-06-15","status":"pendiente","evidence":[]},
      {"description":"Auditoría de campo: verificar etiquetado de lúmenes en 100% de los pacientes con CVC o PICC activos","responsible":"Responsable de Calidad","due_date":"2026-09-30","status":"pendiente","evidence":[]}
    ]'::jsonb,
    v_user
  );
END IF;

-- ──────────────────────────────────────────────────────────────
-- NC-2026-011 · Protocolo de acceso a salas en urgencias
-- AI-2026-004 · §8.5 · PENDIENTE
-- ──────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM public.planes_correctivos WHERE number = 'NC-2026-011') THEN
  INSERT INTO public.planes_correctivos (
    number, detection_date, source, responsible, nc_description, root_cause, status, activities, created_by
  ) VALUES (
    'NC-2026-011', '2026-04-23', 'Auditoría interna',
    'Dirección Médica',
    'NC Mayor §8.5 — AI-2026-004 Quirófano: 1-Abr-2026: Paciente en urgencia dialítica fue obstaculizada para la colocación de catéter tunelizado por supervisión de enfermería que se negó a autorizar sala de rayos X disponible. Trabajadoras dormidas en turno nocturno, sin respuesta al teléfono.',
    'No existe un protocolo que establezca la prioridad clínica para el uso de salas de procedimientos (rayos X, salas de procedimientos menores) ante urgencias, independientemente de criterios administrativos o de horario. La autonomía de supervisión de enfermería para bloquear decisiones médicas en pacientes críticos no está limitada por ningún procedimiento.',
    'abierto',
    '[
      {"description":"Elaborar PR-DM-02 (Acceso Prioritario a Salas de Procedimientos en Urgencias) con definición de criterios clínicos de prioridad y proceso de aprobación inmediata","responsible":"Dirección Médica / Jefe de Quirófano","due_date":"2026-06-15","status":"pendiente","evidence":[]},
      {"description":"Definir el rol y los límites de supervisión de enfermería en decisiones sobre recursos para pacientes inestables","responsible":"Dirección Médica / Jefa de Enfermería","due_date":"2026-06-30","status":"pendiente","evidence":[]},
      {"description":"Capacitación a supervisoras de enfermería y jefes de turno sobre el protocolo de prioridad clínica","responsible":"Jefa de Enseñanza","due_date":"2026-07-31","status":"pendiente","evidence":[]},
      {"description":"Verificar implementación en siguiente auditoría de Quirófano (oct 2026)","responsible":"Responsable de Calidad","due_date":"2026-10-31","status":"pendiente","evidence":[]}
    ]'::jsonb,
    v_user
  );
END IF;

END $$;
