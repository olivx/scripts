/****** Script do comando SelectTopNRows de SSMS  ******/
SELECT PESO_INI , PESO_FIM , 
convert(money,CAPITAL_SP_HJ * 1.07 ,103)as CAPITAL_SP_HJ , 
convert(money,CAPITAL_SP_24 * 1.07,103) as CAPITAL_SP_24 , 
convert(money,GRANDE_SP_HJ  * 1.07,103) as GRANDE_SP_HJ , 
convert(money,GRANDE_SP_24 * 1.07,103) as GRANDE_SP_24 
from PRECOS_LAERCIO


SELECT PESO_INI , PESO_FIM , 
convert(money,CAPITAL_SP_HJ,103) as CAPITAL_SP_HJ , 
convert(money,CAPITAL_SP_24,103) as CAPITAL_SP_24 , 
convert(money,GRANDE_SP_HJ ,103) as GRANDE_SP_HJ , 
convert(money,GRANDE_SP_24,103) as GRANDE_SP_24 
from PRECOS_LAERCIO



/****** Script do comando SelectTopNRows de SSMS  ******/
UPDATE PRECOS_LAERCIO set 
CAPITAL_SP_HJ = CAPITAL_SP_HJ * 1.07 , 
CAPITAL_SP_24 = CAPITAL_SP_24 * 1.07 ,
GRANDE_SP_HJ = GRANDE_SP_HJ  * 1.07,
GRANDE_SP_24 = GRANDE_SP_24 * 1.07

select *  from PRECOS_LAERCIO









