#coding:utf8
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
_string_conection = 'DRIVER={FreeTDS};SERVER=SERVER2008;PORT=1433;DATABASE=TECHCD;UID=sa;PWD=tigre177;TDS_Version=7.0'
query_head_invoicing = 'exec SP_REL_CONSULTOR_FATURAMENTO_HEADER @INI = ?, @FIM = ?'
query_detail_invoicing = 'exec SP_REL_CONSULTOR_FATURAMENTO_DETAIL @INI = ?, @FIM = ?'

parms, now , month = [] , datetime.now() , datetime.now().month -1
report_header_invoicing_csv = 'faturamento_detalado_cabeçalho_' + str(now.date()) + '_.csv'
report_detail_invoicing_csv = 'faturamento_detalado_cabeçalho_' + str(now.date()) + '_.csv'
report_file= 'faturamento_detalhado_' + str(now.date()) + '_.xlsx'


'''Retorna o Primeiro e ultimo dia do mês passado '''
# last_day_of_month =  monthrange(now.year, month)
# parms.append(datetime(now.year, month, 1))
# parms.append(datetime(now.year, month, last_day_of_month[1]))

'''Retorna o Primeiro e ultimo dia do mês passado '''
parms.append(datetime(2015, 1, 1))
parms.append(datetime(2016, 8, 31))


'''Executa a query e exporta para excel'''
connection = pyodbc.connect(_string_conection)


excel = pandas.ExcelWriter(report_file)
report_header = pandas.read_sql_query(query_head_invoicing, connection , params=parms)
report_detail = pandas.read_sql_query(query_detail_invoicing, connection , params=parms)
report_header.to_excel(excel, sheet_name='CABEÇALHO')
report_detail.to_excel(excel, sheet_name='DETALHES')
excel.close()


'''Envia para lista de email o relatorio'''
''' codigo copiado na internet...  é eu sei, ,as eu melhorei ele e tá funcionado,
é o que importa ! '''

from_addr = "thiago@techcd.com.br"
to_addr = "thiago@techcd.com.br "
recipents = ['jrnegrao@e2gestao.com', 'rene@techcd.com.br', 'thiago@techcd.com.br']


message = MIMEMultipart()
message['From'] = from_addr
message['To'] = to_addr
message['Cc'] = ', '.join(recipents)
message['Subject'] = "RELATORIO DE FATURAMENTO TECHCD MIDIA CENTER E DATA STORE"

body = '''
Bom dia,

este email esta sendo enviado automaticamente , ele se refere ao período de %s a %s

está em anexo a planilha de faturamento com os sheet de cabeçalho e detalhes caso haja

sugestão de melhoria no processo, favor responder esse email ou  entrar em contato comigo

por email, telefone ou WhatsApp

obs: esse é um email teste gostaria que me confirmasse o e-mail para validar

qualquer sugestão é bem vinda.

Obrigado.

Thiago Oliveira
TechCD Informática
skype: olvieiravicente.net
Tel:+55 11-  3677-6655
Cel:+55 11- 97051-3508
www.techcd.com.br
www.rimagebrasil.com.br

''' % (parms[0].date().__format__('%d/%m/%y'), parms[1].date().__format__('%d/%m/%y'))

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
server.sendmail(from_addr,  recipents, text)
server.quit()

path_destination = '/home/olvx/Documentos/Relatorios /CONSULTOR/enviado_por_scripts/'
os.rename(file_name, path_destination + 'report_enviado_' + report_file)
