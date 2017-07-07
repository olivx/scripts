
-- PROCURA POR NOME DE COLUNA 
 SELECT 
       OBJECT_NAME(id) AS Tabela,
       Name            AS Coluna 
FROM 
    sys.syscolumns 
WHERE 
    name = 'COD_NF_ENTRADA'

DECLARE @column		sysname
SET @column = '%ENTRADA%'


--  PROCURA POR NOME DE COLUNA 
SELECT a.name AS COLUNA, b.name AS TABELA
FROM dbo.syscolumns a JOIN dbo.sysobjects b ON a.id = b.id
WHERE a.name LIKE @column 
AND b.xtype = 'U'

-- PROCURA PROCEDURE COM ESSE NOME 
SELECT name, create_date, modify_date FROM sys.procedures 
WHERE OBJECT_DEFINITION(object_id) LIKE '%ENTRADA%'
order by modify_date asc 

