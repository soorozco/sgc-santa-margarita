-- ============================================================
--  COMPRAS — Vista digital de PR-JC-05
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar DESPUÉS de compras_docs.sql
-- ============================================================

INSERT INTO document_content (
  document_id, objetivo, alcance,
  definiciones, responsabilidades, desarrollo,
  gestion_riesgos, referencias, control_cambios,
  elaborado_por, cargo_elaboro,
  revisado_por,  cargo_reviso,
  autorizado_por, cargo_autorizo
)
SELECT d.id,

'Establecer un procedimiento estandarizado para la solicitud, control, entrega y registro de tóner desde el almacén a los servicios o departamentos del hospital, garantizando el control de inventarios, la disponibilidad adecuada, la trazabilidad del suministro y la prevención de riesgos operativos.',

'Aplica a todas las áreas y servicios del hospital que requieran tóner para impresoras institucionales y al personal del almacén responsable de la gestión de suministros.',

'[{"termino":"Inventario","definicion":"Registro sistemático y actualizado de las existencias de bienes almacenados, incluyendo cantidad disponible, ubicación y estado."},{"termino":"Stock crítico","definicion":"Cantidad mínima de tóner establecida que debe mantenerse disponible en almacén para garantizar la continuidad operativa y evitar desabasto."}]'::jsonb,

'[{"tipo":"4.1 Actualización","descripcion":"Jefa o jefe de Almacén"},{"tipo":"4.2 Ejecución","descripcion":"Directora administrativa, jefa o jefe de tecnologías de información, personal de tecnologías de información, encargada o encargado de compras, personal de almacén y servicios solicitantes de tóner."},{"tipo":"4.3 Supervisión","descripcion":"Directora administrativa"}]'::jsonb,

