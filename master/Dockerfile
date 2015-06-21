FROM ubuntu:14.04 
MAINTAINER Rob Layton <hire@roblayton.com>

# Install buildbot and dependencies
RUN /bin/echo -e "\
    deb http://archive.ubuntu.com/ubuntu trusty main universe\n\
    deb http://archive.ubuntu.com/ubuntu trusty-updates main universe" > \
    /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-pip python-dev \
    supervisor git sudo ssh
RUN pip install buildbot

RUN groupadd -r buildbot \
    && useradd -r -d /master -g buildbot buildbot \
    && mkdir /buildbot

WORKDIR /master
VOLUME /master
EXPOSE 8010 9989

COPY run.sh /
CMD ["/run.sh"]
