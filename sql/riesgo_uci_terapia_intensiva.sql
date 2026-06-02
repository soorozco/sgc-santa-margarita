-- ══════════════════════════════════════════════════════════════════
-- Riesgos — Terapia Intensiva (UCI)
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Cubre los 20 procedimientos documentados:
--   PR-UCI-01..12  (uci_docs.sql)
--   PR-UCI-13..20  (uci_docs_13_20.sql)
--
-- Custodio: Jefe de Terapia Intensiva
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

INSERT INTO risk_processes (
  name, process_type, process_owner, description, sort_order, risks
)
VALUES (
  'Terapia Intensiva (UCI)',
  'misional',
  'Jefe de Terapia Intensiva',
  'Atención de pacientes críticos en la Unidad de Cuidados Intensivos: inserción y manejo de dispositivos vasculares y pleurales, ventilación mecánica invasiva, monitoreo hemodinámico avanzado, procedimientos de emergencia (cardioversión, desfibrilación, marcapasos) y procedimientos diagnósticos (paracentesis, toracocentesis, punción lumbar, pericardiocentesis).',
  23,
  '[
    {
      "id": "uci-01",
      "type": "riesgo",
      "description": "Infección del torrente sanguíneo asociada a catéter (ITSAC) en catéter venoso central o línea arterial (PR-UCI-02/03/04)",
      "cause": "Técnica de inserción no estéril, mantenimiento inadecuado (apósito, línea), no retiro oportuno del dispositivo innecesario",
      "effect": "Bacteremia, sepsis grave, aumento de estancia y mortalidad",
      "probability": 3,
      "impact": 5,
      "action_plan": "Aplicar Bundle de catéter central (higiene de manos, máxima barrera estéril, clorhexidina, sitio subclavio preferente, retiro diario de dispositivos innecesarios). Registro diario de días-catéter. Revisión mensual de tasa de ITSAC con UVEH.",
      "responsible": "Jefe de Terapia Intensiva",
      "due_date": "2026-06-30",
      "status": "en_control"
    },
    {
      "id": "uci-02",
      "type": "riesgo",
      "description": "Neumonía asociada a ventilación mecánica (NAVM) en pacientes intubados (PR-UCI-14/13/16)",
      "cause": "Higiene bucal insuficiente, cabecera en posición menor a 30°, falta de interrupción diaria de sedación y evaluación de extubación, aspiración de secreciones sin técnica estéril",
      "effect": "Infección pulmonar nosocomial grave, prolongación de VMI, aumento de estancia y mortalidad",
      "probability": 3,
      "impact": 5,
      "action_plan": "Implementar Bundle de NAVM: elevación de cabecera 30-45°, higiene bucal con clorhexidina cada 8 h, interrupción diaria de sedación, evaluación diaria de extubación, presión de neumotaponamiento 20-30 cmH₂O. Registro de días-VMI. Revisión mensual de tasa con UVEH.",
      "responsible": "Jefe de Terapia Intensiva",
      "due_date": "2026-06-30",
      "status": "en_control"
    },
    {
      "id": "uci-03",
      "type": "riesgo",
      "description": "Extubación accidental o autoadministrada (PR-UCI-13/14)",
      "cause": "Fijación inadecuada del tubo orotraqueal, agitación del paciente por sedoanalgesia insuficiente, revisión deficiente durante movilizaciones o procedimientos de enfermería",
      "effect": "Emergencia respiratoria, hipoxia severa, necesidad de reintubación urgente, riesgo de muerte",
      "probability": 2,
      "impact": 5,
      "action_plan": "Verificar y reforzar la fijación del TOT en cada turno y después de cada movilización. Escala de sedación-agitación validada (RASS) cada 4 h. Protocolo de manejo de vía aérea difícil disponible y equipo comprobado diariamente.",
      "responsible": "Jefatura de Enfermería",
      "due_date": "2026-06-30",
      "status": "en_control"
    },
    {
      "id": "uci-04",
      "type": "riesgo",
      "description": "Infección de tracto urinario asociada a catéter (ITUAC) (PR-UCI-08)",
      "cause": "Técnica de inserción no estéril de sonda vesical, sistema de drenaje abierto o desconectado, no retiro oportuno de la sonda al resolverse la indicación",
      "effect": "Infección urinaria, urosepsis, bacteremia secundaria",
      "probability": 3,
      "impact": 3,
      "action_plan": "Indicación documentada y revisada diariamente. Inserción con técnica aséptica. Sistema de drenaje cerrado en posición declive. Higiene del meato uretral diaria. Registro de días-sonda. Retiro en cuanto cesa la indicación.",
      "responsible": "Jefatura de Enfermería",
      "due_date": "2026-06-30",
      "status": "en_control"
    },
    {
      "id": "uci-05",
      "type": "riesgo",
      "description": "Neumotórax iatrogénico durante inserción de catéter venoso central o tubo pleural (PR-UCI-02/09/20)",
      "cause": "Técnica de inserción sin guía ultrasonográfica, posición incorrecta del paciente, variación anatómica no identificada",
      "effect": "Neumotórax simple o a tensión, compromiso respiratorio agudo y hemodinámico",
      "probability": 2,
      "impact": 4,
      "action_plan": "Utilizar guía ultrasonográfica para acceso venoso central siempre que esté disponible. Radiografía de tórax post-procedimiento inmediata. Registro del procedimiento con técnica y complicaciones en el expediente. Capacitación periódica en simulación.",
      "responsible": "Jefe de Terapia Intensiva",
      "due_date": "2026-09-30",
      "status": "identificado"
    },
    {
      "id": "uci-06",
      "type": "riesgo",
      "description": "Error en la identificación del paciente crítico antes de un procedimiento invasivo (todos los PR-UCI)",
      "cause": "Paciente inconsciente o sedado sin posibilidad de confirmar verbalmente, verificación insuficiente con expediente o brazalete antes del procedimiento",
      "effect": "Procedimiento realizado en paciente incorrecto, evento adverso grave, responsabilidad médico-legal",
      "probability": 2,
      "impact": 4,
      "action_plan": "Doble verificación de identidad con brazalete + expediente antes de cada procedimiento invasivo. Lista de verificación pre-procedimiento obligatoria. Pausas de seguridad (time-out) antes de procedimientos de alto riesgo.",
      "responsible": "Jefe de Terapia Intensiva",
      "due_date": "2026-06-30",
      "status": "en_control"
    },
    {
      "id": "uci-07",
      "type": "riesgo",
      "description": "Sobredosificación o subdosificación de sedoanalgesia en el paciente crítico (PR-UCI-16)",
      "cause": "Ajuste de dosis sin escala validada, ausencia de evaluación sistemática de sedación y dolor, comunicación deficiente en cambio de turno",
      "effect": "Agitación con extubación accidental o desconexión de dispositivos (subdosis), o depresión respiratoria y prolongación de VMI (sobredosis)",
      "probability": 3,
      "impact": 4,
      "action_plan": "Uso obligatorio de escala RASS para sedación y NRS/BPS para dolor en cada valoración. Protocolo de sedoanalgesia con objetivos definidos y ajuste por escala. Informe en cada cambio de turno con estado de sedación. Revisión de bombas de infusión en cada ronda.",
      "responsible": "Jefe de Terapia Intensiva",
      "due_date": "2026-06-30",
      "status": "en_control"
    },
    {
      "id": "uci-08",
      "type": "riesgo",
      "description": "Complicaciones por cardioversión o desfibrilación incorrecta (PR-UCI-01/12)",
      "cause": "Selección inadecuada de nivel de energía, posicionamiento incorrecto de palas o parches, falta de sincronización en cardioversión electiva, equipo sin revisión periódica",
      "effect": "Quemaduras cutáneas, arritmia maligna desencadenada, choque eléctrico accidental al personal, fallo del procedimiento",
      "probability": 2,
      "impact": 5,
      "action_plan": "Verificar modo sincronizado/no sincronizado según indicación antes del procedimiento. Comprobación del equipo (desfibrilador) al inicio de cada turno. Capacitación en ACLS vigente para todo el personal médico y de enfermería de UCI. Registro de procedimiento con nivel de energía y resultado.",
      "responsible": "Jefe de Terapia Intensiva",
      "due_date": "2026-06-30",
      "status": "en_control"
    },
    {
      "id": "uci-09",
      "type": "riesgo",
      "description": "Desaturación o paro cardiorrespiratorio durante intubación orotraqueal difícil (PR-UCI-14)",
      "cause": "Vía aérea difícil no prevista, preoxigenación insuficiente, equipo de vía aérea difícil no disponible o no revisado, operador sin experiencia en vía aérea difícil",
      "effect": "Hipoxia severa, daño neurológico anóxico, paro cardiaco, muerte",
      "probability": 2,
      "impact": 5,
      "action_plan": "Valoración de vía aérea antes de toda intubación programada. Carro de vía aérea difícil comprobado al inicio de turno. Plan B documentado antes de iniciar la intubación. Preoxigenación ≥3 min con oxígeno al 100%. Disponibilidad de videolaringoscopio. Capacitación en simulación de manejo de vía aérea difícil.",
      "responsible": "Jefe de Terapia Intensiva",
      "due_date": "2026-09-30",
      "status": "en_control"
    },
    {
      "id": "uci-10",
      "type": "riesgo",
      "description": "Tromboembolia pulmonar (TEP) por trombosis venosa profunda (TVP) en paciente crítico inmovilizado (PR-UCI-16)",
      "cause": "Omisión de profilaxis antitrombótica (heparina, compresión neumática), evaluación de riesgo tromboembólico no realizada al ingreso, movilización pasiva insuficiente",
      "effect": "TEP masiva, cor pulmonale agudo, colapso hemodinámico, muerte súbita",
      "probability": 2,
      "impact": 5,
      "action_plan": "Escala de riesgo tromboembólico (Padua/Caprini) al ingreso de cada paciente. Profilaxis farmacológica con heparina de bajo peso molecular cuando no exista contraindicación. Compresión neumática intermitente en pacientes con contraindicación a anticoagulación. Movilización pasiva y cambios de posición cada 2 h.",
      "responsible": "Jefe de Terapia Intensiva",
      "due_date": "2026-06-30",
      "status": "en_control"
    }
  ]'
)
ON CONFLICT (name) DO UPDATE SET
  process_owner = EXCLUDED.process_owner,
  description   = EXCLUDED.description,
  risks         = EXCLUDED.risks,
  updated_at    = now();


-- ── Verificación ──────────────────────────────────────────────────
SELECT
  name,
  process_type,
  process_owner,
  jsonb_array_length(risks) AS total_riesgos,
  sort_order
FROM risk_processes
WHERE name = 'Terapia Intensiva (UCI)';
