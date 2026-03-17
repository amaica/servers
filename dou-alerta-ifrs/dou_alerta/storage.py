"""Armazenamento SQLite para deduplicação."""

from __future__ import annotations

import logging
import sqlite3
from pathlib import Path
from typing import Optional

from dou_alerta.config import config
from dou_alerta.models import DouItem

logger = logging.getLogger(__name__)


def get_db_path() -> Path:
    return Path(config.DB_PATH)


def init_db(path: Path | None = None) -> None:
    p = path or get_db_path()
    p.parent.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(str(p))
    conn.execute("""
        CREATE TABLE IF NOT EXISTS items (
            hash TEXT PRIMARY KEY,
            date TEXT NOT NULL,
            title TEXT,
            url TEXT,
            score REAL,
            created_at TEXT DEFAULT (datetime('now'))
        )
    """)
    conn.commit()
    conn.close()
    logger.info("DB inicializado em %s", p)


def exists(hash_id: str, path: Path | None = None) -> bool:
    p = path or get_db_path()
    conn = sqlite3.connect(str(p))
    cur = conn.execute("SELECT 1 FROM items WHERE hash = ?", (hash_id,))
    row = cur.fetchone()
    conn.close()
    return row is not None


def insert(item: DouItem, score: float = 0.0, path: Path | None = None) -> None:
    p = path or get_db_path()
    conn = sqlite3.connect(str(p))
    conn.execute(
        "INSERT OR IGNORE INTO items (hash, date, title, url, score) VALUES (?, ?, ?, ?, ?)",
        (item.id_hash, item.date, item.title[:500], item.url[:1000], score),
    )
    conn.commit()
    conn.close()
    logger.debug("Inserido hash=%s", item.id_hash[:16])


def insert_many(items: list[tuple[DouItem, float]], path: Path | None = None) -> int:
    p = path or get_db_path()
    conn = sqlite3.connect(str(p))
    count = 0
    for item, score in items:
        try:
            conn.execute(
                "INSERT OR IGNORE INTO items (hash, date, title, url, score) VALUES (?, ?, ?, ?, ?)",
                (item.id_hash, item.date, item.title[:500], item.url[:1000], score),
            )
            count += 1
        except Exception as e:
            logger.debug("Erro ao inserir %s: %s", item.id_hash[:16], e)
    conn.commit()
    conn.close()
    return count


def filter_new(items: list[DouItem], path: Path | None = None) -> list[DouItem]:
    """Retorna apenas itens que ainda não estão no banco."""
    p = path or get_db_path()
    conn = sqlite3.connect(str(p))
    new_items: list[DouItem] = []
    for item in items:
        cur = conn.execute("SELECT 1 FROM items WHERE hash = ?", (item.id_hash,))
        if cur.fetchone() is None:
            new_items.append(item)
    conn.close()
    return new_items
