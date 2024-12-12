SELECT
    sigla_uf,
    LAST_DAY(DATE(CONCAT('2020', '-', mes, '-01'))) AS ultimo_dia_mes,
    b002 AS foi_algum_estabelecimento_saude,
    b005 AS ficou_internado,
    b006 AS ficou_sedado_entubado_respiracao_artificial_com_ventilador,
    b0041 AS buscou_atendimento_posto_saude_ou_equipe_saude_familia,
    b0042 AS buscou_atendimento_pronto_socorro_sus_upa,
    b0043 AS buscou_atendimento_hospital_sus,
    b0044 AS buscou_atendimento_ambulatorio_ou_consultorio_privado_ou_ligado_forcas_armadas,
    b0045 AS buscou_atendimento_pronto_socorro_ou_consultorio_privado_ou_ligado_forcas_armadas,
    b0046 AS buscou_atendimento_hospital_ou_consultorio_privado_ou_ligado_forcas_armadas,
    b0011 AS teve_febre,
    b0012 AS teve_tosse,
    b0013 AS teve_dor_garganta,
    b0014 AS teve_dificuldade_respirar,
    b0015 AS teve_dor_cabeca,
    b0016 AS teve_dor_peito,
    b0017 AS teve_nausea,
    b0018 AS teve_nariz_entupido_ou_escorrendo,
    b0019 AS teve_fadiga,
    b00110 AS teve_dor_nos_olhos,
    b00111 AS teve_perda_cheiro_sabor,
    b00112 AS teve_dor_muscular,
    b00113 AS teve_teve_diarreia,
    CASE
      WHEN CAST(UPPER(sigla_uf) AS STRING) IN ("PA","AM","AC","RR","RO","TO","AP") THEN "Norte"
      WHEN CAST(UPPER(sigla_uf) AS STRING) IN ("MG","SP","RJ","ES") THEN "Sudeste"
      WHEN CAST(UPPER(sigla_uf) AS STRING) IN ("SC","RS","PR") THEN "Sul"
      WHEN CAST(UPPER(sigla_uf) AS STRING) IN ("MA","CE","BA","PE","AL","PB","PI","SE","RN") THEN "Nordeste"
      WHEN CAST(UPPER(sigla_uf) AS STRING) IN ("GO","MT","MS","DF") THEN "Centro-Oeste"
    END regiao_brasil
FROM
    `basedosdados.br_ibge_pnad_covid.microdados`
WHERE
    mes IN (8, 9, 10)
    and (b002 is not null OR
        b0011 is not null OR
        b0012 is not null OR
        b0013 is not null OR
        b0014 is not null OR
        b0015 is not null OR
        b0016 is not null OR
        b0017 is not null OR
        b0018 is not null OR
        b0019 is not null OR
        b00110 is not null OR
        b00111 is not null OR
        b00112 is not null OR
        b00113 is not null
    )
   