

select cod_nf_saida as	[NFE] ,DATAEMIS_NF_SAIDA AS [DATA EMISSAO], nat.DESC_NAT AS [NATUREZA OPERAÇAO], 
nfe.TOTAL_NF_SAIDA AS [TOTAL NFE]
from nfe 
inner join NATUREZA_OPERACAO as nat on nat.COD_NAT = nfe.COD_NAT 
where nfe.COD_VEND = 20 and DATAEMIS_NF_SAIDA between '2014-01-01' ANd'2014-12-31'
and PES_CLI = 'F' and nat.TIPO_NF = 'VE'