'[{"no":"5.1","responsable":"Jefa o jefe de tecnologías de información","actividad":"Identifica los modelos de tóner que se requieren para el hospital según las impresoras institucionales disponibles registradas en el inventario de equipo y mobiliario del hospital."},{"no":"5.2","responsable":"Jefa o jefe de tecnologías de información","actividad":"Realiza el listado de los modelos de tóner que se requieren para el funcionamiento de las impresoras, considerando su uso, registrando la cantidad de toners según el consumo promedio."},{"no":"5.3","responsable":"Jefa o jefe de tecnologías de información","actividad":"Solicita la compra de los modelos de tóner para mantener el stock mínimo de los mismos (se considera stock crítico de 2 toners)."},{"no":"5.4","responsable":"Encargada o encargado de compras","actividad":"Realiza por lo menos 3 estudios de mercado para la compra de los toners."},{"no":"5.5","responsable":"Encargada o encargado de compras","actividad":"Analiza los estudios de mercado considerando la capacidad de distribución del proveedor, rango de precios por proveedor, formas de pago y financiamiento, garantías, pólizas de servicio y soporte técnico."},{"no":"5.6","responsable":"Encargada o encargado de compras","actividad":"Realiza la solicitud de compra para su visto bueno a la dirección administrativa anexándole los estudios de mercado para su validación."},{"no":"5.7","responsable":"Directora administrativa","actividad":"Otorga el visto bueno de los estudios de mercado y firma la solicitud de compra para que se lleve a cabo la misma."},{"no":"5.8","responsable":"Encargada o encargado de compras","actividad":"Realiza la compra de los toners solicitados según el proceso de compra."},{"no":"5.9","responsable":"Personal de almacén","actividad":"Recibe los tóner y los almacena según el proceso del almacén general."},{"no":"5.10","responsable":"Personal solicitante","actividad":"Detecta la falta de suministro de tóner para la impresión de documentos y notifica a tecnologías de información."},{"no":"5.11","responsable":"Personal de tecnologías de información","actividad":"Revisa el nivel de tóner de la impresora para asegurarse de la falta del suministro. ¿Cuenta con el 20% o más de tóner? SI: Acude a revisar el insumo y/o impresora para detectar alguna posible falla. NO: Valida la falta del suministro."},{"no":"5.12","responsable":"Personal de tecnologías de información","actividad":"Realiza la solicitud del insumo al almacén general a través del sistema, registrando modelo y tóner requerido, incluyendo el nombre del departamento o servicio para posterior solicitar el nombre y firma del responsable del área solicitante."},{"no":"5.13","responsable":"Personal de almacén","actividad":"Recibe solicitud de aprovisionamiento y verifica en el sistema de inventario la existencia del tóner solicitado."},{"no":"5.14","responsable":"Personal de almacén","actividad":"Consulta el sistema de control de inventarios para verificar las existencias disponibles del tóner solicitado. ¿Se encuentra en inventario? No: pasa al punto 5.15. Sí: continúa en el punto 5.16."},{"no":"5.15","responsable":"Personal de almacén","actividad":"Informa inmediatamente al solicitante y realiza la solicitud de reposición de existencias a compras."},{"no":"5.16","responsable":"Personal de tecnologías de información","actividad":"Acude al servicio solicitante a recoger el tóner vacío para su entrega al almacén general."},{"no":"5.17","responsable":"Personal de almacén","actividad":"Revisa las condiciones del tóner a entregar y entrega el tóner al personal de tecnologías de información."},{"no":"5.18","responsable":"Personal de tecnologías de información","actividad":"Entrega el tóner vacío y registra fecha y hora de recepción del tóner, cantidad entregada, código de lote (si aplica) en el formato de entrega."},{"no":"5.19","responsable":"Personal de almacén","actividad":"Recibe el tóner vacío corroborando que sea el mismo modelo del tóner de entrega."},{"no":"5.20","responsable":"Personal de almacén","actividad":"Archiva el formato de entrega y registra la baja en el sistema."},{"no":"5.21","responsable":"Personal de tecnologías de información","actividad":"Instala el tóner en la impresora correspondiente del servicio solicitante."},{"no":"5.22","responsable":"Personal de tecnologías de información","actividad":"Verifica el funcionamiento del mismo a través de la impresión de una hoja de prueba."},{"no":"5.23","responsable":"Personal solicitante","actividad":"Firma la orden de servicio de cambio de toner registrando fecha y hora del cambio."},{"no":"5.24","responsable":"Personal de tecnologías de información","actividad":"Registra en la bitácora de cambio de tóner el cambio de toner realizado al servicio solicitante."}]'::jsonb,

'[{"riesgo":"Pérdida de suministros.","barrera":"Registro de entradas y salidas en tiempo real."},{"riesgo":"Entrega de tóner incorrecto.","barrera":"Doble verificación en la entrega."},{"riesgo":"Ruptura de stock crítico.","barrera":"Definición de stock crítico y sistema de alertas para reposición oportuna."}]'::jsonb,

'[{"nombre":"Bitácora de cambio de tóner","codigo":"FT-TI-01"}]'::jsonb,

'[{"version":"01","fecha":"Agosto 2025","descripcion":"Documento de nueva creación","realizado":"Hna. María de Jesús Gómez Flores","aprobado":"Hna. María de Jesús García Castro"}]'::jsonb,

'Hna. María de Jesús Gómez Flores', 'Directora Administrativa',
'Dra. Giselle Ivette De la Torre García', 'Jefa de Calidad',
'Hna. María de Jesús García Castro', 'Directora General'

FROM documents d WHERE d.code = 'PR-JC-05'
ON CONFLICT (document_id) DO NOTHING;

-- ── Verificación ─────────────────────────────────────────────
SELECT d.code, d.current_version AS ver,
       CASE WHEN dc.id IS NOT NULL THEN 'Con contenido ✓' ELSE 'Sin contenido' END AS contenido
FROM documents d
LEFT JOIN document_content dc ON dc.document_id = d.id
WHERE d.code = 'PR-JC-05';
