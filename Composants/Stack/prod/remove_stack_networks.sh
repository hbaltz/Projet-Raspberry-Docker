#!/bin/bash

# Remove rok4
docker stack rm rok4

# Remove metrics
docker stack rm metrics

# Remove traefik
docker stack rm traefik

# Remove networks
docker network rm INTERCO_TEST
docker network rm DATA_TEST
docker network rm traefik_default
