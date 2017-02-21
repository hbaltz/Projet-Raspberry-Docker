#!/bin/bash

# Networks configuration
docker network create -d overlay --internal DATA_TEST
docker network create -d overlay INTERCO_TEST
docker network create --driver=overlay traefik_default


# Deployer traefik
docker stack deploy -c docker-config-traefik.yml traefik

watch docker stack ps traefik --no-trunc
echo "Continue to deploy stacks"

# Deployer le suvi d'état des raspberry pi
docker stack deploy -c NETWORKS_docker-config-influxdb.yml metrics

# Deployer rok4
docker stack deploy -c NETWORKS_docker-config-rok4.yml rok4
