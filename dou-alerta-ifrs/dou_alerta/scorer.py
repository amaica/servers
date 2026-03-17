"""
Scoring e gating para filtragem de publicações DOU.

- Gating: precisa ter ao menos 1 termo de movimentação
  E (contexto TI/teletrabalho OU órgão IFRS/MEC/UF)
- Scoring: pesos por termo, apenas alerta acima do limiar.
"""

from __future__ import annotations

import re
from dataclasses import dataclass

from dou_alerta.config import config
from dou_alerta.models import DouItem


@dataclass
class ScoredItem:
    """Item com score e termos que bateram."""

    item: DouItem
    score: float
    termos_batidos: list[str]
    passou_gating: bool


def _normalize_for_match(s: str) -> str:
    """Remove acentos para matching flexível."""
    replacements = {
        "á": "a", "à": "a", "â": "a", "ã": "a",
        "é": "e", "ê": "e",
        "í": "i",
        "ó": "o", "ô": "o", "õ": "o",
        "ú": "u", "û": "u",
        "ç": "c",
    }
    r = s.lower()
    for k, v in replacements.items():
        r = r.replace(k, v)
    return r


# Termos de movimentação (core) - peso 2
MOVIMENTACAO_TERMS = [
    r"redistribui[cç][aã]o",
    r"remo[cç][aã]o",
    r"cess[aã]o",
    r"exerc[ií]cio\s+provis[oó]rio",
    r"lota[cç][aã]o",
]

# Contexto TI/teletrabalho - peso 1.5
CONTEXTO_TERMS = [
    r"teletrabalho",
    r"trabalho\s+remoto",
    r"home\s+office",
    r"tecnologia\s+da\s+informa[cç][aã]o",
    r"\bTI\b",
    r"inform[aá]tica",
    r"desenvolvimento",
    r"sistemas",
    r"aplica[cç][oõ]es",
    r"analista\s+de\s+TI",
]

# Órgãos - peso 2
ORGAO_TERMS = [
    r"\bIFRS\b",
    r"Instituto\s+Federal\s+do\s+Rio\s+Grande\s+do\s+Sul",
    r"Instituto\s+Federal",
    r"\bMEC\b",
    r"Minist[eé]rio\s+da\s+Educa[cç][aã]o",
    r"Universidade\s+Federal",
]

# Pesos
PESO_MOVIMENTACAO = 2.0
PESO_CONTEXTO = 1.5
PESO_ORGAO = 2.0
PESO_EXTRA = 1.0


def _compile_patterns(terms: list[str]) -> list[re.Pattern[str]]:
    return [re.compile(t, re.IGNORECASE) for t in terms]


MOVIMENTACAO_RE = _compile_patterns(MOVIMENTACAO_TERMS)
CONTEXTO_RE = _compile_patterns(CONTEXTO_TERMS)
ORGAO_RE = _compile_patterns(ORGAO_TERMS)


def _match_any(text: str, patterns: list[re.Pattern[str]]) -> list[str]:
    """Retorna lista de termos que bateram (do texto original)."""
    found: list[str] = []
    for pat in patterns:
        for m in pat.finditer(text):
            span = m.group(0)
            if span and span not in found:
                found.append(span)
    return found


def _match_any_bool(text: str, patterns: list[re.Pattern[str]]) -> bool:
    return bool(_match_any(text, patterns))


def score_item(item: DouItem) -> ScoredItem:
    """
    Aplica gating e scoring ao item.

    Gating:
    - Tem ao menos 1 termo de movimentação
    - E (tem contexto TI/teletrabalho OU tem órgão IFRS/MEC/UF)

    Scoring: soma dos pesos dos termos que bateram.
    """
    text = f"{item.title} {item.text}".lower()
    texto_norm = _normalize_for_match(text)

    mov_terms = _match_any(texto_norm, MOVIMENTACAO_RE)
    ctx_terms = _match_any(texto_norm, CONTEXTO_RE)
    org_terms = _match_any(texto_norm, ORGAO_RE)

    extra_terms: list[str] = []
    for kw in config.KEYWORDS_EXTRA:
        if kw and kw.lower() in text:
            extra_terms.append(kw)

    # Gating
    tem_movimentacao = len(mov_terms) >= 1
    tem_contexto = len(ctx_terms) >= 1
    tem_orgao = len(org_terms) >= 1
    passou_gating = tem_movimentacao and (tem_contexto or tem_orgao)

    # Scoring
    score = 0.0
    termos: list[str] = []
    if mov_terms:
        score += PESO_MOVIMENTACAO
        termos.extend(mov_terms)
    for t in ctx_terms:
        score += PESO_CONTEXTO
        termos.append(t)
    for t in org_terms:
        score += PESO_ORGAO
        termos.append(t)
    for t in extra_terms:
        score += PESO_EXTRA
        termos.append(t)

    return ScoredItem(
        item=item,
        score=score,
        termos_batidos=list(dict.fromkeys(termos)),
        passou_gating=passou_gating,
    )


def filter_and_score(items: list[DouItem], threshold: float | None = None) -> list[ScoredItem]:
    """Filtra por gating e threshold, retorna ScoredItems."""
    thr = threshold if threshold is not None else config.SCORE_THRESHOLD
    result: list[ScoredItem] = []
    for item in items:
        si = score_item(item)
        if si.passou_gating and si.score >= thr:
            result.append(si)
    return result
