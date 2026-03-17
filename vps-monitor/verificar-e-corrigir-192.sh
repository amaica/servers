#!/bin/bash
# Executar NO SERVIDOR 192.168.56.10 (como root) para:
# REQUISITO: A pasta vps-monitor deve estar neste servidor (copie via scp se necessario)
# 1. Verificar se o monitor está rodando
# 2. Liberar firewall na porta 8888
# 3. Iniciar o monitor se necessário

set -e
echo "=== Diagnóstico e correção - Monitor VPS em 192.168.56.10 ==="
echo ""

# 1. Verificar se vps-monitor existe e está rodando
echo "1. Serviço vps-monitor:"
if systemctl is-active --quiet vps-monitor 2>/dev/null; then
    echo "   OK - Rodando"
else
    echo "   INATIVO ou não instalado"
    if [ -f /opt/vps-monitor/monitor_server.py ]; then
        echo "   Instalando e iniciando..."
        SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        mkdir -p /opt/vps-monitor
        cp -a "$SCRIPT_DIR/monitor_server.py" /opt/vps-monitor/
        [ -f "$SCRIPT_DIR/vps-monitor.service" ] && cp "$SCRIPT_DIR/vps-monitor.service" /etc/systemd/system/
        systemctl daemon-reload
        systemctl enable vps-monitor
        systemctl start vps-monitor
        echo "   Serviço iniciado."
    else
        echo "   ERRO: Copie a pasta vps-monitor para este servidor e execute novamente."
        exit 1
    fi
fi

# 2. Verificar porta 8888
echo ""
echo "2. Porta 8888:"
if ss -tlnp | grep -q ":8888 "; then
    echo "   OK - Algo está escutando"
else
    echo "   NADA escutando - monitor não está rodando na 8888"
fi

# 3. Firewall - firewalld (CentOS/RHEL)
echo ""
echo "3. Firewall:"
if command -v firewall-cmd &>/dev/null; then
    if systemctl is-active --quiet firewalld 2>/dev/null; then
        echo "   firewalld ativo - liberando porta 8888..."
        firewall-cmd --permanent --add-port=8888/tcp 2>/dev/null || true
        firewall-cmd --add-port=8888/tcp 2>/dev/null || true
        echo "   Porta 8888 liberada."
    else
        echo "   firewalld inativo"
    fi
# UFW (Ubuntu/Debian)
elif command -v ufw &>/dev/null; then
    if ufw status | grep -q "Status: active"; then
        echo "   ufw ativo - liberando porta 8888..."
        ufw allow 8888/tcp
        ufw status | grep 8888 || true
    else
        echo "   ufw inativo"
    fi
else
    echo "   Nenhum firewall gerido encontrado (firewalld/ufw)"
fi

# 4. Teste local
echo ""
echo "4. Teste interno (curl localhost:8888):"
curl -s -o /dev/null -w "   HTTP %{http_code}\n" --connect-timeout 2 http://127.0.0.1:8888/ 2>/dev/null || echo "   FALHOU - serviço não responde"

echo ""
echo "=== Concluído. Acesse: http://192.168.56.10:8888/ ==="
