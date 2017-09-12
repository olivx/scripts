from calendar import monthrange
from datetime import datetime, timedelta
import pyodbc
import pandas
import os

import smtplib
from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


def relatorio(ini, finish):
    # string de conexão
    _string_conection = 'DRIVER={FreeTDS};SERVER=192.168.0.204;PORT=1433;DATABASE=TECHCD;UID=sa;PWD=tigre177;TDS_Version=7.0'

    # params
    params = []
    params.append(ini)
    params.append(finish)

    # nome do arquvios
    _report_file = 'relatorio_consultor_' + str(ini.date()) + '_' + str(finish_date.date()) + '.xlsx'

    # query's
    _query_faturamento_header = 'exec SP_REL_CONSULTOR_FATURAMENTO_HEADER @INI = ?, @FIM = ?'
    _query_faturamento_detail = 'exec SP_REL_CONSULTOR_FATURAMENTO_DETAIL @INI = ?, @FIM = ?'

    # work on pandas
    excel = pandas.ExcelWriter(_report_file)
    pandas.formats.format.header_style = None

    connection = pyodbc.connect(_string_conection)
    report_faturamento_header = pandas.read_sql_query(_query_faturamento_header, connection, params=params)
    report_faturamento_detail = pandas.read_sql_query(_query_faturamento_detail, connection, params=params)

    report_faturamento_detail.to_excel(excel, sheet_name='VENDAS', index=False)
    report_faturamento_header.to_excel(excel, sheet_name='NFE', index=False)
    excel.close()

    # send to e-mail
    _from = 'thiago@techcd.com.br'
    _to = 'thiago@techcd.com.br'
    # recipents = ['thiago@techcd.com.br']
    recipents = ['thiago@techcd.com.br', 'rene@techcd.com.br', 'ekaplan@e2gestao.com']

    message = MIMEMultipart()

    message['from'] = _from
    message['to'] = _to
    message['Cc'] = ','.join(recipents)
    message['subject'] = ''' Relatorio de TechCD , Midia Center e Data Store referente á  {0} até {1} ''' \
        .format(params[0].date().__format__('%d/%m/%y'), params[1].date().__format__('%d/%m/%y'))

    body = '''
    Bom dia,

    este email esta sendo gerado e enviado automaticamente , ele se refere ao período de {0} á {1}.

    O relatório possui 2 abas , Vendas , NFe , 

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

    path_destination = '/home/olivx/Documentos/Relatorios/CONSULTOR/' \
                       'envado_por_script_vendas_semanal/'
    os.rename(file_name, path_destination + 'report_enviado_' + _report_file)


if __name__ == '__main__':
    finish_date = datetime.today()
    init_date = datetime(finish_date.year, finish_date.month, 1).replace(hour=7, minute=0, second=0)
    # init_date = (finish_date.replace(hour=7, minute=0, second=0) - timedelta(days=31))

    relatorio(ini=init_date,finish=finish_date)
