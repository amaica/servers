# dou-alerta-ifrs

Monitora o Diário Oficial da União (DOU) e envia alertas por e-mail quando há publicações relevantes para servidores federais do IFRS na área de TI (redistribuição, remoção, cessão, exercício provisório, lotação, teletrabalho).

## Requisitos

- Python 3.12+
- Conta SMTP (ex.: Gmail com senha de app)

## Configuração

1. Copie o exemplo de configuração:

```bash
cp .env.example .env
```

2. Edite o `.env`:

```env
SMTP_USER=seu_email@gmail.com
SMTP_PASS=senha_de_app_16_chars
TO_EMAIL=destinatario@exemplo.com
```

Para Gmail, gere uma senha de app em: https://myaccount.google.com/apppasswords

## Rodar localmente

```bash
pip install -r requirements.txt
python -m dou_alerta.main
```

Ou com o projeto instalável:

```bash
pip install -e .
python -m dou_alerta.main
```

## Agendamento

### Linux (cron)

1x por dia às 8h:

```cron
0 8 * * * cd /caminho/dou-alerta-ifrs && /usr/bin/python3 -m dou_alerta.main >> /var/log/dou-alerta.log 2>&1
```

### Windows (Agendador de Tarefas)

1. Abra o Agendador de Tarefas
2. Criar Tarefa Básica
3. Gatilho: Diariamente, horário desejado
4. Ação: Iniciar um programa
   - Programa: `C:\Python312\python.exe`
   - Argumentos: `-m dou_alerta.main`
   - Iniciar em: `C:\caminho\dou-alerta-ifrs`

### Docker

```bash
docker build -t dou-alerta-ifrs .
docker run --env-file .env -v $(pwd)/dou_alerta.db:/app/dou_alerta.db dou-alerta-ifrs
```

Para agendar no Docker, use cron no host ou um scheduler externo.

### GitHub Actions (opcional)

Crie `.github/workflows/dou-alerta.yml`:

```yaml
name: DOU Alerta
on:
  schedule:
    - cron: '0 11 * * *'  # 8h BRT
  workflow_dispatch:
jobs:
  alerta:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.12'
      - run: pip install -r requirements.txt
      - run: python -m dou_alerta.main
        env:
          SMTP_HOST: ${{ secrets.SMTP_HOST }}
          SMTP_PORT: ${{ secrets.SMTP_PORT }}
          SMTP_USER: ${{ secrets.SMTP_USER }}
          SMTP_PASS: ${{ secrets.SMTP_PASS }}
          FROM_EMAIL: ${{ secrets.FROM_EMAIL }}
          TO_EMAIL: ${{ secrets.TO_EMAIL }}
          DOU_RSS_URLS: ${{ secrets.DOU_RSS_URLS }}
```

Configure os secrets no repositório. Para preservar o SQLite e evitar alertas repetidos, use o recurso de cache do Actions ou um artefato com o hash do dia. Alternativa: armazene o SQLite em um serviço externo (ex.: S3) e restaure antes do run.

## Fonte de dados

Utiliza os feeds RSS oficiais do Portal da Imprensa Nacional (www.in.gov.br). O feed DOU2 (Seção 2 – Atos de Pessoal) é o mais relevante para movimentação de servidores.

URLs típicas (verifique no portal para URLs atualizadas):
- DOU1 (normativos): `https://www.in.gov.br/rss/dou1.xml`
- DOU2 (pessoal): `https://www.in.gov.br/rss/dou2.xml`
- DOU3 (contratos): `https://www.in.gov.br/rss/dou3.xml`

Configure `DOU_RSS_URLS` no `.env` para múltiplos feeds separados por `;`.

## Testes

```bash
pytest tests/ -v
```

## Licença

MIT
