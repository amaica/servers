#!/bin/bash
# Gera migracao.sql com INSERT apenas nas colunas comuns (flow_crm -> synki_pulse05036308000100)
# Uso: MYSQL_PWD='@lface#81*' ./gerar-migracao.sh

set -e
HOST="209.50.229.247"
USER="root"
SOURCE="flow_crm"
TARGET="synki_pulse05036308000100"
OUT="migracao.sql"

echo "-- Migração $SOURCE -> $TARGET" > "$OUT"
echo "-- Colunas comuns apenas. Execute: mysql -h $HOST -u $USER -p < $OUT" >> "$OUT"
echo "" >> "$OUT"
echo "SET FOREIGN_KEY_CHECKS=0;" >> "$OUT"
echo "SET SESSION sql_mode='NO_ENGINE_SUBSTITUTION';" >> "$OUT"
echo "" >> "$OUT"

TABLES=$(mysql -h "$HOST" -u "$USER" -N -e "
SELECT t.TABLE_NAME FROM information_schema.TABLES t
WHERE t.TABLE_SCHEMA='$SOURCE' AND t.TABLE_TYPE='BASE TABLE'
AND t.TABLE_NAME IN (SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA='$TARGET')
AND t.TABLE_NAME NOT LIKE 'view%' AND t.TABLE_NAME NOT LIKE 'vw_%'
ORDER BY t.TABLE_NAME;
")

n=0
for T in $TABLES; do
  n=$((n+1))
  echo "[$n] $T" >&2
  COLS_SRC=$(mysql -h "$HOST" -u "$USER" -N -e "SELECT COLUMN_NAME FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='$SOURCE' AND TABLE_NAME='$T' ORDER BY ORDINAL_POSITION;" | tr '\n' ',' | sed 's/,$//')
  COLS_TGT=$(mysql -h "$HOST" -u "$USER" -N -e "SELECT COLUMN_NAME FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='$TARGET' AND TABLE_NAME='$T' ORDER BY ORDINAL_POSITION;" | tr '\n' ',' | sed 's/,$//')
  # Colunas comuns (que existem nos dois) - por ordem da origem
  COMMON=""
  for c in $(echo "$COLS_SRC" | tr ',' '\n'); do
    if echo "$COLS_TGT" | tr ',' '\n' | grep -qFx "$c"; then
      [ -n "$COMMON" ] && COMMON="$COMMON, "
      COMMON="${COMMON}\`$c\`"
    fi
  done
  if [ -z "$COMMON" ]; then
    echo "-- $T: sem colunas em comum" >> "$OUT"
  else
    echo "-- $T" >> "$OUT"
    echo "INSERT IGNORE INTO \`$TARGET\`.\`$T\` ($COMMON) SELECT $COMMON FROM \`$SOURCE\`.\`$T\`;" >> "$OUT"
    echo "" >> "$OUT"
  fi
done

echo "SET FOREIGN_KEY_CHECKS=1;" >> "$OUT"
echo "" >> "$OUT"
echo "Gerado: $OUT ($(wc -l < "$OUT") linhas)" >&2
