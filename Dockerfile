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

## create the user and a shared project-directory
### ADD USER
RUN useradd -c "Developer" -m -d /home/developer -s /bin/bash developer
RUN su - developer -c "mkdir ~/projects ~/src"
### PACK CURRENT SOURCE
ADD project_source  /src/
RUN su - developer -c "tar cvzf ~/original_project_source.tgz ~/src"
RUN su - developer -c "rm -Rf ~/src"
### SETUP LINUX USER
ADD gists/_bashrc /home/developer/.bashrc_ext
RUN su - developer -c "echo 'source ~/.bashrc_ext' >> /home/developer/.bashrc"
RUN su - developer -c "echo 'cat .motd' >> /home/developer/.bashrc"
RUN su - developer -c "echo 'cd projects' >> /home/developer/.bashrc"
RUN echo 'developer ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ADD README.md /home/developer/README.md
ADD project_source/Gemfile   /home/developer/projects/Gemfile

## install rvm
RUN su - developer -c "/usr/bin/curl -sSL https://get.rvm.io | /bin/bash -s stable"
RUN su - developer -c "command rvm install 2.1.2"
#RUN su - developer -c "echo 'clear; cat ~/README.md' >> ~/.bashrc"
RUN su - developer -c "echo 'source ~/.rvm/scripts/rvm && rvm use 2.1.2 ' >> ~/.bashrc"
RUN su - developer -c "source ~/.rvm/scripts/rvm && rvm use 2.1.2 && cd projects && bundle"

## install console environment
# ADD gists/_tmux.conf       /home/developer/.tmux.conf
RUN su - developer -c "mkdir -p ~/.vim/bundle/nerdtree ~/.vim/colors"
ADD gists/_motd            /home/developer/.motd


### VIM

RUN mkdir -p /home/developer/.vim/autoload /home/developer/.vim/bundle
RUN curl -So /home/developer/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
ADD vim/nerdtree.zip       /home/developer/.vim/bundle/nerdtree/nerdtree.zip
ADD vim/vim-colorschemes/colors /home/developer/.vim/colors
RUN find /home/developer/.vim/colors -name "*.vim" -exec mv {} /home/developer/.vim/colors/ \;
RUN su - developer -c "unzip -d /home/developer/.vim/bundle/nerdtree /home/developer/.vim/bundle/nerdtree/nerdtree.zip"
RUN su - developer -c "echo 'source /home/developer/.vim/bundle/nerdtree/plugin/NERD_tree.vim' >> .vimrc"
ADD gists/_vimrc           /home/developer/.vimrc
ADD gists/rspec-vim.vim    /home/developer/.vim/bundle/rspec-vim.vim
ADD gists/run_ruby.vim     /home/developer/.vim/bundle/run_ruby.vim
RUN chown -R developer:developer /home/developer/.vim
RUN su - developer -c "cd /home/developer/.vim/bundle && git clone https://github.com/wincent/Command-T.git"

## MKDIR for shared host-path
RUN mkdir -p /home/developer/dev
RUN chown -R developer:developer /home/developer

RUN su - developer -c "source /home/developer/.rvm/scripts/rvm && rvm use 2.1.2 && cd /home/developer/.vim/bundle/Command-T && sudo gem install rake && rake make && cd -"

# BOOT
CMD [ "/etc/init.d/ssh", "start" ]
CMD [ "su", "-", "developer", "-l", "tmux", "-8", "new" ]
