#!/usr/bin/env python3
"""
Migração flow_crm -> synki_pulse05036308000100
Gera SQL que copia dados das tabelas comuns, respeitando colunas compatíveis.
Uso: python3 migrar.py  (gera migracao.sql)
      mysql -h HOST -u root -p < migracao.sql  (executa)
"""

import subprocess
import sys

HOST = "209.50.229.247"
USER = "root"
PASS = "@lface#81*"
SOURCE_DB = "flow_crm"
TARGET_DB = "synki_pulse05036308000100"
OUTPUT_SQL = "migracao.sql"

def run_mysql(sql):
    cmd = ["mysql", "-h", HOST, "-u", USER, "-N", "-e", "SET SESSION sql_mode=''; " + sql]
    r = subprocess.run(cmd, env={**__import__("os").environ, "MYSQL_PWD": PASS},
                       capture_output=True, text=True, timeout=30)
    if r.returncode != 0:
        raise Exception(r.stderr or r.stdout)
    return r.stdout.strip()

def get_tables():
    sql = """
    SELECT TABLE_NAME FROM information_schema.TABLES
    WHERE TABLE_SCHEMA=%r AND TABLE_TYPE='BASE TABLE'
    AND TABLE_NAME IN (SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA=%r)
    AND TABLE_NAME NOT LIKE 'view%%' AND TABLE_NAME NOT LIKE 'vw_%%'
    ORDER BY TABLE_NAME
    """ % (SOURCE_DB, TARGET_DB)
    out = run_mysql(sql)
    return [l.strip() for l in out.splitlines() if l.strip()]

def get_columns(db, table):
    sql = """
    SELECT COLUMN_NAME FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA=%r AND TABLE_NAME=%r ORDER BY ORDINAL_POSITION
    """ % (db, table)
    out = run_mysql(sql)
    return [l.strip() for l in out.splitlines() if l.strip()]

def main():
    tables = get_tables()
    print(f"Tabelas comuns (base): {len(tables)}", file=sys.stderr)
    lines = []
    lines.append("-- Migração flow_crm -> synki_pulse05036308000100")
    lines.append("-- Gerado automaticamente. Revise antes de executar.")
    lines.append("")
    lines.append("SET FOREIGN_KEY_CHECKS=0;")
    lines.append("SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO';")
    lines.append("")
    for t in tables:
        try:
            cols_src = set(get_columns(SOURCE_DB, t))
            cols_tgt = set(get_columns(TARGET_DB, t))
            common = sorted(cols_src & cols_tgt)
            if not common:
                lines.append(f"-- {t}: sem colunas em comum, pulando")
                continue
            cols_str = ", ".join(common)
            lines.append(f"-- {t}")
            lines.append(f"INSERT IGNORE INTO `{TARGET_DB}`.`{t}` ({cols_str})")
            lines.append(f"SELECT {cols_str} FROM `{SOURCE_DB}`.`{t}`;")
            lines.append("")
        except Exception as e:
            lines.append(f"-- ERRO {t}: {e}")
            lines.append("")
    lines.append("SET FOREIGN_KEY_CHECKS=1;")
    lines.append("")
    sql_content = "\n".join(lines)
    with open(OUTPUT_SQL, "w", encoding="utf-8") as f:
        f.write(sql_content)
    print(f"Arquivo gerado: {OUTPUT_SQL}", file=sys.stderr)

if __name__ == "__main__":
    main()
