# Por que e-mails do servidor pm15nov (177.22.81.69) caem no spam?

**Implementação:** No servidor o DKIM já está habilitado. Falta apenas **publicar o registro DNS** e o **DMARC**. Valores exatos e correção dos alertas CVE/EOL estão em **[PM15NOV-DNS-E-CVE.md](PM15NOV-DNS-E-CVE.md)**.

## Diagnóstico (DNS e configuração)

### O que está OK
- **DNS reverso (PTR):** `177.22.81.69` → `mail.pm15nov.rs.gov.br` ✓  
- **Encaminhamento:** `mail.pm15nov.rs.gov.br` → `177.22.81.69` ✓ (reverso e direto batem).  
- **SPF:** `v=spf1 mx -all` e MX = `mail.pm15nov.rs.gov.br` (177.22.81.69) ✓ — SPF deve passar quando o envio for feito desse IP com HELO/nome correto.

### O que está em falta ou é crítico

1. **DKIM (DomainKeys Identified Mail)**  
   - Não apareceu registro TXT de DKIM para `pm15nov.rs.gov.br` (nem `default._domainkey` nem `zimbra._domainkey`).  
   - Provedores (Gmail, Outlook, etc.) usam muito DKIM para decidir se a mensagem é confiável.  
   - **Sem DKIM, a tendência é cair em spam ou ter entrega pior.**

2. **DMARC**  
   - Não há registro `_dmarc.pm15nov.rs.gov.br`.  
   - DMARC melhora a reputação do domínio e diz ao receptor o que fazer quando SPF/DKIM falham.  
   - Não é o único motivo de ir para spam, mas ajuda a evitar.

3. **Reputação do IP**  
   - IP novo ou já usado para spam pode estar com reputação baixa.  
   - Vale conferir se o IP está em listas de bloqueio:  
     - https://mxtoolbox.com/blacklists.aspx (campo: `177.22.81.69`)

---

## O que fazer (em ordem de prioridade)

### 1. Ativar e publicar DKIM (Zimbra)

No servidor (como usuário `zimbra`):

```bash
# Ver selector e se DKIM está habilitado
sudo su - zimbra
zmprov gs $(zmhostname) zimbraDKIMSelector
zmprov gd pm15nov.rs.gov.br zimbraDKIMSigningEnabled
zmprov gd pm15nov.rs.gov.br zimbraDKIMPublicKey
```

Se não houver chave/selector para o domínio:

```bash
# Gerar e habilitar DKIM para o domínio
zmprov gd pm15nov.rs.gov.br zimbraDKIMSelector
# Se não existir, definir um selector (ex.: default ou zimbra)
zmprov md pm15nov.rs.gov.br zimbraDKIMSelector "default"
# Gerar chave (comando típico Zimbra)
/opt/zimbra/libexec/zmdkimkeygen -d pm15nov.rs.gov.br
# Habilitar assinatura
zmprov md pm15nov.rs.gov.br zimbraDKIMSigningEnabled TRUE
```

Depois, pegar a chave pública:

```bash
zmprov gd pm15nov.rs.gov.br zimbraDKIMPublicKey
```

No DNS do domínio **pm15nov.rs.gov.br**, criar um registro **TXT**:

- Nome: `default._domainkey.pm15nov.rs.gov.br` (ou o selector que aparecer no comando acima).  
- Valor: o conteúdo que o Zimbra mostrar (geralmente começa com `v=DKIM1; k=rsa; p=...`).

Sem esse TXT no DNS, o DKIM não valida e o e-mail continua “não autenticado” para os receptores.

### 2. Configurar DMARC

Criar registro **TXT** para o nome **\_dmarc.pm15nov.rs.gov.br**, por exemplo:

- Política inicial (só monitorar):  
  `v=DMARC1; p=none; rua=mailto:admin@pm15nov.rs.gov.br; pct=100; adkim=s; aspf=s`  
- Depois de validar relatórios e SPF/DKIM, pode evoluir para `p=quarantine` ou `p=reject`.

### 3. Conferir SPF e HELO

- Manter SPF como está (`v=spf1 mx -all`) está correto.  
- No Zimbra, o **hostname** do servidor deve ser `mail.pm15nov.rs.gov.br` e o envio deve usar esse nome no HELO/EHLO. Assim o SPF continua passando.

### 4. Reputação e listas

- Acessar https://mxtoolbox.com/blacklists.aspx e consultar `177.22.81.69`.  
- Se aparecer em alguma lista, seguir o procedimento de remoção no site da própria lista (cada uma tem link de “delist”).

### 5. Conteúdo e prática de envio

- Evitar palavras/layout típicos de spam; evitar muitos links ou imagens sem texto.  
- Evitar picos de envio; preferir volumes estáveis.  
- Se usar envio em massa, usar lista de opt-in e remetente consistente com o domínio.

---

## Resumo

- **Principal motivo provável de cair no spam:** falta de **DKIM** (e seu registro no DNS).  
- **Em seguida:** falta de **DMARC** e possível **reputação do IP** (e listas de bloqueio).  
- **Já ok:** PTR, encaminhamento e SPF.

Priorize ativar DKIM no Zimbra, publicar o TXT do selector no DNS e, em seguida, criar o registro DMARC e conferir o IP em ferramentas de blacklist.
