

/*VERIFICAR A QUAL OS ESTA VINCULADO O BOLETO */
select * from OS where COD_NF_SAIDA = 2183

/*VERIFICAR COMO ESTA O ITENS DE PAGAMENTO NO BANCO DE DADOS*/
select * from ITM_NFE_SAIDA_PAGTO_DATA where COD_NF_SAIDA in(2183)
select * from ITM_NFE_SAIDA_DATA where COD_NF_SAIDA in(2183)

/*VERIFICAR QUAL A FORMA DE PAGAMENTO DA NFE */
select * from FORMA_PAGTO where COD_FRMPAGTO = 
(select COD_FRMPAGTO from ITM_NFE_SAIDA_PAGTO_DATA where COD_NF_SAIDA in(2183))

/*DELETAR O BOLETOS ERRO DO BANCO */
delete from ITM_NFE_SAIDA_PAGTO where COD_NF_SAIDA = 25559

/*INSERT PARA O BLOLETOS CORRETOS */
insert into ITM_NFE_SAIDA_PAGTO values(25559,	1.00,	13,	8,	82.99,	0.00,	'2015-03-13 00:00:00',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL)
insert into ITM_NFE_SAIDA_PAGTO values(25559,	2.00,	13,	12,	82.99,	0.00,	'2015-04-12 00:00:00',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL)
insert into ITM_NFE_SAIDA_PAGTO values(25559,	3.00,	13,	17,	83.00,	0.00,	'2015-05-12 00:00:00',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL)

/*VERIFICAR SE ELE ESTA INCLUINDO NA TABELA QUE ENVIARA OS BOLETOS AI BANCO*/
select * from BOLETOS_DATA_NFe where NumDoc_Bol in (2183)
select * from BOLETOS_DATA_NFe where NumDoc_Bol in (2183)

/*ISERT TABLA DE BOLETOD PARA O BANCO*/
SELECT TOP 1 * FROM BOLETOS_DATA_NFE
ORDER BY NumDoc_Bol DESC 

select * from NFE_DATA as n
inner join clientes as  c on c.COD_CLI = n.COD_CLI
where n.COD_NF_SAIDA = 2183 

   
insert BOLETOS_TECHCD_NFe 
(NNum_Bol,Data_Bol,Venc_Bol,NumDoc_Bol,Val_Bol,Sac_Bol,
End_Bol,Cep_Bol,Bair_Bol,Cid_Bol,UF_Bol,Pes_Bol,CNPJ_Bol,Env_Bol)
values
(30793120, NULL, NULL, 30793 , NULL, NULL,
 NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL)
 
 UPDATE BOLETOS_TECHCD_NFe SET End_Bol='AVENIDA DA SAUDADE, Cep_Bol='09030030',
 Bair_Bol='VILA ASSUNCAO', Cid_Bol='SAO PAULO', UF_Bol='SP' WHERE NumDoc_Bol = 30793
 SELECT * FROM BOLETOS_TECHCD_NFe WHERE NumDoc_Bol = 30793


