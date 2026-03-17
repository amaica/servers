FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY dou_alerta/ dou_alerta/
COPY pyproject.toml .

ENV PYTHONUNBUFFERED=1
ENV DB_PATH=/app/dou_alerta.db

CMD ["python", "-m", "dou_alerta.main"]
