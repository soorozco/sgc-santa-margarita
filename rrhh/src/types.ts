export enum UserRole {
  WORKER   = 'WORKER',
  MANAGER  = 'MANAGER',
  ADMIN_RH = 'ADMIN_RH',
}

export enum RequestStatus {
  PENDING          = 'PENDING',
  APPROVED_MANAGER = 'APPROVED_MANAGER',
  APPROVED_HR      = 'APPROVED_HR',
  REJECTED         = 'REJECTED',
}

export enum RequestType {
  VACATION   = 'VACATION',
  PASS_EXIT  = 'PASS_EXIT',
  PASS_ENTRY = 'PASS_ENTRY',
  SINDICAL   = 'SINDICAL',
  CONVENIO   = 'CONVENIO',
}

export enum ShiftCycleType {
  WEEKLY          = 'WEEKLY',
  ROTATING_24_48  = 'ROTATING_24_48',
  ROTATING_12     = 'ROTATING_12',
}

export interface ShiftSettings {
  id:        string
  name:      string
  startTime: string
  endTime:   string
  cycleType: ShiftCycleType
  restDay?:  number  // 0=Dom … 6=Sáb
}

export interface User {
  id:                 string
  name:               string
  email?:             string
  username?:          string
  hireDate:           string
  birthDate:          string
  area:               string
  position:           string
  shiftId:            string
  role:               UserRole
  vacationDays:       number
  sindicalDays:       number
  absences:           number
  delaysInMinutes:    number
  authorizes?:        string[]
  needsPasswordReset?: boolean
  customStartTime?:   string
  customEndTime?:     string
  customRestDay?:     number
}

export interface RequestRecord {
  id:              string
  userId:          string
  userName:        string
  type:            RequestType
  startDate:       string
  endDate:         string
  startTime?:      string
  endTime?:        string
  durationMinutes?: number
  reason:          string
  status:          RequestStatus
  createdAt:       string
  attachment?:     string
}
