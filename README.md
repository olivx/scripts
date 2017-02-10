# scripts helper

## Introdução

Esses script form escritos para que possa automatizar tarefas simples do meu dia a dia,
coisa chatas ou repetitvas que não quero fazer toda horas, alguns desses trabalahos eram,
apenas repetivos outros precisa fazer algo para um cliente ou outro...

### check_valid_util_license_perennity
- problema:
    Existe um software chamado Pernnity o qual damos suporte, e normalmente quando fazemos a instalação instalamos um licena **demo**
    o meu feche sempre quer instalar a licença **demo** antes mesmo se o cliente tiver comprado a a **full**, bom a licenã demo funciona
    igual a **full** por 30 dias, o que acontece é que não tem o controle de quando solicitou e quando ele vencerá , a empresa perennity é da Belgica,
    então não tão simples solicitar uma licensa, fora que ele tambem não tem controle das licença, que são vinculadas com `MAC ADDRESS`
    ai jpa viu, la vem o cliente furioso por que a licença que ele comprou expirou perguntar por que está instalado uma *demo* se ele comprou
    a *full* ai como ele não tem controle, eu tenho que pedir o *mac address* enviar para meu chefe, esperar a empresa Belga enviar pedir o
    acesso remoto para instalar, em quanto isso o cliente fica parado com cara de taxo sem poder usar o software , muito mas muito puto e o pior
    ele tem toda razão, então o que fiz....

- solução:
    Criei uma planição para estocar as instalações que faço, com `mac address` , `serial`, `chave` `data da instalação`, `data que expira`,
    assim já tenho um controle do que eu faço, depois criei um script em ´Python´ e coloquei ele para rodar no meu *cron*, que aqui por sinal
    são contra o uso do linux ...  vai entender ? bom voltando ao assunto, assim uma vez por dia o meu *script no cron*, verifica se tem uma
    licença com até 5 dias de antecedencia dele expirar e 5 dias depois que ele já expirou, caso exista alguma licença nessa situação ele envia
    o nome do cliente, o `mac address` a `serial` do cliente por e-mail para que possa passar para o meu feche para que a licença não expire e acredite
    se quiser ele ainda deixa licença expirar hahaa...  mas beleza eu fiz minha parte...

- Proximo passo:
    Bom eu adore fazer o script ver ele funcionado me avisando, mas como comentei há cima ele não crute linux, na verdade ele fã de Microsoft,
    então ele não deu bola para meu *script* e sou eu uso ele mesmo, e como tem preencher uma planilha ninguem quer usar, então sempre que tenho
    tempo estou trabalhando em um projeto que batizei de [webtechsis] que estou fazer um *crud* mesmo em  *DJANGO*  para que outras pessoas talvez
    me ajudem a cadastrar as licenças e quando tiver pronto eu mudo o *script* para buscar no banco de dados em vez de buscar em uma palhanição,
    esse [webtechsis] eu estou integrando junto com o sistema da empresa que chama Sistech, ele foi feito em `vb6` com `sql-server`, o que está sendo
    muito legal de fazer, pena que tenho pouco tempo para programar , já que aqui não sou programador, mas um dia chego lá!



### monitor
-  problema:
    esse cara foi o seguinte, nosso cliente em grande parte são da area medica, que fazem gravação de imagem tipo, tomografica e e rio-x em cd,
    agente fornece um software chamdo [perennity] um publicador de midia, [Rimage] ou [Epson], mas alguns de nossos cliente usam outras soluções
    de software que necesse caso era da [E-people], no software dele quando o usuario faz o retrive do exame e manda gravar é o software quem decide
    qual mídia será usando e você não pode opinar, caso passe de 600 mb ele mandar para um `DVD` isso é bem legal quando você tem `CD` e `DVD`
    no gravador, o que aconteceu era que o cliente tinha somente `DVD` e a maior parte das gravações são em `CD`, conversando com o cliente ele
    me disse que somente compraria `CD` na outra semana e que o pessoal da [E-people] disse que não tinha o que fazer se eu podia ajudar, não tinha o
    que fazer por que ele não sabem nada `Python` e `Python` é vida!

