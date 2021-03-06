USE [techcd]
GO
/****** Object:  StoredProcedure [dbo].[SP_REL_CONSULTOR_FATURAMENTO_HEADER]    Script Date: 02/10/2017 14:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, THIAGO OLIVEIRA>
-- Create date: <Create 02-09-2016,,>
-- Description:	<Description,,RELATORIO SOLICITANDO PELO CONSULTOR PARA DETALHAMENTO DO FATURAMETO>
-- =============================================
ALTER PROCEDURE [dbo].[SP_REL_CONSULTOR_FATURAMENTO_HEADER] 
	@INI as DATETIME,
	@FIM as DATETIME 
AS
BEGIN
	
--------------------------------------------------------------------------------------------- CABEÇALHO  TECHCD 

SELECT 'TECHCD' AS ENPRESA,  NFE.COD_NF_SAIDA AS CODIGO, CONVERT(NVARCHAR,NFE.DATAEMIS_NF_SAIDA,103) AS DATA_EMISSAO_NFE,  
OS_NF.COD_OS AS OS, CONVERT(NVARCHAR,OS.DATA2_OS,103) AS DATA_EMISSAO_OS, CLI.COD_CLI AS CODIGO_CLIENTE,
CLI.NOME_CLI AS NOME_CLIENTE, CASE 
WHEN CLI.PES_CLI = 'j' THEN CLI.CNPJ_CLI
ELSE CLI.CPF_CLI END CNPJ_CPF, NAT.DESC_NAT AS [NATUREZA DA OPERAÇÃO] ,CONTRATO.NUM_CONTRATO CODIGO_CONTRATO, 
NFE.TOTFRETE_NF_SAIDA AS VALOR_FRETE, NFE.TOTPROD_NF_SAIDA AS TOTAL_PRODUTO, NFE.TOTSERV_NF_SAIDA AS TOTAL_SERVICO, 
NFE.SUBST_TRIBUTARIA AS ST,NFE.VAL_ICMS AS ICMS, 
NFE.IPI_NF_SAIDA AS IPI, NFE.TOTAL_NF_SAIDA AS TOTAL_NFE , 
CASE 
WHEN NFE.CANC_NF_SAIDA = 0 THEN 'ATIVA'
WHEN NFE.CANC_NF_SAIDA = 1 THEN 'CANCELADA' 
END AS [STATUS NFE]
FROM NFE AS NFE 
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
INNER JOIN CLIENTES AS CLI ON CLI.COD_CLI = NFE.COD_CLI
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
LEFT JOIN CONTRATO_CLIENTE AS CONT ON CONT.COD_CLI = CLI.COD_CLI AND CONT.COD_CONTRATO = OS.COD_CONTRATO
LEFT JOIN CONTRATO AS CONTRATO ON CONTRATO.COD_CONTRATO = CONT.COD_CONTRATO
INNER JOIN NATUREZA_OPERACAO AS NAT ON NAT.COD_NAT = NFE.COD_NAT
/* consultor solicitou para retirar o filtro por data de OS */
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM /*AND OS.DAT1_OS BETWEEN @INI AND @FIM*/
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA = 'T'

UNION all 

