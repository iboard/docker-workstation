FROM       ubuntu
MAINTAINER Andreas Altendorfer <andreas@altendorfer.at>


# SET SOURCE LIST

ADD package-list /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list
RUN apt-get update

# INSTALL PACKAGES

RUN apt-get -fy install htop git openssh-server vim vim-nox ruby curl tmux links unzip vim-rails ruby-dev mysql-server

# INSTALL DEVELOPER ENVIRONMENT

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# MYSQL SETUP
ADD my.cnf /etc/mysql/my.cnf
RUN service mysql start && sleep 5 && mysqladmin password 1234

# START MYSQL
CMD /usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql \
    --plugin-dir=/usr/lib/mysql/plugin \
    --user=mysql --log-error=/var/lib/mysql/rtvipr-db01.err \
    --open-files-limit=65535 --pid-file=/var/run/mysqld/mysqld.pid \
    --socket=/var/run/mysqld/mysqld.sock \
    --port=3306 --bind-address=0.0.0.0 \
    --skip-grant-tables



