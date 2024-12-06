select
    sigla_uf,
    b0041 as buscou_atendimento_posto_saude_ou_equipe_saude_familia,
    b0042 as buscou_atendimento_pronto_socorro_sus_upa,
    b0043 as buscou_atendimento_hospital_sus,
    b0044 as buscou_atendimento_ambulatorio_ou_consultorio_privado_ou_ligado_forcas_armadas,
    b0045 as buscou_atendimento_pronto_socorro_ou_consultorio_privado_ou_ligado_forcas_armadas,
    b0046 as buscou_atendimento_hospital_ou_consultorio_privado_ou_ligado_forcas_armadas,
    FROM `basedosdados.br_ibge_pnad_covid.microdados`
    where mes in (7,9,11) 
    and b0041 is not null 
    or b0042 is not null 
    or b0043 is not null 
    or b0044 is not null 
    or b0045 is not null 
    or b0046 is not null
