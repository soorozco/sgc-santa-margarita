#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Intendencia — Formatos (FT-IN-01..12)
Genera ft_in_full.sql
"""
import json, pathlib

def esc(s):
    return str(s).replace("'", "''") if s else ''

def j(obj):
    return json.dumps(obj, ensure_ascii=False)

# ── Autorizaciones ────────────────────────────────────────────────
# Set A: documentos 2022-2023 (Alizbeydi era)
_EA  = "I.A. Alizbeydi Vázquez Serafín"
_ECA = "Jefatura de Seguridad e Higiene y Medio Ambiente"
_RA  = "Enf. Claudia Filiberta Rivera Ortega"
_RCA = "Jefatura de Intendencia"
_AA  = "Lic. Maria Elena Martínez Alvarado"
_ACA = "Dirección Administrativa"

# Set B: documentos 2024 (Rosa Isela era)
_EB  = "Lic. Rosa Isela López Astorga"
_ECB = "Dirección Administrativa"
_AB  = "Mtra. Ana Cecilia Zárate Bautista"
_ACB = "Jefatura de Calidad"

def _meta(code, name, ver, dt, en, ec, rn, rc, an, ac, status="en_revision"):
    return {"code": code, "name": name, "type_prefix": "FT", "dept_code": "IN",
            "version": ver, "status": status,
            "custodian": "Jefatura de Intendencia",
            "issue_date": dt,
            "elab_nombre": en, "elab_cargo": ec,
            "rev_nombre":  rn, "rev_cargo":  rc,
            "aut_nombre":  an, "aut_cargo":  ac}

DOCS_META = [
    # ── Era 2022 ──────────────────────────────────────────────────
    _meta("FT-IN-10","Bitácora de Limpieza de Áreas",
          "01","2022-08-01", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    # ── Era 2023 ──────────────────────────────────────────────────
    _meta("FT-IN-01","Bitácora de Aseo Baños de Quirógrafo",
          "02","2023-01-09", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    _meta("FT-IN-11","Hoja de Supervisión de Intendencia",
          "01","2023-01-09", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    # ── Era 2024-02 ───────────────────────────────────────────────
    _meta("FT-IN-02","Checklist de Limpieza de Habitaciones",
          "02","2024-02-14", _EB,_ECB, _EB,_ECB, _AB,_ACB),
    _meta("FT-IN-03","Bitácora de Entrega de Turno",
          "02","2024-02-14", _EB,_ECB, _EB,_ECB, _AB,_ACB),
    _meta("FT-IN-04","Bitácora de Limpieza del Área de Lockers",
          "02","2024-02-14", _EB,_ECB, _EB,_ECB, _AB,_ACB),
    _meta("FT-IN-05","Bitácora de Limpieza Ordinaria",
          "02","2024-02-14", _EB,_ECB, _EB,_ECB, _AB,_ACB),
    _meta("FT-IN-06","Cronograma de Limpieza Ordinaria",
          "02","2024-02-14", _EB,_ECB, _EB,_ECB, _AB,_ACB),
    _meta("FT-IN-07","Control de Pendientes en Áreas",
          "02","2024-02-14", _EB,_ECB, _EB,_ECB, _AB,_ACB),
    _meta("FT-IN-09","Registro de Limpieza del Área de Comedor",
          "02","2024-02-14", _EB,_ECB, _EB,_ECB, _AB,_ACB),
    # ── Era 2024-05 ───────────────────────────────────────────────
    _meta("FT-IN-08","Registro de Limpieza Rutinaria",
          "03","2024-05-05", _EB,_ECB, _EB,_ECB, _AB,_ACB),
    # ── Era 2024-07 ───────────────────────────────────────────────
    _meta("FT-IN-12","Control para la Preparación de Habitaciones",
          "01","2024-07-05", _EB,_ECB, _EB,_ECB, _AB,_ACB),
]

# ── Descripciones breves (alcance/objetivo para formatos) ─────────
_DESC = {
    "FT-IN-01": "Bitácora para el registro del aseo de baños del área de quirógrafo, con control cada 2 horas de turno.",
    "FT-IN-02": "Checklist de limpieza de habitaciones por área (Planta Baja, Planta Alta, Pediatría, Juan Pablo II, Terapia Intensiva, etc.), con verificación de tipo de limpieza e insumos.",
    "FT-IN-03": "Bitácora para el registro de la entrega de turno entre el personal de intendencia, con anotación de actividades, fecha, semana y firmas de quien realiza y supervisa.",
    "FT-IN-04": "Bitácora para el registro de la limpieza del área de lockers del personal.",
    "FT-IN-05": "Bitácora de registro de limpieza ordinaria en áreas, con columnas de fecha, semana, actividades realizadas, responsable, supervisor y observaciones.",
    "FT-IN-06": "Formato de cronograma mensual de limpieza ordinaria, para la planeación y asignación de áreas al personal de intendencia.",
    "FT-IN-07": "Formato de control de pendientes en áreas, para el seguimiento de actividades no concluidas por parte del personal de intendencia.",
    "FT-IN-08": "Registro de limpieza rutinaria por habitación o área, con nombre del responsable, área y verificación de actividades.",
    "FT-IN-09": "Registro de limpieza del área de comedor, con control de actividades, responsable y frecuencia.",
    "FT-IN-10": "Bitácora de limpieza de áreas con registro de fecha, turno, área o habitación, desinfectante utilizado, tipo de aseo (rutinaria, cultivo o desinfección de alto nivel), responsable y supervisora.",
    "FT-IN-11": "Hoja de supervisión de intendencia con checklist por habitación (cama, colchón, closet, mesa puente, cherlon, tripié, paredes, televisión, puertas, piso, silla, ventanas) y tipo de limpieza realizada.",
    "FT-IN-12": "Control para la preparación de habitaciones con registro de fecha, habitación, retiro de ropa, tipo de aseo, checklist, nebulización, cultivo, cortinas, insumos, línea de teléfono, botón de emergencia, estatus y observaciones.",
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
HEADER = """\
-- ============================================================
--  Intendencia — Formatos FT-IN-01 al FT-IN-12
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

-- Asegurarse que el departamento Intendencia exista
INSERT INTO departments (code, name, is_active)
VALUES ('IN', 'Intendencia', true)
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
WHERE dp.code = 'IN'
ORDER BY d.code;
"""

out = pathlib.Path(__file__).parent / 'ft_in_full.sql'
out.write_text(sql, encoding='utf-8')
print(f"ft_in_full.sql generado: {len(sql):,} bytes")
print(f"Documentos: {len(DOCS_META)}")
for m in DOCS_META:
    print(f"  {m['code']}  v{m['version']}  {m['issue_date']}  [{m['status']}]")
