"""
Solução simpples para automatizar um processo de limpeza de uma arquivo de logo que anda parando um serviço,
o script depois de executado fica moniitorando uma pasta que deve ser configurada na varaivel self.path_monitor,
quando há uma alteração nessa pasta, ele lança um evento e verifica qual é o tamano do arquivo de log,
se for maior que o maximo permitido, configurado na variavel self.max_size , ele pegas as informações
do micro e envia por email que deve ser configurado como a conta smtp desejada, deleta o arquivo e
recria caso necessario, caso o serviço do log escolido a ser monitorado crie aotomanticamente o arquivo
quando ele nao existir, comente as linhas:
                # caso nao seja necessario crear o arquivo, descarte essas duas linhas
                open(self.log_file, 'w+')
                print('arquivo creado....')
usando o # (jogo da velha).
para a utiilização é necessario a installar o watchdog, que pode ser instalado usado o comando:
pip install watchdog
installa a bilioteca via terminal
"""
# !/usr/bin/python
import os
import datetime
import time
from smtplib import SMTP
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler


# executada quando lançado um evento na pasta monitorada
class LogMonitorHandler(FileSystemEventHandler):
    def __init__(self):

        """ Informações de disco """
        """ cheque o a quantidade de espaco livre no hd e delete arquivos ou pastas na lista """
        disk = os.statvfs('/')
        self.used = (disk.f_blocks - disk.f_bfree) * disk.f_frsize
        self.free = (disk.f_bavail * disk.f_bsize)
        self.total = (disk.f_blocks * disk.f_bsize)

        """ configurações da pasta e tamanho de arquivo """
        self.path_monitor = ''  # pasta ser munitorada
        self.log_process = ''  # arquivo a ser recriado(caso ne necessario)
        self.log_file = ''  # arquivo de log
        self.max_size = 1000  # configura o tamanho maximo para o arquivo

    def on_modified(self, event):

        if os.path.exists(self.log_file):
            """Cheque o tamanho do arquivo e remove se for maior que tamnho permitido"""
            log_size = os.path.getsize(self.log_file)
            if log_size > self.max_size:
                print('##############################################')
                print('log gerado: ', str(datetime.datetime.now()))
                print('tamanho exedico...')
                print('enviado notificação...')
                """ Enviar notificação que o processo de reset do log foi realizado """
                debuglevel = 0
                smtp = SMTP()
                smtp.set_debuglevel(debuglevel)
                smtp.connect('', 587)
                smtp.login('', 'mmnhbn')
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
                os.remove(self.log_file)

                # caso nao seja necessario crear o arquivo, descarte essas duas linhas
                open(self.log_file, 'w+')
                print('arquivo criando....')


if __name__ == '__main__':
    event_handler = LogMonitorHandler()
    observer = Observer()
    observer.schedule(event_handler, path=event_handler.path_monitor, recursive=False)
    observer.start()

    try:
        while True:
            time.sleep(10)

    except KeyboardInterrupt:
        observer.stop()
    observer.join()
