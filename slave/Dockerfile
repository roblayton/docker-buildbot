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
RUN pip install buildbot_slave

RUN groupadd -r buildbot \
    && useradd -r -d /slave -g buildbot buildbot \
    && mkdir /slave

WORKDIR /slave
VOLUME /slave

COPY run.sh /
CMD ["/run.sh"]
