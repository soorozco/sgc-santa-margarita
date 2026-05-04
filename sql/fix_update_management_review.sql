-- ══════════════════════════════════════════════════════════════════
-- FIX: Recrear función update_management_review con parámetros correctos
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- Primero eliminamos cualquier versión anterior con firma diferente
DROP FUNCTION IF EXISTS update_management_review(uuid,text,text,date,text,jsonb,jsonb,jsonb);
DROP FUNCTION IF EXISTS update_management_review(uuid,jsonb);
DROP FUNCTION IF EXISTS update_management_review(uuid,text,text,date,text,jsonb,jsonb,jsonb,jsonb);

-- Recreamos con la firma exacta que usa el JS
CREATE OR REPLACE FUNCTION update_management_review(
  p_id                  uuid,
  p_status              text,
  p_location            text,
  p_next_review_date    date,
  p_general_conclusions text,
  p_attendees           jsonb,
  p_inputs              jsonb,
  p_outputs             jsonb,
  p_form_data           jsonb DEFAULT '{}'
)
RETURNS void
LANGUAGE plpgsql SECURITY DEFINER
AS $$
BEGIN
  UPDATE management_reviews SET
    status                       = p_status,
    location                     = p_location,
    next_review_date             = p_next_review_date,
    improvement_opportunities    = p_general_conclusions,
    attendees                    = p_attendees,
    outputs                      = p_outputs,
    form_data                    = p_form_data,
    -- Sincronizar columnas planas desde form_data
    internal_external_changes    = CONCAT(
                                     COALESCE(p_form_data->>'changes_internal', ''),
                                     CASE WHEN COALESCE(p_form_data->>'changes_external','') <> ''
                                       THEN E'\n\nCambios externos: ' || (p_form_data->>'changes_external')
                                       ELSE '' END
                                   ),
    user_satisfaction_results    = COALESCE(p_form_data->>'desemp_3a_results', ''),
    user_satisfaction_followup   = COALESCE(p_form_data->>'desemp_3a_plan',    ''),
    stakeholder_internal_results = COALESCE(p_form_data->>'desemp_3b_results', ''),
    stakeholder_followup         = COALESCE(p_form_data->>'desemp_3b_plan',    ''),
    resources_current_situation  = COALESCE(p_form_data->>'recursos_current',  ''),
    resources_future_intentions  = COALESCE(p_form_data->>'recursos_future',   ''),
    risk_effectiveness_summary   = COALESCE(p_form_data->>'riesgos_measures',  ''),
    actions_to_take              = p_general_conclusions,
    updated_at                   = now()
  WHERE id = p_id;
END;
$$;

GRANT EXECUTE ON FUNCTION update_management_review(uuid,text,text,date,text,jsonb,jsonb,jsonb,jsonb) TO authenticated;

-- Verificar que quedó correctamente
SELECT routine_name, specific_name
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name = 'update_management_review';
