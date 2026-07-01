# ══════════════════════════════════════════════════════════════════
# Robot verificador de normas externas · Hospital Santa Margarita
#
# Corre semanalmente en GitHub Actions (.github/workflows/verificar-normas.yml).
# 1. Lee los documentos externos (DE-*) vigentes de Supabase
# 2. Por cada norma le pide a Claude (con búsqueda web) verificar en la
#    fuente oficial (DOF/SINEC para NOMs, iso.org para ISO, etc.) si
#    sigue vigente o existe una versión más reciente
# 3. Guarda el resultado en Supabase (auto_check_*)
#
# Variables de entorno requeridas (secrets del repo):
#   SUPABASE_URL          https://xxxx.supabase.co
#   SUPABASE_SERVICE_KEY  service_role key (NO la anon)
#   ANTHROPIC_API_KEY     API key de Anthropic
# ══════════════════════════════════════════════════════════════════

import json
import os
import re
import sys
from datetime import datetime, timezone

import requests
import anthropic

SUPABASE_URL = os.environ["SUPABASE_URL"].rstrip("/")
SERVICE_KEY = os.environ["SUPABASE_SERVICE_KEY"]

HEADERS = {
    "apikey": SERVICE_KEY,
    "Authorization": f"Bearer {SERVICE_KEY}",
    "Content-Type": "application/json",
}

client = anthropic.Anthropic()  # lee ANTHROPIC_API_KEY del entorno

PROMPT = """Eres un verificador de vigencia de normativa para un hospital en México.

Documento externo a verificar:
- Código interno: {code}
- Nombre: {name}
- Versión registrada: {version}
- URL de referencia registrada: {source_url}

Busca en las fuentes oficiales (para NOMs mexicanas: DOF/dof.gob.mx y el
catálogo SINEC; para normas ISO: iso.org; para leyes y reglamentos:
diputados.gob.mx y el DOF; para GPC: CENETEC) y determina:

1. ¿La norma/documento sigue vigente tal como está registrada?
2. ¿Existe una modificación, cancelación o versión más reciente?

Responde ÚNICAMENTE con un objeto JSON, sin texto adicional:
{{"status": "vigente" | "desactualizada" | "no_verificado",
  "note": "explicación breve en español (máx 200 caracteres)",
  "url": "URL de la fuente oficial consultada o null"}}

Usa "vigente" solo si confirmaste en una fuente oficial que no hay versión
más reciente. Usa "desactualizada" si encontraste una modificación,
cancelación o versión posterior. Usa "no_verificado" si no pudiste
confirmar con certeza."""


def get_external_docs():
    """Lee los documentos externos vigentes de Supabase."""
    r = requests.get(
        f"{SUPABASE_URL}/rest/v1/documents",
        headers=HEADERS,
        params={
            "select": "id,code,name,current_version,source_url",
            "code": "like.DE-*",
            "status": "eq.vigente",
            "order": "code.asc",
        },
        timeout=30,
    )
    r.raise_for_status()
    return r.json()


def check_norm(doc):
    """Le pregunta a Claude (con búsqueda web) si la norma sigue vigente."""
    prompt = PROMPT.format(
        code=doc.get("code") or "—",
        name=doc.get("name") or "—",
        version=doc.get("current_version") or "—",
        source_url=doc.get("source_url") or "no registrada",
    )
    response = client.messages.create(
        model="claude-opus-4-8",
        max_tokens=2000,
        tools=[{"type": "web_search_20260209", "name": "web_search", "max_uses": 5}],
        messages=[{"role": "user", "content": prompt}],
    )

    if response.stop_reason == "refusal":
        return {"status": "no_verificado", "note": "El modelo declinó la consulta", "url": None}

    # Concatenar los bloques de texto y extraer el JSON
    text = "".join(b.text for b in response.content if b.type == "text")
    match = re.search(r"\{.*\}", text, re.DOTALL)
    if not match:
        return {"status": "no_verificado", "note": "Respuesta sin JSON interpretable", "url": None}
    try:
        data = json.loads(match.group(0))
    except json.JSONDecodeError:
        return {"status": "no_verificado", "note": "JSON inválido en la respuesta", "url": None}

    status = data.get("status")
    if status not in ("vigente", "desactualizada", "no_verificado"):
        status = "no_verificado"
    return {
        "status": status,
        "note": (data.get("note") or "")[:300],
        "url": data.get("url") if isinstance(data.get("url"), str) else None,
    }


def save_result(doc_id, result):
    """Guarda el resultado del robot en Supabase."""
    r = requests.patch(
        f"{SUPABASE_URL}/rest/v1/documents",
        headers={**HEADERS, "Prefer": "return=minimal"},
        params={"id": f"eq.{doc_id}"},
        json={
            "auto_check_status": result["status"],
            "auto_check_at": datetime.now(timezone.utc).isoformat(),
            "auto_check_note": result["note"],
            "auto_check_url": result["url"],
        },
        timeout=30,
    )
    r.raise_for_status()


def main():
    docs = get_external_docs()
    print(f"Documentos externos a verificar: {len(docs)}")
    errors = 0

    for doc in docs:
        code = doc.get("code", "?")
        try:
            result = check_norm(doc)
        except anthropic.APIError as e:
            print(f"  {code}: error de API ({e}) — marcando no_verificado")
            result = {"status": "no_verificado", "note": f"Error del robot: {e}"[:300], "url": None}
            errors += 1
        try:
            save_result(doc["id"], result)
            icon = {"vigente": "OK", "desactualizada": "!!", "no_verificado": "??"}[result["status"]]
            print(f"  [{icon}] {code}: {result['status']} — {result['note']}")
        except requests.HTTPError as e:
            print(f"  {code}: error guardando en Supabase: {e}")
            errors += 1

    print(f"Terminado. {len(docs)} documentos, {errors} errores.")
    sys.exit(1 if errors and errors == len(docs) else 0)


if __name__ == "__main__":
    main()
