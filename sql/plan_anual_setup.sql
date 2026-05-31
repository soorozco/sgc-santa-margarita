-- ═══════════════════════════════════════════════════════════════
-- Plan Anual de Auditorías Internas — FT-CA-39
-- Ejecutar en Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.plan_anual_auditorias (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  year          INTEGER NOT NULL,
  month         INTEGER NOT NULL CHECK (month BETWEEN 1 AND 12),
  area          TEXT NOT NULL,
  alcance       TEXT,
  auditor_lider TEXT,
  responsable   TEXT,
  status        TEXT NOT NULL DEFAULT 'programada',
  -- programada / realizada / seguimiento / cancelada / reprogramada
  auditoria_id  UUID REFERENCES public.auditorias_internas(id) ON DELETE SET NULL,
  notas         TEXT,
  created_by    UUID REFERENCES auth.users(id),
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE public.plan_anual_auditorias ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS paa_select ON public.plan_anual_auditorias;
DROP POLICY IF EXISTS paa_insert ON public.plan_anual_auditorias;
DROP POLICY IF EXISTS paa_update ON public.plan_anual_auditorias;
DROP POLICY IF EXISTS paa_delete ON public.plan_anual_auditorias;

CREATE POLICY paa_select ON public.plan_anual_auditorias FOR SELECT TO authenticated USING (true);
CREATE POLICY paa_insert ON public.plan_anual_auditorias FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY paa_update ON public.plan_anual_auditorias FOR UPDATE TO authenticated USING (true);
CREATE POLICY paa_delete ON public.plan_anual_auditorias FOR DELETE TO authenticated USING (true);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.plan_anual_auditorias TO authenticated;
GRANT SELECT ON public.plan_anual_auditorias TO anon;

-- ── Índice para consultas por año ────────────────────────────────
CREATE INDEX IF NOT EXISTS idx_paa_year ON public.plan_anual_auditorias(year);

-- ═══════════════════════════════════════════════════════════════
-- SEED: Plan 2025 (según FT-CA-39 / plan anual de auditorías 2025)
-- Auditora Líder: Dra. Giselle De la Torre
-- Nota: meses anteriores a junio 2025 se marcan como realizadas
--       según el registro P+R del Excel original
-- ═══════════════════════════════════════════════════════════════

INSERT INTO public.plan_anual_auditorias
  (year, month, area, alcance, auditor_lider, responsable, status)
SELECT * FROM (VALUES
  -- Quirófano: 3 visitas (P+R en mayo, Seguimiento agosto, realizada noviembre)
  (2025, 5,  'Quirófano',
   'Procesos quirúrgicos, esterilización e infraestructura',
   'Dra. Giselle De la Torre', 'Jefe de Quirófano', 'realizada'),
  (2025, 8,  'Quirófano',
   'Seguimiento de hallazgos mayo 2025',
   'Dra. Giselle De la Torre', 'Jefe de Quirófano', 'seguimiento'),
  (2025, 11, 'Quirófano',
   'Procesos quirúrgicos, esterilización e infraestructura',
   'Dra. Giselle De la Torre', 'Jefe de Quirófano', 'realizada'),
  -- Cocina
  (2025, 7,  'Cocina / Nutrición',
   'Procesos de cocina, inocuidad alimentaria y nutrición clínica',
   'Dra. Giselle De la Torre', 'Encargada de Cocina', 'realizada'),
  -- Farmacia Hospitalaria: 2 visitas
  (2025, 9,  'Farmacia Hospitalaria',
   'Preparación, dispensación y control de caducidades',
   'Dra. Giselle De la Torre', 'Jefa de Farmacia', 'realizada'),
  (2025, 12, 'Farmacia Hospitalaria',
   'Preparación, dispensación y control de caducidades',
   'Dra. Giselle De la Torre', 'Jefa de Farmacia', 'realizada'),
  -- Urgencias
  (2025, 10, 'Urgencias',
   'Triage, tiempos de atención y protocolos de urgencia',
   'Dra. Giselle De la Torre', 'Jefe de Urgencias', 'realizada'),
  -- Admisión
  (2025, 11, 'Admisión',
   'Procesos administrativos, admisión y alta de pacientes',
   'Dra. Giselle De la Torre', 'Jefa de Admisión', 'realizada'),
  -- Imagenología / Laboratorio
  (2025, 12, 'Imagenología / Laboratorio',
   'Calidad en procesos diagnósticos, trazabilidad y registros',
   'Dra. Giselle De la Torre', 'Jefe de Imagenología', 'realizada')
) AS v(year, month, area, alcance, auditor_lider, responsable, status)
WHERE NOT EXISTS (
  SELECT 1 FROM public.plan_anual_auditorias
  WHERE year = v.year AND month = v.month AND area = v.area
);

-- ═══════════════════════════════════════════════════════════════
-- SEED: Plan 2026 (propuesto — cobertura completa ISO 9001:2015)
-- Distribución: 12 auditorías durante el año
-- Nuevas áreas incorporadas: Enfermería, RRHH, Eventos Adversos,
-- Gestión de Riesgos, Satisfacción del Paciente
-- ═══════════════════════════════════════════════════════════════

INSERT INTO public.plan_anual_auditorias
  (year, month, area, alcance, auditor_lider, responsable, status)
SELECT * FROM (VALUES
  -- Q1 — Enero: Arranque del año
  (2026, 1,  'Admisión',
   'Procesos administrativos, expediente clínico y alta de pacientes §7.5',
   'Dra. Giselle De la Torre', 'Jefa de Admisión', 'programada'),

  -- Q1 — Febrero: Urgencias (seguimiento hallazgos Oct-2025)
  (2026, 2,  'Urgencias',
   'Seguimiento hallazgos 2025 · Triage, tiempos y protocolos de urgencia',
   'Dra. Giselle De la Torre', 'Jefe de Urgencias', 'programada'),

  -- Q1 — Marzo: Área nueva — Enfermería
  (2026, 3,  'Enfermería / Hospitalización',
   'Cuidados de enfermería, registros clínicos, procedimientos y seguridad del paciente §8.5',
   'Dra. Giselle De la Torre', 'Jefa de Enfermería', 'programada'),

  -- Q2 — Abril: Quirófano (semestral)
  (2026, 4,  'Quirófano',
   'Procesos quirúrgicos, esterilización, seguridad e infraestructura §8.5',
   'Dra. Giselle De la Torre', 'Jefe de Quirófano', 'programada'),

  -- Q2 — Mayo: Área nueva — Recursos Humanos §7.2
  (2026, 5,  'Recursos Humanos',
   'Competencia del personal, capacitación, credenciales y formación continua §7.2',
   'Dra. Giselle De la Torre', 'Responsable de Recursos Humanos', 'programada'),

  -- Q2 — Junio: Cocina
  (2026, 6,  'Cocina / Nutrición',
   'Inocuidad alimentaria, preparación de dietas clínicas y control de temperatura §8.5',
   'Dra. Giselle De la Torre', 'Encargada de Cocina', 'programada'),

  -- Q3 — Julio: Farmacia
  (2026, 7,  'Farmacia Hospitalaria',
   'Dispensación, preparación, control de caducidades y cadena de frío §8.4',
   'Dra. Giselle De la Torre', 'Jefa de Farmacia', 'programada'),

  -- Q3 — Agosto: Imagenología / Laboratorio
  (2026, 8,  'Imagenología / Laboratorio',
   'Trazabilidad de resultados, calibración de equipos y registros §7.1.5',
   'Dra. Giselle De la Torre', 'Jefe de Imagenología', 'programada'),

  -- Q3 — Septiembre: Área nueva — Gestión de Riesgos
  (2026, 9,  'Gestión de Riesgos y Eventos Adversos',
   'Identificación y tratamiento de riesgos, análisis de eventos adversos §6.1 §10.2',
   'Dra. Giselle De la Torre', 'Responsable de Calidad', 'programada'),

  -- Q4 — Octubre: Quirófano (seguimiento semestral)
  (2026, 10, 'Quirófano',
   'Seguimiento hallazgos abril 2026 y verificación de protocolos §8.7',
   'Dra. Giselle De la Torre', 'Jefe de Quirófano', 'programada'),

  -- Q4 — Noviembre: Área nueva — Satisfacción del Paciente §9.1.2
  (2026, 11, 'Satisfacción del Paciente',
   'Encuestas de satisfacción, gestión de quejas y retroalimentación §9.1.2 §8.2.1',
   'Dra. Giselle De la Torre', 'Responsable de Calidad', 'programada'),

  -- Q4 — Diciembre: Cierre de año — todos los procesos criticos
  (2026, 12, 'Revisión General SGC',
   'Revisión integral del sistema: indicadores, objetivos de calidad y mejora continua §9.3 §10.3',
   'Dra. Giselle De la Torre', 'Responsable de Calidad', 'programada')
) AS v(year, month, area, alcance, auditor_lider, responsable, status)
WHERE NOT EXISTS (
  SELECT 1 FROM public.plan_anual_auditorias
  WHERE year = v.year AND month = v.month AND area = v.area
);
