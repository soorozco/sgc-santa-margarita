-- ============================================================
-- Módulo: Quejas, Sugerencias y Felicitaciones
-- Formato: FT-CA-24 — Cláusula 9.1.2 ISO 9001:2015
-- ============================================================

-- ── Tabla principal ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.quejas (
  id                   UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  folio                TEXT UNIQUE,
  fecha                DATE NOT NULL DEFAULT CURRENT_DATE,
  nombre_paciente      TEXT,
  habitacion           TEXT,
  telefono             TEXT,
  tipo                 TEXT NOT NULL CHECK (tipo IN ('queja','sugerencia','felicitacion')),
  departamento         TEXT,
  personal_involucrado TEXT,
  descripcion          TEXT NOT NULL,
  nombre_presenta      TEXT,
  nombre_recibe        TEXT,
  nombre_calidad       TEXT,
  status               TEXT NOT NULL DEFAULT 'pendiente'
                         CHECK (status IN ('pendiente','en_proceso','resuelto','cerrado')),
  created_by           UUID REFERENCES profiles(id),
  created_at           TIMESTAMPTZ DEFAULT now(),
  updated_at           TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_quejas_tipo   ON quejas(tipo);
CREATE INDEX IF NOT EXISTS idx_quejas_status ON quejas(status);
CREATE INDEX IF NOT EXISTS idx_quejas_fecha  ON quejas(fecha);

-- ── Tabla de notas de seguimiento ────────────────────────────
CREATE TABLE IF NOT EXISTS public.quejas_notas (
  id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  queja_id     UUID NOT NULL REFERENCES quejas(id) ON DELETE CASCADE,
  nota         TEXT NOT NULL,
  status_change TEXT CHECK (status_change IN ('en_proceso','resuelto','cerrado')),
  created_by   UUID REFERENCES profiles(id),
  created_at   TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_qn_queja ON quejas_notas(queja_id);

-- ── Auto-folio ────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION generate_queja_folio()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE
  year_str TEXT := to_char(NOW(), 'YYYY');
  next_num INT;
  prefix   TEXT;
BEGIN
  SELECT COUNT(*) + 1 INTO next_num
  FROM quejas
  WHERE to_char(created_at, 'YYYY') = year_str;

  prefix := CASE NEW.tipo
    WHEN 'queja'       THEN 'QJ'
    WHEN 'sugerencia'  THEN 'SG'
    WHEN 'felicitacion'THEN 'FL'
    ELSE 'QJ'
  END;

  IF NEW.folio IS NULL OR NEW.folio = '' THEN
    NEW.folio := prefix || '-' || year_str || '-' || LPAD(next_num::TEXT, 2, '0');
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_queja_folio
  BEFORE INSERT ON quejas
  FOR EACH ROW EXECUTE FUNCTION generate_queja_folio();

-- ── updated_at ────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION update_queja_timestamp()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_queja_updated_at
  BEFORE UPDATE ON quejas
  FOR EACH ROW EXECUTE FUNCTION update_queja_timestamp();

-- ── RLS ───────────────────────────────────────────────────────
ALTER TABLE quejas       ENABLE ROW LEVEL SECURITY;
ALTER TABLE quejas_notas ENABLE ROW LEVEL SECURITY;

-- Todos los autenticados pueden ver quejas
CREATE POLICY "auth_see_quejas"
  ON quejas FOR SELECT
  USING (auth.role() = 'authenticated');

-- Insertar: roles con acceso de escritura
CREATE POLICY "writers_insert_quejas"
  ON quejas FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles p JOIN roles r ON p.role_id = r.id
      WHERE p.id = auth.uid()
        AND r.name IN ('administrador','responsable_calidad','jefe_departamento','recepcion')
    )
  );

-- Actualizar: admin y calidad
CREATE POLICY "admins_update_quejas"
  ON quejas FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM profiles p JOIN roles r ON p.role_id = r.id
      WHERE p.id = auth.uid()
        AND r.name IN ('administrador','responsable_calidad','jefe_departamento')
    )
  );

-- Notas: ver
CREATE POLICY "auth_see_notas"
  ON quejas_notas FOR SELECT
  USING (auth.role() = 'authenticated');

-- Notas: insertar (managers)
CREATE POLICY "managers_insert_notas"
  ON quejas_notas FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles p JOIN roles r ON p.role_id = r.id
      WHERE p.id = auth.uid()
        AND r.name IN ('administrador','responsable_calidad','jefe_departamento')
    )
  );
