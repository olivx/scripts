
/*RELATORIO TECHCD REM BENS POR CONTA DE CONT COMODATO  */
SELECT N.COD_NF_SAIDA AS NFE , NAT.COD_NAT  , UPPER(NAT.DESC_NAT) AS DESCRICAO , 
CONVERT(NVARCHAR,N.DATAEMIS_NF_SAIDA,103)AS [DATA DE EMISSAO]  , 
C.COD_CLI , UPPER(C.NOME_CLI) AS CLIENTE , C.CNPJ_CLI , UPPER(C.EST_CLI) AS ESTADO , UPPER(C.CID_CLI) AS CIDADE 
FROM NFE AS N
INNER JOIN NATUREZA_OPERACAO AS NAT ON NAT.COD_NAT= N.COD_NAT
INNER JOIN CLIENTES AS C ON C.COD_CLI =  N.COD_CLI 
WHERE N.COD_NAT IN(select COD_NAT from NATUREZA_OPERACAO where COD_NAT = 144)
GROUP BY  N.COD_NF_SAIDA  , NAT.COD_NAT  , NAT.DESC_NAT  , N.DATAEMIS_NF_SAIDA , 
C.COD_CLI , C.NOME_CLI , C.CNPJ_CLI , C.EST_CLI , C.CID_CLI
ORDER BY N.DATAEMIS_NF_SAIDA ASC 

/*RELATORIO DATA REM BENS POR CONTA DE CONT COMODATO  */
SELECT N.COD_NF_SAIDA AS NFE , NAT.COD_NAT  , UPPER(NAT.DESC_NAT) AS DESCRICAO , 
CONVERT(NVARCHAR,N.DATAEMIS_NF_SAIDA,103)AS [DATA DE EMISSAO]  , 
C.COD_CLI , UPPER(C.NOME_CLI) AS CLIENTE , C.CNPJ_CLI , UPPER(C.EST_CLI) AS ESTADO , UPPER(C.CID_CLI) AS CIDADE 
FROM NFE_DATA AS N
INNER JOIN NATUREZA_OPERACAO AS NAT ON NAT.COD_NAT= N.COD_NAT
INNER JOIN CLIENTES AS C ON C.COD_CLI =  N.COD_CLI 
WHERE N.COD_NAT IN(select COD_NAT from NATUREZA_OPERACAO where COD_NAT = 144)
GROUP BY  N.COD_NF_SAIDA  , NAT.COD_NAT  , NAT.DESC_NAT  , N.DATAEMIS_NF_SAIDA , 
C.COD_CLI , C.NOME_CLI , C.CNPJ_CLI , C.EST_CLI , C.CID_CLI
ORDER BY N.DATAEMIS_NF_SAIDA ASC 


/*RELATORIO MIDIA REM BENS POR CONTA DE CONT COMODATO  */
SELECT N.COD_NF_SAIDA AS NFE , NAT.COD_NAT  , UPPER(NAT.DESC_NAT) AS DESCRICAO , 
CONVERT(NVARCHAR,N.DATAEMIS_NF_SAIDA,103)AS [DATA DE EMISSAO]  , 
C.COD_CLI , UPPER(C.NOME_CLI) AS CLIENTE , C.CNPJ_CLI , UPPER(C.EST_CLI) AS ESTADO , UPPER(C.CID_CLI) AS CIDADE 
FROM NFE_MIDIA AS N
INNER JOIN NATUREZA_OPERACAO AS NAT ON NAT.COD_NAT= N.COD_NAT
INNER JOIN CLIENTES AS C ON C.COD_CLI =  N.COD_CLI 
WHERE N.COD_NAT IN(select COD_NAT from NATUREZA_OPERACAO where COD_NAT = 144)
GROUP BY  N.COD_NF_SAIDA  , NAT.COD_NAT  , NAT.DESC_NAT  , N.DATAEMIS_NF_SAIDA , 
C.COD_CLI , C.NOME_CLI , C.CNPJ_CLI , C.EST_CLI , C.CID_CLI
ORDER BY N.DATAEMIS_NF_SAIDA ASC 