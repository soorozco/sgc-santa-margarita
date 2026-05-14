import os

out = []

def row(code, name, ver, fecha, tipo):
    return f"  ('{code}', '{name}', '{tipo}', '{ver}', 'vigente', '{fecha}'::date)"

# ── IT documents ─────────────────────────────────────────────────────────────
it_docs = [
    ('IT-UV-02','INSTRUCCIÓN DE TRABAJO PARA LA HIGIENE DE MANOS QUIRÚRGICO CERO CEPILLOS','03','2025-10-02'),
    ('IT-UV-05','INSTRUCCIÓN DE TRABAJO PARA LA COLOCACIÓN DE LA BATA COMO BARRERA DE SEGURIDAD','03','2025-10-02'),
    ('IT-UV-06','INSTRUCCIÓN DE TRABAJO PARA LA COLOCACIÓN DE MASCARILLA FACIAL (CUBREBOCAS)','03','2025-10-02'),
    ('IT-UV-07','INSTRUCCIÓN DE TRABAJO PARA LA COLOCACIÓN DE LENTES DE PROTECCIÓN','03','2025-10-02'),
    ('IT-UV-08','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES POR CONTACTO (TARJETA AMARILLA)','03','2025-10-02'),
    ('IT-UV-09','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES AÉREAS POR MICROGOTAS (TARJETA AZUL)','03','2025-10-02'),
    ('IT-UV-10','INSTRUCCIÓN DE TRABAJO PARA CALZADO DE GUANTES TÉCNICA ABIERTA','03','2025-10-02'),
    ('IT-UV-11','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES POR GOTAS (TARJETA VERDE)','03','2025-10-02'),
    ('IT-UV-12','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES ESTÁNDAR (TARJETA ROJA)','03','2025-10-02'),
    ('IT-UV-13','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES POR VECTOR (TARJETA ROSA)','03','2025-10-02'),
    ('IT-UV-14','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES INVERSA (TARJETA LILA)','03','2025-10-02'),
    ('IT-UV-15','ESTUDIO DE SOMBRA DE HIGIENE DE MANOS','03','2025-10-02'),
    ('IT-UV-16','NOTIFICACIÓN DE CASOS NUEVOS DE ENFERMEDADES AL SISTEMA ÚNICO DE INFORMACIÓN PARA LA VIGILANCIA EPIDEMIOLÓGICA (SUIVE)','02','2025-10-02'),
    ('IT-UV-17','INSTRUCCIÓN DE VIGILANCIA EPIDEMIOLÓGICA ACTIVA','03','2025-10-02'),
    ('IT-UV-18','SUPERVISIÓN DE LAS MEDIDAS PRECAUTORIAS HOSPITALARIAS','03','2025-10-02'),
    ('IT-UV-19','SUPERVISIÓN DEL USO Y DESECHO DE PUNZOCORTANTES','03','2025-10-02'),
    ('IT-UV-20','INSTRUCCIÓN PARA SUPERVISIÓN DE REFRIGERADORES DE MEDICAMENTOS','03','2025-10-02'),
    ('IT-UV-22','INSTRUCCIÓN DE TRABAJO PARA LA SUPERVISIÓN DE ÁREAS Y PROCESOS','03','2025-10-02'),
    ('IT-UV-23','INSTRUCCIÓN DE TRABAJO PARA LA DETECCIÓN DE INFECCIONES ASOCIADAS A LA ATENCIÓN DE SALUD (IAAS)','03','2025-10-02'),
    ('IT-UV-24','INSTRUCCIÓN DE TRABAJO PARA PRECAUCIONES POR MICROORGANISMOS MULTIDROGORRESISTENTES (MDRO) (TARJETA NARANJA)','02','2025-10-02'),
]

