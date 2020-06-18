FROM ubuntu:18.04
MAINTAINER Lukas Rist <glaslos@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

## setup APT
RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse' /etc/apt/sources.list && \
    sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse' /etc/apt/sources.list && \
    sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse' /etc/apt/sources.list && \
    sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse' /etc/apt/sources.list

## Install dependencies
RUN apt-get update && apt-get install -y \
        build-essential \
        g++ \
        gfortran \
        git \
        libevent-dev \
        liblapack-dev \
        libmysqlclient-dev \
        libxml2-dev \
        libxslt-dev \
        make \
        python-beautifulsoup \
        python-chardet \
        python-dev \
        python-gevent \
        python-lxml \
        python-openssl \
        python-pip \
        python-requests \
        python-setuptools \
        python-sqlalchemy \
        python-mysqldb \
        cython \
        python-dateutil \
        python2.7 \
        python2.7-dev \
        software-properties-common \
	dirmngr \
	apt-transport-https \
	lsb-release \
	ca-certificates \
	&& \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN locale-gen en_US.UTF-8
RUN export LANG=en_US.UTF-8
RUN LC_ALL=en_US.UTF-8
RUN add-apt-repository -y ppa:ondrej/php && apt-get update

RUN git clone https://github.com/Leocodefocus/shockpot.git /opt/shockpot

RUN cd /opt/shockpot && pip install -r requirements.txt

EXPOSE 8080
WORKDIR /opt/shockpot
CMD ["python","shockpot.py"]


