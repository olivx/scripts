# -*- coding: utf-8 -*-
import pyodbc
import pandas
import os

from calendar import monthrange
from datetime import datetime

import smtplib
from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

'''
Relatorio de faturamente de dalahdo será gerado todos os dias primenro do mês
e enviar a referencia ao mes passado
'''
_string_conection = 'DRIVER={FreeTDS};SERVER=192.168.0.204;PORT=1433;DATABASE=TECHCD;UID=sa;PWD=tigre177;TDS_Version=7.0'
query_saldo_em_estoque = 'exec SP_REL_CONSULTOR_SALDO_DE_ESTOQUE @PERIODO = ?'
query_movimentacao = 'exec SP_REL_CONSULTOR_MOVIMENTACAO @STARTER = ?, @FINISH = ?'

parms, now , month = [] , datetime.now(), datetime.now().month -1
report_movimentaocao_csv = 'movimentacao_no_estoque_' + str(now.date()) + '_.csv'
Report_saldo_em_estoque_csv = 'saldo_de_estoque_' + str(now.date()) + '_.csv'
report_file= 'relaotorio_de_estoque_' + str(now.date()) + '_.xlsx'




'''Retorna o Primeiro e ultimo dia do mês passado '''
last_day_of_month =  monthrange(now.year, month)
parms.append(datetime(now.year, month, 1))
parms.append(datetime(now.year, month, last_day_of_month[1]))

# month_ = 9
# last_day_of_month =  monthrange(now.year, month_)
# parms.append(datetime(1999, 1, 1))
# parms.append(datetime(2016, 12, 31))
# parms.append(datetime(2016, 12, last_day_of_month[1]))

'''Executa a query e exporta para excel'''
connection = pyodbc.connect(_string_conection)

excel = pandas.ExcelWriter(report_file)
report_movimentacao = pandas.read_sql_query(query_movimentacao, connection, params=parms)
report_saldo_em_estoque = pandas.read_sql_query(query_saldo_em_estoque, connection, params=[parms[-1]])

report_saldo_em_estoque.to_excel(excel, sheet_name='SALDO EM ESTOQUE')
report_movimentacao.to_excel(excel, sheet_name='MOVIMENTAÇÃO')
excel.close()


'''Envia para lista de email o relatorio'''
''' codigo copiado na internet...  é eu sei, ,as eu melhorei ele e tá funcionado,
é o que importa ! '''

from_addr = "thiago@techcd.com.br"
to_addr = "thiago@techcd.com.br"
recipents = ['jrnegrao@e2gestao.com' , 'rene@techcd.com.br', 'thiago@techcd.com.br']
# recipents = ['vera.dc@revisaocontabil.com.br', 'lidia@techcd.com.br', 'wolf@techcd.com.br']
#recipents = ['thiago@techcd.com.br']

message = MIMEMultipart()

message['From'] = from_addr
message['To'] = to_addr
message['Cc'] = ','.join(recipents)
message['Subject'] = "RELATORIO DE MOVIMENTAÇÃO E SALDO DE ESTOQUE"

body = '''
Bom dia,

este email esta sendo enviado automaticamente , ele se refere ao período de %s a %s para movimentação

e o saldo em estoque no dia  %s , o relatorio  está em anexo com a  planilha de estoque dentro dela

possui a sheet de salado em estoque  e movimentação em  caso de  sugestão de melhoria no processo,

favor responder esse email ou  entrar em contato comigo por email, telefone ou WhatsApp



Obrigado.

Thiago Oliveira
TechCD Informática
skype: oliveiravicente.net
Tel:+55 11-  3677-6655
Cel:+55 11- 97051-3508
www.techcd.com.br
www.rimagebrasil.com.br

''' % (parms[0].date().__format__('%d/%m/%y'), parms[1].date().__format__('%d/%m/%y'), parms[-1].date().__format__('%d/%m/%y') )

message.attach(MIMEText(body, 'plain'))


file_name = report_file

attachment = open(file_name, "rb")
part = MIMEBase('application', 'octet-stream')
part.set_payload((attachment).read())


encoders.encode_base64(part)
part.add_header('Content-Disposition', "attachment; filename= %s" % file_name)
message.attach(part)


recipents.append(to_addr)

server = smtplib.SMTP('smtp.techcd.com.br', 587)
server.starttls()
server.login(from_addr, "mmnhbn")
text = message.as_string()
server.sendmail(from_addr, recipents, text)
server.quit()

path_destination = '/home/olvx/Documentos/Relatorios /CONSULTOR/enviado_por_scripts/'
os.rename(file_name, path_destination + 'report_enviado_' + report_file)