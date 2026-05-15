#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Almacén — Registra documentos y carga contenido digital
Genera al_full.sql (docs + document_content)
"""
import json, pathlib

def esc(s):
    return str(s).replace("'", "''") if s else ''

def j(obj):
    return json.dumps(obj, ensure_ascii=False)

# ══════════════════════════════════════════════════════════════
# DOCUMENTOS (metadata para tabla documents)
# ══════════════════════════════════════════════════════════════
DOCS_META = [
    {
        "code":               "IT-AL-01",
        "name":               "Instrucción de Trabajo para Limpieza de Áreas, Mobiliario e Insumos",
        "type_prefix":        "IT",
        "dept_code":          "AL",
        "version":            "3",
        "status":             "vigente",
        "custodian":          "Jefe del Área",
        "elab_date":          "2022-03-02",
        "elaborated_by":      "LAE. Ismael Omar Rodríguez Vázquez",
        "reviewed_by":        "Dra. Giselle Ivette De la Torre García",
        "vigencia":           2,
    },
    {
        "code":               "PR-AL-01",
        "name":               "Procedimiento para la Adquisición y Recepción de Insumos en General",
        "type_prefix":        "PR",
        "dept_code":          "AL",
        "version":            "3",
        "status":             "vigente",
        "custodian":          "Coordinador de Almacén",
        "elab_date":          "2022-07-05",
        "elaborated_by":      "LAE. Ismael Omar Rodríguez Vázquez",
        "reviewed_by":        "Dra. Giselle Ivette De la Torre García",
        "vigencia":           2,
    },
    {
        "code":               "PR-AL-02",
        "name":               "Procedimiento para la Adquisición y Recepción de Insumos en Remisión y Consigna",
        "type_prefix":        "PR",
        "dept_code":          "AL",
        "version":            "4",
        "status":             "vigente",
        "custodian":          "Coordinador de Almacén",
        "elab_date":          "2022-07-05",
        "elaborated_by":      "LAE. Ismael Omar Rodríguez Vázquez",
        "reviewed_by":        "Dra. Giselle Ivette De la Torre García",
        "vigencia":           2,
    },
    {
        "code":               "PR-AL-03",
        "name":               "Procedimiento para el Manejo y Almacenamiento de Insumos en General",
        "type_prefix":        "PR",
        "dept_code":          "AL",
        "version":            "3",
        "status":             "vigente",
        "custodian":          "Jefatura de Almacén",
        "elab_date":          "2022-07-28",
        "elaborated_by":      "LAE. Ismael Omar Rodríguez Vázquez",
        "reviewed_by":        "Dra. Giselle Ivette De la Torre García",
        "vigencia":           2,
    },
    {
        "code":               "PR-AL-04",
        "name":               "Procedimiento para la Devolución a Proveedores",
        "type_prefix":        "PR",
        "dept_code":          "AL",
        "version":            "3",
        "status":             "vigente",
        "custodian":          "Coordinador de Almacén",
        "elab_date":          "2023-09-13",
        "elaborated_by":      "LAE. Ismael Omar Rodríguez Vázquez",
        "reviewed_by":        "Dra. Giselle Ivette De la Torre García",
        "vigencia":           2,
    },
]

# ══════════════════════════════════════════════════════════════
# CONTENIDO (document_content)
# ══════════════════════════════════════════════════════════════

IT_AL_01 = {
    "codigo": "IT-AL-01",
    "alcance": "El presente instructivo de trabajo abarca desde la selección del anaquel en el área de almacén hasta el registro en el formato de trabajo.",
    "material_equipo": [
        "3 franelas limpias y secas",
        "Guantes de protección para limpieza de áreas",
        "Solución detergente (agua con jabón)",
        "Sacudidor",
    ],
    "desarrollo": [
        {"num":"3.1","responsable":"Auxiliar de Almacén","actividad":"Seleccionar el anaquel a limpiar corroborando el correcto manejo del material, así como que se esté cumpliendo la correcta rotación del mismo, retirar los insumos que se encuentren en él, colocándolos en un lugar seguro."},
        {"num":"3.2","responsable":"Auxiliar de Almacén","actividad":"Preparar la solución detergente (agua y jabón) 2 litros."},
        {"num":"3.3","responsable":"Auxiliar de Almacén","actividad":"Humedecer una de las franelas limpias con la solución detergente y limpiar la suciedad adherida a la superficie del anaquel, de arriba hacia abajo, de atrás hacia delante."},
        {"num":"3.4","responsable":"Auxiliar de Almacén","actividad":"Cambiar la solución detergente tantas veces como sea necesario con el fin de no regresar la suciedad retirada a los anaqueles."},
        {"num":"3.5","responsable":"Auxiliar de Almacén","actividad":"Humedecer la franela con agua para retirar el detergente residual que haya quedado. Repetir las veces que sea necesario, hasta que el detergente haya sido retirado completamente. Secar con una franela limpia."},
        {"num":"3.6","responsable":"Auxiliar de Almacén","actividad":"Utilizar una franela seca o sacudidor para retirar el polvo de los insumos cuyo empaque o envase sea de cartón, realizando movimientos circulares y cuidando no dañarlo o desgastarlo; si el empaque secundario no es de cartón, limpiar con una franela húmeda si es necesario. Nota: evitar utilizar soluciones que deterioren el empaque o su etiquetado tales como Agua, Alcohol, Cloro, Jabón concentrado."},
        {"num":"3.7","responsable":"Auxiliar de Almacén","actividad":"Durante la limpieza, revisar que los insumos se encuentren en buen estado, con la debida rotación respetando el orden de Primeras Entradas – Primeras Salidas (PEPS), Primeras Caducidades – Primeras Salidas (PCPS), y se encuentren etiquetados según la fecha de caducidad y lo establecido en el proceso PR-AL-05."},
        {"num":"3.8","responsable":"Auxiliar de Almacén","actividad":"Al finalizar la limpieza de las áreas asignadas, registrar en el formato FT-AL-04 los siguientes datos: a) Fecha en la que se realizó la limpieza. b) Anaquel o área. c) Observaciones (incidentes encontrados durante la limpieza). Iniciales y firma de quien realizó la limpieza."},
        {"num":"3.9","responsable":"Encargado de Almacén","actividad":"Supervisar el cumplimiento del presente proceso en tiempo y forma con el debido llenado del formato FT-AL-04. NOTA: Este procedimiento debe realizarse al menos una vez por semana, o según necesidad. Se sugiere realizarse antes de recibir el surtido quincenal o semanal de insumos."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Alteración de los insumos por malas prácticas de almacenamiento.","barrera":"Cumplir debidamente con el proceso PR-AL-05 e instrucción de trabajo."},
        {"riesgo":"Daño del empaque exterior, impresiones, fechas de caducidad e instrucciones de uso.","barrera":"Utilizar únicamente el material indicado y realizarla en tiempo y forma, tal como se describe."},
    ],
    "referencias": [
        {"nombre":"Registro de limpieza de áreas, mobiliario e insumos","codigo":"FT-AL-04"},
        {"nombre":"Manejo y almacenamiento de insumos en general","codigo":"PR-AL-05"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"02/03/2022","descripcion":"Alta del documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"28/07/2022","descripcion":"Modificación de documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"03","fecha":"22/04/2026","descripcion":"Modificación de documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Dra. Giselle Ivette De la Torre García"},
    ],
}

PR_AL_01 = {
    "codigo": "PR-AL-01",
    "objetivo": "Garantizar la adquisición de insumos para salud e insumos en general para su oportuna distribución en las distintas áreas y departamentos del Hospital Santa Margarita, manteniendo la existencia mínima y máxima de los stocks.",
    "alcance": "El presente documento menciona desde la revisión de las necesidades de manera quincenal principal y semanalmente (cuando sea necesario o haya urgencia de adquisición de estos), hasta la recepción de insumos para proceder a su almacenamiento.",
    "definiciones": [
        {"termino":"Procedimiento Normalizado de Operación (PNO)","definicion":"Documento que contiene las instrucciones mínimas y necesarias para llevar a cabo una operación específica de manera reproducible y consistente."},
        {"termino":"Procedimiento (PR)","definicion":"Es una forma concreta para realizar una actividad o un proceso concreto donde se especifica como sucede. Intervienen varios responsables."},
        {"termino":"Primeras Caducidades, Primeras Salidas (PCPS)","definicion":"Método de gestión de inventarios que prioriza la salida de los productos con fecha de caducidad más próxima."},
        {"termino":"Primeras Entradas, Primeras Salidas (PEPS)","definicion":"Método de gestión de inventarios que prioriza la salida de los productos que ingresaron primero al almacén."},
    ],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Coordinador de almacén."},
        {"tipo":"Ejecución","descripcion":"Coordinador de almacén, analista de almacén, almacenista."},
        {"tipo":"Supervisión","descripcion":"Dirección Administrativa, Jefatura Farmacia."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Coordinador de Almacén / Analista de Almacén","actividad":"Revisar las necesidades en base al consumo semanal, requerimientos diarios, solicitudes de pedido del área farmacia y quirófano, para calcular la cantidad exacta a adquirir por producto. Realizando un recorrido presencial para corroborar existencias y stock físico en el área."},
        {"num":"5.2","responsable":"Analista de Almacén","actividad":"Generar la requisición conforme al formato FT-JC-06 en Excel."},
        {"num":"5.3","responsable":"Coordinador de Almacén","actividad":"Revisar requisición generada, que concuerden cantidades previamente registradas tomando en cuenta movimientos en traspasos, vales de dependencia. Si hay alguna modificación realizarla en el formato FT-JC-06 vigente, enviar correo electrónico a compras@hsmgdl.com, imprimir 2 copias, firmar ambas impresiones, entregar al área de compras una copia firmada y recibir la segunda copia con su firma de recepción."},
        {"num":"5.4","responsable":"Compras","actividad":"Departamento de compras entrega órdenes de compra autorizadas y firmadas a Almacén, quedando a la espera de la entrega del insumo solicitado."},
        {"num":"5.5","responsable":"Analista de Almacén / Almacenista","actividad":"Recibir los insumos y verificar: Datos en la factura; razón social y domicilio del proveedor conforme a Licencia Sanitaria; datos del insumo, cantidad, fecha de caducidad y número de lote. NOTA: El proveedor debe entregar 3 juegos de copia de la factura. Verificar también que los productos estén en buen estado y que se cumplan condiciones especiales de almacenamiento si aplica."},
        {"num":"5.6","responsable":"Coordinador de Almacén / Analista de Almacén / Almacenista / Compras","actividad":"Si se cumple con lo citado en el punto anterior, sellar y firmar la factura original; entregar una copia original al proveedor y resguardar 3 copias. En caso contrario dar aviso al área de compras para rechazar la entrega o confirmar si se autorizó una entrega parcial."},
        {"num":"5.7","responsable":"Coordinador de Almacén / Analista de Almacén","actividad":"Dar entrada a la factura en el sistema vigente por medio de la orden de compra, revisando que el precio de adquisición coincida con la factura y aprobarla para su entrada en el Almacén correspondiente. Archivar una copia en la carpeta correspondiente junto con su entrada generada."},
        {"num":"5.8","responsable":"Almacenista","actividad":"Almacenar los insumos recibidos de acuerdo con el proceso para el manejo y almacenamiento, respetando PEPS y PCPS."},
        {"num":"5.9","responsable":"Almacenista","actividad":"En caso de que se reciban insumos que no se almacenen en Almacén General, entregarlos al área responsable de su almacenamiento respetando el empaquetado, transporte o temperatura con que se recibe dicho insumo."},
        {"num":"5.10","responsable":"Personal de las diferentes áreas","actividad":"Al momento de la entrega el personal a recepción debe verificar los insumos que se están entregando junto con la entrada dada en sistema y firmar de aceptado con su nombre y fecha de recepción."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Retraso para la entrada del insumo adquirido.","barrera":"Notificar a Almacén con la entrega de la orden de compra generada después de ser enviada al proveedor."},
        {"riesgo":"El proveedor no es capaz de cubrir la orden de compra completa en tiempo y forma por alta demanda o faltante desde fabricante.","barrera":"Contactar con el departamento de compras para que se comunique con otro proveedor autorizado y/o buscar sustituto del producto faltante."},
        {"riesgo":"Mal manejo por parte del área receptora e inconformidad por entrega de material.","barrera":"Firma de conformidad y seguimiento del protocolo de manejo de material o insumo."},
    ],
    "referencias": [
        {"nombre":"Manejo y almacenamiento de dispositivos médicos y otros insumos en general","codigo":"PR-AL-05"},
        {"nombre":"Devolución de medicamentos y demás insumos para la salud a proveedores","codigo":"PNO-FH-27"},
        {"nombre":"Formato de Requisición Almacén","codigo":"FT-JC-06"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"05/07/2022","descripcion":"Alta del documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"22/09/2025","descripcion":"Actualización de documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Dra. Giselle Ivette De la Torre García"},
        {"version":"03","fecha":"28/04/2026","descripcion":"Actualización de documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Dra. Giselle Ivette De la Torre García"},
    ],
}

PR_AL_02 = {
    "codigo": "PR-AL-02",
    "objetivo": "Garantizar la adquisición de insumos para salud e insumos en general para su oportuna distribución en las distintas áreas del Hospital Santa Margarita, en forma de consignación o remisión y poder mantener una existencia mínima para su uso posterior.",
    "alcance": "El presente documento le compete a la Jefatura de Compras, Coordinador de Almacén, Analista de Almacén, Almacenista.",
    "definiciones": [
        {"termino":"Procedimiento Normalizado de Operación (PNO)","definicion":"Documento que contiene las instrucciones mínimas y necesarias para llevar a cabo una operación específica de manera reproducible y consistente."},
        {"termino":"Procedimiento (PR)","definicion":"Es una forma concreta para realizar una actividad o un proceso concreto donde se especifica como sucede. Intervienen varios responsables."},
    ],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Coordinador de almacén."},
        {"tipo":"Ejecución","descripcion":"Jefatura de compras, Coordinador de almacén, analista de almacén, almacenista."},
        {"tipo":"Supervisión","descripcion":"Dirección Administrativa."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Coordinador de Almacén / Analista de Almacén","actividad":"Atender las necesidades para la solicitud de material extraordinario para procedimientos quirúrgicos, solicitudes de pedido del área de Farmacia o Quirófano, así como la cantidad exacta a adquirir del producto solicitado y dentro del catálogo al día (FT-JC-06). NOTA: Para productos nuevos y fuera de catálogo se transferirá la solicitud al dpto. de compras."},
        {"num":"5.2","responsable":"Coordinador de Almacén / Analista de Almacén","actividad":"Contactar al dpto. de Compras y solicitar los insumos requeridos de manera extraordinaria en remisión o consigna, mientras no se tenga asegurado su uso por parte del área que lo solicita, indicando solo las unidades que se prevén utilizar."},
        {"num":"5.3","responsable":"Analista de Almacén / Almacenista","actividad":"Recibir los insumos de forma remisionada o consignada y verificar: datos en la remisión o consigna; razón social y domicilio del proveedor; datos del insumo, cantidad, fecha de caducidad y número de lote; productos en buen estado; condiciones especiales de almacenamiento si aplica."},
        {"num":"5.4","responsable":"Coordinador de Almacén / Analista de Almacén","actividad":"Si se cumple con lo citado en el punto anterior, sellar y firmar la remisión o consigna original y copias que entregue el proveedor."},
        {"num":"5.5","responsable":"Coordinador de Almacén / Analista de Almacén","actividad":"Ingresar la remisión o consigna como 'entrada no ligada a orden de compra', imprimir y engrapar la entrada al sistema junto con la copia de remisión o consigna. Entregar al área de Compras la hoja original de remisión o consigna recibida para su resguardo y seguimiento. Archivar en carpeta correspondiente."},
        {"num":"5.6","responsable":"Analista de Almacén / Almacenista","actividad":"Informar al área solicitante sobre la existencia del insumo para su entrega."},
        {"num":"5.7","responsable":"Analista de Almacén / Almacenista","actividad":"Traspasar el insumo al área solicitante a través del sistema para afectar las existencias de ambos almacenes."},
        {"num":"5.8","responsable":"Coordinador de Almacén / Analista de Almacén / Jefatura de Compras","actividad":"Confirmar con el área solicitante si el insumo fue utilizado. Si fue utilizado, notificar al dpto. de compras para que solicite al proveedor su facturación y realice la orden de compra (PR-AL-01) correspondiente para su ingreso al sistema."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Insumo solicitado de forma urgente y el proveedor no puede cumplir con su entrega a tiempo.","barrera":"Contactar por parte del departamento de compras a otro proveedor autorizado."},
        {"riesgo":"Datos de la remisión no coinciden con el producto entregado (cantidad, lote, fecha caducidad).","barrera":"Cotejar producto físico recibido contra la remisión o consigna recibida de manera detallada."},
        {"riesgo":"En copia de remisión o consigna falta la leyenda 'cancelada', lo que podría propiciar una factura de un producto no utilizado.","barrera":"Al momento de la recolección dejar por escrito la leyenda CANCELADA, así como si el producto se devuelve en óptimas condiciones, nombre y firma de quien realiza la colecta y fecha de recolección."},
    ],
    "referencias": [
        {"nombre":"Devolución de medicamentos y demás insumos para la salud a proveedores","codigo":"PNO-FH-27"},
        {"nombre":"Adquisición y recepción de insumos en general","codigo":"PR-AL-01"},
        {"nombre":"Formato de Requisición Almacén","codigo":"FT-JC-06"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"05/07/2022","descripcion":"Alta del documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Mtra. Ana Cecilia Zárate Bautista"},
        {"version":"02","fecha":"31/01/2023","descripcion":"Modificación de documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Mtra. Ana Cecilia Zárate Bautista"},
        {"version":"03","fecha":"22/09/2025","descripcion":"Actualización de documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Dra. Giselle Ivette De la Torre García"},
        {"version":"04","fecha":"29/04/2026","descripcion":"Actualización de documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Dra. Giselle Ivette De la Torre García"},
    ],
}

PR_AL_03 = {
    "codigo": "PR-AL-03",
    "objetivo": "Establecer los lineamientos y acciones para el correcto manejo y conservación de dispositivos médicos y otros insumos en el almacén, para mantener la integridad y seguridad de estos.",
    "alcance": "Este documento es de carácter obligatorio para todo el personal del área de almacén que se vea involucrado desde la recepción de los insumos, el almacenamiento con control de condiciones medioambientales, hasta la revisión de caducidades.",
    "definiciones": [
        {"termino":"Primeras Caducidades - Primeras Salidas (PCPS)","definicion":"Este método se basa en las salidas del almacén según el orden en que estas entraron, tomando muy en cuenta las fechas de caducidad evitando así pérdidas por deterioro y/o pérdida de esterilidad del insumo."},
        {"termino":"Primeras Entradas – Primeras Salidas (PEPS)","definicion":"Este método se basa en que los productos adquiridos primero son los primeros en salir. Permite mantener un orden en el inventario siendo que los artículos primeros adquiridos sean utilizados antes del vencimiento o deterioro."},
    ],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Jefatura de Almacén."},
        {"tipo":"Ejecución","descripcion":"Jefatura de Almacén, Analista de Almacén, Almacenista, Auditoría."},
        {"tipo":"Supervisión","descripcion":"Jefatura de Farmacia, Auditoría."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Almacenista","actividad":"Una vez recibidos los insumos conforme a PR-AL-02, almacenarlos y organizarlos: organizar según tipo y uso; aplicar PCPS y PEPS dando prioridad a la fecha de caducidad, acomodando de izquierda a derecha y de atrás hacia adelante; conservar en envase original protegidos de la luz directa; etiquetar con circular roja si caducidad menor a 6 meses. Material NO debe colocarse sobre el suelo."},
        {"num":"5.2","responsable":"Almacenista","actividad":"Almacenar dispositivos médicos y otros insumos conforme a los requerimientos de temperatura (entre 20 y 25°C), humedad (no mayor al 40% de humedad relativa) y exposición a la luz, de acuerdo con la normativa oficial vigente."},
        {"num":"5.3","responsable":"Almacenista","actividad":"Almacenar dispositivos médicos e insumos en remisión o consigna en el área asignada por el departamento de Almacén, siguiendo los mismos lineamientos de temperatura, humedad y exposición a la luz."},
        {"num":"5.4","responsable":"Almacenista","actividad":"Limpiar y ordenar el mobiliario de acuerdo con lo establecido en la instrucción de trabajo IT-AL-01."},
        {"num":"5.5","responsable":"Jefatura de Almacén","actividad":"Supervisar el cumplimiento de cada una de las actividades anteriormente mencionadas en tiempo y forma."},
        {"num":"5.6","responsable":"Almacenista","actividad":"Monitorizar la temperatura y humedad relativa del medio ambiente del Almacén y registrar la lectura en los formatos FT-AL-06 y FT-AL-07, respectivamente. NOTA: El termohigrómetro debe estar calibrado por un laboratorio acreditado por la EMA."},
        {"num":"5.7","responsable":"Jefatura de Almacén / Analista de Almacén","actividad":"En caso de que la humedad relativa sobrepase el 40% o la temperatura supere los 30°C, dar aviso al Departamento de Mantenimiento para aplicar las medidas correctivas necesarias al área."},
        {"num":"5.8","responsable":"Auxiliar de Mantenimiento","actividad":"Al recibir el aviso por parte del departamento de Almacén General, realizar el mantenimiento correctivo conforme al PR-SG-17 en las instalaciones para dar pronta solución al problema detectado."},
        {"num":"5.9","responsable":"Jefatura de Almacén","actividad":"Supervisar que cada una de las actividades anteriormente mencionadas se realicen en tiempo y forma."},
        {"num":"5.10","responsable":"Jefatura de Almacén / Analista de Almacén / Almacenista","actividad":"Revisar mensualmente y/o durante la limpieza cada uno de los insumos para identificar aquellos próximos a caducar o caducos, así como los que han sufrido alguna alteración física como: envase manchado por humedad, manchado por contenido, ruptura, decoloración o daño por luz directa."},
        {"num":"5.11","responsable":"Almacenista / Analista de Almacén","actividad":"Al encontrar alguna alteración, separar del resto en el lugar indicado, avisando a Jefatura de Almacén para tomar las medidas necesarias. Dar aviso al dpto. de Compras para ponerse en contacto con el proveedor si procediese algún cambio."},
        {"num":"5.12","responsable":"Jefatura de Almacén","actividad":"Revisar los insumos próximos a caducar, caducos o deteriorados y determinar si se devuelven al proveedor (si procede) o si se destruyen y desechan de la manera correspondiente."},
        {"num":"5.13","responsable":"Jefatura de Almacén / Analista de Almacén","actividad":"Dar de baja la existencia en el almacén por medio del sistema vigente, realizando un traspaso al almacén de CADUCADOS ALMACÉN GENERAL para fines contables."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Almacenamiento y organización inapropiada de los insumos, generando pérdidas por caducidad o por alguna alteración física.","barrera":"Utilizar el sistema PCPS y/o PEPS, almacenar los insumos dentro de su empaque original y protegidos de la luz directa, y colocar el insumo en el mobiliario y área correspondiente."},
        {"riesgo":"Temperatura y humedad relativa del medio ambiente fuera de rango.","barrera":"Dar aviso de inmediato al departamento de Mantenimiento para aplicar las medidas correctivas, así como el mantenimiento preventivo para evitar fallas en los equipos."},
        {"riesgo":"Distribución de insumos caducados o deteriorados.","barrera":"Revisar mensualmente los insumos y etiquetar de acuerdo con la fecha de caducidad conforme a lo descrito en el presente documento."},
    ],
    "referencias": [
        {"nombre":"Registro de temperatura del medio ambiente de Almacén","codigo":"FT-AL-06"},
        {"nombre":"Registro de humedad relativa del medio ambiente de Almacén","codigo":"FT-AL-07"},
        {"nombre":"Limpieza de áreas, mobiliario e insumos","codigo":"IT-AL-01"},
        {"nombre":"Proceso de mantenimiento correctivo en equipo e infraestructura","codigo":"PR-SG-17"},
        {"nombre":"Adquisición y recepción de insumos en general","codigo":"PR-AL-02"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"28/07/2022","descripcion":"Alta del documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"22/09/2025","descripcion":"Actualización del documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Dra. Giselle Ivette De la Torre García"},
        {"version":"03","fecha":"29/04/2026","descripcion":"Actualización del documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Dra. Giselle Ivette De la Torre García"},
    ],
}

PR_AL_04 = {
    "codigo": "PR-AL-04",
    "objetivo": "Garantizar la correcta revisión de los materiales médicos, medicamentos y demás insumos para la salud, con la finalidad de identificar aquellos que no cumplan con las características de calidad necesarias o que estén próximos a caducar, realizando la devolución correspondiente al proveedor.",
    "alcance": "El presente documento le compete a todo el Personal del Servicio de Farmacia y Almacén General del Hospital Santa Margarita.",
    "definiciones": [
        {"termino":"Procedimiento Normalizado de Operación (PNO)","definicion":"Documento que contiene las instrucciones mínimas y necesarias para llevar a cabo una operación específica de manera reproducible y consistente."},
    ],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Jefatura de Farmacia, Coordinador de Almacén."},
        {"tipo":"Ejecución","descripcion":"Coordinador de Almacén, Analista de almacén, Almacenista, Auxiliar de Farmacia y proveedores autorizados."},
        {"tipo":"Supervisión","descripcion":"Dirección General, Dirección Administrativa, Jefatura de Farmacia, Auditoría."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Analista de Almacén / Almacenista / Auxiliar de Farmacia","actividad":"Identificar insumos para devolución al proveedor: próximos a caducar (caducidad en menos de 2 meses), baja rotación en consigna, defectos de calidad, producto no solicitado en orden de compra, deterioro (decoloración, manchas de humedad, empaque inflado, daño que comprometa el insumo, fugas, rupturas, cambio de color o apariencia, líquidos con partículas anormales)."},
        {"num":"5.2","responsable":"Analista de Almacén / Almacenista / Auxiliar de Farmacia","actividad":"Separar el insumo indicando el proveedor al que será devuelto y colocarlo en el área de devoluciones, en donde permanecerá hasta obtener la resolución de la solicitud generada."},
        {"num":"5.3","responsable":"Analista de Almacén / Almacenista / Auxiliar de Farmacia","actividad":"Llenar el formato 'Comprobante de devolución a proveedores' con: fecha, proveedor, número de factura, cantidad, descripción del medicamento/insumo, lote, fecha de caducidad. Realizar una salida de 'vale de dependencia' en el software hospitalario vigente indicando el motivo de la devolución y el proveedor. Registrar el número de folio del vale en el formato (no imprimir el vale de dependencia)."},
        {"num":"5.4","responsable":"Coordinador de Almacén / Analista de Almacén","actividad":"Recibir los comprobantes de devolución a proveedor provenientes de Farmacia y dar continuidad al proceso."},
        {"num":"5.5","responsable":"Coordinador de Almacén / Analista de Almacén","actividad":"Notificar inmediatamente al dpto. de Compras (insumos en general) o al proveedor de medicamentos vía WhatsApp, correo electrónico o llamada telefónica sobre la devolución del medicamento/insumo, y esperar respuesta del proveedor."},
        {"num":"5.6","responsable":"Proveedor autorizado","actividad":"Una vez recibida y aceptada la notificación, revisar el medicamento/insumo verificando el motivo de la devolución. En caso de no detectar anomalía o motivo para rechazar la devolución, retirarlo de Farmacia y/o Almacén."},
        {"num":"5.7","responsable":"Proveedor autorizado","actividad":"Informar si realizará una nota de crédito o, si procede, la reposición del medicamento/insumo. Firmar de recibido FT-FH-96 y retirar el medicamento/insumo del hospital."},
        {"num":"5.8","responsable":"Coordinador de Almacén / Analista de Almacén","actividad":"En caso de nota de crédito: devolver el vale realizado anteriormente; ingresar la nota de crédito en el sistema Abastecimientos2 ligándola con la factura correspondiente; imprimir tres copias (resguardo, Auditor y Contabilidad). En caso de reposición: devolver el vale de dependencia para cuadrar inventarios y recibir el medicamento/insumo para almacenarlo."},
        {"num":"5.9","responsable":"Coordinador de Almacén / Analista de Almacén","actividad":"En caso de que el proveedor rechace la devolución, avisar a Jefatura de Farmacia y/o Dirección Administrativa para tomar las medidas necesarias."},
    ],
    "gestion_riesgos": [
        {"riesgo":"No avisar al proveedor sobre la devolución.","barrera":"Avisar inmediatamente al proveedor en cuanto se reciba el formato de devolución de proveedores y dar seguimiento a la resolución."},
        {"riesgo":"No informar al auditor sobre nota de crédito recibida.","barrera":"En cuanto se ingrese la nota de crédito en el sistema, sacar un juego para el auditor para que aplique el descuento."},
        {"riesgo":"Afectación del inventario por no realizar el vale correspondiente.","barrera":"En cuanto se detecte el producto deteriorado realizar el vale mediante sistema y llenado de formulario para evitar descuadre y faltantes de inventario."},
    ],
    "referencias": [
        {"nombre":"Comprobante de devolución a proveedores","codigo":"FT-FH-96"},
        {"nombre":"Control y desecho de medicamentos y demás insumos para la salud: deteriorados, caducos o sus residuos peligrosos","codigo":"PNO-FH-11"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"13/09/2023","descripcion":"Alta de documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"26/09/2025","descripcion":"Modificación y actualización de documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Dra. Giselle Ivette De la Torre García"},
        {"version":"03","fecha":"29/04/2026","descripcion":"Modificación y actualización de documento","realizado":"LAE. Ismael Omar Rodríguez Vázquez","aprobado":"Dra. Giselle Ivette De la Torre García"},
    ],
}

# ══════════════════════════════════════════════════════════════
# BUILDERS
# ══════════════════════════════════════════════════════════════

def build_doc_insert(m):
    code      = esc(m['code'])
    name      = esc(m['name'])
    tprefix   = esc(m['type_prefix'])
    dcode     = esc(m['dept_code'])
    version   = esc(m['version'])
    status    = esc(m['status'])
    custodian = esc(m['custodian'])
    elab      = m['elab_date']
    elaborated= esc(m['elaborated_by'])
    reviewed  = esc(m['reviewed_by'])
    vigencia  = m['vigencia']
    return f"""
