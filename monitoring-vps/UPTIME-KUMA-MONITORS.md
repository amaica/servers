# Monitores para configurar no Uptime Kuma (http://IP:3002)

Após acessar o Uptime Kuma, adicione os seguintes monitores:

| Aplicação | Tipo | URL/Host | Porta |
|-----------|------|----------|-------|
| CAHTS (Node) | HTTP(s) | http://127.0.0.1 | 3001 |
| Tomcat | HTTP(s) | http://127.0.0.1 | 8080 |
| Scheduler (Spring) | HTTP(s) | http://127.0.0.1 | 8081 |
| Kafdrop | HTTP(s) | http://127.0.0.1 | 9000 |
| MySQL | TCP Port | 127.0.0.1 | 3306 |
| Kafka | TCP Port | 127.0.0.1 | 9092 |
| Nginx | HTTP(s) | http://127.0.0.1 | 80 |

**Alertas:** Em Settings → Notifications, configure Telegram, Discord ou email para receber alertas quando algum monitor cair.
