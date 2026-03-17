#!/bin/bash
# Backup de todas as bases MySQL locais
# Uso: sudo ./backup-mysql-all.sh  (usa root sem senha)
#  ou:  MYSQL_PWD=sua_senha ./backup-mysql-all.sh -u root
#  ou:  ./backup-mysql-all.sh -u usuario -p  (pede senha)

DIR_BACKUP="/home/aurelio/FONTES/servers/backups-mysql"
DATA=$(date +%Y%m%d_%H%M%S)
ARQUIVO="${DIR_BACKUP}/mysql_all_${DATA}.sql"

mkdir -p "$DIR_BACKUP"

echo "=== Backup MySQL - $(date) ==="
echo "Destino: $ARQUIVO"

mysqldump --all-databases --routines --triggers --events --single-transaction --quick \
  --default-character-set=utf8mb4 \
  "$@" \
  > "$ARQUIVO" 2>/dev/null

if [ $? -eq 0 ]; then
  gzip "$ARQUIVO"
  echo "OK: ${ARQUIVO}.gz ($(du -h "${ARQUIVO}.gz" | cut -f1))"
else
  echo "ERRO no backup. Tente: sudo $0"
  rm -f "$ARQUIVO"
  exit 1
fi
