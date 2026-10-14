-- ══════════════════════════════════════════════════════════════════
-- Jornadas Médicas — Normalizar la columna 'profesion' a valores fijos
--
-- Unifica variantes capturadas como texto libre (ej. "medico", "Médico",
-- "enfermera") a los valores oficiales del desplegable, para que la
-- estadística de "Inscritos por profesión" salga correcta.
--
-- Valores oficiales: Médico · Enfermería · Terapeuta Respiratorio ·
-- Estudiante · Otro personal de la salud.
-- Lo que no coincida se deja igual (el personal lo corrige desde el panel).
--
-- Solo cambia el texto de 'profesion'. No borra nada. Re-ejecutable.
-- Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

update public.jornadas_participantes
set profesion = case
  when lower(translate(profesion,'áéíóúÁÉÍÓÚ','aeiouaeiou')) like '%medic%'     then 'Médico'
  when lower(translate(profesion,'áéíóúÁÉÍÓÚ','aeiouaeiou')) like '%enferm%'    then 'Enfermería'
  when lower(translate(profesion,'áéíóúÁÉÍÓÚ','aeiouaeiou')) like '%terap%'
    or lower(translate(profesion,'áéíóúÁÉÍÓÚ','aeiouaeiou')) like '%inhalo%'
    or lower(translate(profesion,'áéíóúÁÉÍÓÚ','aeiouaeiou')) like '%respirat%'  then 'Terapeuta Respiratorio'
  when lower(translate(profesion,'áéíóúÁÉÍÓÚ','aeiouaeiou')) like '%estudi%'    then 'Estudiante'
  else profesion
end
where profesion is not null and trim(profesion) <> '';

-- Ver cómo quedó la distribución
select coalesce(profesion,'(sin dato)') as profesion, count(*)
from public.jornadas_participantes
group by 1 order by 2 desc;
