# Docker container for the mapnick-xml to cartocss convertor
# Provided at: https://github.com/rundel/carto-generator


#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM ubuntu:trusty
MAINTAINER Tim Sutton<tim@linfiniti.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl

# Use local cached debs from host (saves your bandwidth!)
# Change ip below to that of your apt-cacher-ng host
# Or comment this line out if you do not with to use caching
ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng

#-------------Application Specific Stuff ----------------------------------------------------

RUN apt-get update
# add-apt moved to the common package now so we need to install that too
RUN apt-get install -y python-software-properties software-properties-common
RUN apt-get install -y build-essential git

RUN apt-get update
RUN add-apt-repository -y ppa:mapnik/v2.2.0
RUN add-apt-repository -y ppa:mapnik/boost

RUN apt-get install -y libboost-dev libboost-filesystem-dev \
    libboost-program-options-dev libboost-python-dev \
    libboost-regex-dev libboost-system-dev libboost-thread-dev \
    build-essential git scons


# get a build environment going...
RUN apt-get install \
    libicu-dev \
    python-dev libxml2 libxml2-dev \
    libfreetype6 libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libproj-dev \
    libtiff-dev \
    libcairo2 libcairo2-dev python-cairo python-cairo-dev \
    libcairomm-1.0-1 libcairomm-1.0-dev \
    ttf-unifont ttf-dejavu ttf-dejavu-core ttf-dejavu-extra \
    git build-essential python-nose \
    libgdal1-dev python-gdal \
    postgresql-9.3 postgresql-server-dev-9.3 postgresql-contrib-9.3 postgresql-9.3-postgis-2.1 \
    libsqlite3-dev


# Install cartogenerator
RUN git clone git://github.com/rundel/carto-generator.git
WORKDIR /carto-generator
RUN make



