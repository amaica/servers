#!/bin/bash
# Instala o Monitor VPS como serviço systemd (sobe após reinício)
# Executar como root na VPS

set -e
INSTALL_DIR="/opt/vps-monitor"
SERVICE_NAME="vps-monitor.service"

echo "=== Instalando Monitor VPS ==="
mkdir -p "$INSTALL_DIR"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp -a "$SCRIPT_DIR/monitor_server.py" "$INSTALL_DIR/"
cp "$SCRIPT_DIR/vps-monitor.service" /etc/systemd/system/
systemctl daemon-reload
systemctl enable "$SERVICE_NAME"
systemctl start "$SERVICE_NAME"
echo ""
echo "Serviço instalado e iniciado."
echo "Página: http://$(hostname -I | awk '{print $1}'):8888/"
echo ""
systemctl status "$SERVICE_NAME" --no-pager
