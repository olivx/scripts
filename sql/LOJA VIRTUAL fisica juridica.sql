select nfe.COD_NF_SAIDA AS NFE , 
case 
when nfe.PES_CLI = 'J' then 'JURIDICA'
when nfe.PES_CLI = 'F' then 'FISICA'
end TIPO , nfe.TOTAL_NF_SAIDA AS TOTAL  , nop.DESC_NAT as [NATUREZA DA OPERAÇÃO]
from nfe 
inner join NATUREZA_OPERACAO as nop on nop.COD_NAT = nfe.COD_NAT
where nfe.DATAEMIS_NF_SAIDA between '2015-01-01' and '2015-12-31' 
and nfe.COD_VEND = 20 and nfe.CANC_NF_SAIDA = 0 
group by nfe.cod_NF_SAIDA, nfe.PES_CLI, nfe.TOTAL_NF_SAIDA, nop.DESC_NAT , NFE.DATAEMIS_NF_SAIDA
ORDER BY NFE.DATAEMIS_NF_SAIDA ASC 