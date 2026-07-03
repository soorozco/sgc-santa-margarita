# ══════════════════════════════════════════════════════════════════
# Importador de documentos externos desde la matriz Excel (CSV)
# Hospital Santa Margarita · SGC ISO 9001:2015
#
# Lee el CSV exportado de "Base_control_documentos_externos_ISO9001"
# y crea/actualiza los documentos en Supabase (tabla documents),
# llenando la ficha external_meta (§ 7.5.3.2).
#
# Uso (Terminal):
#   SUPABASE_SERVICE_KEY="<service_role key>" \
#   python3 robot/importar_externos.py "/ruta/al/archivo.csv"
#
# No requiere instalar nada (usa solo la librería estándar de Python)
# Antes ejecuta en Supabase la migración sql/add_external_meta.sql
# ══════════════════════════════════════════════════════════════════

import csv
import os
import re
import sys

import json
import urllib.request
import urllib.parse
import urllib.error

SUPABASE_URL = os.environ.get("SUPABASE_URL", "https://tdxkvvmdxnbarjsaknse.supabase.co").rstrip("/")
SERVICE_KEY = os.environ.get("SUPABASE_SERVICE_KEY")

if not SERVICE_KEY:
    sys.exit("Falta la variable SUPABASE_SERVICE_KEY (Supabase → Settings → API → service_role)")
if len(sys.argv) < 2:
    sys.exit('Uso: python3 robot/importar_externos.py "/ruta/al/archivo.csv"')

CSV_PATH = sys.argv[1]

HEADERS = {
    "apikey": SERVICE_KEY,
    "Authorization": f"Bearer {SERVICE_KEY}",
    "Content-Type": "application/json",
}

# Columna del CSV → llave de external_meta
META_MAP = {
    "Proceso asociado": "proceso",
    "Tipo de documento": "tipo_doc_externo",
    "Origen / Emisor externo": "emisor",
    "Código / folio / versión externa": "codigo_externo",
    "Fecha de emisión": "fecha_emision",
    "Fecha de recepción": "fecha_recepcion",
    "Medio de soporte": "medio",
    "Ubicación / ruta / carpeta": "ubicacion",
    "Uso previsto en el servicio": "uso_previsto",
    "Responsable de uso": "resp_uso",
    "Responsable de resguardo": "resp_resguardo",
    "¿Aplica para el SGC?": "aplica_sgc",
    "Requisito ISO 9001:2015 relacionado": "requisito_iso",
    "Método de identificación": "met_identificacion",
    "Método de control de cambios / actualización": "met_control_cambios",
    "Periodicidad de revisión": "periodicidad",
    "Retención documental": "retencion",
    "Disposición final": "disposicion",
    "Acceso / confidencialidad": "acceso",
    "Evidencia de distribución / difusión": "evidencia_difusion",
    "Próxima revisión": "proxima_revision",
    "Riesgo por uso de documento obsoleto/no controlado": "riesgo",
    "Barreras de control establecidas": "barreras",
    "Observaciones": "observaciones",
}

DATE_KEYS = {"fecha_emision", "fecha_recepcion"}


def clean(v):
    v = (v or "").strip()
    return "" if v in ("#REF!", "N/A") else v


def to_date(v):
    """Normaliza fechas: '2015' → '2015-01-01', deja YYYY-MM-DD tal cual."""
    v = clean(v)
    if re.fullmatch(r"\d{4}", v):
        return f"{v}-01-01"
    if re.fullmatch(r"\d{4}-\d{2}-\d{2}", v):
        return v
    return v  # otro formato: se guarda como texto


def api(method, table, params=None, payload=None):
    """Llama al REST de Supabase con la librería estándar. Devuelve (status, body)."""
    url = f"{SUPABASE_URL}/rest/v1/{table}"
    if params:
        url += "?" + urllib.parse.urlencode(params)
    data = json.dumps(payload).encode() if payload is not None else None
    req = urllib.request.Request(url, data=data, method=method)
    for k, v in HEADERS.items():
        req.add_header(k, v)
    if method in ("POST", "PATCH"):
        req.add_header("Prefer", "return=minimal")
    try:
        with urllib.request.urlopen(req, timeout=30) as resp:
            return resp.status, resp.read().decode()
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode()


def fetch(table, params):
    status, body = api("GET", table, params)
    if status >= 400:
        sys.exit(f"Error {status} leyendo {table}: {body[:300]}")
    return json.loads(body)


def main():
    # Catálogos para relacionar departamento y tipo de documento
    depts = fetch("departments", {"select": "id,name"})
    types = fetch("document_types", {"select": "id,code_prefix"})
    existing = {d["code"]: d["id"] for d in fetch("documents", {"select": "id,code", "code": "like.DE-*"})}

    de_type_id = next((t["id"] for t in types if t["code_prefix"] == "DE"), None)

    def dept_id(name):
        name = clean(name).lower()
        if not name:
            return None
        for d in depts:
            if name in d["name"].lower() or d["name"].lower() in name:
                return d["id"]
        return None

    created = updated = skipped = 0

    with open(CSV_PATH, newline="", encoding="utf-8-sig") as f:
        for row in csv.DictReader(f):
            code = clean(row.get("ID"))
            name = clean(row.get("Nombre del documento externo"))
            if not code or not name:
                skipped += 1
                continue

            meta = {}
            for col, key in META_MAP.items():
                v = clean(row.get(col))
                if not v:
                    continue
                meta[key] = to_date(v) if key in DATE_KEYS else v

            estado = clean(row.get("Estado del documento")).lower()
            payload = {
                "code": code.upper(),
                "name": name,
                "status": "vigente" if estado == "vigente" else "borrador",
                "document_type_id": de_type_id,
                "department_id": dept_id(row.get("Servicio / Área")),
                "custodian_position": meta.get("resp_resguardo") or None,
                "external_meta": meta or None,
            }

            # Última revisión interna → verificación manual
            ultima = to_date(row.get("Fecha última revisión interna"))
            if re.fullmatch(r"\d{4}-\d{2}-\d{2}", ultima or ""):
                payload["last_verified_at"] = f"{ultima}T12:00:00Z"
                capturo = clean(row.get("Capturó"))
                if capturo:
                    payload["verified_by"] = capturo

            if code.upper() in existing:
                status, body = api("PATCH", "documents",
                                   {"id": f"eq.{existing[code.upper()]}"}, payload)
                action = "actualizado"
                updated += 1
            else:
                payload["current_version"] = "1.0"
                status, body = api("POST", "documents", None, payload)
                action = "creado"
                created += 1

            if status >= 400:
                print(f"  ✗ {code}: ERROR {status} — {body[:200]}")
                if action == "creado":
                    created -= 1
                else:
                    updated -= 1
                skipped += 1
            else:
                print(f"  ✓ {code}: {action} — {name[:60]}")

    print(f"\nTerminado: {created} creados, {updated} actualizados, {skipped} omitidos/con error.")


if __name__ == "__main__":
    main()
