# Revisão da tabela OPORTUNIDADE (migração flow_crm → synki)

A tabela `oportunidade` é a mais importante do sistema. Este documento descreve estrutura, relacionamentos e correções aplicadas/necessárias.

---

## 1. Estrutura comparada

| Campo | flow_crm | synki | Observação |
|------|----------|-------|------------|
| ID | int AUTO_INCREMENT | bigint AUTO_INCREMENT | Mesmos valores migrados (261 registros, IDs 33–343). |
| DATA_CRIACAO, NOME, OBSERVACAO, CONTATO, DATA_FECHAMENTO_ESPERADA | ✓ | ✓ | Migrados. |
| DESCRICAO, PROBABILIDADE, STATUS, TIPO_MAQUINA, VALOR | ✓ | ✓ | Migrados. STATUS no synki é cópia; etapa de negócio é **ETAPA_ID**. |
| ID_PESSOA | int, FK pessoas(ID) | bigint, FK pessoas(ID) | Migrado. 3 oportunidades com ID_PESSOA NULL. |
| ID_FUNIL | int, FK funil(ID) | bigint, FK funil(ID) | Migrado. 3 oportunidades com ID_FUNIL NULL (mesmas que sem origem). |
| ID_ORIGEM | int, FK origem(ID) | bigint, FK origem(ID) | Migrado. 3 oportunidades com ID_ORIGEM NULL. |
| ID_VENDEDOR | int, FK usuario(id) | bigint, FK usuario(id) | Migrado. Sem órfãos. |
| LOCAL, POSSIBILIDADE, LEADBOOL, PROSPECT, NEGOTIATION, PEDIDO | ✓ | ✓ | Migrados. |
| VALOR_ATUALIZADO, ID_MOTIVO_PERDA, ID_MARCA, OBSERVACAO_PERDA | ✓ | ✓ | Migrados. |
| VALOR_CONCORRENCIA, POSSUI_PARTICIPACAO, ENVIADO_PARA_AGENDA | ✓ | ✓ | Migrados. |
| ID_ATENDIMENTO, VALOR_TOTAL_CUSTO | ✓ | ✓ | Migrados. |
| **ETAPA_ID** | — | int, FK etapas_oportunidade(ID) | **Só no synki.** Preenchido em pós-migração a partir de STATUS. |
| **data_ultima_atualizacao** | — | timestamp | Só no synki. Default CURRENT_TIMESTAMP. |
| **ID_EMPRESA** | — | bigint, FK empresa(id) | **Só no synki.** Preenchido = 1 em pós-migração (filtro da aplicação). |
| **UUID_OPORTUNIDADE** | — | varchar(255) | Só no synki. NULL para migrados. |

---

## 2. Relacionamentos (synki)

### 2.1 Tabelas que referenciam `oportunidade` (oportunidade.ID)

| Tabela | Coluna | Uso |
|--------|--------|-----|
| agenda_compromisso | ID_OPORTUNIDADE | Compromissos ligados à oportunidade. |
| atendimento | ID_OPORTUNIDADE | Atendimentos da oportunidade. |
| check_in | id_oportunidade | Check-in (só synki). |
| documento_ged | ID_OPORTUNIDADE | Documentos GED. |
| evolucao_pedido | ID_OPORTUNIDADE | Evolução do pedido. |
| oportunidade_evolucao | ID_OPORTUNIDADE | Histórico de etapas/mudanças. |
| pedido | OPORTUNIDADE_ID | Pedido gerado a partir da oportunidade. |
| pedido_etapas | ID_OPORTUNIDADE | Etapas do pedido por oportunidade. |
| visitas_sugeridas | ID_OPORTUNIDADE | Visitas sugeridas. |

### 2.2 Tabela `item_oportunidade`

