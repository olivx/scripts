ALTER PROCEDURE [dbo].[SP_REL_CONTABILIDADE_CONTAS_RECEBER_MIDIA_CENTER] @INI AS DATETIME , @FIM AS DATETIME

AS
BEGIN


--MIDIA CENTER NFE =================================================================================================================== midias center 
SELECT N.COD_NF_SAIDA AS NFE,  C.NOME_CLI AS CLIENTE , ITEM.PARCNF_SAIDA_PAGTO AS PARCELA, 
ITEM.VALNF_SAIDA_PAGTO AS [VALOR SAIDA] , TP.DESC_PAGTO AS [TIPO DE PAGAMENTO ],
FP.DESC_FRMPAGTO AS [FORMA DE PAGAMENTO], 
CONVERT(NVARCHAR,ITEM.DATAVENCNF_SAIDA_PAGTO,103) AS [DATA VENCIMENTO],
CONVERT(NVARCHAR,N.DATAEMIS_NF_SAIDA,103) AS [DATA EMISSAO],
ISNULL(CONVERT(NVARCHAR,ITEM.DATAQUITNF_SAIDA_PAGTO,103),'EM ABERTO') AS [QUITADA EM]
FROM NFE_MIDIA AS N
INNER JOIN ITM_NFE_SAIDA_PAGTO_MIDIA AS ITEM ON ITEM.COD_NF_SAIDA =  N.COD_NF_SAIDA
INNER JOIN CLIENTES AS C ON C.COD_CLI =  N.COD_CLI
INNER JOIN FORMA_PAGTO AS FP ON FP.COD_FRMPAGTO = ITEM.COD_FRMPAGTO
INNER  JOIN TIPO_PAGTO AS TP ON TP.COD_PAGTO =  ITEM.COD_PAGTO
WHERE ITEM.DATAVENCNF_SAIDA_PAGTO BETWEEN @ini AND @fim  
or ITEM.DATAQUITNF_SAIDA_PAGTO BETWEEN @ini 
AND @fim and N.CANC_NF_SAIDA = 0

UNION ALL --- NOTAS ANTIGAS 

SELECT N.COD_NF_SAIDA AS NFE,  C.NOME_CLI AS CLIENTE , ITEM.PARCNF_SAIDA_PAGTO AS PARCELA, 
ITEM.VALNF_SAIDA_PAGTO AS [VALOR SAIDA] , TP.DESC_PAGTO AS [TIPO DE PAGAMENTO ],
FP.DESC_FRMPAGTO AS [FORMA DE PAGAMENTO], 
CONVERT(NVARCHAR,ITEM.DATAVENCNF_SAIDA_PAGTO,103) AS [DATA VENCIMENTO],
CONVERT(NVARCHAR,N.DATAEMIS_NF_SAIDA,103) AS [DATA EMISSAO], 
ISNULL(CONVERT(NVARCHAR,ITEM.DATAQUITNF_SAIDA_PAGTO,103),'EM ABERTO') AS [QUITADA EM]
FROM NOTAS_FISCAIS_MIDIA AS N
INNER JOIN ITM_NF_SAIDA_PAGTO_MIDIA AS ITEM ON ITEM.COD_NF_SAIDA =  N.COD_NF_SAIDA
INNER JOIN CLIENTES AS C ON C.COD_CLI =  N.COD_CLI
INNER JOIN FORMA_PAGTO AS FP ON FP.COD_FRMPAGTO = ITEM.COD_FRMPAGTO
INNER  JOIN TIPO_PAGTO AS TP ON TP.COD_PAGTO =   ITEM.COD_PAGTO
WHERE ITEM.DATAVENCNF_SAIDA_PAGTO BETWEEN @ini AND @fim  
or ITEM.DATAQUITNF_SAIDA_PAGTO BETWEEN @ini 
AND @fim and N.CANC_NF_SAIDA = 0


UNION --- NFE SERVI�O

SELECT N.COD_NF_SAIDA AS NFE,  C.NOME_CLI AS CLIENTE , ITEM.PARCNF_SAIDA_PAGTO AS PARCELA, 
ITEM.VALNF_SAIDA_PAGTO AS [VALOR SAIDA] , TP.DESC_PAGTO AS [TIPO DE PAGAMENTO ],
FP.DESC_FRMPAGTO AS [FORMA DE PAGAMENTO], 
CONVERT(NVARCHAR,ITEM.DATAVENCNF_SAIDA_PAGTO,103) AS [DATA VENCIMENTO],
CONVERT(NVARCHAR,N.DATAEMIS_NF_SAIDA,103) AS [DATA EMISSAO],
ISNULL(CONVERT(NVARCHAR,ITEM.DATAQUITNF_SAIDA_PAGTO,103),'EM ABERTO') AS [QUITADA EM]
FROM NFE_MIDIA_SRV AS N
INNER JOIN ITM_NFE_SAIDA_PAGTO_MIDIA_SRV AS ITEM ON ITEM.COD_NF_SAIDA =  N.COD_NF_SAIDA
INNER JOIN CLIENTES AS C ON C.COD_CLI =  N.COD_CLI
INNER JOIN FORMA_PAGTO AS FP ON FP.COD_FRMPAGTO = ITEM.COD_FRMPAGTO
INNER  JOIN TIPO_PAGTO AS TP ON TP.COD_PAGTO =   ITEM.COD_PAGTO
WHERE ITEM.DATAVENCNF_SAIDA_PAGTO BETWEEN @ini AND @fim  
or ITEM.DATAQUITNF_SAIDA_PAGTO BETWEEN @ini 
AND @fim and N.CANC_NF_SAIDA = 0


ORDER BY NFE ASC 




END
