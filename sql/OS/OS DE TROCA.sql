
/** 
OS com Substituição Tributaria (Consumo) FINANCEIRO : *159734C*
o frete esta incluso nos materiais.
Valor correto do CD 0,97-1,02 = 0,05 x 2.000 = 100,00
Valor do DVD : 1,47-1,50 = 0,03 x 1.200 = 36,00
Total : R$ 136,00 para cobrir o frete
**/

-- 1 AJUSTAR NA OS ORGINAL O CAMPO TOTTROCA_OS NA TABELA OS
select * from os where cod_os in(159734,159525) 
select * from ITM_OS_PAGTO where cod_os in(159734,159525) 

update os set TOTTROCA_OS = 1100.00 where cod_os = 159525

update os set TOT_OS = 0.00 where cod_os = 159525

update ITM_OS_PAGTO set VAL_PAGTO = 252.00 where cod_os = 159328

update ITM_OS_PAGTO set VAL_PAGTO = 1.98 where cod_os = 159328

update ITM_OS_PAGTO set REAL_PAGTO = 1.98 where cod_os = 159328


