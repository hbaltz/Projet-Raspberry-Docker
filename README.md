# Projet-Raspberry-Docker

Sujet issu du [TP de tcoupin](https://github.com/tcoupin/tp_asi_ensg)

## Le projet

Nous avons 3,5 jours pour jouer avec une vingtaine de RaspeberryPi :)

### But du jeu : mettre en place une IDG (as a Service)

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

### Organisation

A vous de choisir comment vous organisez votre temps et vos ressources.

Je fournis les cartes SD prêtes : HypriotOS, Git et ce qui vous ferait plaisir.

### Rendu

Un début d'infra qui tourne.

Un dépôt Github :

- analyse
- proposition d'architecture et organisation de la conception et du build
- détails de chaque composant : solution, relations, risques
- procédures
- PAQ (sauvegarde, résilience, surface d'attaque...)
- script et config pour un redéploiement
- ...

La contribution de chacun sera évaluée.
