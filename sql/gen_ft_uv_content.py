#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Unidad de Vigilancia Epidemiológica — Formatos (FT-UV)
Genera ft_uv_full.sql
"""
import json, pathlib

def esc(s):
    return str(s).replace("'", "''") if s else ''

def j(obj):
    return json.dumps(obj, ensure_ascii=False)

# ── Autorizaciones ────────────────────────────────────────────────
# Constantes del departamento UV (mismo patrón que gen_uv_docs.py)
_EA  = "Dr. Esteban González Díaz"
_ECA = "Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)"
_RA  = "Dra. Giselle Ivette De la Torre García"
_RCA = "Jefatura de Calidad"

# Autorizó pre-sep-2023
_AA_OLD  = "Hna. María de Jesús García Castro"
_ACA_OLD = "Dirección General"

# Autorizó sep-2023 en adelante
_AA_NEW  = "Dr. José Gonzalo Vázquez Camacho"
_ACA_NEW = "Dirección Médica"

def _meta(code, name, ver, dt, aa, ac, status="en_revision"):
    return {"code": code, "name": name, "type_prefix": "FT", "dept_code": "UV",
            "version": ver, "status": status,
            "custodian": "Jefatura de UVEH",
            "issue_date": dt,
            "elab_nombre": _EA,  "elab_cargo": _ECA,
            "rev_nombre":  _RA,  "rev_cargo":  _RCA,
            "aut_nombre":  aa,   "aut_cargo":  ac}

# Alias cortos
OLD = (_AA_OLD, _ACA_OLD)
NEW = (_AA_NEW, _ACA_NEW)

DOCS_META = [
    # ── Era 2023-01 (autorizó: Hna. María de Jesús) ───────────────
    _meta("FT-UV-01","Seguimiento de Pacientes y Habitaciones",
          "03","2023-01-04", *OLD),
    _meta("FT-UV-02","Supervisión de RPBI",
          "02","2023-01-23", *OLD),
    _meta("FT-UV-03","Supervisión Cocina y Cafetería",
          "02","2023-01-23", *OLD),
    _meta("FT-UV-04","Supervisión de Hemodiálisis",
          "02","2023-01-23", *OLD),
    _meta("FT-UV-10","Bitácora de Supervisión de Laboratorio",
          "02","2023-01-04", *OLD),
    # Nota: el PDF de FT-UV-11 tiene código FT-UV-12 por error tipográfico;
    # el contenido corresponde a la Encuesta de Accidentes Laborales.
    _meta("FT-UV-11","Encuesta de Accidentes Laborales por Riesgos Biológicos",
          "02","2023-01-23", *OLD),
    _meta("FT-UV-12","Evaluación de Higiene de Manos",
          "02","2023-01-23", *OLD),
    _meta("FT-UV-21","Enfermedades Infectocontagiosas",
          "01","2023-01-04", *OLD),
    _meta("FT-UV-22","Supervisión de Centrales y Áreas",
          "01","2023-01-04", *OLD),
    # ── Era 2023-03 ───────────────────────────────────────────────
    _meta("FT-UV-05","Medidas Precautorias",
          "01","2023-03-27", *OLD),
    # ── Era 2023-09 (autorizó: Dr. José Gonzalo) ──────────────────
    _meta("FT-UV-13","Bitácora de Laboratorio de Control de Calidad de Habitaciones y/o Cubículos",
          "02","2023-09-08", *NEW),
    _meta("FT-UV-14","Bitácora de Supervisión Banco de Sangre",
          "02","2023-09-08", *NEW),
    _meta("FT-UV-17","Supervisión Rayos X",
          "02","2023-09-08", *NEW),
    # ── Era 2024-02 ───────────────────────────────────────────────
    _meta("FT-UV-16","Vale de Control para la Preparación de Habitaciones y/o Cubículos",
          "03","2024-02-08", *NEW),
    _meta("FT-UV-20","Supervisión de Higiene Personal de Intendencia",
          "02","2024-02-09", *NEW),
]

# ── Descripciones ─────────────────────────────────────────────────
_DESC = {
    "FT-UV-01": "Formato de seguimiento de pacientes y habitaciones con verificación de aislamientos, medidas precautorias, equipo de bioseguridad y restricción de personas al área.",
    "FT-UV-02": "Formato de supervisión del manejo de Residuos Peligrosos Biológicos Infecciosos (RPBI): ruta, contenedores, bitácora por área y cumplimiento de porcentaje de llenado.",
    "FT-UV-03": "Formato de supervisión de cocina y cafetería: temperaturas, niveles de cloro residual libre, mantenimiento de equipos, limpieza de instalaciones y refrigeradores.",
    "FT-UV-04": "Formato de supervisión del área de hemodiálisis: clasificación de contenedores, insumos para higiene de manos (jabón, toallas desechables, gel antibacterial) y observaciones.",
    "FT-UV-05": "Tabla de medidas precautorias por tipo de aislamiento (contacto, gotículas, aéreo, protector) con listado de enfermedades infectocontagiosas aplicables.",
    "FT-UV-10": "Bitácora de supervisión de laboratorio con verificación de temperatura, limpieza, higiene personal (uñas, cabello recogido) y firma del supervisor.",
    "FT-UV-11": "Encuesta de accidentes laborales por riesgos biológicos: fecha del accidente, datos del trabajador, tipo de accidente, seguimiento de laboratorio y derivación.",
    "FT-UV-12": "Formato de evaluación de la técnica de higiene de manos del personal, con verificación de efectividad y registro de pasos omitidos.",
    "FT-UV-13": "Bitácora de laboratorio para el control de calidad de habitaciones y/o cubículos con registro de resultados a 72 horas y resultado final, con notificación a UVEH.",
    "FT-UV-14": "Formato de supervisión del banco de sangre: almacenamiento de instrumentos, equipos de refrigeración con termómetros, firma del supervisor y turno.",
    "FT-UV-16": "Vale de control para la preparación de habitaciones y/o cubículos con datos del paciente, admisión, firmas de UVEH e intendencia, y registro de recepción.",
    "FT-UV-17": "Formato de supervisión del área de Rayos X: uso de equipo de protección, limpieza de baños, almacenamiento del equipo de intendencia y estado de los equipos.",
    "FT-UV-20": "Formato de supervisión de higiene personal del personal de intendencia: uniforme, limpieza, turno, cubrebocas, calzado y criterios de evaluación por colaboradora.",
    "FT-UV-21": "Tabla de enfermedades infectocontagiosas de notificación y seguimiento epidemiológico en el hospital.",
    "FT-UV-22": "Formato de supervisión de centrales y áreas del hospital con verificación de condiciones de limpieza, seguridad e higiene.",
}

# ── Contenidos ────────────────────────────────────────────────────
DOCS_CONTENT = []
for m in DOCS_META:
    code = m['code']
    DOCS_CONTENT.append({
        "codigo": code,
        "alcance": _DESC[code],
        "objetivo": _DESC[code],
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
HEADER = """\
-- ============================================================
--  Unidad de Vigilancia Epidemiológica — Formatos FT-UV
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

-- Asegurarse que el departamento UV exista
INSERT INTO departments (code, name, is_active)
VALUES ('UV', 'Unidad de Vigilancia Epidemiológica Hospitalaria', true)
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
WHERE dp.code = 'UV' AND dt.code_prefix = 'FT'
ORDER BY d.code;
"""

out = pathlib.Path(__file__).parent / 'ft_uv_full.sql'
out.write_text(sql, encoding='utf-8')
print(f"ft_uv_full.sql generado: {len(sql):,} bytes")
print(f"Documentos: {len(DOCS_META)}")
for m in DOCS_META:
    print(f"  {m['code']}  v{m['version']}  {m['issue_date']}  [{m['status']}]")
