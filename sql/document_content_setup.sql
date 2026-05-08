-- ============================================================
--  CONTENIDO DE DOCUMENTOS — Vista digital de lectura
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar en Supabase → SQL Editor
-- ============================================================

-- ── 1. Tabla ──────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS document_content (
  id                uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  document_id       uuid        NOT NULL UNIQUE REFERENCES documents(id) ON DELETE CASCADE,
  objetivo          text,
  alcance           text,
  definiciones      jsonb       NOT NULL DEFAULT '[]',
  responsabilidades jsonb       NOT NULL DEFAULT '[]',
  material_equipo   jsonb       NOT NULL DEFAULT '[]',
  desarrollo        jsonb       NOT NULL DEFAULT '[]',
  gestion_riesgos   jsonb       NOT NULL DEFAULT '[]',
  referencias       jsonb       NOT NULL DEFAULT '[]',
  control_cambios   jsonb       NOT NULL DEFAULT '[]',
  elaborado_por     text,
  cargo_elaboro     text,
  revisado_por      text,
  cargo_reviso      text,
  autorizado_por    text,
  cargo_autorizo    text,
  created_at        timestamptz NOT NULL DEFAULT now(),
  updated_at        timestamptz NOT NULL DEFAULT now()
);

-- Trigger updated_at
DROP TRIGGER IF EXISTS trg_doc_content_ts ON document_content;
CREATE TRIGGER trg_doc_content_ts
  BEFORE UPDATE ON document_content
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- RLS
ALTER TABLE document_content ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "dc_read"  ON document_content;
DROP POLICY IF EXISTS "dc_write" ON document_content;
CREATE POLICY "dc_read"  ON document_content FOR SELECT TO authenticated USING (true);
CREATE POLICY "dc_write" ON document_content FOR ALL    TO authenticated USING (true);

-- ── 2. Actualizar versiones reales en documentos ──────────────────
UPDATE documents SET
  current_version  = '3.0',
  elaboration_date = '2025-09-24',
  elaborated_by    = 'Mayra Olivares Cervantes',
  reviewed_by      = 'Dra. Giselle Ivette De la Torre García',
  custodian_position = 'Coordinador Archivo Clínico'
WHERE code = 'PR-AR-01';

UPDATE documents SET
  current_version  = '4.0',
  elaboration_date = '2025-09-20',
  elaborated_by    = 'Mayra Olivares Cervantes',
  reviewed_by      = 'Dra. Giselle Ivette De la Torre García',
  custodian_position = 'Coordinador Archivo Clínico'
WHERE code = 'IT-AR-02';

-- ── 3. PR-AR-01 — Contenido extraído del PDF ──────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Proporcionar a los departamentos autorizados para solicitar préstamo, el soporte documental que se incluye en el expediente cerrado, para consulta en forma segura y responsable.',

'Este procedimiento inicia cuando se realiza la solicitud del expediente o los expedientes cerrados al archivo clínico concluyendo cuando se regresa el expediente clínico archivando en el lugar que corresponde.

Las áreas autorizadas a solicitar para consulta, el préstamo interno de expedientes clínicos son las siguientes:
• Dirección Médica
• Dirección Administrativa
• Coordinación Médica
• Dpto. de Calidad
• Coordinación de Expediente Clínico
• Epidemiología
• Servicios Farmacéuticos
• Administración y Convenio Vigente
• Jurídico

Área Jurídica: Ésta es la única que puede extraer al exterior del hospital un expediente clínico, única y exclusivamente cuando sea solicitado por escrito por una instancia judicial o juez, en caso de tener un seguimiento médico legal o administrativo.',

'[{"termino":"Expediente Clínico","definicion":"Es la información y datos personales de un paciente, que incluye documentos escritos, imagenológicos y electrónicos, donde se registran todos los datos relevantes de la atención médica recibida, desde su ingreso hasta su egreso."}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Coordinador del departamento de Archivo clínico."},{"tipo":"4.2 Ejecución","descripcion":"Coordinador del departamento de Archivo clínico, personal de archivo."},{"tipo":"4.3 Supervisión","descripcion":"Dirección Médica, Coordinador del departamento de Archivo clínico, Departamento de Calidad."}]'::jsonb,

