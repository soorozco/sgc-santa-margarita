// Edge Function: correo de confirmación de registro — Jornadas Médicas
// Envía por GMAIL SMTP (sin dominio) usando una CONTRASEÑA DE APLICACIÓN.
//
// Requisitos en la cuenta de Gmail remitente (calidadhsm.gdl@gmail.com):
//   1) Activar "Verificación en 2 pasos".
//   2) Crear una "Contraseña de aplicación" (16 caracteres) en
//      https://myaccount.google.com/apppasswords
//
// Despliegue (en tu terminal, dentro de sgc-web):
//   supabase login
//   supabase link --project-ref tdxkvvmdxnbarjsaknse
//   supabase secrets set GMAIL_USER=calidadhsm.gdl@gmail.com
//   supabase secrets set GMAIL_APP_PASSWORD="xxxxxxxxxxxxxxxx"   # sin espacios
//   supabase functions deploy jornadas-correo --no-verify-jwt
//
// La contraseña de aplicación NUNCA va en el código ni en el repo: vive como secreto.
// El front la invoca con db.functions.invoke('jornadas-correo', { body: {...} }).

import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { SMTPClient } from "https://deno.land/x/denomailer@1.6.0/mod.ts";

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

  const json = (obj: unknown, status = 200) =>
    new Response(JSON.stringify(obj), {
      status, headers: { ...CORS, "Content-Type": "application/json" },
    });

  try {
    const { folio, nombre, email, categoria, taller, taller_nombre } = await req.json();
    const USER = Deno.env.get("GMAIL_USER");
    const PASS = Deno.env.get("GMAIL_APP_PASSWORD");
    if (!USER || !PASS) return json({ ok: false, error: "GMAIL_USER / GMAIL_APP_PASSWORD no configurados" }, 500);
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

    const text =
      `Hola ${nombre}, tu registro a las Primeras Jornadas Médicas quedó confirmado.\n` +
      `Folio: ${folio}\nCategoría: ${categoria || "—"}\n${tallerTxt}\n` +
      `Fecha: Viernes 23 de octubre de 2026, 7:30 h · Salón de Usos Múltiples, HSM.\n` +
      `Presenta este folio el día del evento.`;

    const client = new SMTPClient({
      connection: {
        hostname: "smtp.gmail.com",
        port: 465,
        tls: true,
        auth: { username: USER, password: PASS },
      },
    });

    await client.send({
      from: `Jornadas Médicas HSM <${USER}>`,
      to: email,
      subject: `Registro confirmado · Jornadas Médicas HSM — ${folio}`,
      content: text,
      html,
    });
    await client.close();

    return json({ ok: true });
  } catch (e) {
    return json({ ok: false, error: String(e) }, 500);
  }
});
