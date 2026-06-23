#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Seguridad, Higiene y Medio Ambiente — IT, MA, PR (34 documentos)
Genera sg_full.sql
"""
import json, pathlib

def esc(s):
    return str(s).replace("'", "''") if s else ''

def j(obj):
    return json.dumps(obj, ensure_ascii=False)

# ── Autorizaciones ────────────────────────────────────────────────
# Set A: standard — Alizbeydi elabora, Rosa Isela revisa, María Elena autoriza
_EA  = "I.A. Alizbeydi Vázquez Serafín";  _ECA = "Jefatura de Seguridad, Higiene y Medio Ambiente"
_RA  = "Lic. Rosa Isela López Astorga";   _RCA = "Dirección Administrativa"
_AA  = "Lic. María Elena Martínez Alvarado"; _ACA = "Dirección General"

# Set B: Viviana elabora, Alizbeydi revisa, Rosa Isela autoriza
_EB  = "Lic. Viviana Janeth Langarica Leal"; _ECB = "Analista de Seguridad e Higiene y Medio Ambiente"
_RB  = "I.A. Alizbeydi Vázquez Serafín";    _RCB = "Jefatura de Seguridad e Higiene y Medio Ambiente"
_AB  = "Rosa Isela Lopez Astorga";           _ACB = "Dirección Administrativa"

# Set C: Alizbeydi elabora, Ana Cecilia revisa, María Elena autoriza (Dirección Administrativa)
_EC  = "Jefatura de Seguridad e Higiene y Medio Ambiente"
_RC2 = "Mtra. Ana Cecilia Zárate";          _RCC2 = "Jefatura de Calidad"
_AC2 = "Lic. Ma. Elena Martínez Alvarado"; _ACC2 = "Dirección Administrativa"

# Set D: Alizbeydi elabora, María Elena revisa, Ana Cecilia autoriza
_RD  = "Lic. Ma. Elena Martínez Alvarado"; _RCD = "Dirección Administrativa"
_AD  = "Mtra. Ana Cecilia Zárate";          _ACD = "Jefatura de Calidad"

# Set E: Alizbeydi como analista elabora, María Elena revisa, Ana Cecilia autoriza (IT-SG-22)
_EE  = "L.A. Alizbeydi Vázquez Serafín";   _ECE = "Analista de Seguridad Higiene y Medio Ambiente"

# Set F: Alizbeydi elabora, Dr. González revisa, María Elena autoriza (PR-SG-23)
_RF  = "Dr. José Gonzalo Vázquez Camacho"; _RCF = "Dirección Médica"
_AF  = "Lic. María Elena Martínez Alvarado"; _ACF = "Dirección Administrativa"

# Set G: Alizbeydi elabora, Dr. González revisa, María de Jesús autoriza (PR-SG-24)
_AG  = "María de Jesús Gómez Flores";      _ACG = "Dirección Administrativa"

dept_code = "SG"
dept_name = "Seguridad, Higiene y Medio Ambiente"

def _meta(code, name, type_prefix, ver, dt, en, ec, rn, rc, an, ac):
    return {
        "code": code, "name": name,
        "type_prefix": type_prefix,
        "dept_code": dept_code,
        "version": ver,
        "status": "en_revision",
        "custodian": "Jefatura de Seguridad, Higiene y Medio Ambiente",
        "issue_date": dt,
        "elab_nombre": en, "elab_cargo": ec,
        "rev_nombre":  rn, "rev_cargo":  rc,
        "aut_nombre":  an, "aut_cargo":  ac,
    }

DOCS_META = [
    # ── IT ───────────────────────────────────────────────────────────
    _meta("IT-SG-15", "Instrucción de Trabajo para el Traslado de Bebés",
          "IT", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("IT-SG-16", "Instrucción de Trabajo para Acceso a Visitantes",
          "IT", "v02", "2024-05-31", _EA, _EC,  _RC2, _RCC2, _AC2, _ACC2),
    _meta("IT-SG-17", "Instrucción de Trabajo para el Control de Ingreso y Egreso de Pacientes Hospitalizados",
          "IT", "v02", "2024-07-17", _EA, _EC,  _RD,  _RCD,  _AD,  _ACD),
    _meta("IT-SG-18", "Instrucción de Trabajo para Nebulización de Habitaciones y/o Cubículos",
          "IT", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("IT-SG-19", "Instrucción de Trabajo para el Acceso a Urgencias",
          "IT", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("IT-SG-20", "Instrucción de Trabajo en Caso de Extravío de Pertenencias",
          "IT", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("IT-SG-21", "Instrucción de Trabajo para Realizar Rondines de Vigilancia",
          "IT", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    # IT-SG-22: Alizbeydi como analista, María Elena revisa, Ana Cecilia autoriza
    _meta("IT-SG-22", "Instrucción de Trabajo para el Monitoreo de Niveles de Cloro en Agua",
          "IT", "v02", "2024-07-30",
          _EE,  _ECE,
          "Lic. María Elena Martínez Alvarado", "Dirección Administrativa",
          "Mtra. Ana Cecilia Zárate Bautista",  "Jefatura de Calidad"),
    _meta("IT-SG-23", "Instrucción de Trabajo para la Atención de Contingencias de Residuos Peligrosos Biológicos Infecciosos",
          "IT", "v01", "2022-08-17", _EA, _ECA, _RA, _RCA, _AA, _ACA),
    _meta("IT-SG-24", "Instrucción de Trabajo para Supervisión de Áreas",
          "IT", "v01", "2023-04-28", _EA, _ECA, _RA, _RCA, _AA, _ACA),
    # ── MA ───────────────────────────────────────────────────────────
    _meta("MA-SG-01", "Manual de Residuos Peligrosos Biológicos Infecciosos",
          "MA", "v01", "2022-12-07", _EA, _ECA, _RA, _RCA, _AA, _ACA),
    # ── PR ───────────────────────────────────────────────────────────
    _meta("PR-SG-01", "Proceso en Caso de Persona Violenta",
          "PR", "v01", "2023-02-24", _EA, _ECA, _RA, _RCA, _AA, _ACA),
    _meta("PR-SG-02", "Proceso para el Acceso a Proveedores y/o Representantes Comerciales",
          "PR", "v02", "2024-05-31", _EA, _EC,  _RC2, _RCC2, _AC2, _ACC2),
    _meta("PR-SG-03", "Proceso de Control de Ingreso y Egreso del Personal",
          "PR", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("PR-SG-04", "Proceso de Mantenimiento Correctivo en Equipos o Infraestructura",
          "PR", "v01", "2022-08-17", _EA, _ECA, _RA, _RCA, _AA, _ACA),
    _meta("PR-SG-05", "Proceso de Mantenimiento Preventivo",
          "PR", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("PR-SG-06", "Proceso para Manipulación, Almacenamiento y Trasvase de Productos Químicos",
          "PR", "v02", "2023-04-28", _EA, _ECA, _RA, _RCA, _AA, _ACA),
    _meta("PR-SG-07", "Proceso de Recolección Interna de RPBI",
          "PR", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("PR-SG-08", "Proceso para la Regulación de los Niveles de Cloro en el Agua",
          "PR", "v02", "2023-04-28", _EA, _ECA, _RA, _RCA, _AA, _ACA),
    _meta("PR-SG-09", "Proceso para el Mantenimiento Preventivo Anual de Instalaciones, Inmuebles y Equipos del Hospital",
          "PR", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("PR-SG-10", "Proceso de Revisión de Detectores de Humo",
          "PR", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("PR-SG-11", "Procedimiento para la Revisión de Servicios Básicos",
          "PR", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("PR-SG-12", "Proceso para Revisión de Habitaciones",
          "PR", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("PR-SG-13", "Proceso para la Identificación de Sustancias Químicas Peligrosas",
          "PR", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("PR-SG-14", "Proceso de Recolección Externa de Residuos Peligrosos",
          "PR", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("PR-SG-15", "Proceso de Mantenimiento Preventivo Externo de Equipos o Instalaciones",
          "PR", "v01", "2023-02-28", _EA, _ECA, _RA, _RCA, _AA, _ACA),
    _meta("PR-SG-16", "Proceso para Supervisión en Construcción y Remodelación",
          "PR", "v03", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    # PR-SG-17: Set D variant with Ana Cecilia autorizó
    _meta("PR-SG-17", "Proceso de Coordinación con Empresas Subrogadas para Realizar Servicios Externos",
          "PR", "v02", "2024-07-24",
          _EA,  _EC,
          _RD,  _RCD,
          "Mtra. Ana Cecilia Zárate Bautista", "Jefatura de Calidad"),
    _meta("PR-SG-19", "Proceso para el Traslado de Pacientes con COVID",
          "PR", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("PR-SG-20", "Proceso para la Coordinación de Fumigación y Control de Plagas",
          "PR", "v02", "2024-02-12", _EB, _ECB, _RB, _RCB, _AB, _ACB),
    _meta("PR-SG-21", "Monitoreo de los Niveles de Cloro en Agua Potable",
          "PR", "v21", "2023-02-24", _EA, _ECA, _RA, _RCA, _AA, _ACA),
    _meta("PR-SG-22", "Proceso de Actuación en Caso de Falla de Energía Eléctrica",
          "PR", "v01", "2023-01-20", _EA, _ECA, _RA, _RCA, _AA, _ACA),
    # PR-SG-23: Set F
    _meta("PR-SG-23", "Proceso para el Ingreso a Infantes o Familiares en Habitaciones",
          "PR", "v01", "2024-05-27",
          _EA, _EC, _RF, _RCF, _AF, _ACF),
    # PR-SG-24: Set G
    _meta("PR-SG-24", "Proceso para la Selección y Evaluación de Prestador de Servicios",
          "PR", "v01", "2024-09-30",
          _EA, _EC, _RF, _RCF, _AG, _ACG),
]

# ── Descripciones breves ──────────────────────────────────────────
_DESC = {
    "IT-SG-15": "Instrucción para el traslado seguro de bebés dentro de las instalaciones del hospital, estableciendo responsabilidades, verificaciones y registros necesarios para garantizar la seguridad del neonato.",
    "IT-SG-16": "Instrucción para controlar y registrar el acceso de visitantes a las instalaciones del hospital, incluyendo verificación de identidad, horarios permitidos y áreas autorizadas.",
    "IT-SG-17": "Instrucción para el control del ingreso y egreso de pacientes hospitalizados, garantizando la trazabilidad y seguridad de cada movimiento dentro del hospital.",
    "IT-SG-18": "Instrucción para la nebulización de habitaciones y/o cubículos, especificando los productos autorizados, diluciones, equipos a utilizar y medidas de protección personal.",
    "IT-SG-19": "Instrucción para regular el acceso al área de urgencias, estableciendo los criterios de ingreso para pacientes, acompañantes y visitantes según el protocolo del hospital.",
    "IT-SG-20": "Instrucción para la atención de reportes de extravío de pertenencias de pacientes o visitantes, estableciendo el flujo de notificación, búsqueda y resguardo de objetos.",
    "IT-SG-21": "Instrucción para realizar rondines de vigilancia en las instalaciones del hospital, definiendo rutas, frecuencias, puntos de control y registro de incidencias.",
    "IT-SG-22": "Instrucción para el monitoreo periódico de los niveles de cloro en el agua de las instalaciones del hospital, estableciendo frecuencias de medición, valores de referencia y acciones correctivas.",
    "IT-SG-23": "Instrucción para la atención de contingencias relacionadas con residuos peligrosos biológico-infecciosos, incluyendo derrames, exposiciones accidentales y situaciones de riesgo.",
    "IT-SG-24": "Instrucción para la supervisión periódica de áreas del hospital por parte de seguridad e higiene, verificando condiciones de orden, limpieza, seguridad y cumplimiento normativo.",
    "MA-SG-01": "Manual que establece los lineamientos, responsabilidades y procedimientos para el manejo integral de residuos peligrosos biológico-infecciosos (RPBI) conforme a la normatividad vigente (NOM-087-ECOL-SSA1-2002).",
    "PR-SG-01": "Proceso de actuación del personal de seguridad ante la presencia de personas violentas dentro de las instalaciones del hospital, incluyendo protocolo de contención, notificación y registro.",
    "PR-SG-02": "Proceso para regular el acceso de proveedores y/o representantes comerciales a las instalaciones del hospital, incluyendo registro, identificación, acompañamiento y control de áreas restringidas.",
    "PR-SG-03": "Proceso para el control del ingreso y egreso del personal del hospital, garantizando el registro de entradas y salidas, y la detección de accesos no autorizados.",
    "PR-SG-04": "Proceso para la atención de mantenimiento correctivo en equipos o infraestructura del hospital, desde la detección de fallas hasta la verificación de la reparación y cierre de reporte.",
    "PR-SG-05": "Proceso para la planeación y ejecución del mantenimiento preventivo de equipos e instalaciones del hospital, con programación anual, seguimiento y registro de actividades realizadas.",
    "PR-SG-06": "Proceso para la manipulación, almacenamiento y trasvase de productos químicos utilizados en el hospital, estableciendo condiciones de seguridad, EPP requerido y manejo de derrames.",
    "PR-SG-07": "Proceso de recolección interna de residuos peligrosos biológico-infecciosos (RPBI) en las diferentes áreas del hospital, con rutas establecidas, recipientes autorizados y frecuencias definidas.",
    "PR-SG-08": "Proceso para la regulación y ajuste de los niveles de cloro en el agua de las instalaciones del hospital, asegurando valores dentro del rango normativo para agua potable.",
    "PR-SG-09": "Proceso para el mantenimiento preventivo anual de instalaciones, inmuebles y equipos del hospital, incluyendo programación, contratación de servicios externos y verificación de resultados.",
    "PR-SG-10": "Proceso de revisión periódica de detectores de humo instalados en las instalaciones del hospital, verificando su correcto funcionamiento, estado físico y registro de inspecciones.",
    "PR-SG-11": "Procedimiento para la revisión y verificación del estado de los servicios básicos del hospital (agua, electricidad, gas, etc.), con registro de lecturas, anomalías y acciones correctivas.",
    "PR-SG-12": "Proceso para la revisión de habitaciones del hospital, verificando condiciones de seguridad, higiene, funcionamiento de equipos y mobiliario antes de la asignación a un nuevo paciente.",
    "PR-SG-13": "Proceso para la identificación y etiquetado de sustancias químicas peligrosas en el hospital, incluyendo inventario, hojas de seguridad (MSDS/HDS) y señalización de almacenes.",
    "PR-SG-14": "Proceso de recolección externa de residuos peligrosos del hospital por empresa autorizada, incluyendo programación, manifiestos de entrega, pesaje y resguardo de documentación.",
    "PR-SG-15": "Proceso para la contratación y supervisión del mantenimiento preventivo externo de equipos o instalaciones del hospital, incluyendo solicitud de cotizaciones, orden de servicio y validación de trabajos.",
    "PR-SG-16": "Proceso para la supervisión de obras de construcción y remodelación dentro del hospital, garantizando el cumplimiento de medidas de seguridad, señalización y protección a pacientes y personal.",
    "PR-SG-17": "Proceso de coordinación con empresas subrogadas para la realización de servicios externos en el hospital, estableciendo los criterios de selección, contratación, seguimiento y evaluación de desempeño.",
    "PR-SG-19": "Proceso para el traslado seguro de pacientes con COVID-19 dentro o desde las instalaciones del hospital, con medidas de aislamiento, EPP y protocolos de descontaminación.",
    "PR-SG-20": "Proceso para la coordinación de fumigación y control de plagas en las instalaciones del hospital, incluyendo programación, selección de empresa, supervisión de actividades y registro de evidencias.",
    "PR-SG-21": "Proceso de monitoreo sistemático de los niveles de cloro en el agua potable de las instalaciones del hospital, con registros de medición, valores de referencia y acciones ante desviaciones.",
    "PR-SG-22": "Proceso de actuación del hospital ante una falla de energía eléctrica, estableciendo la activación del sistema de respaldo, notificaciones, responsabilidades y registro del evento.",
    "PR-SG-23": "Proceso para autorizar y controlar el ingreso de infantes o familiares a las habitaciones del hospital, estableciendo los criterios de edad, condición clínica del paciente y horarios permitidos.",
    "PR-SG-24": "Proceso para la selección y evaluación de prestadores de servicios externos del hospital, incluyendo criterios de calificación, documentación requerida, evaluación de desempeño y registro de proveedores.",
}

# ── Contenidos ────────────────────────────────────────────────────
DOCS_CONTENT = []
for m in DOCS_META:
    code = m['code']
    desc = _DESC[code]
    DOCS_CONTENT.append({
        "codigo": code,
        "alcance": desc,
        "objetivo": desc,
        "definiciones": [],
        "responsabilidades": [],
        "material_equipo": [],
        "desarrollo": [],
        "gestion_riesgos": [],
        "referencias": [],
        "control_cambios": [],
    })

# ── Constructores SQL ─────────────────────────────────────────────
def build_doc_insert(m):
    code        = esc(m['code'])
    name        = esc(m['name'])
    tprefix     = m['type_prefix']
    dcode       = m['dept_code']
    version     = m['version']
    status      = m['status']
    custodian   = esc(m['custodian'])
    issue_date  = m['issue_date']
    elab_nombre = esc(m['elab_nombre'])
    elab_cargo  = esc(m['elab_cargo'])
    rev_nombre  = esc(m['rev_nombre'])
    rev_cargo   = esc(m['rev_cargo'])
    aut_nombre  = esc(m['aut_nombre'])
    aut_cargo   = esc(m['aut_cargo'])
    return f"""