SELECT 'TECHCD SERVIÇO' AS ENPRESA,  NFE.COD_NF_SAIDA AS CODIGO, CONVERT(NVARCHAR,NFE.DATAEMIS_NF_SAIDA,103) AS DATA_EMISSAO_NFE,  
OS_NF.COD_OS AS OS, CONVERT(NVARCHAR,OS.DATA2_OS,103) AS DATA_EMISSAO_OS, CLI.COD_CLI AS CODIGO_CLIENTE,
CLI.NOME_CLI AS NOME_CLIENTE, CASE 
WHEN CLI.PES_CLI = 'j' THEN CLI.CNPJ_CLI
ELSE CLI.CPF_CLI END CNPJ_CPF, NAT.DESC_NAT AS [NATUREZA DA OPERAÇÃO] ,CONTRATO.NUM_CONTRATO CODIGO_CONTRATO, 
NFE.TOTFRETE_NF_SAIDA AS VALOR_FRETE, NFE.TOTPROD_NF_SAIDA AS TOTAL_PRODUTO, NFE.TOTSERV_NF_SAIDA AS TOTAL_SERVICO, 
NFE.SUBST_TRIBUTARIA AS ST,NFE.VAL_ICMS AS ICMS, 
NFE.IPI_NF_SAIDA AS IPI, NFE.TOTAL_NF_SAIDA AS TOTAL_NFE , 
CASE 
WHEN NFE.CANC_NF_SAIDA = 0 THEN 'ATIVA'
WHEN NFE.CANC_NF_SAIDA = 1 THEN 'CANCELADA' 
END AS [STATUS NFE]
FROM NFE_SRV AS NFE 
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
INNER JOIN CLIENTES AS CLI ON CLI.COD_CLI = NFE.COD_CLI
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
LEFT JOIN CONTRATO_CLIENTE AS CONT ON CONT.COD_CLI = CLI.COD_CLI AND CONT.COD_CONTRATO = OS.COD_CONTRATO
LEFT JOIN CONTRATO AS CONTRATO ON CONTRATO.COD_CONTRATO = CONT.COD_CONTRATO
INNER JOIN NATUREZA_OPERACAO AS NAT ON NAT.COD_NAT = NFE.COD_NAT
/*as notas de serviço precisam manter o filtro de data por OS, senão o relatorio traz datas OS 
antigas isso por causa que o banco não esta normalizado, e como foi criado um outra tabela pra NFS comoçando
do zero ele acabaca não entendedo, houve tempo nem prioridade para esse ajuste */
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM AND OS.DATA1_OS BETWEEN @INI AND @FIM
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA = 'T'

UNION all 
--------------------------------------------------------------------------------------------------------- CABEÇALHO  MIDIA CENTER 
SELECT 'MIDIA CENTER' AS ENPRESA,  NFE.COD_NF_SAIDA AS CODIGO, 
CONVERT(NVARCHAR,NFE.DATAEMIS_NF_SAIDA,103) AS DATA_EMISSAO_NFE,  
OS_NF.COD_OS AS OS, CONVERT(NVARCHAR,OS.DATA2_OS,103) AS DATA_EMISSAO_OS, CLI.COD_CLI AS CODIGO_CLIENTE,
CLI.NOME_CLI AS NOME_CLIENTE, CASE 
WHEN CLI.PES_CLI = 'j' THEN CLI.CNPJ_CLI
ELSE CLI.CPF_CLI END CNPJ_CPF, NAT.DESC_NAT AS [NATUREZA DA OPERAÇÃO] ,CONTRATO.NUM_CONTRATO CODIGO_CONTRATO, 
NFE.TOTFRETE_NF_SAIDA AS VALOR_FRETE, NFE.TOTPROD_NF_SAIDA AS TOTAL_PRODUTO, NFE.TOTSERV_NF_SAIDA AS TOTAL_SERVICO, 
NFE.SUBST_TRIBUTARIA AS ST,NFE.VAL_ICMS AS ICMS, 
NFE.IPI_NF_SAIDA AS IPI, NFE.TOTAL_NF_SAIDA AS TOTAL_NFE , 
CASE 
WHEN NFE.CANC_NF_SAIDA = 0 THEN 'ATIVA'
WHEN NFE.CANC_NF_SAIDA = 1 THEN 'CANCELADA' 
END AS [STATUS NFE]
FROM NFE_MIDIA AS NFE 
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
INNER JOIN CLIENTES AS CLI ON CLI.COD_CLI = NFE.COD_CLI
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
LEFT JOIN CONTRATO_CLIENTE AS CONT ON CONT.COD_CLI = CLI.COD_CLI AND CONT.COD_CONTRATO = OS.COD_CONTRATO
LEFT JOIN CONTRATO AS CONTRATO ON CONTRATO.COD_CONTRATO = CONT.COD_CONTRATO
INNER JOIN NATUREZA_OPERACAO AS NAT ON NAT.COD_NAT = NFE.COD_NAT
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM /* AND OS.DATA1_OS BETWEEN @INI AND @FIM */
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA = 'M'

UNION all

