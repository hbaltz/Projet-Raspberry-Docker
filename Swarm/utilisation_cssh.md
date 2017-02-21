# Utilisation de cssh

## Installation
```
apt-get install clusterssh
```

## Définition des clusters
Dans le $HOME/.clusterssh/clusters ajouter la liste des machines dans le cluster avec un tag 
Exemple :
```
piensg piensg005 piensg004 piensg011 piensg010 piensg003 piensg009 piensg018 piensg007 piensg015 piensg016 piensg017
```

## Lancer la connection ssh au cluster
```
cssh TAG_CLUSER
```
Exemple :
```
cssh piensg
```