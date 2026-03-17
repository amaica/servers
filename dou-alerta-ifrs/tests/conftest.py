"""Pytest fixtures."""

from pathlib import Path

import pytest

from dou_alerta.models import DouItem


@pytest.fixture
def sample_item() -> DouItem:
    return DouItem(
        id_hash="abc123",
        date="2026-01-15",
        title="REDISTRIBUIÇÃO de servidor - IFRS - Tecnologia da Informação",
        text="Portaria de redistribuição do servidor João Silva para o IFRS, área de TI.",
        url="https://www.in.gov.br/123",
        secao="DOU2",
        orgao="IFRS",
    )


@pytest.fixture
def sample_item_no_match() -> DouItem:
    return DouItem(
        id_hash="xyz789",
        date="2026-01-15",
        title="Alteração de horário de expediente",
        text="Comunicado sobre horário.",
        url="https://www.in.gov.br/456",
        secao="DOU2",
        orgao=None,
    )


@pytest.fixture
def temp_db_path(tmp_path: Path) -> Path:
    return tmp_path / "test_dou.db"
