-- Migração flow_crm -> synki_pulse05036308000100
-- Colunas comuns apenas. Execute: mysql -h 209.50.229.247 -u root -p < migracao.sql

SET FOREIGN_KEY_CHECKS=0;
SET SESSION sql_mode='NO_ENGINE_SUBSTITUTION';

-- agencia_banco
INSERT IGNORE INTO `synki_pulse05036308000100`.`agencia_banco` (`ID`, `BAIRRO`, `CEP`, `CIDADE`, `COD_AGENCIA`, `COD_CONTA`, `COMPLEMENTO`, `CONTA`, `CONTATO`, `DATA_SALDO_ATUAL`, `DATA_SALDO_INICIAL`, `DESCRICAO`, `DV_CONTA`, `ENDERECO`, `GERENTE`, `NOME`, `NUMERO`, `OBSERVACAO`, `SALDO_ATUAL`, `SALDO_INICIAL`, `SITUACAO_CONTA`, `TELEFONE1`, `TELEFONE2`, `UF`, `BANCO_ID`, `TIPO_CONTA_ID`) SELECT `ID`, `BAIRRO`, `CEP`, `CIDADE`, `COD_AGENCIA`, `COD_CONTA`, `COMPLEMENTO`, `CONTA`, `CONTATO`, `DATA_SALDO_ATUAL`, `DATA_SALDO_INICIAL`, `DESCRICAO`, `DV_CONTA`, `ENDERECO`, `GERENTE`, `NOME`, `NUMERO`, `OBSERVACAO`, `SALDO_ATUAL`, `SALDO_INICIAL`, `SITUACAO_CONTA`, `TELEFONE1`, `TELEFONE2`, `UF`, `BANCO_ID`, `TIPO_CONTA_ID` FROM `flow_crm`.`agencia_banco`;

-- agencia_caixa
INSERT IGNORE INTO `synki_pulse05036308000100`.`agencia_caixa` (`ID`, `BAIRRO`, `CEP`, `CIDADE`, `COD_AGENCIA`, `COD_CONTA`, `COMPLEMENTO`, `CONTA`, `CONTATO`, `DATA_SALDO_ATUAL`, `DATA_SALDO_INICIAL`, `DESCRICAO`, `DV_CONTA`, `ENDERECO`, `GERENTE`, `NOME`, `NUMERO`, `OBSERVACAO`, `SALDO_ATUAL`, `SALDO_INICIAL`, `SITUACAO_CONTA`, `TELEFONE1`, `TELEFONE2`, `TIPO_CONTAB`, `UF`, `BANCO_ID`) SELECT `ID`, `BAIRRO`, `CEP`, `CIDADE`, `COD_AGENCIA`, `COD_CONTA`, `COMPLEMENTO`, `CONTA`, `CONTATO`, `DATA_SALDO_ATUAL`, `DATA_SALDO_INICIAL`, `DESCRICAO`, `DV_CONTA`, `ENDERECO`, `GERENTE`, `NOME`, `NUMERO`, `OBSERVACAO`, `SALDO_ATUAL`, `SALDO_INICIAL`, `SITUACAO_CONTA`, `TELEFONE1`, `TELEFONE2`, `TIPO_CONTAB`, `UF`, `BANCO_ID` FROM `flow_crm`.`agencia_caixa`;

-- agenda_categoria_compromisso
INSERT IGNORE INTO `synki_pulse05036308000100`.`agenda_categoria_compromisso` (`ID`, `COR`, `NOME`) SELECT `ID`, `COR`, `NOME` FROM `flow_crm`.`agenda_categoria_compromisso`;

-- agenda_compromisso
INSERT IGNORE INTO `synki_pulse05036308000100`.`agenda_compromisso` (`ID`, `DATA_COMPROMISSO`, `DATA_FIM`, `DATA_INICIO`, `DESCRICAO`, `DURACAO`, `HORA`, `ONDE`, `TIPO`, `ID_AGENDA_CATEGORIA_COMPROMISSO`, `ID_USUARIO`, `ID_PESSOA`, `HORA_FIM`, `HORA_INICIO`, `alertar_em`, `status`, `nome_colaborador`, `ID_ATENDIMENTO`, `ID_OPORTUNIDADE`, `HASH_VERIFICACAO`, `numero`, `confirmacao`) SELECT `ID`, `DATA_COMPROMISSO`, `DATA_FIM`, `DATA_INICIO`, `DESCRICAO`, `DURACAO`, `HORA`, `ONDE`, `TIPO`, `ID_AGENDA_CATEGORIA_COMPROMISSO`, `ID_USUARIO`, `ID_PESSOA`, `HORA_FIM`, `HORA_INICIO`, `alertar_em`, `status`, `nome_colaborador`, `ID_ATENDIMENTO`, `ID_OPORTUNIDADE`, `HASH_VERIFICACAO`, `numero`, `confirmacao` FROM `flow_crm`.`agenda_compromisso`;

-- agenda_compromisso_convidado
INSERT IGNORE INTO `synki_pulse05036308000100`.`agenda_compromisso_convidado` (`ID`, `ID_AGENDA_COMPROMISSO`, `ID_USUARIO`) SELECT `ID`, `ID_AGENDA_COMPROMISSO`, `ID_USUARIO` FROM `flow_crm`.`agenda_compromisso_convidado`;

-- agenda_notificacao
INSERT IGNORE INTO `synki_pulse05036308000100`.`agenda_notificacao` (`ID`, `DATA_NOTIFICACAO`, `HORA`, `TIPO`, `ID_AGENDA_COMPROMISSO`) SELECT `ID`, `DATA_NOTIFICACAO`, `HORA`, `TIPO`, `ID_AGENDA_COMPROMISSO` FROM `flow_crm`.`agenda_notificacao`;

-- almoxarifado
INSERT IGNORE INTO `synki_pulse05036308000100`.`almoxarifado` (`ID`, `LATITUDE`, `LONGITUDE`, `NOME`, `ID_EMPRESA`) SELECT `ID`, `LATITUDE`, `LONGITUDE`, `NOME`, `ID_EMPRESA` FROM `flow_crm`.`almoxarifado`;

-- analise_ia
INSERT IGNORE INTO `synki_pulse05036308000100`.`analise_ia` (`ID`, `ANALISE`, `DATA_GERACAO`, `ORIGEM`, `ID_USUARIO`, `NOME`) SELECT `ID`, `ANALISE`, `DATA_GERACAO`, `ORIGEM`, `ID_USUARIO`, `NOME` FROM `flow_crm`.`analise_ia`;

-- atendimento
INSERT IGNORE INTO `synki_pulse05036308000100`.`atendimento` (`ID`, `CONTATO`, `DATA_CRIACAO`, `DATA_INICIO`, `DATA_TERMINO`, `HORA_FIM`, `HORA_INICIO`, `OBSERVACAO`, `VALOR`, `ID_PESSOA`, `ID_LOCAL`, `ID_TIPO_ATENDIMENTO`, `ID_VENDEDOR`, `DATA_ALTERACAO`, `ID_VENDEDOR1`, `ID_OPORTUNIDADE`, `ENVIADO_AGENDA`, `OBS`, `ID_TIPO_SERVICO`) SELECT `ID`, `CONTATO`, `DATA_CRIACAO`, `DATA_INICIO`, `DATA_TERMINO`, `HORA_FIM`, `HORA_INICIO`, `OBSERVACAO`, `VALOR`, `ID_PESSOA`, `ID_LOCAL`, `ID_TIPO_ATENDIMENTO`, `ID_VENDEDOR`, `DATA_ALTERACAO`, `ID_VENDEDOR1`, `ID_OPORTUNIDADE`, `ENVIADO_AGENDA`, `OBS`, `ID_TIPO_SERVICO` FROM `flow_crm`.`atendimento`;

-- backgrounds
INSERT IGNORE INTO `synki_pulse05036308000100`.`backgrounds` (`ID`, `NOME`, `BACKGROUND`) SELECT `ID`, `NOME`, `BACKGROUND` FROM `flow_crm`.`backgrounds`;

-- banco
INSERT IGNORE INTO `synki_pulse05036308000100`.`banco` (`ID`, `COD`, `BANCO`, `URL`, `CODIGO`, `NOME`) SELECT `ID`, `COD`, `BANCO`, `URL`, `CODIGO`, `NOME` FROM `flow_crm`.`banco`;

-- c_beneficio
INSERT IGNORE INTO `synki_pulse05036308000100`.`c_beneficio` (`id`, `CODIGO`, `CONTAGEM`, `CST_00`, `CST_10`, `CST_20`, `CST_30`, `CST_40`, `CST_41`, `CST_50`, `CST_51`, `CST_60`, `CST_70`, `CST_90`, `DESCRICAO`, `DESCRICAO_NFE`, `OBS`) SELECT `id`, `CODIGO`, `CONTAGEM`, `CST_00`, `CST_10`, `CST_20`, `CST_30`, `CST_40`, `CST_41`, `CST_50`, `CST_51`, `CST_60`, `CST_70`, `CST_90`, `DESCRICAO`, `DESCRICAO_NFE`, `OBS` FROM `flow_crm`.`c_beneficio`;

-- campanha
INSERT IGNORE INTO `synki_pulse05036308000100`.`campanha` (`ID`, `BAIRRO`, `caminhoImagem`, `CIDADE`, `DATA_CADASTRO`, `DATA_FIM_EXECUCAO`, `DATA_FINAL`, `DATA_INICIAL`, `GERAR_MENSSAGEM`, `imagem`, `NOME`, `OBS`, `SEXO`, `STATUS`, `TEM_MIDIA_IMAGEM`, `USUARIO`, `EMPRESA_ID`, `PESSOA_ID`) SELECT `ID`, `BAIRRO`, `caminhoImagem`, `CIDADE`, `DATA_CADASTRO`, `DATA_FIM_EXECUCAO`, `DATA_FINAL`, `DATA_INICIAL`, `GERAR_MENSSAGEM`, `imagem`, `NOME`, `OBS`, `SEXO`, `STATUS`, `TEM_MIDIA_IMAGEM`, `USUARIO`, `EMPRESA_ID`, `PESSOA_ID` FROM `flow_crm`.`campanha`;

-- categoria
INSERT IGNORE INTO `synki_pulse05036308000100`.`categoria` (`id`, `descricao`, `categoria_pai_id`) SELECT `id`, `descricao`, `categoria_pai_id` FROM `flow_crm`.`categoria`;

-- categoria_cliente
INSERT IGNORE INTO `synki_pulse05036308000100`.`categoria_cliente` (`ID`, `DESCRICAO`, `NOME`) SELECT `ID`, `DESCRICAO`, `NOME` FROM `flow_crm`.`categoria_cliente`;

-- cbo
INSERT IGNORE INTO `synki_pulse05036308000100`.`cbo` (`ID`, `CODIGO`, `CODIGO_1994`, `NOME`, `OBSERVACAO`) SELECT `ID`, `CODIGO`, `CODIGO_1994`, `NOME`, `OBSERVACAO` FROM `flow_crm`.`cbo`;

-- centro_custo
INSERT IGNORE INTO `synki_pulse05036308000100`.`centro_custo` (`ID`, `BAIRRO`, `CEP`, `CIDADE`, `CNPJ`, `DATA_CRIACAO`, `DESCRICAO`, `EMAIL`, `FONE`, `IE`, `LOGRADOURO`, `NOME`, `NUM`, `UF`, `valor_total`) SELECT `ID`, `BAIRRO`, `CEP`, `CIDADE`, `CNPJ`, `DATA_CRIACAO`, `DESCRICAO`, `EMAIL`, `FONE`, `IE`, `LOGRADOURO`, `NOME`, `NUM`, `UF`, `valor_total` FROM `flow_crm`.`centro_custo`;

-- cfop
INSERT IGNORE INTO `synki_pulse05036308000100`.`cfop` (`ID`, `APLICACAO`, `CFOP`, `DESCRICAO`, `valores`) SELECT `ID`, `APLICACAO`, `CFOP`, `DESCRICAO`, `valores` FROM `flow_crm`.`cfop`;

-- cliente
INSERT IGNORE INTO `synki_pulse05036308000100`.`cliente` (`id`, `DATA_CADASTRO`, `DESDE`, `LIMITE_CREDITO`, `OBSERVACAO`, `TAXA_DESCONTO`, `ID_PESSOA`) SELECT `id`, `DATA_CADASTRO`, `DESDE`, `LIMITE_CREDITO`, `OBSERVACAO`, `TAXA_DESCONTO`, `ID_PESSOA` FROM `flow_crm`.`cliente`;

