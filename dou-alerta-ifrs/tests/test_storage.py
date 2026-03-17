"""Testes de deduplicação e storage."""

from pathlib import Path

import pytest

from dou_alerta.models import DouItem
from dou_alerta.storage import exists, filter_new, init_db, insert


def test_init_db(temp_db_path: Path) -> None:
    init_db(temp_db_path)
    assert temp_db_path.exists()


def test_insert_and_exists(temp_db_path: Path) -> None:
    init_db(temp_db_path)
    item = DouItem("h1", "2026-01-15", "Título", "Texto", "https://a.com")
    assert exists("h1", temp_db_path) is False
    insert(item, score=5.0, path=temp_db_path)
    assert exists("h1", temp_db_path) is True


def test_filter_new_deduplication(temp_db_path: Path) -> None:
    init_db(temp_db_path)
    item1 = DouItem("hash1", "2026-01-15", "A", "x", "url1")
    item2 = DouItem("hash2", "2026-01-15", "B", "y", "url2")
    insert(item1, path=temp_db_path)

    new = filter_new([item1, item2], temp_db_path)
    assert len(new) == 1
    assert new[0].id_hash == "hash2"
