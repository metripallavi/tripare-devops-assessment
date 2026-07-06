#!/bin/bash

set -e

BACKUP_DIR="./database/backups"

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

BACKUP_FILE="$BACKUP_DIR/hoteldb_$TIMESTAMP.sql"

docker exec hotel-postgres pg_dump \
    -U postgres \
    -d hoteldb \
    > "$BACKUP_FILE"

echo "Backup created successfully:"
echo "$BACKUP_FILE"
