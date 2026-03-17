#!/bin/bash

# Script simplificado para instalação do MinIO Server
# Usa binário já copiado para /tmp/minio

set -e

MINIO_USER="minio-user"
MINIO_GROUP="minio-user"
MINIO_HOME="/opt/minio"
MINIO_DATA_DIR="/opt/minio/data"
MINIO_CONFIG_DIR="/etc/minio"
MINIO_BINARY="/usr/local/bin/minio"
MINIO_BINARY_SOURCE="/tmp/minio"

echo "=== Instalação do MinIO Server ==="
echo ""

# Verificar se está rodando como root
if [ "$EUID" -ne 0 ]; then 
    echo "Este script precisa ser executado como root ou com sudo"
    exit 1
fi

# Verificar se binário existe
if [ ! -f "$MINIO_BINARY_SOURCE" ]; then
    echo "ERRO: Binário MinIO não encontrado em $MINIO_BINARY_SOURCE"
    exit 1
fi

# Criar usuário e grupo MinIO
echo "Criando usuário e grupo MinIO..."
if ! id "$MINIO_USER" &>/dev/null; then
    useradd -r -s /bin/false "$MINIO_USER"
    echo "Usuário $MINIO_USER criado."
else
    echo "Usuário $MINIO_USER já existe."
fi

# Criar diretórios
echo "Criando diretórios..."
mkdir -p "$MINIO_HOME"
mkdir -p "$MINIO_DATA_DIR"
mkdir -p "$MINIO_CONFIG_DIR"

# Instalar binário
echo "Instalando binário MinIO..."
chmod +x "$MINIO_BINARY_SOURCE"
cp "$MINIO_BINARY_SOURCE" "$MINIO_BINARY"
chown "$MINIO_USER:$MINIO_GROUP" "$MINIO_BINARY"

# Configurar permissões
chown -R "$MINIO_USER:$MINIO_GROUP" "$MINIO_DATA_DIR"
chown -R "$MINIO_USER:$MINIO_GROUP" "$MINIO_CONFIG_DIR"
chmod 755 "$MINIO_DATA_DIR"
chmod 755 "$MINIO_CONFIG_DIR"

# Obter IP do servidor
SERVER_IP=$(hostname -I | awk '{print $1}')
if [ -z "$SERVER_IP" ]; then
    SERVER_IP="0.0.0.0"
fi

# Criar arquivo de variáveis de ambiente
echo "Criando arquivo de configuração..."
cat > "$MINIO_CONFIG_DIR/minio" <<EOF
# MinIO Server Configuration
MINIO_ROOT_USER=minioadmin
MINIO_ROOT_PASSWORD=minioadmin123
MINIO_VOLUMES="$MINIO_DATA_DIR"
MINIO_OPTS="--console-address :9001 --address :9000"
EOF

chmod 600 "$MINIO_CONFIG_DIR/minio"
chown "$MINIO_USER:$MINIO_GROUP" "$MINIO_CONFIG_DIR/minio"

# Criar serviço systemd
echo "Criando serviço systemd..."
cat > /etc/systemd/system/minio.service <<EOF
[Unit]
Description=MinIO Object Storage
Documentation=https://docs.min.io
Wants=network-online.target
After=network-online.target
AssertFileIsExecutable=$MINIO_BINARY

[Service]
WorkingDirectory=$MINIO_HOME
User=$MINIO_USER
Group=$MINIO_GROUP
EnvironmentFile=$MINIO_CONFIG_DIR/minio
ExecStartPre=/bin/bash -c "if [ -z \"\${MINIO_VOLUMES}\" ]; then echo \"Variable MINIO_VOLUMES is not set in \${MINIO_CONFIG_DIR}/minio\"; exit 1; fi"
ExecStart=$MINIO_BINARY server \$MINIO_OPTS \$MINIO_VOLUMES
Restart=always
LimitNOFILE=65536
TasksMax=infinity
SendSIGKILL=no

[Install]
WantedBy=multi-user.target
EOF

# Recarregar systemd
systemctl daemon-reload

# Habilitar e iniciar serviço
echo "Iniciando serviço MinIO..."
systemctl enable minio
systemctl start minio

# Aguardar serviço iniciar
sleep 5

# Verificar status
if systemctl is-active --quiet minio; then
    echo ""
    echo "=== MinIO instalado com sucesso! ==="
    echo ""
    echo "Informações de acesso:"
    echo "  Console Web: http://$SERVER_IP:9001"
    echo "  API Endpoint: http://$SERVER_IP:9000"
    echo ""
    echo "Credenciais padrão:"
    echo "  Usuário: minioadmin"
    echo "  Senha: minioadmin123"
    echo ""
    echo "IMPORTANTE: Altere a senha padrão após o primeiro login!"
    echo ""
    echo "Diretório de dados: $MINIO_DATA_DIR"
    echo ""
    echo "Comandos úteis:"
    echo "  Status: systemctl status minio"
    echo "  Logs: journalctl -u minio -f"
    echo "  Parar: systemctl stop minio"
    echo "  Iniciar: systemctl start minio"
    echo ""
else
    echo ""
    echo "ERRO: Serviço MinIO não iniciou corretamente."
    echo "Verifique os logs com: journalctl -u minio -n 50"
    exit 1
fi

