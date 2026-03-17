-- ============================================================
-- CHAT INTERNO - Criação das tabelas
-- ============================================================
-- Executar em cada banco synki_pulse* (ou flow_master).
-- Pré-requisito: tabela usuario com coluna id BIGINT (PK).
--
-- Uso: mysql -u root -p NOME_DO_BANCO < criar-tabelas-chat.sql
--
-- Para todos os synki_pulse*:
--   for db in $(mysql -u root -p -N -e "SELECT schema_name FROM information_schema.schemata WHERE schema_name LIKE 'synki_pulse%'"); do
--     mysql -u root -p "$db" < criar-tabelas-chat.sql
--   done
-- ============================================================

-- 1) Conversas (1-a-1)
CREATE TABLE IF NOT EXISTS chat_conversas (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  criado_em     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2) Participantes (2 por conversa)
CREATE TABLE IF NOT EXISTS chat_participantes (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  conversa_id    INT NOT NULL,
  usuario_id     BIGINT NOT NULL,
  criado_em      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uk_conversa_usuario (conversa_id, usuario_id),
  FOREIGN KEY (conversa_id) REFERENCES chat_conversas(id) ON DELETE CASCADE,
  FOREIGN KEY (usuario_id)  REFERENCES usuario(id) ON DELETE CASCADE,
  INDEX idx_usuario (usuario_id),
  INDEX idx_conversa (conversa_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3) Mensagens
CREATE TABLE IF NOT EXISTS chat_mensagens (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  conversa_id    INT NOT NULL,
  usuario_id     BIGINT NOT NULL COMMENT 'quem enviou',
  conteudo       TEXT NOT NULL,
  lida           TINYINT(1) NOT NULL DEFAULT 0,
  criado_em      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (conversa_id) REFERENCES chat_conversas(id) ON DELETE CASCADE,
  FOREIGN KEY (usuario_id)  REFERENCES usuario(id) ON DELETE CASCADE,
  INDEX idx_conversa (conversa_id),
  INDEX idx_criado (criado_em),
  INDEX idx_lida   (lida)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