-- {m['code']}
INSERT INTO documents (
  code, name, document_type_id, department_id,
  current_version, status, custodian_position,
  issue_date,
  elaboro_nombre, elaboro_cargo,
  reviso_nombre,  reviso_cargo,
  autorizo_nombre, autorizo_cargo)
SELECT
  '{code}', '{name}',
  (SELECT id FROM document_types WHERE code_prefix = '{tprefix}'),
  (SELECT id FROM departments     WHERE code = '{dcode}'),
  '{version}', '{status}', '{custodian}',
  '{issue_date}',
  '{elab_nombre}', '{elab_cargo}',
  '{rev_nombre}',  '{rev_cargo}',
  '{aut_nombre}',  '{aut_cargo}'
WHERE EXISTS (SELECT 1 FROM departments WHERE code = '{dcode}')
ON CONFLICT (code) DO UPDATE SET
  name              = EXCLUDED.name,
  current_version   = EXCLUDED.current_version,
  status            = EXCLUDED.status,
  custodian_position= EXCLUDED.custodian_position,
  issue_date        = EXCLUDED.issue_date,
  elaboro_nombre    = EXCLUDED.elaboro_nombre,
  elaboro_cargo     = EXCLUDED.elaboro_cargo,
  reviso_nombre     = EXCLUDED.reviso_nombre,
  reviso_cargo      = EXCLUDED.reviso_cargo,
  autorizo_nombre   = EXCLUDED.autorizo_nombre,
  autorizo_cargo    = EXCLUDED.autorizo_cargo;"""

def build_content(doc):
    code = doc['codigo']
    alc  = esc(doc['alcance'])
    obj  = esc(doc['objetivo'])
    mat  = esc(j(doc['material_equipo']))
    des  = esc(j(doc['desarrollo']))
    gr   = esc(j(doc['gestion_riesgos']))
    refs = esc(j(doc['referencias']))
    cc   = esc(j(doc['control_cambios']))
    defi = esc(j(doc['definiciones']))
    resp = esc(j(doc['responsabilidades']))
    return f"""
