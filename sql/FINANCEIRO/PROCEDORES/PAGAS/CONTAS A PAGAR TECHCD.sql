
CREATE PROCEDURE SP_REL_CONTABILIDADE_CONTAS_PAGAR_TECHCD
		@INI AS datetime, 
		@FIM AS datetime 
AS

BEGIN
	--Contas a Pagar
----NFE	FORNECEDOR	EMISSAO	VENCIMENTO	 VALOR
--- TECHCD 

SELECT NFE.COD_NF_ENTRADA AS NFE, F.NOME_FORN AS FORNECEDOR  , 
CONVERT(NVARCHAR,NFE.DATA_EMISS,103) AS EMISSAO , 
CONVERT(NVARCHAR,ITM.VENC_PARC,103) AS VENCIMENTO, ITM.VAL_PARC AS PARCELA 
FROM nfe_entrada AS NFE  
INNER JOIN FORNECEDORES AS F ON F.COD_FORN = NFE.COD_FORN
INNER JOIN itm_nfe_entrada_PAGTO AS ITM ON ITM.COD_NF_ENTRADA =  NFE.COD_NF_ENTRADA
WHERE nfe.DATA_EMISS BETWEEN @INI AND @FIM 
ORDER BY ITM.VENC_PARC

END
GO
