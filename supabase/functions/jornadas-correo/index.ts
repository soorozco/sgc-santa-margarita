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
    const { folio, nombre, email, profesion, grado, taller, taller_nombre } = await req.json();
    const USER = Deno.env.get("GMAIL_USER");
    const PASS = Deno.env.get("GMAIL_APP_PASSWORD");
    if (!USER || !PASS) return json({ ok: false, error: "GMAIL_USER / GMAIL_APP_PASSWORD no configurados" }, 500);
    if (!email || !folio) return json({ ok: false, error: "faltan datos" }, 400);

    const tallerTxt = taller
      ? `Taller ${taller}: ${esc(taller_nombre || "")}`
      : "Sin taller (programa general)";

    const PROG: [string, string, string][] = [
      ["7:30", "Registro", ""],
      ["8:00", "Entronización del Sagrado Corazón", "Pbro. Santiago Garibay Rojas"],
      ["8:10", "Bienvenida", "Dr. Julio César Mijangos Méndez"],
      ["8:20", "Memoria, presente y futuro del Hospital Santa Margarita", "Dr. Celso Cerda González"],
      ["8:50", "Obesidad 2026: GLP-1/GIP y cambio de paradigma", "Vicepresidente AJMI"],
      ["9:20", "Preeclampsia y riesgo cardiovascular", "Dr. Heriberto Ravelero Rodríguez"],
      ["9:50", "Intermedio · Intervención Ballet Flamenco", ""],
      ["10:30", "Inauguración", "Autoridades e invitados especiales"],
      ["11:00", "Conferencia Magistral: “Humanizando los servicios de salud”", "Dr. Gabriel Heras La Calle (España)"],
      ["11:30", "TEP: de Urgencias a la UCI", "Dr. Ricardo Campos Cerda"],
      ["12:00", "Sepsis: nuevas guías 2026", "Dr. Julio César Mijangos Méndez"],
      ["12:40", "POCUS y VExUS para el médico clínico", "Dra. Diana G. Bravo Lozano"],
      ["13:20", "Cánulas nasales de alto flujo: indicaciones, monitoreo y retiro", "Dra. Ana A. Velarde Pineda"],
      ["14:00", "Comida · Intervención ballet folclórico", ""],
      ["18:00", "Clausura", ""],
    ];
    const progRows = PROG.map(([t, ti, sp]) =>
      `<tr><td style="color:#d14e2b;font-weight:bold;padding:4px 10px 4px 0;white-space:nowrap;vertical-align:top">${t}</td>` +
      `<td style="padding:4px 0;color:#14312a"><b>${esc(ti)}</b>${sp ? `<br><span style="color:#6b7280">${esc(sp)}</span>` : ""}</td></tr>`
    ).join("");
    const progHtml = `
      <h3 style="margin:24px 0 8px;color:#163a7a;font-size:16px">Programa</h3>
      <table style="width:100%;border-collapse:collapse;font-size:13px">${progRows}</table>
      <div style="background:#fff3ee;border:1px solid #f3c9b6;border-radius:10px;padding:10px 14px;margin-top:10px">
        <div style="color:#d14e2b;font-weight:bold;margin-bottom:4px">15:00 – 18:00 · Talleres</div>
        <div style="font-size:13px;color:#14312a;line-height:1.5">
          <b>1.</b> Manejo de la vía aérea — <span style="color:#6b7280">Dra. Lesly Rivero Villalobos</span><br>
          <b>2.</b> Evaluación VExUS y USG — <span style="color:#6b7280">Dra. Iris Xóchitl Ortíz Macías</span><br>
          <b>3.</b> Herramientas de Inteligencia Artificial en Investigación en Salud — <span style="color:#6b7280">Dr. Julio César Mijangos Méndez</span>
        </div>
      </div>`;

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
            ${profesion ? `<tr><td style="padding:6px 0;color:#6b7280">Profesión</td><td style="text-align:right">${esc(profesion)}</td></tr>` : ""}
            ${grado ? `<tr><td style="padding:6px 0;color:#6b7280">Grado académico</td><td style="text-align:right">${esc(grado)}</td></tr>` : ""}
            <tr><td style="padding:6px 0;color:#6b7280">Taller</td><td style="text-align:right">${tallerTxt}</td></tr>
            <tr><td style="padding:6px 0;color:#6b7280">Fecha</td><td style="text-align:right"><b>Viernes 23 de octubre de 2026 · 7:30 h</b></td></tr>
            <tr><td style="padding:6px 0;color:#6b7280">Sede</td><td style="text-align:right">Salón de Usos Múltiples, HSM</td></tr>
          </table>
          <p style="margin-top:18px;font-size:14px;color:#6b7280">Presenta este folio el día del evento. Guarda este correo.</p>
          ${progHtml}
        </div>
      </div>`;

    const text =
      `Hola ${nombre}, tu registro a las Primeras Jornadas Médicas quedó confirmado.\n` +
      `Folio: ${folio}\n${profesion ? "Profesión: " + profesion + "\n" : ""}${tallerTxt}\n` +
      `Fecha: Viernes 23 de octubre de 2026, 7:30 h · Salón de Usos Múltiples, HSM.\n` +
      `Presenta este folio el día del evento.\n\n` +
      `PROGRAMA\n` +
      PROG.map(([t, ti, sp]) => `${t}  ${ti}${sp ? " (" + sp + ")" : ""}`).join("\n") +
      `\n15:00-18:00  Talleres: 1) Manejo de la vía aérea; 2) Evaluación VExUS y USG; 3) Herramientas de IA en Investigación en Salud.`;

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
