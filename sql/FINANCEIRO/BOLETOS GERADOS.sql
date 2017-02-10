select b.NumDoc_Bol as NUMERO_NFE, CONVERT(nvarchar,b.Data_Bol,103)as DATA_GERADO , b.Sac_Bol as SACADO , b.Env_Bol,
f.NOME_FUNC , CONVERT(nvarchar,b.Venc_Bol,103)as DATA_VENCIMENTO , b.CNPJ_Bol as CNPJ 
from BOLETOS_DATA_NFE as b 
inner join nfe as n  on n.COD_NF_SAIDA =  b.NumDoc_Bol
inner join FUNCIONARIOS as f on f.COD_FUNC =  n.COD_VEND
where  

b.Data_Bol between '2015-06-30'  AND '2015-07-01'
order by b.NumDoc_Bol asc 


select * from techcd.dbo.NFE_DATA where COD_NF_SAIDA = 2153
select * from techcd.dbo.ITM_NFE_SAIDA_PAGTO_DATA where COD_NF_SAIDA = 2153
select * from techcd.dbo.ITM_NFE_SAIDA_PAGTO_DATA where COD_NF_SAIDA = 2152
SELECT * FROM FORMA_PAGTO WHERE COD_FRMPAGTO = 8
SELECT * FROM TIPO_PAGTO WHERE COD_PAGTO = 3
SELECT * FROM TIPO_PAGTO WHERE COD_PAGTO = 13



UPDATE  BOLETOS_DATA_NFE  SET Data_Bol =  GETDATE()
where  
Data_Bol between '2015-06-30'  AND '2015-07-01'