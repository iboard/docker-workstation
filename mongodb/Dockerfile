FROM       ubuntu
MAINTAINER Andreas Altendorfer <andreas@altendorfer.at>


# SET SOURCE LIST

ADD package-list /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list
RUN apt-get update

# INSTALL PACKAGES

RUN apt-get -fy install htop git openssh-server vim vim-nox ruby curl tmux links unzip vim-rails ruby-dev

# INSTALL DEVELOPER ENVIRONMENT

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# INSTALL MONGO
RUN mkdir -p /var/lib/mongo
RUN curl -O http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.6.4.tgz
RUN tar -zxvf mongodb-linux-x86_64-2.6.4.tgz
RUN cp -R -n mongodb-linux-x86_64-2.6.4/ /var/lib/mongo
RUN ln  -s /var/lib/mongo/mongodb-linux-x86_64-2.6.4/bin /var/lib/mongo/bin
RUN echo "export PATH=/var/lib/mongo/bin:$PATH" >> "/.bashrc"

# SETUP MONGO
RUN mkdir -p /data/db

# BOOT
CMD [ "/var/lib/mongo/bin/mongod" ]
