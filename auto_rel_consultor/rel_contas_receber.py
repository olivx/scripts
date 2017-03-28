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
query_contas_receber_techcd = 'exec SP_REL_CONTABILIDADE_CONTAS_RECEBER_TECHCD @INI = ?, @FIM = ?'
query_contas_receber_data_store = 'exec SP_REL_CONTABILIDADE_CONTAS_RECEBER_DATA_STORE @INI = ?, @FIM = ?'
query_contas_receber_midia_center = 'exec SP_REL_CONTABILIDADE_CONTAS_RECEBER_MIDIA_CENTER @INI = ?, @FIM = ?'

parms, now = [], datetime.now()
report_movimentaocao_csv = 'contas_receber_' + str(now.date()) + '_.csv'
report_file = 'relatorio_contas_receber_' + str(now.date()) + '_.xlsx'

'''Retorna o Primeiro e ultimo dia do mês passado '''
_month = now.month - 2
if _month <= 0:
    _month = 1
parms.append(datetime(now.year, _month, 1))
parms.append(datetime(now.year, now.month, 1))

# # ULTIMAL SOLICTAÇÃO DA CONSULTOR
# month_ = 8
# parms.append(datetime(1999, 1, 1))
# parms.append(datetime(2016, 12 , 31))

'''Executa a query e exporta para excel'''
connection = pyodbc.connect(_string_conection)

'''Contas a Receber'''
excel = pandas.ExcelWriter(report_file)
report_contas_receber_techcd = pandas.read_sql_query(query_contas_receber_techcd, connection, params=parms)
report_contas_receber_data_store = pandas.read_sql_query(query_contas_receber_data_store, connection, params=parms)
report_contas_receber_midia_center = pandas.read_sql_query(query_contas_receber_midia_center, connection, params=parms)

report_contas_receber_techcd.to_excel(excel, sheet_name='TECHCD')
report_contas_receber_data_store.to_excel(excel, sheet_name='DATA STORE')
report_contas_receber_midia_center.to_excel(excel, sheet_name='MIDIA CENTER')
excel.close()

'''Envia para lista de email o relatorio'''
''' codigo copiado na internet...  é eu sei, ,as eu melhorei ele e tá funcionado,
é o que importa ! '''

from_addr = "thiago@techcd.com.br"
to_addr = "thiago@techcd.com.br"
# recipents = ['vera.dc@revisaocontabil.com.br', 'lidia@techcd.com.br', 'wolf@techcd.com.br']
recipents = ['thiago@techcd.com.br']

message = MIMEMultipart()

message['From'] = from_addr
message['To'] = to_addr
message['Cc'] = ','.join(recipents)
message['Subject'] = "INVENTARIO CONTAS A  RECBER E RECEBIDAS  REFERENTE Á %s ATÉ %s" % \
                     (parms[0].date().__format__('%d/%m/%y'), parms[1].date().__format__('%d/%m/%y'))

body = '''
Bom dia,

este email esta sendo enviado automaticamente , ele se refere ao período de %s a %s para contas

a receber e recebidas , o relatorio  está em anexo com a  planilha de estoque dentro dela

possui uma sheet para cada empresa, em  caso de  sugestão de melhoria no processo,

favor responder esse email ou  entrar em contato comigo por email, telefone ou WhatsApp



Obrigado.

Thiago Oliveira
TechCD Informática
skype: oliveiravicente.net
Tel:+55 11-  3677-6655
Cel:+55 11- 97051-3508
www.techcd.com.br
www.rimagebrasil.com.br

''' % (
    parms[0].date().__format__('%d/%m/%y'), parms[1].date().__format__('%d/%m/%y'))

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
