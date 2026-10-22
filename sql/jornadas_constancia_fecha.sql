-- Constancia de las Jornadas: solo disponible al terminar el evento
-- (23 oct 2026, 18:00 h Guadalajara). Ejecutar en el SQL Editor de Supabase.
-- ── FUNCIÓN: datos para la constancia (por folio o correo) — pública ─
create or replace function public.jornadas_constancia(
  p_folio text default null,
  p_email text default null
)
returns json
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v public.jornadas_participantes%rowtype;
  v_tnombre text;
begin
  -- La constancia solo se entrega al terminar las Jornadas
  if now() < timestamptz '2026-10-23 18:00:00-06' then
    return json_build_object('ok', false, 'code', 'NO_DISPONIBLE');
  end if;

  if p_folio is not null and length(trim(p_folio)) > 0 then
    select * into v from public.jornadas_participantes
      where upper(folio) = upper(trim(p_folio)) limit 1;
  elsif p_email is not null and length(trim(p_email)) > 0 then
    select * into v from public.jornadas_participantes
      where lower(email) = lower(trim(p_email)) limit 1;
  end if;

  if not found then
    return json_build_object('ok', false, 'code', 'NO_ENCONTRADO');
  end if;

  select nombre into v_tnombre from public.jornadas_talleres where num = v.taller;
  return json_build_object('ok', true,
    'folio', v.folio, 'nombre', v.nombre, 'categoria', v.categoria,
    'taller', v.taller, 'taller_nombre', v_tnombre,
    'fecha', to_char(v.created_at, 'YYYY-MM-DD'));
end;
$$;
