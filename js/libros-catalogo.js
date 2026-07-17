// ─── Catálogo de libros electrónicos de controlados ──────────────
// Compartido por libros-controlados.js y libros-recetas.js
// Mismos grupos que el Conteo de Controlados.

const LIBROS_CATALOGO = {
  I: [
    'Fentanilo (Fenodid) 0.25mg/5ml caja c/6 amp',
    'Fentanilo (Fenodid) 0.5mg/10ml',
    'Morfina (Graten) 2.5mg/2.5ml',
    'Morfina (Graten) 10mg/10ml',
  ],
  II: [
    'Antadona (Flumazenil) 0.5mg/5ml',
    'Brospina (Buprenorfina) 0.3mg/ml',
    'Bufigen (Nalbufina) 10mg/ml',
    'Relacum (Midazolam) 5mg/5ml',
    'Relacum (Midazolam) 15mg/3ml',
    'Relacum (Midazolam) 50mg/10ml',
    'Relazepam (Diazepam) 10mg/2ml',
    'Alprazolam 0.25mg tabletas',
    'Alprazolam 0.5mg tabletas',
    'Kriadex (Clonazepam) 2mg tabletas',
    'Kriadex (Clonazepam) 2.5mg/ml gotas',
    'Soloro 7 (Buprenorfina) 5mcg parches',
    'Soloro 7 (Buprenorfina) 10mcg parches',
  ],
  III: [
    'Anapsique (Amitriptilina) 25mg tabletas',
    'Pisazol (Tramadol) 50mg',
    'Pisazol (Tramadol) 100mg',
    'Tradol (Tramadol) 50mg',
    'Tradol (Tramadol) 100mg',
    'Supradol Duet (Tramadol/Ketorolaco) 10mg/25mg',
    'Onemer Duet (Tramadol/Ketorolaco)',
    'Tramadol gotas',
    'Tramadol / Paracetamol tabletas',
  ],
}

function grupoDeMedicamento(med) {
  for (const [g, meds] of Object.entries(LIBROS_CATALOGO)) {
    if (meds.includes(med)) return g
  }
  return null
}
