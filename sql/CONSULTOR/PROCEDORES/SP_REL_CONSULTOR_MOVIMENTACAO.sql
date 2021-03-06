-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  SP_REL_CONSULTOR_MOVIMENTACAO 
	-- Add the parameters for the stored procedure here
	@STARTER  DATETIME ,
	@FINISH   DATETIME 
AS
BEGIN
	



SELECT cod_prod AS [CODIGO] , cod_ref AS [REFERENCIA], MOVIMENTACAO_TECHCD.QTDE_MOV, 
CASE STATUS_MOV  
WHEN 'S' THEN 'SAIDA' 
WHEN 'E' THEN 'ENTRADA'
WHEN 'A' THEN 'AJUSTE'
WHEN 'C' THEN 'CANCELADO'
WHEN 'T' THEN 'TROCA' 
WHEN 'M' THEN 'AMOSTRA'
WHEN 'R' THEN 'REJEITADO' 
WHEN 'I' THEN 'USO INTERNO'
WHEN 'K' THEN 'SILK' 
WHEN 'D' THEN 'DEVOLU플O'
WHEN 'W' THEN 'TRANS MIDIA'
WHEN 'X' THEN 'TRANS DATA' 
WHEN 'Z' THEN 'TRANS TECHCD'
WHEN 'Y' THEN 'TRANSFERENCIA'
END AS [STATUS] , 
CONVERT(NVARCHAR, DATA_MOV, 103)  as [MOVIMENTA플O] , 'TECHCD'AS [EMPRESA] from MOVIMENTACAO_TECHCD
WHERE DATA_MOV BETWEEN  @STARTER AND @FINISH

UNION 
SELECT cod_prod AS [CODIGO] , cod_ref AS [REFERENCIA],  MOVIMENTACAO_DATASTORE.QTDE_MOV, 
CASE STATUS_MOV  
WHEN 'S' THEN 'SAIDA' 
WHEN 'E' THEN 'ENTRADA'
WHEN 'A' THEN 'AJUSTE'
WHEN 'C' THEN 'CANCELADO'
WHEN 'T' THEN 'TROCA' 
WHEN 'M' THEN 'AMOSTRA'
WHEN 'R' THEN 'REJEITADO' 
WHEN 'I' THEN 'USO INTERNO'
WHEN 'K' THEN 'SILK' 
WHEN 'D' THEN 'DEVOLU플O'
WHEN 'W' THEN 'TRANS MIDIA'
WHEN 'X' THEN 'TRANS DATA' 
WHEN 'Z' THEN 'TRANS TECHCD'
WHEN 'Y' THEN 'TRANSFERENCIA'
END AS [STATUS] , 
CONVERT(NVARCHAR, DATA_MOV, 103)  as [MOVIMENTA플O] , 'DATA STORE'AS [EMPRESA] from MOVIMENTACAO_DATASTORE
WHERE DATA_MOV BETWEEN  @STARTER AND @FINISH

UNION 
SELECT cod_prod AS [CODIGO] , cod_ref AS [REFERENCIA], MOVIMENTACAO_MIDIACENTER.QTDE_MOV, 
CASE STATUS_MOV  
WHEN 'S' THEN 'SAIDA' 
WHEN 'E' THEN 'ENTRADA'
WHEN 'A' THEN 'AJUSTE'
WHEN 'C' THEN 'CANCELADO'
WHEN 'T' THEN 'TROCA' 
WHEN 'M' THEN 'AMOSTRA'
WHEN 'R' THEN 'REJEITADO' 
WHEN 'I' THEN 'USO INTERNO'
WHEN 'K' THEN 'SILK' 
WHEN 'D' THEN 'DEVOLU플O'
WHEN 'W' THEN 'TRANS MIDIA'
WHEN 'X' THEN 'TRANS DATA' 
WHEN 'Z' THEN 'TRANS TECHCD'
WHEN 'Y' THEN 'TRANSFERENCIA'
END AS [STATUS] , 
CONVERT(NVARCHAR, DATA_MOV, 103)  as [MOVIMENTA플O] , 'MIDIA CENTER'AS [EMPRESA] from MOVIMENTACAO_MIDIACENTER
WHERE DATA_MOV BETWEEN  @STARTER AND @FINISH



	
END
GO
