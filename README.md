# scripts helper

## Introdução

 -  Esses script foram escritos para que possa automatizar tarefas simples do meu dia a dia,
    coisa chatas ou repetitivas que não quero fazer toda horas, alguns desses trabalhos eram,
    apenas repetidos outros precisa fazer algo para um cliente ou outro...

### check_valid_util_license_perennity
- problema:
    Existe um software chamado Pernnity o qual damos suporte, e normalmente quando fazemos a instalação instalamos um licença **demo**
    o meu feche sempre quer instalar a licença **demo** antes mesmo se o cliente tiver comprado a a **full**, bom a licença  demo funciona
    igual a **full** por 30 dias, o que acontece é que não tem o controle de quando solicitou e quando ele vencerá , a empresa Perennity é da Bélgica,
    então não tão simples solicitar uma licença, fora que ele também não tem controle das licença, que são vinculadas com `MAC ADDRESS`
    ai já viu, lá vem o cliente furioso por que a licença que ele comprou expirou! pergunta por que está instalado uma *demo* se ele comprou
    a *full* ai como não tinhamos controle, eu tenho que pedir o *mac address*, enviar para meu chefe, esperar a empresa Belga enviar, pedir o
    acesso remoto para instalar. em quanto isso o cliente fica parado com cara de taxo sem poder usar o software , muito mas muito puto! e o pior,
    ele tem toda razão, então o que fiz....

- solução:
    Criei uma planilha para estocar as instalações que faço, com `mac address` , `serial`, `chave` `data da instalação`, `data que expira`,
    assim já tenho um controle do que eu faço, depois criei um script em ´Python´ e coloquei ele para rodar no meu *cron*, assim uma vez por dia 
    meu *script no cron*, verifica se tem uma licença com até 5 dias de antecedência para expirar e 5 dias após ter expirado, 
    caso exista alguma licença nessa situação ele envia um aviso para o suporte contendo as informações do nome do cliente, 
    por e-mail o meu responsável peça a licença antes de expirar
    

- Proximo passo:
    Bom eu adorei fazer o script ver ele funcionado me avisando, mas como tem preencher uma planilha existe uma grande chance de dar problema,
    então sempre que tenho tempo estou trabalhando em um projeto que batizei de [webtechsis] que estou fazendo um *crud* mesmo em  *DJANGO*  
    para que outras pessoas talvez possa interagir com a solução, oque está indo para frente, quando o pessoal ver uma interface amigável 
    e bonita (bootstrap ta me ajudando muito com isso).
    esse [webtechsis] eu estou integrando junto com o sistema da empresa que chama Sistech, ele foi feito em `vb6` com `sql-server`, o que está sendo
    muito legal de fazer, apesar de dar muito trabalho tenho muita coisa fora de norma, o bom que estou evoluindo muito!
    pena que tenho pouco tempo para programar , já que aqui não sou programador, mas um dia chego lá!



### monitor
-  problema:
    esse cara foi o seguinte, nossos cliente em grande parte são da área medica, que fazem gravação de imagem tipo, tomográfica e e raio-X em mídias e
    agente fornece um software chamado [perennity] e um publicador de mídia, [Rimage] ou [Epson], mas alguns de nossos cliente usam outras soluções
    de software para gerenciar as gravações como nesse caso, por exemplo, eles usam o software fornecido pela [E-people], 
    software que gerencia as gravações faz o retrive do exame e manda gravar, normalmente software quem decide  qual mídia será usando e 
    caso passe de 600 MB ele vai mandar para um `DVD` isso é bem legal quando você tem `CD` e `DVD` no publicador que geralmente é configurado mas 
    nesse caso é necessário ter os dois tipos de mídia, requisito do software.  
    o que aconteceu,  era que o cliente tinha somente `DVD` e a maior parte das gravações são em `CD`, conversando com o cliente ele
    me disse que somente compraria `CD` na outra semana e que o pessoal da [E-people] disse que não tinha o que fazer.
   (não tinha o que fazer por que eles não sabem `Python`!  `Python` é vida!).

    

- solução:
    configurar para o [E-people] enviar os arquivos a serem gravados pelo [Epson] em uma pasta que não será monitorado pelo [Epson]
    criei um *script* que monitora esse o diretório e envia o arquivo `.JDF` que é o arquivo com os parâmetros a serem gravados, caso
    o arquivo contiver a a tag *MIDIA=CD* ele altera para *MIDIA=DVD* e copia o arquivo já com os paramos alterado para uma pasta que o
    [Epson] monitora, assim o [Epson] consegue fazer as gravações usando o software deles usando somente um tipo de mídia ... 
    pronto problema resolvido , cliente feliz , tudo mundo feliz !
    Meu supervisor, gostou da ideia, mas como fiz com `Script em Python`, ficava rodando no terminal e isso ele não achou ideal,
    disse que o cliente poderia pesar que é algum  vírus e fez uma interface, que ficou bem legal também e o cliente está usando até hoje, 
    eu pensei em fazer uma interface, mas como ele já tinha feito e tá funcionando, não vi necessidade. 

