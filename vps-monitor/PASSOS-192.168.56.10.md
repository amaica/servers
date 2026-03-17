# Monitor em 192.168.56.10:8888

**Atualização:** O servidor **192.168.56.10 = 177.22.84.3** (srvtecnicon). O monitor está rodando e respondendo HTTP 200 internamente. Firewall desativado. Se ainda der "conexão recusada" do seu PC, o bloqueio pode estar na rede (roteador, VLAN, outro firewall entre seu PC e o servidor).

---

**Erro:** `ERR_CONNECTION_REFUSED` – conexão recusada.

---

## Causas possíveis

1. **Monitor não instalado** em 192.168.56.10 (o monitor está em 177.22.84.3)
2. **Firewall** bloqueando a porta 8888
3. **Serviço parado** (vps-monitor não está rodando)

---

## O que fazer no servidor 192.168.56.10

Conecte via SSH no **192.168.56.10** e execute:

### Opção A – Script automático (se a pasta vps-monitor já estiver no servidor)

```bash
cd /caminho/para/vps-monitor
chmod +x verificar-e-corrigir-192.sh
sudo ./verificar-e-corrigir-192.sh
```

### Opção B – Comandos manuais

```bash
# 1. Monitor está rodando?
systemctl status vps-monitor

# 2. Algo escuta na porta 8888?
ss -tlnp | grep 8888

# 3. Firewall (firewalld – CentOS/RHEL)
sudo firewall-cmd --permanent --add-port=8888/tcp
sudo firewall-cmd --reload

# OU firewall (ufw – Ubuntu)
sudo ufw allow 8888/tcp
sudo ufw reload

# 4. Iniciar o monitor (se existir)
sudo systemctl start vps-monitor
```

### Opção C – Monitor ainda não instalado em 192.168.56.10

Se o monitor só existe em **177.22.84.3**, copie para **192.168.56.10**:

```bash
# No seu PC (onde está a pasta vps-monitor)
scp -r vps-monitor root@192.168.56.10:/opt/

# Depois, no servidor 192.168.56.10
ssh root@192.168.56.10
cd /opt/vps-monitor
chmod +x verificar-e-corrigir-192.sh
./verificar-e-corrigir-192.sh
```

---

## Conferir se funcionou

No próprio servidor 192.168.56.10:

```bash
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8888/
```

Se retornar `200`, o serviço está ok. Acesse no navegador: **http://192.168.56.10:8888/**