-- Documento: {m['code']}
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  elab_date, elaborated_by, reviewed_by, vigencia)
SELECT
  '{code}',
  '{name}',
  (SELECT id FROM document_types WHERE code_prefix = '{tprefix}'),
  (SELECT id FROM departments     WHERE code = '{dcode}'),
  '{version}', '{status}', '{custodian}',
  '{elab}', '{elaborated}', '{reviewed}', {vigencia}
WHERE EXISTS (SELECT 1 FROM departments WHERE code = '{dcode}')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  elaborated_by     = EXCLUDED.elaborated_by,
  reviewed_by       = EXCLUDED.reviewed_by;"""

def build_it_content(doc):
    code = doc['codigo']
    alc  = esc(doc['alcance'])
    mat  = esc(j(doc['material_equipo']))
    des  = esc(j(doc['desarrollo']))
    gr   = esc(j(doc['gestion_riesgos']))
    refs = esc(j(doc['referencias']))
    cc   = esc(j(doc['control_cambios']))
    return f"""
-- Contenido: {code}
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios, definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = '{code}'),
  '{alc}', '{alc}',
  '{mat}'::jsonb, '{des}'::jsonb, '{gr}'::jsonb,
  '{refs}'::jsonb, '{cc}'::jsonb, '[]'::jsonb, '[]'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = '{code}')
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;"""

def build_pr_content(doc):
    code  = doc['codigo']
    obj   = esc(doc['objetivo'])
    alc   = esc(doc['alcance'])
    des   = esc(j(doc['desarrollo']))
    gr    = esc(j(doc['gestion_riesgos']))
    refs  = esc(j(doc['referencias']))
    cc    = esc(j(doc['control_cambios']))
    defs  = esc(j(doc['definiciones']))
    resps = esc(j(doc['responsabilidades']))
    return f"""
