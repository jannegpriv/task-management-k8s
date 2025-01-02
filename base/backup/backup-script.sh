#!/bin/bash
set -e

# Configuration
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="postgres_backup_${TIMESTAMP}.sql.gz"

echo "Starting database backup at ${TIMESTAMP}"

# Extract database connection details from DATABASE_URL
# Format: postgresql://username:password@host:port/dbname
if [[ $DATABASE_URL =~ postgresql://([^:]+):([^@]+)@([^:]+):([^/]+)/(.+) ]]; then
    DB_USER="${BASH_REMATCH[1]}"
    DB_PASS="${BASH_REMATCH[2]}"
    DB_HOST="${BASH_REMATCH[3]}"
    DB_PORT="${BASH_REMATCH[4]}"
    DB_NAME="${BASH_REMATCH[5]}"
else
    echo "Error: Invalid DATABASE_URL format"
    exit 1
fi

# Perform PostgreSQL dump
echo "Creating database dump..."
PGPASSWORD="$DB_PASS" pg_dump \
    -h "$DB_HOST" \
    -p "$DB_PORT" \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    | gzip > "/tmp/${BACKUP_FILE}"

echo "Database dump completed"

# Upload to B2
echo "Uploading to Backblaze B2..."
b2 authorize-account "$B2_APPLICATION_KEY_ID" "$B2_APPLICATION_KEY"
b2 upload-file "$B2_BUCKET_NAME" "/tmp/${BACKUP_FILE}" "backups/${BACKUP_FILE}"

echo "Upload completed"

# Cleanup
echo "Cleaning up temporary files..."
rm "/tmp/${BACKUP_FILE}"

echo "Backup process completed successfully"
