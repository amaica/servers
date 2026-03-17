#!/bin/bash
# Inicia stack de monitoramento com docker run
cd /opt/monitoring

run_or_start() {
  if docker ps -a --format '{{.Names}}' | grep -q "^${1}\$"; then
    docker start "$1"
  else
    shift
    docker run -d "$@"
  fi
}

# Criar rede
docker network create monitoring 2>/dev/null || true

# Node Exporter
run_or_start node-exporter --name node-exporter --restart unless-stopped --network monitoring \
  -v /proc:/host/proc:ro -v /sys:/host/sys:ro -v /:/rootfs:ro \
  -p 9100:9100 \
  prom/node-exporter:v1.7.0 \
  --path.procfs=/host/proc --path.sysfs=/host/sys --path.rootfs=/rootfs \
  --collector.systemd --collector.filesystem.mount-points-exclude='^/(sys|proc|dev|host|etc)($$|/)'

# Prometheus
run_or_start prometheus --name prometheus --restart unless-stopped --network monitoring \
  -v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml:ro \
  -v $(pwd)/alerts.yml:/etc/prometheus/alerts.yml:ro \
  -v prometheus_data:/prometheus \
  -p 9090:9090 \
  prom/prometheus:v2.52.0 \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/prometheus \
  --storage.tsdb.retention.time=15d \
  --web.enable-lifecycle

# Grafana
run_or_start grafana --name grafana --restart unless-stopped --network monitoring \
  -e GF_SECURITY_ADMIN_USER=admin \
  -e GF_SECURITY_ADMIN_PASSWORD=admin \
  -e GF_USERS_ALLOW_SIGN_UP=false \
  -e GF_SERVER_ROOT_URL=http://localhost:3000 \
  -v grafana_data:/var/lib/grafana \
  -v $(pwd)/grafana-datasource.yaml:/etc/grafana/provisioning/datasources/datasources.yaml:ro \
  -p 3000:3000 \
  grafana/grafana:10.4.1

# Uptime Kuma
run_or_start uptime-kuma --name uptime-kuma --restart unless-stopped \
  -v uptime_kuma_data:/app/data \
  -e UPTIME_KUMA_DISABLE_FRAME_SAMEORIGIN=true \
  -p 3002:3001 \
  louislam/uptime-kuma:1

echo "Stack de monitoramento iniciado."
echo "Grafana: http://localhost:3000 (admin/admin)"
echo "Prometheus: http://localhost:9090"
echo "Uptime Kuma: http://localhost:3002"
