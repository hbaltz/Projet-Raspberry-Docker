# Serveur wms raster (rok4)

## Informations générales 

* [rok] (http://www.rok4.org/)
* [rok github] (https://github.com/rok4/rok4)

Jeu de données gratuit : <http://www.rok4.org/data/SCAN1000_JPG_LAMB93_FXX.zip> (SCAN1000® de l’IGN)

Nécessaire :
* BE4 
* nginx

## Images Docker existantes

* [rok4] (https://hub.docker.com/u/rok4/) propose 2 containers :
    * le serveur nginx rok4
    * les données 
    
## Docker compose 

Containers à déployer sur des marchines intel... si cela fonctionne à adapter pour utiliser / concevoir des conteneurs pour **arm**.

<https://github.com/rok4/docker-rok4-with-data>

> ** Notes ** : Les containers *data* servent à créer les volumes pour les exploiter ensuite