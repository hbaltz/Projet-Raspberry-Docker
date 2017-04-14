# Remarques/Commentaires

## Globalement

Les difficultés viennent de :

- la différence d'architecture x86/ARM
- les images ARM sont quasi tout le temps des images communautaires et la façon de mettre en place l'applicatif dépend de la personne qui a fait l'image c'est pourquoi il faut privilégier les images documentées. La version des applicatifs change aussi (on a eu l'expérience avec le fichier de configuration de telegraf)
- la présence d'un proxy à l'école

J'ai vu beaucoup de reprise de dockerfile en mode copier/coller : si aucune modification n'est nécessaire, c'est inutile de reconstruire l'image.

## Rok4 – CP

Rok4 n'expose pas nativement de port HTTP, mais FastCGI (voir https://fr.wikipedia.org/wiki/FastCGI). Il faut donc un middleware supplémentaire écoutant sur un port http et pouvant communiquer avec du fastcgi (Apache HTTPD, Nginx…)

Sur le hub, on trouve l'image rok4/rok4 avec de multiple tags dont fastgci, http, fastcgi-arm, http-arm… Les tags http signifient qu'un nginx est embarqué. Ceci n'est pas documenté sur l'image.

Dans les exemples de rok4, on trouve aussi des images « data » et une nouvelle option pour la commande docker run : « --volume-from ». Avec cette option on demande à docker de monter tous les volumes d'un autre conteneur sur le conteneur qu'on est en train de démarrer. On trouve cette option dans les exemples car il a des images uniquement avec de la donnée exemple. Sur notre IDG, la cible du stockage des data raster est sur le GlusterFS : il ne faut donc pas reprendre ces exemples mais arriver à extraire la donnée des images présentes sur le hub.

## FTP – Ru M

On est passé de sftp à ftp simple.
Plusieurs images ont été testées. L'image tcoupin/rpi-proftpd permet de personalisée la liste d'utilisateur et leur dossier. Elle inclut aussi une documentation sur les 2 modes FTP : actif/passif (voir https://fr.wikipedia.org/wiki/File_Transfer_Protocol#.C3.89tablissement_des_connexions)


##GlusterFS - Ru M

Gluster permet d'agréer des espaces disques de différents serveurs et de gérer la réplication des fichiers sur ces différents serveurs pour assurer la performance d'accès aux données et la sécurité en cas de perte de disque.

Exemple avec 4 serveurs de 10Go :

- réplica 1 : on aura un volume utile de 40Go mais si un serveur tombe, on perdra ses données ;
- réplica 2 : on aura un volume utile de 20Go, chaque fichier sera présent sur 2 serveurs, si un tombe, on accédera au fichier par le second ;
- réplica 4 : on aura un volume utile de 10Go, chaque fichier sera présent sur les 4 serveurs

Je peux faire une démo sur des VMs.

Les étapes sont :

- installation de glusterfs-server
- création d'un dossier sur chaque RPI pour accueillir des données (ex : /data)
- Sur un des RPI, ajouter les autres au cluster glusterfs. A cette étape, ils communiquent entre eux
- Créer un volume glusterfs en définissant le nombre de réplica et comment chaque serveur va contribuer à ce volume
- Démarrer le volume
- Monter le volume agréger où il faut

Sur le github, je vois la création d'un volume s'appuyant sur les 11 serveurs avec une réplication de 11 : ça veut dire que tous les fichiers seront copiés sur les 11 serveurs et il ne peut donc pas d'avoir d'agréation d'espace disque.


## Registry – ED

Le registry est l'applicatif qui tourne sur hub.docker.com, il nous permet de stocker des images et ainsi de les rendre disponibles à l'ensemble des RPI.
Une configuration est nécessaire pour que les RPI ne passent pas par le proxy de l'école lorsqu'il veut utiliser ce nouveau registry.

Il faut bien identifier l'emplacement dans le FS du conteneur où sont stocker les images pour faire un montage de volume hôte->conteneur pour éviter de tout perdre lorsque le conteneur sera arrêté.

## Grafana-InfluxDB-Telegraf - JM

La difficulté principale est que les images se comportent différemment les unes des autres. Il reste à faire discuter telegraf et influxdb, puis grafana et influxdb.
Attention, au-delà de l'architecture spécifique des RPI (ARM), la version est également importante comme on peut le constater sur https://github.com/heziegl/rpi-grafana/issues/2
Une stack qui fonctionne : https://github.com/tcoupin/rasp-workspace/tree/master/myStack/grafana-influxdb-telegraf


## Swarm – HB LM

Le swarm est en place, certains RPI sont masters, d'autres simples workers.
Les masters peuvent accueillir les requêtes réseaux et les balancent sur les nœuds hébergeant le service (un worker ou un master).
Les masters élisent un leader qui commande. En cas de chute de ce serveur, un nouveau leader est élu (ça a été testé).


> Il me manque le travail de Romain mais je ne sais plus sur quoi il travaillait...
>> Merci pour ton retour. Romain était focalisé sur le serveur http avec nginx.
