# Création stack
Utilisation d'une stack par ensemble de services fonctionnant ensemble

## Ordre commande des déploiment

Commencer par déployer la stack registry

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
