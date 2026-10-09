-- ══════════════════════════════════════════════════════════════════
-- Jornadas Médicas — campos adicionales del registro
--
-- Agrega: edad, sexo, municipio, estado, país, grado académico,
--         profesión, especialidad, universidad, institución de procedencia.
-- Reemplaza la función jornadas_registrar para recibir y guardar estos campos
-- (se quita 'categoría' del formulario; la columna vieja se conserva por si hay datos).
--
-- Requiere haber corrido antes: sql/jornadas_setup.sql
-- No borra datos. Re-ejecutable. Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- 1) Nuevas columnas
alter table public.jornadas_participantes
  add column if not exists edad          smallint,
  add column if not exists sexo          text,
  add column if not exists municipio     text,
  add column if not exists estado        text,
  add column if not exists pais          text,
  add column if not exists grado_academico text,
  add column if not exists profesion     text,
  add column if not exists especialidad  text,
  add column if not exists universidad   text,
  add column if not exists institucion_procedencia text;

-- 2) Nueva versión de la función de registro (atómica, anti-sobreventa)
--    Se elimina la firma anterior (cambió la lista de parámetros).
drop function if exists public.jornadas_registrar(text,text,text,text,smallint,text,uuid);

create or replace function public.jornadas_registrar(
  p_nombre     text,
  p_email      text,
  p_telefono   text default null,
  p_taller     smallint default null,
  p_medio      text default 'correo',
  p_auth_uid   uuid default null,
  p_edad       smallint default null,
  p_sexo       text default null,
  p_municipio  text default null,
  p_estado     text default null,
  p_pais       text default null,
  p_grado_academico text default null,
  p_profesion  text default null,
  p_especialidad text default null,
  p_universidad  text default null,
  p_institucion  text default null
)
returns json
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_cfg      public.jornadas_config%rowtype;
  v_email    text := lower(trim(p_email));
  v_nombre   text := trim(p_nombre);
  v_reg      int;
  v_exist    public.jornadas_participantes%rowtype;
  v_cupo     smallint;
  v_ocup     int;
  v_folio    text;
  v_tnombre  text;
begin
  perform pg_advisory_xact_lock(778899123);

  if v_nombre is null or length(v_nombre) < 3 then
    return json_build_object('ok', false, 'code', 'NOMBRE_INVALIDO');
  end if;
  if v_email is null or v_email !~ '^[^@\s]+@[^@\s]+\.[^@\s]+$' then
    return json_build_object('ok', false, 'code', 'CORREO_INVALIDO');
  end if;

  select * into v_cfg from public.jornadas_config where id = 1;

  -- ¿ya registrado con ese correo? → devolvemos su folio (para reimprimir pase)
  select * into v_exist from public.jornadas_participantes
    where lower(email) = v_email limit 1;
  if found then
    select nombre into v_tnombre from public.jornadas_talleres where num = v_exist.taller;
    return json_build_object('ok', false, 'code', 'YA_REGISTRADO',
      'folio', v_exist.folio, 'nombre', v_exist.nombre,
      'profesion', v_exist.profesion, 'grado_academico', v_exist.grado_academico,
      'taller', v_exist.taller, 'taller_nombre', v_tnombre);
  end if;

  -- cupo total
  select count(*) into v_reg from public.jornadas_participantes;
  if not v_cfg.registro_abierto or v_reg >= v_cfg.cupo_total then
    return json_build_object('ok', false, 'code', 'EVENTO_LLENO');
  end if;

  -- taller (opcional)
  if p_taller is not null then
    select cupo into v_cupo from public.jornadas_talleres where num = p_taller;
    if v_cupo is null then
      return json_build_object('ok', false, 'code', 'TALLER_INVALIDO');
    end if;
    select count(*) into v_ocup from public.jornadas_participantes where taller = p_taller;
    if v_ocup >= v_cupo then
      return json_build_object('ok', false, 'code', 'TALLER_LLENO', 'taller', p_taller);
    end if;
    select nombre into v_tnombre from public.jornadas_talleres where num = p_taller;
  end if;

  v_folio := 'JM-' || lpad(nextval('public.jornadas_folio_seq')::text, 3, '0');

  insert into public.jornadas_participantes
    (folio, nombre, email, telefono, taller, medio, auth_uid,
     edad, sexo, municipio, estado, pais, grado_academico, profesion,
     especialidad, universidad, institucion_procedencia)
  values
    (v_folio, v_nombre, v_email, nullif(trim(coalesce(p_telefono,'')),''),
     p_taller, coalesce(p_medio,'correo'), p_auth_uid,
     p_edad,
     nullif(trim(coalesce(p_sexo,'')),''),
     nullif(trim(coalesce(p_municipio,'')),''),
     nullif(trim(coalesce(p_estado,'')),''),
     nullif(trim(coalesce(p_pais,'')),''),
     nullif(trim(coalesce(p_grado_academico,'')),''),
     nullif(trim(coalesce(p_profesion,'')),''),
     nullif(trim(coalesce(p_especialidad,'')),''),
     nullif(trim(coalesce(p_universidad,'')),''),
     nullif(trim(coalesce(p_institucion,'')),''));

  return json_build_object('ok', true,
    'folio', v_folio, 'nombre', v_nombre, 'email', v_email,
    'profesion', p_profesion, 'grado_academico', p_grado_academico,
    'taller', p_taller, 'taller_nombre', v_tnombre);
end;
$$;

-- 3) Permisos: anon y authenticated solo EJECUTAN
revoke all on function public.jornadas_registrar(text,text,text,smallint,text,uuid,smallint,text,text,text,text,text,text,text,text,text) from public;
grant execute on function public.jornadas_registrar(text,text,text,smallint,text,uuid,smallint,text,text,text,text,text,text,text,text,text) to anon, authenticated;

-- Verificación
select public.jornadas_disponibilidad();
