

-- verificando tabela 
select * from CONTATOS_CLI where COD_CLI = 10972

-- verificando se o contato esta em mais tabelas 
select cli.cod_cli , cli.NOME_CLI ,con.TEL_CONTA from CLIENTES as cli 
inner join  CONTATOS_CLI as con on con.COD_CLI = cli.COD_CLI
where TEL_CONTA = '6802-7262'

-- vendo o numero de contatos na tablea 
select count(cli.cod_cli) from CLIENTES as cli 
inner join  CONTATOS_CLI as con on con.COD_CLI = cli.COD_CLI
where TEL_CONTA = '6802-7262'

-- tabela com bkp antingo gerado 
select * from bkptechcd.dbo.CONTATOS_CLI where COD_CLI = 10972

-- inserindo registro 
insert into contatos_cli (COD_CLI	,COD_CONTA,	NOME_CONTA,	EMAIL_CONTA,	
EMAIL2_CONTA,	DDD_CONTA,	TEL_CONTA,
RAMAL_CONTA,	CARGO_CONTA,	DEPARTAMENTO_CONTA,	RECEBER_EMAIL,	DDDCEL_CONTA,
CEL_CONTA,	DDD2_CONTA,	TEL2_CONTA,	RAMAL2_CONTA,	NIVER_CONTA,	ATIVO_CONTA)
select COD_CLI	,COD_CONTA,	NOME_CONTA,	EMAIL_CONTA,	EMAIL2_CONTA,	DDD_CONTA,	TEL_CONTA,
RAMAL_CONTA,	CARGO_CONTA,	DEPARTAMENTO_CONTA,	RECEBER_EMAIL,	DDDCEL_CONTA,
CEL_CONTA,	DDD2_CONTA,	TEL2_CONTA,	RAMAL2_CONTA,	NIVER_CONTA,	ATIVO_CONTA 
from bkptechcd.dbo.CONTATOS_CLI where COD_CLI = 10972