# ── PR documents ─────────────────────────────────────────────────────────────
pr_docs = [
    ('PR-UV-01','PROCEDIMIENTO PARA EL ABASTECIMIENTO DE INSUMOS DE HIGIENE DE MANOS','03','2025-09-30'),
    ('PR-UV-02','PROCEDIMIENTO PARA LA PREPARACIÓN DE HABITACIONES','04','2025-09-30'),
    ('PR-UV-03','PROCEDIMIENTO PARA LA SUPERVISIÓN DE LA CLORACIÓN DE AGUA','03','2025-09-30'),
    ('PR-UV-06','PROCEDIMIENTO DE NOTIFICACIÓN EPIDEMIOLÓGICA INMEDIATA','03','2025-09-30'),
    ('PR-UV-07','PROCEDIMIENTO PARA LA NOTIFICACIÓN EPIDEMIOLÓGICA DIARIA','03','2025-09-30'),
    ('PR-UV-08','PROCEDIMIENTO PARA LA CAPACITACIÓN DE HIGIENE DE MANOS POR UVEH','03','2025-09-30'),
    ('PR-UV-09','PROCEDIMIENTO DE ACCIDENTES LABORALES POR RIESGOS BIOLÓGICOS','03','2025-09-30'),
    ('PR-UV-10','PROCEDIMIENTO PARA LA EMISIÓN DE ALERTA EPIDEMIOLÓGICA','03','2025-09-30'),
    ('PR-UV-11','PROCEDIMIENTO PARA EL AISLAMIENTO PARA PACIENTES INFECCIOSOS','03','2025-09-30'),
    ('PR-UV-12','PROCEDIMIENTO PARA AISLAMIENTO PARA PACIENTES INMUNODEPRIMIDOS','03','2025-09-30'),
    ('PR-UV-13','PROCEDIMIENTO DE RECURSOS DEL SISTEMA','03','2025-09-30'),
    ('PR-UV-14','PROCEDIMIENTO DE ENFOQUE DEL SISTEMA','04','2025-09-30'),
    ('PR-UV-15','PROCEDIMIENTO DE MEDIDAS DE PRECAUCIÓN ESTÁNDAR','03','2025-09-30'),
    ('PR-UV-16','PROCEDIMIENTO DEL MANEJO ADECUADO DE RESIDUOS PELIGROSOS BIOLÓGICO-INFECCIOSOS','03','2025-09-30'),
    ('PR-UV-17','PROCEDIMIENTO DE MANEJO ADECUADO DE LOS ALIMENTOS','03','2025-09-30'),
    ('PR-UV-18','PROCEDIMIENTO DE ADECUACIONES, CONSTRUCCIONES Y REMODELACIONES','03','2025-09-30'),
    ('PR-UV-19','PROCEDIMIENTO DE MEDICACIÓN','03','2025-09-30'),
    ('PR-UV-20','PROCEDIMIENTO DEL CONTROL DEL SISTEMA','03','2025-09-30'),
    ('PR-UV-21','PROCEDIMIENTO DE RECEPCIÓN, ALMACENAMIENTO, DISTRIBUCIÓN, MANEJO Y DISPOSICIÓN FINAL DE ROPA HOSPITALARIA','03','2025-09-30'),
    ('PR-UV-22','TERAPIA DE REEMPLAZO RENAL CON HEMODIÁLISIS','02','2025-09-30'),
    ('PR-UV-23','PROCEDIMIENTO PARA EL INGRESO DE PACIENTES CON SÍNTOMAS Y ENFERMEDADES RESPIRATORIAS','02','2025-09-30'),
    ('PR-UV-24','PROCEDIMIENTO PARA LA SUPERVISIÓN DEL MUESTREO PARA DETECCIÓN DE VIBRIO CHOLERAE EN AGUA RESIDUAL Y/O POTABLE','02','2025-09-30'),
    ('PR-UV-25','PROCEDIMIENTO DE TOMA DE MUESTRAS DE ALIMENTOS','01','2025-09-30'),
]

sql = []
sql.append("-- ============================================================")
sql.append("--  UV — Unidad de Vigilancia Epidemiológica")
sql.append("--  Documentos: 20 IT + 23 PR = 43 total")
sql.append("--  Hospital Santa Margarita · SGC ISO 9001:2015")
sql.append("-- ============================================================\n")

# ── 1. Insert/update department ───────────────────────────────────────────
sql.append("-- 1. Departamento UV")
sql.append("INSERT INTO departments (code, name, description)")
sql.append("VALUES ('UV', 'Unidad de Vigilancia Epidemiológica', 'Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)')")
sql.append("ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name;")
sql.append("")

# ── 2. IT Documents ───────────────────────────────────────────────────────
sql.append("-- 2. IT Documents")
sql.append("INSERT INTO documents (code, name, type, version, status, issue_date,")
sql.append("  elaboro_nombre, elaboro_cargo, reviso_nombre, reviso_cargo,")
sql.append("  autorizo_nombre, autorizo_cargo, department_id)")
sql.append("SELECT d.code, d.name, d.type::document_type, d.ver, 'vigente'::document_status,")
sql.append("  d.fecha::date,")
sql.append("  'Dr. Esteban González Díaz',")
sql.append("  'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',")
sql.append("  'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',")
sql.append("  d.aut_n, d.aut_c,")
sql.append("  (SELECT id FROM departments WHERE code = 'UV')")
sql.append("FROM (VALUES")

