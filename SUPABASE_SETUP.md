# Supabase Project Setup Guide

## 🎯 Purpose
This repository contains complete backups of a Supabase project that can be restored to a new project at any time.

## 📁 Backup Structure
```
prisma/backups/
└── YYYY-MM-DD-THH-MM/     # Timestamped backups
    ├── schema.sql          # Complete database schema
    ├── data.sql            # All data
    ├── roles_summary.tsv   # Role information
    ├── storage_buckets.txt # Storage configuration
    ├── project_info.md     # Project metadata
    └── config.toml         # Supabase configuration (if exists)

supabase/
├── migrations/             # Schema migrations
└── seed.sql               # Seed data
```

## 🚀 Quick Restoration

### 1. Prerequisites
- [Supabase CLI](https://supabase.com/docs/guides/cli) installed
- [Supabase account](https://app.supabase.com)
- Node.js/npm (if this is a web project)

### 2. Create New Project
1. Go to [Supabase Dashboard](https://app.supabase.com)
2. Click "New Project"
3. Choose organization and set:
   - Project name
   - Database password (save this!)
   - Region (choose closest)
4. Wait for project to initialize (~2 minutes)

### 3. Run Restoration Script
```bash
# From project root directory
./scripts/restore-supabase.sh
```

The script will:
- Find your latest backup automatically
- Guide you through the restoration process
- Apply schema and seed data

### 4. Manual Configuration
After running the script, configure in Supabase Dashboard:

#### Authentication Tab:
- Enable Email provider
- Configure OAuth providers if needed
- Set Site URL to your app URL
- Configure email templates

#### Storage Tab:
- Check `prisma/backups/[latest]/storage_buckets.txt` for your buckets
- Create buckets with the same names and settings
- Set up bucket policies

#### Database Tab:
- Check `prisma/backups/[latest]/project_info.md` for extensions
- Enable any extensions you were using

#### Settings Tab:
- Copy API keys to your `.env` file
- Configure any custom settings

## 💰 Cost Savings
- **Active project**: ~$25/month
- **Backed up project**: $0/month
- **Restoration time**: ~10 minutes
- **Savings per year**: ~$300

## ⚠️ Limitations
- User accounts are not backed up (for security)
- OAuth app credentials need to be reconfigured
- Storage files are not backed up (only bucket config)
- Some settings must be manually configured in dashboard

## 🔧 Troubleshooting
- If migrations fail, check `supabase/migrations/` for syntax errors
- For auth issues, ensure providers are enabled in dashboard
- For storage issues, verify bucket names match your code
- Check backup timestamps to ensure you're using the right backup
