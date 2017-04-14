#!/bin/bash

# Deployer traefik 
docker stack deploy -c docker-config-traefik traefik

# Deployer le suvi d'état des raspberry pi
docker stack deploy -c docker-config-influxdb.yml metrics

# Deployer rok4
docker stack deploy -c docker-config-rok4.yml rok4

# Deployer ftp
docker stack deploy -c docker-config-ftp.yml ftp

# Deployer postgis
docker stack deploy -c docker-config-postgis.yml postgis
