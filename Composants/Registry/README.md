# Registry

Le Registry est une application côté serveur qui stocke et permet de distribuer des images Docker.

## Installation du Registry sur Raspberry Pi
##### Recherche d'une image Registry pour des Raspberry:

    docker pull dixonwille/rpi-registry

##### Lancement du Registry dans un volume par défaut:  
*-d pour en mode démon*  
*-i pour rediriger la sortie standard*  
*--name nom que l'on donne au registry*  
*-p le port (localhost:5000 pour l'ordi, 5000:5000 por le raspberry Pi)*   

    docker run -d -i --name registryDocker -p 5000:5000 -v /mnt/Data/registry:/var/lib/registry dixonwille/rpi-registry

Le dossier de montage */tmp* et la création du volume */mnt/data/registry* sont effectués pendant le *run*.

## Utilisation
##### Intégation d'une image dans Registry:

    docker pull hello-world
    docker tag idhello-world piensg004:5000/hello-world
    docker push piensg004:5000/hello-world

###### Lors de la connection

Se servir de l'addresse http://{$Nom_DNS}.ensg.eu:5000

###### Les commandes de base restent inchangées:
- chercher une image:

      docker search piensg004:5000/hello-world

- récupérer une image

      docker pull piensg004:5000/hello-world

- regarder des informations sur les images

      docker inspect piensg004:5000/hello-world

##### Arrêter le Registry:

    docker stop registryDocker && docker rm -v registryDocker

##### Configuration du proxy (si besoin):  

    cd /etc/systemd/system/docker.service.d/
    sudo nano 02-http-proxy.conf

      Environment="HTTP_PROXY=http://10.0.4.2:3128/"
      Environment="NO_PROXY=ensg.eu,127.0.1.1"

    sudo systemctl daemon-reload
    sudo systemctl restart docker


##### Autre commande:  
    docker exec -it registryDocker /bin/bash

##### Ajout de l'insecure sur le registry:  

    sudo nano /etc/systemd/system/docker.service.d/01-main.conf  
    --insecure-registry piensg017.ensg.eu:5000  

###### Attention: ne pas oublier de tout redémarrer  

    sudo systemctl daemon-reload
    sudo systemctl restart docker

### Intégation d'une image dans le Registry avec le swarm

    docker tag idhello-world piensg017.ensg.eu:5000/hello-world
    docker push piensg017.ensg.eu:5000/hello-world

## Risques  

Le Registry est déployé sur tous les raspberry pour le partage des images mais il n'est mis en place que sur un seul: s'il y a plantage, il n'y a pas d'autres Registry.  
Cependant il suffit de le redémarrer mais cela prend un certain temps.

#### Liens utiles:
https://docs.docker.com/registry/deploying/
https://hub.docker.com/r/dixonwille/rpi-registry/