-- colaborador
INSERT IGNORE INTO `synki_pulse05036308000100`.`colaborador` (`id`, `CTPS_DATA_EXPEDICAO`, `CTPS_NUMERO`, `CTPS_SERIE`, `CTPS_UF`, `DATA_ADMISSAO`, `DATA_CADASTRO`, `DATA_DEMISSAO`, `MATRICULA`, `OBSERVACAO`, `ID_PESSOA`) SELECT `id`, `CTPS_DATA_EXPEDICAO`, `CTPS_NUMERO`, `CTPS_SERIE`, `CTPS_UF`, `DATA_ADMISSAO`, `DATA_CADASTRO`, `DATA_DEMISSAO`, `MATRICULA`, `OBSERVACAO`, `ID_PESSOA` FROM `flow_crm`.`colaborador`;

-- comissao_objetivo
INSERT IGNORE INTO `synki_pulse05036308000100`.`comissao_objetivo` (`ID`, `CODIGO`, `DESCRICAO`, `FORMA_PAGAMENTO`, `NOME`, `QUANTIDADE`, `TAXA_PAGAMENTO`, `VALOR_META`, `VALOR_PAGAMENTO`, `ID_COMISSAO_PERFIL`, `ID_PRODUTO`) SELECT `ID`, `CODIGO`, `DESCRICAO`, `FORMA_PAGAMENTO`, `NOME`, `QUANTIDADE`, `TAXA_PAGAMENTO`, `VALOR_META`, `VALOR_PAGAMENTO`, `ID_COMISSAO_PERFIL`, `ID_PRODUTO` FROM `flow_crm`.`comissao_objetivo`;

-- comissao_perfil
INSERT IGNORE INTO `synki_pulse05036308000100`.`comissao_perfil` (`ID`, `CODIGO`, `NOME`, `ID_EMPRESA`, `ID_USUARIO`) SELECT `ID`, `CODIGO`, `NOME`, `ID_EMPRESA`, `ID_USUARIO` FROM `flow_crm`.`comissao_perfil`;

-- configuracoes
INSERT IGNORE INTO `synki_pulse05036308000100`.`configuracoes` (`ID`, `CIDADE`, `CNPJ`, `EMAIL_ALERTAS`, `LOGO`, `NOME`, `QUOTA`, `TIPO_USUARIO`, `LOGRADOURO`, `BAIRRO`, `UF`, `FONE`, `CONDICOES`, `SERIE`, `REGIAO`) SELECT `ID`, `CIDADE`, `CNPJ`, `EMAIL_ALERTAS`, `LOGO`, `NOME`, `QUOTA`, `TIPO_USUARIO`, `LOGRADOURO`, `BAIRRO`, `UF`, `FONE`, `CONDICOES`, `SERIE`, `REGIAO` FROM `flow_crm`.`configuracoes`;

-- configuracoes_email
INSERT IGNORE INTO `synki_pulse05036308000100`.`configuracoes_email` (`id`, `autenticacaoRequerida`, `email`, `imapPorta`, `imapSSL`, `imapServidor`, `nomeRemetente`, `senha`, `smtpPorta`, `smtpSSL`, `smtpServidor`, `smtpTLS`, `usuario_id`) SELECT `id`, `autenticacaoRequerida`, `email`, `imapPorta`, `imapSSL`, `imapServidor`, `nomeRemetente`, `senha`, `smtpPorta`, `smtpSSL`, `smtpServidor`, `smtpTLS`, `usuario_id` FROM `flow_crm`.`configuracoes_email`;

-- contact
INSERT IGNORE INTO `synki_pulse05036308000100`.`contact` (`id`, `createdAt`, `profilePicUrl`, `pushName`, `remoteJid`, `updatedAt`, `instanceId`) SELECT `id`, `createdAt`, `profilePicUrl`, `pushName`, `remoteJid`, `updatedAt`, `instanceId` FROM `flow_crm`.`contact`;

-- contrato
INSERT IGNORE INTO `synki_pulse05036308000100`.`contrato` (`ID`, `CLASSIFICACAO_CONTABIL_CONTA`, `DATA_CADASTRO`, `DATA_FIM_VIGENCIA`, `DATA_INICIO_VIGENCIA`, `DESCRICAO`, `DIA_FATURAMENTO`, `INTERVALO_ENTRE_PARCELAS`, `NOME`, `NUMERO`, `OBSERVACAO`, `QUANTIDADE_PARCELAS`, `VALOR`, `ID_SOLICITACAO_SERVICO`, `ID_TIPO_CONTRATO`) SELECT `ID`, `CLASSIFICACAO_CONTABIL_CONTA`, `DATA_CADASTRO`, `DATA_FIM_VIGENCIA`, `DATA_INICIO_VIGENCIA`, `DESCRICAO`, `DIA_FATURAMENTO`, `INTERVALO_ENTRE_PARCELAS`, `NOME`, `NUMERO`, `OBSERVACAO`, `QUANTIDADE_PARCELAS`, `VALOR`, `ID_SOLICITACAO_SERVICO`, `ID_TIPO_CONTRATO` FROM `flow_crm`.`contrato`;

-- contrato_hist_faturamento
INSERT IGNORE INTO `synki_pulse05036308000100`.`contrato_hist_faturamento` (`ID`, `DATA_FATURA`, `VALOR`, `ID_CONTRATO`) SELECT `ID`, `DATA_FATURA`, `VALOR`, `ID_CONTRATO` FROM `flow_crm`.`contrato_hist_faturamento`;

-- contrato_historico_reajuste
INSERT IGNORE INTO `synki_pulse05036308000100`.`contrato_historico_reajuste` (`ID`, `DATA_REAJUSTE`, `INDICE`, `OBSERVACAO`, `VALOR_ANTERIOR`, `VALOR_ATUAL`, `ID_CONTRATO`) SELECT `ID`, `DATA_REAJUSTE`, `INDICE`, `OBSERVACAO`, `VALOR_ANTERIOR`, `VALOR_ATUAL`, `ID_CONTRATO` FROM `flow_crm`.`contrato_historico_reajuste`;

-- contrato_prev_faturamento
INSERT IGNORE INTO `synki_pulse05036308000100`.`contrato_prev_faturamento` (`ID`, `DATA_PREVISTA`, `VALOR`, `ID_CONTRATO`) SELECT `ID`, `DATA_PREVISTA`, `VALOR`, `ID_CONTRATO` FROM `flow_crm`.`contrato_prev_faturamento`;

-- contrato_solicitacao_servico
INSERT IGNORE INTO `synki_pulse05036308000100`.`contrato_solicitacao_servico` (`ID`, `DATA_DESEJADA_INICIO`, `DATA_SOLICITACAO`, `DESCRICAO`, `STATUS_SOLICITACAO`, `URGENTE`, `ID_CLIENTE`, `ID_COLABORADOR`, `ID_CONTRATO_TIPO_SERVICO`) SELECT `ID`, `DATA_DESEJADA_INICIO`, `DATA_SOLICITACAO`, `DESCRICAO`, `STATUS_SOLICITACAO`, `URGENTE`, `ID_CLIENTE`, `ID_COLABORADOR`, `ID_CONTRATO_TIPO_SERVICO` FROM `flow_crm`.`contrato_solicitacao_servico`;

-- contrato_template
INSERT IGNORE INTO `synki_pulse05036308000100`.`contrato_template` (`ID`, `DESCRICAO`, `NOME`, `ID_EMPRESA`) SELECT `ID`, `DESCRICAO`, `NOME`, `ID_EMPRESA` FROM `flow_crm`.`contrato_template`;

-- contrato_tipo_servico
INSERT IGNORE INTO `synki_pulse05036308000100`.`contrato_tipo_servico` (`ID`, `DESCRICAO`, `NOME`, `ID_EMPRESA`) SELECT `ID`, `DESCRICAO`, `NOME`, `ID_EMPRESA` FROM `flow_crm`.`contrato_tipo_servico`;

-- csosn
INSERT IGNORE INTO `synki_pulse05036308000100`.`csosn` (`ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO`, `valores`) SELECT `ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO`, `valores` FROM `flow_crm`.`csosn`;

-- cst_cofins
INSERT IGNORE INTO `synki_pulse05036308000100`.`cst_cofins` (`ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO`) SELECT `ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO` FROM `flow_crm`.`cst_cofins`;

-- cst_icms
INSERT IGNORE INTO `synki_pulse05036308000100`.`cst_icms` (`ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO`) SELECT `ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO` FROM `flow_crm`.`cst_icms`;

-- cst_ipi
INSERT IGNORE INTO `synki_pulse05036308000100`.`cst_ipi` (`ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO`) SELECT `ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO` FROM `flow_crm`.`cst_ipi`;

-- cst_pis
INSERT IGNORE INTO `synki_pulse05036308000100`.`cst_pis` (`ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO`) SELECT `ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO` FROM `flow_crm`.`cst_pis`;

-- cultura
INSERT IGNORE INTO `synki_pulse05036308000100`.`cultura` (`ID`, `DESCRICAO`, `NOME`) SELECT `ID`, `DESCRICAO`, `NOME` FROM `flow_crm`.`cultura`;

-- documento_ged
INSERT IGNORE INTO `synki_pulse05036308000100`.`documento_ged` (`id`, `ALERTA_EM`, `ASSINADO`, `ASSINATURA`, `caminho`, `COM_DOCUMENTO`, `data_cadastro`, `data_documento`, `descricao`, `EMAILS_ALERTA`, `EXTENSAO`, `FILE`, `FILE_BASE64`, `HASH`, `matricula`, `NOME`, `NUMERO_DOCUMENTO`, `status`, `TAMANHO`, `ID_PESSOA`, `ID_ATENDIMENTO`, `ID_TIPO_DOCUMENTO`, `ID_SERVICO_ATENDIMENTO`, `ID_OPORTUNIDADE`, `NOME_ARQUIVO`) SELECT `id`, `ALERTA_EM`, `ASSINADO`, `ASSINATURA`, `caminho`, `COM_DOCUMENTO`, `data_cadastro`, `data_documento`, `descricao`, `EMAILS_ALERTA`, `EXTENSAO`, `FILE`, `FILE_BASE64`, `HASH`, `matricula`, `NOME`, `NUMERO_DOCUMENTO`, `status`, `TAMANHO`, `ID_PESSOA`, `ID_ATENDIMENTO`, `ID_TIPO_DOCUMENTO`, `ID_SERVICO_ATENDIMENTO`, `ID_OPORTUNIDADE`, `NOME_ARQUIVO` FROM `flow_crm`.`documento_ged`;

-- eixo
INSERT IGNORE INTO `synki_pulse05036308000100`.`eixo` (`ID`, `NOME`) SELECT `ID`, `NOME` FROM `flow_crm`.`eixo`;

-- empresa
INSERT IGNORE INTO `synki_pulse05036308000100`.`empresa` (`id`, `ambiente`, `BAIXA_DFE`, `CAMINHO_CERTIFICADO`, `CAMINHO_COMPLETO_CERTIFICADO`, `CAMINHO_LOGO_EMPRESA`, `CEI`, `CERTIFICADO_ARQUIVO`, `CNPJ`, `CODIGO_CNAE_PRINCIPAL`, `CODIGO_IBGE_CIDADE`, `CODIGO_IBGE_UF`, `CONTATO`, `CRT`, `DATA_CONSTITUICAO`, `DATA_INSC_JUNTA_COMERCIAL`, `EMAIL`, `EMAIL_CONTADOR`, `enderecoPrincipal`, `ENVIAR_EM_DIAS`, `INSCRICAO_ESTADUAL`, `INSCRICAO_JUNTA_COMERCIAL`, `INSCRICAO_MUNICIPAL`, `LOGO_EMPRESA`, `MODELO`, `NOME_FANTASIA`, `nsu`, `RAZAO_SOCIAL`, `SENHA_CERTIFICADO`, `SERIE`, `SITE`, `TIPO`, `TIPO_AMBIENTE`, `TIPO_EMITENTE`, `TIPO_REGIME`, `uf`, `CIDADE`, `URL_INSTANCIA`, `CELULAR`, `ID_GOOGLE_AGENDA`, `ID_USUARIO`, `ID_EMPRESA_MATRIZ`) SELECT `id`, `ambiente`, `BAIXA_DFE`, `CAMINHO_CERTIFICADO`, `CAMINHO_COMPLETO_CERTIFICADO`, `CAMINHO_LOGO_EMPRESA`, `CEI`, `CERTIFICADO_ARQUIVO`, `CNPJ`, `CODIGO_CNAE_PRINCIPAL`, `CODIGO_IBGE_CIDADE`, `CODIGO_IBGE_UF`, `CONTATO`, `CRT`, `DATA_CONSTITUICAO`, `DATA_INSC_JUNTA_COMERCIAL`, `EMAIL`, `EMAIL_CONTADOR`, `enderecoPrincipal`, `ENVIAR_EM_DIAS`, `INSCRICAO_ESTADUAL`, `INSCRICAO_JUNTA_COMERCIAL`, `INSCRICAO_MUNICIPAL`, `LOGO_EMPRESA`, `MODELO`, `NOME_FANTASIA`, `nsu`, `RAZAO_SOCIAL`, `SENHA_CERTIFICADO`, `SERIE`, `SITE`, `TIPO`, `TIPO_AMBIENTE`, `TIPO_EMITENTE`, `TIPO_REGIME`, `uf`, `CIDADE`, `URL_INSTANCIA`, `CELULAR`, `ID_GOOGLE_AGENDA`, `ID_USUARIO`, `ID_EMPRESA_MATRIZ` FROM `flow_crm`.`empresa`;

