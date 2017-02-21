##Traefik##

- **Service utilisé :** hypriot/rpi-traefik
- **Port ouvert :** 80/8080
- **Nom du contenaire :** hypriot/rpi-traefik
- **Dépôt officiel :** [https://hub.docker.com/r/hypriot/rpi-traefik/](https://hub.docker.com/r/hypriot/rpi-traefik/)

###Contexte###
Traefik est en charge de la réception des requêtes sur le front end et du redispatch vers les différents services en backend suivant des règles, il gère aussi le load balancing.

###Docker-compose.yml###

Voici le fichier pour traefik.
Le port 80 est ouvert, c'est celui que recevra les requêtes pour les différents services.
Le port 8080 quant à lui permet d'accéder à l'interface d'adminitration de traefik.

```yml
version: "2.0"
services:
  frontlb:
    image: hypriot/rpi-traefik
    command: --web --docker --docker.domain=piensg017.ensg.eu
    environment:
      TRAEFIK_LOG_LEVEL="INFO" # Log level
      TRAEFIK_LOG_FILE="/opt/traefik/log/traefik.log"} # Log file. Redirected to docker stdout.
      TRAEFIK_ACCESS_FILE="/opt/traefik/log/access.log"} # Access file. Redirected to docker stdout.
    volumes:
     - /var/run/docker.sock:/var/run/docker.sock
     - /mnt/data/traefik/log/:/opt/traefik/log/
    ports:
     - "80:80"
     - "8080:8080"
```

Lancement
```sh
cd ./path/
docker-compose up -d
```

###Configuration de services utilisateurs###

###Docker-compose.yml###

**Exemple pour Rok4**
```yml
version: '2'
services:
  rok4:
    image: rok4/rok4:arm-http
    volumes:
      - /mnt/Data/geodata/scan1000:/rok4/config/pyramids/scan1000
      - /mnt/Data/geodata/bdortho:/rok4/config/pyramids/bdortho
#Partie à ajouter pour que le service se "déclare" auprès de traefik
    labels:
      traefik.port: "80" 
      traefik.frontend.rule: "Host:piensg017.ensg.eu;Path:/rok4"
      traefik.backend: "rok4"
    networks:
      - traefik_default
networks:
  traefik_default:
    external: true
```

Les instructions des labels vont permettre à traefik de récupérer la conf.
traefik.port : le port de du service cible
traefik.frontend.rule : les règles de routage, 

- Host : la liste des hostnames et/ou des ip séparés par des ","
- Path : le chemin qui permettra de différencier les cibles.

traefik.backend : le nom donné au backend, il permettra à traefik de lier toutes les instances identiques

networks:

- traefik_default : permet de créer l'instance dans le réseau de traefik et de ne pas en recréer un, ce qui poserait un problème d'isolation des réseaux.