rows = []
for code, name, ver, fecha in it_docs:
    # IT-UV-09, IT-UV-24 → Dirección Médica; others → Dirección General
    if code in ('IT-UV-09','IT-UV-24'):
        aut_n = 'Dr. José Gonzalo Vázquez Camacho'
        aut_c = 'Dirección Médica'
    else:
        aut_n = 'Hna. María de Jesús García Castro'
        aut_c = 'Dirección General'
    n = name.replace("'","''")
    rows.append(f"  ('{code}','{n}','IT','{ver}','{fecha}','{aut_n}','{aut_c}')")
sql.append(",\n".join(rows))
sql.append(") AS d(code,name,type,ver,fecha,aut_n,aut_c)")
sql.append("ON CONFLICT (code) DO UPDATE SET")
sql.append("  name=EXCLUDED.name, version=EXCLUDED.version, status=EXCLUDED.status,")
sql.append("  issue_date=EXCLUDED.issue_date, elaboro_nombre=EXCLUDED.elaboro_nombre,")
sql.append("  elaboro_cargo=EXCLUDED.elaboro_cargo, reviso_nombre=EXCLUDED.reviso_nombre,")
sql.append("  reviso_cargo=EXCLUDED.reviso_cargo, autorizo_nombre=EXCLUDED.autorizo_nombre,")
sql.append("  autorizo_cargo=EXCLUDED.autorizo_cargo;")
sql.append("")
sql.append("UPDATE documents SET department_id=(SELECT id FROM departments WHERE code='UV')")
sql.append("WHERE code IN (" + ",".join(f"'{c}'" for c,*_ in it_docs) + ");")
sql.append("")

# ── 3. PR Documents ───────────────────────────────────────────────────────
sql.append("-- 3. PR Documents")
sql.append("INSERT INTO documents (code, name, type, version, status, issue_date,")
sql.append("  elaboro_nombre, elaboro_cargo, reviso_nombre, reviso_cargo,")
sql.append("  autorizo_nombre, autorizo_cargo, department_id)")
sql.append("SELECT d.code, d.name, d.type::document_type, d.ver, 'vigente'::document_status,")
sql.append("  d.fecha::date,")
sql.append("  'Dr. Esteban González Díaz',")
sql.append("  'Jefatura de la Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH)',")
sql.append("  'Dra. Giselle Ivette De la Torre García', 'Jefatura de Calidad',")
sql.append("  'Dr. José Gonzalo Vázquez Camacho', 'Dirección Médica',")
sql.append("  (SELECT id FROM departments WHERE code = 'UV')")
sql.append("FROM (VALUES")

rows = []
for code, name, ver, fecha in pr_docs:
    n = name.replace("'","''")
    rows.append(f"  ('{code}','{n}','PR','{ver}','{fecha}')")
sql.append(",\n".join(rows))
sql.append(") AS d(code,name,type,ver,fecha)")
sql.append("ON CONFLICT (code) DO UPDATE SET")
sql.append("  name=EXCLUDED.name, version=EXCLUDED.version, status=EXCLUDED.status,")
sql.append("  issue_date=EXCLUDED.issue_date, elaboro_nombre=EXCLUDED.elaboro_nombre,")
sql.append("  elaboro_cargo=EXCLUDED.elaboro_cargo, reviso_nombre=EXCLUDED.reviso_nombre,")
sql.append("  reviso_cargo=EXCLUDED.reviso_cargo, autorizo_nombre=EXCLUDED.autorizo_nombre,")
sql.append("  autorizo_cargo=EXCLUDED.autorizo_cargo;")
sql.append("")
sql.append("UPDATE documents SET department_id=(SELECT id FROM departments WHERE code='UV')")
sql.append("WHERE code IN (" + ",".join(f"'{c}'" for c,*_ in pr_docs) + ");")
sql.append("")
sql.append("-- Verificación")
sql.append("SELECT code, name, version, type FROM documents")
sql.append("WHERE department_id=(SELECT id FROM departments WHERE code='UV')")
sql.append("ORDER BY type, code;")

content = "\n".join(sql)
out_path = "/Users/soov/Documents/STA MAGO/sgc-web/sql/uv_docs.sql"
with open(out_path, 'w', encoding='utf-8') as f:
    f.write(content)

print(f"✓ Generado: {out_path}")
print(f"  IT docs: {len(it_docs)}")
print(f"  PR docs: {len(pr_docs)}")
print(f"  Total:   {len(it_docs)+len(pr_docs)}")