-- empresa_contato
INSERT IGNORE INTO `synki_pulse05036308000100`.`empresa_contato` (`id`, `EMAIL`, `NOME`, `OBSERVACAO`, `ID_EMPRESA`) SELECT `id`, `EMAIL`, `NOME`, `OBSERVACAO`, `ID_EMPRESA` FROM `flow_crm`.`empresa_contato`;

-- empresa_endereco
INSERT IGNORE INTO `synki_pulse05036308000100`.`empresa_endereco` (`id`, `BAIRRO`, `CEP`, `CIDADE`, `COBRANCA`, `CODIGO_UF`, `COMPLEMENTO`, `CORRESPONDENCIA`, `ENTREGA`, `INSCRICAO_ESTADUAL`, `LOGRADOURO`, `MUNICIPIO_IBGE`, `NUMERO`, `PRINCIPAL`, `SERIE`, `UF`, `ID_EMPRESA`) SELECT `id`, `BAIRRO`, `CEP`, `CIDADE`, `COBRANCA`, `CODIGO_UF`, `COMPLEMENTO`, `CORRESPONDENCIA`, `ENTREGA`, `INSCRICAO_ESTADUAL`, `LOGRADOURO`, `MUNICIPIO_IBGE`, `NUMERO`, `PRINCIPAL`, `SERIE`, `UF`, `ID_EMPRESA` FROM `flow_crm`.`empresa_endereco`;

-- empresa_telefone
INSERT IGNORE INTO `synki_pulse05036308000100`.`empresa_telefone` (`id`, `NUMERO`, `TIPO`, `ID_EMPRESA`) SELECT `id`, `NUMERO`, `TIPO`, `ID_EMPRESA` FROM `flow_crm`.`empresa_telefone`;

-- empresa_vinculada
INSERT IGNORE INTO `synki_pulse05036308000100`.`empresa_vinculada` (`ID`, `PRINCIPAL`, `ID_EMPRESA`, `ID_USUARIO`) SELECT `ID`, `PRINCIPAL`, `ID_EMPRESA`, `ID_USUARIO` FROM `flow_crm`.`empresa_vinculada`;

-- etapas
INSERT IGNORE INTO `synki_pulse05036308000100`.`etapas` (`ID`, `DATA_CRIACAO`, `NOME`, `OBS`, `ID_PEDIDO_ETAPA`, `COR`, `GERAR_AGENDA`) SELECT `ID`, `DATA_CRIACAO`, `NOME`, `OBS`, `ID_PEDIDO_ETAPA`, `COR`, `GERAR_AGENDA` FROM `flow_crm`.`etapas`;

-- evolucao_pedido
INSERT IGNORE INTO `synki_pulse05036308000100`.`evolucao_pedido` (`ID`, `DATA_ALTERACAO`, `DATA_CRIACAO`, `OBS`, `STATUS`, `VALOR`, `ID_OPORTUNIDADE`, `ID_VENDEDOR_ALTEROU`, `ID_VENDEDOR`, `ID_ETAPA`, `ID_ATENDIMENTO`, `DESCRICAO`, `NOME`) SELECT `ID`, `DATA_ALTERACAO`, `DATA_CRIACAO`, `OBS`, `STATUS`, `VALOR`, `ID_OPORTUNIDADE`, `ID_VENDEDOR_ALTEROU`, `ID_VENDEDOR`, `ID_ETAPA`, `ID_ATENDIMENTO`, `DESCRICAO`, `NOME` FROM `flow_crm`.`evolucao_pedido`;

-- fin_documento_origem
INSERT IGNORE INTO `synki_pulse05036308000100`.`fin_documento_origem` (`ID`, `ID_EMPRESA`, `CODIGO`, `SIGLA_DOCUMENTO`, `DESCRICAO`, `ATIVO`) SELECT `ID`, `ID_EMPRESA`, `CODIGO`, `SIGLA_DOCUMENTO`, `DESCRICAO`, `ATIVO` FROM `flow_crm`.`fin_documento_origem`;

-- fin_lancamento_receber
INSERT IGNORE INTO `synki_pulse05036308000100`.`fin_lancamento_receber` (`ID`, `COD_AGENCIA`, `CODIGO_MODULO_LCTO`, `DATA_LANCAMENTO`, `DATA_NOTA`, `FISCAL`, `FRETE`, `HASH_MODULO_LCTO`, `HISTORICO`, `ID_AGENCIA`, `ID_CARGA`, `ID_NFE`, `ID_VENDA`, `INTERVALO_ENTRE_PARCELAS`, `MESCLADO_PARA`, `NOME_AGENCIA`, `NUMERO_DOCUMENTO`, `PARCELAR`, `PLANO_CONTA`, `PRIMEIRO_VENCIMENTO`, `QUANTIDADE_PARCELA`, `RATEIO`, `RATEIO_LINEAR`, `STATUS`, `TAG_VENDA`, `TAXA_COMISSAO`, `TIPO_BAIXA`, `TIPO_LANCAMENTO`, `TIPO_OPERACAO`, `USUARIO`, `VALOR_COFINS`, `VALOR_COMISSAO`, `VALOR_DESCONTO_CONVENIO`, `VALOR_IPIS`, `VALOR_PAGAMENTO`, `VALOR_RESTANTE`, `VALOR_TOTAL`, `VALOR_BASE_CALCULO_ICM`, `VALOR_ICM_ISENTA`, `VALOR_ICM_VBC`, `VALOR_ICM_OUTRAS`, `VALOR_IPI`, `VALOR_IPI_ISENTA`, `VALOR_IPI_OUTRO`, `VALOR_PI_VBC`, `VALOR_ICM`, `VALOR_ICMS_ST`, `VALOR_OUTROS_CUSTOS`, `VALOR_SEGUROS`, `VALOR_ALIQUOTA`, `VALOR_DESCONTO`, `VALOR_DESPESAS_ACESSORIAS`, `VALOR_FRETE`, `VALORES_ICMS_ST`, `VALOR_NOTA`, `VALOR_PRODUTOS`, `VENCIMENTO2`, `ID_CLIENTE`, `ID_FIN_DOCUMENTO_ORIGEM`, `ID_VEICULO`, `ID_NATUREZA_FINANCEIRA`) SELECT `ID`, `COD_AGENCIA`, `CODIGO_MODULO_LCTO`, `DATA_LANCAMENTO`, `DATA_NOTA`, `FISCAL`, `FRETE`, `HASH_MODULO_LCTO`, `HISTORICO`, `ID_AGENCIA`, `ID_CARGA`, `ID_NFE`, `ID_VENDA`, `INTERVALO_ENTRE_PARCELAS`, `MESCLADO_PARA`, `NOME_AGENCIA`, `NUMERO_DOCUMENTO`, `PARCELAR`, `PLANO_CONTA`, `PRIMEIRO_VENCIMENTO`, `QUANTIDADE_PARCELA`, `RATEIO`, `RATEIO_LINEAR`, `STATUS`, `TAG_VENDA`, `TAXA_COMISSAO`, `TIPO_BAIXA`, `TIPO_LANCAMENTO`, `TIPO_OPERACAO`, `USUARIO`, `VALOR_COFINS`, `VALOR_COMISSAO`, `VALOR_DESCONTO_CONVENIO`, `VALOR_IPIS`, `VALOR_PAGAMENTO`, `VALOR_RESTANTE`, `VALOR_TOTAL`, `VALOR_BASE_CALCULO_ICM`, `VALOR_ICM_ISENTA`, `VALOR_ICM_VBC`, `VALOR_ICM_OUTRAS`, `VALOR_IPI`, `VALOR_IPI_ISENTA`, `VALOR_IPI_OUTRO`, `VALOR_PI_VBC`, `VALOR_ICM`, `VALOR_ICMS_ST`, `VALOR_OUTROS_CUSTOS`, `VALOR_SEGUROS`, `VALOR_ALIQUOTA`, `VALOR_DESCONTO`, `VALOR_DESPESAS_ACESSORIAS`, `VALOR_FRETE`, `VALORES_ICMS_ST`, `VALOR_NOTA`, `VALOR_PRODUTOS`, `VENCIMENTO2`, `ID_CLIENTE`, `ID_FIN_DOCUMENTO_ORIGEM`, `ID_VEICULO`, `ID_NATUREZA_FINANCEIRA` FROM `flow_crm`.`fin_lancamento_receber`;

-- fin_lcto_receber_nt_financeira
INSERT IGNORE INTO `synki_pulse05036308000100`.`fin_lcto_receber_nt_financeira` (`ID`, `DATA_INCLUSAO`, `PERCENTUAL`, `VALOR`, `ID_FIN_LANCAMENTO_RECEBER`, `ID_NATUREZA_FINANCEIRA`) SELECT `ID`, `DATA_INCLUSAO`, `PERCENTUAL`, `VALOR`, `ID_FIN_LANCAMENTO_RECEBER`, `ID_NATUREZA_FINANCEIRA` FROM `flow_crm`.`fin_lcto_receber_nt_financeira`;

-- fin_parcela_receber
INSERT IGNORE INTO `synki_pulse05036308000100`.`fin_parcela_receber` (`ID`, `ACERTO`, `ANO`, `BOLETO_NOSSO_NUMERO`, `CIDADE_DATA`, `COD_AGENCIA`, `CONCILIADO`, `DATA_EMISSAO`, `DATA_RECEBIMENTO`, `DATA_VENCIMENTO`, `DESCONTO_ATE`, `DIA`, `EMITIU_BOLETO`, `HISTORICO`, `ID_FIN_STATUS_PARCELA`, `ID_OPERACAO`, `MES`, `MES_ANO`, `MESCLADO_PARA`, `NOME_AGENCIA`, `NUMERO_PARCELA`, `OBS_CONCILIACAO`, `OPERACOES_REFERENCIAS`, `REFERENTE`, `STATUS_PARCELA`, `TAXA_DESCONTO`, `TAXA_JURO`, `TAXA_MULTA`, `TIPO_BAIXA`, `TIPO_PAGAMENTO`, `USUARIO`, `VALOR`, `VALOR_DESCONTO`, `VALOR_EXTENSO`, `VALOR_FINAL_JUROS`, `VALOR_JURO`, `VALOR_MULTA`, `VALOR_RECEBIDO`, `VALOR_RESTANTE`, `VENCIMENTO2`, `AGENCIA_ID`, `ID_FIN_LANCAMENTO_RECEBER`) SELECT `ID`, `ACERTO`, `ANO`, `BOLETO_NOSSO_NUMERO`, `CIDADE_DATA`, `COD_AGENCIA`, `CONCILIADO`, `DATA_EMISSAO`, `DATA_RECEBIMENTO`, `DATA_VENCIMENTO`, `DESCONTO_ATE`, `DIA`, `EMITIU_BOLETO`, `HISTORICO`, `ID_FIN_STATUS_PARCELA`, `ID_OPERACAO`, `MES`, `MES_ANO`, `MESCLADO_PARA`, `NOME_AGENCIA`, `NUMERO_PARCELA`, `OBS_CONCILIACAO`, `OPERACOES_REFERENCIAS`, `REFERENTE`, `STATUS_PARCELA`, `TAXA_DESCONTO`, `TAXA_JURO`, `TAXA_MULTA`, `TIPO_BAIXA`, `TIPO_PAGAMENTO`, `USUARIO`, `VALOR`, `VALOR_DESCONTO`, `VALOR_EXTENSO`, `VALOR_FINAL_JUROS`, `VALOR_JURO`, `VALOR_MULTA`, `VALOR_RECEBIDO`, `VALOR_RESTANTE`, `VENCIMENTO2`, `AGENCIA_ID`, `ID_FIN_LANCAMENTO_RECEBER` FROM `flow_crm`.`fin_parcela_receber`;

-- funil
INSERT IGNORE INTO `synki_pulse05036308000100`.`funil` (`ID`, `DATA_CRIACAO`, `DESCRICAO`, `NOME`) SELECT `ID`, `DATA_CRIACAO`, `DESCRICAO`, `NOME` FROM `flow_crm`.`funil`;

-- grupo
INSERT IGNORE INTO `synki_pulse05036308000100`.`grupo` (`id`, `descricao`, `nome`) SELECT `id`, `descricao`, `nome` FROM `flow_crm`.`grupo`;

-- grupo_permissao
INSERT IGNORE INTO `synki_pulse05036308000100`.`grupo_permissao` (`grupo_id`, `permissao_id`) SELECT `grupo_id`, `permissao_id` FROM `flow_crm`.`grupo_permissao`;

