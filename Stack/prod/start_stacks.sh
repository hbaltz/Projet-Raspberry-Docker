#!/bin/bash

docker stack deploy -c docker-config-influxdb.yml metrics
docker stack deploy -c docker-config-rok4.yml rok4
docker stack deploy -c docker-config-ftp.yml ftp
