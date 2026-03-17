"""Envio de e-mails via SMTP."""

from __future__ import annotations

import logging
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from typing import TYPE_CHECKING

from dou_alerta.config import config

if TYPE_CHECKING:
    from dou_alerta.scorer import ScoredItem

logger = logging.getLogger(__name__)


def _truncate(s: str, max_len: int = 300) -> str:
    s = (s or "").strip()
    if len(s) <= max_len:
        return s
    return s[: max_len - 3] + "..."


def _build_body(items: list[ScoredItem], max_items: int = 20) -> tuple[str, int]:
    """Gera corpo do e-mail. Retorna (html, total_truncado)."""
    lines: list[str] = []
    trunc = 0
    for i, si in enumerate(items[:max_items]):
        it = si.item
        termos = ", ".join(si.termos_batidos[:5]) if si.termos_batidos else "-"
        trecho = _truncate(it.text, 400)
        bloco = f"""
---
[{i+1}] Data: {it.date} | Seção: {it.secao or '-'} | Órgão: {it.orgao or '-'}
Score: {si.score} | Termos: {termos}
Título: {it.title}
Trecho: {trecho}
Link: {it.url}
"""
        lines.append(bloco.strip())

    if len(items) > max_items:
        trunc = len(items) - max_items
        lines.append(f"\n... e mais {trunc} itens (total {len(items)}).")

    body = "\n".join(lines)
    return body, trunc


def send_alert(items: list[ScoredItem], date_str: str) -> bool:
    """Envia e-mail de alerta. Retorna True se enviou com sucesso."""
    if not items:
        return False

    if config.DRY_RUN:
        logger.info("[DRY_RUN] E-mail não enviado - %d itens, assunto: ALERTA DOU - %s", len(items), date_str)
        return True

    max_items = config.EMAIL_MAX_ITEMS
    body, _ = _build_body(items, max_items)

    subject = f"ALERTA DOU (IFRS/TI): {len(items)} itens - {date_str}"

    msg = MIMEMultipart("alternative")
    msg["Subject"] = subject
    msg["From"] = config.FROM_EMAIL
    msg["To"] = config.TO_EMAIL

    text_part = MIMEText(body, "plain", "utf-8")
    msg.attach(text_part)

    try:
        with smtplib.SMTP(config.SMTP_HOST, config.SMTP_PORT, timeout=30) as smtp:
            if config.SMTP_USE_TLS:
                smtp.starttls()
            smtp.login(config.SMTP_USER, config.SMTP_PASS)
            smtp.sendmail(config.FROM_EMAIL, [config.TO_EMAIL], msg.as_string())
        logger.info("E-mail enviado para %s com %d itens", config.TO_EMAIL, len(items))
        return True
    except Exception as e:
        logger.error("Falha ao enviar e-mail: %s", e)
        raise
