select * from  BOLETOS_TECHCD_NFe 
WHERE Data_Bol between '2015-03-31 00:00:00.000' and '2015-03-31 23:59:59.000'

update BOLETOS_TECHCD_NFe set Env_Bol = 0  
WHERE Data_Bol between '2015-03-30 00:00:00.000' and '2015-03-30 23:59:59.000'
