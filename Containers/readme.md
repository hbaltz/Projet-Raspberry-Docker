# Docker - service rok4

## Aide mémoire Docker

`docker rm $(docker ps -a -q)` efface tous les containers
`docker rmi $(docker images -q)` efface toutes les images

## Aide mémoire RPI
Accès a piensg10 :

``` sh
$ ssh pirate@172.31.57.69
```

## Mettre en place de quoi installer les données

### Installation locale des images (sur ubuntu) 

* [data-scan1000](https://hub.docker.com/r/rok4/data-scan1000/) et [bdortho](https://hub.docker.com/r/rok4/data-bdortho-d075/)

``` sh
$ docker pull rok4/data-scan1000
$ docker pull rok4/data-bdortho-d075
$ docker run -it --name scan1000 -v $PWD/data:/data rok4/data-scan1000 /bin/sh
``` 

Une fois dans le container scan1000 :
``` sh
/ # cd data
/data # mkdir scan1000
/data # cd scan1000/
cp -r /rok4/config/pyramids/SCAN1000_PYR-JPG_FXX_PM/* .
```

Dans bdortho :
``` sh
/ # cd data
/data # mkdir bdortho
/data # cd bdortho/
/data/bdortho # cp -r /rok4/config/pyramids/ORTHO_JPG_PM_D075/* .
```

### Copie sur les raspberry (sur Glusterfs)

``` sh
$ sudo mount -t glusterfs 172.31.57.64:/gfsdata /mnt/cpdata
$ sudo apt-get install glusterfs-client
$ sudo mkdir geodata
$ cd geodata/
$ sudo cp -r ~/workcp/Docker_Perso/data/* .
``` 
### Modification dans les fichiers layers

> Objectif : permettre à rok4 de trouver les fichiers pyramides

le chemin est écrit dans le fichier [startRok4](https://github.com/tcoupin/docker-rok4/blob/master/startRok4.sh) de l'image **rok4/rok4:arm-http**

`find /rok4/config/pyramids/ -name *.lay -exec cp '{}' /rok4/config/layers/ \;`

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

Configuration (docker-compose) :
``` sh
    volumes:
      - /mnt/Data/geodata/scan1000:/rok4/config/pyramids/scan1000
      - /mnt/Data/geodata/bdortho:/rok4/config/pyramids/bdortho
```

Vérification :

* Services disponibles 
`http://172.31.57.69:8080/rok4?service=WMS&request=GetCapabilities`

* Sous QGIS :
  * Ajouter couche WMS : `http://172.31.57.69:8080/rok4`

