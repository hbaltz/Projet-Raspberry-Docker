FROM resin/rpi-raspbian:jessie

MAINTAINER Thibault Coupin <thibault.coupin@gmail.com>

ENV http_proxy http://10.0.4.2:3128

RUN apt-get update && apt-get install -y proftpd-basic
RUN mkdir /proftpd

ADD proftpd.conf users /proftpd/
ADD start.sh /

EXPOSE 20 21 50000-50050

CMD /bin/bash /start.sh
