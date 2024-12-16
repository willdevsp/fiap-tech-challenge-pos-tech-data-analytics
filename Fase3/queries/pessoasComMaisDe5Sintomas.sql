#B0011 #Na semana passada teve febre?
#B0012 #Na semana passada teve tosse?
#B0013 #Na semana passada teve dor de garganta?
#B0014 #Na semana passada teve dificuldade para respirar?
#B0015 #Na semana passada teve dor de cabeça?
#B0016 #Na semana passada teve dor no peito?
#B0017 #Na semana passada teve náusea?
#B0018 #Na semana passada teve nariz entupido ou escorrendo?
#B0019 #Na semana passada teve fadiga?
#B00110 #Na semana passada teve dor nos olhos?
#B00111 #Na semana passada teve perda de cheiro ou sabor?
#B00112 #Na semana passada teve dor muscular?
#B00113 #Na semana passada teve diarreia?

#1	Sim
#2	Não 
#3	Não sabe
#9	Ignorado

WITH Sintomas as (
SELECT 
       ano,
       mes,
       CAST(a002 AS INT64) AS idade_pessoa,
   
       SUM(IF(b0011 =  '1',1,0)) as febre,
       SUM(IF(b0012 =  '1',1,0)) as tosse,
       SUM(IF(b0013 =  '1',1,0)) as dor_de_garganta,
       SUM(IF(b0014 =  '1',1,0)) as dificuldade_respirar,
       SUM(IF(b0015 =  '1',1,0))as dor_de_cabeca,
       SUM(IF(b0016 =  '1',1,0)) as dor_no_peito,
       SUM(IF(b0017 =  '1',1,0)) as nausea,
       SUM(IF(b0018 =  '1',1,0)) as nariz_entupido_ou_escorrendo,
       SUM(IF(b0019 =  '1',1,0)) as fadiga,
       SUM(IF(b00110 =  '1',1,0)) as dor_nos_olhos,
       SUM(IF(b00111 =  '1',1,0)) as perda_cheiro_ou_sabor,
       SUM(IF(b00112 =  '1',1,0)) as dor_muscular,
       SUM(IF(b00113 =  '1',1,0)) as diarreia
FROM `basedosdados.br_ibge_pnad_covid.microdados` 
WHERE mes in (8,9,10)
GROUP BY ano,mes,idade_pessoa
HAVING COUNT(*) >= 5
),

FaixasEtarias as (
  SELECT *,
         CASE 
           WHEN idade_pessoa BETWEEN 18 AND 29 THEN '18-29'
           WHEN idade_pessoa BETWEEN 30 AND 49 THEN '30-49'
           WHEN idade_pessoa BETWEEN 50 AND 64 THEN '50-64'
           ELSE '65+'
         END AS faixa_etaria
  FROM Sintomas
)
SELECT 
  faixa_etaria,
  COUNT(*) as pessoas_com_muitos_sintomas
FROM FaixasEtarias
GROUP BY faixa_etaria
ORDER BY COUNT(*) DESC;
