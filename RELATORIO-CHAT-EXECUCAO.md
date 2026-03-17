# Relatório – Execução do schema de chat interno

**Data:** 28/02/2025  
**Host:** 100.104.1.54:3306 (MySQL)

---

## Bases onde foi executado (9 bancos)

| Banco |
|-------|
| synki_pulse |
| synki_pulse05036308000100 |
| synki_pulse34113364000108 |
| synki_pulse50047122000101 |
| synki_pulse51459391000148 |
| synki_pulse57006716000113 |
| synki_pulse58757395000151 |
| synki_pulse61175427000115 |
| synki_pulse63569470000190 |

---

## Tabelas criadas em cada banco

| Tabela              | Colunas                                                                 |
|---------------------|-------------------------------------------------------------------------|
| `chat_conversas`    | id, criado_em                                                          |
| `chat_participantes`| id, conversa_id, usuario_id, criado_em                                |
| `chat_mensagens`    | id, conversa_id, usuario_id, conteudo, lida, criado_em                |

---

## Relacionamentos

- `chat_participantes.conversa_id` → `chat_conversas.id`
- `chat_participantes.usuario_id`  → `usuario.id`
- `chat_mensagens.conversa_id`     → `chat_conversas.id`
- `chat_mensagens.usuario_id`      → `usuario.id`

---

## Observação

O schema usa `usuario_id BIGINT` para compatibilidade com a PK `usuario.id` (bigint) no tenant.
