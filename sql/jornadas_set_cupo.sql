-- ══════════════════════════════════════════════════════════════════
-- Jornadas Médicas — Ajustar cupos (uso emergente, desde el panel)
--
-- Permite AUMENTAR (o cambiar) el cupo total del evento o el de un taller
-- SIN afectar las inscripciones existentes. Nunca deja poner un cupo por
-- debajo de lo ya inscrito. Solo el rol 'authenticated' puede ejecutarla
-- (el público/anónimo NO).
--
-- Requiere: sql/jornadas_setup.sql. No borra nada. Re-ejecutable.
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

create or replace function public.jornadas_set_cupo(
  p_que    text,                 -- 'total' | 'taller'
  p_cupo   int,
  p_taller smallint default null
)
returns json
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_ocup int;
begin
  if p_cupo is null or p_cupo < 1 then
    return json_build_object('ok', false, 'code', 'CUPO_INVALIDO');
  end if;

  if p_que = 'total' then
    select count(*) into v_ocup from public.jornadas_participantes;
    if p_cupo < v_ocup then
      return json_build_object('ok', false, 'code', 'MENOR_QUE_INSCRITOS', 'inscritos', v_ocup);
    end if;
    update public.jornadas_config set cupo_total = p_cupo where id = 1;

  elsif p_que = 'taller' then
    if p_taller is null then
      return json_build_object('ok', false, 'code', 'TALLER_REQUERIDO');
    end if;
    select count(*) into v_ocup from public.jornadas_participantes where taller = p_taller;
    if p_cupo < v_ocup then
      return json_build_object('ok', false, 'code', 'MENOR_QUE_INSCRITOS', 'inscritos', v_ocup);
    end if;
    update public.jornadas_talleres set cupo = p_cupo where num = p_taller;
    if not found then
      return json_build_object('ok', false, 'code', 'TALLER_INVALIDO');
    end if;

  else
    return json_build_object('ok', false, 'code', 'TIPO_INVALIDO');
  end if;

  return json_build_object('ok', true, 'disponibilidad', public.jornadas_disponibilidad());
end;
$$;

-- Solo personal autenticado (nunca anon)
revoke all on function public.jornadas_set_cupo(text,int,smallint) from public, anon;
grant execute on function public.jornadas_set_cupo(text,int,smallint) to authenticated;

select 'ok' as estado;
