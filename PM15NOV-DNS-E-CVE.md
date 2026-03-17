# pm15nov.rs.gov.br – Registros DNS a adicionar e correção dos alertas CVE/EOL

## 1. Registro DKIM (obrigatório para reduzir spam)

O Zimbra já tem DKIM habilitado e a chave gerada. Falta **apenas publicar no DNS**.

No painel DNS do domínio **pm15nov.rs.gov.br** (quem gerencia: TI do estado/RS ou provedor), crie:

| Tipo | Nome (host/subdomínio) | Valor (TXT) | TTL |
|------|------------------------|-------------|-----|
| TXT | `61EDF07A-3FFD-11ED-9B88-6A89A0686093._domainkey` | Ver bloco abaixo | 3600 |

**Valor TXT único (pode colar em uma linha ou em dois segmentos, conforme o painel):**

```
v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsr9f8yJxcigLqNgsCTJ5XgxulzqHXXXwxGBW1zCU41guMtKLed/1Nyqscj5Sc0M2QeejuEAzvYiNGLTk2vGwjka1VlPsUNM8J10wPbJ7ttmOMrO8Xj8Rl0Fgb6p/g0so8OK8ltmzgW3xlFMchY06Gjli2cDmkaYM6QSt194mCCUcfbJTAT3BfxVSn2MCcCL7I88igugryBOev17m/gQD8oGKAPFV4z/RDQBBCNb44kCTvE+BNkEgDNTIzI58oxzQFCo1eZcFjDiF+c3kkKmQbgMfc/1kOA8Lprc0E3O98iAkFY5OUDU/8Wo3dUUlu/3CZE3j703fPB0uMl9Om/RrPQIDAQAB
```

Alguns provedores pedem o valor em partes; nesse caso use:
- Parte 1: `v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsr9f8yJxcigLqNgsCTJ5XgxulzqHXXXwxGBW1zCU41guMtKLed/1Nyqscj5Sc0M2QeejuEAzvYiNGLTk2vGwjka1VlPsUNM8J10wPbJ7ttmOMrO8Xj8Rl0Fgb6p/g0so8OK8ltmzgW3xlFMchY06Gjli2cDmkaYM6QSt194mCCUcfbJTAT3BfxVSn2MCcCL7I88igugryBOev1`
- Parte 2: `7m/gQD8oGKAPFV4z/RDQBBCNb44kCTvE+BNkEgDNTIzI58oxzQFCo1eZcFjDiF+c3kkKmQbgMfc/1kOA8Lprc0E3O98iAkFY5OUDU/8Wo3dUUlu/3CZE3j703fPB0uMl9Om/RrPQIDAQAB`

Após publicar, aguarde a propagação (minutos a poucas horas) e teste em: https://mxtoolbox.com/dkim.aspx (domínio: pm15nov.rs.gov.br, selector: 61EDF07A-3FFD-11ED-9B88-6A89A0686093).

---

## 2. Registro DMARC (recomendado)

Crie um registro TXT para receber relatórios e melhorar reputação:

| Tipo | Nome | Valor (TXT) | TTL |
|------|------|-------------|-----|
| TXT | `_dmarc` | `v=DMARC1; p=none; rua=mailto:postmaster@pm15nov.rs.gov.br; pct=100; adkim=s; aspf=s` | 3600 |

Troque `postmaster@pm15nov.rs.gov.br` pelo e-mail que deve receber os relatórios DMARC, se for outro.

---

## 3. Alertas CVE-2024-45519 e EOL Zimbra

### O que os alertas significam

- **CVE-2024-45519:** vulnerabilidade crítica no serviço **postjournal** do Zimbra (execução de comandos remota sem autenticação). Versões corrigidas: **8.8.15 Patch 46** ou superior, 9.0.0 P41+, 10.0.9+, 10.1.1+.
- **eol / eol-zimbra:** o Zimbra **8.8.15** está em fim de vida (Technical Guidance até 31/12/2024). Não há mais patches de segurança oficiais para essa linha.
- **ssl; zimbra:** o scanner detecta Zimbra nas portas 443 e 8443 (esperado).

### Versão atual no servidor

- **8.8.15 Patch 33** → ainda **vulnerável** à CVE-2024-45519 (a correção está a partir da **P46**).

### O que fazer

**Opção A – Atualizar para Patch 46 (mínimo para CVE-2024-45519)**  
- Baixar o pacote **8.8.15 Patch 46** (ou o patch mais recente ainda disponível para 8.8.15) no site/repositório Zimbra (ou pelo suporte).  
- Fazer backup e aplicar o upgrade conforme a documentação Zimbra para 8.8.15.  
- Isso mitiga a CVE-2024-45519, mas a linha 8.8.15 continua EOL (sem novos patches no futuro).

**Opção B – Planejar migração para Zimbra 10.x (recomendado)**  
- Zimbra 8.8.15 está em fim de vida.  
- A linha suportada atualmente é a **Zimbra 10.1** (Daffodil).  
- Planejar migração para 10.1 em janela de manutenção (nova instalação + migração de contas/dados).

**Mitigação imediata (enquanto não atualiza)**  
- O serviço **postjournal** costuma **não estar habilitado** por padrão; mesmo assim, a versão continua vulnerável e o scanner continuará apontando CVE até a atualização.  
- As portas **443** e **8443** já estão com regras de firewall (443 aberta para webmail; 8443 restrita aos IPs 177.22.84.251 e 177.22.81.66). Manter 8443 restrita reduz superfície de ataque.

### Referências

- [Zimbra – CVE-2024-45519 (blog oficial)](https://blog.zimbra.com/2024/10/zimbra-cve-2024-45519-vulnerability-stay-secure-by-updating/)  
- [Ciclo de vida do produto Zimbra](https://zimbra.com/product/product-lifecycle)  
- Pacotes/patches: repositório ou portal de suporte Zimbra para sua edição (FOSS/Network).

---

## Resumo

| Ação | Onde | Status |
|------|------|--------|
| Publicar TXT DKIM (selector `61EDF07A-3FFD-11ED-9B88-6A89A0686093`) | Bind9 no servidor 177.22.81.69 | **Feito** (zona `db.pm15nov.rs.gov.br`) |
| Publicar TXT DMARC | Bind9 no servidor 177.22.81.69 | **Feito** |
| Atualizar Zimbra para P46 ou superior | Servidor 177.22.81.69 | **Recomendado** (resolve CVE-2024-45519) |
| Planejar migração para Zimbra 10.1 | Planejamento TI | **Recomendado** (sai de EOL) |

DKIM e DMARC foram adicionados na zona Bind9 do próprio servidor (`/etc/bind/db.pm15nov.rs.gov.br`). O DKIM está em 7 segmentos TXT (&lt;255 caracteres cada) para compatibilidade com o parser do BIND. Os alertas de CVE e EOL só deixam de aparecer após atualizar/migrar o Zimbra conforme acima.