- próximo passo:
    colocar isso em uma interface gráfica talvez PyQT ou Tkinter, não sei...  mas isso é sem previsão...

### rel_contas_pagar_despesas
### rel_contas_receber
- problema:
    a contabilidade solicitava todos os nesses um relatório em Excel com de contas a pagar despesas e contas pagas e o sistema é legado e tem
    algumas partes não implantada, ele ate gera esses documentos mas não em Excel. Então fiz uma procedure par isso, por que os select que 
    o sistema tem para isso, está tudo chumbado no código. Como o processo é trabalhoso ... toda vez que era solicitada eu tinha que abrir o 
    sql-manager rodar o .sql copiar e colar o resultado para o Excel e , deixar com nome para poder achar no futuro e enviar por e-mail. 
    É simples mas, me fazia perder tempo. sempre que fazia o processo eu mudava e nunca fica bonitinho com mesmo padrão de nome de arquivo.

- solução:
    criação de uma script para padronizar os arquivos e o seus envios com datas e tudo mais agendados pelo cron!

### rel_estoque_movimentação
### rel_faturamento
- problema::
    esse caso aqui já foi muito parecido com o de cima, mas quem fazia solicitação não era a contabilidade e sim um consultor que está nos ajudando
    a mapear alguns problemas na empresa.

### script_clear_log
### script_clear_log_monitor
- problema:
    esses dois é o seguinte, um amigo falou que tinha um micro que as vezes trava por que tinha um log que ficava gigante, acho que era um servidor squid,
    não tenho certeza, não me lembro ao certo, foi umas das primeiras coisa que fiz com *Python*, ele nunca usou não sei se funciona,
    mas foi legal desenvolver a lógica e brincar com Python o *script_clear_monitor* talvez seja total responsável por eu ter abandonado o Java, pois
    jamais iria conseguir fazer algo em Java algo assim, rápido e simples. Na época eu estava meio transitório, tipo adorando Python mas como já sabia 
    Java estava inseguro. ai quando vi o whatdog rodando e monitorando uma pasta e tudo com tão pouco tempo de Python e esforço para escrever o script, 
    foi um estalo na minha mente, eu tinha me encontrado com uma linguagem que realmente era o meu perfil, já aprendi um pouco de c# e Java mas cara, 
    Python é sem igual e melhor do Python é sem duvida a comunidade, acho que isso é o que mais fez diferença no final.
    esse cara pode estar bem tosco, mas para mim foi separador de água.

### to_comper_files_in_path
- problema:
    no sistema legado que temos aqui na empresa. Temos as fotos dos produtos e no banco de dados, não são gravadas o caminho das fotos, como o sistema.
    e como o sistema sabe se o produto tem foto ou não ? bom ele procura em uma pasta na rede um arquivo .gif com o mesmo código do produtos e 
    não achar ele colocar uma imagem padrão
    ai vira e mexe o gerente de vendas quer saber quais os produtos que estão sem foto. e como é que vou saber ? 
    eu nem mexo no sistema hahahaha  ... se tivesse pelo menos o caminho para validar se tem um arquivo, ia ajudar e muito.
    

- solução
    script Python que cria uma listas com os nomes dos arquivos que existem na pasta e depois compara as listas de códigos de produtos
    e faço a comparação, assim sei que fotos faltam para os produtos
    lógico tem uma lógica mas foi legal também de fazer, eu fiz isso depois em VBA e na moral, em Python foi muito melhor e mais rápido e 
    mais fácil, VBA deu um trabalho, até por que eu não manjo nada de VBA, talvez vc saiba... 

### pasta SQL
- SQL
    contem alguns dos SQL que precisei fazer  para resolver alguns problemas ou empurrar eles , enquanto pensamos em soluções ou que iria
    resolver .


[webtechsis]: <https://github.com/olivx/webtechsis>
[perennity]: <http://www.perennitysoft.com/en/>
[Rimage]: <http://www.rimage.com/>
[Epson]: <https://www.epson.pt/products/discproducer/epson-discproducer-pp-100>
[E-people]: <http://www.epeople.com.br/>