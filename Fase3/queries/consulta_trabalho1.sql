WITH 

BASE_INICIAL AS (
SELECT 
  * 
FROM `basedosdados.br_ibge_pnad_covid.microdados`
WHERE MES IN (8,9,10)


)

,BASE_FINAL AS (
SELECT 

####### VARIAVEIS NÃO SUMARIZADAS ########

####### REFERÊNCIA #######
    ANO,
    MES,
    CASE 
       WHEN MES = 8  THEN '2020-08-01'
       WHEN MES = 9  THEN '2020-09-01'
       WHEN MES = 10 THEN '2020-10-01'
    ELSE 'S/ INFO'
    END AS DESC_MES,

####### SALÁRIO #######
    CASE
       WHEN CAST(C011A11 AS INT64) = 0  THEN 'a. Até 100'
       WHEN CAST(C011A11 AS INT64) = 1  THEN 'b. Até 300'
       WHEN CAST(C011A11 AS INT64) = 2  THEN 'c. Até 600'
       WHEN CAST(C011A11 AS INT64) = 3  THEN 'd. Até 800'
       WHEN CAST(C011A11 AS INT64) = 4  THEN 'e. Até 1.600'
       WHEN CAST(C011A11 AS INT64) = 5  THEN 'f. Até 3.000'
       WHEN CAST(C011A11 AS INT64) = 6  THEN 'g. Até 10.000'
       WHEN CAST(C011A11 AS INT64) = 7  THEN 'h. Até 50.000'
       WHEN CAST(C011A11 AS INT64) = 8  THEN 'i. Até 100.000'
       WHEN CAST(C011A11 AS INT64) = 9  THEN 'j. > 100.000'
    ELSE 'K. S/ INFO'
    END AS FX_SALARIAL,

    C011A12 AS VR_SALARIO,

####### CARGO ######## PERGUNTA 1 - TÓPICO TRABALHO    
    CASE 
        WHEN C007c = '1' THEN 'Empregado doméstico, diarista, cozinheiro'
        WHEN C007c = '2' THEN 'Faxineiro, auxiliar de limpeza etc.'
        WHEN C007c = '3' THEN 'Auxiliar de escritório, escriturário'
        WHEN C007c = '4' THEN 'Secretária, recepcionista'
        WHEN C007c = '5' THEN 'Operador de Telemarketing'
        WHEN C007c = '6' THEN 'Comerciante'
        WHEN C007c = '7' THEN 'Balconista, vendedor de loja'
        WHEN C007c = '8' THEN 'Vendedor a domicílio, representante de vendas, vendedor de catálogo'
        WHEN C007c = '9' THEN 'Vendedor ambulante'
        WHEN C007c = '10' THEN 'Cozinheiro e garçon'
        WHEN C007c = '11' THEN 'Padeiro, açougueiro e doceiro'
        WHEN C007c = '12' THEN 'Agricultor, criador de animais, pescador, silvicultor e jardineiro'
        WHEN C007c = '13' THEN 'Auxiliar da agropecuária'
        WHEN C007c = '14' THEN 'Motorista'
        WHEN C007c = '15' THEN 'Motorista de caminhão'
        WHEN C007c = '16' THEN 'Motoboy'
        WHEN C007c = '17' THEN 'Entregador de mercadorias'
        WHEN C007c = '18' THEN 'Pedreiro, servente de pedreiro, pintor, eletricista, marceneiro'
        WHEN C007c = '19' THEN 'Mecânico de veículos, máquinas industriais etc.'
        WHEN C007c = '20' THEN 'Artesão, costureiro e sapateiro'
        WHEN C007c = '21' THEN 'Cabeleireiro, manicure e afins'
        WHEN C007c = '22' THEN 'Operador de máquinas, montador na indústria'
        WHEN C007c = '23' THEN 'Auxiliar de produção, de carga e descarga'
        WHEN C007c = '24' THEN 'Professor da educação infantil, de ensino fundamental, médio ou superior'
        WHEN C007c = '25' THEN 'Pedagogo, professor de idiomas, música, arte e reforço escolar'
        WHEN C007c = '26' THEN 'Médico, enfermeiro, profissionais de saúde de nível superior'
        WHEN C007c = '27' THEN 'Técnico, profissional da saúde de nível médio'
        WHEN C007c = '28' THEN 'Cuidador de crianças, doentes ou idosos'
        WHEN C007c = '29' THEN 'Segurança, vigilante, outro trabalhador dos serviços de proteção'
        WHEN C007c = '30' THEN 'Policial civil'
        WHEN C007c = '31' THEN 'Porteiro, zelador'
        WHEN C007c = '32' THEN 'Artista, religioso'
        WHEN C007c = '33' THEN 'Diretor, gerente, cargo político ou comissionado'
        WHEN C007c = '34' THEN 'Outra profissão de nível superior'
        WHEN C007c = '35' THEN 'Outro técnico ou profissional de nível médio'
        ELSE 'Outro'
    END AS CARGO,


        CASE 
        WHEN C007c IN ('1', '2')            THEN 'Serv. Domésticos'
        WHEN C007c IN ('6','7','8','9')     THEN 'Vendas em Geral'
        WHEN C007c IN ('10','11')           THEN 'Alimentos em Geral'
        WHEN C007c IN ('12','13')           THEN 'Agro em Geral'
        WHEN C007c IN ('14','15','16','17') THEN 'Entregas/Motoristas'
        WHEN C007c IN ('18','19','22','23') THEN 'Serv. Braçais'
        WHEN C007c = '20'                   THEN 'Serv. Manuais'
        WHEN C007c IN ('24', '25')          THEN 'Professor'
        WHEN C007c IN ('26','27','28')      THEN 'Área da Saúde'
        WHEN C007c IN ('29','30')           THEN 'Segurança'
        WHEN C007c = '21'                   THEN 'Serv. Estéticos '
        WHEN C007c = '33'                   THEN 'Cargo de Confiança'
        WHEN C007c = '34'                   THEN 'Outras Nível Superior'
        WHEN C007c IN ('3','4','5','31','32','35') THEN 'Outras Nível Médio'
        ELSE 'Outro'
    END AS CARGO_SUMARIZADO,

####### TRABALHOU HOME OFFICE SEMANA PASSADA ######## PERGUNTA 2 - TÓPICO TRABALHO  
    CASE 
        WHEN C013 = '1' THEN 'SIM'
        WHEN C013 = '2' THEN 'NÃO'
    ELSE 'S/ INFO'
    END HO_SEMANA_PASSADA,

####### VARIAVEIS  SUMARIZADAS ########

####### POPULAÇÃO TRABALHANDO ######## PERGUNTA 3 - TÓPICO TRABALHO
    COUNT(*)                                               AS QT_POPULACAO_ENTREVISTADA,
    SUM(IF(C001 = '1', 1, 0))                              AS TRABALHANDO,
    SUM(IF(C001 = '2', 1, 0))                              AS NAO_TRABALHANDO,
    SUM(IF(C006 = '1', 1, 0))                              AS MAIS_DE_UM_EMPREGO,
    ROUND((SUM(IF(C001 = '1', 1, 0)) / COUNT(*)) * 100, 2) AS PERC_TRABALHANDO,
    ROUND((SUM(IF(C001 = '2', 1, 0)) / COUNT(*)) * 100, 2) AS PERC_NAO_TRABALHANDO,
    ROUND((SUM(IF(C006 = '1', 1, 0)) / COUNT(*)) * 100, 2) AS PERC_MAIS_DE_UM_EMPREGO,
    

####### SALÁRIO  ######## PERGUNTA 4 - TÓPICO TRABALHO

    MAX(CASE WHEN C011A11 IS NOT NULL THEN C011A12 END)    AS MAX_SALARIO,
    MIN(CASE WHEN C011A11 IS NOT NULL THEN C011A12 END)    AS MIN_SALARIO

FROM BASE_INICIAL 
GROUP BY ALL


)
SELECT 
* EXCEPT(DESC_MES), 
DATE(DESC_MES) AS DESC_MES,
FROM BASE_FINAL
