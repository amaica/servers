"""Normalização e extração de campos do DOU."""

from __future__ import annotations

import re
from typing import Optional

from dou_alerta.models import DouItem


def normalize_text(s: str) -> str:
    """Remove espaços extras e normaliza."""
    if not s:
        return ""
    return " ".join(s.split()).strip()


def extract_orgao(text: str) -> Optional[str]:
    """Tenta extrair órgão/entidade do texto."""
    patterns = [
        r"(?:órgão|orgao|entidade)\s*:?\s*([^\n.;]{5,80})",
        r"(?:publicado\s+por|publica\s+)\s*([^\n.;]{5,80})",
    ]
    for pat in patterns:
        m = re.search(pat, text, re.IGNORECASE)
        if m:
            return normalize_text(m.group(1))[:100]
    return None


def parse_item(item: DouItem) -> DouItem:
    """Aplica parsing/normalização ao item."""
    item.title = normalize_text(item.title)
    item.text = normalize_text(item.text)
    if not item.orgao and item.text:
        item.orgao = extract_orgao(item.text)
    return item
