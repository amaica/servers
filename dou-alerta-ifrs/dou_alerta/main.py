"""Ponto de entrada do dou-alerta-ifrs."""

from __future__ import annotations

import logging
from datetime import datetime

from dou_alerta.fetcher import get_fetcher
from dou_alerta.mailer import send_alert
from dou_alerta.parser import parse_item
from dou_alerta.scorer import filter_and_score, score_item
from dou_alerta.storage import filter_new, init_db, insert_many

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)
logger = logging.getLogger(__name__)


def run() -> None:
    """Fluxo principal: fetch -> dedup -> score -> alerta."""
    init_db()

    fetcher = get_fetcher()
    items = fetcher.fetch()

    for item in items:
        parse_item(item)

    new_items = filter_new(items)
    if not new_items:
        logger.info("Nenhum item novo. Até a próxima.")
        return

    all_scored = [score_item(it) for it in new_items]
    insert_many([(si.item, si.score) for si in all_scored])

    scored = filter_and_score(new_items)
    if not scored:
        logger.info("%d itens novos, nenhum passou no gating/score.", len(new_items))
        return

    date_str = datetime.utcnow().strftime("%Y-%m-%d")
    send_alert(scored, date_str)
    logger.info("Alerta enviado com %d itens.", len(scored))


if __name__ == "__main__":
    run()
