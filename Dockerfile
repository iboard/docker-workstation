FROM       ubuntu
MAINTAINER Andreas Altendorfer <andreas@altendorfer.at>


# SET SOURCE LIST

ADD package-list /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list
RUN apt-get update


# INSTALL PACKAGES
RUN apt-get -fy install htop git openssh-server vim ruby curl tmux links

# INSTALL DEVELOPER ENVIRONMENT

## create the user and a shared project-directory
RUN useradd -c "Developer" -m -d /home/developer -s /bin/bash developer
RUN su - developer -c "mkdir ~/projects ~/src"
ADD project_source/  ~/src
#RUN su - developer -c "tar cvzf ~/original_project_source.tgz ~/src"
RUN su - developer -c "echo 'cat .motd' >> ~/.bashrc"
RUN su - developer -c "echo 'cd projects' >> ~/.bashrc"
RUN echo 'developer ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ADD README.md /home/developer/README.md
ADD Gemfile   /home/developer/projects/Gemfile

## install rvm
RUN su - developer -c "/usr/bin/curl -sSL https://get.rvm.io | /bin/bash -s stable"
RUN su - developer -c "command rvm install 2.1.2"
#RUN su - developer -c "echo 'clear; cat ~/README.md' >> ~/.bashrc"
RUN su - developer -c "echo 'source ~/.rvm/scripts/rvm && rvm use 2.1.2 --default' >> ~/.bashrc"
RUN su - developer -c "source ~/.rvm/scripts/rvm && rvm use 2.1.2 --default && cd projects && bundle"

## install console environment
# ADD gists/_tmux.conf       /home/developer/.tmux.conf
RUN su - developer -c "mkdir -p ~/.vim/bundle ~/.vim/colors"
ADD gists/_motd            /home/developer/.motd
ADD gists/_vimrc           /home/developer/.vimrc
ADD gists/rspec-vim.vim    /home/developer/.vim/bundle/rspec-vim.vim
ADD gists/run_ruby.vim     /home/developer/.vim/bundle/run_ruby.vim
ADD gists/wombatAndi.vim   /home/developer/.vim/colors/wombatAndi.vim
RUN chown -R developer:developer /home/developer/.vim


# BOOT
CMD [ "sudo", "/etc/inti.d/ssh", "start" ]
CMD [ "su", "-", "developer", "-l", "tmux", "new" ]