-- Contenido: {code}
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios, definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = '{code}'),
  '{alc}', '{obj}',
  '[]'::jsonb, '{des}'::jsonb, '{gr}'::jsonb,
  '{refs}'::jsonb, '{cc}'::jsonb, '{defs}'::jsonb, '{resps}'::jsonb
WHERE EXISTS (SELECT 1 FROM documents WHERE code = '{code}')
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  desarrollo=EXCLUDED.desarrollo, gestion_riesgos=EXCLUDED.gestion_riesgos,
  referencias=EXCLUDED.referencias, control_cambios=EXCLUDED.control_cambios,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades;"""

# ══════════════════════════════════════════════════════════════
# GENERAR SQL
# ══════════════════════════════════════════════════════════════
HEADER = """\
-- ============================================================
--  Almacén — Registro y contenido digital de documentos AL
--  Hospital Santa Margarita · SGC ISO 9001:2015
--
--  Orden de ejecución:
--    1. Asegúrate de que exista el departamento con code='AL'
--       (la página de Configuración o el cleanup SQL lo actualiza)
--    2. Ejecutar este SQL completo en Supabase SQL Editor
-- ============================================================

-- Actualizar código del departamento Almacén de ALM → AL
UPDATE departments SET code = 'AL' WHERE code = 'ALM' AND name = 'Almacén';
-- Si el departamento no existe, crearlo:
INSERT INTO departments (code, name, is_active)
VALUES ('AL', 'Almacén', true)
ON CONFLICT (code) DO NOTHING;

