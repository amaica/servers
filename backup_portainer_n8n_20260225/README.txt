BACKUP PORTAINER E N8N - 25/02/2026
====================================

Origem: VPS root@72.60.245.119 (produção com Portainer e N8N)

Observação: O IP 72.60.148.169 informado não possui Portainer/N8N.
O backup foi feito da VPS 72.60.245.119 onde estão os serviços.

CONTEÚDO DO BACKUP
------------------

Stacks (arquivos .yaml):
- evolution.yaml    - Evolution API + Redis
- evoai.yaml        - EvoAI
- keycloak.yaml     - Keycloak
- metabase.yaml     - Metabase
- n8n.yaml          - N8N (workflows, editor, webhook, worker, redis)
- portainer.yaml    - Portainer + Agent
- postgres.yaml     - PostgreSQL
- stirlingpdf.yaml  - Stirling PDF
- supabase.yaml     - Supabase
- traefik.yaml      - Traefik (proxy reverso)

Bancos de dados:
- n8n_queue_backup.sql     - Backup completo do banco N8N (workflows e configurações)
- evolution_db_backup.sql  - Backup do banco Evolution API

RESTAURAR N8N (workflows e fluxos):
  psql -U postgres -d n8n_queue < n8n_queue_backup.sql

RESTAURAR EVOLUTION:
  psql -U postgres -d evolution < evolution_db_backup.sql
