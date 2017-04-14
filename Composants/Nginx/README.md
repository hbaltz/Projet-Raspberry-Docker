## Serveur Web Privé ##

- **Service utilisé :** nginx
- **Dépôt officiel :** [https://hub.docker.com/_/nginx/](https://hub.docker.com/_/nginx/)

### Contexte ###
Le serveur web privé sert à l'administration et à la visualisation des données issues du monitoring machines et services.
Les fichiers de configuration seront sur le système de fichiers.
Le contenu des sites sera sur le système de fichiers.

### Configuration ###

Deux virtual hosts :

- port 80 pour la visualisation,
- port 8080 pour l'accès à jenkins

### Docker-compose.yml ###

**Exemple**
```yml
version: "2.0"
services:
  privateHttpd:
    image: nginx
    volumes:
     - /home/prof/docker/nginx/html/:/usr/share/nginx/html:ro
    ports:
     - "8080:80"
```

Lancement
```sh
cd ./path/
docker-compose up -d
```

### Montage réseau ###

```sh
sudo mkdir -p /mnt/data/httpdata/
sudo mount -t glusterfs 172.31.57.64:/gfsdata /mnt/data/
```
