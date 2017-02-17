#!/bin/bash

docker images
docker ps

docker build --label rpi-proftpd --tag tcoupin /home/pirate
docker images

docker run --name proftpd -d -p 21:21 -v /home/pirate:/users tcoupin
docker ps

exit