- Coluna **ID_OPORTUNIDADE** (int) referencia logicamente `oportunidade.ID` (bigint).
- No synki **não há FK** de item_oportunidade → oportunidade (só FK para produto).
- **Problema:** 5 linhas em `item_oportunidade` têm ID_OPORTUNIDADE = 11, 31, 88, 101, 137; essas IDs **não existem** em `oportunidade` (IDs migrados vão de 33 a 343). São itens órfãos vindos do flow_crm.
- **Correção recomendada:** ver script `pós-migração-oportunidades.sql` (remover ou comentar os 5 órfãos se a regra de negócio permitir).

### 2.3 FKs que oportunidade referencia (synki)

- **pessoas(ID)** ← ID_PESSOA  
- **funil(ID)** ← ID_FUNIL  
- **origem(ID)** ← ID_ORIGEM  
- **usuario(id)** ← ID_VENDEDOR  
- **motivo_perda(ID)** ← ID_MOTIVO_PERDA  
- **produto_marca(id)** ← ID_MARCA  
- **etapas_oportunidade(ID)** ← ETAPA_ID  
- **empresa(id)** ← ID_EMPRESA  

**Integridade:** nenhuma oportunidade migrada aponta para pessoa, funil, origem, vendedor, motivo_perda, marca, etapa ou empresa inexistentes (0 órfãos nessas FKs).

---

## 3. Contagens e consistência (synki)

- **oportunidade:** 261.
- **oportunidade_evolucao:** 860 (todas com ID_OPORTUNIDADE existente).
- **item_oportunidade:** 263 (5 órfãos removidos: ID_OPORTUNIDADE 11, 31, 88, 101, 137).
- **agenda_compromisso** com ID_OPORTUNIDADE: 51.
- **atendimento** com ID_OPORTUNIDADE: 83.
- **pedido** com OPORTUNIDADE_ID: 90.
- **pedido_etapas** com ID_OPORTUNIDADE: 117.
- **documento_ged** com ID_OPORTUNIDADE: 11.

Nenhuma dessas tabelas (exceto item_oportunidade) tem referência para oportunidade inexistente.

---

## 4. Campos críticos pós-migração

- **ID_EMPRESA:** preenchido = 1 para todas (aplicação filtra por empresa).
- **ETAPA_ID:** preenchido a partir de STATUS (LEAD→1, PROSPECT→2, NEGOCIACAO→3, PEDIDO→4, FATURADO→5, PERDA→6, ARQUIVADO→7); etapas 6 e 7 criadas em `etapas_oportunidade` na pós-migração.
- **ID_FUNIL / ID_ORIGEM NULL:** Corrigido na pós-migração: ID_FUNIL = 6 e ID_ORIGEM = 4 onde estavam NULL. Nenhuma oportunidade fica sem funil ou origem.

---

## 5. Ordem recomendada na migração

1. Migrar tabelas referenciadas por oportunidade: **pessoas**, **funil**, **origem**, **usuario**, **motivo_perda**, **produto_marca**, **empresa**, **etapas_oportunidade** (incluindo etapas PERDA e ARQUIVADO).
2. **INSERT** em `oportunidade` (apenas colunas comuns ao flow_crm).
3. **INSERT** em **oportunidade_evolucao**, **item_oportunidade**, **pedido**, **pedido_etapas**, **atendimento**, **agenda_compromisso**, **documento_ged**, **evolucao_pedido**, **visitas_sugeridas** (ordem respeitando FKs).
4. Executar **pós-migração-oportunidades.sql** (ID_EMPRESA, ETAPA_ID, ID_ETAPA em oportunidade_evolucao, defaults para funil/origem, remoção de item_oportunidade órfãos).

---

## 6. Observações para a aplicação

- Listagens/filtros de oportunidade costumam usar **ID_EMPRESA**, **ETAPA_ID** e às vezes **ID_FUNIL**; garantir que esses campos estejam preenchidos para os registros migrados.
- **STATUS** foi mantido como cópia do valor do flow_crm; a lógica de etapa no synki deve usar **ETAPA_ID** e **etapas_oportunidade**.
- **UUID_OPORTUNIDADE** está NULL nos migrados; se a aplicação usar UUID para integração, pode ser gerado em lote depois.