-- ies
INSERT IGNORE INTO `synki_pulse05036308000100`.`ies` (`ID`, `IE`, `DATA_ABERTURA`, `COD_ESTAVE`, `CNAE`, `TIPO`, `CPF_CNPJ`) SELECT `ID`, `IE`, `DATA_ABERTURA`, `COD_ESTAVE`, `CNAE`, `TIPO`, `CPF_CNPJ` FROM `flow_crm`.`ies`;

-- imovel_rural
INSERT IGNORE INTO `synki_pulse05036308000100`.`imovel_rural` (`id`, `area`, `cep`, `data_inscricao`, `data_referencia`, `distrito`, `endereco`, `id_imovel_incra`, `id_imovel_receita_federal`, `id_municipio`, `nome`, `sigla_uf`, `situacao_imovel`, `status_sncr`, `tipo_itr`) SELECT `id`, `area`, `cep`, `data_inscricao`, `data_referencia`, `distrito`, `endereco`, `id_imovel_incra`, `id_imovel_receita_federal`, `id_municipio`, `nome`, `sigla_uf`, `situacao_imovel`, `status_sncr`, `tipo_itr` FROM `flow_crm`.`imovel_rural`;

-- instance
INSERT IGNORE INTO `synki_pulse05036308000100`.`instance` (`id`, `businessId`, `clientName`, `connectionStatus`, `createdAt`, `disconnectionAt`, `disconnectionObject`, `disconnectionReasonCode`, `integration`, `name`, `number`, `ownerJid`, `profileName`, `profilePicUrl`, `token`, `updatedAt`) SELECT `id`, `businessId`, `clientName`, `connectionStatus`, `createdAt`, `disconnectionAt`, `disconnectionObject`, `disconnectionReasonCode`, `integration`, `name`, `number`, `ownerJid`, `profileName`, `profilePicUrl`, `token`, `updatedAt` FROM `flow_crm`.`instance`;

-- instancia
INSERT IGNORE INTO `synki_pulse05036308000100`.`instancia` (`ID`, `NOME`, `ID_EMPPRESA`) SELECT `ID`, `NOME`, `ID_EMPPRESA` FROM `flow_crm`.`instancia`;

-- integrationsession
INSERT IGNORE INTO `synki_pulse05036308000100`.`integrationsession` (`id`, `awaitUser`, `botId`, `context`, `createdAt`, `parameters`, `pushName`, `remoteJid`, `sessionId`, `status`, `type`, `updatedAt`, `instanceId`) SELECT `id`, `awaitUser`, `botId`, `context`, `createdAt`, `parameters`, `pushName`, `remoteJid`, `sessionId`, `status`, `type`, `updatedAt`, `instanceId` FROM `flow_crm`.`integrationsession`;

-- item_condicional_devolvido
INSERT IGNORE INTO `synki_pulse05036308000100`.`item_condicional_devolvido` (`id`, `descontoItem`, `quantidade`, `tipo_desconto`, `valor_unitario`, `pedido_id`, `produto_id`) SELECT `id`, `descontoItem`, `quantidade`, `tipo_desconto`, `valor_unitario`, `pedido_id`, `produto_id` FROM `flow_crm`.`item_condicional_devolvido`;

-- item_oportunidade
INSERT IGNORE INTO `synki_pulse05036308000100`.`item_oportunidade` (`ID`, `DATA_CRIACAO`, `DESCONTO_ITEM`, `OBSERVACAO`, `QUANTIDADE`, `TIPO_DESCONTO`, `VALOR_UNITARIO`, `ID_PRODUTO`, `ID_OPORTUNIDADE`, `CHASSI`, `ITEM_OPORTUNIDADE`, `VALOR_CUSTO`) SELECT `ID`, `DATA_CRIACAO`, `DESCONTO_ITEM`, `OBSERVACAO`, `QUANTIDADE`, `TIPO_DESCONTO`, `VALOR_UNITARIO`, `ID_PRODUTO`, `ID_OPORTUNIDADE`, `CHASSI`, `ITEM_OPORTUNIDADE`, `VALOR_CUSTO` FROM `flow_crm`.`item_oportunidade`;

-- item_pedido
INSERT IGNORE INTO `synki_pulse05036308000100`.`item_pedido` (`ID`, `DESCONTO_ITEM`, `QUANTIDADE`, `TIPO_DESCONTO`, `VALOR_UNITARIO`, `ID_PEDIDO`, `ID_PRODUTO`, `UNIDADE_COMERCIAL`, `SUB_TOTAL`, `VALOR_CUSTO`, `JUROS`, `VALOR_COMISSAO`, `COMISSAO`, `VALOR_FATURADO`, `REFERENCIA`, `CHASSI`, `DESCRICAO_ITEM`) SELECT `ID`, `DESCONTO_ITEM`, `QUANTIDADE`, `TIPO_DESCONTO`, `VALOR_UNITARIO`, `ID_PEDIDO`, `ID_PRODUTO`, `UNIDADE_COMERCIAL`, `SUB_TOTAL`, `VALOR_CUSTO`, `JUROS`, `VALOR_COMISSAO`, `COMISSAO`, `VALOR_FATURADO`, `REFERENCIA`, `CHASSI`, `DESCRICAO_ITEM` FROM `flow_crm`.`item_pedido`;

-- item_pedido_pagamentos
INSERT IGNORE INTO `synki_pulse05036308000100`.`item_pedido_pagamentos` (`ID`, `DESCRICAO`, `NOME`, `VALOR_TOTAL`, `VENCIMENTO`, `pedido_id`, `ID_TIPO_PAGAMENTO`, `STATUS`, `VALOR_CUSTO`) SELECT `ID`, `DESCRICAO`, `NOME`, `VALOR_TOTAL`, `VENCIMENTO`, `pedido_id`, `ID_TIPO_PAGAMENTO`, `STATUS`, `VALOR_CUSTO` FROM `flow_crm`.`item_pedido_pagamentos`;

-- item_pedido_usados
INSERT IGNORE INTO `synki_pulse05036308000100`.`item_pedido_usados` (`ID`, `DESCONTO_ITEM`, `QUANTIDADE`, `TIPO_DESCONTO`, `UNIDADE_COMERCIAL`, `SUB_TOTAL`, `VALOR_UNITARIO`, `ID_PEDIDO`, `ID_PRODUTO`, `CHASSI`) SELECT `ID`, `DESCONTO_ITEM`, `QUANTIDADE`, `TIPO_DESCONTO`, `UNIDADE_COMERCIAL`, `SUB_TOTAL`, `VALOR_UNITARIO`, `ID_PEDIDO`, `ID_PRODUTO`, `CHASSI` FROM `flow_crm`.`item_pedido_usados`;

-- local_atendimento
INSERT IGNORE INTO `synki_pulse05036308000100`.`local_atendimento` (`ID`, `DATA_CRIACAO`, `DESCRICAO`, `NOME`) SELECT `ID`, `DATA_CRIACAO`, `DESCRICAO`, `NOME` FROM `flow_crm`.`local_atendimento`;

-- mail_empresa
INSERT IGNORE INTO `synki_pulse05036308000100`.`mail_empresa` (`id`, `CORPO`, `NOME`, `DATA_RECEBIMENTO`, `ASSUNTO`, `ID_PESSOA`, `MESSAGE_ID`, `REMETENTE`) SELECT `id`, `CORPO`, `NOME`, `DATA_RECEBIMENTO`, `ASSUNTO`, `ID_PESSOA`, `MESSAGE_ID`, `REMETENTE` FROM `flow_crm`.`mail_empresa`;

-- menssagememail
INSERT IGNORE INTO `synki_pulse05036308000100`.`menssagememail` (`ID`, `CORPO_MENSSAGEM`, `DATA_MENSSAGEM`, `DESTINO`, `NOME`, `ORIGEM`, `ID_PESSOA`) SELECT `ID`, `CORPO_MENSSAGEM`, `DATA_MENSSAGEM`, `DESTINO`, `NOME`, `ORIGEM`, `ID_PESSOA` FROM `flow_crm`.`menssagememail`;

-- menu
INSERT IGNORE INTO `synki_pulse05036308000100`.`menu` (`id`, `icon`, `label`, `OPERADOR_TEM_ACESSO`, `outcome`) SELECT `id`, `icon`, `label`, `OPERADOR_TEM_ACESSO`, `outcome` FROM `flow_crm`.`menu`;

-- messagenswhats
INSERT IGNORE INTO `synki_pulse05036308000100`.`messagenswhats` (`ID`, `CORPO_MENSSAGEM`, `DATA_MENSSAGEM`, `DESTINO`, `NOME`, `ORIGEM`, `ID_PESSOA`, `ID_MESSAGE`) SELECT `ID`, `CORPO_MENSSAGEM`, `DATA_MENSSAGEM`, `DESTINO`, `NOME`, `ORIGEM`, `ID_PESSOA`, `ID_MESSAGE` FROM `flow_crm`.`messagenswhats`;

-- messageupdate
INSERT IGNORE INTO `synki_pulse05036308000100`.`messageupdate` (`id`, `fromMe`, `keyId`, `participant`, `pollUpdates`, `remoteJid`, `status`, `instanceId`, `messageId`) SELECT `id`, `fromMe`, `keyId`, `participant`, `pollUpdates`, `remoteJid`, `status`, `instanceId`, `messageId` FROM `flow_crm`.`messageupdate`;

-- motivo_perda
INSERT IGNORE INTO `synki_pulse05036308000100`.`motivo_perda` (`ID`, `DATA_CRIACAO`, `DESCRICAO`, `OBSERVACAO`) SELECT `ID`, `DATA_CRIACAO`, `DESCRICAO`, `OBSERVACAO` FROM `flow_crm`.`motivo_perda`;

-- municipio
INSERT IGNORE INTO `synki_pulse05036308000100`.`municipio` (`ID`, `CODIGO_ESTADUAL`, `CODIGO_IBGE`, `CODIGO_RECEITA_FEDERAL`, `NOME`, `ID_UF`, `ID_LOCALIZACAO`, `INCIO_IE`) SELECT `ID`, `CODIGO_ESTADUAL`, `CODIGO_IBGE`, `CODIGO_RECEITA_FEDERAL`, `NOME`, `ID_UF`, `ID_LOCALIZACAO`, `INCIO_IE` FROM `flow_crm`.`municipio`;

-- natureza_financeira
INSERT IGNORE INTO `synki_pulse05036308000100`.`natureza_financeira` (`ID`, `APARECE_A_PAGAR`, `APARECE_A_RECEBER`, `APLICACAO`, `CLASSIFICACAO`, `DESCRICAO`, `TIPO`, `ID_PLANO_NATUREZA_FINANCEIRA`) SELECT `ID`, `APARECE_A_PAGAR`, `APARECE_A_RECEBER`, `APLICACAO`, `CLASSIFICACAO`, `DESCRICAO`, `TIPO`, `ID_PLANO_NATUREZA_FINANCEIRA` FROM `flow_crm`.`natureza_financeira`;

-- ncm
INSERT IGNORE INTO `synki_pulse05036308000100`.`ncm` (`ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO`) SELECT `ID`, `CODIGO`, `DESCRICAO`, `OBSERVACAO` FROM `flow_crm`.`ncm`;

-- nota_entrada_dfe
INSERT IGNORE INTO `synki_pulse05036308000100`.`nota_entrada_dfe` (`id`, `caminho_schema`, `cfop`, `chave`, `cnpj_emitente`, `cod_uf_emitente`, `data_nota`, `DATA_NOTA2`, `ie_emitente`, `importada`, `natureza`, `nome_emitente`, `numero_nota`, `serie_emitente`, `valor`, `xml`, `empresa_id`) SELECT `id`, `caminho_schema`, `cfop`, `chave`, `cnpj_emitente`, `cod_uf_emitente`, `data_nota`, `DATA_NOTA2`, `ie_emitente`, `importada`, `natureza`, `nome_emitente`, `numero_nota`, `serie_emitente`, `valor`, `xml`, `empresa_id` FROM `flow_crm`.`nota_entrada_dfe`;

