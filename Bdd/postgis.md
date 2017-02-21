# Bdd

### Pour mettre en place postgis sur un raspberry Pi

Création du dossier postgresql et lancement image postgis

    docker pull tobi312/rpi-postgresql-postgis

    docker run --name postgis -d -p 5432:5432 -v /mnt/Data/postgresql:/var/lib/postgresql/data -e POSTGRES_PASSWORD=docker tobi312/rpi-postgresql-postgis:latest

Utilisation de postgis:  

    docker run -it --rm --link postgis:postgres tobi312/rpi-postgresql-postgis psql -h postgres -U postgres

Remplissage de la bdd à la main
