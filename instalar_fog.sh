#!/bin/bash

# Script para instalação automatizada do FOG Server
# Configurado para usar MySQL existente e /mnt/backup como diretório de imagens

set -e

MYSQL_ROOT_PASS="rQhTt7j3"
FOG_IMAGES_DIR="/mnt/backup/fogimages"
FOG_DIR="/tmp/fogproject-dev-branch"
FOG_CONFIG="/opt/fog/.fogsettings"

echo "=== Instalação do FOG Server ==="
echo "Diretório de imagens: $FOG_IMAGES_DIR"
echo "MySQL root password: [configurado]"
echo ""

# Verificar se está rodando como root
if [ "$EUID" -ne 0 ]; then 
    echo "Este script precisa ser executado como root ou com sudo"
    exit 1
fi

# Criar diretório de imagens se não existir
echo "Criando diretório de imagens..."
mkdir -p "$FOG_IMAGES_DIR"
chmod 755 "$FOG_IMAGES_DIR"
chown fog:fog "$FOG_IMAGES_DIR" 2>/dev/null || echo "Usuário fog ainda não existe, será criado durante instalação"

# Verificar se MySQL está rodando
if ! systemctl is-active --quiet mysql; then
    echo "Iniciando MySQL..."
    systemctl start mysql
    sleep 2
fi

# Verificar se o banco fog existe
echo "Verificando banco de dados..."
DB_EXISTS=$(mysql -u root -p"$MYSQL_ROOT_PASS" -e "SHOW DATABASES LIKE 'fog';" 2>/dev/null | grep -c fog || echo "0")

if [ "$DB_EXISTS" -eq 0 ]; then
    echo "Criando banco de dados fog..."
    mysql -u root -p"$MYSQL_ROOT_PASS" <<EOF
CREATE DATABASE IF NOT EXISTS fog;
CREATE USER IF NOT EXISTS 'fog'@'localhost' IDENTIFIED BY 'fogpassword';
GRANT ALL PRIVILEGES ON fog.* TO 'fog'@'localhost';
FLUSH PRIVILEGES;
EOF
    echo "Banco de dados fog criado."
else
    echo "Banco de dados fog já existe. Não será removido."
fi

# Verificar se FOG já está instalado
if [ -d "/opt/fog" ] && [ -f "$FOG_CONFIG" ]; then
    echo ""
    echo "FOG parece já estar instalado."
    read -p "Deseja reinstalar? (s/N): " REINSTALL
    if [[ ! "$REINSTALL" =~ ^[Ss]$ ]]; then
        echo "Instalação cancelada."
        exit 0
    fi
fi

# Navegar para o diretório do FOG
cd "$FOG_DIR"

echo ""
echo "Iniciando instalação do FOG Server..."
echo "Isso pode levar vários minutos..."
echo ""

# Executar instalação com auto-aceitar defaults
# A opção -Y aceita automaticamente os defaults
bash bin/installfog.sh -Y

echo ""
echo "=== Configurando diretório de imagens ==="

# Aguardar instalação completar
sleep 5

# Verificar se arquivo de configuração existe
if [ -f "$FOG_CONFIG" ]; then
    echo "Atualizando configuração do FOG..."
    
    # Fazer backup da configuração
    cp "$FOG_CONFIG" "${FOG_CONFIG}.backup"
    
    # Atualizar diretório de imagens na configuração
    if grep -q "^storageLocation=" "$FOG_CONFIG"; then
        sed -i "s|^storageLocation=.*|storageLocation=$FOG_IMAGES_DIR|" "$FOG_CONFIG"
    else
        echo "storageLocation=$FOG_IMAGES_DIR" >> "$FOG_CONFIG"
    fi
    
    # Atualizar permissões do diretório
    if id "fog" &>/dev/null; then
        chown -R fog:fog "$FOG_IMAGES_DIR"
        chmod 755 "$FOG_IMAGES_DIR"
    fi
    
    echo "Configuração atualizada."
else
    echo "Aviso: Arquivo de configuração não encontrado em $FOG_CONFIG"
    echo "Você precisará configurar manualmente o diretório de imagens."
fi

# Verificar se há arquivo de configuração do NFS
NFS_EXPORT="/etc/exports"
if [ -f "$NFS_EXPORT" ] && grep -q "fogimages" "$NFS_EXPORT"; then
    echo "Atualizando exportação NFS..."
    # Atualizar exportação NFS para usar novo diretório
    sed -i "s|.*fogimages.*|$FOG_IMAGES_DIR *(ro,sync,no_wdelay,no_subtree_check,insecure_locks,no_root_squash,insecure)|" "$NFS_EXPORT"
    exportfs -ra 2>/dev/null || echo "Reexportando NFS..."
fi

echo ""
echo "=== Instalação concluída ==="
echo ""
echo "Diretório de imagens configurado: $FOG_IMAGES_DIR"
echo ""
echo "Para acessar o FOG:"
echo "  URL: http://$(hostname -I | awk '{print $1}')/fog"
echo "  Usuário padrão: fog"
echo "  Senha padrão: fog"
echo ""
echo "IMPORTANTE: Altere a senha padrão após o primeiro login!"
echo ""
echo "Para verificar o status:"
echo "  systemctl status fog*"
echo ""
