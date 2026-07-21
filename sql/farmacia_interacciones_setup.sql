-- ══════════════════════════════════════════════════════════════════
-- Migración: Farmacia — Base de Interacciones Medicamentosas (PFT)
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- 1) Agrega el principio activo a cada medicamento del catálogo (para
--    el cruce por sustancia, no por marca).
-- 2) Crea pharmacy_interactions: pares de principios activos con su
--    severidad, efecto, mecanismo, recomendación y FUENTE (cita+URL).
-- 3) Siembra las interacciones relevantes entre los medicamentos del
--    vademécum del hospital.
--
-- ⚠ Conjunto curado de PARTIDA para revisión y validación por el
--   farmacéutico. NO sustituye el juicio clínico ni es exhaustivo.
--   Fuentes: DDInter 2.0 (https://ddinter2.scbdd.com) e información de
--   prescripción / advertencias de la FDA.
--
-- Ejecutar en: Supabase → SQL Editor  (después de farmacia_pft_setup.sql)
-- ══════════════════════════════════════════════════════════════════

ALTER TABLE public.pharmacy_med_catalog ADD COLUMN IF NOT EXISTS ingrediente TEXT;

UPDATE public.pharmacy_med_catalog SET ingrediente = 'paracetamol' WHERE nombre LIKE 'PARACETAMOL%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'omeprazol' WHERE nombre LIKE 'OMEPRAZOL%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'dexketoprofeno' WHERE nombre LIKE 'DEXKETOPROFENO%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'metamizol' WHERE nombre LIKE 'METAMIZOL%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'dexametasona' WHERE nombre LIKE 'DEXAMETASONA%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'enoxaparina' WHERE nombre LIKE 'ENOXAPARINA%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'ceftriaxona' WHERE nombre LIKE 'CEFTRIAXONA%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'cefalotina' WHERE nombre LIKE 'CEFALOTINA%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'ondansetron' WHERE nombre LIKE 'ONDANSETRON%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'diazepam' WHERE nombre LIKE 'DIAZEPAM%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'buprenorfina' WHERE nombre LIKE 'BUPRENORFINA%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'midazolam' WHERE nombre LIKE 'MIDAZOLAM%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'fentanilo' WHERE nombre LIKE 'FENTANILO%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'clonazepam' WHERE nombre LIKE 'CLONAZEPAM%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'tramadol' WHERE nombre LIKE 'TRAMADOL%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'cloruro de potasio' WHERE nombre LIKE 'CLORURO DE POTASIO%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'sulfato de magnesio' WHERE nombre LIKE 'SULFATO DE MAGNESIO%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'cloruro de sodio' WHERE nombre LIKE 'CLORURO DE SODIO%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'bicarbonato de sodio' WHERE nombre LIKE 'BICARBONATO DE SODIO%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'ketorolaco' WHERE nombre LIKE 'KETOROLACO%';
UPDATE public.pharmacy_med_catalog SET ingrediente = 'parecoxib' WHERE nombre LIKE 'PARECOXIB%';

CREATE TABLE IF NOT EXISTS public.pharmacy_interactions (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ingrediente_a  TEXT NOT NULL,
  ingrediente_b  TEXT NOT NULL,
  severidad      TEXT NOT NULL,   -- contraindicada | mayor | moderada | menor
  efecto         TEXT,
  mecanismo      TEXT,
  recomendacion  TEXT,
  fuente         TEXT,
  fuente_url     TEXT,
  activo         BOOLEAN DEFAULT TRUE,
  created_by     UUID,
  created_at     TIMESTAMPTZ DEFAULT now(),
  updated_at     TIMESTAMPTZ DEFAULT now()
);

INSERT INTO public.pharmacy_interactions
  (ingrediente_a, ingrediente_b, severidad, efecto, mecanismo, recomendacion, fuente, fuente_url)
SELECT v.* FROM (VALUES
  ('dexketoprofeno','ketorolaco','contraindicada','Toxicidad gastrointestinal y renal aditiva sin beneficio analgésico adicional. El ketorolaco está contraindicado con otros AINE.','Inhibición aditiva de prostaglandinas (duplicidad de AINE).','No combinar; el ketorolaco no debe usarse junto con otros AINE.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('ketorolaco','metamizol','contraindicada','Toxicidad gastrointestinal y renal aditiva sin beneficio analgésico adicional. El ketorolaco está contraindicado con otros AINE.','Inhibición aditiva de prostaglandinas (duplicidad de AINE).','No combinar; el ketorolaco no debe usarse junto con otros AINE.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('ketorolaco','parecoxib','contraindicada','Toxicidad gastrointestinal y renal aditiva sin beneficio analgésico adicional. El ketorolaco está contraindicado con otros AINE.','Inhibición aditiva de prostaglandinas (duplicidad de AINE).','No combinar; el ketorolaco no debe usarse junto con otros AINE.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('buprenorfina','clonazepam','mayor','Depresión respiratoria y sedación profunda, potencialmente mortal.','Depresión aditiva del SNC (agonismo opioide + potenciación GABAérgica de la benzodiacepina).','Evitar la combinación. Si es indispensable, usar la mínima dosis y duración, vigilar sedación y frecuencia respiratoria y tener naloxona disponible.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('buprenorfina','diazepam','mayor','Depresión respiratoria y sedación profunda, potencialmente mortal.','Depresión aditiva del SNC (agonismo opioide + potenciación GABAérgica de la benzodiacepina).','Evitar la combinación. Si es indispensable, usar la mínima dosis y duración, vigilar sedación y frecuencia respiratoria y tener naloxona disponible.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('buprenorfina','fentanilo','mayor','La buprenorfina puede reducir la analgesia del fentanilo y precipitar síndrome de abstinencia; depresión respiratoria aditiva.','Competencia en el receptor opioide µ (agonista parcial frente a agonista completo).','Evitar el uso concomitante; si se rota de opioide, hacerlo de forma controlada y vigilar dolor y sedación.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('buprenorfina','midazolam','mayor','Depresión respiratoria y sedación profunda, potencialmente mortal.','Depresión aditiva del SNC (agonismo opioide + potenciación GABAérgica de la benzodiacepina).','Evitar la combinación. Si es indispensable, usar la mínima dosis y duración, vigilar sedación y frecuencia respiratoria y tener naloxona disponible.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('buprenorfina','tramadol','mayor','La buprenorfina puede reducir la analgesia del tramadol y precipitar abstinencia; depresión del SNC aditiva.','Competencia en el receptor µ (agonista parcial vs agonista).','Evitar la combinación; elegir un solo opioide.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('clonazepam','fentanilo','mayor','Depresión respiratoria y sedación profunda, potencialmente mortal.','Depresión aditiva del SNC (agonismo opioide + potenciación GABAérgica de la benzodiacepina).','Evitar la combinación. Si es indispensable, usar la mínima dosis y duración, vigilar sedación y frecuencia respiratoria y tener naloxona disponible.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('clonazepam','tramadol','mayor','Depresión respiratoria y sedación profunda, potencialmente mortal.','Depresión aditiva del SNC (agonismo opioide + potenciación GABAérgica de la benzodiacepina).','Evitar la combinación. Si es indispensable, usar la mínima dosis y duración, vigilar sedación y frecuencia respiratoria y tener naloxona disponible.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('dexametasona','dexketoprofeno','mayor','Mayor riesgo de úlcera y hemorragia digestiva.','Efecto gastrolesivo aditivo de corticoide + AINE.','Evitar o indicar gastroprotección y vigilar datos de sangrado digestivo.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('dexametasona','ketorolaco','mayor','Mayor riesgo de úlcera y hemorragia digestiva.','Efecto gastrolesivo aditivo de corticoide + AINE.','Evitar o indicar gastroprotección y vigilar datos de sangrado digestivo.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('dexametasona','metamizol','mayor','Mayor riesgo de úlcera y hemorragia digestiva.','Efecto gastrolesivo aditivo de corticoide + AINE.','Evitar o indicar gastroprotección y vigilar datos de sangrado digestivo.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('dexametasona','parecoxib','mayor','Mayor riesgo de úlcera y hemorragia digestiva.','Efecto gastrolesivo aditivo de corticoide + AINE.','Evitar o indicar gastroprotección y vigilar datos de sangrado digestivo.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('dexketoprofeno','enoxaparina','mayor','Aumento del riesgo de hemorragia (digestiva y de otros sitios).','Efecto gastrolesivo/antiagregante del AINE sumado a la anticoagulación.','Evitar; si se requiere, indicar gastroprotección y vigilar datos de sangrado y biometría hemática.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('dexketoprofeno','metamizol','mayor','Toxicidad gastrointestinal y renal aditiva; sin beneficio analgésico adicional (duplicidad de AINE).','Inhibición aditiva de prostaglandinas.','No combinar dos AINE; elegir uno.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('dexketoprofeno','parecoxib','mayor','Toxicidad gastrointestinal y renal aditiva; sin beneficio analgésico adicional (duplicidad de AINE).','Inhibición aditiva de prostaglandinas.','No combinar dos AINE; elegir uno.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('diazepam','fentanilo','mayor','Depresión respiratoria y sedación profunda, potencialmente mortal.','Depresión aditiva del SNC (agonismo opioide + potenciación GABAérgica de la benzodiacepina).','Evitar la combinación. Si es indispensable, usar la mínima dosis y duración, vigilar sedación y frecuencia respiratoria y tener naloxona disponible.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('diazepam','tramadol','mayor','Depresión respiratoria y sedación profunda, potencialmente mortal.','Depresión aditiva del SNC (agonismo opioide + potenciación GABAérgica de la benzodiacepina).','Evitar la combinación. Si es indispensable, usar la mínima dosis y duración, vigilar sedación y frecuencia respiratoria y tener naloxona disponible.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('enoxaparina','ketorolaco','mayor','Aumento del riesgo de hemorragia (digestiva y de otros sitios).','Efecto gastrolesivo/antiagregante del AINE sumado a la anticoagulación.','Evitar; si se requiere, indicar gastroprotección y vigilar datos de sangrado y biometría hemática.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('enoxaparina','metamizol','mayor','Aumento del riesgo de hemorragia (digestiva y de otros sitios).','Efecto gastrolesivo/antiagregante del AINE sumado a la anticoagulación.','Evitar; si se requiere, indicar gastroprotección y vigilar datos de sangrado y biometría hemática.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('enoxaparina','parecoxib','mayor','Aumento del riesgo de hemorragia (digestiva y de otros sitios).','Efecto gastrolesivo/antiagregante del AINE sumado a la anticoagulación.','Evitar; si se requiere, indicar gastroprotección y vigilar datos de sangrado y biometría hemática.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('fentanilo','midazolam','mayor','Depresión respiratoria y sedación profunda, potencialmente mortal.','Depresión aditiva del SNC (agonismo opioide + potenciación GABAérgica de la benzodiacepina).','Evitar la combinación. Si es indispensable, usar la mínima dosis y duración, vigilar sedación y frecuencia respiratoria y tener naloxona disponible.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('metamizol','parecoxib','mayor','Toxicidad gastrointestinal y renal aditiva; sin beneficio analgésico adicional (duplicidad de AINE).','Inhibición aditiva de prostaglandinas.','No combinar dos AINE; elegir uno.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('midazolam','tramadol','mayor','Depresión respiratoria y sedación profunda, potencialmente mortal.','Depresión aditiva del SNC (agonismo opioide + potenciación GABAérgica de la benzodiacepina).','Evitar la combinación. Si es indispensable, usar la mínima dosis y duración, vigilar sedación y frecuencia respiratoria y tener naloxona disponible.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('clonazepam','diazepam','moderada','Sedación aditiva y depresión del SNC (duplicidad de benzodiacepinas).','Potenciación GABAérgica aditiva.','Evitar duplicar benzodiacepinas; ajustar dosis y vigilar sedación.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('clonazepam','midazolam','moderada','Sedación aditiva y depresión del SNC (duplicidad de benzodiacepinas).','Potenciación GABAérgica aditiva.','Evitar duplicar benzodiacepinas; ajustar dosis y vigilar sedación.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('dexametasona','enoxaparina','moderada','Posible aumento del riesgo de sangrado.','Efecto sobre la mucosa/coagulación sumado a la anticoagulación.','Vigilar datos de sangrado.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('diazepam','midazolam','moderada','Sedación aditiva y depresión del SNC (duplicidad de benzodiacepinas).','Potenciación GABAérgica aditiva.','Evitar duplicar benzodiacepinas; ajustar dosis y vigilar sedación.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('diazepam','omeprazol','moderada','Aumento de las concentraciones y de la sedación por diazepam.','Inhibición de CYP2C19 por omeprazol, que reduce el metabolismo del diazepam.','Vigilar sedación excesiva; considerar ajuste de dosis de diazepam.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com'),
  ('fentanilo','tramadol','moderada','Depresión aditiva del SNC; el tramadol añade riesgo de convulsiones y de síndrome serotoninérgico.','Efecto opioide aditivo + acción serotoninérgica/proconvulsiva del tramadol.','Evitar duplicar opioides; vigilar sedación y datos de toxicidad serotoninérgica.','DDInter 2.0 (base curada de interacciones)','https://ddinter2.scbdd.com'),
  ('ondansetron','tramadol','moderada','El ondansetrón puede reducir el efecto analgésico del tramadol; riesgo aditivo de prolongación del QT y de síndrome serotoninérgico.','Antagonismo 5-HT3 (reduce analgesia) y efectos serotoninérgicos/sobre el QT.','Vigilar control del dolor; considerar antiemético alterno y vigilar QT en pacientes de riesgo.','FDA (información de prescripción / advertencia de recuadro) · DDInter 2.0','https://ddinter2.scbdd.com')
) AS v(ingrediente_a, ingrediente_b, severidad, efecto, mecanismo, recomendacion, fuente, fuente_url)
WHERE NOT EXISTS (
  SELECT 1 FROM public.pharmacy_interactions i
  WHERE i.ingrediente_a = v.ingrediente_a AND i.ingrediente_b = v.ingrediente_b
);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.pharmacy_interactions TO authenticated;
GRANT ALL ON public.pharmacy_interactions TO service_role;
ALTER TABLE public.pharmacy_interactions ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "authenticated acceso completo" ON public.pharmacy_interactions;
CREATE POLICY "authenticated acceso completo" ON public.pharmacy_interactions
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- ── Verificación ──────────────────────────────────────────────────
SELECT severidad, count(*) FROM public.pharmacy_interactions GROUP BY severidad ORDER BY 1;
