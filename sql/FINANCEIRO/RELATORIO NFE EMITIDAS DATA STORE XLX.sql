
declare @DATA1 AS DATETIME = '2015-07-01', @DATA2 AS DATETIME = '2015-07-31'

select 	 
nfe_DATA.COD_NF_SAIDA [NFE], nfe_DATA.TIPO_NF_SAIDA [TIPO NFE],  
nfe_DATA.COD_CLI [COD CLIENTE],  cli.NOME_CLI [CLIENTE] ,
/*clientes.*/
CASE nfe_DATA.CANC_NF_SAIDA
WHEN  1  THEN 'CANCELADA'
WHEN  0  THEN 'ATIVA' END [NFE CANCELADA], 
FUNC.NOME_FUNC [VENDEDOR],
UPPER(ENT.DESC_ENT) [ENTREGA], 
CASE nfe_DATA.PAGAFRETE_NF_SAIDA
WHEN 'C' THEN 'CLIENTE' 
WHEN 'T' THEN 'TECHCD' END [PAGA FRETE], 
nfe_DATA.DATAEMIS_NF_SAIDA [EMISSAO],                                   
NAT.DESC_NAT [NATUREZA OPERACAO], NAT.TIPO_NF [TIPO NATURESA] ,nfe_DATA.TOTAL_NF_SAIDA [TOTAL NFE],
nfe_DATA.subst_tributaria [ST], nfe_DATA.TOTPROD_NF_SAIDA [TOTAL PRODUTO],
nfe_DATA.TOTSERV_NF_SAIDA [TOTAL SERV], nfe_DATA.IPI_NF_SAIDA [IPI] , 

CASE nfe_DATA.IMPRIMEFRETE_NF_SAIDA 
WHEN 1 THEN nfe_DATA.TOTFRETE_NF_SAIDA 
ELSE nfe_DATA.TOTFRETE_NF_SAIDA END AS [TOTAL FRETE], 

CASE 
WHEN sum(isnull(os2.tottroca_os , 0)) >
nfe_DATA.TOTPROD_NF_SAIDA + 
nfe_DATA.TOTSERV_NF_SAIDA + 
nfe_DATA.TOTFRETE_NF_SAIDA +
nfe_DATA.subst_tributaria 

THEN nfe_DATA.TOTPROD_NF_SAIDA + 
nfe_DATA.TOTSERV_NF_SAIDA + 
nfe_DATA.TOTFRETE_NF_SAIDA + 
nfe_DATA.subst_tributaria 
ELSE sum(isnull(os2.tottroca_os,0))
END [TOTAL TROCA] 

from nfe_DATA 
left join os_nf on nfe_DATA.cod_nf_saida = os_nf.cod_nf_saida 
left join os on os.cod_os = os_nf.cod_os 
left join os os2 on os.codostroca_os = os2.cod_os 
inner join clientes  as cli on cli.COD_CLI =  NFE_DATA.COD_CLI
INNER JOIN FUNCIONARIOS AS FUNC ON FUNC.COD_FUNC =  NFE_DATA.COD_VEND
INNER JOIN ENTREGAS AS ENT ON ENT.COD_ENT = NFE_DATA.COD_ENT
INNER JOIN NATUREZA_OPERACAO AS NAT ON NAT.COD_NAT = NFE_DATA.COD_NAT

Where nfe_DATA.DataEmis_NF_Saida Between @Data1 And @Data2
and os_nf.empresa_nf_saida = 'D'
and (os_nf.cod_os > 121912 or os_nf.cod_os = 120732)--Mudou série de nf 'QUE MERDA É ESSA'
group by nfe_DATA.COD_NF_SAIDA,
nfe_DATA.TIPO_NF_SAIDA, 
nfe_DATA.COD_CLI,
/*clientes.*/
CLI.NOME_CLI ,
cli.EST_CLI,
nfe_DATA.PES_CLI,
nfe_DATA.TOTFRETE_NF_SAIDA,
nfe_DATA.CANC_NF_SAIDA,
nfe_DATA.TOTAL_NF_SAIDA,
nfe_DATA.COD_VEND,
nfe_DATA.COD_ENT,             
nfe_DATA.IMPRIMEFRETE_NF_SAIDA, 
nfe_DATA.PAGAFRETE_NF_SAIDA, 
nfe_DATA.DATAEMIS_NF_SAIDA,                                     
nfe_DATA.COD_NAT,     
nfe_DATA.VALICMS_NF_SAIDA, 
nfe_DATA.VALISS_NF_SAIDA, 
nfe_DATA.subst_tributaria,
nfe_DATA.TOTPROD_NF_SAIDA,      
nfe_DATA.TOTSERV_NF_SAIDA,  
nfe_DATA.IPI_NF_SAIDA,     
nfe_DATA.TOTFRETE_NF_SAIDA,     
nfe_DATA.CANC_NF_SAIDA,
os_nf.empresa_nf_saida,
FUNC.NOME_FUNC,
NAT.DESC_NAT ,
NAT.TIPO_NF,
ENT.DESC_ENT
Order By 
nfe_DATA.COD_NF_SAIDA