SELECT 'MIDIA CENTER SERVIÇO' AS ENPRESA,  NFE.COD_NF_SAIDA AS CODIGO, 
CONVERT(NVARCHAR,NFE.DATAEMIS_NF_SAIDA,103) AS DATA_EMISSAO_NFE,  
OS_NF.COD_OS AS OS, CONVERT(NVARCHAR,OS.DATA2_OS,103) AS DATA_EMISSAO_OS, CLI.COD_CLI AS CODIGO_CLIENTE,
CLI.NOME_CLI AS NOME_CLIENTE, CASE 
WHEN CLI.PES_CLI = 'j' THEN CLI.CNPJ_CLI
ELSE CLI.CPF_CLI END CNPJ_CPF, NAT.DESC_NAT AS [NATUREZA DA OPERAÇÃO] ,CONTRATO.NUM_CONTRATO CODIGO_CONTRATO, 
NFE.TOTFRETE_NF_SAIDA AS VALOR_FRETE, NFE.TOTPROD_NF_SAIDA AS TOTAL_PRODUTO, NFE.TOTSERV_NF_SAIDA AS TOTAL_SERVICO, 
NFE.SUBST_TRIBUTARIA AS ST,NFE.VAL_ICMS AS ICMS, 
NFE.IPI_NF_SAIDA AS IPI, NFE.TOTAL_NF_SAIDA AS TOTAL_NFE , 
CASE 
WHEN NFE.CANC_NF_SAIDA = 0 THEN 'ATIVA'
WHEN NFE.CANC_NF_SAIDA = 1 THEN 'CANCELADA' 
END AS [STATUS NFE]
FROM NFE_MIDIA_SRV AS NFE 
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
INNER JOIN CLIENTES AS CLI ON CLI.COD_CLI = NFE.COD_CLI
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
LEFT JOIN CONTRATO_CLIENTE AS CONT ON CONT.COD_CLI = CLI.COD_CLI AND CONT.COD_CONTRATO = OS.COD_CONTRATO
LEFT JOIN CONTRATO AS CONTRATO ON CONTRATO.COD_CONTRATO = CONT.COD_CONTRATO
INNER JOIN NATUREZA_OPERACAO AS NAT ON NAT.COD_NAT = NFE.COD_NAT
/*as notas de serviço precisam manter o filtro de data por OS, senão o relatorio traz datas OS 
antigas isso por causa que o banco não esta normalizado, e como foi criado um outra tabela pra NFS comoçando
do zero ele acabaca não entendedo, houve tempo nem prioridade para esse ajuste */
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM AND OS.DATA1_OS BETWEEN @INI AND @FIM
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA = 'M'


UNION all 
------------------------------------------------------------------------------------------------------- CABEÇALHO  DATA STORE  
SELECT 'DATA STORE' AS ENPRESA,  NFE.COD_NF_SAIDA AS CODIGO, 
CONVERT(NVARCHAR,NFE.DATAEMIS_NF_SAIDA,103) AS DATA_EMISSAO_NFE,  
OS_NF.COD_OS AS OS, CONVERT(NVARCHAR,OS.DATA2_OS,103) AS DATA_EMISSAO_OS, CLI.COD_CLI AS CODIGO_CLIENTE,
CLI.NOME_CLI AS NOME_CLIENTE, CASE 
WHEN CLI.PES_CLI = 'j' THEN CLI.CNPJ_CLI
ELSE CLI.CPF_CLI END CNPJ_CPF, NAT.DESC_NAT AS [NATUREZA DA OPERAÇÃO] ,CONTRATO.NUM_CONTRATO CODIGO_CONTRATO, 
NFE.TOTFRETE_NF_SAIDA AS VALOR_FRETE, NFE.TOTPROD_NF_SAIDA AS TOTAL_PRODUTO, NFE.TOTSERV_NF_SAIDA AS TOTAL_SERVICO, 
NFE.SUBST_TRIBUTARIA AS ST,NFE.VAL_ICMS AS ICMS, 
NFE.IPI_NF_SAIDA AS IPI, NFE.TOTAL_NF_SAIDA AS TOTAL_NFE , 
CASE 
WHEN NFE.CANC_NF_SAIDA = 0 THEN 'ATIVA'
WHEN NFE.CANC_NF_SAIDA = 1 THEN 'CANCELADA' 
END AS [STATUS NFE]
FROM NFE_DATA AS NFE 
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
INNER JOIN CLIENTES AS CLI ON CLI.COD_CLI = NFE.COD_CLI
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
LEFT JOIN CONTRATO_CLIENTE AS CONT ON CONT.COD_CLI = CLI.COD_CLI AND CONT.COD_CONTRATO = OS.COD_CONTRATO
LEFT JOIN CONTRATO AS CONTRATO ON CONTRATO.COD_CONTRATO = CONT.COD_CONTRATO
INNER JOIN NATUREZA_OPERACAO AS NAT ON NAT.COD_NAT = NFE.COD_NAT
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM /* AND OS.DATA1_OS BETWEEN @INI AND @FIM*/ 
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA =  'D'

