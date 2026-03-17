# Investigação da base de dados – Chat interno

## O que foi encontrado

### Arquitetura atual

| Componente | Banco | Uso |
|------------|-------|-----|
| **PostgreSQL** (72.60.245.119:5432) | `evolution` | Evolution API – WhatsApp (chats, mensagens, contatos) |
| **MySQL** | `flow_master` | Master – view `vw_usuario_empresa_pessoa` (cpf_cnpj, pessoa_cpf_cnpj, email) |
| **MySQL** | `synki_pulse{CNPJ}` | Tenant por empresa (ex: `synki_pulse58757395000151`) – tabela `pessoas` para leads |

### View `vw_usuario_empresa_pessoa` (flow_master)

- Colunas: `cpf_cnpj`, `pessoa_cpf_cnpj`, `email`
- Faz a ponte entre usuário (CPF) e empresa (CNPJ)
- Usada para resolver o tenant e conectar em `synki_pulse{CNPJ}`

### Tabela `usuario`

- Está na base onde a view `vw_usuario_empresa_pessoa` faz join (provavelmente em `flow_master`)
- Para o chat interno, precisamos saber a PK: `id` ou `cpf_cnpj` (e outros campos)

### Observação

A VPS 100.104.1.54 não tem `MYSQL_*` configurado no `.env` do CAHTS. O MySQL que aparece no seu cliente (`synki_pulse58757395000151`) provavelmente é acessado direto da sua máquina ou de outro host.

---

## Chat interno – proposta

Sim, para o chat interno é recomendável criar novas tabelas.

### 1. Onde criar

- **Por tenant** (por empresa): em cada `synki_pulse{CNPJ}` – chat interno da empresa
- **Centralizado**: em `flow_master` – chat entre usuários de qualquer tenant

Sugestão: por tenant em `synki_pulse{CNPJ}`, para manter o chat por empresa.

### 2. Tabelas sugeridas (chat 1-a-1, sem grupos)

1. **`chat_conversas`** – conversa entre 2 usuários
2. **`chat_participantes`** – os 2 participantes de cada conversa
3. **`chat_mensagens`** – mensagens enviadas

O arquivo `chat-interno-schema.sql` contém o `CREATE TABLE` sugerido.

### 3. Ligação com `usuario`

- O schema assume uma tabela `usuario` com coluna `id` (PK).
- Se `usuario` tiver outra PK (ex: `cpf_cnpj`), ajuste as FKs no script.
- Se `usuario` estiver em `flow_master` e o chat em `synki_pulse*`, será preciso:
  - ter em `synki_pulse*` uma tabela de usuários (espelho ou referência), ou
  - centralizar o chat em `flow_master`.

### 4. Próximos passos

1. Conferir a estrutura de `usuario`: `DESCRIBE usuario` ou `SHOW CREATE TABLE usuario`
2. Escolher onde o chat fica: `flow_master` ou `synki_pulse{CNPJ}`
3. Ajustar `chat-interno-schema.sql` conforme a PK de `usuario` e o banco escolhido
4. Executar o script no banco escolhido
5. Implementar as APIs e a UI do chat usando essas tabelas