"""

IT_DOCS      = [IT_AL_01]
PR_DOCS      = [PR_AL_01, PR_AL_02, PR_AL_03, PR_AL_04]
ALL_CONTENT  = {d['codigo']: d for d in IT_DOCS + PR_DOCS}

sql = HEADER

sql += "\n-- ═══ REGISTRAR DOCUMENTOS ═══\n"
for m in DOCS_META:
    sql += build_doc_insert(m)

sql += "\n\n-- ═══ CARGAR CONTENIDO DIGITAL ═══\n"
sql += build_it_content(IT_AL_01)
for doc in PR_DOCS:
    sql += build_pr_content(doc)

sql += "\n\n-- Verificación\nSELECT d.code, d.name, dc.document_id IS NOT NULL AS tiene_contenido\nFROM documents d\nLEFT JOIN document_content dc ON dc.document_id = d.id\nWHERE d.code LIKE 'IT-AL%' OR d.code LIKE 'PR-AL%'\nORDER BY d.code;\n"

pathlib.Path('al_full.sql').write_text(sql, encoding='utf-8')
size = pathlib.Path('al_full.sql').stat().st_size
print(f'al_full.sql generado: {size:,} bytes')
print(f'Documentos: {len(DOCS_META)}')
for m in DOCS_META:
    code = m['code']
    print(f"  {code}")
