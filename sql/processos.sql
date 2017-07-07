

SELECT * FROM SYS.SYSPROCESSES WHERE BLOCKED <> 0

SELECT
	Processo      = spid
	,Computador   = hostname
	,Usuario      = loginame
	,Status       = status
	,BloqueadoPor = blocked
	,TipoComando  = cmd
	,Aplicativo   = program_name
FROM
	master..sysprocesses
WHERE
	status in ('runnable', 'suspended')
ORDER BY
	blocked desc, status, spid



select spid,blocked,lastwaittype,waitresource,
db_name(sysprocesses.dbid) [Database],dest.text from sys.sysprocesses
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS DEST 
where blocked<>0 or spid in (select blocked from sys.sysprocesses)

kill 76