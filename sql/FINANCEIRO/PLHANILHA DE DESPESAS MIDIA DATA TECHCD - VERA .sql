use techcd

declare @DATA_INI datetime;
declare @DATA_FIM datetime;
set @DATA_INI = '1999-01-01 00:00:00'
set @DATA_FIM = '2016-08-01 23:59:59'
 

--------------------------------------------------------------------------------------------------------------------- MIDIA 
SELECT cp.COD_DESP , CP.NUMDOC_PAGAR , DESP.DESC_DESP , TP.DESC_PAGTO , FP.DESC_FRMPAGTO , 
BANCOS.DESC_BANCO , CP.VALORPREV_PAGAR , CP.VALORREAL_PAGAR , CP.QUEMQUIT_PAGAR ,
convert(nvarchar,CP.DATAVENC_PAGAR,103) as VENCIMENTO, convert(nvarchar,CP.DATAQUIT_PAGAR,103) AS QUITA��O 
FROM  CONTAS_PAGAR_MIDIA AS CP
INNER JOIN DESPESAS AS DESP ON DESP.COD_DESP = CP.COD_DESP
INNER JOIN TIPO_PAGTO AS TP ON TP.COD_PAGTO =  CP.COD_PAGTO
INNER JOIN FORMA_PAGTO AS FP ON FP.COD_FRMPAGTO = CP.COD_FRMPAGTO
INNER JOIN BANCOS ON BANCOS.COD_BANCO = CP.COD_BANCO 
WHERE CP.DATAVENC_PAGAR BETWEEN @DATA_INI AND  @DATA_FIM
order BY CP.DATAVENC_PAGAR ASC 

--------------------------------------------------------------------------------------------------------------------DATA
SELECT cp.COD_DESP , CP.NUMDOC_PAGAR,  DESP.DESC_DESP , TP.DESC_PAGTO , FP.DESC_FRMPAGTO , 
BANCOS.DESC_BANCO , CP.VALORPREV_PAGAR , CP.VALORREAL_PAGAR , CP.QUEMQUIT_PAGAR ,
convert(nvarchar,CP.DATAVENC_PAGAR,103) AS VENCIMENTO, convert(nvarchar,CP.DATAQUIT_PAGAR,103) AS QUITA��O 
FROM  CONTAS_PAGAR_DATA AS CP
INNER JOIN DESPESAS AS DESP ON DESP.COD_DESP = CP.COD_DESP
INNER JOIN TIPO_PAGTO AS TP ON TP.COD_PAGTO =  CP.COD_PAGTO
INNER JOIN FORMA_PAGTO AS FP ON FP.COD_FRMPAGTO = CP.COD_FRMPAGTO
INNER JOIN BANCOS ON BANCOS.COD_BANCO = CP.COD_BANCO 
WHERE CP.DATAVENC_PAGAR BETWEEN @DATA_INI AND  @DATA_FIM
order BY CP.DATAVENC_PAGAR ASC 



---------------------------------------------------------------------------------------------------------------------TECHCD
SELECT cp.COD_DESP , CP.NUMDOC_PAGAR, DESP.DESC_DESP , TP.DESC_PAGTO , FP.DESC_FRMPAGTO , 
BANCOS.DESC_BANCO , CP.VALORPREV_PAGAR , CP.VALORREAL_PAGAR , CP.QUEMQUIT_PAGAR ,
convert(nvarchar,CP.DATAVENC_PAGAR,103) AS VENCIMENTO , convert(nvarchar,CP.DATAQUIT_PAGAR,103) AS QUITA��O
FROM  CONTAS_PAGAR AS CP
INNER JOIN DESPESAS AS DESP ON DESP.COD_DESP = CP.COD_DESP
INNER JOIN TIPO_PAGTO AS TP ON TP.COD_PAGTO =  CP.COD_PAGTO
INNER JOIN FORMA_PAGTO AS FP ON FP.COD_FRMPAGTO = CP.COD_FRMPAGTO
INNER JOIN BANCOS ON BANCOS.COD_BANCO = CP.COD_BANCO 
WHERE CP.DATAVENC_PAGAR BETWEEN @DATA_INI AND  @DATA_FIM
order BY CP.DATAVENC_PAGAR ASC 
