#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Lote 4 — PR-UV-18, 19, 20, 21, 22
Genera uv_pr_b4.sql
"""
import json, pathlib

def esc(s):
    return str(s).replace("'", "''") if s else ''

def j(obj):
    return json.dumps(obj, ensure_ascii=False)

# ── PR-UV-18 ──────────────────────────────────────────────────────────────────
PR_UV_18 = {
    "codigo": "PR-UV-18",
    "objetivo": (
        "Prevenir la probabilidad de infección polvo y humedad por adecuaciones, "
        "construcciones y remodelaciones."
    ),
    "alcance": (
        "Inicia cuando el departamento de Seguridad e Higiene y Medio Ambiente realiza "
        "calendario anual de actividades para construcciones, remodelaciones o modificaciones."
    ),
    "definiciones": [],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Seguridad e Higiene y Medio Ambiente y UVEH."},
        {"tipo":"Supervisión","descripcion":"Dirección Médica."},
    ],
    "desarrollo": [
        {"num":"5.2","responsable":"Seguridad e Higiene y Medio Ambiente","actividad":"El departamento cuenta las medidas necesarias para reducir los riesgos de infección a pacientes, colaboradores, visitantes, etc.; con apego a la identificación de áreas de riesgo basadas en construcciones, remodelaciones y/o modificaciones. EM1"},
        {"num":"5.3","responsable":"Seguridad e Higiene y Medio Ambiente","actividad":"Realiza análisis de riesgo antes de iniciar algún proyecto de construcciones, remodelaciones y/o modificaciones. EM2"},
        {"num":"5.4","responsable":"Seguridad e Higiene y Medio Ambiente","actividad":"Aplica proceso proactivo para la evaluación de los riesgos previo al inicio de un proceso de supervisión de construcción y/o remodelación (PR-SG-16) en el cual se realiza la revisión de las condiciones de infraestructura y observaciones y/o indicaciones."},
        {"num":"5.5","responsable":"UVEH","actividad":"Supervisa las actividades de construcciones, remodelaciones o modificaciones, y si se requiere, de manera por medio de memorándum informar al personal que labora en el hospital las medidas que se tienen que llevar a cabo."},
        {"num":"5.6","responsable":"UVEH","actividad":"Supervisa las condiciones de inicio de trabajos y define en conjunto con Seguridad de Higiene los métodos, controles de entrada y salidas de personal y materiales, así como limpieza al final antes de entregar las obras. EM2."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Riesgo de infecciones y alergias, en pacientes, colaboradores, visitantes por el polvo, humedad etc.","barrera":"Se realizan análisis de riesgo de manera anticipada de todas las construcciones."},
        {"riesgo":"Sanciones por parte de secretaría del trabajo y prevención social, secretaría de energía, secretaría de medio ambiente y recursos naturales, protección civil y bomberos del estado, comisión para la protección contra riesgos sanitarios del estado de Jalisco.","barrera":"Supervisión continúa sobre la aplicación de los procesos internos."},
    ],
    "referencias": [
        {"nombre":"Proceso de supervisión en construcción y remodelación","codigo":"PR-SG-16"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"05/07/2021","descripcion":"Alta de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"08/02/2024","descripcion":"Modificación de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"03","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Estebán González Díaz"},
    ],
}

# ── PR-UV-19 ──────────────────────────────────────────────────────────────────
PR_UV_19 = {
    "codigo": "PR-UV-19",
    "objetivo": (
        "Garantizar el adecuado uso de los medicamentos y vacunas desde el punto de vista "
        "de prevención de infecciones."
    ),
    "alcance": (
        "Inicia cuando el departamento aplica proceso seguro del uso de medicamentos y termina "
        "cuando UVEH realiza muestreo y análisis microbiológico de manera aleatoria tanto en "
        "refrigeradores como de medicamentos almacenados, con la finalidad de prevenir infecciones."
    ),
    "definiciones": [],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Farmacovigilancia, Intendencia, Enfermería y UVEH."},
        {"tipo":"Supervisión","descripcion":"Dirección Médica."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Farmacovigilancia","actividad":"Aplica proceso seguro del uso de medicamentos multidosis (PR-FH-06), así como Política (PL-FH-01) y proceso de administración de los medicamentos que trae consigo el paciente (PR-FH-02), con el objetivo de asegurar el cuidado de su medicación durante su estancia hospitalaria. EM1."},
        {"num":"5.2","responsable":"Intendencia","actividad":"Se realiza limpieza de refrigeradores de alimentos, con el fin de evitar la contaminación bacteriana. (IT-IN-07) EM2"},
        {"num":"5.3","responsable":"Enfermería","actividad":"Cuenta con los insumos necesarios de limpieza de mesas para la preparación de medicamentos hasta la aplicación de estos cuidando las técnicas correctas de asepsia. EM2"},
        {"num":"5.4","responsable":"UVEH","actividad":"Realiza supervisión de los refrigeradores de medicamentos de las diferentes áreas, con la finalidad de detectar factores que contribuyen a contaminación de los medicamentos ahí resguardados (FTUV-22)."},
        {"num":"5.5","responsable":"UVEH","actividad":"De manera anual se realizará muestreo y análisis microbiológico de manera aleatoria tanto en refrigeradores como de medicamentos almacenados, con la finalidad de prevenir infecciones."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Riesgo de contaminación microbiológica de los medicamentos por mal manejo.","barrera":"Capacitación continúa del personal para el correcto uso de medicamentos."},
        {"riesgo":"Infección a la paciente asociada a la atención sanitaria.","barrera":"Supervisión constante por parte de epidemiología y muestreo microbiológico con fin de prevenir infecciones."},
    ],
    "referencias": [
        {"nombre":"Instrucción de trabajo para la limpieza y desinfección de refrigeradores de medicamentos.","codigo":"IT-IN-07"},
        {"nombre":"Supervisión de centrales y áreas.","codigo":"FT-UV-22"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"05/07/2021","descripcion":"Alta de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"21/09/2022","descripcion":"Modificación de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"03","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Estebán González Díaz"},
    ],
}

# ── PR-UV-20 ──────────────────────────────────────────────────────────────────
PR_UV_20 = {
    "codigo": "PR-UV-20",
    "objetivo": (
        "Reducir el riesgo de infecciones para los pacientes, personal y familiares, a través de "
        "supervisión y análisis de tasas, patrones y tendencias."
    ),
    "alcance": (
        "Inicia cuando el auxiliar de epidemiología realiza vigilancia activa en hospital y termina "
        "cuando el jefe del departamento presenta el análisis de las tasas, patrones y tendencias "
        "en el 'Comité para la Detección y Control de Infecciones Asociadas a la Atención de la "
        "Salud (CODECIAAS)'."
    ),
    "definiciones": [
        {"termino":"CODECIAAS","definicion":"Son las siglas del Comité para la Detección y Control de Infecciones Asociadas a la Atención de la Salud."},
    ],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Auxiliar de UVEH, Jefatura de UVEH y CODECIAAS."},
        {"tipo":"Supervisión","descripcion":"Dirección Médica."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Auxiliar de UVEH","actividad":"Realiza vigilancia epidemiológica 'Activa', el cual consiste básicamente en la búsqueda intencionada de casos de enfermedades sujetas a vigilancia epidemiológica y de infecciones hospitalarias descritas en la instrucción de vigilancia activa IT-UV-17 y es el responsable de la notificación inmediata y mensual de las enfermedades que establece la normativa vigente. (Norma Oficial Mexicana NOM-017-SSA2-2012, para la vigilancia epidemiológica.) (EM7)"},
        {"num":"5.2","responsable":"Auxiliar de UVEH","actividad":"Diariamente se monitorean los pacientes hospitalizados, con el fin de identificar oportunamente infecciones relacionadas a la atención sanitaria."},
        {"num":"5.3","responsable":"Auxiliar de UVEH","actividad":"Una vez identificadas las infecciones se levanta estudio epidemiológico correspondiente (PR-UV-06 y PR-UV-07), se capturan los datos con el fin de formar indicadores, que ayuden analizar el comportamiento y tomar medidas preventivas. EM3"},
        {"num":"5.4","responsable":"CODECIAAS","actividad":"El jefe encargado del departamento será el encargado de realizar indicadores de manera mensual de las infecciones hospitalarias, con el fin de medir, analizar y evaluar y estos resultados se presentan en las sesiones ordinarias del CODECIAAS. EM4"},
        {"num":"5.5","responsable":"CODECIAAS","actividad":"Además realizará las tasas de infecciones relacionadas a la atención sanitaria, analizar los patrones y tendencias. EM2. Para poder realizar las tasas es importante obtener datos del departamento de sistemas del total de egresos por mes y para hacer análisis de los patrones y tendencias, se cuenta con datos históricos, que nos permiten realizar comparaciones."},
        {"num":"5.6","responsable":"CODECIAAS","actividad":"Los resultados obtenidos siempre serán comparados con los estándares nacionales e internacionales, así como organizaciones estatales; con el único fin de apegarnos a los lineamientos establecidos. EM5"},
        {"num":"5.7","responsable":"CODECIAAS","actividad":"De igual forma tendrán que ser presentados en las sesiones ordinarias del CODECIN, con la finalidad de mejorar procesos o generar estrategias para mejorar nuestros datos. EM6"},
    ],
    "gestion_riesgos": [
        {"riesgo":"Sesgo en la información por no identificar oportunamente las infecciones.","barrera":"Adiestramiento del personal de epidemiología para la identificación oportuna de los casos."},
        {"riesgo":"Falta de información por parte del departamento de archivo clínico para la construcción de indicadores.","barrera":"Compromiso por parte del departamento de archivo clínico para entrega oportuna cada mes de la información."},
    ],
    "referencias": [
        {"nombre":"Norma Oficial Mexicana NOM-017-SSA2-2012, para la vigilancia epidemiológica.","codigo":"NA"},
        {"nombre":"Vigilancia epidemiológica activa","codigo":"IT-UV-17"},
        {"nombre":"Notificación epidemiológica inmediata","codigo":"PR-UV-06"},
        {"nombre":"Notificación epidemiológica diaria","codigo":"PR-UV-07"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"05/07/2021","descripcion":"Alta de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"21/09/2022","descripcion":"Modificación de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"03","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Estebán González Díaz"},
    ],
}

# ── PR-UV-21 ──────────────────────────────────────────────────────────────────
PR_UV_21 = {
    "codigo": "PR-UV-21",
    "objetivo": (
        "Asegurar el buen manejo de la ropa hospitalaria desde su recepción hasta su disposición final."
    ),
    "alcance": (
        "Este procedimiento inicia la empresa subrogada entrega la ropa limpia hospitalaria y "
        "termina cuando la responsable de ropería hace la entrega de la ropa sucia y/o contaminada."
    ),
    "definiciones": [
        {"termino":"CODECIAAS","definicion":"Son las siglas del Comité para la Detección y Control de Infecciones Asociadas a la Atención de la Salud."},
    ],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Encargada de ropería, enfermería operativa, Médico tratante, Intendencia, Operador de la empresa subrogada y Epidemiología."},
        {"tipo":"Supervisión","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Encargada de Ropería","actividad":"Realiza recepción y almacenamiento de ropa limpia hospitalaria que la empresa subrogada renta al hospital. (PR-RO-02)"},
        {"num":"5.2","responsable":"Encargada de Ropería","actividad":"Determinan el stock de ropa limpia de cada una de las áreas. (FT-RO-01)"},
        {"num":"5.3","responsable":"Encargada de Ropería / Jefatura de Enfermería","actividad":"Realizan acuerdos de horarios de entrega y recepción de ropa limpia (FT-RO-04). PR-JE-02 MISP 2. Mejorar la comunicación efectiva."},
        {"num":"5.4","responsable":"Encargada de Ropería","actividad":"Realiza abastecimientos de stock de ropa de cada área (IT-RO-1) y firma bitácora 'Entrega y recepción de ropa hospitalaria.' (FT-RO-01)."},
        {"num":"5.5","responsable":"Enfermería (Operativo)","actividad":"Recibe, realiza conteo y firma bitácora de ropa limpia de cada área. (FT-RO-01)"},
        {"num":"5.6","responsable":"Enfermería (Operativo)","actividad":"Verifica que la ropa limpia entregada sea la correcta y suficiente para cubrir la demanda y necesidades del servicio."},
        {"num":"5.7","responsable":"Enfermería (Operativo)","actividad":"Realiza manejo adecuado de la ropa limpia. Nota: En caso de requerir prendas extras avisará a la ropería para la gestión."},
        {"num":"5.8","responsable":"Médico Tratante","actividad":"Indica egreso del paciente."},
        {"num":"5.9","responsable":"Enfermería (Operativo)","actividad":"Procede hacer el retiro y clasificación de ropa sucia y/o contaminada. (IT-JE-27). Nota: la ropa contaminada no deberá depositarse en el tánico."},
        {"num":"5.10","responsable":"Intendencia","actividad":"Traslada tánico con ropa sucia correspondiente a su área al cuarto de 'ropa sucia' al contenedor temporal, cada que se encuentre al 90% de su capacidad. (PR-RO-01). Nota: el traslado de ropa al contenedor temporal se hará las veces que sean necesarias."},
        {"num":"5.11","responsable":"Intendencia","actividad":"Realiza la separación y conteo de la ropa sucia generada; ropa propia y de la empresa subrogada. (PR-RO-01)"},
        {"num":"5.12","responsable":"Operador de la Empresa Subrogada","actividad":"Genera nota de recolección y entrega al encargado de ropería."},
        {"num":"5.13","responsable":"Operador de la Empresa Subrogada","actividad":"Deposita los bultos de ropa sucia para su traslado a la empresa."},
        {"num":"5.14","responsable":"UVEH","actividad":"Supervisa que cada uno de los miembros realice sus funciones adecuadamente."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Riesgo de infecciones al paciente y al personal que manipula la ropa hospitalaria.","barrera":"Supervisión y comunicación continua por parte de los departamentos involucrados."},
        {"riesgo":"Desconocimiento y/o omisión de los procesos e instrucciones relacionados con el manejo de ropa.","barrera":"Realizar capacitación de los procesos e instrucciones que deben aplicarse."},
    ],
    "referencias": [
        {"nombre":"Proceso de recepción y almacenamiento de ropa limpia hospitalaria.","codigo":"PR-RO-02"},
        {"nombre":"Proceso de almacenamiento y transporte de ropa sucia y contaminada.","codigo":"PR-RO-01"},
        {"nombre":"Instrucción de trabajo para el abastecimiento de ropa limpia hospitalaria.","codigo":"IT-RO-01"},
        {"nombre":"Entrega y recepción de ropa hospitalaria.","codigo":"FT-RO-01"},
        {"nombre":"Instrucción de trabajo para el retiro y clasificación de ropa sucia o contaminada.","codigo":"IT-JE-27"},
        {"nombre":"Horarios y ruta de distribución de ropa.","codigo":"FT-RO-04"},
        {"nombre":"Instrucción de trabajo para desmontaje y sanitización de material y equipo al egreso de paciente de habitación.","codigo":"IT-JE-45"},
        {"nombre":"Norma oficial mexicana NOM-087-SEMARNAT-SSA1-2002 protección ambiental residuos peligrosos biológicos infecciosos, clasificación y especificación de manejo.","codigo":"NA"},
        {"nombre":"Norma oficial epidemiológica mexicana NOM-017-SSA2-1994 para la Vigilancia Epidemiológica.","codigo":"NA"},
        {"nombre":"Ley general de salud art. 17 b i a iii. art. 32, art. 52, constitución política de los estados unidos mexicanos art. 4to.","codigo":"NA"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"18/04/2022","descripcion":"Alta de documento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"08/02/2024","descripcion":"Modificación de documento","realizado":"Dr. Estebán González Díaz","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"03","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Estebán González Díaz"},
    ],
}

# ── PR-UV-22 ──────────────────────────────────────────────────────────────────
PR_UV_22 = {
    "codigo": "PR-UV-22",
    "objetivo": (
        "Implementar procesos seguros que minimicen los riesgos de infecciones asociados a la "
        "terapia de reemplazo renal con hemodiálisis."
    ),
    "alcance": (
        "Inicia cuando el departamento de enfermería ejecuta los procesos seguros y termina cuando "
        "el departamento de epidemiología supervisa el área."
    ),
    "definiciones": [],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Enfermería, Seguridad e higiene y medio ambiente, Empresa Subrogada y Epidemiología."},
        {"tipo":"Supervisión","descripcion":"Dirección Médica."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Enfermería","actividad":"El personal operativo correspondiente al área de enfermería ejecuta procesos seguros con el fin de minimizar riesgos de infección. Aplica medidas precautorias para el personal operativo en contacto con pacientes de hemodiálisis (FT-UV-05). EM1"},
        {"num":"5.2","responsable":"Enfermería","actividad":"Además aplica técnica de desinfección de la máquina de hemodiálisis (IT-JE-22) EM1"},
        {"num":"5.3","responsable":"Enfermería","actividad":"Realizar (PR-JE-02) comunicación efectiva entre los miembros del equipo de trabajo."},
        {"num":"5.4","responsable":"Enfermería","actividad":"En caso de paciente con serología positiva se cuenta con la instrucción de Trabajo Para La Atención Y Manejo De Usuario Con Serología Positiva para hepatitis B, C y VIH en Hemodiálisis (IT-JE-19). EM2"},
        {"num":"5.5","responsable":"Enfermería","actividad":"En cuestión del Manejo de accesos vasculares, se aplica la instrucción de trabajo (IT-JE-20) especifica en catéteres; en cuanto al manejo y cuidado de acceso vascular para hemodiálisis-fístula, se aplica la siguiente instrucción (IT-JE-21). EM2"},
        {"num":"5.6","responsable":"Enfermería","actividad":"En cuanto al reusó de filtros el departamento de hemodiálisis no realiza esta acción, los filtros son desechables."},
        {"num":"5.7","responsable":"Empresa Subrogada","actividad":"Toma muestra para análisis microbiológico del agua utilizada en la terapia de reemplazo renal con hemodiálisis. EM2. Apegado siempre a la Norma Oficial Mexicana NOM-092-SSA1-1994, Bienes y Servicios. Métodos para la cuenta de bacterias aerobias en placa."},
        {"num":"5.8","responsable":"Seguridad e Higiene y Medio Ambiente","actividad":"Realiza monitoreo de la calidad del agua a través de los resultados emitidos por la empresa. EM2. Nota: en caso de detectar niveles fuera de los rangos normales (>1 UFC/mL), se avisa a la empresa subrogada para realizar sanitación. Se realiza sanitización cada último domingo del mes. Supervisa que la empresa cuente con especificaciones de calidad. EM3"},
        {"num":"5.9","responsable":"Epidemiología","actividad":"Supervisión al departamento apegado a la Norma Oficial Mexicana NOM-003-SSA3-2016: Para la práctica de hemodiálisis a través del formato (FT-UV-04) EM1. En el cual se evalúa que el personal aplica las medidas precautorias correspondientes para el área: Higiene personal, Instalaciones, Evaluación RPBI, Insumos para higiene de manos."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Infecciones en los pacientes y colaboradores por mal ejecución de los procesos referentes a la atención de pacientes en el área de Hemodiálisis.","barrera":"Confirmar que personal del área de hemodiálisis cuente con conocimientos básicos, así como capacidades y aptitudes en el manejo de pacientes con hemodiálisis."},
        {"riesgo":"Intoxicación en los pacientes por mala calidad del agua.","barrera":"Supervisión continúa de los niveles permisibles de cloración de agua (<1 UFC/mL) y corrección en caso de que lo requiera."},
        {"riesgo":"Faltante de filtros desechables en el departamento.","barrera":"Se realiza requisición semanal del material (filtros desechables) para stock del departamento de hemodiálisis, para asegurar que siempre se tenga lo necesario."},
    ],
    "referencias": [
        {"nombre":"Formato de Medidas precautorias.","codigo":"FT-UV-05"},
        {"nombre":"Instrucción de trabajo de técnica de desinfección de la máquina de hemodiálisis","codigo":"IT-JE-22"},
        {"nombre":"Proceso de comunicación efectiva entre los miembros del equipo de trabajo.","codigo":"PR-JE-02"},
        {"nombre":"Instrucción de trabajo manejo de paciente con serología positiva en hemodiálisis.","codigo":"IT-JE-19"},
        {"nombre":"Instrucción de trabajo manejo y cuidado de acceso vascular para hemodiálisis-catéter.","codigo":"IT-JE-20"},
        {"nombre":"Instrucción de trabajo Manejo y cuidado de acceso vascular para hemodiálisis-fístula.","codigo":"IT-JE-21"},
        {"nombre":"Supervisión de Hemodiálisis.","codigo":"FT-UV-04"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"06/10/2025","descripcion":"Alta de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Esteban González Díaz"},
    ],
}

# ── Generador ─────────────────────────────────────────────────────────────────
DOCS = [PR_UV_18, PR_UV_19, PR_UV_20, PR_UV_21, PR_UV_22]

HEADER = """\
-- ============================================================
--  UV PR Lote 4 — PR-UV-18, 19, 20, 21, 22
--  Hospital Santa Margarita · SGC ISO 9001:2015
-- ============================================================
"""

def build(doc):
    code  = doc['codigo']
    alc   = esc(doc['alcance'])
    obj   = esc(doc['objetivo'])
    des   = esc(j(doc['desarrollo']))
    gr    = esc(j(doc['gestion_riesgos']))
    refs  = esc(j(doc['referencias']))
    cc    = esc(j(doc['control_cambios']))
    defs  = esc(j(doc['definiciones']))
    resps = esc(j(doc['responsabilidades']))
    return f"""
-- {code}
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = '{code}'),
  '{alc}',
  '{obj}',
  '[]'::jsonb,
  '{des}'::jsonb,
  '{gr}'::jsonb,
  '{refs}'::jsonb,
  '{cc}'::jsonb,
  '{defs}'::jsonb,
  '{resps}'::jsonb
ON CONFLICT (document_id) DO UPDATE SET
  alcance              = EXCLUDED.alcance,
  objetivo             = EXCLUDED.objetivo,
  material_equipo      = EXCLUDED.material_equipo,
  desarrollo           = EXCLUDED.desarrollo,
  gestion_riesgos      = EXCLUDED.gestion_riesgos,
  referencias          = EXCLUDED.referencias,
  control_cambios      = EXCLUDED.control_cambios,
  definiciones         = EXCLUDED.definiciones,
  responsabilidades    = EXCLUDED.responsabilidades;
"""

out = HEADER + '\n'.join(build(d) for d in DOCS)
pathlib.Path('uv_pr_b4.sql').write_text(out, encoding='utf-8')
print(f'PR docs lote 4: {len(DOCS)}')
for d in DOCS:
    print(f"  {d['codigo']} — {len(d['desarrollo'])} pasos")
