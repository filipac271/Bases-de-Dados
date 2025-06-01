#!/bin/bash

USER="root"
PASSWORD="root"
DATABASE="BelaRentaCar"
BACKUP_DIR="$(dirname "$(realpath "$0")")/backups"


mkdir -p "$BACKUP_DIR"

DATA=$(date +"%Y-%m-%d")
BACKUP_FILE="${BACKUP_DIR}/backup_${DATABASE}_${DATA}.sql"

mysqldump -u "$USER" -p"$PASSWORD" "$DATABASE" > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
  echo "Backup feito com sucesso: $BACKUP_FILE"
else
  echo "Erro ao fazer backup"
fi
