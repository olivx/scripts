/*CAMPOS SOLICITADOS PELA FIT*/
/*Codigo Produto,	Descrição Produto,	Unidade,	NCM,	Quantidade,	Valor Unitario,	
Valor Total,	Código Conta, Contábil,	Descrição Conta Contábil,	Natureza*,	
Código do Plano de Conta Superior,	Nível */

/*TECHCD*/
SELECT EXCEL.CODIGO  AS [Codigo Produto] , EXCEL.DESC_PROD AS [Descrição Produto] , 
'UN'AS [UNIDADE]  , P.CLASSITRIB_PROD AS [NCM],  EXCEL.SALDO AS [Quantidade],
EXCEL.VALOR_UNI [Valor Unitario], EXCEL.VALOR_TOTAL [Valor Total], '41022002' AS [Código Conta, Contábil],
'Estoque de material para revenda' AS [Descrição Conta Contábil], '1' AS [Natureza] , 
'11801' AS [Código do Plano de Conta Superior] ,'1' AS [Nível]
 FROM PRODUTOS AS P 
 INNER JOIN OPENROWSET('Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0 Xml;HDR=YES;Database=C:\backup_sql\20-12-2014 - INVENTARIO-1.xlsx',
    'SELECT  * FROM [techcd$]') AS EXCEL  ON EXCEL.CODIGO = P.COD_PROD
    
/*MIDIA*/
SELECT EXCEL.CODIGO  AS [Codigo Produto] , EXCEL.DESC_PROD AS [Descrição Produto] , 
'UN'AS [UNIDADE]  , P.CLASSITRIB_PROD AS [NCM],  EXCEL.SALDO AS [Quantidade],
EXCEL.VALOR_UNI [Valor Unitario], EXCEL.VALOR_TOTAL [Valor Total], '41022002' AS [Código Conta, Contábil],
'Estoque de material para revenda' AS [Descrição Conta Contábil], '1' AS [Natureza] , 
'11801' AS [Código do Plano de Conta Superior] ,'1' AS [Nível]
 FROM PRODUTOS AS P 
 INNER JOIN OPENROWSET('Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0 Xml;HDR=YES;Database=C:\backup_sql\20-12-2014 - INVENTARIO-1.xlsx',
    'SELECT  * FROM [MIDIA$]') AS EXCEL  ON EXCEL.CODIGO = P.COD_PROD    

/*DATA*/
SELECT EXCEL.CODIGO  AS [Codigo Produto] , EXCEL.DESC_PROD AS [Descrição Produto] , 
'UN'AS [UNIDADE]  , P.CLASSITRIB_PROD AS [NCM],  EXCEL.SALDO AS [Quantidade],
EXCEL.VALOR_UNI [Valor Unitario], EXCEL.VALOR_TOTAL [Valor Total], '41022002' AS [Código Conta, Contábil],
'Estoque de material para revenda' AS [Descrição Conta Contábil], '1' AS [Natureza] , 
'11801' AS [Código do Plano de Conta Superior] ,'1' AS [Nível]
 FROM PRODUTOS AS P 
 INNER JOIN OPENROWSET('Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0 Xml;HDR=YES;Database=C:\backup_sql\20-12-2014 - INVENTARIO-1.xlsx',
    'SELECT  * FROM [DATA$]') AS EXCEL  ON EXCEL.CODIGO = P.COD_PROD        
   
    
/*PRODUTOS COM NCM ZERADOS */ 
/*ACHA O ULTIMO PEDIDO DE COMPRA DO PRODUTO*/   
SELECT  PED.COD_CMP , I.COD_PROD , P.DESC_PROD  , 
CONVERT(NVARCHAR(10),PED.ULTIMACOMPRA,103) ,
CASE PED.EMPRESA_CMP
WHEN 'T' THEN 'TECHCD'
WHEN 'D' THEN 'DATA'
WHEN 'M' THEN 'MIDIA' 
END AS EMPRESA
FROM(SELECT COD_CMP, EMPRESA_CMP  , MAX(DATA1_CMP) AS ULTIMACOMPRA
      FROM PED_COMPRA where DATA1_CMP < '2014-12-20'
      GROUP BY COD_CMP , EMPRESA_CMP ) PED
INNER JOIN PED_COMPRA AS PEDIDO ON  PEDIDO.DATA1_CMP = PED.ULTIMACOMPRA       
INNER JOIN ITM_CMP AS I ON I.COD_CMP = PED.COD_CMP 
INNER JOIN PRODUTOS AS P  ON P.COD_PROD = I.COD_PROD
INNER JOIN OPENROWSET('Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0 Xml;HDR=YES;Database=C:\backup_sql\20-12-2014 - INVENTARIO-1.xlsx',
    'SELECT  * FROM [TECHCD$]') AS EXCEL  ON EXCEL.CODIGO = I.COD_PROD
WHERE P.CLASSITRIB_PROD = '0'
GROUP BY PED.COD_CMP , I.COD_PROD , P.DESC_PROD ,PED.EMPRESA_CMP ,PED.ULTIMACOMPRA 
ORDER BY I.COD_PROD




