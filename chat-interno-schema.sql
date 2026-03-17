-- ============================================================
-- CHAT INTERNO - Proposta de tabelas
-- ============================================================
-- Onde criar: no banco do tenant (ex: synki_pulse58757395000151)
-- ou em flow_master, dependendo se o chat é por empresa ou global.
--
-- Pré-requisito: tabela usuario com coluna id (PK).
-- Se usuario tiver outro PK (ex: cpf_cnpj), ajuste as FKs.
-- ============================================================

-- 1) Conversas (apenas 1-a-1)
CREATE TABLE IF NOT EXISTS chat_conversas (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  criado_em     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2) Participantes (sempre 2 por conversa, chat 1-a-1)
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
  usuario_id     INT NOT NULL COMMENT 'quem enviou',
  conteudo       TEXT NOT NULL,
  lida           TINYINT(1) NOT NULL DEFAULT 0,
  criado_em      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (conversa_id) REFERENCES chat_conversas(id) ON DELETE CASCADE,
  FOREIGN KEY (usuario_id)  REFERENCES usuario(id) ON DELETE CASCADE,
  INDEX idx_conversa (conversa_id),
  INDEX idx_criado (criado_em),
  INDEX idx_lida   (lida)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Alternativa: se a tabela usuario tiver outro nome/PK
-- ============================================================
-- Exemplo: se usuario tem PK "cpf_cnpj" (VARCHAR):
-- ALTER TABLE chat_participantes 
--   CHANGE usuario_id usuario_cpf_cnpj VARCHAR(14),
--   DROP FOREIGN KEY chat_participantes_ibfk_2,
--   ADD FOREIGN KEY (usuario_cpf_cnpj) REFERENCES usuario(cpf_cnpj);
-- ============================================================
