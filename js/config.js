// ─── Supabase Client ───────────────────────────────────────────
const SUPABASE_URL     = 'https://tdxkvvmdxnbarjsaknse.supabase.co'
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRkeGt2dm1keG5iYXJqc2FrbnNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY4MTcxNzUsImV4cCI6MjA5MjM5MzE3NX0.pxCo12p7H6JzAeDRlroZx5DkhZBcAeYEOQmVGwzSIAc'

const db = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY)
