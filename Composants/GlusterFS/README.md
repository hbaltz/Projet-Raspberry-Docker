# GlusterFS
GlusterFS est un système de fichier partagé scalable. Il permet d'agréger la mémoire physique de plusieurs machines connectées pour étendre une mémoire 'virtuelle' plus importante. 


## Installer GlusterFS Server sur chaque Raspberry
```
sudo apt-get install glusterfs-server
```
## Lancer le serveur sur chaque Raspberry
```
sudo service glusterfs-server restart
```
## Créer un cluster à partir d'un Raspberry (source)
```
sudo gluster peer probe xxx.xxx.xxx.xxx
```
## Création du nouveau volume avec une réplication  
... nom : **gfsdata**  
... réplication : **3**  
... nombre de dossiers de stockage : **12**  
```
sudo gluster volume create gfsdata replica 3 transport tcp\
        172.31.57.64:/data\
        172.31.57.63:/data\
        172.31.57.70:/data\
        172.31.57.69:/data\
        172.31.57.62:/data\
        172.31.57.68:/data\
        172.31.56.159:/data\
        172.31.57.66:/data\
        172.31.57.156:/data\
        172.31.56.157:/data\
        172.31.56.158:/data\
        172.31.56.158:/data2\
         force
```
## Démarrage du volume
```
sudo gluster volume start gfsdata
```
## Installation sur sa machine de GlusterFS Client
```
sudo apt-get install glusterfs-client
```
## Montage d'un dossier de la machine sur le volume  
... source : **172.31.57.64:/gfsdata**  
... cible : **/mnt/dossier**
```
sudo mount -t glusterfs 172.31.57.64:/gfsdata /mnt/...
```
