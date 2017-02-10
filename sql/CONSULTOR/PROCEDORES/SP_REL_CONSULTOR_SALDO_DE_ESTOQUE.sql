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
CREATE PROCEDURE SP_REL_CONSULTOR_SALDO_DE_ESTOQUE
	-- Add the parameters for the stored procedure here
	@periodo DATETIME
AS
BEGIN

SELECT convert(nvarchar,@periodo,103) as PERIODO, 
'TECHCD' AS EMPRESA ,
m.COD_PROD AS CODIGO,
UPPER(P.DESC_PROD) AS [DESCRIÇÃO PRODUTO] ,
cat.COD_CAT  AS [COD CATEGORIA], 
cat.DESC_CAT AS [DESC CATEGORIA], 
g.COD_GRUPO AS [COD GRUPO],
g.DESC_GRUPO AS [DESC GRUPO],
convert(nvarchar,r.MaxTime,103) AS [ULTIMA MOVIMENTACAO],
M.SALDOTECH_MOV AS [SALDO TECH],
p.CUSTO_PROD AS [CUSTO PROD],
p.CUSTOREF_PROD AS [CUSTO REFERENCIA],
p.MED_PROD AS [MEDIA PROD],
max(pc.IMP_PRE) as [VALOR UNIT] 
FROM (SELECT cod_prod, MAX(DATA_MOV) as MaxTime
      FROM MOVIMENTACAO_TECHCD where DATA_MOV < @periodo
      GROUP BY COD_PROD) r
INNER JOIN MOVIMENTACAO_TECHCD m ON m.COD_PROD = r.COD_PROD AND m.DATA_MOV = r.MaxTime
inner join PRODUTOS as p on p.COD_PROD = m.COD_PROD 
inner join PRODUTOS_QTDE as pq on pq.COD_PROD = m.COD_PROD 
inner join PRECOS_PROD as pc on pc.COD_PROD =  m.COD_PROD
inner join CATEGORIAS AS cat on cat.COD_CAT = p.COD_CAT
inner join GRUPO_PRODUTOS as g on g.COD_GRUPO =  p.COD_GRUPO
where m.SALDOTECH_MOV > 0  and m.COD_PROD >  10008 
and p.COD_CAT <> 29 and p.COD_CAT <> 57
group by m.COD_PROD, r.MaxTime , p.DESC_PROD  ,M.SALDOTECH_MOV , p.CLASSITRIB_PROD, 
p.COD_CAT, cat.DESC_CAT, cat.COD_SUPERCAT, g.COD_GRUPO, g.DESC_GRUPO ,  p.CUSTO_PROD,
p.CUSTOREF_PROD, p.MED_PROD , cat.COD_CAT

UNION ALL 

-- MIDIA
SELECT convert(nvarchar,@periodo,103) as PERIODO, 
'MIDIA' AS EMPRESA ,
m.COD_PROD AS CODIGO,
UPPER(P.DESC_PROD) AS [DESCRIÇÃO PRODUTO] ,
cat.COD_CAT  AS [COD CATEGORIA], 
cat.DESC_CAT AS [DESC CATEGORIA], 
g.COD_GRUPO AS [COD GRUPO],
g.DESC_GRUPO AS [DESC GRUPO],
convert(nvarchar,r.MaxTime,103) AS [ULTIMA MOVIMENTACAO],
M.SALDOMIDIA_MOV AS [SALDO TECH],
p.CUSTO_PROD AS [CUSTO PROD],
p.CUSTOREF_PROD AS [CUSTO REFERENCIA],
p.MED_PROD AS [MEDIA PROD],
max(pc.IMP_PRE) as [VALOR UNIT] 
FROM (SELECT cod_prod, MAX(DATA_MOV) as MaxTime
      FROM MOVIMENTACAO_MIDIACENTER where DATA_MOV < @periodo
      GROUP BY COD_PROD) r
INNER JOIN MOVIMENTACAO_MIDIACENTER m ON m.COD_PROD = r.COD_PROD AND m.DATA_MOV = r.MaxTime
inner join PRODUTOS as p on p.COD_PROD = m.COD_PROD 
inner join PRODUTOS_QTDE as pq on pq.COD_PROD = m.COD_PROD 
inner join PRECOS_PROD as pc on pc.COD_PROD =  m.COD_PROD
inner join CATEGORIAS AS cat on cat.COD_CAT = p.COD_CAT
inner join GRUPO_PRODUTOS as g on g.COD_GRUPO = p.COD_GRUPO
where m.SALDOMIDIA_MOV > 0  and m.COD_PROD >  10008 
and p.COD_CAT <> 29 and p.COD_CAT <> 57
group by m.COD_PROD, r.MaxTime , p.DESC_PROD  ,M.SALDOMIDIA_MOV , p.CLASSITRIB_PROD, 
p.COD_CAT, cat.DESC_CAT, cat.COD_SUPERCAT, g.COD_GRUPO, g.DESC_GRUPO ,  p.CUSTO_PROD,
p.CUSTOREF_PROD, p.MED_PROD , cat.COD_CAT

UNION ALL 

--DATA
SELECT convert(nvarchar,@periodo,103) as PERIODO, 
'DATA' AS EMPRESA ,
m.COD_PROD AS CODIGO,
UPPER(P.DESC_PROD) AS [DESCRIÇÃO PRODUTO] ,
cat.COD_CAT  AS [COD CATEGORIA], 
cat.DESC_CAT AS [DESC CATEGORIA], 
g.COD_GRUPO AS [COD GRUPO],
g.DESC_GRUPO AS [DESC GRUPO],
convert(nvarchar,r.MaxTime,103) AS [ULTIMA MOVIMENTACAO],
M.SALDODATA_MOV AS [SALDO TECH],
p.CUSTO_PROD AS [CUSTO PROD],
p.CUSTOREF_PROD AS [CUSTO REFERENCIA],
p.MED_PROD AS [MEDIA PROD],
max(pc.IMP_PRE) as [VALOR UNIT] 
FROM (SELECT cod_prod, MAX(DATA_MOV) as MaxTime
      FROM MOVIMENTACAO_DATASTORE where DATA_MOV < @periodo
      GROUP BY COD_PROD) r
INNER JOIN MOVIMENTACAO_DATASTORE m ON m.COD_PROD = r.COD_PROD AND m.DATA_MOV = r.MaxTime
inner join PRODUTOS as p on p.COD_PROD = m.COD_PROD 
inner join PRODUTOS_QTDE as pq on pq.COD_PROD = m.COD_PROD 
inner join PRECOS_PROD as pc on pc.COD_PROD =  m.COD_PROD
inner join CATEGORIAS AS cat on cat.COD_CAT = p.COD_CAT
inner join GRUPO_PRODUTOS as g on g.COD_GRUPO = p.COD_GRUPO
where m.SALDODATA_MOV > 0  and m.COD_PROD >  10008 
and p.COD_CAT <> 29 and p.COD_CAT <> 57
group by m.COD_PROD, r.MaxTime , p.DESC_PROD  ,M.SALDODATA_MOV , p.CLASSITRIB_PROD, 
p.COD_CAT, cat.DESC_CAT, cat.COD_SUPERCAT, g.COD_GRUPO, g.DESC_GRUPO ,  p.CUSTO_PROD,
p.CUSTOREF_PROD, p.MED_PROD , cat.COD_CAT





END
GO
