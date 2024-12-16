SELECT 
    sintoma,
    SUM(CASE WHEN resposta = '1' THEN 1 ELSE 0 END) AS quantidade
FROM (
    SELECT 'febre' AS sintoma, b0011 AS resposta FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'tosse', b0012 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'dor_de_garganta', b0013 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'dificuldade_respirar', b0014 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'dor_de_cabeca', b0015 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'dor_no_peito', b0016 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'nausea', b0017 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'nariz_entupido_ou_escorrendo', b0018 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'fadiga', b0019 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'dor_nos_olhos', b00110 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'perda_cheiro_ou_sabor', b00111 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'dor_muscular', b00112 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
    UNION ALL
    SELECT 'diarreia', b00113 FROM `basedosdados.br_ibge_pnad_covid.microdados` WHERE mes IN (8, 9, 10)
) AS sintomas
GROUP BY sintoma
ORDER BY sintoma;