-- oportunidade
INSERT IGNORE INTO `synki_pulse05036308000100`.`oportunidade` (`ID`, `DATA_CRIACAO`, `NOME`, `OBSERVACAO`, `CONTATO`, `DATA_FECHAMENTO_ESPERADA`, `DESCRICAO`, `PROBABILIDADE`, `STATUS`, `TIPO_MAQUINA`, `VALOR`, `ID_PESSOA`, `ID_FUNIL`, `ID_ORIGEM`, `ID_VENDEDOR`, `LOCAL`, `POSSIBILIDADE`, `LEADBOOL`, `PROSPECT`, `NEGOTIATION`, `PEDIDO`, `VALOR_ATUALIZADO`, `ID_MOTIVO_PERDA`, `ID_MARCA`, `OBSERVACAO_PERDA`, `VALOR_CONCORRENCIA`, `POSSUI_PARTICIPACAO`, `ENVIADO_PARA_AGENDA`, `ID_ATENDIMENTO`, `VALOR_TOTAL_CUSTO`) SELECT `ID`, `DATA_CRIACAO`, `NOME`, `OBSERVACAO`, `CONTATO`, `DATA_FECHAMENTO_ESPERADA`, `DESCRICAO`, `PROBABILIDADE`, `STATUS`, `TIPO_MAQUINA`, `VALOR`, `ID_PESSOA`, `ID_FUNIL`, `ID_ORIGEM`, `ID_VENDEDOR`, `LOCAL`, `POSSIBILIDADE`, `LEADBOOL`, `PROSPECT`, `NEGOTIATION`, `PEDIDO`, `VALOR_ATUALIZADO`, `ID_MOTIVO_PERDA`, `ID_MARCA`, `OBSERVACAO_PERDA`, `VALOR_CONCORRENCIA`, `POSSUI_PARTICIPACAO`, `ENVIADO_PARA_AGENDA`, `ID_ATENDIMENTO`, `VALOR_TOTAL_CUSTO` FROM `flow_crm`.`oportunidade`;

-- oportunidade_evolucao
INSERT IGNORE INTO `synki_pulse05036308000100`.`oportunidade_evolucao` (`ID`, `DATA_ALTERACAO`, `DATA_CRIACAO`, `STATUS`, `ID_OPORTUNIDADE`, `ID_VENDEDOR_ALTEROU`, `ID_VENDEDOR`, `OBS`, `ID_ATENDIMENTO`) SELECT `ID`, `DATA_ALTERACAO`, `DATA_CRIACAO`, `STATUS`, `ID_OPORTUNIDADE`, `ID_VENDEDOR_ALTEROU`, `ID_VENDEDOR`, `OBS`, `ID_ATENDIMENTO` FROM `flow_crm`.`oportunidade_evolucao`;

-- orcamento_detalhe
INSERT IGNORE INTO `synki_pulse05036308000100`.`orcamento_detalhe` (`ID`, `PERIODO`, `TAXA_VARIACAO`, `VALOR_ORCADO`, `VALOR_REALIZADO`, `VALOR_VARIACAO`, `ID_NATUREZA_FINANCEIRA`, `ID_ORCAMENTO_EMPRESARIAL`) SELECT `ID`, `PERIODO`, `TAXA_VARIACAO`, `VALOR_ORCADO`, `VALOR_REALIZADO`, `VALOR_VARIACAO`, `ID_NATUREZA_FINANCEIRA`, `ID_ORCAMENTO_EMPRESARIAL` FROM `flow_crm`.`orcamento_detalhe`;

-- orcamento_empresarial
INSERT IGNORE INTO `synki_pulse05036308000100`.`orcamento_empresarial` (`ID`, `DATA_BASE`, `DATA_INICIAL`, `DESCRICAO`, `NOME`, `NUMERO_PERIODOS`, `ID_ORCAMENTO_PERIODO`) SELECT `ID`, `DATA_BASE`, `DATA_INICIAL`, `DESCRICAO`, `NOME`, `NUMERO_PERIODOS`, `ID_ORCAMENTO_PERIODO` FROM `flow_crm`.`orcamento_empresarial`;

-- orcamento_fluxo_caixa
INSERT IGNORE INTO `synki_pulse05036308000100`.`orcamento_fluxo_caixa` (`ID`, `DATA_BASE`, `DATA_INICIAL`, `DESCRICAO`, `NOME`, `NUMERO_PERIODOS`, `ID_ORC_FLUXO_CAIXA_PERIODO`) SELECT `ID`, `DATA_BASE`, `DATA_INICIAL`, `DESCRICAO`, `NOME`, `NUMERO_PERIODOS`, `ID_ORC_FLUXO_CAIXA_PERIODO` FROM `flow_crm`.`orcamento_fluxo_caixa`;

-- orcamento_fluxo_caixa_detalhe
INSERT IGNORE INTO `synki_pulse05036308000100`.`orcamento_fluxo_caixa_detalhe` (`ID`, `PERIODO`, `TAXA_VARIACAO`, `VALOR_ORCADO`, `VALOR_REALIZADO`, `VALOR_VARIACAO`, `ID_NATUREZA_FINANCEIRA`, `ID_ORCAMENTO_FLUXO_CAIXA`) SELECT `ID`, `PERIODO`, `TAXA_VARIACAO`, `VALOR_ORCADO`, `VALOR_REALIZADO`, `VALOR_VARIACAO`, `ID_NATUREZA_FINANCEIRA`, `ID_ORCAMENTO_FLUXO_CAIXA` FROM `flow_crm`.`orcamento_fluxo_caixa_detalhe`;

-- orcamento_fluxo_caixa_periodo
INSERT IGNORE INTO `synki_pulse05036308000100`.`orcamento_fluxo_caixa_periodo` (`ID`, `NOME`, `PERIODO`, `ID_CONTA_CAIXA`) SELECT `ID`, `NOME`, `PERIODO`, `ID_CONTA_CAIXA` FROM `flow_crm`.`orcamento_fluxo_caixa_periodo`;

-- orcamento_periodo
INSERT IGNORE INTO `synki_pulse05036308000100`.`orcamento_periodo` (`ID`, `NOME`, `PERIODO`, `ID_EMPRESA`) SELECT `ID`, `NOME`, `PERIODO`, `ID_EMPRESA` FROM `flow_crm`.`orcamento_periodo`;

-- origem
INSERT IGNORE INTO `synki_pulse05036308000100`.`origem` (`ID`, `DATA_CRIACAO`, `NOME`, `OBSERVACAO`) SELECT `ID`, `DATA_CRIACAO`, `NOME`, `OBSERVACAO` FROM `flow_crm`.`origem`;

-- os_abertura
INSERT IGNORE INTO `synki_pulse05036308000100`.`os_abertura` (`ID`, `DATA_FIM`, `DATA_INICIO`, `DATA_PREVISAO`, `FONE_CONTATO`, `HORA_FIM`, `HORA_INICIO`, `HORA_PREVISAO`, `NOME_CONTATO`, `NUMERO`, `OBSERVACAO_ABERTURA`, `OBSERVACAO_CLIENTE`, `ID_CLIENTE`, `ID_COLABORADOR`, `ID_OS_STATUS`) SELECT `ID`, `DATA_FIM`, `DATA_INICIO`, `DATA_PREVISAO`, `FONE_CONTATO`, `HORA_FIM`, `HORA_INICIO`, `HORA_PREVISAO`, `NOME_CONTATO`, `NUMERO`, `OBSERVACAO_ABERTURA`, `OBSERVACAO_CLIENTE`, `ID_CLIENTE`, `ID_COLABORADOR`, `ID_OS_STATUS` FROM `flow_crm`.`os_abertura`;

-- os_abertura_equipamento
INSERT IGNORE INTO `synki_pulse05036308000100`.`os_abertura_equipamento` (`ID`, `NUMERO_SERIE`, `TIPO_COBERTURA`, `ID_OS_ABERTURA`, `ID_OS_EQUIPAMENTO`) SELECT `ID`, `NUMERO_SERIE`, `TIPO_COBERTURA`, `ID_OS_ABERTURA`, `ID_OS_EQUIPAMENTO` FROM `flow_crm`.`os_abertura_equipamento`;

-- os_equipamento
INSERT IGNORE INTO `synki_pulse05036308000100`.`os_equipamento` (`ID`, `DESCRICAO`, `NOME`) SELECT `ID`, `DESCRICAO`, `NOME` FROM `flow_crm`.`os_equipamento`;

-- os_evolucao
INSERT IGNORE INTO `synki_pulse05036308000100`.`os_evolucao` (`ID`, `DATA_REGISTRO`, `ENVIAR_EMAIL`, `HORA_REGISTRO`, `OBSERVACAO`, `OS_ABERTURA_ID`) SELECT `ID`, `DATA_REGISTRO`, `ENVIAR_EMAIL`, `HORA_REGISTRO`, `OBSERVACAO`, `OS_ABERTURA_ID` FROM `flow_crm`.`os_evolucao`;

-- os_produto_servico
INSERT IGNORE INTO `synki_pulse05036308000100`.`os_produto_servico` (`ID`, `COMPLEMENTO`, `QUANTIDADE`, `TAXA_DESCONTO`, `TIPO`, `VALOR_DESCONTO`, `VALOR_SUBTOTAL`, `VALOR_TOTAL`, `VALOR_UNITARIO`, `ID_OS_ABERTURA`, `ID_PRODUTO`) SELECT `ID`, `COMPLEMENTO`, `QUANTIDADE`, `TAXA_DESCONTO`, `TIPO`, `VALOR_DESCONTO`, `VALOR_SUBTOTAL`, `VALOR_TOTAL`, `VALOR_UNITARIO`, `ID_OS_ABERTURA`, `ID_PRODUTO` FROM `flow_crm`.`os_produto_servico`;

-- os_status
INSERT IGNORE INTO `synki_pulse05036308000100`.`os_status` (`ID`, `CODIGO`, `NOME`) SELECT `ID`, `CODIGO`, `NOME` FROM `flow_crm`.`os_status`;

-- parametros
INSERT IGNORE INTO `synki_pulse05036308000100`.`parametros` (`ID`, `NOME`, `VALOR`) SELECT `ID`, `NOME`, `VALOR` FROM `flow_crm`.`parametros`;

-- pedido
INSERT IGNORE INTO `synki_pulse05036308000100`.`pedido` (`id`, `data_criacao`, `data_entrega`, `entrega_cep`, `entrega_cidade`, `entrega_complemento`, `entrega_logradouro`, `entrega_numero`, `entrega_uf`, `forma_pagamento`, `observacao`, `quantidadeItens`, `status`, `valor_desconto`, `valor_frete`, `valor_total`, `cliente_id`, `vendedor_id`, `cliente2_id`, `OPORTUNIDADE_ID`, `QUANTIDADE_ITENS`, `VALOR_TOTAL_PAGAMENTOS`, `TOTAL_USADO`, `SALDO`, `SUB_TOTAL_PAGAR`, `NOME_CLIENTE2`, `IE_CLIENTE2`, `CPF_CNPJ_CLIENTE2`, `ENDERECO_CLIENTE2`, `VALOR_PAGAMENTOS`, `valorTotalPagamentosUsados`, `COM_USADO`, `VALOR_PAGO`, `VALOR_RESTANTE`, `SALDO_COM_USADOS`, `ENDERECO_CLIENTE1`, `NCM`, `VALOR_CUSTO`, `VALOR_TOTAL_ARMAZENADO`, `VALOR_JUROS`, `VALOR_FATURADO`, `CFOP`, `DATA_PRIMEIRO_VENCIMENTO`, `INTEVALO_PARCELAS`, `QUANTIDADE_PARCELA`, `ID_EMPRESA`, `ENDERECO_ENTREGA`, `CONTATO`, `PREVISAO_ENTREGA`, `VALIDADE`, `LP`, `COLHEITA`, `MONTAGEM`, `EIXOS`, `ASSINATURA2`, `TEXTO2`, `BASE64_2`, `ASSINATURA1`, `TEXTO1`, `BASE64_1`, `ASSINATURA3`, `TEXTO3`, `BASE64_3`, `ASSINATURA_CLIENTE`, `ASSINATURA_REVENDA`, `ASSINATURA_VENDEDOR`, `LOGRADOURO_ENTREGA`, `BAIRRO_ENTREGA`, `CIDADE_ENTREGA`, `CEP_ENTREGA`, `UF_ENTREGA`, `NUMERO_ENTREGA`, `TIPO_PEDIDO`) SELECT `id`, `data_criacao`, `data_entrega`, `entrega_cep`, `entrega_cidade`, `entrega_complemento`, `entrega_logradouro`, `entrega_numero`, `entrega_uf`, `forma_pagamento`, `observacao`, `quantidadeItens`, `status`, `valor_desconto`, `valor_frete`, `valor_total`, `cliente_id`, `vendedor_id`, `cliente2_id`, `OPORTUNIDADE_ID`, `QUANTIDADE_ITENS`, `VALOR_TOTAL_PAGAMENTOS`, `TOTAL_USADO`, `SALDO`, `SUB_TOTAL_PAGAR`, `NOME_CLIENTE2`, `IE_CLIENTE2`, `CPF_CNPJ_CLIENTE2`, `ENDERECO_CLIENTE2`, `VALOR_PAGAMENTOS`, `valorTotalPagamentosUsados`, `COM_USADO`, `VALOR_PAGO`, `VALOR_RESTANTE`, `SALDO_COM_USADOS`, `ENDERECO_CLIENTE1`, `NCM`, `VALOR_CUSTO`, `VALOR_TOTAL_ARMAZENADO`, `VALOR_JUROS`, `VALOR_FATURADO`, `CFOP`, `DATA_PRIMEIRO_VENCIMENTO`, `INTEVALO_PARCELAS`, `QUANTIDADE_PARCELA`, `ID_EMPRESA`, `ENDERECO_ENTREGA`, `CONTATO`, `PREVISAO_ENTREGA`, `VALIDADE`, `LP`, `COLHEITA`, `MONTAGEM`, `EIXOS`, `ASSINATURA2`, `TEXTO2`, `BASE64_2`, `ASSINATURA1`, `TEXTO1`, `BASE64_1`, `ASSINATURA3`, `TEXTO3`, `BASE64_3`, `ASSINATURA_CLIENTE`, `ASSINATURA_REVENDA`, `ASSINATURA_VENDEDOR`, `LOGRADOURO_ENTREGA`, `BAIRRO_ENTREGA`, `CIDADE_ENTREGA`, `CEP_ENTREGA`, `UF_ENTREGA`, `NUMERO_ENTREGA`, `TIPO_PEDIDO` FROM `flow_crm`.`pedido`;

