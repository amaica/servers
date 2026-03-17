# Diagnóstico Técnico – Sistema Tecnicon
## Relatório para Empresa Desenvolvedora

**Data:** 11/03/2026  
**Servidor:** srvtecnicon (177.22.84.3)  
**Sistema:** Tecnicon ERP – GlassFish + Firebird

---

## 1. Resumo Executivo

O sistema apresenta mensagem de erro durante operações:

> **"Operação abortada. A memória livre do servidor chegou ao limite! Memória Livre: -831655776 bytes."**

O valor negativo (-831655776 bytes ≈ -793 MB) indica que o sistema está atingindo limite de memória ou há inconsistência na verificação de memória livre. O servidor **não possui espaço de swap** configurado, o que amplifica o impacto em situações de pico de uso.

---

## 2. Ambiente de Hardware e Software

| Item | Valor |
|------|-------|
| **Hostname** | srvtecnicon |
| **SO** | Linux 4.18.0-240 (CentOS/RHEL 8.x) |
| **CPU** | 4 núcleos |
| **RAM total** | 15 GB |
| **Swap** | 0 B (não configurado) |
| **Disco /** | 930 GB total, 536 GB em uso (58%) |
| **Java** | 1.8.0_51 (JDK 8) |
| **Servidor de aplicação** | GlassFish 4 |
| **Banco de dados** | Firebird 3.x |

---

## 3. Configuração Atual

### 3.1 GlassFish / Java
- **Heap JVM:** -Xms6g -Xmx6g (6 GB)
- **Portas:** 8080 (HTTP), 8181, 4848 (admin), 3700, 7676, 9001, 8686
- **Configuração:** `/tecnicon/sistema/DominioTecnicon/config/domain.xml`

### 3.2 Montagens de Rede
- **CIFS:** `//192.168.56.1/publico` montado em `/mnt/PUBLICO` (≈ 2 TB)
- Possível impacto em desempenho se a aplicação ler/escrever diretamente nesse compartilhamento

### 3.3 Serviços
- **GlassFish_DominioTecnicon:** ativo
- **Firebird:** em execução (porta 3050)
- **Samba (smbd):** ativo (portas 139, 445)
- **Conexões ativas:** ~78 (GlassFish + Firebird no momento do diagnóstico)

---

## 4. Problema Relatado

### 4.1 Sintoma
Durante o uso do sistema, operações são abortadas com a mensagem:

```
Operação abortada. A memória livre do servidor chegou ao limite!
Memória Livre: -831655776 bytes.
```

### 4.2 Possíveis Causas
1. **Falta de swap** – Com 0 B de swap, o SO não dispõe de buffer quando a RAM se esgota.
2. **Cálculo de memória livre** – O valor negativo sugere possível overflow ou uso de métrica incorreta na verificação interna do sistema.
3. **Picos de uso** – Múltiplos usuários ou operações pesadas podem elevar o consumo de RAM acima do disponível.
4. **Vazamento de memória** – Possível acúmulo progressivo de memória em sessões ou conexões não encerradas.

---

## 5. Análise Realizada (11/03/2026)

### 5.1 Uso de Memória no Momento
```
              total        used        free      buff/cache   available
Mem:           15Gi       5,2Gi       8,9Gi       1,0Gi       9,6Gi
Swap:            0B          0B          0B
```

Em horário de menor uso, a memória disponível estava em ~9,6 GB. Em picos, o consumo pode subir e atingir o limite verificado pela aplicação.

### 5.2 Alterações Já Realizadas
- **Heap Java:** aumento de 3 GB para 6 GB (`-Xms6g -Xmx6g`)
- **Backup:** `domain.xml.backup_20260311_142730` antes da alteração

---

## 6. Recomendações Técnicas

### 6.1 Curto Prazo
1. **Configurar swap de 4 GB:**
   ```bash
   fallocate -l 4G /swapfile
   chmod 600 /swapfile
   mkswap /swapfile
   swapon /swapfile
   echo '/swapfile none swap sw 0 0' >> /etc/fstab
   ```

2. **Revisar a verificação de memória** – O valor negativo sugere possível bug ou overflow; indicado verificar a lógica e o tipo de dado usados para "memória livre" na aplicação.

3. **Definir limite de sessões/usuários simultâneos** – Se aplicável, limitar concorrência para evitar picos de RAM.

### 6.2 Médio Prazo
1. **Aumentar RAM do servidor** – 16 GB adicionais seriam um ganho significativo.
2. **Auditar queries Firebird** – Otimizar consultas lentas e pool de conexões.
3. **Monitorar uso de /mnt/PUBLICO** – Se houver leitura/escrita intensa, considerar cache ou migração de dados críticos para disco local.
4. **Avaliar upgrade Java** – JDK 1.8.0_51 está desatualizado; migrar para versão LTS recente e mais estável.

### 6.3 Suporte Desenvolvedor
- Confirmar como é calculada a "memória livre" (Runtime.freeMemory(), meminfo, outro).
- Validar tratamento quando o valor obtido é negativo ou inconsistente.
- Avaliar ajuste ou desativação do limite em ambientes controlados, se fizer sentido para o negócio.
- Verificar possíveis vazamentos de memória em sessões longas ou operações em lote.

---

## 7. Arquivos de Configuração Relevantes

| Arquivo | Descrição |
|---------|-----------|
| `/tecnicon/sistema/DominioTecnicon/config/domain.xml` | Configuração GlassFish e JVM |
| `/tecnicon/log/gc.log` | Logs de garbage collection Java |
| `/etc/systemd/system/GlassFish_DominioTecnicon.service` | Inicialização GlassFish |

---

## 8. Contato

Para dúvidas sobre este diagnóstico ou sobre o ambiente de produção, utilizar os canais de suporte da empresa contratante.

---

*Documento gerado com base em análise remota do servidor e relato de erros pelos usuários.*
