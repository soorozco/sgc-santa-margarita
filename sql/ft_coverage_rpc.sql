-- ═══════════════════════════════════════════════════════════════
-- RPC: get_ft_coverage
-- Devuelve para cada formato FT cuántos documentos lo referencian
-- Busca el código FT en los campos de document_content (tipo JSONB/TEXT)
-- Ejecutar en Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════

CREATE OR REPLACE FUNCTION public.get_ft_coverage()
RETURNS TABLE (
  ft_code   TEXT,
  ref_count BIGINT,
  refs      JSONB
)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT
    ft.code                                            AS ft_code,
    COUNT(DISTINCT dc.document_id)::BIGINT             AS ref_count,
    COALESCE(
      jsonb_agg(
        DISTINCT jsonb_build_object(
          'code', rd.code,
          'name', rd.name,
          'type', dt.code_prefix
        )
      ) FILTER (WHERE rd.id IS NOT NULL),
      '[]'::jsonb
    )                                                  AS refs
  FROM documents ft
  JOIN document_types ft_dt
    ON ft_dt.id = ft.document_type_id
   AND ft_dt.code_prefix = 'FT'
  LEFT JOIN document_content dc
    ON (
         COALESCE(dc.referencias::TEXT,       '') ILIKE ('%' || ft.code || '%')
      OR COALESCE(dc.desarrollo::TEXT,        '') ILIKE ('%' || ft.code || '%')
      OR COALESCE(dc.alcance::TEXT,           '') ILIKE ('%' || ft.code || '%')
      OR COALESCE(dc.responsabilidades::TEXT, '') ILIKE ('%' || ft.code || '%')
    )
  LEFT JOIN documents rd
    ON rd.id = dc.document_id
   AND rd.id <> ft.id
  LEFT JOIN document_types dt
    ON dt.id = rd.document_type_id
  GROUP BY ft.code
  ORDER BY ft.code;
$$;

-- Verificación
SELECT * FROM get_ft_coverage() LIMIT 5;
