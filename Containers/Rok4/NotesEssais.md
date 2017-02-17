# Serveur wms raster (rok4)

## Informations générales 

* [rok] (http://www.rok4.org/)
* [rok github] (https://github.com/rok4/rok4)

Jeu de données gratuit : <http://www.rok4.org/data/SCAN1000_JPG_LAMB93_FXX.zip> (SCAN1000® de l’IGN)

Nécessaire :
* (BE4 )
* nginx

* Raspberry cible piensg010 (pi2) et piensg017(pi3)

## Images Docker existantes

* [rok4] (https://hub.docker.com/u/rok4/) propose 2 containers :
    * le serveur nginx rok4
    * les données
    
## Docker compose

Containers à déployer sur des marchines intel... si cela fonctionne à adapter pour utiliser / concevoir des conteneurs pour **arm**.

<https://github.com/rok4/docker-rok4-with-data>

> ** Notes ** : Les containers *data* servent à créer les volumes pour les exploiter ensuite

Résultat:
```
prof@ubuntu:~/work/tp1/docker-rok4-with-data$ docker-compose up
Creating dockerrok4withdata_data-scan1000_1
Creating dockerrok4withdata_data-bdortho-d075_1
Creating dockerrok4withdata_rok4_1
Creating dockerrok4withdata_nginx_1
Attaching to dockerrok4withdata_data-scan1000_1, dockerrok4withdata_data-bdortho-d075_1, dockerrok4withdata_rok4_1, dockerrok4withdata_nginx_1
data-scan1000_1      | Data SCAN1000_PYR-JPG_FXX_PM ready !
data-bdortho-d075_1  | Data ORTHO_JPG_PM_D075 ready !
rok4_1               | /rok4/startNginx.sh: 7: /rok4/startNginx.sh: source: not found
rok4_1               | /rok4/startNginx.sh: 8: /rok4/startNginx.sh: source: not found
rok4_1               | Lancement du serveur rok4[44]
dockerrok4withdata_data-scan1000_1 exited with code 0
rok4_1               | Chargement des parametres techniques depuis /rok4/config/server.conf
rok4_1               | Env : PROJ_LIB = /rok4/config/proj
rok4_1               | Element <serverPort> : Lancement interne impossible (Apache, spawn-fcgi)
rok4_1               | Envoi des messages dans la sortie du logger
dockerrok4withdata_data-bdortho-d075_1 exited with code 0
```

Accès web
```
http://127.0.0.1:8080/rok4?SERVICE=WMS&REQUEST=GetMap&VERSION=1.3.0&LAYERS=ORTHO_JPG_PM_D075&STYLES=normal&CRS=EPSG:3857&WIDTH=3000&HEIGHT=3000&BBOX=242152,6229923,291072,6264167&FORMAT=image/png
```
## Docker Images

### Docker data

Sert à monter les volumes

--> rok4data
```sh
prof@ubuntu:docker run --name=rok4data -v /rok4/config/layers -v /rok4/config/pyramids rok4/rok4-datatest true
prof@ubuntu:~/work/tp1/docker-rok4-solo$ docker volume ls
DRIVER              VOLUME NAME
local               1c9599e0739d84177e38a94aafef410a322d05d2b3ce3b75e16de783a48e072d
local               5f3dda86e10c80381ba1555f5111b46ed3c63e5e6f54a511efb2261592abf955

prof@ubuntu:~/work/tp1/docker-rok4-solo$ docker run -it -d --rm --volumes-from rok4data --publish=9000:9000  rok4/rok4:fastcgi
35ab35d65194f92ba8c4b0cf93c3ad4f7709ce0578bb992207f2a304c468325e

prof@ubuntu:~/work/tp1/docker-rok4-solo$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                    NAMES
35ab35d65194        rok4/rok4:fastcgi   "/bin/sh -c /rok4/..."   About a minute ago   Up About a minute   0.0.0.0:9000->9000/tcp   wonderful_hodgkin

```

### Docker Rok4

``` sh
FROM rok4/rok4:fastcgi

ENV http_proxy http://10.0.4.2:3128

ADD default.template /etc/nginx/sites-available/default.template
ADD startNginx.sh /rok4/startNginx.sh

RUN chmod -R 777 /rok4/* && apt-get install -y nginx

CMD /rok4/startNginx.sh
```

``` sh
$ docker run -it -d --rm --volumes-from rok4data --name=rok4fcgi --publish=9000:9000  rok4/rok4:fastcgi
```



## Test sur rpi

$ssh pirate@piensg010
(hypriot)

Test nginx-arm
ok


Test hypriot
docker run -d -p 80:80 hypriot/rpi-busybox-httpd
ok

traefik pour loadbalancer les serveur rok4
pas testé:

test httpd
$ nano docker-compose.yml
HypriotOS/armv7: pirate@piensg010 in ~/test_httpd
$ docker-compose up



### Procédure

* Créer les images nécessaires : data (plus tard car montage NFS), rok4, nginx pour arm
* Lancer les dockers 1 par 1

#### Image

A partir de l'image [tcoupin/rok4-build](https://hub.docker.com/r/tcoupin/rok4-build/~/dockerfile/)
* ajouter le proxy `ENV http_proxy http://10.0.4.2:3128`
* construire l'image ` docker build -t rpirok4 .`
* lancer l'image 






#### Compiler
Compiler rok4 sur arm <-- nope !

``` sh
HypriotOS/armv7: pirate@piensg010 in ~/Dockers_rok4
$ mkdir rok4
HypriotOS/armv7: pirate@piensg010 in ~/Dockers_rok4
$ docker run -t -v $(pwd)/rok4:/rok4 tcoupin/rok4-build:arm
```

