-- ══════════════════════════════════════════════════════════════════
-- Migración: Libros Electrónicos de Medicamentos Controlados
-- Hospital Santa Margarita · SGC ISO 9001:2015
--
-- Crea la tabla pharmacy_ledger_entries: el libro electrónico por
-- medicamento (formato "FENTANILO (FENODID)…" etc.). Cada registro es
-- un movimiento del libro:
--   · Entrada (proveedor): proveedor, dirección, no. factura, lote, cad
--   · Salida  (receta):    paciente, fecha nacimiento, médico,
--                          dirección, cédula, no. receta, uso
-- Las salidas alimentan automáticamente el "Registro de Recetas" por
-- grupo (I / II / III) — no hay tabla aparte para el registro.
--
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.pharmacy_ledger_entries (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  medicamento        TEXT NOT NULL,       -- nombre del libro
  grupo              TEXT,                -- I | II | III
  fecha              DATE NOT NULL,
  entrada            NUMERIC,             -- cantidad que entra (proveedor)
  salida             NUMERIC,             -- cantidad que sale (receta)
  paciente_proveedor TEXT,                -- paciente (salida) o proveedor (entrada)
  fecha_nacimiento   DATE,                -- solo salidas
  medico             TEXT,                -- solo salidas
  direccion          TEXT,
  cedula_factura     TEXT,                -- cédula profesional (salida) o no. factura (entrada)
  receta             TEXT,                -- no. de receta (solo salidas) → folio del Registro de Recetas
  uso                TEXT,                -- Hospitalario | Quirúrgico | Ambulatorio | Otro
  lote               TEXT,
  cad                TEXT,                -- caducidad (YYYY-MM)
  observaciones      TEXT,
  created_by         UUID,
  created_by_name    TEXT,
  created_at         TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_ple_medicamento
  ON public.pharmacy_ledger_entries (medicamento, fecha);
CREATE INDEX IF NOT EXISTS idx_ple_grupo
  ON public.pharmacy_ledger_entries (grupo, fecha);

-- Permisos (mismo patrón que el resto de las tablas del SGC)
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pharmacy_ledger_entries TO authenticated;
GRANT ALL ON public.pharmacy_ledger_entries TO service_role;

-- RLS: cualquier usuario autenticado puede leer y capturar
ALTER TABLE public.pharmacy_ledger_entries ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "authenticated acceso completo" ON public.pharmacy_ledger_entries;
CREATE POLICY "authenticated acceso completo"
  ON public.pharmacy_ledger_entries
  FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- ── Verificación ──────────────────────────────────────────────────
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'pharmacy_ledger_entries'
ORDER BY ordinal_position;
