# Bdd

### Pour mettre en place postgis sur un raspberry Pi

    docker pull tobi312/rpi-postgresql-postgis

Création du dossier de data  

    cd /mnt/Data
    mkdir postgis


    docker run --name postgis -d -p 5432:5432 -v /mnt/Data/postgis:/var/lib/postgresql/data -e POSTGRES_PASSWORD=postgres tobi312/rpi-postgresql-postgis
