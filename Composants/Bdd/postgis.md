# Bdd

### Pour mettre en place postgis sur un raspberry Pi

Création du dossier postgresql et lancement image postgis (sur le registry)

    docker pull piensg017.ensg.eu:5000/rpi-postgresql-postgis:latest

L'image contient à la fois le server et un client postgres/postgis.
Démarrer le server postgresql dans un container:  

    docker run --name postgis -d -p 5432:5432 -v /mnt/Data/postgresql:/var/lib/postgresql/data -e POSTGRES_PASSWORD=docker piensg017.ensg.eu:5000/rpi-postgresql-postgis:latest

Test de postgis (lancement d'un client dans un autre container):  

    docker run -it --rm --link postgis:postgres piensg017.ensg.eu:5000/rpi-postgresql-postgis:latest psql -h postgres -U postgres

Remplissage de la bdd à la main

### Lien utile :

Provenance de l'image:  
  https://hub.docker.com/r/tobi312/rpi-postgresql-postgis/
