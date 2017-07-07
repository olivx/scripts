use techcd
select  c.NOME_CLI , c.EMAIL_CLI 
from CLIENTES as c
where c.DATAINCL_CLI between '2015-08-01' and '2015-08-30' and
email_cli <> ''