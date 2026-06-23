#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Ropería — Registra 11 documentos (FT-RO-01..08, IT-RO-01, IT-RO-02, PR-RO-02)
y carga contenido digital.
Genera ro_full.sql
"""
import json, pathlib

def esc(s):
    return str(s).replace("'", "''") if s else ''

def j(obj):
    return json.dumps(obj, ensure_ascii=False)

# ── Autorizaciones ────────────────────────────────────────────────
# Set A: IT-RO-01, IT-RO-02 y FT-RO-XX
_EA = "Claudia Filiberta Rivera Ortega"
_ECA = "Jefatura de Ropería"
_RA = "Rosa Isela Lopez Astorga"
_RCA = "Dirección Administrativa"
_AA = "Mtra. Ana Cecilia Zárate"
_ACA = "Jefatura de Calidad"

# Set B: PR-RO-02
_AB = "Lic. María Elena Martínez"
_ACB = "Dirección General"

def _meta(code, name, type_prefix, ver, dt, en, ec, rn, rc, an, ac, status="en_revision"):
    return {"code": code, "name": name, "type_prefix": type_prefix, "dept_code": "RO",
            "version": ver, "status": status,
            "custodian": "Jefatura de Ropería",
            "issue_date": dt,
            "elab_nombre": en, "elab_cargo": ec,
            "rev_nombre":  rn, "rev_cargo":  rc,
            "aut_nombre":  an, "aut_cargo":  ac}

DOCS_META = [
    # ── Formatos ──────────────────────────────────────────────────
    _meta("FT-RO-01","Control de Ropa Sucia Recolectada (Externa)",
          "FT","02","2024-02-26", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    _meta("FT-RO-02","Vale de Entrega de Ropería Extraordinaria",
          "FT","02","2024-02-26", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    _meta("FT-RO-03","Vale de Entrega de Ropa",
          "FT","02","2024-02-26", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    _meta("FT-RO-04","Horarios y Ruta de Distribución de Ropa Hospitalaria",
          "FT","02","2024-02-26", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    _meta("FT-RO-05","Bitácora de Control de Entrega y Salida de Ropa Hospitalaria (Externa)",
          "FT","02","2024-02-26", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    _meta("FT-RO-06","Bitácora de Entrega y Recepción de Ropa Hospitalaria",
          "FT","02","2024-02-26", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    _meta("FT-RO-07","Control de Ropa Sucia Recolectada (Interna)",
          "FT","01","2024-02-26", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    _meta("FT-RO-08","Bitácora de Control de Entrega y Salida de Ropa Hospitalaria (Interna)",
          "FT","01","2024-02-26", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    # ── Instrucciones de trabajo ──────────────────────────────────
    _meta("IT-RO-01","Instrucción de Trabajo para el Abastecimiento de Ropa Limpia Hospitalaria",
          "IT","03","2023-03-30", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    _meta("IT-RO-02","Instrucción de Trabajo para la Recolección de Ropa Sucia Hospitalaria",
          "IT","02","2023-03-30", _EA,_ECA, _RA,_RCA, _AA,_ACA),
    # ── Proceso ───────────────────────────────────────────────────
    _meta("PR-RO-02","Proceso de Recepción y Almacenamiento de Ropa Limpia Hospitalaria",
          "PR","02","2022-07-17", _EA,_ECA, _RA,_RCA, _AB,_ACB),
]

# ── Control de cambios ────────────────────────────────────────────
_CC_FT = [
    {"version":"01","fecha":"26/02/2024","descripcion":"Alta de documento",
     "realizado":"Claudia Filiberta Rivera Ortega","aprobado":"Mtra. Ana Cecilia Zárate"},
    {"version":"02","fecha":"26/02/2024","descripcion":"Modificación de documento",
     "realizado":"Claudia Filiberta Rivera Ortega","aprobado":"Mtra. Ana Cecilia Zárate"},
]
_CC_FT_V1 = [
    {"version":"01","fecha":"26/02/2024","descripcion":"Alta de documento",
     "realizado":"Claudia Filiberta Rivera Ortega","aprobado":"Mtra. Ana Cecilia Zárate"},
]
_CC_IT01 = [
    {"version":"02","fecha":"12/07/2022","descripcion":"Modificación de documento",
     "realizado":"Claudia Filiberta Rivera Ortega","aprobado":"Mtra. Ana Cecilia Zárate Bautista"},
    {"version":"03","fecha":"30/03/2023","descripcion":"Modificación de documento",
     "realizado":"Claudia Filiberta Rivera Ortega","aprobado":"Mtra. Ana Cecilia Zárate Bautista"},
]
_CC_IT02 = [
    {"version":"01","fecha":"12/07/2022","descripcion":"Alta de documento",
     "realizado":"Claudia Filiberta Rivera Ortega","aprobado":"Mtra. Ana Cecilia Zárate Bautista"},
    {"version":"02","fecha":"30/03/2023","descripcion":"Modificación de documento",
     "realizado":"Claudia Filiberta Rivera Ortega","aprobado":"Mtra. Ana Cecilia Zárate Bautista"},
]
_CC_PR02 = [
    {"version":"01","fecha":"06/04/2022","descripcion":"Alta de documento",
     "realizado":"I.A. Alizbeydi Vázquez Serafín","aprobado":"Mtra. Ana Cecilia Zárate"},
    {"version":"02","fecha":"12/07/2022","descripcion":"Modificación de documento",
     "realizado":"I.A. Alizbeydi Vázquez Serafín","aprobado":"Mtra. Ana Cecilia Zárate"},
]

# ── Contenidos de formatos ────────────────────────────────────────
def ft_content(code, desc):
    return {
        "codigo": code,
        "alcance": desc,
        "objetivo": desc,
        "definiciones": [],
        "responsabilidades": [],
        "material_equipo": [],
        "desarrollo": [],
        "gestion_riesgos": [],
        "referencias": [],
        "control_cambios": _CC_FT if code not in ("FT-RO-07","FT-RO-08") else _CC_FT_V1,
    }

FT_RO_01 = ft_content("FT-RO-01",
    "Formato para el registro del conteo de ropa sucia recolectada por turno proveniente de empresa externa de lavandería.")
FT_RO_02 = ft_content("FT-RO-02",
    "Vale para la entrega extraordinaria de ropa hospitalaria a pacientes, con campos de solicitud, área, habitación y firmas de enfermería y ropería.")
FT_RO_03 = ft_content("FT-RO-03",
    "Vale de entrega de ropa hospitalaria por área y turno, con columnas de stock, cantidad solicitada, surtida y pendiente/adeudo.")
FT_RO_04 = ft_content("FT-RO-04",
    "Formato que establece los horarios y la ruta de recolección y distribución de ropa hospitalaria en las distintas áreas del hospital.")
FT_RO_05 = ft_content("FT-RO-05",
    "Bitácora de control de las prendas entregadas y recibidas con empresa externa de lavandería, con columnas de cantidad por tipo de prenda y firmas de operador.")
FT_RO_06 = ft_content("FT-RO-06",
    "Bitácora de entrega y recepción interna de ropa hospitalaria por área, con stocks de referencia y registro de prendas.")
FT_RO_07 = ft_content("FT-RO-07",
    "Formato para el registro del conteo de ropa sucia recolectada por turno en áreas internas del hospital.")
FT_RO_08 = ft_content("FT-RO-08",
    "Bitácora de control de entrega y salida de ropa hospitalaria en áreas internas, con registro de prendas y firmas de operador y ropería.")

# ── Contenido IT-RO-01 ────────────────────────────────────────────
IT_RO_01 = {
  "codigo": "IT-RO-01",
  "alcance": "La presente instrucción de trabajo da inicio con la preparación de paquetes de ropa limpia para la entrega de esta y finaliza una vez que se han abastecido los stocks de ropa en las distintas áreas.",
  "objetivo": "La presente instrucción de trabajo da inicio con la preparación de paquetes de ropa limpia para la entrega de esta y finaliza una vez que se han abastecido los stocks de ropa en las distintas áreas.",
  "definiciones": [],
  "responsabilidades": [],
  "material_equipo": [
    "Vale de entrega de ropa hospitalaria.",
    "Carro exclusivo para el traslado de ropa hospitalaria limpia.",
    "Ropa hospitalaria.",
  ],
  "desarrollo": [
    {"no":"1","responsable":"Ropería","actividad":"Realiza la higiene de manos conforme a IT-UV-01 Instrucción de trabajo para la higiene de manos con agua y jabón."},
    {"no":"2","responsable":"Ropería","actividad":"Limpia y desinfecta el carrito exclusivo para la transportación de ropa limpia."},
    {"no":"3","responsable":"Ropería","actividad":"Prepara el carro con la ropa limpia necesaria para surtir los stocks (sábana regular, sábana clínica, fundas, batas de aislamiento, batas de paciente, toallas, cobertores, filipinas, pantalones y almohadas). Nota: Los paquetes de ropa tienen que ir empaquetados en bolsa transparente y tapados con una sábana para la entrega de ropa a cada piso."},
    {"no":"4","responsable":"Ropería","actividad":"Inicia el recorrido para la entrega de ropa limpia basándose en los horarios y ruta de distribución de ropa hospitalaria FT-RO-04."},
    {"no":"5","responsable":"Ropería","actividad":"Comunica a personal de enfermería la entrega de ropa y surte la cantidad de prendas solicitadas para completar el stock."},
    {"no":"6","responsable":"Ropería","actividad":"Registra la entrega de ropa limpia en FT-RO-03 Vale de entrega de ropa. Nota: En caso de que soliciten prendas extras, realizará entrega y llenará el FT-RO-02 Vale de entrega de ropería extraordinaria."},
  ],
  "gestion_riesgos": [
    {"riesgo":"Desabasto de ropa hospitalaria en los stocks.","barrera":"Realizar el conteo de ropa limpia en los stocks cada cierto tiempo."},
    {"riesgo":"Falta de comunicación entre los departamentos involucrados que generen un desacuerdo con el abastecimiento de los stocks.","barrera":"Contar con el personal necesario y capacitado para ejecutar el proceso, así como mejorar la comunicación entre cada involucrado."},
  ],
  "referencias": [
    {"nombre":"Instrucción de trabajo para la higiene de manos con agua y jabón","codigo":"IT-UV-01"},
    {"nombre":"Vale de entrega de ropería extraordinaria","codigo":"FT-RO-02"},
    {"nombre":"Vale de entrega de ropa","codigo":"FT-RO-03"},
    {"nombre":"Horarios y ruta de distribución de ropa hospitalaria","codigo":"FT-RO-04"},
  ],
  "control_cambios": _CC_IT01,
}

# ── Contenido IT-RO-02 ────────────────────────────────────────────
IT_RO_02 = {
  "codigo": "IT-RO-02",
  "alcance": "La presente instrucción de trabajo da inicio con la recolección de ropa sucia hospitalaria en las distintas áreas y finaliza una vez que se ha depositado y clasificado la ropa sucia en el cuarto correspondiente.",
  "objetivo": "La presente instrucción de trabajo da inicio con la recolección de ropa sucia hospitalaria en las distintas áreas y finaliza una vez que se ha depositado y clasificado la ropa sucia en el cuarto correspondiente.",
  "definiciones": [],
  "responsabilidades": [],
  "material_equipo": [
    "Control de ropa sucia hospitalaria (FT-RO-01).",
    "Carro exclusivo para el traslado de ropa sucia hospitalaria.",
  ],
  "desarrollo": [
    {"no":"1","responsable":"Ropería","actividad":"Prepara y desinfecta el carrito exclusivo para la recolección de la ropa sucia."},
    {"no":"2","responsable":"Ropería","actividad":"Inicia el recorrido para la recolección de ropa sucia en base a los horarios y ruta de recolección FT-RO-04 Horarios y ruta de distribución de ropa hospitalaria."},
    {"no":"3","responsable":"Ropería","actividad":"Realiza la recolección de ropa sucia en cada séptico correspondiente a cada área. Nota: La ropa sucia clasificada como contaminada deberá estar en bolsa transparente con su respectivo rótulo que nos indique qué prendas contiene la bolsa."},
    {"no":"4","responsable":"Ropería","actividad":"Registra en FT-RO-01 Control de ropa sucia recolectada la cantidad de cada prenda que se recolectó en cada piso."},
    {"no":"5","responsable":"Ropería","actividad":"Traslada el carrito con ropa sucia recolectada al cuarto de 'Ropa sucia'."},
    {"no":"6","responsable":"Ropería","actividad":"Deposita cada prenda en el contenedor temporal de acuerdo con su clasificación (sábana regular, sábana clínica, fundas, batas de aislamiento, batas de paciente, toallas, cobertores, filipinas, pantalones y almohadas)."},
    {"no":"7","responsable":"Ropería","actividad":"Realiza el conteo de ropa sucia recolectada haciendo la suma de cada prenda que se recolectó el día anterior en base a lo registrado en ambos turnos en FT-RO-01 Control de ropa recolectada."},
    {"no":"8","responsable":"Ropería","actividad":"Se coloca el equipo necesario para su protección: bata, guantes y cubrebocas."},
    {"no":"9","responsable":"Ropería","actividad":"Realiza la separación de la ropa sucia generada: ropa propia y ropa de la empresa subrogada."},
    {"no":"10","responsable":"Ropería","actividad":"Supervisa que se realice el conteo general de la ropa de acuerdo con su separación y clasificación. Nota: En el caso de la ropa contaminada, toma en cuenta lo que se encuentra etiquetado en la bolsa."},
    {"no":"11","responsable":"Ropería","actividad":"Solicita al personal de la empresa subrogada la nota de recolección y corrobora que el conteo total coincida con el total registrado en FT-RO-01 Control de ropa sucia recolectada. Registra la ropa sucia entregada a la empresa subrogada en FT-RO-05 Bitácora de control de entrega y salida de ropa hospitalaria en la sección de 'ropa entregada'."},
    {"no":"12","responsable":"Ropería","actividad":"Realiza la higiene de manos conforme a IT-UV-01 Instrucción de trabajo para la higiene de manos con agua y jabón."},
  ],
  "gestion_riesgos": [
    {"riesgo":"Riesgo de infecciones asociadas a la atención de salud (IAAS) entre el personal que manipula ropa sucia y/o contaminada.","barrera":"Uso de equipo de protección personal adecuado (bata, guantes y cubrebocas), así como supervisión continua del cumplimiento del proceso."},
    {"riesgo":"Pago extra por pérdida de ropa hospitalaria.","barrera":"Llevar un registro y control interno de la ropa sucia recolectada."},
  ],
  "referencias": [
    {"nombre":"Control de ropa sucia recolectada","codigo":"FT-RO-01"},
    {"nombre":"Bitácora de control de entrega y salida de ropa hospitalaria (Externa)","codigo":"FT-RO-05"},
    {"nombre":"Instrucción de trabajo para la higiene de manos con agua y jabón","codigo":"IT-UV-01"},
    {"nombre":"Horarios y ruta de distribución de ropa hospitalaria","codigo":"FT-RO-04"},
  ],
  "control_cambios": _CC_IT02,
}

# ── Contenido PR-RO-02 ────────────────────────────────────────────
PR_RO_02 = {
  "codigo": "PR-RO-02",
  "alcance": "El presente proceso da inicio una vez que el operador de la empresa subrogada acude a las instalaciones para la entrega de la ropa hospitalaria y termina una vez que se ejecutó la actividad quedando registrada en la bitácora correspondiente.",
  "objetivo": "Disminuir el riesgo de infecciones asociadas al manejo de ropa limpia mediante la secuencia cronológica de pasos seguros y en forma estandarizada.",
  "definiciones": [],
  "responsabilidades": [
    {"rol":"Actualización","descripcion":"Jefatura de ropería"},
    {"rol":"Ejecución","descripcion":"Auxiliar de ropería"},
    {"rol":"Supervisión","descripcion":"Epidemiología y Jefatura de ropería"},
  ],
  "material_equipo": [],
  "desarrollo": [
    {"no":"1","responsable":"Ropería","actividad":"Realiza higiene de manos antes de iniciar el proceso, conforme a IT-UV-01 Instrucción de trabajo para la higiene de manos con agua y jabón."},
    {"no":"2","responsable":"Ropería","actividad":"Se coloca equipo de protección personal (bata de manga larga y cubrebocas)."},
    {"no":"3","responsable":"Operador de empresa subrogada","actividad":"Realiza la técnica de higiene de manos conforme a IT-UV-01 Instrucción de trabajo para la higiene de manos con agua y jabón."},
    {"no":"4","responsable":"Operador de empresa subrogada","actividad":"Entrega los paquetes de ropa limpia a la encargada de ropería y realiza el conteo de la cantidad de ropa que se está entregando."},
    {"no":"5","responsable":"Ropería","actividad":"Indica al operador de la empresa subrogada el anaquel destinado para la colocación de la ropa limpia. Nota: Verificar que los anaqueles se encuentren limpios para el acomodo de la ropa."},
    {"no":"5b","responsable":"Operador de empresa subrogada","actividad":"Distribuye y acomoda la ropa limpia en los anaqueles correspondientes."},
    {"no":"6","responsable":"Operador de empresa subrogada","actividad":"Realiza el registro de la ropa limpia que entregó en las notas."},
    {"no":"7","responsable":"Ropería","actividad":"Verifica que lo registrado en la nota coincida con lo que se le entregó de ropa limpia y firma de conformidad. Registra la cantidad de prendas recibidas en FT-RO-05 Bitácora de control de entrega y salida de ropa hospitalaria en la sección de 'ropa recibida'."},
  ],
  "gestion_riesgos": [
    {"riesgo":"Desabasto de stocks en las distintas áreas.","barrera":"Coordinación con la empresa subrogada para la recepción de ropa limpia en horarios establecidos."},
    {"riesgo":"Pérdida monetaria por extravío de ropa limpia.","barrera":"Control de bitácoras y realización de inventarios."},
  ],
  "referencias": [
    {"nombre":"Instrucción de trabajo para la higiene de manos con agua y jabón","codigo":"IT-UV-01"},
    {"nombre":"Bitácora de control de entrega y salida de ropa hospitalaria (Externa)","codigo":"FT-RO-05"},
    {"nombre":"Proceso para la preparación de habitaciones","codigo":"PR-UV-02"},
  ],
  "control_cambios": _CC_PR02,
}

DOCS_CONTENT = [
    FT_RO_01, FT_RO_02, FT_RO_03, FT_RO_04,
    FT_RO_05, FT_RO_06, FT_RO_07, FT_RO_08,
    IT_RO_01, IT_RO_02, PR_RO_02,
]

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
    alc  = esc(doc.get('alcance', ''))
    obj  = esc(doc.get('objetivo', ''))
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
--  Ropería — Registro y contenido digital de documentos RO
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

-- Asegurarse que el departamento Ropería exista
INSERT INTO departments (code, name, is_active)
VALUES ('RO', 'Ropería', true)
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
WHERE dp.code = 'RO'
ORDER BY d.code;
"""

out = pathlib.Path(__file__).parent / 'ro_full.sql'
out.write_text(sql, encoding='utf-8')
print(f"ro_full.sql generado: {len(sql):,} bytes")
print(f"Documentos: {len(DOCS_META)}")
for m in DOCS_META:
    print(f"  {m['code']}  [{m['status']}]")
