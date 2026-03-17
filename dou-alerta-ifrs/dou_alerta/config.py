"""Configuração via variáveis de ambiente (.env.local e .env)."""

from __future__ import annotations

import os
from pathlib import Path

from dotenv import load_dotenv

# Diretório do projeto (raiz onde estão .env.local e .env)
ROOT = Path(__file__).resolve().parent.parent
ENV_LOCAL = ROOT / ".env.local"
ENV_FILE = ROOT / ".env"

# Carrega .env primeiro, depois .env.local (este sobrescreve)
load_dotenv(ENV_FILE)
if ENV_LOCAL.exists():
    load_dotenv(ENV_LOCAL, override=True)


def _str(key: str, default: str = "") -> str:
    return os.environ.get(key, default).strip()


def _bool(key: str, default: bool = False) -> bool:
    v = os.environ.get(key, "").strip().lower()
    if v in ("1", "true", "yes", "on"):
        return True
    if v in ("0", "false", "no", "off"):
        return False
    return default


def _float(key: str, default: float = 0.0) -> float:
    try:
        return float(os.environ.get(key, default) or default)
    except (TypeError, ValueError):
        return default


def _str_list(key: str, sep: str = ",;") -> list[str]:
    raw = os.environ.get(key, "").strip()
    if not raw:
        return []
    for s in sep:
        if s in raw:
            return [u.strip() for u in raw.split(s) if u.strip()]
    return [raw] if raw else []


class Config:
    """Objeto de configuração com valores lidos do ambiente."""

    # SMTP
    SMTP_HOST: str = _str("SMTP_HOST", "smtp.gmail.com")
    SMTP_PORT: int = int(os.environ.get("SMTP_PORT", "587") or 587)
    SMTP_USER: str = _str("SMTP_USER")
    SMTP_PASS: str = _str("SMTP_PASS")
    SMTP_USE_TLS: bool = _bool("SMTP_USE_TLS", True)
    FROM_EMAIL: str = _str("FROM_EMAIL")
    TO_EMAIL: str = _str("TO_EMAIL")

    # Filtros
    SCORE_THRESHOLD: float = _float("SCORE_THRESHOLD", 5.0)
    KEYWORDS_EXTRA: list[str] = _str_list("KEYWORDS_EXTRA")

    # DOU RSS - Imprensa Nacional funciona; dou2.xml às vezes 404
    DOU_RSS_URLS: list[str] = _str_list("DOU_RSS_URLS") or [
        "https://www.gov.br/imprensanacional/pt-br/RSS",
        "https://www.in.gov.br/rss/dou2.xml",
    ]

    # Storage
    DB_PATH: str = _str("DB_PATH", "dou_alerta.db")

    # E-mail
    EMAIL_MAX_ITEMS: int = int(os.environ.get("EMAIL_MAX_ITEMS", "20") or 20)

    # Dry run: não envia e-mail de verdade
    DRY_RUN: bool = _bool("DRY_RUN", False)


config = Config()
