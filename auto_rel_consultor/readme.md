# **Scripts
#### tenho algumas planilhas e alguns .vbs funcionando a ideia é trocar
#### tudo por scripts em python, tenho alguns aplicativos em java também
#### esses vou colocar em outro repositório mas pretendo mudar tudo para python

Esse repositório vou deixar para guardar scripts utilizados que precisei usar em algum momento
por alguma razão especifica assim se precisar de algo parecido já tenho um ponto de partida

## **rel_consultor**
esse relatório juntou os outros de vendas , contas , pagar , a receber e estoque para ele que ele possa
possa fazer um consultoria em nossa contas nos orientando no carecimento  empresa , eu já criei as procedures no SQL-Server
e automatizei o processo com Python sei que tem muito para evoluir no modo de escrever esse script  mas a solução esta funcionado muito
bem e poupando um tempo valioso e tedioso que era fazer isso todos os mesmo e conferir, assim otimizei meu tempo  e resolvi um problema na empresa

## **script_clear_log & script_monitor_log**
desenvolvido para eliminar um arquivo de log que está ficando muito grande e
acaba parando um serviço gerando alguns problemas

a diferença entre script_clear_lg e script_monitor_log, é que
o script_monitor_log fica monitorando a pasta configurada com o
watchdog que quando gera alguma alteração na pasta ele verifica
o tamanho do arquivo caso necessário ele da um reset deletando e craindo
um arquivo de log vazio

## **to_comper_files_in_path**
esse script foi realizado para resolver um problema , tenho um sistema que usa uma pasta
para armazenar as fotos dos produtos , essa pasta atualmente fica em \\file_server\fotos
os sistema verifica se existe um gif como o código do produto caso existe ele exibe uma foto
com o produto, ela pode conter uma foto para thumbnail essa foto fica armazenada nessa pasta
com o código do produto + p.gif ,
criei esse script pa eu precisava saber quais fotos eu tinha thumbnail e qual tinha o tamanho padrão
ele acesso o banco retiva os produtos com codigos e verifica se o codigo está na lista de arquivos 
da pasta, uma lista para arquivos thumbnail outro para arquivos tamnho padrão.


# Configurar pra uso
  self.path_monitor = ''    pasta ser monitorada
  self.log_process = ''     arquivo a ser recriado(caso ne necessario)
  self.log_file = ''        arquivo de log
  self.max_size =           configura o tamanho maximo em bytes para o arquivo

  smtp.connect('smtp.dominio.com.br', 587)     smtp  responsável enviará o e-mail
  smtp.login('email@dominio.com.br', 'senha')  e-mail e senha da conta de envio
  from_addr = "conta_envio@dominio.com.br"     e-mail conta de envio
  to_addr = "email_recebe@dominio.com.br"      e-mail para quem o e-mail será enviado


# instalação na sua máquina

```bash
git clone  git@github.com:olivx/scripts.git scripts
cd scripts
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