-- pedido_etapas
INSERT IGNORE INTO `synki_pulse05036308000100`.`pedido_etapas` (`id`, `DESCRICAO`, `NOME`, `ID_OPORTUNIDADE`, `ID_ETAPA`, `DATA_ALTERACAO`) SELECT `id`, `DESCRICAO`, `NOME`, `ID_OPORTUNIDADE`, `ID_ETAPA`, `DATA_ALTERACAO` FROM `flow_crm`.`pedido_etapas`;

-- permissao
INSERT IGNORE INTO `synki_pulse05036308000100`.`permissao` (`id`, `descricao`, `nome`) SELECT `id`, `descricao`, `nome` FROM `flow_crm`.`permissao`;

-- pessoa_contato
INSERT IGNORE INTO `synki_pulse05036308000100`.`pessoa_contato` (`id`, `EMAIL`, `NOME`, `OBSERVACAO`, `ID_PESSOA`) SELECT `id`, `EMAIL`, `NOME`, `OBSERVACAO`, `ID_PESSOA` FROM `flow_crm`.`pessoa_contato`;

-- pessoa_cultura
INSERT IGNORE INTO `synki_pulse05036308000100`.`pessoa_cultura` (`ID`, `AREA_CULTIVADA`, `DESCRICAO`, `NOME`, `PERCENTUAL_PARTICIPACAO`, `ID_CULTURA`, `ID_PESSOA`) SELECT `ID`, `AREA_CULTIVADA`, `DESCRICAO`, `NOME`, `PERCENTUAL_PARTICIPACAO`, `ID_CULTURA`, `ID_PESSOA` FROM `flow_crm`.`pessoa_cultura`;

-- pessoa_endereco
INSERT IGNORE INTO `synki_pulse05036308000100`.`pessoa_endereco` (`id`, `BAIRRO`, `CEP`, `CIDADE`, `COBRANCA`, `CODIGO_UF`, `COMPLEMENTO`, `CORRESPONDENCIA`, `TIPO_ENDERECO`, `ENTREGA`, `INSCRICAO_ESTADUAL`, `LATITUDE`, `LONGITUDE`, `LOGRADOURO`, `MUNICIPIO_IBGE`, `NUMERO`, `PRINCIPAL`, `SERIE`, `UF`, `ID_PESSOA`, `COORDS`) SELECT `id`, `BAIRRO`, `CEP`, `CIDADE`, `COBRANCA`, `CODIGO_UF`, `COMPLEMENTO`, `CORRESPONDENCIA`, `TIPO_ENDERECO`, `ENTREGA`, `INSCRICAO_ESTADUAL`, `LATITUDE`, `LONGITUDE`, `LOGRADOURO`, `MUNICIPIO_IBGE`, `NUMERO`, `PRINCIPAL`, `SERIE`, `UF`, `ID_PESSOA`, `COORDS` FROM `flow_crm`.`pessoa_endereco`;

-- pessoa_fisica
INSERT IGNORE INTO `synki_pulse05036308000100`.`pessoa_fisica` (`id`, `CPF`, `DATA_EMISSAO_RG`, `DATA_NASCIMENTO`, `NACIONALIDADE`, `NATURALIDADE`, `NOME_MAE`, `NOME_PAI`, `ORGAO_RG`, `RACA`, `RG`, `SEXO`, `ID_PESSOA`) SELECT `id`, `CPF`, `DATA_EMISSAO_RG`, `DATA_NASCIMENTO`, `NACIONALIDADE`, `NATURALIDADE`, `NOME_MAE`, `NOME_PAI`, `ORGAO_RG`, `RACA`, `RG`, `SEXO`, `ID_PESSOA` FROM `flow_crm`.`pessoa_fisica`;

-- pessoa_juridica
INSERT IGNORE INTO `synki_pulse05036308000100`.`pessoa_juridica` (`id`, `CNPJ`, `CRT`, `DATA_CONSTITUICAO`, `INSCRICAO_ESTADUAL`, `INSCRICAO_MUNICIPAL`, `NOME_FANTASIA`, `TIPO_REGIME`, `ID_PESSOA`) SELECT `id`, `CNPJ`, `CRT`, `DATA_CONSTITUICAO`, `INSCRICAO_ESTADUAL`, `INSCRICAO_MUNICIPAL`, `NOME_FANTASIA`, `TIPO_REGIME`, `ID_PESSOA` FROM `flow_crm`.`pessoa_juridica`;

-- pessoa_maquinario
INSERT IGNORE INTO `synki_pulse05036308000100`.`pessoa_maquinario` (`id`, `ANO`, `DESCRICAO`, `DISPONIVEL_VENDA`, `HORIMETRO`, `NOME`, `VALOR`, `ID_PESSOA`, `ID_PRODUTO`, `LOCAL`, `CHASSI`) SELECT `id`, `ANO`, `DESCRICAO`, `DISPONIVEL_VENDA`, `HORIMETRO`, `NOME`, `VALOR`, `ID_PESSOA`, `ID_PRODUTO`, `LOCAL`, `CHASSI` FROM `flow_crm`.`pessoa_maquinario`;

-- pessoa_telefone
INSERT IGNORE INTO `synki_pulse05036308000100`.`pessoa_telefone` (`id`, `NUMERO`, `TIPO`, `ID_PESSOA`) SELECT `id`, `NUMERO`, `TIPO`, `ID_PESSOA` FROM `flow_crm`.`pessoa_telefone`;

-- pessoas
INSERT IGNORE INTO `synki_pulse05036308000100`.`pessoas` (`ID`, `BAIRRO`, `CELULAR`, `CEP`, `cidade`, `CLIENTE`, `COD_CIDADE`, `COD_ESTADO`, `COD_MUNICIPIO`, `COD_PAIS`, `COD_UF`, `COMPLEMENTO`, `comprador`, `CONJUGE`, `contato`, `CPF_CNPJ`, `DATA_CADASTRO`, `DATA_EMISSAO_RG`, `DATA_NASCIMENTO`, `EMAIL`, `EMPRESA_ID`, `END_TRABALHO`, `FABRICANTE`, `FILHOS1`, `FILHOS2`, `FONE1`, `FONE2`, `FORNECEDOR`, `GENERO`, `ID_CIDADE`, `idade`, `IDESTRANGEIRO`, `INSCRICAO_ESTADUAL`, `INSCRICAO_MUNICIPAL`, `LATITUDE`, `LOCAL_TRABALHO`, `LOGRADOURO`, `LONGITUDE`, `MODIFICACAO`, `NOME`, `NOME_FANTASIA`, `NUMERO`, `obs`, `ORGAO_RG`, `PORTADOR`, `POTENCIAL`, `REF_BANCARIA`, `rendimento`, `rendimento_conjugue`, `RESIDENCIA`, `RG`, `SEXO`, `SITE`, `SUFRAMA`, `tecnico`, `TEMPO_SERVICO`, `TEMPO_SERVICO_CONJUGUE`, `TIPO`, `TIPO_PESSOA`, `TRANSPORTADORA`, `UF`, `VENDEDOR`, `ID_EMPRESA`, `CRT`, `COD`, `coords`, `tipo_cliente`, `dados_cafir`, `ID_CATEGORIA`, `uiid_pessoa`, `salvar_whats`, `salvar_email`, `celular_api`, `STATUS_DO_LEAD`, `ORIGEM`, `ULTIMO_CONTATO`) SELECT `ID`, `BAIRRO`, `CELULAR`, `CEP`, `cidade`, `CLIENTE`, `COD_CIDADE`, `COD_ESTADO`, `COD_MUNICIPIO`, `COD_PAIS`, `COD_UF`, `COMPLEMENTO`, `comprador`, `CONJUGE`, `contato`, `CPF_CNPJ`, `DATA_CADASTRO`, `DATA_EMISSAO_RG`, `DATA_NASCIMENTO`, `EMAIL`, `EMPRESA_ID`, `END_TRABALHO`, `FABRICANTE`, `FILHOS1`, `FILHOS2`, `FONE1`, `FONE2`, `FORNECEDOR`, `GENERO`, `ID_CIDADE`, `idade`, `IDESTRANGEIRO`, `INSCRICAO_ESTADUAL`, `INSCRICAO_MUNICIPAL`, `LATITUDE`, `LOCAL_TRABALHO`, `LOGRADOURO`, `LONGITUDE`, `MODIFICACAO`, `NOME`, `NOME_FANTASIA`, `NUMERO`, `obs`, `ORGAO_RG`, `PORTADOR`, `POTENCIAL`, `REF_BANCARIA`, `rendimento`, `rendimento_conjugue`, `RESIDENCIA`, `RG`, `SEXO`, `SITE`, `SUFRAMA`, `tecnico`, `TEMPO_SERVICO`, `TEMPO_SERVICO_CONJUGUE`, `TIPO`, `TIPO_PESSOA`, `TRANSPORTADORA`, `UF`, `VENDEDOR`, `ID_EMPRESA`, `CRT`, `COD`, `coords`, `tipo_cliente`, `dados_cafir`, `ID_CATEGORIA`, `uiid_pessoa`, `salvar_whats`, `salvar_email`, `celular_api`, `STATUS_DO_LEAD`, `ORIGEM`, `ULTIMO_CONTATO` FROM `flow_crm`.`pessoas`;

-- plano_centro_resultado
INSERT IGNORE INTO `synki_pulse05036308000100`.`plano_centro_resultado` (`ID`, `DATA_INCLUSAO`, `MASCARA`, `NIVEIS`, `NOME`) SELECT `ID`, `DATA_INCLUSAO`, `MASCARA`, `NIVEIS`, `NOME` FROM `flow_crm`.`plano_centro_resultado`;

-- plano_natureza_financeira
INSERT IGNORE INTO `synki_pulse05036308000100`.`plano_natureza_financeira` (`ID`, `DATA_INCLUSAO`, `MASCARA`, `NIVEIS`, `NOME`) SELECT `ID`, `DATA_INCLUSAO`, `MASCARA`, `NIVEIS`, `NOME` FROM `flow_crm`.`plano_natureza_financeira`;