UNION all

SELECT 'DATA STORE SERVICO' AS ENPRESA,  NFE.COD_NF_SAIDA AS CODIGO,
 CONVERT(NVARCHAR,NFE.DATAEMIS_NF_SAIDA,103) AS DATA_EMISSAO_NFE,  
OS_NF.COD_OS AS OS, CONVERT(NVARCHAR,OS.DATA2_OS,103) AS DATA_EMISSAO_OS, CLI.COD_CLI AS CODIGO_CLIENTE,
CLI.NOME_CLI AS NOME_CLIENTE, CASE 
WHEN CLI.PES_CLI = 'j' THEN CLI.CNPJ_CLI
ELSE CLI.CPF_CLI END CNPJ_CPF, NAT.DESC_NAT AS [NATUREZA DA OPERAÇÃO] ,CONTRATO.NUM_CONTRATO CODIGO_CONTRATO, 
NFE.TOTFRETE_NF_SAIDA AS VALOR_FRETE, NFE.TOTPROD_NF_SAIDA AS TOTAL_PRODUTO, NFE.TOTSERV_NF_SAIDA AS TOTAL_SERVICO, 
NFE.SUBST_TRIBUTARIA AS ST,NFE.VAL_ICMS AS ICMS, 
NFE.IPI_NF_SAIDA AS IPI, NFE.TOTAL_NF_SAIDA AS TOTAL_NFE , 
CASE 
WHEN NFE.CANC_NF_SAIDA = 0 THEN 'ATIVA'
WHEN NFE.CANC_NF_SAIDA = 1 THEN 'CANCELADA' 
END AS [STATUS NFE]
FROM NFE_DATA_SRV AS NFE 
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
INNER JOIN CLIENTES AS CLI ON CLI.COD_CLI = NFE.COD_CLI
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
LEFT JOIN CONTRATO_CLIENTE AS CONT ON CONT.COD_CLI = CLI.COD_CLI AND CONT.COD_CONTRATO = OS.COD_CONTRATO
LEFT JOIN CONTRATO AS CONTRATO ON CONTRATO.COD_CONTRATO = CONT.COD_CONTRATO
INNER JOIN NATUREZA_OPERACAO AS NAT ON NAT.COD_NAT = NFE.COD_NAT
/*as notas de serviço precisam manter o filtro de data por OS, senão o relatorio traz datas OS 
antigas isso por causa que o banco não esta normalizado, e como foi criado um outra tabela pra NFS comoçando
do zero ele acabaca não entendedo, houve tempo nem prioridade para esse ajuste */
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM AND OS.DATA1_OS BETWEEN @INI AND @FIM 
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA = 'D'


order by  nfe.COD_NF_SAIDA asc 


