from calendar import monthrange
from datetime import datetime
import pyodbc
import pandas
import os

import smtplib
from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# string de conexão
_string_conection = 'DRIVER={FreeTDS};SERVER=192.168.0.204;PORT=1433;DATABASE=TECHCD;UID=sa;PWD=tigre177;TDS_Version=7.0'

# params
params, now = [], datetime.now()
_last_day = monthrange(now.year, now.month)[1]

params.append(datetime(now.year, now.month, 1))
params.append(datetime(now.year, now.month, _last_day))

# nome do arquvios
_report_file = 'relatorio_consultor_' + str(now.date()) + '.xlsx'

# query's
_query_faturamento_header = 'exec SP_REL_CONSULTOR_FATURAMENTO_HEADER @INI = ?, @FIM = ?'
_query_faturamento_detail = 'exec SP_REL_CONSULTOR_FATURAMENTO_DETAIL @INI = ?, @FIM = ?'
_query_saldo_de_estoque = 'exec SP_REL_CONSULTOR_SALDO_DE_ESTOQUE @PERIODO = ? '
_query_contas_receber = 'exec SP_REL_CONSULTOR_CONTAS_RECEBER @INI = ? , @FIM = ?'
_query_despesas = 'exec SP_REL_CONSULTOR_DESPESAS @INI = ? , @FIM = ?'

# work on pandas
excel = pandas.ExcelWriter(_report_file)
pandas.formats.format.header_style = None
workbook = excel.book

connection = pyodbc.connect(_string_conection)
report_faturamento_header = pandas.read_sql_query(_query_faturamento_header, connection, params=params)
report_faturamento_detail = pandas.read_sql_query(_query_faturamento_detail, connection, params=params)
report_contas_receber = pandas.read_sql_query(_query_contas_receber, connection, params=params)
report_contas_pagar_fornecedor = pandas.read_sql_query(_query_despesas, connection, params=params)
report_saldo_de_stoque = pandas.read_sql_query(_query_saldo_de_estoque, connection, params=[params[-1]])

# sheet vendas
report_faturamento_detail.to_excel(excel, sheet_name='VENDAS', index=False)
header_format = workbook.add_format({'bold': True, 'font_color': 'blue', 'bg_color': '#C6EFCE'})
money_format = workbook.add_format({'num_format': '#,##0.00', 'align': 'right'})
aling_center = workbook.add_format({'align': 'center'})

worksheet = excel.sheets['VENDAS']
worksheet.set_row(0, 15, header_format)

# column update names  of columns

worksheet.set_column('A:A', 20)  # EMPRESA
worksheet.set_column('B:B', 15)  # CODIGO
worksheet.set_column('C:C', 20)  # DDESC PRODUTO
worksheet.set_column('D:D', 10, aling_center)  # CODIGO CATEGORIA
worksheet.set_column('E:E', 60)
worksheet.set_column('F:F', 20, aling_center)
worksheet.set_column('G:G', 15)
worksheet.set_column('H:I', 20, money_format)

# sheet nfe
report_faturamento_header.to_excel(excel, sheet_name='NFE', index=False)
header_format = workbook.add_format({'bold': True, 'font_color': 'blue', 'bg_color': '#C6EFCE'})
money_format = workbook.add_format({'num_format': '#,##0.00', 'align': 'right'})
aling_center = workbook.add_format({'align': 'center'})

worksheet = excel.sheets['NFE']
worksheet.set_row(0, 15, header_format)

# column
worksheet.set_column('A:A', 20)  # EMPRESA
worksheet.set_column('B:B', 10, aling_center)  # CODIGO NFE
worksheet.set_column('C:C', 20, aling_center)  # DATA EMISSAO NFE
worksheet.set_column('D:D', 10, aling_center)  # CODIGO OS
worksheet.set_column('E:E', 20, aling_center)  # DATA EMISSAO OS
worksheet.set_column('F:F', 18, aling_center)  # COD CLIENTE
worksheet.set_column('G:G', 50)  # NOME CLIENTE
worksheet.set_column('H:H', 20)  # CNPJ CPF
worksheet.set_column('I:I', 30)  # NATUREZA DA OPERACAO
worksheet.set_column('J:J', 18, aling_center)  # CONTRATO
worksheet.set_column('K:R', 20, money_format)  # VALORES
worksheet.set_column('S:S', 15, aling_center)  # STATUS

report_saldo_de_stoque.to_excel(excel, sheet_name='ESTOQUE', index=False)
header_format = workbook.add_format({'bold': True, 'font_color': 'blue', 'bg_color': '#C6EFCE'})
money_format = workbook.add_format({'num_format': '#,##0.00', 'align': 'right'})
aling_center = workbook.add_format({'align': 'center'})

worksheet = excel.sheets['ESTOQUE']
worksheet.set_row(0, 15, header_format)