'[{"no":"5.1","responsable":"Áreas autorizadas","actividad":"Realiza la solicitud del expediente o los expedientes cerrados al archivo clínico."},{"no":"5.2","responsable":"Personal de archivo","actividad":"Entrega expedientes solicitados."},{"no":"5.3","responsable":"El solicitante","actividad":"Firma la recepción de los expedientes junto con la aceptación de la responsabilidad legal del documento."},{"no":"5.4","responsable":"El solicitante","actividad":"Una vez que desocupa el o los expedientes, los devuelve al archivo clínico para su resguardo."},{"no":"5.5","responsable":"Personal de archivo","actividad":"Archiva el expediente clínico en el lugar que corresponda."}]'::jsonb,

'[{"riesgo":"Servicio se quede de forma indefinida el expediente.","barrera":"Personal de archivo realizará una solicitud de devolución de forma quincenal."},{"riesgo":"Que se extravíe el expediente.","barrera":"Personal de archivo establece políticas claras sobre el manejo del expediente así como la responsabilidad de su resguardo."}]'::jsonb,

'[{"nombre":"No Aplica","codigo":"No Aplica"}]'::jsonb,

'[{"version":"1","fecha":"03/06/2021","descripcion":"Alta de documento","realizado":"Areli Janeth Ruiz Sánchez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"2","fecha":"11/03/2022","descripcion":"Actualización del documento","realizado":"Areli Janeth Ruiz Sánchez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"24/09/2025","descripcion":"Actualización del documento","realizado":"Mayra Olivares Cervantes","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Mayra Olivares Cervantes', 'Coordinador Archivo Clínico',
'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
'Hna. María de Jesús García Castro', 'Directora General'

FROM documents d WHERE d.code = 'PR-AR-01'
ON CONFLICT (document_id) DO NOTHING;

-- ── 4. IT-AR-02 — Contenido extraído del PDF ──────────────────────
INSERT INTO document_content (
  document_id, alcance,
  material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por, cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Este documento aplica cuando se realiza la destrucción de los expedientes clínicos cerrados del área de archivo clínico a los expedientes que cumplen más de 5 años siguiendo las políticas generales de archivo y la NOM-004-SSA3-2012 bajo la autorización de la Directora General del Hospital Santa Margarita.',

'[{"item":"Trituradora de papel"},{"item":"Quita grapas"},{"item":"Bolsas para depositar el material triturado"}]'::jsonb,

'[{"no":"5.1","responsable":"Asistente de archivo","actividad":"Separa los expedientes que cumplen más de 5 años desde la última atención médica indicados por el personal auxiliar administrativo de archivo clínico."},{"no":"5.2","responsable":"Asistente de archivo","actividad":"Retira cualquier objeto de metal (grapas, clips, etc.) de los expedientes clínicos."},{"no":"5.3","responsable":"Asistente de archivo","actividad":"Verifica y/o coloca una bolsa de plástico adecuada para el almacenaje de papel en la trituradora de papel del área."},{"no":"5.4","responsable":"Asistente de archivo","actividad":"Se procede a la destrucción de los expedientes en periodos de 30 minutos por 30 minutos de descanso (para no sobrecalentar el motor de la trituradora)."},{"no":"5.5","responsable":"Asistente de archivo","actividad":"Se hace el recambio de la bolsa para almacenaje conforme sea necesario."}]'::jsonb,

'[{"riesgo":"Destrucción de expedientes clínicos incorrectos.","barrera":"Se verifican los datos para corroborar que el expediente ya tenga 5 años de su última atención."}]'::jsonb,

'[{"nombre":"No Aplica","codigo":"No Aplica"}]'::jsonb,

'[{"version":"1","fecha":"16/11/2019","descripcion":"Alta de documento","realizado":"Selene Araceli Silva Valdez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"2","fecha":"03/02/2022","descripcion":"Modificación de documento","realizado":"Areli Janeth Ruiz Sánchez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"3","fecha":"24/01/2024","descripcion":"Actualización","realizado":"Mayra Olivares Cervantes","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},{"version":"4","fecha":"20/09/2025","descripcion":"Actualización del formato","realizado":"Mayra Olivares Cervantes","aprobado":"Dra. Giselle Ivette De la Torre García"}]'::jsonb,

'Mayra Olivares Cervantes', 'Coordinador Archivo Clínico',
'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
'Hna. María de Jesús García Castro', 'Directora General'

FROM documents d WHERE d.code = 'IT-AR-02'
ON CONFLICT (document_id) DO NOTHING;

-- ── Verificación ─────────────────────────────────────────────────
SELECT d.code, d.current_version,
       CASE WHEN dc.id IS NOT NULL THEN 'Con contenido ✓' ELSE 'Sin contenido' END AS contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
ORDER BY d.code;
