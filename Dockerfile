FROM ubuntu:22.04

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive  apt install python3 python3-pip \
    unzip sudo curl less wget -y


WORKDIR /opt

RUN ln -s /usr/bin/python3 /usr/bin/python

CMD ["/usr/bin/python", "/opt/deploy.py"]