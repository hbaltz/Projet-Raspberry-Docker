# Architecture

## Identifier les différents éléments

    1 composant => 1 docker

## Services
  - wms raster *(RPI 3)*
  - wms vecteur *(RPI 3)*

  - website host HTTPD *(léger)*


  - administration *(léger)*
    - intégrateur de données
    - suivi des consommations *(serveur dashboard)*

  - forge avec registry

  - suiveur d'état des raspberry

## Diagrammes

Diagrammes réalisés avec [www.draw.io](https://www.draw.io/)


![Architecture_1.png](Architecture_1.png)

![Architecture_2.png](Architecture_2.png)
