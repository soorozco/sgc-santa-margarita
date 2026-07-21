-- ══════════════════════════════════════════════════════════════════
-- Migración: Farmacia — Perfil Farmacoterapéutico (PFT)
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Crea el catálogo maestro de medicamentos (con ATC y alto riesgo) y
-- la tabla del perfil farmacoterapéutico por paciente (datos clínicos,
-- medicación por categorías y registro de administración por horario).
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.pharmacy_med_catalog (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre       TEXT NOT NULL UNIQUE,
  atc          TEXT,
  alto_riesgo  BOOLEAN DEFAULT FALSE,
  activo       BOOLEAN DEFAULT TRUE,
  created_at   TIMESTAMPTZ DEFAULT now()
);

INSERT INTO public.pharmacy_med_catalog (nombre, atc, alto_riesgo) VALUES
  ('PARACETAMOL (SALPIFAR) 1GR INY','N',false),
  ('PARACETAMOL (SALPIFAR) 500MG INY','N',false),
  ('OMEPRAZOL (PISA) 40MG INY','A',false),
  ('OMEPRAZOL (INHIBITRON INFUSION) INY','A',false),
  ('OMEPRAZOL (INHIBITRON) INY','A',false),
  ('DEXKETOPROFENO (KERAL) 50MG INY','M',false),
  ('DEXKETOPROFENO (STADIUM) 50MG INY','M',false),
  ('PARACETAMOL (PERFALGAN) 1GR INY','N',false),
  ('PARACETAMOL (PERFALGAN) 500MG INY','N',false),
  ('METAMIZOL (ALNEX) 1GR INY','N',false),
  ('DEXAMETASONA (DECOREX) 8MG INY','H',false),
  ('DEXAMETASONA (ALIN DEPOT) 4MG INY','H',false),
  ('ENOXAPARINA (BOLENTAX) 20MG INY (ALTO RIESGO)','B',true),
  ('ENOXAPARINA (BOLENTAX) 60MG INY (ALTO RIESGO)','B',true),
  ('ENOXAPARINA (BOLENTAX) 80MG INY (ALTO RIESGO)','B',true),
  ('ENOXAPARINA (BOLENTAX) 40MG INY (ALTO RIESGO)','B',true),
  ('CEFTRIAXONA (PISA) 1GR INY','J',false),
  ('CEFALOTINA (FALOT) 1GR INY','J',false),
  ('ONDANSETRON (ANTIVON) 4MG INY','A',false),
  ('ONDANSETRON (ANTIVON) 8MG INY','A',false),
  ('ONDANSETRON (HT-BLOC) 8MG INY','A',false),
  ('DIAZEPAM (RELAZEPAM) 10MG/2ML INY','N',false),
  ('BUPRENORFINA (BROSPINA) 0.3MG/ML INY','N',false),
  ('MIDAZOLAM (RELACUM) 5MG/5ML INY','N',false),
  ('MIDAZOLAM (RELACUM) 15MG/3ML INY','N',false),
  ('FENTANILO (FENODID) 0.25MG INY','N',false),
  ('FENTANILO (FENODID) 0.5MG INY','N',false),
  ('CLONAZEPAM (KRIADEX) 2MG TAB','N',false),
  ('TRAMADOL (TRADOL) 50MG INY','N',false),
  ('TRAMADOL (TRADOL) 100MG INY','N',false),
  ('TRAMADOL (PISAZOL) 50MG INY','N',false),
  ('TRAMADOL (PISAZOL) 100MG INY','N',false),
  ('CLORURO DE POTASIO (KELEFUSIN) 40MEQ INY (ALTO RIESGO)','A',true),
  ('SULFATO DE MAGNESIO (MAGNEFUSIN) 1GR INY (ALTO RIESGO)','A',true),
  ('CLORURO DE SODIO (PISA) 10ML INY (ALTO RIESGO)','B',true),
  ('BICARBONATO DE SODIO (BICAR-NAT) 10ML (ALTO RIESGO)','B',true),
  ('BICARBONATO DE SODIO (BICAR-NAT) 50ML (ALTO RIESGO)','B',true),
  ('KETOROLACO (ONEMER) 30MG INY','M',false),
  ('KETOROLACO (SUPRADOL) 60MG INY','M',false),
  ('PARECOXIB (PIXIVA) 40MG INY','M',false),
  ('PARECOXIB (DYNASTAT) 40MG INY','M',false)
ON CONFLICT (nombre) DO NOTHING;

CREATE TABLE IF NOT EXISTS public.pharmacy_pft (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  folio_exp         TEXT,
  paciente          TEXT NOT NULL,
  fecha_nacimiento  DATE,
  fecha_ingreso     DATE,
  fecha_egreso      DATE,
  medico_tratante   TEXT,
  especialidad      TEXT,
  peso              NUMERIC,
  talla             NUMERIC,
  alergias          TEXT,
  diagnostico       TEXT,
  comorbilidades    TEXT,
  historia_clinica  TEXT,
  medicamentos      JSONB DEFAULT '[]'::jsonb,
  administraciones  JSONB DEFAULT '{}'::jsonb,
  activo            BOOLEAN DEFAULT TRUE,
  created_by        UUID,
  created_by_name   TEXT,
  created_at        TIMESTAMPTZ DEFAULT now(),
  updated_at        TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_pft_activo ON public.pharmacy_pft (activo, fecha_ingreso);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.pharmacy_med_catalog TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pharmacy_pft          TO authenticated;
GRANT ALL ON public.pharmacy_med_catalog TO service_role;
GRANT ALL ON public.pharmacy_pft          TO service_role;

ALTER TABLE public.pharmacy_med_catalog ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pharmacy_pft          ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "authenticated acceso completo" ON public.pharmacy_med_catalog;
CREATE POLICY "authenticated acceso completo" ON public.pharmacy_med_catalog
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "authenticated acceso completo" ON public.pharmacy_pft;
CREATE POLICY "authenticated acceso completo" ON public.pharmacy_pft
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

SELECT 'catalogo' AS tabla, count(*) AS registros FROM public.pharmacy_med_catalog
UNION ALL
SELECT 'pft', count(*) FROM public.pharmacy_pft;
