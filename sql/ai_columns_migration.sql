-- ═══════════════════════════════════════════════════════════════
-- Migración: Nuevas columnas para Auditorías Internas
-- Ejecutar en Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════

ALTER TABLE public.auditorias_internas
  ADD COLUMN IF NOT EXISTS checklist     JSONB NOT NULL DEFAULT '[]',
  ADD COLUMN IF NOT EXISTS evaluaciones  JSONB NOT NULL DEFAULT '[]',
  ADD COLUMN IF NOT EXISTS actuaciones   JSONB NOT NULL DEFAULT '[]',
  ADD COLUMN IF NOT EXISTS reunion_final JSONB NOT NULL DEFAULT '{}';

-- ── Actualizar función RPC para incluir nuevas columnas ──────────
CREATE OR REPLACE FUNCTION public.save_auditoria_interna(p_row JSONB)
RETURNS void LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_id   UUID;
  v_name TEXT;
BEGIN
  v_id := NULLIF(p_row->>'id','')::UUID;
  SELECT full_name INTO v_name FROM public.profiles WHERE id = NULLIF(p_row->>'created_by','')::UUID;

  IF v_id IS NULL THEN
    INSERT INTO public.auditorias_internas (
      audit_number, audit_type, coordinator, audit_date_start, audit_date_end,
      scope, lead_auditor, team, areas, findings, status, audit_result,
      conclusion, next_audit_date, report_path, report_url, report_name,
      meeting_path, meeting_url, meeting_name,
      checklist, evaluaciones, actuaciones, reunion_final,
      created_by, created_by_name, updated_at
    ) VALUES (
      p_row->>'audit_number', COALESCE(p_row->>'audit_type','programada'),
      NULLIF(p_row->>'coordinator',''),
      NULLIF(p_row->>'audit_date_start','')::DATE, NULLIF(p_row->>'audit_date_end','')::DATE,
      NULLIF(p_row->>'scope',''), NULLIF(p_row->>'lead_auditor',''),
      COALESCE(p_row->'team','[]'::jsonb), COALESCE(p_row->'areas','[]'::jsonb),
      COALESCE(p_row->'findings','[]'::jsonb), COALESCE(p_row->>'status','planificada'),
      NULLIF(p_row->>'audit_result',''), NULLIF(p_row->>'conclusion',''),
      NULLIF(p_row->>'next_audit_date','')::DATE,
      NULLIF(p_row->>'report_path',''), NULLIF(p_row->>'report_url',''), NULLIF(p_row->>'report_name',''),
      NULLIF(p_row->>'meeting_path',''), NULLIF(p_row->>'meeting_url',''), NULLIF(p_row->>'meeting_name',''),
      COALESCE(p_row->'checklist','[]'::jsonb),
      COALESCE(p_row->'evaluaciones','[]'::jsonb),
      COALESCE(p_row->'actuaciones','[]'::jsonb),
      COALESCE(p_row->'reunion_final','{}'::jsonb),
      NULLIF(p_row->>'created_by','')::UUID, COALESCE(v_name, p_row->>'created_by'), now()
    );
  ELSE
    UPDATE public.auditorias_internas SET
      audit_number     = p_row->>'audit_number',
      audit_type       = COALESCE(p_row->>'audit_type','programada'),
      coordinator      = NULLIF(p_row->>'coordinator',''),
      audit_date_start = NULLIF(p_row->>'audit_date_start','')::DATE,
      audit_date_end   = NULLIF(p_row->>'audit_date_end','')::DATE,
      scope            = NULLIF(p_row->>'scope',''),
      lead_auditor     = NULLIF(p_row->>'lead_auditor',''),
      team             = COALESCE(p_row->'team','[]'::jsonb),
      areas            = COALESCE(p_row->'areas','[]'::jsonb),
      findings         = COALESCE(p_row->'findings','[]'::jsonb),
      status           = COALESCE(p_row->>'status','planificada'),
      audit_result     = NULLIF(p_row->>'audit_result',''),
      conclusion       = NULLIF(p_row->>'conclusion',''),
      next_audit_date  = NULLIF(p_row->>'next_audit_date','')::DATE,
      report_path      = NULLIF(p_row->>'report_path',''),
      report_url       = NULLIF(p_row->>'report_url',''),
      report_name      = NULLIF(p_row->>'report_name',''),
      meeting_path     = NULLIF(p_row->>'meeting_path',''),
      meeting_url      = NULLIF(p_row->>'meeting_url',''),
      meeting_name     = NULLIF(p_row->>'meeting_name',''),
      checklist        = COALESCE(p_row->'checklist','[]'::jsonb),
      evaluaciones     = COALESCE(p_row->'evaluaciones','[]'::jsonb),
      actuaciones      = COALESCE(p_row->'actuaciones','[]'::jsonb),
      reunion_final    = COALESCE(p_row->'reunion_final','{}'::jsonb),
      updated_at       = now()
    WHERE id = v_id;
  END IF;
END;
$$;

GRANT EXECUTE ON FUNCTION public.save_auditoria_interna TO authenticated;
