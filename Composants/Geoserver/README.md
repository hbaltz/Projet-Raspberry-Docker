# Geoserver #

## Description ##

Serveur open-source nous proposant le service WMS vecteur

## Lien avec les autres composants ##

- BDD
- web public

## Documentation ##

### Sur ordinateur ###

Il y a plusieurs exemples fonctionnels comme :
- [https://hub.docker.com/r/kartoza/geoserver/](https://hub.docker.com/r/kartoza/geoserver/)
- [https://github.com/tcoupin/tp_asi_ensg/tree/master/examples/00-dockerfile-geoserver](https://github.com/tcoupin/tp_asi_ensg/tree/master/examples/00-dockerfile-geoserver)
- et d'autres sur le [hub.docker](https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=geoserver&starCount=0)

### Sur RPI ###

Documentation sur ce [lien](http://blog.sortedset.com/gis-tiny-box-geoserver-raspberry-pi/)

Pour l'implémenation sur Raspberry, il faut :
- Java 1.8
- Tomcat7 (ligne de commande + variable d'environnement JAVA_HOME)
- Geoserver (zip)
- Lancer Tomcat7 puis aller sur [http://localhost:8080/geoserver/](http://localhost:8080/geoserver/)


Adapatation de [https://github.com/daveb1034/R_Pi_Geo](https://github.com/daveb1034/R_Pi_Geo) :

> Création des répertoires de partage

Le **docker-compose.yml** fait appel au **Dockerfile**.
```yml
version: "2.0"
services:
  geoserver:
    build: geoserver
    volumes:
      - /mnt/Data/geoserver/data:/data
```

## Difficultés rencontrées ##

> Après le lancement, crash direct  

Dockerfile est à modifier pour faire perdurer tomcat7 dans le conteneur.
