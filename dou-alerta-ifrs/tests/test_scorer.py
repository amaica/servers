"""Testes de scoring e gating."""

import pytest

from dou_alerta.models import DouItem
from dou_alerta.scorer import filter_and_score, score_item


def test_score_item_passou_gating(sample_item: DouItem) -> None:
    """Item com redistribuição + IFRS + TI deve passar gating e ter score alto."""
    si = score_item(sample_item)
    assert si.passou_gating is True
    assert si.score >= 5.0
    assert "redistribuição" in str(si.termos_batidos).lower() or "redistribuicao" in str(si.termos_batidos).lower()
    assert "IFRS" in si.termos_batidos or "ifrs" in [t.lower() for t in si.termos_batidos]


def test_score_item_nao_passou_gating(sample_item_no_match: DouItem) -> None:
    """Item sem termos de movimentação não passa gating."""
    si = score_item(sample_item_no_match)
    assert si.passou_gating is False


def test_score_item_teletrabalho() -> None:
    """Item com lotação + teletrabalho deve passar."""
    item = DouItem(
        id_hash="tt1",
        date="2026-01-15",
        title="LOTAÇÃO com exercício em teletrabalho",
        text="MEC - Ministério da Educação - lotação em regime de teletrabalho.",
        url="https://example.com/1",
    )
    si = score_item(item)
    assert si.passou_gating is True
    assert si.score >= 3.0


def test_filter_and_score_threshold() -> None:
    """filter_and_score respeita threshold."""
    items = [
        DouItem("1", "2026-01-15", "Redistribuição IFRS TI", "texto", "url1"),
        DouItem("2", "2026-01-15", "X", "texto", "url2"),
    ]
    result = filter_and_score(items, threshold=10.0)
    assert len(result) <= 1
