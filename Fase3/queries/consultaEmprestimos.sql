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

#LAST_DAY(DATE(CONCAT('2020', '-', mes, '-01'))) AS ultimo_dia_mes,

SELECT 
       ano,
       CASE 
              WHEN mes = 8 THEN 'Agosto'
              WHEN mes = 9 THEN 'Setembro'
              WHEN mes = 10 THEN 'Outubro'
       END AS mes_texto,
       COUNT(*) pessoas_entrevistadas, 
       SUM(IF(e001 =  '1',1,0))  as emprestimo_solicitado,
       SUM(IF(e0021 =  '1',1,0)) as realizado_por_banco,
       SUM(IF(e0022 =  '1',1,0)) as realizado_por_amigo_ou_parente,
       SUM(IF(e0023 =  '1',1,0)) as realizado_por_patrao,
       SUM(IF(e0024 =  '1',1,0)) as realizado_por_outro
FROM `basedosdados.br_ibge_pnad_covid.microdados` 
WHERE mes in (8,9,10)
GROUP BY ano,mes,mes_texto
ORDER BY mes
