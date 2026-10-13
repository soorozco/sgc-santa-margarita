-- ══════════════════════════════════════════════════════════════════
-- Jornadas Médicas — Corregir datos de un inscrito (desde el panel)
--
-- Permite al PERSONAL autenticado corregir el nombre y datos personales
-- de un registro (ej. un nombre mal escrito). NO cambia correo, folio ni
-- taller. Solo el rol 'authenticated' puede ejecutarla (anon NO).
--
-- Requiere: sql/jornadas_setup.sql. No borra nada. Re-ejecutable.
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

create or replace function public.jornadas_editar(
  p_id              uuid,
  p_nombre          text,
  p_edad            smallint default null,
  p_sexo            text default null,
  p_municipio       text default null,
  p_estado          text default null,
  p_pais            text default null,
  p_grado_academico text default null,
  p_profesion       text default null,
  p_especialidad    text default null,
  p_universidad     text default null,
  p_institucion     text default null,
  p_telefono        text default null
)
returns json
language plpgsql
security definer
set search_path = public, pg_temp
as $$
begin
  if p_nombre is null or length(trim(p_nombre)) < 3 then
    return json_build_object('ok', false, 'code', 'NOMBRE_INVALIDO');
  end if;

  update public.jornadas_participantes set
    nombre                  = trim(p_nombre),
    edad                    = p_edad,
    sexo                    = nullif(trim(coalesce(p_sexo,'')),''),
    municipio               = nullif(trim(coalesce(p_municipio,'')),''),
    estado                  = nullif(trim(coalesce(p_estado,'')),''),
    pais                    = nullif(trim(coalesce(p_pais,'')),''),
    grado_academico         = nullif(trim(coalesce(p_grado_academico,'')),''),
    profesion               = nullif(trim(coalesce(p_profesion,'')),''),
    especialidad            = nullif(trim(coalesce(p_especialidad,'')),''),
    universidad             = nullif(trim(coalesce(p_universidad,'')),''),
    institucion_procedencia = nullif(trim(coalesce(p_institucion,'')),''),
    telefono                = nullif(trim(coalesce(p_telefono,'')),'')
  where id = p_id;

  if not found then
    return json_build_object('ok', false, 'code', 'NO_ENCONTRADO');
  end if;
  return json_build_object('ok', true);
end;
$$;

-- Solo personal autenticado (nunca anon)
revoke all on function public.jornadas_editar(uuid,text,smallint,text,text,text,text,text,text,text,text,text,text) from public, anon;
grant execute on function public.jornadas_editar(uuid,text,smallint,text,text,text,text,text,text,text,text,text,text) to authenticated;

select 'ok' as estado;
