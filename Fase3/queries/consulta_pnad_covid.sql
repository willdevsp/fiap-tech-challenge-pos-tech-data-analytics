
SELECT 
    PNAD.MES AS mes,
    PNAD.SIGLA_UF AS uf,
    CASE 
        WHEN CAST(PNAD.A002 AS INT64) <= 19 THEN "Jovens"
        WHEN CAST(PNAD.A002 AS INT64) > 20 AND CAST(PNAD.A002 AS INT64) <= 59 THEN "Adultos"
        ELSE "Idosos"
    END AS faixa_etaria,
    PNAD.A003 AS id_sexo,
    PNAD.A004 AS id_grupo,
    PNAD.A005 AS id_escolaridade,
    SUM(IF(CAST(PNAD.B008 AS INT64) = 1, 1, 0)) AS qtd_pop_fez_teste_covid,
    SUM(IF(CAST(PNAD.B009A AS INT64) = 1, 1, 0)) AS qtd_pop_fez_teste_covid_swab,
    SUM(IF(CAST(PNAD.B009B AS INT64) = 1, 1, 0)) AS qtd_pop_teste_swab_positivo,
    SUM(IF(CAST(PNAD.B009B AS INT64) = 3, 1, 0)) AS qtd_pop_teste_swab_inconclusivo,
    SUM(IF(CAST(PNAD.B009B AS INT64) = 4, 1, 0)) AS qtd_pop_teste_swab_sem_resultado,
    SUM(IF(CAST(PNAD.B009C AS INT64) = 1, 1, 0)) AS qtd_pop_fez_teste_covid_furo_dedo,
    SUM(IF(CAST(PNAD.B009D AS INT64) = 1, 1, 0)) AS qtd_pop_teste_furo_dedo_positivo,
    SUM(IF(CAST(PNAD.B009D AS INT64) = 3, 1, 0)) AS qtd_pop_teste_furo_dedo_inconclusivo,
    SUM(IF(CAST(PNAD.B009D AS INT64) = 4, 1, 0)) AS qtd_pop_teste_furo_dedo_sem_resultado,
    SUM(IF(CAST(PNAD.B009E AS INT64) = 1, 1, 0)) AS qtd_pop_fez_teste_covid_veia,
    SUM(IF(CAST(PNAD.B009F AS INT64) = 1, 1, 0)) AS qtd_pop_teste_veia_positivo,
    SUM(IF(CAST(PNAD.B009F AS INT64) = 3, 1, 0)) AS qtd_pop_teste_veia_inconclusivo,
    SUM(IF(CAST(PNAD.B009F AS INT64) = 4, 1, 0)) AS qtd_pop_teste_veia_sem_resultado
FROM 
    `basedosdados.br_ibge_pnad_covid.microdados` PNAD
WHERE   
    (
        CAST(PNAD.B0011 AS INT64) = 1 OR CAST(PNAD.B0012 AS INT64) = 1 OR
        CAST(PNAD.B0013 AS INT64) = 1 OR CAST(PNAD.B0014 AS INT64) = 1 OR
        CAST(PNAD.B0015 AS INT64) = 1 OR CAST(PNAD.B0016 AS INT64) = 1 OR
        CAST(PNAD.B0017 AS INT64) = 1 OR CAST(PNAD.B0018 AS INT64) = 1 OR
        CAST(PNAD.B0019 AS INT64) = 1 OR CAST(PNAD.B00110 AS INT64) = 1 OR
        CAST(PNAD.B00111 AS INT64) = 1 OR CAST(PNAD.B00112 AS INT64) = 1 OR
        CAST(PNAD.B00113 AS INT64) = 1
    ) 
    AND CAST(PNAD.MES AS INT64) IN (8, 9, 10) -- Filtro pelos meses 8, 9 e 10
GROUP BY 
    PNAD.MES,
    PNAD.SIGLA_UF,
    CASE 
        WHEN CAST(PNAD.A002 AS INT64) <= 19 THEN "Jovens"
        WHEN CAST(PNAD.A002 AS INT64) > 20 AND CAST(PNAD.A002 AS INT64) <= 59 THEN "Adultos"
        ELSE "Idosos"
    END,
    PNAD.A003,
    PNAD.A004,
    PNAD.A005
ORDER BY mes;
