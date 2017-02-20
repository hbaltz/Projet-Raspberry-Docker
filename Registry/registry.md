# Registry

### Pour mettre en place le registry sur un raspberry Pi
Recherche d'une image Registry pour des Raspberry

    docker pull nimblestratus/rpi-docker-registry

Lancement du registry dans un volume par défaut  
*-d pour en mode démon*  
*-i pour rediriger la sortie standard*  
*--name nom que l'on donne au registry*  
*-p le port (localhost:5000 pour l'ordi, 5000:5000 por le raspberry Pi)*   

    docker run -d -i --name registryDocker -p 5000:5000 -v /tmp:/mnt/data/registry nimblestratus/rpi-docker-registry  


Intégation d'une image dans registry

    docker pull hello-world
    docker tag idhello-world piensg004:5000/hello-world
    docker push piensg004:5000/hello-world

Les commandes de base restent inchangés:
- chercher une image:

      docker search piensg004:5000/hello-world

- récupérer une image

      docker pull piensg004:5000/hello-world

Arreter le registry

    docker stop registryDocker && docker rm -v registryDocker

Configuration du proxy si problème

    cd /etc/systemd/system/docker.service.d/
    sudo nano 02-http-proxy.conf

      Environment="HTTP_PROXY=http://10.0.4.2:3128/"
      Environment="NO_PROXY=ensg.eu,127.0.1.1"

    sudo systemctl daemon-reload
    sudo systemctl restart docker

Regarder informations sur les images

    docker inspect piensg004:5000/hello-world

Dossier de montage:  /tmp  
Création du volume /mnt/data/registry   
=> tout est fait lors du run !

    docker exec -it registryDocker /bin/bash

Ajout de l'insecure sur le registry  

    sudo nano /etc/systemd/system/docker.service.d/01-main.conf  
    --insecure-registry piensg004.ensg.eu:5000  

! Attention ne pas oublier de tout redémarrer:  

    sudo systemctl daemon-reload
    sudo systemctl restart docker

Du coup avec la config du swarm:  
Intégation d'une image dans registry

    docker tag idhello-world piensg004.ensg.eu:5000/hello-world
    docker push piensg004.ensg.eu:5000/hello-world


Lien utile:
https://docs.docker.com/registry/deploying/

# Lors de la connection

Se servir de l'addrese http://{$Nom_DNS}.ensg.eu:5000
