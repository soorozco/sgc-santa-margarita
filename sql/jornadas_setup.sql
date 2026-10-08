-- ══════════════════════════════════════════════════════════════════
-- PRIMERAS JORNADAS MÉDICAS — Registro público con control de cupo
-- Hospital Santa Margarita · 23 de octubre de 2026
--
-- Registro SIN login (rol anon) a través de FUNCIONES (no inserción directa),
-- para que el cupo se controle de forma ATÓMICA y nunca haya sobreventa:
--   • Cupo total del evento: 150
--   • Cupo por taller: 30 (3 talleres) → cuando un taller se llena, se oculta
--
-- El anónimo SOLO puede EJECUTAR las funciones (no leer ni escribir las tablas).
-- El personal con sesión (authenticated) puede LEER para el panel de conteo.
--
-- No borra nada. Re-ejecutable. Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

-- ── Tablas ──────────────────────────────────────────────────────────
create table if not exists public.jornadas_talleres (
  num     smallint primary key,
  nombre  text not null,
  coordina text,
  cupo    smallint not null default 30
);

insert into public.jornadas_talleres (num, nombre, coordina, cupo) values
  (1, 'Manejo de la vía aérea', 'Dra. Lesly Rivero Villalobos', 30),
  (2, 'Evaluación VExUS y USG', 'Dra. Iris Xóchitl Ortíz Macías', 30),
  (3, 'Herramientas de Inteligencia Artificial en Investigación en Salud', 'Dr. Julio César Mijangos Méndez', 30)
on conflict (num) do nothing;

create table if not exists public.jornadas_config (
  id              smallint primary key default 1,
  cupo_total      int not null default 150,
  registro_abierto boolean not null default true,
  constraint jornadas_config_single check (id = 1)
);
insert into public.jornadas_config (id) values (1) on conflict (id) do nothing;

create sequence if not exists public.jornadas_folio_seq start 1;

create table if not exists public.jornadas_participantes (
  id         uuid primary key default gen_random_uuid(),
  folio      text unique not null,
  nombre     text not null,
  email      text not null,
  telefono   text,
  categoria  text,
  taller     smallint references public.jornadas_talleres(num),
  medio      text not null default 'correo',   -- 'correo' | 'google'
  auth_uid   uuid,
  asistio    boolean not null default false,
  checkin_at timestamptz,
  created_at timestamptz not null default now()
);
create unique index if not exists jornadas_part_email_uidx
  on public.jornadas_participantes (lower(email));

-- ── RLS: nadie entra directo salvo el personal autenticado (solo lectura) ──
alter table public.jornadas_participantes enable row level security;
alter table public.jornadas_talleres     enable row level security;
alter table public.jornadas_config        enable row level security;

drop policy if exists jornadas_part_auth_read on public.jornadas_participantes;
create policy jornadas_part_auth_read on public.jornadas_participantes
  for select to authenticated using (true);

drop policy if exists jornadas_tall_read on public.jornadas_talleres;
create policy jornadas_tall_read on public.jornadas_talleres
  for select to authenticated using (true);

-- ── FUNCIÓN: disponibilidad (cupos restantes) — pública ─────────────
create or replace function public.jornadas_disponibilidad()
returns json
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_cfg   public.jornadas_config%rowtype;
  v_reg   int;
  v_tall  json;
begin
  select * into v_cfg from public.jornadas_config where id = 1;
  select count(*) into v_reg from public.jornadas_participantes;

  select json_agg(t) into v_tall from (
    select x.num, x.nombre, x.coordina, x.cupo,
           coalesce(c.ocupados,0) as ocupados,
           greatest(x.cupo - coalesce(c.ocupados,0),0) as restantes
    from public.jornadas_talleres x
    left join (
      select taller, count(*) ocupados
      from public.jornadas_participantes
      where taller is not null
      group by taller
    ) c on c.taller = x.num
    order by x.num
  ) t;

  return json_build_object(
    'cupo_total',       v_cfg.cupo_total,
    'registrados',      v_reg,
    'lugares_restantes',greatest(v_cfg.cupo_total - v_reg, 0),
    'registro_abierto', v_cfg.registro_abierto and v_reg < v_cfg.cupo_total,
    'talleres',         coalesce(v_tall, '[]'::json)
  );
end;
$$;

-- ── FUNCIÓN: registrar participante (atómica, anti-sobreventa) ──────
create or replace function public.jornadas_registrar(
  p_nombre    text,
  p_email     text,
  p_telefono  text default null,
  p_categoria text default null,
  p_taller    smallint default null,
  p_medio     text default 'correo',
  p_auth_uid  uuid default null
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
  -- Serializa los registros para que los conteos sean exactos bajo concurrencia
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
    (folio, nombre, email, telefono, categoria, taller, medio, auth_uid)
  values
    (v_folio, v_nombre, v_email, nullif(trim(coalesce(p_telefono,'')),''),
     nullif(trim(coalesce(p_categoria,'')),''), p_taller,
     coalesce(p_medio,'correo'), p_auth_uid);

  return json_build_object('ok', true,
    'folio', v_folio, 'nombre', v_nombre, 'email', v_email,
    'categoria', p_categoria, 'taller', p_taller, 'taller_nombre', v_tnombre);
end;
$$;

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

-- ── Permisos: anon y authenticated solo EJECUTAN las funciones ──────
revoke all on function public.jornadas_disponibilidad()           from public;
revoke all on function public.jornadas_registrar(text,text,text,text,smallint,text,uuid) from public;
revoke all on function public.jornadas_constancia(text,text)      from public;

grant execute on function public.jornadas_disponibilidad()        to anon, authenticated;
grant execute on function public.jornadas_registrar(text,text,text,text,smallint,text,uuid) to anon, authenticated;
grant execute on function public.jornadas_constancia(text,text)   to anon, authenticated;

-- Panel de conteo (personal autenticado)
grant select on public.jornadas_participantes to authenticated;
grant select on public.jornadas_talleres      to authenticated;

-- Verificación rápida
select public.jornadas_disponibilidad();
