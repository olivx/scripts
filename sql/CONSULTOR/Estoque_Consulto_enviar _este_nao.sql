USE techcd
declare  @periodo as datetime = '2016-06-30'
/*
declare  @id as int = 0

CREATE TABLE #tempdata (
  ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  DATA DATETIME 
);

INSERT #tempdata(DATA) VALUES('2014-01-28')
INSERT #tempdata(DATA) VALUES('2014-02-28')
INSERT #tempdata(DATA) VALUES('2014-03-28')
INSERT #tempdata(DATA) VALUES('2014-04-28')
INSERT #tempdata(DATA) VALUES('2014-05-28')
INSERT #tempdata(DATA) VALUES('2014-06-28')
INSERT #tempdata(DATA) VALUES('2014-07-28')
INSERT #tempdata(DATA) VALUES('2014-08-28')
INSERT #tempdata(DATA) VALUES('2014-09-28')
INSERT #tempdata(DATA) VALUES('2014-10-28')
INSERT #tempdata(DATA) VALUES('2014-11-28')
INSERT #tempdata(DATA) VALUES('2014-12-28')


WHILE EXISTS (SELECT * FROM #tempdata)
BEGIN 

SELECT TOP 1 @periodo  = #tempdata.DATA , @id =  #tempdata.ID FROM  #tempdata
*/
--TECHCD 
SELECT m.COD_PROD AS CODIGO,
UPPER(P.DESC_PROD) AS [DESCRIÇÃO PRODUTO] , 
M.SALDOTECH_MOV AS [SALDO TECH],
max(pc.IMP_PRE) as [VALOR UNIT] ,
m.SALDOTECH_MOV * min(pc.IMP_PRE) as [VALOR TOTAL], 
convert(nvarchar,r.MaxTime,103) AS [ULTIMA MOVIMENTACAO] , 
p.CLASSITRIB_PROD as NCM , 
p.COD_CAT, cat.DESC_CAT,
cat.COD_SUPERCAT, g.COD_GRUPO, 
g.DESC_GRUPO
FROM (SELECT cod_prod, MAX(DATA_MOV) as MaxTime
      FROM MOVIMENTACAO_TECHCD where DATA_MOV < @periodo
      GROUP BY COD_PROD) r
INNER JOIN MOVIMENTACAO_TECHCD m ON m.COD_PROD = r.COD_PROD AND m.DATA_MOV = r.MaxTime
inner join PRODUTOS as p on p.COD_PROD = m.COD_PROD 
left join PRODUTOS_QTDE as pq on pq.COD_PROD = m.COD_PROD 
left join PRECOS_PROD as pc on pc.COD_PROD =  m.COD_PROD
left join CATEGORIAS AS cat on cat.COD_CAT = p.COD_CAT
left join GRUPO_PRODUTOS as g on g.COD_GRUPO =  p.COD_GRUPO
where m.SALDOTECH_MOV > 0  and m.COD_PROD >  10008 
and p.COD_CAT <> 29 and p.COD_CAT <> 57
group by m.COD_PROD, r.MaxTime , p.DESC_PROD  ,M.SALDOTECH_MOV , p.CLASSITRIB_PROD, 
p.COD_CAT, cat.DESC_CAT, cat.COD_SUPERCAT, g.COD_GRUPO, g.DESC_GRUPO
order by m.COD_PROD asc 



USE techcd

--MIDIA 
SELECT m.COD_PROD AS CODIGO,
UPPER(P.DESC_PROD) AS [DESCRIÇÃO PRODUTO] , 
M.SALDOMIDIA_MOV AS [SALDO MIDIA],
min(pc.IMP_PRE) as [VALOR UNIT] ,
m.SALDOMIDIA_MOV * min(pc.IMP_PRE) as [VALOR TOTAL], 
convert(nvarchar,r.MaxTime,103) AS [ULTIMA MOVIMENTACAO] , 
p.CLASSITRIB_PROD as NCM , 
p.COD_CAT, cat.DESC_CAT,
cat.COD_SUPERCAT, g.COD_GRUPO, 
g.DESC_GRUPO
FROM (SELECT cod_prod, MAX(DATA_MOV) as MaxTime
      FROM MOVIMENTACAO_MIDIACENTER where DATA_MOV < @periodo
      GROUP BY COD_PROD) r
INNER JOIN MOVIMENTACAO_MIDIACENTER m ON m.COD_PROD = r.COD_PROD AND m.DATA_MOV = r.MaxTime
inner join PRODUTOS as p on p.COD_PROD = m.COD_PROD 
left join PRODUTOS_QTDE as pq on pq.COD_PROD = m.COD_PROD 
left join PRECOS_PROD as pc on pc.COD_PROD =  m.COD_PROD
left join CATEGORIAS AS cat on cat.COD_CAT = p.COD_CAT
left join GRUPO_PRODUTOS as g on g.COD_GRUPO = p.COD_GRUPO
where m.SALDOMIDIA_MOV > 0  and m.COD_PROD >  10008 
and p.COD_CAT <> 29 and p.COD_CAT <> 57
group by m.COD_PROD, r.MaxTime , p.DESC_PROD  ,M.SALDOMIDIA_MOV , p.CLASSITRIB_PROD, 
p.COD_CAT, cat.DESC_CAT, cat.COD_SUPERCAT, g.COD_GRUPO, g.DESC_GRUPO
order by m.COD_PROD asc 


USE techcd

--DATA
SELECT m.COD_PROD AS CODIGO,
UPPER(P.DESC_PROD) AS [DESCRIÇÃO PRODUTO] , 
M.SALDODATA_MOV AS [SALDO DATA],
min(pc.IMP_PRE) as [VALOR UNIT] ,
m.SALDODATA_MOV * min(pc.IMP_PRE) as [VALOR TOTAL], 
convert(nvarchar,r.MaxTime,103) AS [ULTIMA MOVIMENTACAO] , 
p.CLASSITRIB_PROD as NCM , 
p.COD_CAT, cat.DESC_CAT,
cat.COD_SUPERCAT, g.COD_GRUPO, 
g.DESC_GRUPO
FROM (SELECT cod_prod, MAX(DATA_MOV) as MaxTime
      FROM MOVIMENTACAO_DATASTORE where DATA_MOV < @periodo
      GROUP BY COD_PROD) r
INNER JOIN MOVIMENTACAO_DATASTORE m ON m.COD_PROD = r.COD_PROD AND m.DATA_MOV = r.MaxTime
inner join PRODUTOS as p on p.COD_PROD = m.COD_PROD 
left join PRODUTOS_QTDE as pq on pq.COD_PROD = m.COD_PROD 
left join PRECOS_PROD as pc on pc.COD_PROD =  m.COD_PROD
left join CATEGORIAS AS cat on cat.COD_CAT = p.COD_CAT
left join GRUPO_PRODUTOS as g on g.COD_GRUPO = p.COD_GRUPO
where m.SALDODATA_MOV > 0  and m.COD_PROD >  10008 
and p.COD_CAT <> 29 and p.COD_CAT <> 57
group by m.COD_PROD, r.MaxTime , p.DESC_PROD  ,M.SALDODATA_MOV , p.CLASSITRIB_PROD, 
p.COD_CAT, cat.DESC_CAT, cat.COD_SUPERCAT, g.COD_GRUPO, g.DESC_GRUPO
order by m.COD_PROD asc 

/*
     DELETE FROM #tempdata WHERE ID = @ID
END 


--drop table #tempdata-->
*/