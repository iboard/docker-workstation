FROM       ubuntu
MAINTAINER Andreas Altendorfer <andreas@altendorfer.at>


# SET SOURCE LIST

ADD package-list /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list
RUN apt-get update

# INSTALL PACKAGES

RUN apt-get -fy install htop git openssh-server vim vim-nox ruby curl tmux links unzip vim-rails ruby-dev redis-server

# INSTALL DEVELOPER ENVIRONMENT

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# START REDIS
CMD /usr/bin/redis-server