# column
worksheet.set_column('A:A', 20)  # EMPRESA
worksheet.set_column('B:B', 10, aling_center)  # CODIGO NFE
worksheet.set_column('C:C', 20, aling_center)  # DATA EMISSAO NFE
worksheet.set_column('D:D', 50)  # CODIGO OS
worksheet.set_column('E:E', 20, aling_center)  # DATA EMISSAO OS
worksheet.set_column('F:F', 18, aling_center)  # COD CLIENTE
worksheet.set_column('G:G', 10)  # NOME CLIENTE
worksheet.set_column('H:H', 50)  # CNPJ CPF
worksheet.set_column('I:I', 30, aling_center)  # NATUREZA DA OPERACAO
worksheet.set_column('L:N', 20, money_format)  # CONTRATO

report_contas_pagar_fornecedor.to_excel(excel, sheet_name='DESPESAS', index=False)
header_format = workbook.add_format({'bold': True, 'font_color': 'blue', 'bg_color': '#C6EFCE'})
money_format = workbook.add_format({'num_format': '#,##0.00', 'align': 'right'})
aling_center = workbook.add_format({'align': 'center'})

worksheet = excel.sheets['DESPESAS']
worksheet.set_row(0, 15, header_format)

# column
worksheet.set_column('A:A', 20)
worksheet.set_column('B:B', 10, aling_center)
worksheet.set_column('C:C', 20)
worksheet.set_column('D:D', 40)
worksheet.set_column('E:E', 20)
worksheet.set_column('F:F', 18)
worksheet.set_column('G:G', 20)
worksheet.set_column('H:H', 20, money_format)
worksheet.set_column('I:I', 20, money_format)
worksheet.set_column('J:J', 18, aling_center)
worksheet.set_column('K:R', 20, money_format)
worksheet.set_column('S:S', 15, aling_center)

report_contas_receber.to_excel(excel, sheet_name='AR', index=False)
header_format = workbook.add_format({'bold': True, 'font_color': 'blue', 'bg_color': '#C6EFCE'})
money_format = workbook.add_format({'num_format': '#,##0.00', 'align': 'right'})
aling_center = workbook.add_format({'align': 'center'})

worksheet = excel.sheets['AR']
worksheet.set_row(0, 15, header_format)

# column
worksheet.set_column('A:A', 15)
worksheet.set_column('B:B', 10, aling_center)
worksheet.set_column('C:C', 20, aling_center)
worksheet.set_column('D:D', 50)
worksheet.set_column('E:E', 25)
worksheet.set_column('F:F', 18, aling_center)
worksheet.set_column('G:G', 15, money_format)
worksheet.set_column('H:H', 30)
worksheet.set_column('I:I', 20)
worksheet.set_column('J:J', 30)
worksheet.set_column('K:R', 20, money_format)
worksheet.set_column('S:S', 15, aling_center)

excel.close()

# send to e-mail
_from = 'thiago@techcd.com.br'
_to = 'thiago@techcd.com.br'
recipents = ['thiago@techcd.com.br','rene@techcd.com.br']

message = MIMEMultipart()

message['from'] = _from
message['to'] = _to
message['Cc'] = ','.join(recipents)
message['subject'] = ''' Relatorio de TechCD , Midia Center e Data Store referente á  {0} até {1} '''\
    .format(params[0].date().__format__('%d/%m/%y'), params[1].date().__format__('%d/%m/%y'))

body = '''
Bom dia,

este email esta sendo gerado e enviado automaticamente , ele se refere ao período de {0} á {1}.

O relatório possui 5 abas , vendas , estoque, NFe , contas a Receber, Despesas

o mesmo segue  em anexo  caso de  sugestão de melhoria no processo o duvidas ,

favor responder esse email ou  entrar em contato comigo por email, telefone ou WhatsApp

Obrigado.

Qualquer Duvida ou reclamação estamos a disposição.

--
Thiago Oliveira
TechCD Informática
Tel:+55 11-  3677-6655
Cel:+55 11- 97051-3508
www.rimagebrasil.com.br
http://www.techcd.com.br
skype: oliveiravicente.net
'''.format(params[0].date().__format__('%d/%m/%y'), params[1].date().__format__('%d/%m/%y'))

message.attach(MIMEText(body, 'plain'))

file_name = _report_file

attachment = open(file_name, "rb")
part = MIMEBase('application', 'octet-stream')
part.set_payload((attachment).read())

encoders.encode_base64(part)
part.add_header('Content-Disposition', "attachment; filename= %s" % file_name)
message.attach(part)

recipents.append(_to)

server = smtplib.SMTP('smtp.techcd.com.br', 587)
server.starttls()
server.login(_from, "mmnhbn")
text = message.as_string()
server.sendmail(_from, recipents, text)
server.quit()

path_destination = '/home/olvx/Documentos/Relatorios /CONSULTOR/enviado_por_scripts/'
os.rename(file_name, path_destination + 'report_enviado_' + _report_file)
