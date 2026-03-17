#!/bin/bash
# Deploy CAHTS para VPS 100.104.1.54 / 209.50.229.247
# Garante que .env.local tenha os valores corretos após o deploy.

set -e
CAHTS_DIR="${1:-/home/aurelio/FONTES/cahts}"
VPS="root@100.104.1.54"
PASS="uAy3JczHGZS7j6XV"

cd "$CAHTS_DIR"
tar --exclude='node_modules' --exclude='.next' --exclude='.git' -czf /tmp/cahts-deploy.tar.gz .
sshpass -p "$PASS" scp -o StrictHostKeyChecking=no /tmp/cahts-deploy.tar.gz $VPS:/tmp/

sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no $VPS "
  systemctl stop cahts
  cd /opt/cahts
  cp .env.local /tmp/cahts-env-backup.env
  rm -rf .next app lib components db scripts public *.ts *.js *.json *.md 2>/dev/null
  find . -maxdepth 1 -type f ! -name '.env*' -delete 2>/dev/null
  tar -xzf /tmp/cahts-deploy.tar.gz -C /opt/cahts
  cp /tmp/cahts-env-backup.env .env.local
  
  # URL HTTPS para iframe no AgrowCrm (app.agrowsynccrm.com.br:4443)
  sed -i 's|APP_BASE_URL=.*|APP_BASE_URL=https://app.agrowsynccrm.com.br:4443|' .env.local
  sed -i 's|ALLOWED_FRAME_ANCESTORS=.*|ALLOWED_FRAME_ANCESTORS=https://app.agrowsynccrm.com.br https://209.50.229.247 http://209.50.229.247 *|' .env.local
  sed -i 's|NEXT_PUBLIC_ALLOWED_FRAME_ANCESTORS=.*|NEXT_PUBLIC_ALLOWED_FRAME_ANCESTORS=https://app.agrowsynccrm.com.br|' .env.local
  grep -q '^ACCESS_TOKEN=' .env.local || echo 'ACCESS_TOKEN=44d8ca90603fbeaa903d9735df1331f6' >> .env.local
  
  npm install
  npm run build
  systemctl start cahts
  sleep 2
  systemctl status cahts
"

echo "Deploy concluído."
echo "CAHTS: https://app.agrowsynccrm.com.br:4443 (HTTPS) | http://209.50.229.247:3001"
echo "Iframe: No AgrowCrm, o parâmetro URL_INBOX deve ser: https://app.agrowsynccrm.com.br:4443"
