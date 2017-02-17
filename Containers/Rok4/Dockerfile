FROM resin/rpi-raspbian:jessie
MAINTAINER nilct <cparisel@gmail.com>

ENV http_proxy http://10.0.4.2:3128
ENV https_proxy http://10.0.4.2:3128


LABEL rok4.version="0.25.1"
LABEL rok4.proc_type="arm32bit"
ENV ROK4_VERSION 0.25.1
ENV ROK4_PROC_TYPE="arm32bit"

RUN mkdir /rok4
RUN mkdir /rok4/config
WORKDIR /rok4

#ADD config /rok4/config/  # add source to dest(in container)
ADD startRok4.sh /rok4/startRok4.sh
ADD default_env /rok4/default_env
ADD config /rok4/config/


RUN apt-get update \
        && apt-get install -y wget ca-certificates \
        && wget "https://github.com/rok4/rok4/releases/download/${ROK4_VERSION}/Rok4-${ROK4_VERSION}-Linux-${ROK$
        && tar -zxf Rok4-${ROK4_VERSION}-Linux-${ROK4_PROC_TYPE}.tar.gz \
        && rm Rok4-${ROK4_VERSION}-Linux-${ROK4_PROC_TYPE}.tar.gz \
        && chmod -R 777 /rok4/*

CMD /rok4/startRok4.sh
