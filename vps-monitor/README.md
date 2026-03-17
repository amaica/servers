# Monitor VPS - Página de Monitoramento

Página HTML amigável para monitorar recursos da VPS (CPU, memória, disco, processos).  
Roda **apenas na rede interna** – não usa autenticação.

## O que mostra

- **Memória** – uso em tempo real com barra de progresso
- **Disco** – uso do disco raiz
- **Uptime** – tempo ligado
- **Load average** – carga do sistema
- **Top 10 CPU** – processos que mais usam CPU
- **Top 10 memória** – processos que mais usam memória

## Como executar

### Na VPS (ex: srvtecnicon 177.22.84.3)

1. Copie a pasta `vps-monitor` para a VPS
2. No servidor, execute:

```bash
cd vps-monitor
python3 monitor_server.py --port 8888
```

3. No navegador da rede interna:

```
http://177.22.84.3:8888/
```

### Rodar em segundo plano (systemd) – inicia após reinício

Arquivos no projeto: `vps-monitor.service` e `install-service.sh`.

**Já instalado na VPS 177.22.84.3.** O serviço está habilitado e sobe automaticamente após reinício.

Para instalar em outra máquina:

```bash
sudo cp vps-monitor.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable vps-monitor
sudo systemctl start vps-monitor
```

Ou execute como root: `./install-service.sh` (a partir da pasta vps-monitor).

## Garantir que a página não pare

- **systemd**: `Restart=always`, `RestartSec=3`, `StartLimitIntervalSec=0` (não desiste de reiniciar).
- No servidor, rode uma vez: `./ensure-on-server.sh` (copia arquivos, habilita e inicia o serviço).
- O script Python também reinicia em loop em caso de exceção (antes do systemd tentar).

## Porta padrão

- **8888** – altere com `--port 9999` se preferir

## Dependências

- Python 3 (já instalado na maioria dos sistemas Linux)
- Sem bibliotecas externas (usa só subprocess e http.server)
