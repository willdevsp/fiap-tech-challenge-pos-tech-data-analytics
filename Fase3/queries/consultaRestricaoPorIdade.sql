# B011 Qual foi o resultado do teste?  Na semana passada, devido à pandemia do Coronavírus, em que medida o(a) Sr(a) restringiu o contato com as pessoas? 

# 1 Não fez restrição, levou vida normal como antes da pandemia
# 2 Reduziu o contato com as pessoas, mas continuou saindo de casa para trabalho ou atividades não essenciais e/ou recebendo visitas
# 3 Ficou em casa e só saiu em caso de necessidade básica
# 4 Ficou rigorosamente em casa
# 5 Ignorado

SELECT
    CASE 
        WHEN CAST(a002 AS INT64) BETWEEN 18 AND 29 THEN '18-29 anos'
        WHEN CAST(a002 AS INT64) BETWEEN 30 AND 49 THEN '30-49 anos'
        WHEN CAST(a002 AS INT64) BETWEEN 50 AND 64 THEN '50-64 anos'
        ELSE '65+ anos'
    END AS faixa_etaria,
    SUM(IF(B011 = '1', 1, 0)) AS restricao_normal,
    SUM(IF(B011 = '2', 1, 0)) AS restricao_baixa,
    SUM(IF(B011 = '3', 1, 0)) AS restricao_media,
    SUM(IF(B011 = '4', 1, 0)) AS restricao_alta,
    SUM(IF(B011 = '5', 1, 0)) AS nao_respondeu
FROM 
    `basedosdados.br_ibge_pnad_covid.microdados`
WHERE mes in (8,9,10)
GROUP BY 
    faixa_etaria
ORDER BY 
    CASE 
        WHEN faixa_etaria = '18-29 anos' THEN 1
        WHEN faixa_etaria = '30-49 anos' THEN 2
        WHEN faixa_etaria = '50-64 anos' THEN 3
        ELSE 4
    END;