-- produto
INSERT IGNORE INTO `synki_pulse05036308000100`.`produto` (`ID`, `ALIQUOTA_ICMS_PAF`, `ALIQUOTA_ISSQN_PAF`, `CAMINHO_FOTO`, `CEST`, `CLASSE_ABC`, `COD_INTERNO`, `CODIGO_BALANCA`, `CODIGO_INTERNO`, `CODIGO_LST`, `NCM`, `CST_A`, `CUSTO_MEDIO`, `DATA_ALTERACAO`, `DATA_CADASTRO`, `DESCRICAO`, `ESTOQUE_IDEAL`, `ESTOQUE_MAXIMO`, `ESTOQUE_MINIMO`, `EX_TIPI`, `EXCLUIDO`, `FOTO`, `FUNDO_POBREZA`, `GRUPO`, `GTIN`, `IAT`, `IMAGEM`, `INATIVO`, `IPPT`, `LOTE_ECONOMICO_COMPRA`, `MARGEM_LUCRO`, `LUCRO_MARKUP`, `LUCRO_ZERO`, `MOVIMENTA_ESTOQUE`, `NOME`, `NOME_PDV`, `NVE`, `OBS`, `PESO`, `PONTO_PEDIDO`, `PORCENTO_COMISSAO`, `PRECO_SUGERIDO`, `QUANTIDADE_ESTOQUE`, `QUANTIDADE_ESTOQUE_ANTERIOR`, `REDUCAO_ICMS`, `SERVICO`, `STE`, `STS`, `TAMANHO`, `TIPO`, `TIPO_ITEM_SPED`, `TOTALIZADOR_PARCIAL`, `ULTIMO_VALOR_COMPRA`, `ULTIMO_VALOR_VENDA`, `VALOR`, `VALOR_COMPRA`, `VALOR_VENDA`, `ID_ALMOXARIFADO`, `ID_EMPRESA`, `IMPOSTO_ICMS_ID`, `NCM_ID`, `ID_PRODUTO_MARCA`, `ID_PRODUTO_SUBGRUPO`, `ID_PRODUTO_UNIDADE`, `SUBGRUPO_ID`, `ID_TRIBUT_GRUPO_TRIBUTARIO`, `ID_TRIBUT_ICMS_CUSTOM_CAB`, `UNIDADE_PRODUTO_ID`, `TIPO_MAQUINA`, `ANO`, `CHASSI`, `CODIGO_FINAME`, `UUID_PRODUTO`, `ITEM`) SELECT `ID`, `ALIQUOTA_ICMS_PAF`, `ALIQUOTA_ISSQN_PAF`, `CAMINHO_FOTO`, `CEST`, `CLASSE_ABC`, `COD_INTERNO`, `CODIGO_BALANCA`, `CODIGO_INTERNO`, `CODIGO_LST`, `NCM`, `CST_A`, `CUSTO_MEDIO`, `DATA_ALTERACAO`, `DATA_CADASTRO`, `DESCRICAO`, `ESTOQUE_IDEAL`, `ESTOQUE_MAXIMO`, `ESTOQUE_MINIMO`, `EX_TIPI`, `EXCLUIDO`, `FOTO`, `FUNDO_POBREZA`, `GRUPO`, `GTIN`, `IAT`, `IMAGEM`, `INATIVO`, `IPPT`, `LOTE_ECONOMICO_COMPRA`, `MARGEM_LUCRO`, `LUCRO_MARKUP`, `LUCRO_ZERO`, `MOVIMENTA_ESTOQUE`, `NOME`, `NOME_PDV`, `NVE`, `OBS`, `PESO`, `PONTO_PEDIDO`, `PORCENTO_COMISSAO`, `PRECO_SUGERIDO`, `QUANTIDADE_ESTOQUE`, `QUANTIDADE_ESTOQUE_ANTERIOR`, `REDUCAO_ICMS`, `SERVICO`, `STE`, `STS`, `TAMANHO`, `TIPO`, `TIPO_ITEM_SPED`, `TOTALIZADOR_PARCIAL`, `ULTIMO_VALOR_COMPRA`, `ULTIMO_VALOR_VENDA`, `VALOR`, `VALOR_COMPRA`, `VALOR_VENDA`, `ID_ALMOXARIFADO`, `ID_EMPRESA`, `IMPOSTO_ICMS_ID`, `NCM_ID`, `ID_PRODUTO_MARCA`, `ID_PRODUTO_SUBGRUPO`, `ID_PRODUTO_UNIDADE`, `SUBGRUPO_ID`, `ID_TRIBUT_GRUPO_TRIBUTARIO`, `ID_TRIBUT_ICMS_CUSTOM_CAB`, `UNIDADE_PRODUTO_ID`, `TIPO_MAQUINA`, `ANO`, `CHASSI`, `CODIGO_FINAME`, `UUID_PRODUTO`, `ITEM` FROM `flow_crm`.`produto`;

-- produto_grupo
INSERT IGNORE INTO `synki_pulse05036308000100`.`produto_grupo` (`id`, `DESCRICAO`, `NOME`) SELECT `id`, `DESCRICAO`, `NOME` FROM `flow_crm`.`produto_grupo`;

-- produto_marca
INSERT IGNORE INTO `synki_pulse05036308000100`.`produto_marca` (`id`, `DESCRICAO`, `NOME`) SELECT `id`, `DESCRICAO`, `NOME` FROM `flow_crm`.`produto_marca`;

-- produto_subgrupo
INSERT IGNORE INTO `synki_pulse05036308000100`.`produto_subgrupo` (`id`, `DESCRICAO`, `NOME`, `ID_PRODUTO_GRUPO`) SELECT `id`, `DESCRICAO`, `NOME`, `ID_PRODUTO_GRUPO` FROM `flow_crm`.`produto_subgrupo`;

-- produto_unidade
INSERT IGNORE INTO `synki_pulse05036308000100`.`produto_unidade` (`id`, `DESCRICAO`, `PODE_FRACIONAR`, `SIGLA`) SELECT `id`, `DESCRICAO`, `PODE_FRACIONAR`, `SIGLA` FROM `flow_crm`.`produto_unidade`;

-- recado_destinatario
INSERT IGNORE INTO `synki_pulse05036308000100`.`recado_destinatario` (`ID`, `ID_USUARIO`, `ID_RECADO_REMETENTE`) SELECT `ID`, `ID_USUARIO`, `ID_RECADO_REMETENTE` FROM `flow_crm`.`recado_destinatario`;

-- recado_remetente
INSERT IGNORE INTO `synki_pulse05036308000100`.`recado_remetente` (`ID`, `ASSUNTO`, `DATA_ENVIO`, `HORA_ENVIO`, `TEXTO`, `ID_USUARIO`) SELECT `ID`, `ASSUNTO`, `DATA_ENVIO`, `HORA_ENVIO`, `TEXTO`, `ID_USUARIO` FROM `flow_crm`.`recado_remetente`;

-- reuniao_sala
INSERT IGNORE INTO `synki_pulse05036308000100`.`reuniao_sala` (`ID`, `ANDAR`, `NUMERO`, `PREDIO`) SELECT `ID`, `ANDAR`, `NUMERO`, `PREDIO` FROM `flow_crm`.`reuniao_sala`;

-- reuniao_sala_evento
INSERT IGNORE INTO `synki_pulse05036308000100`.`reuniao_sala_evento` (`ID`, `DATA_RESERVA`, `ID_AGENDA_COMPROMISSO`, `ID_REUNIAO_SALA`) SELECT `ID`, `DATA_RESERVA`, `ID_AGENDA_COMPROMISSO`, `ID_REUNIAO_SALA` FROM `flow_crm`.`reuniao_sala_evento`;

-- servicos_atendimento
INSERT IGNORE INTO `synki_pulse05036308000100`.`servicos_atendimento` (`ID`, `DATA_CRIACAO`, `DESCRICAO`, `IMAGEM`, `LEI_BEM`, `NOME`, `OPORTUNIDADE`, `REQUER_TEMPO`, `TEMPO`, `TEMPO_DECORRIDO`, `ID_ATENDIMENTO`, `ID_TIPO_ATENDIMENTO`) SELECT `ID`, `DATA_CRIACAO`, `DESCRICAO`, `IMAGEM`, `LEI_BEM`, `NOME`, `OPORTUNIDADE`, `REQUER_TEMPO`, `TEMPO`, `TEMPO_DECORRIDO`, `ID_ATENDIMENTO`, `ID_TIPO_ATENDIMENTO` FROM `flow_crm`.`servicos_atendimento`;

-- smtp_config
INSERT IGNORE INTO `synki_pulse05036308000100`.`smtp_config` (`id`, `default_sender`, `display_name`, `email_from`, `password`, `port`, `server_address`, `use_ssl`, `use_tls`, `username`, `ID_USUARIO`) SELECT `id`, `default_sender`, `display_name`, `email_from`, `password`, `port`, `server_address`, `use_ssl`, `use_tls`, `username`, `ID_USUARIO` FROM `flow_crm`.`smtp_config`;

-- sub_centro_custo
INSERT IGNORE INTO `synki_pulse05036308000100`.`sub_centro_custo` (`ID`, `DESCRICAO`, `DESCRITIVO`, `INDICE`, `NOME`, `ID_CENTRO_CUSTO`) SELECT `ID`, `DESCRICAO`, `DESCRITIVO`, `INDICE`, `NOME`, `ID_CENTRO_CUSTO` FROM `flow_crm`.`sub_centro_custo`;

-- sub_menu
INSERT IGNORE INTO `synki_pulse05036308000100`.`sub_menu` (`id`, `icon`, `label`, `outcome`, `menu_id`, `ID_PERMISSAO`) SELECT `id`, `icon`, `label`, `outcome`, `menu_id`, `ID_PERMISSAO` FROM `flow_crm`.`sub_menu`;

-- tb_channel
INSERT IGNORE INTO `synki_pulse05036308000100`.`tb_channel` (`channel_id`, `description`) SELECT `channel_id`, `description` FROM `flow_crm`.`tb_channel`;

-- tb_notifications
INSERT IGNORE INTO `synki_pulse05036308000100`.`tb_notifications` (`notification_id`, `date_time`, `destination`, `message`, `channel_id`, `status_id`) SELECT `notification_id`, `date_time`, `destination`, `message`, `channel_id`, `status_id` FROM `flow_crm`.`tb_notifications`;

-- tb_notifications_seq
INSERT IGNORE INTO `synki_pulse05036308000100`.`tb_notifications_seq` (`next_val`) SELECT `next_val` FROM `flow_crm`.`tb_notifications_seq`;

-- tb_status
INSERT IGNORE INTO `synki_pulse05036308000100`.`tb_status` (`status_id`, `description`) SELECT `status_id`, `description` FROM `flow_crm`.`tb_status`;

-- tipo_atendimento
INSERT IGNORE INTO `synki_pulse05036308000100`.`tipo_atendimento` (`ID`, `DATA_CRIACAO`, `DESCRICAO`, `NOME`) SELECT `ID`, `DATA_CRIACAO`, `DESCRICAO`, `NOME` FROM `flow_crm`.`tipo_atendimento`;

-- tipo_conta
INSERT IGNORE INTO `synki_pulse05036308000100`.`tipo_conta` (`ID`, `BANCO`, `CAIXA`, `NOME`, `OUTRO`) SELECT `ID`, `BANCO`, `CAIXA`, `NOME`, `OUTRO` FROM `flow_crm`.`tipo_conta`;

-- tipo_contrato
INSERT IGNORE INTO `synki_pulse05036308000100`.`tipo_contrato` (`ID`, `DESCRICAO`, `NOME`, `ID_EMPRESA`) SELECT `ID`, `DESCRICAO`, `NOME`, `ID_EMPRESA` FROM `flow_crm`.`tipo_contrato`;

-- tipo_documento_ged
INSERT IGNORE INTO `synki_pulse05036308000100`.`tipo_documento_ged` (`id`, `descricao`, `NOME`) SELECT `id`, `descricao`, `NOME` FROM `flow_crm`.`tipo_documento_ged`;

-- tipo_pagamento
INSERT IGNORE INTO `synki_pulse05036308000100`.`tipo_pagamento` (`ID`, `DESCRICAO`, `NOME`) SELECT `ID`, `DESCRICAO`, `NOME` FROM `flow_crm`.`tipo_pagamento`;

-- tipo_receita_dipi
INSERT IGNORE INTO `synki_pulse05036308000100`.`tipo_receita_dipi` (`ID`, `DESCRICAO`) SELECT `ID`, `DESCRICAO` FROM `flow_crm`.`tipo_receita_dipi`;

-- tipo_servico
INSERT IGNORE INTO `synki_pulse05036308000100`.`tipo_servico` (`ID`, `DATA_CRIACAO`, `DESCRICAO`, `NOME`) SELECT `ID`, `DATA_CRIACAO`, `DESCRICAO`, `NOME` FROM `flow_crm`.`tipo_servico`;

-- transportadora
INSERT IGNORE INTO `synki_pulse05036308000100`.`transportadora` (`id`, `DATA_CADASTRO`, `OBSERVACAO`, `ID_PESSOA`) SELECT `id`, `DATA_CADASTRO`, `OBSERVACAO`, `ID_PESSOA` FROM `flow_crm`.`transportadora`;

-- tribut_cofins
INSERT IGNORE INTO `synki_pulse05036308000100`.`tribut_cofins` (`ID`, `ALIQUOTA_PORCENTO`, `ALIQUOTA_UNIDADE`, `CST_COFINS`, `EFD_TABELA_435`, `MODALIDADE_BASE_CALCULO`, `PORCENTO_BASE_CALCULO`, `VALOR_PAUTA_FISCAL`, `VALOR_PRECO_MAXIMO`, `ID_TRIBUT_CONFIGURA_OF_GT`) SELECT `ID`, `ALIQUOTA_PORCENTO`, `ALIQUOTA_UNIDADE`, `CST_COFINS`, `EFD_TABELA_435`, `MODALIDADE_BASE_CALCULO`, `PORCENTO_BASE_CALCULO`, `VALOR_PAUTA_FISCAL`, `VALOR_PRECO_MAXIMO`, `ID_TRIBUT_CONFIGURA_OF_GT` FROM `flow_crm`.`tribut_cofins`;

-- tribut_configura_of_gt
INSERT IGNORE INTO `synki_pulse05036308000100`.`tribut_configura_of_gt` (`ID`, `ID_TRIBUT_GRUPO_TRIBUTARIO`, `ID_TRIBUT_OPERACAO_FISCAL`) SELECT `ID`, `ID_TRIBUT_GRUPO_TRIBUTARIO`, `ID_TRIBUT_OPERACAO_FISCAL` FROM `flow_crm`.`tribut_configura_of_gt`;

