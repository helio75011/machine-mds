# Comment
# FROM
# L’instruction FROM est celle que vous allez mettre au tout début, après les directives bien évidemment.
# C’est celle-ci qui sera exécutée en premier par le docker daemon. FROM sert à spécifier l’image de base que vous allez utiliser,
# image qui sera présente sur Docker Hub. Sans cela, l’image que vous souhaitez construire sera invalide,
# car c’est à partir de cette instruction qu’elle va être initialisée.
# Une seule commande peut être placée au-dessus d’une commande FROM à savoir ARG.
# Cette dernière ne sera pas prise en compte lors de la création de l’image,
# mais sert seulement à initialiser une variable nécessaire à l’initialisation de votre image à partir d’une image de base.

ARG
ARG permet de définir une variable utilisable au cours de l’exécution des instructions dans dockerfile.
Si on la définit avant la commande FROM, elle ne sera pas prise en compte lors de la construction de l’image.
Cependant, si elle se trouve en bas de FROM, docker daemon va l’exécuter en lui attribuant une valeur par défaut si celle-ci
n’est pas spécifiée au moment du lancement du build.

ENV
ARG et ENV sont à peu près les mêmes commandes, car elles servent toutes à déclarer une variable.
Cependant, ARG n’est disponible qu’au moment de l’exécution du dockerfile tandis que ENV peut être accessible même lorsque le conteneur
créé par l’image sera lancé. Il s’agit de ce que l’on appelle une variable d’environnement, c’est-à-dire des variables qui sont nécessaires
à l’exécution même du conteneur et de l’application.
Par exemple, on déclare souvent les informations d’authentification à une base de données dans des variables d’environnement.

WORKDIR
Cette commande permet de spécifier le répertoire dans lequel seront basées les instructions qui suivront son appel.
Toutes les commandes correspondantes au build de l’image à savoir RUN, ADD et COPY seront donc affectées au chemin mentionné dans WORKDIR.
Il en va de même des commandes nécessaires à l’exécution du conteneur à savoir EXPOSE, CMD et ENTRYPOINT.
Le répertoire par défaut de l’exécution des instructions est le répertoire actuel à savoir "/".
On peut définir plusieurs WORKDIR tout le long du dockerfile.
Si aucune commande n’est spécifiée, WORKDIR sera automatiquement créé par Docker.

USER
Tout comme WORKDIR, USER permet d’initialiser un contexte spécifique pour l’exécution des commandes qui le suit. Ici, USER sert à déterminer l’utilisateur ou le groupe d’utilisateur pouvant interagir avec l’image qui sera créée.

USER user1
# suite des instructions

Si aucune commande USER n’est spécifié, celles qui suivront seront exécutées avec l’utilisateur root. Mais si l’on décide d’y attribuer une valeur, il faut que cet utilisateur existe, donc il faut le créer à l’aide de la commande :

net user /add

ADD
L’instruction ADD permet de copier un fichier ou un dossier venant d’un répertoire interne ou externe vers un chemin de destination contenant le système de fichiers de l’image. Généralement, il s’agit du code source et des dépendances de l’application que l’on va faire tourner dans le conteneur.
Il y existe cependant plusieurs façons de spécifier la destination du contenu à ajouter :

    De manière relative :

ADD test.txt path/

Ici, on ajoute le fichier test.txt à la destination spécifiée dans WORKDIR en ajoutant le chemin mentionné sur la destination. En réalité, le chemin absolu de la destination est <valeur_WORKDIR>/path/

    De manière absolue :

ADD test.txt /path/

Dans ce cas-ci, le fichier test.txt sera directement ajouté au chemin path/.

COPY
COPY et ADD agissent de la même manière, mais contrairement à ADD, COPY ne permet pas d’importer des documents venant d’une source distante telle qu’une URL. Dans la plupart des cas, on utilise COPY afin d’éviter des désagréments causés par l’utilisation de liens externes autorisés par ADD.

On peut exécuter ces commandes, que ce soit COPY ou ADD, plusieurs fois au sein d’un dockerfile. Sa syntaxe est similaire à celle de ADD à savoir :

COPY

Si l’on ne spécifie pas la destination, le fichier ou le dossier sera copié à la racine du système de fichier de l’image créée.

RUNN


La commande RUN permet d’exécuter des commandes supplémentaires à l’intérieur du build du dockerfile. L’argument qu’elle prend est identique à une commande Shell ordinaire. On peut donc s’en servir afin de télécharger et d’installer les dépendances nécessaires à l’application ou encore à directement afficher un résultat ou un message. Voici la syntaxe de base de la commande :

RUN

Ici, on exécute une commande qui affiche ‘hello world’.

On peut également utiliser RUN sous la forme exec. Dans ce cas, au lieu de spécifier l’argument comme une commande Shell, on utilise la notation suivante :

RUN ["executable", "param1", "param2"]

On utilise ce format surtout lorsque l’image de base ne possède pas d’exécutable Shell.

Pour éviter que l’image s’alourdisse, on peut spécifier plusieurs commandes à l’intérieur de l’argument d’une seule commande RUN.

EXPOSE
Cette commande permet de rediriger l’exécution du conteneur qui sera lancé à partir de l’image créée par le dockerfile vers un port prédéfini. C’est sur le port qui sera mentionné que le conteneur sera accessible lorsqu’une commande docker run sera exécutée. Cependant, le port exposé à l’aide de la commande EXPOSE peut être écrasé en utilisant la commande docker run -p. EXPOSE supporte les protocoles TCP et UDP, la syntaxe de base est celle-ci :

EXPOSE /

On peut par exemple spécifier que le conteneur est exposé sur le port 80 en utilisant cette commande :

EXPOSE 80/tcp

CMD & ENTRYPOINT
Ces deux commandes servent à mentionner les instructions qui seront exécutées en premier au moment du lancement du conteneur créé à partir de l’image obtenue avec le dockerfile. Ce qui différencie ces deux commandes est que CMD permet d’exécuter une action sans avoir besoin de paramètres supplémentaires tandis que ENTRYPOINT est inchangeable et exécute la même action tout le long de l’activation du conteneur. Dans ce cas, il agit comme un fichier exécutable.

Voici un exemple d’instructions utilisant ces commandes :

ENTRYPOINT [‘echo’, ‘hello’, ‘world’]
CMD [echo ‘hello world’]

Ces deux commandes donnent les mêmes résultats, c’est pour cela que, parfois, on n’utilise qu’une seule d’entre elles, malgré le fait que l’on peut tout à fait les utiliser ensemble.