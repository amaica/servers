#!/bin/bash
# Deploy api-dfe (api-dfePsk) para VPS 100.71.54.35
set -e

PROJECT_DIR="${1:-/home/aurelio/FONTES/SPRING/api-dfePsk}"
VPS="root@100.71.54.35"
PASS="${APIDFE_VPS_PASS:-Ifibiruba@10000}"
MYSQL_PASS="${APIDFE_MYSQL_PASS:-@lface#81}"
JAVA17=/usr/lib/jvm/java-17-openjdk-amd64

cd "$PROJECT_DIR"
JAVA_HOME="$JAVA17" mvn -q clean package -DskipTests

sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no "$VPS" "mkdir -p /opt/apidfe/logs"
sshpass -p "$PASS" scp -o StrictHostKeyChecking=no target/api-dfe-11.jar "$VPS:/opt/apidfe/"

sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no "$VPS" "
  mysql -uroot -p'${MYSQL_PASS}' -e \"CREATE DATABASE IF NOT EXISTS \\\`dfe-service\\\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;\"
  grep -q 'spring.security.user.name' /opt/apidfe/application.properties || cat >> /opt/apidfe/application.properties << 'APIDFE_EOF'

spring.security.user.name=\${DFE_API_USER:-dfeapi}
spring.security.user.password=\${DFE_API_PASSWORD:-dfeapi}
spring.flyway.validate-on-migrate=false
logging.file.name=/opt/apidfe/logs/apidfe.log
logging.logback.rollingpolicy.max-file-size=50MB
logging.logback.rollingpolicy.max-history=14
APIDFE_EOF
  systemctl restart apidfe
  sleep 15
  systemctl is-active apidfe
  curl -sf -u \"\${DFE_API_USER:-dfeapi}:\${DFE_API_PASSWORD:-dfeapi}\" http://127.0.0.1:9090/api/v1/empresa >/dev/null && echo OK || echo FAIL
"

echo "Deploy concluído: http://100.71.54.35:9090/api/v1/empresa"
