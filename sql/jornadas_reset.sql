-- ══════════════════════════════════════════════════════════════════
-- Jornadas Médicas — REINICIAR registros (borra TODOS los participantes)
--
-- ⚠️ Úsalo SOLO para limpiar las pruebas antes de abrir el registro real.
-- Deja el contador en 0, los talleres vacíos y los folios vuelven a JM-001.
-- Es IRREVERSIBLE. Ejecutar en: Supabase → SQL Editor
-- ══════════════════════════════════════════════════════════════════

truncate table public.jornadas_participantes;
alter sequence public.jornadas_folio_seq restart with 1;

-- Verificación (debe mostrar registrados = 0, lugares_restantes = 150)
select public.jornadas_disponibilidad();
