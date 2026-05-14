-- ============================================================
--  Tecnologías de la Información — Contenido de 2 Instrucciones de Trabajo
--  IT-TI-02, IT-TI-03
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar DESPUÉS de ti_docs.sql
-- ============================================================

-- ── IT-TI-02 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Este documento aplica cuando se requiere realizar un consumible para impresión en todas las áreas de la institución, evitando generar papel.',
'Este documento aplica cuando se requiere realizar un consumible para impresión en todas las áreas de la institución, evitando generar papel.',
'[]'::jsonb,
'[]'::jsonb,
'[{"item": "Cartucho de tinta adecuado para el modelo de la impresora"}, {"item": "Tinta para rellenar los depósitos de la impresora"}, {"item": "Guantes de látex"}, {"item": "Jeringa"}]'::jsonb,
'[{"no": "3.1", "responsable": "Usuario de equipo de impresión", "actividad": "Solicitar el soporte vía telefónica, mensaje escrito, vale de dependencia a través del SISTEMA ENLACE (MEDISIST) o verbal directo y únicamente a personal de TI para la sustitución del cartucho o tinta de impresión."}, {"no": "3.2", "responsable": "Personal de TI", "actividad": "Verificar la disponibilidad de los consumibles de impresión en cuanto al stock y hacer la observación a la jefatura de TI para no caer en desabasto."}, {"no": "3.3", "responsable": "Personal de TI", "actividad": "Deberá llenar la bitácora FT-TI-06 para dar seguimiento y dejar el estatus de ejecución del consumible solicitado."}, {"no": "3.4", "responsable": "Personal de TI", "actividad": "Se entrega el consumible y genera un vale de dependencia afectando inventarios y posteriormente hacer la recuperación del stock y dejar evidencia de la solicitud generada."}, {"no": "3.5", "responsable": "Usuario de equipo de impresión", "actividad": "Verificar que se instaló el consumible y firmar la bitácora de consumibles."}, {"no": "3.6", "responsable": "Jefatura de TI", "actividad": "Dar seguimiento a la bitácora FT-TI-06 y validar que se haya solucionado y completado el servicio. Así mismo revisar el stock para realizar la recuperación a través del PR-TI-04."}]'::jsonb,
'[{"riesgo": "Descargas eléctricas.", "barrera": "Verificar que esté apagado el equipo y libre de cualquier fuente eléctrica."}, {"riesgo": "Mal funcionamiento.", "barrera": "Utilizar el consumible adecuado."}]'::jsonb,
'[{"nombre": "Bitácora electrónica de soporte de TI", "codigo": "FT-TI-06"}, {"nombre": "Bitácora electrónica de consumibles", "codigo": "FT-TI-09"}, {"nombre": "Proceso para solicitud de consumibles, accesorios", "codigo": "PR-TI-04"}]'::jsonb,
'[{"version": "01", "fecha": "05/07/2021", "descripcion": "Alta de documento", "realizado": "José Alberto Bustamante Jiménez", "aprobado": "Mtra. Ana Cecilia Zarate"}, {"version": "02", "fecha": "24/04/2023", "descripcion": "Modificación de documento", "realizado": "José Alberto Bustamante Jiménez", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "03", "fecha": "29/09/2025", "descripcion": "Modificación de documento", "realizado": "José Alberto Bustamante Jiménez", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb,
'José Alberto Bustamante Jiménez', 'Jefatura de TI',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'
FROM documents d WHERE d.code = 'IT-TI-02'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
  material_equipo     = EXCLUDED.material_equipo,
  desarrollo          = EXCLUDED.desarrollo,
  gestion_riesgos     = EXCLUDED.gestion_riesgos,
  referencias         = EXCLUDED.referencias,
  control_cambios     = EXCLUDED.control_cambios,
  elaborado_por       = EXCLUDED.elaborado_por,
  cargo_elaboro       = EXCLUDED.cargo_elaboro,
  revisado_por        = EXCLUDED.revisado_por,
  cargo_reviso        = EXCLUDED.cargo_reviso,
  autorizado_por      = EXCLUDED.autorizado_por,
  cargo_autorizo      = EXCLUDED.cargo_autorizo;

