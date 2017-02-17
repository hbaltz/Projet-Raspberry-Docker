# Registry

### Pour mettre en place le registry sur un raspberry Pi
Recherche d'une image Registry pour des Raspberry

    docker pull nimblestratus/rpi-docker-registry

Lancement du registry dans un volume par défaut  
*-d pour en mode démon*  
*-i pour rediriger la sortie standard*  
*--name nom que l'on donne au registry*  
*-p le port (localhost:5000 pour l'ordi, 5000:5000 por le raspberry Pi)*   

    docker run -d -i --name registryDocker -p 5000:5000   nimblestratus/rpi-docker-registry  


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
      Environment="NO_PROXY=piensg004,127.0.1.1"

    sudo systemctl daemon-reload
    sudo systemctl restart docker

Lien utile:
https://docs.docker.com/registry/deploying/