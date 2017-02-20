# Création stack
Utilisation d'une stack par ensemble de services fonctionnant ensemble

# Récupérer les fichiers de déploiements

Plusieurs solutions existent :
- cloner le dépôt git sur les raspberry et aller dans le dossier stack/prod
```
    git clone https://github.com/hbaltz/Projet-Raspberry-Docker
    cd Projet-Raspberry-Docker/Stack/prod
```
- avoir les fichiers sur sa machine locale et les envoyer sur un master :
```
    scp docker-config-registry.yml piensg017:
```

## Ordre commande des déploiments

Commencer par déployer la stack networks :

```
docker stack deploy -c docker-config-networks.yml NETWORKS
```

    Attention, le nom de la stack est à respecter obligatoirement car toutes les autres stacks en dépendent.


Puis la stack registry :

```
docker stack deploy -c docker-config-registry.yml registry
```

Pousser sur registry l'ensemble des images nécessaire, voir [doc registry](../Registry/registry.md)

Lancer le script lançant les différentes stack (ou les différentes stack à la main) dans une pi master avec les différents fichiers de configuration yaml présents dessus
```
start_stacks.sh
```

Pour placer les fichers de conf sur une pi
```
scp fichier_conf.yml Nom_DNS_PI:
```

# Procédure d'arrêt de services
```
docker service rm SERVICE_NAME
```

# Procédure pour scaler un service :
```
docker service scale SERVICE_NAME=NB_REPLICAs
```
