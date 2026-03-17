-- Pós-migração: oportunidades
-- No flow_crm a etapa é o texto em STATUS; no synki é ETAPA_ID (FK para etapas_oportunidade).
-- Execute após o INSERT de oportunidade e oportunidade_evolucao.
-- Base: synki_pulse05036308000100

-- 1) Criar etapas que não existem no funil (PERDA, ARQUIVADO)
INSERT IGNORE INTO etapas_oportunidade (ID, CODIGO, NOME, ORDEM, COR_HEX, ATIVO, GERA_ATENDIMENTO, GERA_AGENDA)
VALUES
(6, 'PERDA', 'Perda', 60, '#EF4444', 'S', 'NAO', 'NAO'),
(7, 'ARQUIVADO', 'Arquivado', 70, '#9CA3AF', 'S', 'NAO', 'NAO');

-- 2) Preencher ID_EMPRESA (aplicação filtra por empresa)
UPDATE oportunidade SET ID_EMPRESA = 1 WHERE ID_EMPRESA IS NULL;

-- 3) Mapear STATUS -> ETAPA_ID em oportunidade
-- etapas_oportunidade: 1=LEAD, 2=PROSPECT, 3=NEGOCIACAO, 4=PEDIDO, 5=FATURADO, 6=PERDA, 7=ARQUIVADO
UPDATE oportunidade SET ETAPA_ID = 1 WHERE STATUS = 'LEAD';
UPDATE oportunidade SET ETAPA_ID = 2 WHERE STATUS = 'PROSPECT';
UPDATE oportunidade SET ETAPA_ID = 3 WHERE STATUS = 'NEGOCIACAO';
UPDATE oportunidade SET ETAPA_ID = 4 WHERE STATUS = 'PEDIDO';
UPDATE oportunidade SET ETAPA_ID = 5 WHERE STATUS = 'FATURADO';
UPDATE oportunidade SET ETAPA_ID = 6 WHERE STATUS = 'PERDA';
UPDATE oportunidade SET ETAPA_ID = 7 WHERE STATUS = 'ARQUIVADO';

-- 4) Mapear STATUS -> ID_ETAPA em oportunidade_evolucao (histórico)
UPDATE oportunidade_evolucao SET ID_ETAPA = 1 WHERE STATUS = 'LEAD';
UPDATE oportunidade_evolucao SET ID_ETAPA = 2 WHERE STATUS = 'PROSPECT';
UPDATE oportunidade_evolucao SET ID_ETAPA = 3 WHERE STATUS = 'NEGOCIACAO';
UPDATE oportunidade_evolucao SET ID_ETAPA = 4 WHERE STATUS = 'PEDIDO';
UPDATE oportunidade_evolucao SET ID_ETAPA = 5 WHERE STATUS = 'FATURADO';
UPDATE oportunidade_evolucao SET ID_ETAPA = 6 WHERE STATUS = 'PERDA';
UPDATE oportunidade_evolucao SET ID_ETAPA = 7 WHERE STATUS = 'ARQUIVADO';
-- Registros "Atendimento ..." ficam com ID_ETAPA NULL (são tipo de atendimento, não etapa do funil).

-- 5) Preencher ID_FUNIL e ID_ORIGEM onde NULL (app pode filtrar por funil)
UPDATE oportunidade SET ID_FUNIL = 6 WHERE ID_FUNIL IS NULL;
UPDATE oportunidade SET ID_ORIGEM = 4 WHERE ID_ORIGEM IS NULL;

-- 6) Remover itens de oportunidade órfãos (ID_OPORTUNIDADE não existe em oportunidade)
DELETE FROM item_oportunidade WHERE ID_OPORTUNIDADE NOT IN (SELECT ID FROM oportunidade);
