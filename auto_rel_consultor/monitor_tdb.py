# -*- coding: utf-8 -*-


#import necessarios
import os
import sys
import time
import datetime
from time import gmtime , strftime
#import de pacotes de testes 
import unittest

#import para monitorar pasta 
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler


class Copiar_JDF_to(FileSystemEventHandler):

	#Contrutor da classe
	def __init__(self):
		#Pasta que ira trabalhar
		self.pasta_monitorada = 'C:\\EPSON\\TDBridge\\IN\\'
		self.copiar_para = 'C:\\EPSON\\TDBridge\\Orders\\'

	#Faz magina no monitoramento	
	def catch_all_handler(self, event):
		pass

	#evento que monitora 
	def on_created(self, event):
		print('***********************************************************************************************')
		print (self.getTime())
		print ('CREATE ' + str(event))
		self.vamo_que_vamo()
		print ('ARQUIVO COPIADO PARA ' + self.copiar_para)
		print('***********************************************************************************************')
		self.catch_all_handler(event)

	def on_modified(self, event):
		print('=================================================================================================')
		print (self.getTime())
		print ('ARQUIVO RENOMEADO ' + str(event))
		self.vamo_que_vamo()
		print ('ARQUIVO RENOMEADO EM' + self.pasta_monitorada)
		print('=================================================================================================')
		self.catch_all_handler(event)

	#Eh quem faz a magica	
	def vamo_que_vamo(self):

		#Lista todos arquivos no diretorio
		files = os.listdir(self.pasta_monitorada)
		
		#Incluir na lista somente os .JDF
		lista  = [file for file in files if file.split('.')[-1] == 'JDF']
		
		#Varre a lista 
		for JDF in lista:
			data = {}
			#Abre o arquivo e preeche o dicionario 
			for line in open(JDF):
				#Se não houver valores separados por '=' ignore a linha
				if not line.find('=') == -1:
					key,value =  line.strip().split('=')
					data[key] = value

			#Escrevendo arquivo		
			with open(self.copiar_para + JDF ,'w') as write_JDF:
				#Percorre o  dicionario
				for key,value in data.iteritems():
					#Verifica qual o tipo  de disco, queremos os DVD sejam dual layer/***//////////////
					if key == 'DISC_TYPE' and value == 'DVD':
						value = 'DVD-DL'
					write_JDF.write(key + '=' + value +'\n')

			#Renomeando Arquivo
			self.rename_to_DON(JDF)

	#Renomendo arquivo				
	def rename_to_DON(self,arquivo):
		arq,ext = arquivo.split('.',1)
		arq += '.DON'
		os.rename(arquivo,arq)

	#Pegando data e hora 	
	def getTime(self):
		return strftime("%Y-%m-%d %H:%M:%S", gmtime())

	#Fazendo Log no arquivo
	def log(self, log):
		with open(self.pasta_monitorada + 'log_monitoramento.txt', 'a' ) as log_file:
			log_file.write(log)

	#Metodo Principal				
	def main(self):
		eventos = Copiar_JDF_to()
		observador = Observer()
		observador.schedule(eventos, self.pasta_monitorada , recursive=False)
		observador.start()

		try:
			while True:
				time.sleep(1)
		except KeyboardInterrupt:
			observador.unschedule(eventos)
			observador.stop()
		observador.join()
		print ("FIM")
				#self.vamo_que_vamo()

#Chama o metodo principal
if __name__ == '__main__':
		#unittest.main()	
		obj =  Copiar_JDF_to()
		obj.main()
