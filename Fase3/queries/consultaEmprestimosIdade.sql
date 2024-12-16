# E001 Durante o período da pandemia alguém deste domicílio solicitou algum empréstimo? 

#1	Sim, e pelo menos um morador conseguiu 
#2	Sim, mas nenhum morador conseguiu
#3	Não solicitou


# E0021 Este empréstimo foi adquirido com banco ou financeira?  

#1	Sim
#2	Não 
#3	Não aplicável

# E0022 Este empréstimo foi adquirido com parente ou amigo? 

#1	Sim
#2	Não 
#3	Não aplicável

# E0023 Este empréstimo foi adquirido com empregados ou patrão?

#1	Sim
#2	Não 
#3	Não aplicável

# E0024 Este empréstimo foi adquirido com outro local ou pessoa? 

#1	Sim
#2	Não 
#3	Não aplicável


SELECT 
       CASE 
              WHEN CAST(a002 AS INT64) BETWEEN 18 AND 29 THEN '18-29'
              WHEN CAST(a002 AS INT64) BETWEEN 30 AND 49 THEN '30-49'
              WHEN CAST(a002 AS INT64) BETWEEN 50 AND 64 THEN '50-64'
              ELSE  '65+'
       END as faixa_etaria,
       SUM(IF(e001 =   '1',1,0))  as emprestimo_solicitado,
       SUM(IF(e0021 =  '1',1,0)) as realizado_por_banco,
       SUM(IF(e0022 =  '1',1,0)) as realizado_por_amigo_ou_parente,
       SUM(IF(e0023 =  '1',1,0)) as realizado_por_patrao,
       SUM(IF(e0024 =  '1',1,0)) as realizado_por_outro
FROM `basedosdados.br_ibge_pnad_covid.microdados` 
WHERE mes in (8,9,10)
GROUP BY faixa_etaria
