"""Modelos de dados do DOU."""

from __future__ import annotations

from dataclasses import dataclass
from typing import Optional


@dataclass
class DouItem:
    """Item normalizado do DOU."""

    id_hash: str
    date: str  # YYYY-MM-DD
    title: str
    text: str
    url: str
    secao: Optional[str] = None
    orgao: Optional[str] = None
    extra: Optional[dict] = None

    def __post_init__(self) -> None:
        if self.extra is None:
            self.extra = {}
