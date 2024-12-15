--Providência tomada
SELECT
  a.ano, 
  a.mes, 
  a.sigla_uf, 
  COUNT(CASE WHEN b.valor = 'Sim' THEN 1 END) foi_ficar_em_casa,
  COUNT(CASE WHEN c.valor = 'Sim' THEN 1 END) ligar_para_algum_profissional_de_saude,
  COUNT(CASE WHEN d.valor = 'Sim' THEN 1 END) comprar_e_ou_tomar__remedio_por_conta_propria,
  COUNT(CASE WHEN e.valor = 'Sim' THEN 1 END) comprar_e_ou_tomar_remedio_por_orientacao_medica,
  COUNT(CASE WHEN f.valor = 'Sim' THEN 1 END) receber_visita_de_algum_profissional_de_saude_do_SUS,
  COUNT(CASE WHEN g.valor = 'Sim' THEN 1 END) receber_visita_de_profissional_de_saude_particular,
  COUNT(CASE WHEN h.valor = 'Sim' THEN 1 END) outra
FROM `basedosdados.br_ibge_pnad_covid.microdados` a
left join basedosdados.br_ibge_pnad_covid.dicionario b on b.nome_coluna = 'b0031' and a.b0031 = b.chave
left join basedosdados.br_ibge_pnad_covid.dicionario c on c.nome_coluna = 'b0032' and a.b0032 = c.chave
left join basedosdados.br_ibge_pnad_covid.dicionario d on d.nome_coluna = 'b0033' and a.b0033 = d.chave
left join basedosdados.br_ibge_pnad_covid.dicionario e on e.nome_coluna = 'b0034' and a.b0034 = e.chave
left join basedosdados.br_ibge_pnad_covid.dicionario f on f.nome_coluna = 'b0035' and a.b0035 = f.chave
left join basedosdados.br_ibge_pnad_covid.dicionario g on g.nome_coluna = 'b0036' and a.b0036 = g.chave
left join basedosdados.br_ibge_pnad_covid.dicionario h on h.nome_coluna = 'b0037' and a.b0037 = h.chave
where mes in (8,9,10)
group by
  a.ano, 
  a.mes, 
  a.sigla_uf;

--Plano de saúde
SELECT
  a.ano, 
  a.mes, 
  a.sigla_uf, 
  b.valor Tem_algum_plano_de_saude_medico_seja_particular_de_empresa_ou_de_orgao_publico,
  c.valor Tem_carteira_de_trabalho_assinada_ou_e_funcionario_publico_estatutario
FROM `basedosdados.br_ibge_pnad_covid.microdados` a
left join basedosdados.br_ibge_pnad_covid.dicionario b on b.nome_coluna = 'b007' and a.b007 = b.chave
left join basedosdados.br_ibge_pnad_covid.dicionario c on c.nome_coluna = 'c007b' and a.c007b =c.chave
where mes in (8,9,10);


--Afastamento
SELECT
  a.ano, 
  a.mes, 
  a.sigla_uf, 
  b.valor Na_semana_passada_estava_temporariamente_afastado_de_algum_trabalho,
  c.valor Qual_o_principal_motivo_deste_afastamento_temporario,
  d.valor Continuou_a_ser_remunerado_mesmo_que_parcialmente_por_esse_trabalho,
  e.valor Ha_quanto_tempo_esta_afastado_desse_trabalho
FROM `basedosdados.br_ibge_pnad_covid.microdados` a
left join basedosdados.br_ibge_pnad_covid.dicionario b on b.nome_coluna = 'c002' and a.c002 = b.chave
left join basedosdados.br_ibge_pnad_covid.dicionario c on c.nome_coluna = 'c003' and a.c003 = c.chave
left join basedosdados.br_ibge_pnad_covid.dicionario d on d.nome_coluna = 'c004' and a.c004 = d.chave
left join basedosdados.br_ibge_pnad_covid.dicionario e on e.nome_coluna = 'c005' and a.c005 = e.chave
where mes in (8,9,10);
