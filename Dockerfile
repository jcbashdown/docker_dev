FROM ubuntu:15.10
MAINTAINER Jacob Ashdown
RUN apt-get update && apt-get install -y git ack-grep python-pip python-virtualenv rbenv tmux git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libpq-dev postgresql unity-scope-virtualbox virtualbox virtualbox-dkms virtualbox-qt unzip \
bzip2 \
libxtst6 \
libxtst6:i386 \
lib32stdc++6 \
libxrender-dev \
libxi6 \
libgconf-2-4

#node
RUN apt-get install -y build-essential
#sudo -E bash -
RUN curl -sL https://deb.nodesource.com/setup_4.x | -E bash -
RUN sudo apt-get install -y nodejs
RUN sudo ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g react-native-cli

RUN git clone https://github.com/facebook/watchman.git
RUN cd watchman
RUN git checkout v4.1.0  # the latest stable release
RUN ./autogen.sh
RUN ./configure
RUN make
RUN sudo make install

RUN sudo npm install -g flow-bin

#ruby
RUN cd
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN exec $SHELL
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
RUN exec $SHELL
RUN git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

RUN rbenv install 2.2.3
RUN rbenv global 2.2.3
RUN ruby -v

#vim
RUN sudo apt-get install -y vim vim-gnome 

RUN git clone git@github.com:jcbashdown/dotfiles.git
RUN cp dotfiles/.bashrc ~/. 
RUN cp dotfiles/.gitconfig ~/. 
# do this on bitbucket?
RUN git config --global user.name "email"
RUN cp dotfiles/environment ~/etc/environment 
RUN cp dotfiles/.vimrc ~/.vimrc
RUN cp dotfiles/.tmux.conf ~/.tmux.conf
RUN rm -rf dotfiles

RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

RUN vim +PluginInstall +qall

RUN apt-get install -y ruby-dev
RUN cd ~/.vim/bundle/command-t/ruby/command-t
RUN ruby extconf.rb 
RUN make
#ssh keys?

#download all current repos?
#git checkout add-testing-start-read-in 
#git checkout wip in graph
# cd in and bundle install, npm install, virtualenv and pip install
# right Gemfile.locks - old when needed, no lock when needed.

#genymotion
#android sdk
#./studio.sh
#jdk
#postgres
#compiz window shortcuts

#get syntax check and line numbers - vim