/***
------------------------------------------------------------------------------------------------------------------ITEMS DAS NOTAS 

--------------------------------------------------------------------- TECHCD 

SELECT 'TECHCD' AS ENPRESA, ITEM.COD_NF_SAIDA ,CASE 
WHEN ITEM.COD_PROD = 0 THEN ITEM.COD_SERV 
ELSE ITEM.COD_PROD END SERVICO_PRODUTO,  
CASE WHEN ITEM.COD_PROD = 0 THEN SERV.DESC_SERV ELSE PROD.DESC_PROD END DESCRICAO_SERVICO_PRODUTO,  
CASE WHEN ITEM.COD_PROD = 0 THEN 'SERVICO' ELSE 'PRODUTO' END TIPO_PRODUTO_SERVICO,  
ITEM.QTDE_NF_SAIDA AS QUANTIDADE, ITEM.VALOR_NF_SAIDA AS VALOR_UNITARIO,
(ITEM.QTDE_NF_SAIDA * ITEM.VALOR_NF_SAIDA -  ITEM.DESCONTO_NF_SAIDA) AS VALOR_TOTAL_DO_ITEM
FROM ITM_NFE_SAIDA AS ITEM 
INNER JOIN NFE AS NFE ON NFE.COD_NF_SAIDA =  ITEM.COD_NF_SAIDA
LEFT JOIN PRODUTOS AS PROD ON PROD.COD_PROD = ITEM.COD_PROD
LEFT JOIN SERVICOS AS SERV ON SERV.COD_SERV = ITEM.COD_SERV
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM AND OS.DATA2_OS BETWEEN @INI AND @FIM 
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA = 'T'


UNION ALL 

SELECT 'TECHCD SERVIÇO' AS ENPRESA, ITEM.COD_NF_SAIDA ,CASE 
WHEN ITEM.COD_PROD = 0 THEN ITEM.COD_SERV 
ELSE ITEM.COD_PROD END SERVICO_PRODUTO,  
CASE WHEN ITEM.COD_PROD = 0 THEN SERV.DESC_SERV ELSE PROD.DESC_PROD END DESCRICAO_SERVICO_PRODUTO,
CASE WHEN ITEM.COD_PROD = 0 THEN 'SERVICO' ELSE 'PRODUTO' END TIPO_PRODUTO_SERVICO,  
ITEM.QTDE_NF_SAIDA AS QUANTIDADE, ITEM.VALOR_NF_SAIDA AS VALOR_UNITARIO,
(ITEM.QTDE_NF_SAIDA * ITEM.VALOR_NF_SAIDA -  ITEM.DESCONTO_NF_SAIDA) AS VALOR_TOTAL_DO_ITEM
FROM ITM_NFE_SAIDA_SRV AS ITEM 
INNER JOIN NFE_SRV AS NFE ON NFE.COD_NF_SAIDA =  ITEM.COD_NF_SAIDA
LEFT JOIN PRODUTOS AS PROD ON PROD.COD_PROD = ITEM.COD_PROD
LEFT JOIN SERVICOS AS SERV ON SERV.COD_SERV = ITEM.COD_SERV
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM AND OS.DATA2_OS BETWEEN @INI AND @FIM 
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA = 'T'

UNION ALL 
-------------------------------------------------------------------------- DATA STORE
SELECT 'DATA STORE' AS ENPRESA, ITEM.COD_NF_SAIDA ,CASE 
WHEN ITEM.COD_PROD = 0 THEN ITEM.COD_SERV 
ELSE ITEM.COD_PROD END SERVICO_PRODUTO,  
CASE WHEN ITEM.COD_PROD = 0 THEN SERV.DESC_SERV ELSE PROD.DESC_PROD END DESCRICAO_SERVICO_PRODUTO,  
CASE WHEN ITEM.COD_PROD = 0 THEN 'SERVICO' ELSE 'PRODUTO' END TIPO_PRODUTO_SERVICO,  
ITEM.QTDE_NF_SAIDA AS QUANTIDADE, ITEM.VALOR_NF_SAIDA AS VALOR_UNITARIO,
(ITEM.QTDE_NF_SAIDA * ITEM.VALOR_NF_SAIDA -  ITEM.DESCONTO_NF_SAIDA) AS VALOR_TOTAL_DO_ITEM
FROM ITM_NFE_SAIDA_DATA AS ITEM 
INNER JOIN NFE_DATA AS NFE ON NFE.COD_NF_SAIDA =  ITEM.COD_NF_SAIDA
LEFT JOIN PRODUTOS AS PROD ON PROD.COD_PROD = ITEM.COD_PROD
LEFT JOIN SERVICOS AS SERV ON SERV.COD_SERV = ITEM.COD_SERV
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM AND OS.DATA2_OS BETWEEN @INI AND @FIM 
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA = 'D'

UNION ALL 

SELECT 'DATA STORE SERVIÇO' AS ENPRESA, ITEM.COD_NF_SAIDA ,CASE 
WHEN ITEM.COD_PROD = 0 THEN ITEM.COD_SERV 
ELSE ITEM.COD_PROD END SERVICO_PRODUTO,  
CASE WHEN ITEM.COD_PROD = 0 THEN SERV.DESC_SERV ELSE PROD.DESC_PROD END DESCRICAO_SERVICO_PRODUTO,
CASE WHEN ITEM.COD_PROD = 0 THEN 'SERVICO' ELSE 'PRODUTO' END TIPO_PRODUTO_SERVICO,  
ITEM.QTDE_NF_SAIDA AS QUANTIDADE, ITEM.VALOR_NF_SAIDA AS VALOR_UNITARIO,
(ITEM.QTDE_NF_SAIDA * ITEM.VALOR_NF_SAIDA -  ITEM.DESCONTO_NF_SAIDA) AS VALOR_TOTAL_DO_ITEM
FROM ITM_NFE_SAIDA_DATA_SRV AS ITEM 
INNER JOIN NFE_DATA_SRV AS NFE ON NFE.COD_NF_SAIDA =  ITEM.COD_NF_SAIDA
LEFT JOIN PRODUTOS AS PROD ON PROD.COD_PROD = ITEM.COD_PROD
LEFT JOIN SERVICOS AS SERV ON SERV.COD_SERV = ITEM.COD_SERV
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM AND OS.DATA2_OS BETWEEN @INI AND @FIM 
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA = 'D'

UNION ALL 
-------------------------------------------------------------------------------------- MIDIA CENTER 
SELECT 'MIDIA CENTER' AS ENPRESA, ITEM.COD_NF_SAIDA ,CASE 
WHEN ITEM.COD_PROD = 0 THEN ITEM.COD_SERV 
ELSE ITEM.COD_PROD END SERVICO_PRODUTO,  
CASE WHEN ITEM.COD_PROD = 0 THEN SERV.DESC_SERV ELSE PROD.DESC_PROD END DESCRICAO_SERVICO_PRODUTO,  
CASE WHEN ITEM.COD_PROD = 0 THEN 'SERVICO' ELSE 'PRODUTO' END TIPO_PRODUTO_SERVICO,  
ITEM.QTDE_NF_SAIDA AS QUANTIDADE, ITEM.VALOR_NF_SAIDA AS VALOR_UNITARIO,
(ITEM.QTDE_NF_SAIDA * ITEM.VALOR_NF_SAIDA -  ITEM.DESCONTO_NF_SAIDA) AS VALOR_TOTAL_DO_ITEM
FROM ITM_NFE_SAIDA_MIDIA AS ITEM 
INNER JOIN NFE_MIDIA AS NFE ON NFE.COD_NF_SAIDA =  ITEM.COD_NF_SAIDA
LEFT JOIN PRODUTOS AS PROD ON PROD.COD_PROD = ITEM.COD_PROD
LEFT JOIN SERVICOS AS SERV ON SERV.COD_SERV = ITEM.COD_SERV
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM AND OS.DATA2_OS BETWEEN @INI AND @FIM 
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA = 'M'

UNION ALL 

SELECT 'MIDIA CENTER SERVIÇO' AS ENPRESA, ITEM.COD_NF_SAIDA ,CASE 
WHEN ITEM.COD_PROD = 0 THEN ITEM.COD_SERV 
ELSE ITEM.COD_PROD END SERVICO_PRODUTO,  
CASE WHEN ITEM.COD_PROD = 0 THEN SERV.DESC_SERV ELSE PROD.DESC_PROD END DESCRICAO_SERVICO_PRODUTO,
CASE WHEN ITEM.COD_PROD = 0 THEN 'SERVICO' ELSE 'PRODUTO' END TIPO_PRODUTO_SERVICO,  
ITEM.QTDE_NF_SAIDA AS QUANTIDADE, ITEM.VALOR_NF_SAIDA AS VALOR_UNITARIO,
(ITEM.QTDE_NF_SAIDA * ITEM.VALOR_NF_SAIDA -  ITEM.DESCONTO_NF_SAIDA) AS VALOR_TOTAL_DO_ITEM
FROM ITM_NFE_SAIDA_MIDIA_SRV AS ITEM 
INNER JOIN NFE_MIDIA_SRV AS NFE ON NFE.COD_NF_SAIDA =  ITEM.COD_NF_SAIDA
LEFT JOIN PRODUTOS AS PROD ON PROD.COD_PROD = ITEM.COD_PROD
LEFT JOIN SERVICOS AS SERV ON SERV.COD_SERV = ITEM.COD_SERV
LEFT JOIN OS_NF AS OS_NF ON OS_NF.COD_NF_SAIDA = NFE.COD_NF_SAIDA
LEFT JOIN OS ON OS.COD_OS = OS_NF.COD_OS
WHERE NFE.DATAEMIS_NF_SAIDA BETWEEN @INI AND @FIM AND OS.DATA2_OS BETWEEN @INI AND @FIM 
AND OS_NF.MODELO_NF = 'N' AND OS_NF.EMPRESA_NF_SAIDA = 'M'

ORDER BY ITEM.COD_NF_SAIDA

*/

END
