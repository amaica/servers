#!/bin/bash
# Firewall VPS 177.22.81.69: email público; 7071 e demais só 177.22.84.251 e 177.22.81.66
set -e
UFW=/usr/sbin/ufw
IPS_RESTRITOS="177.22.84.251 177.22.81.66"

echo "=== Configurando UFW ==="
$UFW --force reset 2>/dev/null || true

# Padrão
$UFW default deny incoming
$UFW default allow outgoing

# SSH (manter acesso)
$UFW allow 22/tcp comment 'SSH'

# --- Portas de EMAIL (públicas) ---
$UFW allow 25/tcp comment 'SMTP'
$UFW allow 110/tcp comment 'POP3'
$UFW allow 143/tcp comment 'IMAP'
$UFW allow 465/tcp comment 'SMTPS'
$UFW allow 587/tcp comment 'Submission'
$UFW allow 993/tcp comment 'IMAPS'
$UFW allow 995/tcp comment 'POP3S'
$UFW allow 10000/tcp comment 'Webmail'
$UFW allow 80/tcp comment 'HTTP'
$UFW allow 443/tcp comment 'HTTPS'

# --- Portas restritas (apenas IPs 177.22.84.251 e 177.22.81.66) ---
for ip in $IPS_RESTRITOS; do
  $UFW allow from $ip to any port 7071 proto tcp comment "App $ip"
  $UFW allow from $ip to any port 7072 proto tcp comment "App $ip"
  $UFW allow from $ip to any port 7073 proto tcp comment "App $ip"
  $UFW allow from $ip to any port 8443 proto tcp comment "Admin $ip"
  $UFW allow from $ip to any port 53 proto tcp comment "DNS $ip"
  $UFW allow from $ip to any port 53 proto udp comment "DNS $ip"
  $UFW allow from $ip to any port 389 proto tcp comment "LDAP $ip"
  $UFW allow from $ip to any port 11211 proto tcp comment "Memcached $ip"
  $UFW allow from $ip to any port 7780 proto tcp comment "Servico $ip"
  $UFW allow from $ip to any port 7025 proto tcp comment "Mail alt $ip"
  $UFW allow from $ip to any port 7110 proto tcp comment "POP alt $ip"
  $UFW allow from $ip to any port 7143 proto tcp comment "IMAP alt $ip"
  $UFW allow from $ip to any port 7993 proto tcp comment "IMAPS alt $ip"
  $UFW allow from $ip to any port 7995 proto tcp comment "POP3S alt $ip"
  $UFW allow from $ip to any port 10050 proto tcp comment "Zabbix $ip"
done

$UFW --force enable
$UFW status numbered
echo "=== Fim ==="
