#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Lote 5 — PR-UV-23, 24, 25
Genera uv_pr_b5.sql
"""
import json, pathlib

def esc(s):
    return str(s).replace("'", "''") if s else ''

def j(obj):
    return json.dumps(obj, ensure_ascii=False)

# ── PR-UV-23 ──────────────────────────────────────────────────────────────────
PR_UV_23 = {
    "codigo": "PR-UV-23",
    "objetivo": (
        "Detectar enfermedades respiratorias (COVID e Influenza tipo A), con el fin de interrumpir "
        "la cadena de transmisión y prevenir el contagio entre los pacientes, y el personal hospitalario."
    ),
    "alcance": (
        "Este procedimiento inicia cuando la admisión recibe al paciente y termina cuando se asigna "
        "la habitación más adecuada (Aislada y/o Semi-aislada)."
    ),
    "definiciones": [],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Admisión Hospitalaria, supervisión de enfermería, médicos de guardia, médico tratante, dirección Médica y UVEH."},
        {"tipo":"Supervisión","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Admisión (Hospitalización y/o Urgencias)","actividad":"Realiza el ingreso de pacientes de acuerdo al proceso PR-CS-01 y PR-CS-02."},
        {"num":"5.2","responsable":"Admisión (Hospitalización y/o Urgencias)","actividad":"Identifica a través de las indicaciones médicas que es una enfermedad respiratoria. Nota: En caso de que el paciente sea identificado por el área de urgencias y requiera hospitalización, el médico urgenciólogo deberá comentarles que es necesario la toma de pruebas de antígeno para 'Influenza y COVID' para poder ser hospitalizado."},
        {"num":"5.3","responsable":"Admisión (Hospitalización y/o Urgencias)","actividad":"Notifica de manera telefónica a supervisión de enfermería."},
        {"num":"5.4","responsable":"Supervisión de Enfermería","actividad":"Explica detalladamente el 'protocolo de enfermedades respiratorias para Influenza tipo A y COVID'. Nota: Si el paciente, familiares y/o médico tratante muestra renuencia al protocolo; favor de notificar a Dirección Médica, para que pueda solucionar el problema."},
        {"num":"5.5","responsable":"Admisión (Hospitalización y/o Urgencias)","actividad":"Solicita al área de Laboratorio la toma de muestra de Antígeno (COVID e influenza). Nota: El cubículo asignado será en URGENCIAS, de 'enfermedades respiratorias'. (Detrás de las cortinas)."},
        {"num":"5.6","responsable":"Laboratorio","actividad":"Toma la muestra de antígeno y explica la duración de tiempo para emitir el resultado. (20 a 30 minutos)."},
        {"num":"5.7","responsable":"Laboratorio","actividad":"Notifica el resultado de las pruebas al área de admisión y/o urgencias."},
        {"num":"5.8","responsable":"Supervisión de Enfermería","actividad":"Si el resultado de la muestra es POSITIVO a 'COVID y/o Influenza tipo A', se ofrecerán las habitaciones aisladas. Si el resultado es NEGATIVO se asignará habitación semi-aislada en piso."},
        {"num":"5.9","responsable":"Médico de Guardia","actividad":"Notifica al médico tratante que por 'protocolo del hospital' la toma de pruebas de Antígeno para Influenza y COVID son OBLIGATORIAS. Nota: Se aislará el paciente con medida precautoria (vía aérea) y se tomará la prueba en la habitación. Si el médico tratante muestra renuencia al proceso, favor de notificar a dirección médica, para que solucione el problema."},
        {"num":"5.10","responsable":"Médico de Guardia","actividad":"Si el resultado de la muestra es POSITIVO a 'COVID y/o Influenza tipo A', se indica al médico tratante que el paciente deberá cambiarse a una habitación aislada. Si el resultado es NEGATIVO se evalúa en conjunto Epidemiología, supervisión de enfermería y coordinador de médicos de guardia, si se puede mantener en esa habitación con su medida precautoria o si requiere movimiento a una habitación Semi-aislada."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Renuencia de Médicos tratantes y familiares de aceptar el protocolo.","barrera":"Respaldo de dirección médica y dirección general para que se cumpla lo establecido."},
        {"riesgo":"No respetar el aislamiento de vía aérea.","barrera":"Supervisión de que se lleve a cabo la medida precautoria."},
        {"riesgo":"Brotes de enfermedad respiratoria en pacientes y colaboradores.","barrera":"Supervisión del protocolo establecido."},
    ],
    "referencias": [
        {"nombre":"Instrucción de trabajo para la higiene de manos con agua y jabón.","codigo":"IT-UV-01"},
        {"nombre":"Instrucción de trabajo para la higiene de manos con gel alcoholado.","codigo":"IT-UV-04"},
        {"nombre":"Medidas precautorias","codigo":"FT-UV-05"},
        {"nombre":"Supervisión de las medidas precautorias","codigo":"IT-UV-18"},
        {"nombre":"Precauciones aéreas por microgotas","codigo":"IT-UV-09"},
        {"nombre":"Colocación correcta de bata","codigo":"IT-UV-05"},
        {"nombre":"Colocación correcta del cubrebocas","codigo":"IT-UV-06"},
        {"nombre":"Proceso para el abastecimiento de insumos para la higiene de manos","codigo":"PR-UV-01"},
        {"nombre":"Proceso para el ingreso de pacientes a hospitalización","codigo":"PR-CS-01"},
        {"nombre":"Proceso para el ingreso de pacientes a urgencias","codigo":"PR-CS-02"},
        {"nombre":"Norma oficial mexicana nom-045-ssa2-2015, para la vigilancia epidemiológica, prevención y control de las infecciones nosocomiales.","codigo":"NA"},
        {"nombre":"Norma oficial mexicana nom-017-ssa2-2012, para la vigilancia epidemiológica.","codigo":"NA"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"25/03/2024","descripcion":"Alta de documento","realizado":"Dr. Esteban González Díaz","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Esteban González Díaz"},
    ],
}

# ── PR-UV-24 ──────────────────────────────────────────────────────────────────
PR_UV_24 = {
    "codigo": "PR-UV-24",
    "objetivo": (
        "Identificar la presencia de la bacteria Vibrio Cholerae, a través de análisis de agua "
        "residual y/o Potable, con la finalidad de asegurar la calidad de agua."
    ),
    "alcance": (
        "Este proceso empieza cuando la empresa subrogada toma la muestra (Residual y/o Potable) "
        "y termina cuando el departamento recibe el resultado de la muestra."
    ),
    "definiciones": [],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Empresa Subrogada y UVEH."},
        {"tipo":"Supervisión","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"UVEH","actividad":"Solicitar con la empresa subrogada el tipo de muestreo (Residual y/o Potable)."},
        {"num":"5.2","responsable":"Empresa Subrogada","actividad":"Llega personal de empresa subrogada a la puerta principal, se presenta y pregunta por el departamento de epidemiología."},
        {"num":"5.3","responsable":"UVEH","actividad":"Corrobora con el personal de la empresa, el tipo de muestreo e indica de qué área se tomará la muestra."},
        {"num":"5.4","responsable":"Empresa Subrogada","actividad":"Revisa el material que va a utilizar para tomar la muestra (Cubrebocas, Guantes y Frascos)."},
        {"num":"5.5","responsable":"Empresa Subrogada","actividad":"Realiza toma de muestra. 1. Agua potable: Limpia la boquilla de llave de lavabo y deja correr el agua de la llave por 1 minuto. Toma suficiente agua en sus frascos estériles. 2. Agua residual: Se pide apoyo de mantenimiento para quitar tapa de registro. Y con ayuda de un mango muestreador de plástico se toma la muestra de agua."},
        {"num":"5.6","responsable":"Empresa Subrogada","actividad":"Llena bitácora de registro y solicita al personal supervisor (UVEH) que firme la orden de trabajo."},
        {"num":"5.7","responsable":"Empresa Subrogada","actividad":"En un lapso de 15 días hábiles se envían los resultados de las muestras tomadas."},
        {"num":"5.8","responsable":"UVEH","actividad":"Analiza los resultados enviados por la empresa y captura los datos. NOTA: Si el resultado es positivo notificar de manera inmediata a la autoridad sanitaria de su jurisdicción para realizar acciones de saneamiento."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Exposición por presencia de la bacteria Vibrio Cholerae en agua potable y/o residual.","barrera":"Monitoreo cloración de agua y calidad de agua de manera frecuente."},
        {"riesgo":"Muestra inadecuada y/o contaminada.","barrera":"Toma de muestra con empresa reconocida y personal capacitado y con equipo de protección."},
    ],
    "referencias": [
        {"nombre":"Solicitud a Análisis del Centro Estatal de Laboratorios.","codigo":"NA"},
        {"nombre":"NORMA Oficial Mexicana NOM-016-SSA2-2012, Para la vigilancia, prevención, control, manejo y tratamiento del cólera.","codigo":"NA"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"11/07/2024","descripcion":"Alta de documento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Esteban González Díaz"},
    ],
}

# ── PR-UV-25 ──────────────────────────────────────────────────────────────────
PR_UV_25 = {
    "codigo": "PR-UV-25",
    "objetivo": (
        "Cuidar la inocuidad de los alimentos destinados a los pacientes del hospital tomando una "
        "muestra de alimentos para control de higiene y verificar que estos sean inocuos."
    ),
    "alcance": (
        "El proceso inicia cuando se les realizan las solicitudes de toma de muestras de alimentos "
        "a UVEH y administración y termina cuando se entregan los resultados a UVEH y estos son satisfactorios."
    ),
    "definiciones": [],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Empresa Subrogada y UVEH."},
        {"tipo":"Supervisión","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Encargado de Cocina","actividad":"Solicita a UVEH y a administración la toma de muestras a alimentos para análisis bacteriológico en laboratorio de alimentos externo."},
        {"num":"5.2","responsable":"Administración","actividad":"Autorización solicitud para toma de muestras anuales."},
        {"num":"5.3","responsable":"UVEH","actividad":"Programa cita con laboratorio de alimentos externo para que acudan a tomar muestras a alimentos."},
        {"num":"5.4","responsable":"Laboratorio Subrogado","actividad":"Acude a toma de muestra de alimentos y otorga los resultados al encargado de cocina."},
        {"num":"5.5","responsable":"UVEH","actividad":"Recibe los resultados y los entrega al encargado de cocina. Nota: En caso de no ser adecuados fórmula junto con encargado de cocina las estrategias correspondientes para atender esta situación. En caso de obtener resultados satisfactorios se guardan en expediente interno del área de cocina."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Contaminación de alimentos por malas prácticas de higiene.","barrera":"Capacitación constante en manejo de alimentos."},
        {"riesgo":"Muestra inadecuada y/o contaminada.","barrera":"Toma de muestra con empresa reconocida y personal capacitado y con equipo de protección."},
    ],
    "referencias": [
        {"nombre":"Norma oficial mexicana nom-251-ssa1-2009, prácticas de higiene para el proceso de alimentos, bebidas o suplementos alimenticios.","codigo":"NA"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"26/09/2025","descripcion":"Alta de documento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Esteban González Díaz"},
    ],
}

# ── Generador + combinar todos los lotes ─────────────────────────────────────
DOCS = [PR_UV_23, PR_UV_24, PR_UV_25]

HEADER_B5 = """\
-- ============================================================
--  UV PR Lote 5 — PR-UV-23, 24, 25
--  Hospital Santa Margarita · SGC ISO 9001:2015
-- ============================================================
"""

HEADER_FULL = """\
-- ============================================================
--  UV PR — Contenido completo de 23 procedimientos PR-UV
--  Hospital Santa Margarita · SGC ISO 9001:2015
--  Ejecutar DESPUÉS de uv_docs.sql y uv_it_content.sql
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

# Lote 5
b5 = HEADER_B5 + '\n'.join(build(d) for d in DOCS)
pathlib.Path('uv_pr_b5.sql').write_text(b5, encoding='utf-8')

# Archivo combinado completo
lotes = ['uv_pr_b1.sql','uv_pr_b2.sql','uv_pr_b3.sql','uv_pr_b4.sql']
combined = HEADER_FULL
for fname in lotes:
    p = pathlib.Path(fname)
    if p.exists():
        # omitir cabecera de cada lote (primeras 5 líneas)
        content = '\n'.join(p.read_text(encoding='utf-8').splitlines()[5:])
        combined += content
combined += '\n'.join(build(d) for d in DOCS)
pathlib.Path('uv_pr_content.sql').write_text(combined, encoding='utf-8')

total = sum(
    len(d['desarrollo'])
    for fname in lotes
    for d in []  # solo contar lote 5 aquí
) + sum(len(d['desarrollo']) for d in DOCS)

print(f'Lote 5: {len(DOCS)} docs')
for d in DOCS:
    print(f"  {d['codigo']} — {len(d['desarrollo'])} pasos")
print(f'\nuv_pr_content.sql generado: {pathlib.Path("uv_pr_content.sql").stat().st_size // 1024} KB')
