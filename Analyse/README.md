# Analyse #

Le sujet impose de fait une structure de l'infrastructure. D'un point de vue interface, il y a un accès internet pour le public et un accès intranet pour l'administration. D'un point de vue de l'architecture interne, il y a une partie stockage et une partie gestion des données

La partie public doit avoir un accès restreint au service (un unique port ouvert :80) afin de limiter les risques liés à la sécurité. Une seule page web manipulant du flux WMS (vecteur ou raster) est alors accessible.

La partie administration offre un panel d'outils de gestion. Au niveau des données, elle doit pouvoir procéder à l'intégration de données quelque soit leur type (vecteur, raster). Elle doit pouvoir suivre les flux de trafic et de consommations comme les logs ou les métriques internes.

Ce service doit être le plus résilient possible et s'ajuster à une montée en charge. L'infrastructure doit être redéployable facilement avec le moins de dépendances à l'architecture physique.
La frontière entre les composants doit donc être correctement délimitée.

Pour tester notre infrastructure, nous avons à disposition une dizaine de Raspberry Pi répartis sur deux sous-réseaux locaux :

| "Nom"     | "Ip"            | "DNS"       | "Rôle"    | 
|-----------|-----------------|-------------|-----------| 
| "pi2s001" | "172.31.57.64"  | "piensg005" | "worker"  | 
| "pi2s002" | "172.31.57.63"  | "piensg004" | "worker"  | 
| "pi2s003" | "172.31.57.70"  | "piensg011" | "worker"  | 
| "pi2s004" | "172.31.57.69"  | "piensg010" | "worker"  | 
| "pi2s005" | "172.31.57.62"  | "piensg003" | "worker"  | 
| "pi2s008" | "172.31.57.66"  | "piensg007" | "worker"  | 
| "pi3s001" | "172.31.57.156" | "piensg015" | "worker"  | 
| "pi2s006" | "172.31.57.68"  | "piensg009" | "manager" | 
| "pi2s007" | "172.31.56.159" | "piensg018" | "manager" | 
| "pi3s002" | "172.31.56.157" | "piensg016" | "manager" | 
| "pi3s003" | "172.31.56.158" | "piensg017" | "manager" | 

[Retour](https://github.com/hbaltz/Projet-Raspberry-Docker/)
