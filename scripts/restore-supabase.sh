#!/bin/bash
set -e

echo "🚀 Supabase Project Restoration Script"
echo "====================================="

# Check prerequisites
if ! command -v supabase &> /dev/null; then
    echo "❌ Error: Supabase CLI not installed"
    echo "Install from: https://supabase.com/docs/guides/cli"
    exit 1
fi

# Find the latest backup
LATEST_BACKUP=$(ls -d prisma/backups/*/ 2>/dev/null | sort -r | head -n 1)
if [ -z "$LATEST_BACKUP" ]; then
    echo "❌ Error: No backups found in prisma/backups/"
    exit 1
fi

echo "📁 Using backup from: $LATEST_BACKUP"
echo ""

# Check if we have a config.toml
if [ ! -f "supabase/config.toml" ]; then
    if [ -f "${LATEST_BACKUP}config.toml" ]; then
        echo "📋 Restoring config.toml from backup..."
        cp "${LATEST_BACKUP}config.toml" supabase/config.toml
    else
        echo "⚠️  No config.toml found. You'll need to run 'supabase init' first"
        echo "Then update the config.toml with your project settings"
        exit 1
    fi
fi

echo ""
echo "📋 Prerequisites:"
echo "1. Create a new project at https://app.supabase.com"
echo "2. Have your project ID and database password ready"
echo ""
read -p "Press Enter when ready to continue..."

# Get project details
echo ""
read -p "Enter your new project ID (e.g., xyzxyzxyzxyzxyz): " PROJECT_ID
read -sp "Enter your database password: " DB_PASSWORD
echo ""

# Update config.toml with new project ID
if [ -f "supabase/config.toml" ]; then
    sed -i.bak "s/id = \".*\"/id = \"$PROJECT_ID\"/" supabase/config.toml
    echo "✅ Updated config.toml with new project ID"
fi

# Link to the new project
echo ""
echo "🔗 Linking to Supabase project..."
supabase link --project-ref "$PROJECT_ID" --password "$DB_PASSWORD"

# Apply migrations
echo ""
echo "📊 Applying database schema..."
supabase db push

# Seed the database
if [ -f "supabase/seed.sql" ]; then
    echo ""
    echo "🌱 Seeding database..."
    supabase db seed
fi

# Show post-restoration tasks
echo ""
echo "✅ Database restoration complete!"
echo ""
echo "📝 Review these backup files for additional configuration:"
echo "   - ${LATEST_BACKUP}project_info.md"
echo "   - ${LATEST_BACKUP}storage_buckets.txt"
echo "   - ${LATEST_BACKUP}roles_summary.tsv"
echo ""
echo "⚠️  Manual steps required:"
echo "1. Go to your Supabase project dashboard"
echo "2. Configure Authentication:"
echo "   - Enable Email/Password auth if needed"
echo "   - Set up OAuth providers (Google, GitHub, etc.)"
echo "   - Configure email templates"
echo "3. Create Storage buckets (check ${LATEST_BACKUP}storage_buckets.txt)"
echo "4. Update your .env file with new project credentials"
echo "5. Configure any Edge Functions"
echo "6. Enable any PostgreSQL extensions you were using"
