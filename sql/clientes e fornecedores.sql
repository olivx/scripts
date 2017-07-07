select distinct  top 10  nfe.COD_CLI, cli.NOME_CLI , sum(TOTAL_NF_SAIDA) as TOTAL ,
cli.CID_CLI, cli.CNPJ_CLI
from nfe
inner join clientes as cli on cli.COD_CLI =  nfe.COD_CLI 
inner join NATUREZA_OPERACAO as nat on nat.COD_NAT = nfe.COD_NAT
where nfe.DATAEMIS_NF_SAIDA
between '2016-01-01' and '2016-05-10' and nat.TIPO_NF <> 'DV' and cli.CNPJ_CLI <> ''
group by nfe.COD_CLI, cli.NOME_CLI, cli.CID_CLI, cli.CNPJ_CLI
order by total desc 

select COD_CLI, NOME_CLI , CNPJ_CLI
from clientes where COD_CLI in (
select COD_CLI 
from NFE 
inner join NATUREZA_OPERACAO as nat on nat.COD_NAT = nfe.COD_NAT
where nfe.DATAEMIS_NF_SAIDA 
between '2015-10-01' and '2016-05-10' and nat.TIPO_NF = 'VE' ) and PES_CLI = 'J'


select top 10 forn.COD_FORN , forn.NOME_FORN , sum(nfe_entrada.VALTOTAL_NF_ENTRADA) Total  , 
forn.TEL1_FORN, forn.EMAIL_FORN, forn.CNPJ_FORN, forn.CONTATO_FORN
from nfe_entrada 
inner join FORNECEDORES as forn on forn.COD_FORN = nfe_entrada.COD_FORN
where DATA_EMISS
between '2016-01-01' and '2016-05-10'
group by forn.COD_FORN , forn.NOME_FORN, forn.TEL1_FORN, EMAIL_FORN,  forn.CNPJ_FORN, forn.CONTATO_FORN
order by total desc 
