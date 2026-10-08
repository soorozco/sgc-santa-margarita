// Edge Function: correo de confirmación de registro — Jornadas Médicas
// Despliegue (cuando tengas la cuenta de Resend):
//   1) En Supabase → Edge Functions, crea un secreto:
//        supabase secrets set RESEND_API_KEY=xxxxxxxx
//        supabase secrets set JORNADAS_FROM="Jornadas HSM <jornadas@tudominio.com>"
//      (Si no verificas dominio, usa el remitente de prueba: onboarding@resend.dev)
//   2) supabase functions deploy jornadas-correo --no-verify-jwt
//
// La llave de Resend NUNCA va en el código ni en el repo: vive solo como secreto.
// El front la invoca con db.functions.invoke('jornadas-correo', { body: {...} }).

import { serve } from "https://deno.land/std@0.224.0/http/server.ts";

const CORS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

const esc = (s: string) =>
  String(s ?? "").replace(/[&<>"]/g, (c) =>
    ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]!));

serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: CORS });

  try {
    const { folio, nombre, email, categoria, taller, taller_nombre } = await req.json();
    const KEY = Deno.env.get("RESEND_API_KEY");
    const FROM = Deno.env.get("JORNADAS_FROM") || "Jornadas HSM <onboarding@resend.dev>";
    if (!KEY) return json({ ok: false, error: "RESEND_API_KEY no configurada" }, 500);
    if (!email || !folio) return json({ ok: false, error: "faltan datos" }, 400);

    const tallerTxt = taller
      ? `Taller ${taller}: ${esc(taller_nombre || "")}`
      : "Sin taller (programa general)";

    const html = `
      <div style="font-family:Arial,sans-serif;max-width:560px;margin:0 auto;color:#1f2937">
        <div style="background:#163a7a;color:#fff;padding:20px;border-radius:12px 12px 0 0;text-align:center">
          <div style="letter-spacing:2px;font-size:12px;color:#cdd8f0">HOSPITAL SANTA MARGARITA · 130 ANIVERSARIO</div>
          <h2 style="margin:8px 0 0">Primeras Jornadas Médicas</h2>
          <div style="color:#f0c9ad">Innovación, Ciencia y Humanismo</div>
        </div>
        <div style="border:1px solid #e5e7eb;border-top:none;padding:22px;border-radius:0 0 12px 12px">
          <p>Hola <b>${esc(nombre)}</b>, tu registro quedó confirmado. 🎉</p>
          <table style="width:100%;border-collapse:collapse;font-size:15px">
            <tr><td style="padding:6px 0;color:#6b7280">Folio</td><td style="text-align:right"><b style="color:#d14e2b;font-size:18px">${esc(folio)}</b></td></tr>
            <tr><td style="padding:6px 0;color:#6b7280">Categoría</td><td style="text-align:right">${esc(categoria || "—")}</td></tr>
            <tr><td style="padding:6px 0;color:#6b7280">Taller</td><td style="text-align:right">${tallerTxt}</td></tr>
            <tr><td style="padding:6px 0;color:#6b7280">Fecha</td><td style="text-align:right"><b>Viernes 23 de octubre de 2026 · 7:30 h</b></td></tr>
            <tr><td style="padding:6px 0;color:#6b7280">Sede</td><td style="text-align:right">Salón de Usos Múltiples, HSM</td></tr>
          </table>
          <p style="margin-top:18px;font-size:14px;color:#6b7280">Presenta este folio el día del evento. Guarda este correo.</p>
        </div>
      </div>`;

    const r = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: { "Authorization": `Bearer ${KEY}`, "Content-Type": "application/json" },
      body: JSON.stringify({
        from: FROM, to: [email],
        subject: `Registro confirmado · Jornadas Médicas HSM — ${folio}`,
        html,
      }),
    });

    const out = await r.json();
    return json({ ok: r.ok, resend: out }, r.ok ? 200 : 502);
  } catch (e) {
    return json({ ok: false, error: String(e) }, 500);
  }

  function json(obj: unknown, status = 200) {
    return new Response(JSON.stringify(obj), {
      status, headers: { ...CORS, "Content-Type": "application/json" },
    });
  }
});
