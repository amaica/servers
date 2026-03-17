#!/bin/bash
# Executar NO SERVIDOR (root) para garantir que o Monitor VPS está instalado e não para.
# Uso: copie a pasta vps-monitor para o servidor e rode: sudo ./ensure-on-server.sh

set -e
INSTALL_DIR="/opt/vps-monitor"
SVC="vps-monitor.service"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Garantindo Monitor VPS no servidor ==="
mkdir -p "$INSTALL_DIR"
cp -a "$SCRIPT_DIR/monitor_server.py" "$INSTALL_DIR/"
cp "$SCRIPT_DIR/vps-monitor.service" /etc/systemd/system/
chmod +x "$INSTALL_DIR/monitor_server.py"
systemctl daemon-reload
systemctl enable "$SVC"
systemctl restart "$SVC"
echo ""
echo "Serviço habilitado para iniciar no boot e reinício automático se cair."
echo "Página: http://$(hostname -I | awk '{print $1}'):8888/"
systemctl status "$SVC" --no-pager
