# Stack de Monitoramento - VPS 100.104.1.54

## Serviços

| Serviço | Porta | URL | Uso |
|---------|-------|-----|-----|
| **Grafana** | 3000 | http://IP:3000 | Dashboards (CPU, memória, disco) |
| **Prometheus** | 9090 | http://IP:9090 | Métricas |
| **Uptime Kuma** | 3002 | http://IP:3002 | Health checks e alertas |
| **Node Exporter** | 9100 | - | Métricas do host |

**Login Grafana:** admin / admin (troque após primeiro acesso)

---

## Configurar Uptime Kuma (alertas quando apps caem)

1. Acesse http://IP:3002
2. Crie conta admin (primeiro acesso)
3. Adicione monitores:

| Aplicação | Tipo | Host/URL | Porta |
|-----------|------|----------|-------|
| CAHTS (Node) | HTTP(s) | http://127.0.0.1:3001 | - |
| Tomcat | HTTP(s) | http://127.0.0.1:8080 | - |
| Scheduler (Spring) | HTTP(s) | http://127.0.0.1:8081 | - |
| Kafdrop | HTTP(s) | http://127.0.0.1:9000 | - |
| MySQL | TCP Port | 127.0.0.1 | 3306 |
| Kafka | TCP Port | 127.0.0.1 | 9092 |
| Nginx | HTTP(s) | http://127.0.0.1 | 80 |

4. **Configurar alertas:** Settings → Notifications → adicione Telegram, Discord ou Email

---

## Dashboard Grafana (CPU, memória, disco)

1. Acesse Grafana → Dashboards → New → Import
2. ID do dashboard: **1860** (Node Exporter Full)
3. Selecione datasource: Prometheus
4. Import

---

## Métricas monitoradas

- **CPU:** uso em %
- **Memória:** uso e disponível
- **Disco:** espaço livre (raiz)
- **Alertas Prometheus:** CPU >90%, Memória >90%, Disco <10% livre

---

## Comandos

```bash
# Iniciar stack
/opt/monitoring/start-monitoring.sh

# Ver status
docker ps | grep -E 'prometheus|grafana|uptime|node-exporter'

# Logs
docker logs prometheus -f
docker logs grafana -f
```

## Inicialização no boot

O serviço `cahts-monitoring.service` está habilitado. Os containers sobem automaticamente após reboot da VPS.
