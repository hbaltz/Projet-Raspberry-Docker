# Analyse #

*la phrase de loic ...............*
D'un point de vue interface, il y a un accès internet pour le public et un accès intranet pour l'administration.
D'un point de vue de l'architecture interne, il y a une partie stockage et une partie gestion des données

La partie public doit avoir un accès restreint au service (un unique port ouvert :80) afin de limiter les risques liés à la sécurité. Une seule page web manipulant du flux WMS (vecteur ou raster) est accessible.

La partie administration offre un panel d'outils *adjectif de loic*. Au niveau des données, elle doit pouvoir procéder à l'intégration de données quelque soit leur type. Elle doit pouvoir suivre les flux de trafic et de consommations comme les logs ou les métriques internes.

Ce service doit être le plus résilient possible et s'ajuster à une montée en charge. L'infrastructure doit être redéployable facilement avec le moins de dépendances à l'architecture physique.
La frontière entre les composants doit être correctement délimitée.

[Retour](..)
