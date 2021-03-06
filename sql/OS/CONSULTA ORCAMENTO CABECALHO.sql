
SELECT 
ORCA.COD_ORCA AS CODIGO ,CLI.COD_CLI AS CODIGOCLIENTE, CLI.NOME_CLI AS CLIENTE ,
FUNC.NOME_FUNC AS VENDEDOR , convert(nvarchar,ORCA.DATA_ORCA,103) AS DATAORCAMENTO ,
CONVERT(nvarchar, ORCA.VALID_ORCA ,103) AS DATAVALIDADE ,  
PG.DESC_PAGTO AS TIPOPAGAMENTO , FPG.DESC_FRMPAGTO AS FORMAPAGAMENTO  , ENT.DESC_ENT AS ENTREGA , 
ORCA.OBS_ORCA AS OBSERVACAO , ORCA.TOT_ORCA AS TOTALORCA , ORCA.FRETE_ORCA AS FRETE , 
ORCA.MULT_ORCA AS MULTORCA , ORCA.NF_ORCA AS  NOTAFISCAL , ORCA.PESOPROD_ORCA AS PESO , 
convert(nvarchar(20),CLI.CEP_CLI,null) AS CEP , 
CLI.CID_CLI  AS CIDADE  , convert(nvarchar(10),CLI.EST_CLI,null) AS ESTADO , CLI.BAIR_CLI AS BAIRRO  , 
CLI.END_CLI AS ENDERECO,
CASE ORCA.PAGAFRETE_ORCA 
WHEN  'C' THEN 'CLIENTE '
WHEN  'T' THEN 'TECHCD' 
END AS QUEMPAGAFRETE , ORCA.TROCA_ORCA AS ISTROCA, ORCA.CODOSTROCA_ORCA AS CODIGOTROCA ,  
ORCA.SUBST_TRIBUTARIA AS SUBTRIB ,
CASE ORCA.EMPRESA_ORCA 
WHEN 'T' THEN 'TECHCD' 
WHEN 'D' THEN 'DATA STORE' 
WHEN 'M' THEN 'MIDIA CENTER' 
END AS EMPRESA
FROM ORCAMENTOS AS ORCA
INNER JOIN CLIENTES AS CLI ON CLI.COD_CLI = ORCA.COD_CLI
INNER JOIN TIPO_PAGTO AS PG ON PG.COD_PAGTO = ORCA.COD_PAGTO
INNER JOIN FORMA_PAGTO AS FPG ON FPG.COD_FRMPAGTO = ORCA.COD_FRMPAGTO 
INNER JOIN FUNCIONARIOS AS FUNC ON COD_FUNC  = ORCA.COD_VEND 
INNER JOIN ENTREGAS AS ENT ON ENT.COD_ENT = ORCA.COD_ENT
WHERE ORCA.COD_ORCA =  25963


 

