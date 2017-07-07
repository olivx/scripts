USE techcd

SELECT m.COD_PROD AS [Codigo Produto],
UPPER(P.DESC_PROD) AS [Descrição do ProdutoO], 
'' AS [UNIDADE],
P.CLASSITRIB_PROD AS [NCM], 
M.SALDOTECH_MOV AS [Saldo em Estoque],
min(pc.IMP_PRE) as [Valor Unitario] ,
m.SALDOTECH_MOV * min(pc.IMP_PRE) as [Valor Total],
'41022002' AS [Código Conta Contábil],
'Estoque de material para revenda'  AS [Descrição Conta Contábil],
'1' AS [Natureza*],
'11801' AS [Código do Plano de Conta Superior],
'1' AS [Nível],
'000'AS [CST ICMS],
m.SALDOTECH_MOV * min(pc.IMP_PRE) AS [Base de Cálculo],
convert(money,(m.SALDOTECH_MOV * min(pc.IMP_PRE)) * 0.18,103) AS [Valor ICMS]

FROM (SELECT cod_prod, MAX(DATA_MOV) as MaxTime
      FROM MOVIMENTACAO_TECHCD where DATA_MOV < '2015-12-31'
      GROUP BY COD_PROD) r
INNER JOIN MOVIMENTACAO_TECHCD m ON m.COD_PROD = r.COD_PROD AND m.DATA_MOV = r.MaxTime
inner join PRODUTOS as p on p.COD_PROD = m.COD_PROD 
inner join PRODUTOS_QTDE as pq on pq.COD_PROD = m.COD_PROD 
inner join PRECOS_PROD as pc on pc.COD_PROD =  m.COD_PROD
where m.SALDOTECH_MOV > 0  and m.COD_PROD >  10008 
and p.COD_CAT <> 29 and p.COD_CAT <> 57
group by m.COD_PROD, r.MaxTime , p.DESC_PROD  ,M.SALDOTECH_MOV , p.CLASSITRIB_PROD, P.ICMS_REDUZIDO
order by m.COD_PROD asc 


