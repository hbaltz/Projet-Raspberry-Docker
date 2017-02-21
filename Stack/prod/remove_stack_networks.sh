#!/bin/bash

# Deployer rok4
docker stack rm rok4


# Deployer le suvi d'état des raspberry pi
docker stack rm metrics


# Deployer traefik
docker stack rm traefik


docker network rm INTERCO_TEST
docker network rm DATA_TEST
docker network rm traefik_default

# Deployer ftp
# docker stack rm ftp