- solução:
    configurar para o [E-people] enviar os arquivos a serem gravados pelo [Epson] em uma pasta que não será munitorado pelo [Epson]
    criar um *script* que lê o diretorio que é enviado o arquivo `.JDF` que é o arquivo com os parametros a serem gravador, caso
    o arquivo contiver a a tag *MIDIA=CD* para para *MIDIA=DVD* e copiar o arquivo já com os paramtros alterado para uma pasta que
    [Epson] munitore e possa fazer a gravação do jeito correto... pronto problema resolvido , cliente feliz , tudo mundo feliz , certo ?
    bom quase, meu chefe não gosta de linux, não curte `Python`, então como era um *script* e fica rodando com terminal ele nãom gostou,
    disse que o cliente ia pesar que é um virus e uson uma parada um software de clicar e arastar para fazer uma interface, bom o mais
    importante é que o cliente ficou feliz e seu problema foi solucionado, eu fiz o *script* em no meu horario de almoço e ele demorou
    mumas 3 semanas para fazer, quando ficou pronto o cliente não precisava mais do *script* nem do `app` dele mas ele fez questão de colocar
    por mim sem crise !

- proximo passo:
    colcoar isso em uma inteface grafica talvez PyQT ou Tkinter, não sei mas isso é sem previsão...

### rel_contas_pagar_despesas
### rel_contas_receber
- problema:
    a contabilidade solicitava todos os messes um relatorio em excel com as contas a pagar dispesas e contatoas pagas, o sistema é legado e tem
    algumas partes não implentada , sem documentação e uma loucuras no meio, então produzi meu propria procedure  par aisso para ficar no formato
    que me pediram e toda vez que era solictada eu tinha que abrir o sql-manager rodar o .sql copiar e coloar o resultado para o exele , deixar com
    nome para pdoer achar no futuro e enviar por e-mail, simples mas me fazia perder um tempos as vezes e sempre que fazia o processo eu mudava como
    não deixar o nome do arquivo em um determinado padrão.

- solução:
    criação de uma script para padrodizar os arquivos e o seus enviaos com datoas e tudo mais agendados pelo cron

### rel_estoque_movimentação
### rel_faturamento
- problema::
    esse caso aqui já foi muito parecido com o decima, mas quem fazia solicitação não era a contabilidade e sim um consultor que está nos ajudando
    a mapear alguns problemas na empresa.

### script_clear_log
### script_clear_log_monitor
- problema:
    esse dois é o seguinte, um amigo falou que tinha um micro que as vezes trava por que tinha um log que ficava gigante, acho que era um servidor squid,
    não tenho certeza, não me lembro ao certo, bom foi bem no começo umas das primeiras coisa que fiz com python, ele nunca usou não sei se funciona,
    mas foi legal desenvolver a logica e brincar com python o *script_clear_monitor* talvez seja total responsavel por eu ter abandonado o java, pois
    jamais iria conseguir fazer algo em java assim e na epoca eu estava meio transitorio, tipo adorando python mas como já sabia java estava inseguro
    ai quando vi o whatdog rodando e monitorando uma pasta e tudo com taão pouco tempo de python e esforço para escrever o script, foi um estalo na
    minha mente, eu tinha me encontrado com uma liguagem que realmente era o meu perfil, já aprendi um poudo de c# e java mas cara, Python é sem igual
    esses cara podem estar bem tosco, mas para mim foram separadores de água.

### to_comper_files_in_path
- problema:
    no sistema legado que temos aqui na empresa, temos as fotos dos produtos, no banco de dados não são gravadas o caminho das fotos, como o sistema
    sabe se o produto tem foto ? bom ele procura em uma pasta na rede um arqui .gif com o mesmo codigo do produto,s e não achar ele colocar uma imagem padão
    ai vira e mexe meu feche me perguntava quais são os produtos sem fotos no sistema e como é que vou saber ? eu nem mexo no sistema ... se tivesse pelomenos
    o caminho para validar se aquile caminho tem um arquivo, ia ajudar e muito, mas os vbzeiros nunca ajudam....

- solução
    script python para para criar listas e depois compara as listas vendo oque tenho em uma mas não em outras, assim sei que fotos faltam para os produtos
    logico tem uma logica mas foi legal tambem de fazer, eu fiz isso depois em VBA e na moral, em python vou muito melhor e mais rapido e mais facil, VBA deu
    um trabalho...  hahaha Python é vida!

### pasta SQL
- sql
    contem alguns dos sql que precisei fazer  para resolver alguns problemas ou empurrar eles , enquato pensamos em soluções ou que iria
    resolver .


[webtechsis]: <https://github.com/olivx/webtechsis>
[perennity]: <http://www.perennitysoft.com/en/>
[Rimage]: <http://www.rimage.com/>
[Epson]: <https://www.epson.pt/products/discproducer/epson-discproducer-pp-100>
[E-people]: <http://www.epeople.com.br/>