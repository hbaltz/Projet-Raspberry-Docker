# Plan d'assurance qualité

Afin d'assurer la robustesse de l'infrastructure à différent niveau d'incidents, nous avons provoqué plusieurs pannes.

## Des pannes réseaux
#### Débranchement des câbles des Raspberry
D'un point de vue physique, il y a des vulnérabilités du service en cas de panne sur les Raspberry. Nous avons cherché à simuler les différentes problèmes auxquels le système pourrait être confrontés.
Nous avons débranché (autant les câbles réseaux que le câble d'alimentation) certains Raspberry pour évaluer le comportement du Swarm.

##### Conséquences sur les services
Cet acte n'a pas affecté l'accès au service du fait du comportement dynamique du swarm. Le nombre de Master est resté constant grâce à la promotion d'un Worker. Les services qui ont été arrêtés par la coupure se sont auto-déployés sur de nouveaux noeuds.

##### Conséquences sur les données
Les raspberry communiquent sur 2 sous-réseaux physique. En cas de défaillance d'un des réseaux, l'autre doit pouvoir pendre toute la charge. Les données étant dupliquées grâce au réplicat du GlusterFS, l'arrêt du matériel n'a pas causé de perte de données.

En conclusion, tous les services et les données sont répliqués sur le cluster, ce qui évite une défaillance du service et renforce sa robustesse.

#### Requêtage massif des serveurs
Afin de s'assurer que les services tiennent une montée en charge lors d'une trop grande quantité d'accès ou de requếtages, ou lorsqu'un sous-réseau tombe, nous avons simulé des attaques grâce à la package `siege`.
Le load-balancer a réparti la charge conformément à nos attentes. Les services continuaient à répondre sans latence.


### Points faibles
Si une coupure générale advient, il sera nécessaire de redéployer le swarm. Les managers sauvegardent l'état du swarm dans le dossier ```/var/lib/docker/swarm/```. Afin de conserver la configuration du swarm, une sauvegarde du contenu de ce dossier doit être faite régulièremenet par les sysadmins s'occupant du cluster. [Voir la documentation officielle pour créer une sauvegarde du système.](https://docs.docker.com/engine/swarm/admin_guide/#back-up-the-swarm)


## Securité
Avec la mise en place de traefik, la surface d'attaque est limitée : 
- le port 80 afin d'accéder à l'interface web
- les ports 21 et 5001-5051 pour l'accès ftp
- le port 22 pour l'accès ssh



[Retour](https://github.com/hbaltz/Projet-Raspberry-Docker/)
