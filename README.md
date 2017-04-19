# Projet-Raspberry-Docker

Sujet issu du [TP de tcoupin](https://github.com/tcoupin/tp_asi_ensg)

## But du jeu : 
**mettre en place une Infrastructure de Données Géographiques (as a Service) sur un cluster de RaspberryPi**

Fonctionnalités/contraintes :
- offre de service publique :
  - wms raster (rok4) / wms vecteur (Geoserver?)
  - site avec carte dynamique et un catalogue
- administration :
  - intégration de données vecteur/raster
  - suivi des consommations
  - si nécessaire, forge pour les builds des images docker
- infrastructure
  - suivi de l'état des RPI
  - élasticité
  - haute disponibilité et distribution
  - mise à jour des composants sans interuption de service

## Organisation

A vous de choisir comment vous organisez votre temps et vos ressources.

Je fournis les cartes SD prêtes : HypriotOS, Git et ce qui vous ferait plaisir.

## Rendu

Un début d'infra qui tourne. 

Un dépôt Github :

- [analyse](./Analyse)
- proposition d'[architecture](./Architecture) et organisation de la conception et du build
- détails de chaque [composant](./Composants) : solution, relations, risques
- procédures
- [PAQ](./PAQ) (sauvegarde, résilience, surface d'attaque...)
- script et config pour un [redéploiement](./Composants/Stack)
- ...

La contribution de chacun sera évaluée.
