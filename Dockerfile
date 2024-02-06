# Initialise une nouvelle étape de construction et
# définit l'image de base
FROM node:latest
# WORKDIR définit le répertoire
# de travail pour les instruction à suivre
WORKDIR /app
# La commande COPY permet de copier des fichiers ou des 
# répertoire depuis le système hôte vers le système de fichiers
# de l'image en cours de construction
COPY ./package.json app/package.json
# La commande RUN permet d'executer des commandes dans une nouvelle
# couche au-dessus de l'image en cours de construction et de
# valider les résultats pour créé une nouvelle image.
RUN npm install
COPY . .
# La commande EXPOSE définit le port d'écoute de l'image
EXPOSE 5000
# La commande CMD définit la commande à
# exécuter par défaut lors du démarrage d'un conteneur
# à partir de l'image construite.
CMD [ "npm", "run", "start" ]
