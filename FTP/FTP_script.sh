#!/bin/bash

docker rm proftpd -f

docker images
docker ps

docker build --label rpi-proftpd --tag tcoupin /home/pirate
docker images

docker run --name proftpd -d -p 21:21 -v /home/pirate:/users -v /mnt/Data:/data tcoupin
docker ps

exit
