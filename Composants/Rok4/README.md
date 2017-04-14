# Service rok4

> **Objectif** : Pour voir lancer le service Rok4 avec un jeux de données exemple dans un container qui pourra ensuite être *load-balancé* via **Docker Swarm** et accolé à un front-end public.

Le travail consiste à :

* mettre en place les données exemples, en profitant de **Glusterfs**
* configurer le docker Rok4 pour qu'il accède à ces données
* liver le tout sous forme de fichier *docker-compose.yml* pour faciliter l'intégration dans **Docker Swarm**.


## Déploiement des données 

Résumé de la procédure :

* récupération des données sur la machine de travail
* copie sur les RPI
* correction des chemins d'accès dans certain fichiers
* définition du docker pour lancer le service

### Récupération des données

Deux docker permettent sous Ubuntu de récupérer les données avec la bonne arborescence dans un répertoire local.

Dockers disponible sur hub.docker.com : [data-scan1000](https://hub.docker.com/r/rok4/data-scan1000/) et [bdortho](https://hub.docker.com/r/rok4/data-bdortho-d075/)


``` sh
$ docker pull rok4/data-scan1000
$ docker pull rok4/data-bdortho-d075
$ docker run -it --name scan1000 -v $PWD/data:/data rok4/data-scan1000 /bin/sh
``` 

Une fois dans le container *data_scan1000* :
``` sh
/ # cd data
/data # mkdir scan1000
/data # cd scan1000/
cp -r /rok4/config/pyramids/SCAN1000_PYR-JPG_FXX_PM/* .
```

De même après avoir lancé le docker *data_bdortho*  :
``` sh
/ # cd data
/data # mkdir bdortho
/data # cd bdortho/
/data/bdortho # cp -r /rok4/config/pyramids/ORTHO_JPG_PM_D075/* .
```

### Copie sur les raspberry (sur Glusterfs)

L'objectif est d'exploiter **Glusterfs** pour ne pas avoir à dupliquer les données sur tous les RPI proposant le service **Rok4**.

Toutes les données *scan1000* et *bdortho* sont copiées sur le volume géré par Glusterfs. 

``` sh
$ sudo apt-get install glusterfs-client
$ sudo mount -t glusterfs 172.31.57.64:/gfsdata /mnt/cpdata
$ sudo mkdir geodata
$ cd geodata/
$ sudo cp -r ~/workcp/Docker_Perso/data/* .
``` 
### Modification dans les fichiers layers

Les fichiers pyramides (.pyr) sont lus à partir de la définition des fichiers *layers*. Il faut les modifier pour que le container **rok4** puisse les trouver. 

Les fichiers à éditer sont maintenant dans le volume géré par Glusterfs : `/mnt/Data/geodata`

* bdortho

``` sh
HypriotOS/armv7: pirate@piensg010 in /mnt/Data/geodata/bdortho
$ sudo nano ORTHO_JPG_PM_D075.lay 
```


``` xml
<pyramid>../pyramids/bdortho/ORTHO_JPG_PM_D075.pyr</pyramid>
``` 

* scan1000

``` sh
HypriotOS/armv7: pirate@piensg010 in /mnt/Data/geodata/scan1000
$ sudo nano SCAN1000_PYR-JPG_FXX_PM.lay
```


``` xml
<pyramid>../pyramids/scan1000/SCAN1000_PYR-JPG_FXX_PM.pyr</pyramid>
```

### docker-compose.yml pour rok4

On utilise l'image existante **rok4/rok4:arm-http**  présente sur [github/tcoupin](https://github.com/tcoupin/docker-rok4).

Le chemin où sont attendus les fichiers layer est décrit dans le fichier [startRok4](https://github.com/tcoupin/docker-rok4/blob/master/startRok4.sh) :

`find /rok4/config/pyramids/ -name *.lay -exec cp '{}' /rok4/config/layers/ \;`

Ce qui donne un montage de volumes (dans *docker-compose.yml*) :
``` sh
    volumes:
      - /mnt/Data/geodata/scan1000:/rok4/config/pyramids/scan1000
      - /mnt/Data/geodata/bdortho:/rok4/config/pyramids/bdortho
```
Le service est lancé localement (sur un seul RPI) par `docker-compose up -d` dans le répertoire où se trouve de fichier *yaml*.

## Déploiement

### Vérification de la disponibilité 

Le docker est lancé sur le RPI 172.31.57.69 avec redirection sur le port 8092 (ligne ` ports: 
      - 8083:80
`)

A partir d'une machine sur le réseau :

* Services disponibles 
`http://172.31.57.69:8092/rok4?service=WMS&request=GetCapabilities`

* Requête web
`http://172.31.57.69:8092/rok4?SERVICE=WMS&REQUEST=GetMap&VERSION=1.3.0&LAYERS=ORTHO_JPG_PM_D075&STYLES=normal&CRS=EPSG:3857&WIDTH=3000&HEIGHT=3000&BBOX=242152,6229923,291072,6264167&FORMAT=image/png`

* Sous QGIS, ajouter couche WMS : `http://172.31.57.69:8092/rok4`

### Déploiement de l'image

L'image est ensuite hébergée sur le **Docker Registry** local à notre réseau de RPI pour être ensuite "lancée" par **Docker Swarm** sur un certain nombre de RPI.

### Accès au service

**Traefik** gère l'accessibilité de l'application.

## Tests de charge

### Modification des variables d'environnement

Ce test consiste à voir l'effet d'une modification du nombre de *threads* pour un seul service (par de Docker Swarm / *load balancing*)

Variables d'environnement dans le fichier compose :
``` sh
    environment:
      - ROK4_SERVER_NBTHREAD="20"
      - ROK4_SERVICE_ABSTRACT="rok4_with_20_threads"
```
Vérification dans :
`docker exec -it rok4compose_rok4_1 /bin/bash` puis `more /tmp/custom_env`

Les *quotes* ne sont pas prises en compte, ce qui oblige à mettre des '\_' dans les champs texte. `ROK4_SERVICE_ABSTRACT` permet uniquement de vérifier que l'on accède bien au service Rok4 modifié.

Vérification sur le serveur web : `http://172.31.57.69:8083/rok4?service=WMS&request=GetCapabilities`

## Déploiement continu

Redéploiement du service suite à une mise à jour de l'image sur le **Registry privé**.

Il existe des solutions pour mettre en place un CD pour un docker particulier, via **Jenkins** par exemple : du dépôt de l'image sur le registry, l'arrêt du docker et le lancement de la nouvelle version.

Le fait de passer par **Swarm** (qui contrôle le nombre de container **rok4** actifs sur les machines *worker*) et **Traefik** qui redistribue les requêtes sur un container **rok4** d'un des RPI (via une requête sur un master `http://piensg017.ensg.eu/rok4`).

Le contrôle des container **rok4** doit rester 

## Notes diverses

#### Aide mémoire Docker

* `docker rm $(docker ps -a -q)` efface tous les containers
* `docker rmi $(docker images -q)` efface toutes les images
* `docker exec -it nom_docker /bin/bash` accéder à un container actif


#### Aide mémoire RPI
Accès a piensg10 :

``` sh
$ ssh pirate@172.31.57.69
```
