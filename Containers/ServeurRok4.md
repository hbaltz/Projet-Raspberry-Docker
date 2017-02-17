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
* [tcoupin/rok4-build](https://hub.docker.com/r/tcoupin/rok4-build/~/dockerfile/) propose des images pour arm

## Containers à déployer


### Docker Rok4 - volume image 

#### Data

``` sh
$ git clone https://github.com/Nilct/docker-rok4datatest.git
$ cd docker-rok4datatest
$ docker build -t rpirok4data .
$ docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
rpirok4data                 latest              3600e7934363        2 minutes ago       163 MB
$ docker run --name=rok4data -v /rok4/config/layers -v /rok4/config/pyramids rpirok4data true
```

#### Rok4

``` sh
$ git clone https://github.com/Nilct/docker-rok4.git
$ cd docker-rok4
$ docker build -t rpirok4 .
$ docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
rpirok4                     latest              5d838dcd5c21        2 minutes ago       207 MB
$ docker run -d --rm --volumes-from rpirok4data --publish=9000:9000  rpirok4
```

? docker run -d --publish 9000:9000 --volumes-from rpirok4data --env ROK4_SERVICE_TITLE=docker-rok4 rpirok4

#### nginx

``` sh
$ git clone https://github.com/Nilct/nginx-proxy
$ cd nginx-proxy
$ docker build -t rpinginx .
$ docker images
```

To run it:

$ docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro rpinginx
Then start any containers you want proxied with an env var VIRTUAL_HOST=subdomain.youdomain.com

$ docker run -e VIRTUAL_HOST=foo.bar.com  ...
The containers being proxied must expose the port to be proxied, either by using the EXPOSE directive in their Dockerfile or by using the --expose flag to docker run or docker create.


