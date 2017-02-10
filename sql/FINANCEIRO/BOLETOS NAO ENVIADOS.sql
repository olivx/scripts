use techcd
select * from BOLETOS_TECHCD_NFe where Data_Bol between '2016-01-14' and '2016-01-15' 
select * from BOLETOS_data_NFe where Data_Bol between '2016-01-14' and '2016-01-15' 
select * from BOLETOS_midia_NFe where Data_Bol between '2016-01-14' and '2016-01-15' 

select * from BOLETOS_data_NFe where Data_Bol between '2016-01-19' and '2016-01-20' 
select * from BOLETOS_midia_NFe where Data_Bol between '2016-01-19' and '2016-01-20' 



UPDATE  BOLETOS_data_NFe SET Data_Bol = GETDATE() , Env_Bol = 0 
where Data_Bol between '2016-01-14' and '2016-01-15' 

UPDATE BOLETOS_midia_NFe SET Data_Bol = GETDATE() , Env_Bol = 0 
where Data_Bol between '2016-01-14' and '2016-01-15' 

