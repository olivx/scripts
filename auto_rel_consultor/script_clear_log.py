# !/usr/bin/python
import os
import datetime
from smtplib import SMTP


# executada quando lançado um evento na pasta monitorada


""" Informações de disco """
""" cheque o a quantidade de espaco livre no hd e delete arquivos ou pastas na lista """
disk = os.statvfs('/')
used = (disk.f_blocks - disk.f_bfree) * disk.f_frsize
free = (disk.f_bavail * disk.f_bsize)
total = (disk.f_blocks * disk.f_bsize)
""" configurações da pasta e tamanho de arquivo """
path_monitor = ''  # pasta ser munitorada
log_process = ''  # arquivo a ser recriado(caso ne necessario)
log_file = ''  # arquivo de log
max_size = 1000  # configura o tamanho maximo para o arquivo


if os.path.exists(log_file):
    """Cheque o tamanho do arquivo e remove se for maior que tamnho permitido"""
    log_size = os.path.getsize(log_file)
    if log_size > max_size:
        print('##############################################')
        print('log gerado: ', str(datetime.datetime.now()))
        print('tamanho exedico...')
        print('enviado notificação...')
        """ Enviar notificação que o processo de reset do log foi realizado """
        debuglevel = 0
        smtp = SMTP()
        smtp.set_debuglevel(debuglevel)
        smtp.connect('', 587)
        smtp.login('', '')
        from_addr = ""
        to_addr = ""

        date = datetime.datetime.now().strftime("%d/%m/%Y %H:%M")
        message_text = "O log do squid foi removido as: {0}".format(date)

        subj = "log do squid foi removido "
        msg = message_text
        smtp.sendmail(from_addr, to_addr, msg)
        smtp.quit()

        print('notificação enviada.... ')
        print('arquivo deletado....')
        os.remove(log_file)

        # caso nao seja necessario crear o arquivo, descarte essas duas linhas
        open(log_file, 'w+')
        print('arquivo criando....')