-- Contenido: {code}
INSERT INTO document_content (
  document_id, alcance, objetivo,
  definiciones, responsabilidades,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios)
SELECT d.id,
  '{alc}', '{obj}',
  '{defi}'::jsonb, '{resp}'::jsonb,
  '{mat}'::jsonb, '{des}'::jsonb, '{gr}'::jsonb,
  '{refs}'::jsonb, '{cc}'::jsonb
FROM documents d WHERE d.code = '{code}'
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios;"""

# ── Generar SQL ───────────────────────────────────────────────────
HEADER = f"""\
-- ============================================================
--  Seguridad, Higiene y Medio Ambiente — IT/MA/PR (34 docs)
--  Hospital Santa Margarita · SGC ISO 9001:2015
-- ============================================================

-- ── Asegurar columnas extendidas en documents ────────────────
ALTER TABLE documents ADD COLUMN IF NOT EXISTS issue_date      date;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS elaboro_nombre  text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS elaboro_cargo   text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS reviso_nombre   text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS reviso_cargo    text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS autorizo_nombre text;
ALTER TABLE documents ADD COLUMN IF NOT EXISTS autorizo_cargo  text;

-- Asegurarse que el tipo de documento Manual exista
INSERT INTO document_types (code_prefix, name, description)
VALUES ('MA', 'Manual', 'Manuales operativos y de referencia departamental')
ON CONFLICT (code_prefix) DO NOTHING;