-- ── IT-TI-03 ─────────────────────────────────────────────────────
INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, material_equipo, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,
'Este documento aplica para registrar y llevar un control de respaldos de toda la información de la institución (bases de datos, archivos de trabajo, etc.), evitando generar papel.',
'Este documento aplica para registrar y llevar un control de respaldos de toda la información de la institución (bases de datos, archivos de trabajo, etc.), evitando generar papel.',
'[]'::jsonb,
'[]'::jsonb,
'[{"item": "Servidores de cómputo"}, {"item": "Unidad externa con SSD 1TB"}]'::jsonb,
'[{"no": "3.1", "responsable": "Jefatura de TI", "actividad": "Realizar los procedimientos de respaldos de los diferentes dispositivos de cómputo como servidores, PCs, Laptops, etc. A través de diferentes técnicas de respaldo para salvaguardar la información en diferentes dispositivos."}, {"no": "3.2", "responsable": "Jefatura de TI", "actividad": "Realiza el respaldo y describe en FT-TI-03 el tipo de respaldo realizado entre estos tres: Completo, incremental o 321. Este último como método de respaldo principal."}, {"no": "3.3", "responsable": "Personal de TI", "actividad": "Deberá llenar la bitácora FT-TI-03 para dar seguimiento y confirmar segunda revisión especificando en el apartado de observaciones e incidencias."}, {"no": "3.4", "responsable": "Jefatura de TI", "actividad": "Deberá estar al pendiente de que los respaldos se ejecuten en tiempo y forma y deberá implementar y capacitar a su personal para dar seguimiento puntual a esta instrucción."}]'::jsonb,
'[{"riesgo": "Descargas eléctricas.", "barrera": "Nobreak funcional al 100%."}, {"riesgo": "Mal funcionamiento.", "barrera": "Mantenimiento preventivo constante."}, {"riesgo": "Caída de RED.", "barrera": "Cableado estructurado correcto y Switch conectados a corriente alterna (nobreak)."}, {"riesgo": "Dispositivo externo desconectado.", "barrera": "Revisión diaria para confirmar que el dispositivo siempre esté funcional."}]'::jsonb,
'[{"nombre": "Bitácora electrónica de respaldos", "codigo": "FT-TI-03"}]'::jsonb,
'[{"version": "01", "fecha": "05/07/2021", "descripcion": "Alta de documento", "realizado": "José Alberto Bustamante Jiménez", "aprobado": "Mtra. Ana Cecilia Zarate"}, {"version": "02", "fecha": "24/04/2023", "descripcion": "Modificación de documento", "realizado": "José Alberto Bustamante Jiménez", "aprobado": "Mtra. Ana Cecilia Zárate"}, {"version": "03", "fecha": "29/09/2025", "descripcion": "Modificación de documento", "realizado": "José Alberto Bustamante Jiménez", "aprobado": "Dra. Giselle Ivette De la Torre García"}]'::jsonb,
'José Alberto Bustamante Jiménez', 'Jefatura de TI',
'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',
'Hna. María de Jesús García Castro', 'Dirección General'
FROM documents d WHERE d.code = 'IT-TI-03'
ON CONFLICT (document_id) DO UPDATE SET
  objetivo            = EXCLUDED.objetivo,
  alcance             = EXCLUDED.alcance,
  material_equipo     = EXCLUDED.material_equipo,
  desarrollo          = EXCLUDED.desarrollo,
  gestion_riesgos     = EXCLUDED.gestion_riesgos,
  referencias         = EXCLUDED.referencias,
  control_cambios     = EXCLUDED.control_cambios,
  elaborado_por       = EXCLUDED.elaborado_por,
  cargo_elaboro       = EXCLUDED.cargo_elaboro,
  revisado_por        = EXCLUDED.revisado_por,
  cargo_reviso        = EXCLUDED.cargo_reviso,
  autorizado_por      = EXCLUDED.autorizado_por,
  cargo_autorizo      = EXCLUDED.cargo_autorizo;

-- ── Verificación ─────────────────────────────────────────────
SELECT d.code, d.name,
       CASE WHEN dc.document_id IS NOT NULL THEN 'Contenido OK ✓' ELSE '⚠ Sin contenido' END AS contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code IN ('IT-TI-02','IT-TI-03')
ORDER BY d.code;
