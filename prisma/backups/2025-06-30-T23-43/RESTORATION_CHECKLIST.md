# Restoration Checklist

## Backup Information
- Backup Date: 2025-06-30-T23-43
- Location: prisma/backups/2025-06-30-T23-43/

## Before Shutdown
- [x] Database schema backed up
- [x] Data backed up  
- [x] Storage bucket configuration saved
- [x] Role information exported
- [x] Project configuration documented
- [ ] Note any custom email templates
- [ ] Document OAuth app credentials (client IDs)
- [ ] Export any user data you need to preserve

## After Creating New Project
- [ ] Run `./scripts/restore-supabase.sh`
- [ ] Enable Email Authentication
- [ ] Configure OAuth providers:
  - [ ] Google (if used)
  - [ ] GitHub (if used)
  - [ ] Others: ________________
- [ ] Create storage buckets:
  - [ ] Check `storage_buckets.txt` for list
- [ ] Update `.env` with new credentials:
  - [ ] NEXT_PUBLIC_SUPABASE_URL
  - [ ] NEXT_PUBLIC_SUPABASE_ANON_KEY  
  - [ ] SUPABASE_SERVICE_ROLE_KEY
- [ ] Enable PostgreSQL extensions (check `project_info.md`)
- [ ] Configure email templates
- [ ] Set correct Site URL in Auth settings
- [ ] Test authentication flow
- [ ] Test database queries
- [ ] Test storage operations

## Project-Specific Notes
_Add any custom configuration notes here:_
