FROM resin/rpi-raspbian:jessie
MAINTAINER Julie Marcuzzi <julie.marcuzzi@ensg.eu>

ENV http_proxy="http://10.0.4.2:3128"
ENV https_proxy="https://10.0.4.2:3128"

RUN apt-get update \
        && apt-get install -y unzip \
        && apt-get install -y tomcat7

ADD https://netcologne.dl.sourceforge.net/project/geoserver/GeoServer/2.8.1/geoserver-2.8.1-war.zip /tmp

RUN cd /tmp && unzip geoserver-2.8.1-war.zip && mv *.war /var/lib/tomcat7/webapps/


## Trouver une solution pour lancer le conteneur sans qu'il se tue
RUN chmod +x /etc/init.d/tomcat7 \
        && sudo service tomcat7 start

ENTRYPOINT ["/bin/sh", "-c"]