-- tribut_grupo_tributario
INSERT IGNORE INTO `synki_pulse05036308000100`.`tribut_grupo_tributario` (`ID`, `DESCRICAO`, `OBSERVACAO`, `ORIGEM_MERCADORIA`, `ID_EMPRESA`) SELECT `ID`, `DESCRICAO`, `OBSERVACAO`, `ORIGEM_MERCADORIA`, `ID_EMPRESA` FROM `flow_crm`.`tribut_grupo_tributario`;

-- tribut_icms_custom_cab
INSERT IGNORE INTO `synki_pulse05036308000100`.`tribut_icms_custom_cab` (`ID`, `DESCRICAO`, `ORIGEM_MERCADORIA`, `ID_EMPRESA`) SELECT `ID`, `DESCRICAO`, `ORIGEM_MERCADORIA`, `ID_EMPRESA` FROM `flow_crm`.`tribut_icms_custom_cab`;

-- tribut_icms_custom_det
INSERT IGNORE INTO `synki_pulse05036308000100`.`tribut_icms_custom_det` (`ID`, `ALIQUOTA`, `ALIQUOTA_ICMS_ST`, `ALIQUOTA_INTERESTADUAL_ST`, `ALIQUOTA_INTERNA_ST`, `CFOP`, `CSOSN_B`, `CST_B`, `MODALIDADE_BC`, `MODALIDADE_BC_ST`, `MVA`, `PORCENTO_BC`, `PORCENTO_BC_ST`, `UF_DESTINO`, `VALOR_PAUTA`, `VALOR_PAUTA_ST`, `VALOR_PRECO_MAXIMO`, `VALOR_PRECO_MAXIMO_ST`, `ID_TRIBUT_ICMS_CUSTOM_CAB`) SELECT `ID`, `ALIQUOTA`, `ALIQUOTA_ICMS_ST`, `ALIQUOTA_INTERESTADUAL_ST`, `ALIQUOTA_INTERNA_ST`, `CFOP`, `CSOSN_B`, `CST_B`, `MODALIDADE_BC`, `MODALIDADE_BC_ST`, `MVA`, `PORCENTO_BC`, `PORCENTO_BC_ST`, `UF_DESTINO`, `VALOR_PAUTA`, `VALOR_PAUTA_ST`, `VALOR_PRECO_MAXIMO`, `VALOR_PRECO_MAXIMO_ST`, `ID_TRIBUT_ICMS_CUSTOM_CAB` FROM `flow_crm`.`tribut_icms_custom_det`;

-- tribut_icms_uf
INSERT IGNORE INTO `synki_pulse05036308000100`.`tribut_icms_uf` (`id`, `ALIQUOTA`, `ALIQUOTA_ICMS_ST`, `ALIQUOTA_INTERESTADUAL_ST`, `ALIQUOTA_INTERNA_ST`, `CFOP`, `C_BENEFICIO`, `CSOSN`, `CST`, `MODALIDADE_BC`, `MODALIDADE_BC_ST`, `MVA`, `ORIGEM_MERCADORIA`, `PORCENTO_BC`, `PORCENTO_BC_ST`, `UF_DESTINO`, `VALOR_PAUTA`, `VALOR_PAUTA_ST`, `VALOR_PRECO_MAXIMO`, `VALOR_PRECO_MAXIMO_ST`, `ID_TRIBUT_CONFIGURA_OF_GT`) SELECT `id`, `ALIQUOTA`, `ALIQUOTA_ICMS_ST`, `ALIQUOTA_INTERESTADUAL_ST`, `ALIQUOTA_INTERNA_ST`, `CFOP`, `C_BENEFICIO`, `CSOSN`, `CST`, `MODALIDADE_BC`, `MODALIDADE_BC_ST`, `MVA`, `ORIGEM_MERCADORIA`, `PORCENTO_BC`, `PORCENTO_BC_ST`, `UF_DESTINO`, `VALOR_PAUTA`, `VALOR_PAUTA_ST`, `VALOR_PRECO_MAXIMO`, `VALOR_PRECO_MAXIMO_ST`, `ID_TRIBUT_CONFIGURA_OF_GT` FROM `flow_crm`.`tribut_icms_uf`;

-- tribut_ipi
INSERT IGNORE INTO `synki_pulse05036308000100`.`tribut_ipi` (`ID`, `ALIQUOTA_PORCENTO`, `ALIQUOTA_UNIDADE`, `CST_IPI`, `MODALIDADE_BASE_CALCULO`, `PORCENTO_BASE_CALCULO`, `VALOR_PAUTA_FISCAL`, `VALOR_PRECO_MAXIMO`, `ID_TIPO_RECEITA_DIPI`, `ID_TRIBUT_CONFIGURA_OF_GT`) SELECT `ID`, `ALIQUOTA_PORCENTO`, `ALIQUOTA_UNIDADE`, `CST_IPI`, `MODALIDADE_BASE_CALCULO`, `PORCENTO_BASE_CALCULO`, `VALOR_PAUTA_FISCAL`, `VALOR_PRECO_MAXIMO`, `ID_TIPO_RECEITA_DIPI`, `ID_TRIBUT_CONFIGURA_OF_GT` FROM `flow_crm`.`tribut_ipi`;

-- tribut_iss
INSERT IGNORE INTO `synki_pulse05036308000100`.`tribut_iss` (`ID`, `ALIQUOTA_PORCENTO`, `ALIQUOTA_UNIDADE`, `CODIGO_TRIBUTACAO`, `ITEM_LISTA_SERVICO`, `MODALIDADE_BASE_CALCULO`, `PORCENTO_BASE_CALCULO`, `VALOR_PAUTA_FISCAL`, `VALOR_PRECO_MAXIMO`, `ID_TRIBUT_OPERACAO_FISCAL`) SELECT `ID`, `ALIQUOTA_PORCENTO`, `ALIQUOTA_UNIDADE`, `CODIGO_TRIBUTACAO`, `ITEM_LISTA_SERVICO`, `MODALIDADE_BASE_CALCULO`, `PORCENTO_BASE_CALCULO`, `VALOR_PAUTA_FISCAL`, `VALOR_PRECO_MAXIMO`, `ID_TRIBUT_OPERACAO_FISCAL` FROM `flow_crm`.`tribut_iss`;

-- tribut_operacao_fiscal
INSERT IGNORE INTO `synki_pulse05036308000100`.`tribut_operacao_fiscal` (`ID`, `CFOP`, `DESCRICAO`, `DESCRICAO_NA_NF`, `FINALIDADE`, `FINALIDADE_OPERACAO`, `GERA_FINANCEIRO`, `MOVIMENTA_ESTOQUE`, `OBSERVACAO`, `PRINCIPAL`, `TIPO_OPERACAO`, `ID_EMPRESA`) SELECT `ID`, `CFOP`, `DESCRICAO`, `DESCRICAO_NA_NF`, `FINALIDADE`, `FINALIDADE_OPERACAO`, `GERA_FINANCEIRO`, `MOVIMENTA_ESTOQUE`, `OBSERVACAO`, `PRINCIPAL`, `TIPO_OPERACAO`, `ID_EMPRESA` FROM `flow_crm`.`tribut_operacao_fiscal`;

-- tribut_pis
INSERT IGNORE INTO `synki_pulse05036308000100`.`tribut_pis` (`ID`, `ALIQUOTA_PORCENTO`, `ALIQUOTA_UNIDADE`, `CST_PIS`, `EFD_TABELA_435`, `MODALIDADE_BASE_CALCULO`, `PORCENTO_BASE_CALCULO`, `VALOR_PAUTA_FISCAL`, `VALOR_PRECO_MAXIMO`, `ID_TRIBUT_CONFIGURA_OF_GT`) SELECT `ID`, `ALIQUOTA_PORCENTO`, `ALIQUOTA_UNIDADE`, `CST_PIS`, `EFD_TABELA_435`, `MODALIDADE_BASE_CALCULO`, `PORCENTO_BASE_CALCULO`, `VALOR_PAUTA_FISCAL`, `VALOR_PRECO_MAXIMO`, `ID_TRIBUT_CONFIGURA_OF_GT` FROM `flow_crm`.`tribut_pis`;

-- uf
INSERT IGNORE INTO `synki_pulse05036308000100`.`uf` (`ID`, `CODIGO_IBGE`, `NOME`, `SIGLA`) SELECT `ID`, `CODIGO_IBGE`, `NOME`, `SIGLA` FROM `flow_crm`.`uf`;

-- usuario
INSERT IGNORE INTO `synki_pulse05036308000100`.`usuario` (`id`, `cidade`, `cpf_cnpj`, `email`, `nome`, `perfil`, `senha`, `senhaConfirma`, `ID_EMPRESA`, `ID_AGENDA`, `agenda`, `celular`, `celularTratado`, `celularTratadoApi`, `NOME_COLABORADOR`, `nomeColaborador`, `urlInstancia`, `url_instancia`, `TOKEN_INSTANCIA`, `tokenIstancia`, `uiidFirebase`, `celular_tratado`, `celular_tratado_api`, `senha_confirma`, `token_istancia`, `uiid_firebase`, `SENHA_EMAIL`, `SERVIDOR_SMTP`, `PORTA_SMTP`, `TEM_SSL`, `TEM_TLS`, `ID_PERMISSAO`, `ID_COMISSAO`) SELECT `id`, `cidade`, `cpf_cnpj`, `email`, `nome`, `perfil`, `senha`, `senhaConfirma`, `ID_EMPRESA`, `ID_AGENDA`, `agenda`, `celular`, `celularTratado`, `celularTratadoApi`, `NOME_COLABORADOR`, `nomeColaborador`, `urlInstancia`, `url_instancia`, `TOKEN_INSTANCIA`, `tokenIstancia`, `uiidFirebase`, `celular_tratado`, `celular_tratado_api`, `senha_confirma`, `token_istancia`, `uiid_firebase`, `SENHA_EMAIL`, `SERVIDOR_SMTP`, `PORTA_SMTP`, `TEM_SSL`, `TEM_TLS`, `ID_PERMISSAO`, `ID_COMISSAO` FROM `flow_crm`.`usuario`;

-- usuario_grupo
INSERT IGNORE INTO `synki_pulse05036308000100`.`usuario_grupo` (`usuario_id`, `grupo_id`) SELECT `usuario_id`, `grupo_id` FROM `flow_crm`.`usuario_grupo`;

-- veiculo
INSERT IGNORE INTO `synki_pulse05036308000100`.`veiculo` (`ID`, `ANO_FABRICA`, `CAPACIDADE_M3`, `CAPACIDADE_KG`, `COR`, `MARCA`, `MODELO`, `OBS`, `PLACA`, `RENAVAM`, `TARA`, `TIPO_CARROCERIA`, `TIPO_PROPRIETARIO`, `TIPO_RODADO`, `TIPO_VEICULO`, `UF_LICENCIAMENTO`, `ID_EMPRESA`) SELECT `ID`, `ANO_FABRICA`, `CAPACIDADE_M3`, `CAPACIDADE_KG`, `COR`, `MARCA`, `MODELO`, `OBS`, `PLACA`, `RENAVAM`, `TARA`, `TIPO_CARROCERIA`, `TIPO_PROPRIETARIO`, `TIPO_RODADO`, `TIPO_VEICULO`, `UF_LICENCIAMENTO`, `ID_EMPRESA` FROM `flow_crm`.`veiculo`;

-- vendedor
INSERT IGNORE INTO `synki_pulse05036308000100`.`vendedor` (`id`, `COMISSAO`, `META_VENDA`) SELECT `id`, `COMISSAO`, `META_VENDA` FROM `flow_crm`.`vendedor`;

-- visita_sugerida
INSERT IGNORE INTO `synki_pulse05036308000100`.`visita_sugerida` (`id`, `data_sugerida`, `insight`, `latitude_cliente`, `longitude_cliente`, `prioridade`, `status`, `id_agenda_compromisso`, `titulo`, `distancia`, `nome`, `data_rota`, `ID_USUARIO`, `identificador`) SELECT `id`, `data_sugerida`, `insight`, `latitude_cliente`, `longitude_cliente`, `prioridade`, `status`, `id_agenda_compromisso`, `titulo`, `distancia`, `nome`, `data_rota`, `ID_USUARIO`, `identificador` FROM `flow_crm`.`visita_sugerida`;

-- visitas_sugeridas
INSERT IGNORE INTO `synki_pulse05036308000100`.`visitas_sugeridas` (`ID`, `DATA_CRIACAO`, `LATITUDE`, `LONGITUDE`, `OBS`, `ID_OPORTUNIDADE`) SELECT `ID`, `DATA_CRIACAO`, `LATITUDE`, `LONGITUDE`, `OBS`, `ID_OPORTUNIDADE` FROM `flow_crm`.`visitas_sugeridas`;

SET FOREIGN_KEY_CHECKS=1;
