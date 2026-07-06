#!/bin/bash

set -e

if [ $# -ne 1 ]; then
    echo "Usage: ./scripts/restore.sh <backup-file>"
    exit 1
fi

BACKUP_FILE=$1

docker exec -i hotel-postgres psql -U postgres -d hoteldb < "$BACKUP_FILE"

echo "Database restored successfully."