-- Asegurarse que el departamento Seguridad, Higiene y Medio Ambiente exista
INSERT INTO departments (code, name, is_active)
VALUES ('{dept_code}', '{dept_name}', true)
ON CONFLICT (code) DO NOTHING;

-- ═══ REGISTRAR DOCUMENTOS ═══
"""

sql = HEADER
for m in DOCS_META:
    sql += build_doc_insert(m)

sql += "\n\n-- ═══ CARGAR CONTENIDO DIGITAL ═══\n"
for doc in DOCS_CONTENT:
    sql += build_content(doc)

sql += """

-- ── Verificación ─────────────────────────────────────────────
SELECT d.code, d.name, d.current_version AS ver,
       dp.code AS dept, d.status
FROM documents d
JOIN document_types dt ON dt.id = d.document_type_id
JOIN departments    dp ON dp.id = d.department_id
WHERE dp.code = 'SG'
ORDER BY d.code;
"""

out = pathlib.Path(__file__).parent / 'sg_full.sql'
out.write_text(sql, encoding='utf-8')
print(f"sg_full.sql generado: {len(sql):,} bytes")
print(f"Documentos: {len(DOCS_META)}")
for m in DOCS_META:
    print(f"  {m['code']}  {m['version']}  {m['issue_date']}  [{m['status']}]")
