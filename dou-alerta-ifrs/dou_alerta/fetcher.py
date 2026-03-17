"""
Busca itens no DOU via RSS (fonte oficial in.gov.br).

Fonte: Feeds RSS do Portal da Imprensa Nacional (www.in.gov.br).
DOU Seção 2 (atos de pessoal) é o mais relevante para movimentação de servidores.
"""

from __future__ import annotations

import hashlib
import logging
from datetime import datetime
from typing import Optional, Protocol
from urllib.parse import urlparse

import feedparser
import requests

from dou_alerta.config import config
from dou_alerta.models import DouItem

logger = logging.getLogger(__name__)

REQUEST_TIMEOUT = 30
REQUEST_HEADERS = {
    "User-Agent": "DouAlertaIFRS/1.0 (monitor IFRS/TI; contato: via config)",
    "Accept": "application/rss+xml, application/xml, text/xml",
}


def _normalize_text(s: str) -> str:
    return " ".join((s or "").split())


def _make_hash(title: str, date: str, url: str) -> str:
    raw = f"{_normalize_text(title)}|{date}|{url}"
    return hashlib.sha256(raw.encode("utf-8")).hexdigest()


def _parse_date(entry: object) -> str:
    """Extrai data no formato YYYY-MM-DD."""
    if hasattr(entry, "published_parsed") and entry.published_parsed:
        t = entry.published_parsed
        return f"{t.tm_year:04d}-{t.tm_mon:02d}-{t.tm_mday:02d}"
    if hasattr(entry, "updated_parsed") and entry.updated_parsed:
        t = entry.updated_parsed
        return f"{t.tm_year:04d}-{t.tm_mon:02d}-{t.tm_mday:02d}"
    return datetime.utcnow().strftime("%Y-%m-%d")


def _extract_link(entry: object) -> str:
    if hasattr(entry, "link"):
        return str(entry.link).strip()
    if hasattr(entry, "links") and entry.links:
        for lnk in entry.links:
            if getattr(lnk, "href", None):
                return str(lnk.href).strip()
    return ""


def _extract_text(entry: object) -> str:
    parts: list[str] = []
    if hasattr(entry, "title") and entry.title:
        parts.append(str(entry.title))
    if hasattr(entry, "summary") and entry.summary:
        parts.append(str(entry.summary))
    if hasattr(entry, "content") and entry.content:
        for c in entry.content:
            if getattr(c, "value", None):
                parts.append(str(c.value))
    return _normalize_text(" ".join(parts))[:5000]


def _extract_orgao_secao(entry: object, feed_url: str) -> tuple[Optional[str], Optional[str]]:
    orgao = None
    secao = None
    if hasattr(entry, "tags") and entry.tags:
        for tag in entry.tags:
            t = getattr(tag, "term", None) or getattr(tag, "label", None)
            if t:
                if "seção" in str(t).lower() or "secao" in str(t).lower():
                    secao = str(t)
                else:
                    orgao = orgao or str(t)
    if "dou1" in feed_url.lower():
        secao = secao or "DOU1"
    elif "dou2" in feed_url.lower():
        secao = secao or "DOU2"
    elif "dou3" in feed_url.lower():
        secao = secao or "DOU3"
    return (orgao, secao)


class FetcherProtocol(Protocol):
    """Protocolo para fetchers plugáveis."""

    def fetch(self) -> list[DouItem]:
        """Retorna lista de itens normalizados."""
        ...


class RssFetcher:
    """Fetcher usando feeds RSS oficiais do in.gov.br."""

    def __init__(self, urls: list[str] | None = None) -> None:
        self.urls = urls or config.DOU_RSS_URLS

    def fetch(self) -> list[DouItem]:
        items: list[DouItem] = []
        seen_hashes: set[str] = set()

        for url in self.urls:
            if not url:
                continue
            try:
                parsed = self._fetch_feed(url)
                for it in parsed:
                    if it.id_hash not in seen_hashes:
                        seen_hashes.add(it.id_hash)
                        items.append(it)
            except Exception as e:
                logger.warning("Erro ao buscar feed %s: %s", url, e)

        logger.info("Fetcher retornou %d itens", len(items))
        return items

    def _fetch_feed(self, url: str) -> list[DouItem]:
        resp = requests.get(url, headers=REQUEST_HEADERS, timeout=REQUEST_TIMEOUT)
        resp.raise_for_status()
        fp = feedparser.parse(resp.content)

        if fp.bozo and fp.bozo_exception:
            raise fp.bozo_exception

        items: list[DouItem] = []
        for entry in fp.entries:
            try:
                date = _parse_date(entry)
                title = _normalize_text(getattr(entry, "title", "") or "")
                text = _extract_text(entry)
                link = _extract_link(entry)
                orgao, secao = _extract_orgao_secao(entry, url)
                id_hash = _make_hash(title, date, link)
                items.append(
                    DouItem(
                        id_hash=id_hash,
                        date=date,
                        title=title,
                        text=text,
                        url=link,
                        secao=secao,
                        orgao=orgao,
                    )
                )
            except Exception as e:
                logger.debug("Ignorando entrada inválida: %s", e)
        return items


def get_fetcher() -> FetcherProtocol:
    """Retorna o fetcher configurado."""
    return RssFetcher()
