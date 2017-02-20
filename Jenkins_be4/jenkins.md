# Jenkins  

### Pour mettre en place jenkins sur un raspberry Pi

Récupération de l'image

    docker pull djdefi/rpi-jenkins

Création du dossier de data  

    cd /mnt/Data
    mkdir jenkins

Lancement de jenkins avec montage du volumes   

    docker run -d -p 49001:8080 -v /mnt/Data/jenkins:/var/jenkins_home:z --name jenkins -t djdefi/rpi-jenkins

Récupération du token pour l'admin  

    docker logs jenkins  

Administration de jenkins sur http://nom_machine:49001/
