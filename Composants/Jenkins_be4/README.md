# Jenkins  

## Installation de Jenkins sur Raspberry Pi

##### Récupération de l'image

    docker pull piensg017.ensg.eu:5000/djdefi/rpi-jenkins

##### Création du dossier de data  

    cd /mnt/Data
    mkdir jenkins

##### Lancement de Jenkins avec montage du volumes   

    docker run -d -p 49001:8080 -v /mnt/Data/jenkins:/var/jenkins_home:z --name jenkins -t piensg017.ensg.eu:5000/djdefi/rpi-jenkins

##### Récupération du token pour l'admin  

    docker logs jenkins  

## Configuration

L'administration de Jenkins se fait sur http://nom_machine:49001/ à la main.  
Pour l'écriture et le lancement de scripts, il faut créer de nouveaux jobs.

##### Attention:  
L'image de Jenkins est très lourde, il faut éviter de la mettre sur le registry.


### Lien utile:

Provenance de l'image:
  https://hub.docker.com/r/dilgerm/rpi-jenkins/
