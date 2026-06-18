import { RequestStatus, ShiftCycleType, ShiftSettings } from './types'

// ── Áreas del Hospital Santa Margarita ────────────────────────────
export const AREAS: string[] = [
  'Capital Humano',
  'Calidad',
  'Dirección General',
  'Dirección Médica',
  'Enfermería',
  'Urgencias',
  'Cirugía General',
  'Quirófano',
  'Anestesiología',
  'Gineco-Obstetricia',
  'Pediatría',
  'UCI / Terapia Intensiva',
  'Medicina Interna',
  'Laboratorio Clínico',
  'Banco de Sangre',
  'Imagenología / Radiología',
  'Farmacia',
  'Inhaloterapia',
  'Trabajo Social',
  'Nutrición y Dietética',
  'Cocina y Comedor',
  'Almacén',
  'Compras',
  'Contabilidad',
  'Sistemas',
  'Mantenimiento y Biomedica',
  'Seguridad',
]

// ── Puestos por área ──────────────────────────────────────────────
export const DEPARTMENTS_DATA: Record<string, string[]> = {
  'Capital Humano': ['Jefe de Capital Humano', 'Coordinador de Nómina', 'Auxiliar de RRHH', 'Reclutador'],
  'Calidad': ['Responsable de Calidad', 'Auditor Interno', 'Auxiliar de Calidad'],
  'Dirección General': ['Director General', 'Asistente de Dirección', 'Coordinador Administrativo'],
  'Dirección Médica': ['Director Médico', 'Subdirector Médico', 'Coordinador Médico'],
  'Enfermería': ['Jefe de Enfermería', 'Enfermera General', 'Enfermera Especialista', 'Auxiliar de Enfermería', 'Camillero'],
  'Urgencias': ['Médico de Urgencias', 'Enfermera de Urgencias', 'Triage', 'Auxiliar de Urgencias'],
  'Cirugía General': ['Cirujano General', 'Residente de Cirugía', 'Instrumentista Quirúrgico'],
  'Quirófano': ['Enfermera de Quirófano', 'Instrumentista', 'Auxiliar de Quirófano', 'Anestesiólogo'],
  'Anestesiología': ['Anestesiólogo', 'Residente de Anestesiología'],
  'Gineco-Obstetricia': ['Gineco-Obstetra', 'Enfermera de Obstetricia', 'Partera'],
  'Pediatría': ['Pediatra', 'Neonatólogo', 'Enfermera de Pediatría'],
  'UCI / Terapia Intensiva': ['Jefe de UCI', 'Intensivista', 'Enfermera UCI', 'Auxiliar UCI'],
  'Medicina Interna': ['Internista', 'Residente de Medicina Interna'],
  'Laboratorio Clínico': ['Jefe de Laboratorio', 'Químico Clínico', 'Técnico de Laboratorio', 'Flebotomista'],
  'Banco de Sangre': ['Responsable de Banco de Sangre', 'Técnico de Banco de Sangre'],
  'Imagenología / Radiología': ['Radiólogo', 'Técnico Radiólogo', 'Técnico en Ultrasonido'],
  'Farmacia': ['Químico Farmacéutico', 'Auxiliar de Farmacia'],
  'Inhaloterapia': ['Inhaloterapista', 'Técnico en Inhaloterapia'],
  'Trabajo Social': ['Trabajadora Social', 'Auxiliar de Trabajo Social'],
  'Nutrición y Dietética': ['Nutriólogo Clínico', 'Auxiliar de Nutrición'],
  'Cocina y Comedor': ['Jefa de Cocina y Comedor', 'Cocinera', 'Auxiliar de Cocina', 'Afanadora de Cocina'],
  'Almacén': ['Jefe de Almacén', 'Auxiliar de Almacén', 'Almacenista'],
  'Compras': ['Jefe de Compras', 'Auxiliar de Compras', 'Cotizador'],
  'Contabilidad': ['Contador General', 'Auxiliar Contable', 'Cuentas por Pagar'],
  'Sistemas': ['Jefe de Sistemas', 'Técnico en Sistemas', 'Soporte Técnico'],
  'Mantenimiento y Biomedica': ['Jefe de Mantenimiento', 'Técnico de Mantenimiento', 'Ingeniero Biomédico', 'Auxiliar de Mantenimiento'],
  'Seguridad': ['Jefe de Seguridad', 'Guardia de Seguridad'],
}

// ── Turnos por defecto ─────────────────────────────────────────────
export const DEFAULT_SHIFTS: ShiftSettings[] = [
  { id: 't-matutino',   name: 'Matutino',            startTime: '07:00', endTime: '14:00', cycleType: ShiftCycleType.WEEKLY, restDay: 0 },
  { id: 't-vespertino', name: 'Vespertino',           startTime: '14:00', endTime: '21:00', cycleType: ShiftCycleType.WEEKLY, restDay: 0 },
  { id: 't-nocturno',   name: 'Nocturno',             startTime: '21:00', endTime: '07:00', cycleType: ShiftCycleType.WEEKLY, restDay: 0 },
  { id: 't-admin',      name: 'Administrativo',       startTime: '08:00', endTime: '16:00', cycleType: ShiftCycleType.WEEKLY, restDay: 0 },
  { id: 't-24-48',      name: 'Guardia 24×48',        startTime: '07:00', endTime: '07:00', cycleType: ShiftCycleType.ROTATING_24_48 },
  { id: 't-12-12',      name: 'Turno 12h Rotatorio',  startTime: '07:00', endTime: '19:00', cycleType: ShiftCycleType.ROTATING_12 },
]

// ── Estado de solicitudes ──────────────────────────────────────────
export const getStatusConfig = (status: RequestStatus) => {
  switch (status) {
    case RequestStatus.APPROVED_HR:      return { label: 'Aprobado',    color: 'bg-emerald-100 text-emerald-800' }
    case RequestStatus.APPROVED_MANAGER: return { label: 'En proceso',  color: 'bg-blue-100 text-blue-800' }
    case RequestStatus.REJECTED:         return { label: 'Rechazado',   color: 'bg-red-100 text-red-800' }
    default:                             return { label: 'Pendiente',   color: 'bg-amber-100 text-amber-800' }
  }
}
