import { createClient } from '@supabase/supabase-js'

// Replace these with your actual Supabase project credentials
const supabaseUrl = 'https://qqdblvnqdklcyzrcyqyf.supabase.co'
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFxZGJsdm5xZGtsY3l6cmN5cXlmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA1ODQyNTksImV4cCI6MjA2NjE2MDI1OX0.2hjDlRBesxD7UBZCwC7dr_WHW28DGGlGcGhRJHKLWuM'

export const supabase = createClient(supabaseUrl, supabaseAnonKey)
