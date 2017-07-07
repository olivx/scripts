


select * from PED_COMPRA where COD_CMP in(14223)
select * from cmp_nfe  where COD_CMP in(14223)

select * from nfe_entrada where COD_NF_ENTRADA = 1354
select * from itm_nfe_entrada where COD_NF_ENTRADA = 1354
select * from itm_nfe_entrada_PAGTO where COD_NF_ENTRADA = 1354



insert into cmp_nfe values (14223,1354,1,'T')




