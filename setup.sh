#!/bin/bash

#add 3rd party repositories  
sudo add-apt-repository ppa://chris-lea/nbode.js -y 
sudo add-apt-repository ppa:webupd8team/java -y 
sudo apt-add-repository -y ppa:cassou/emacs

#chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

#forget it, they do not provide a secure apt method 
sudo apt-get update

sudo apt-get install -y make g++ cmake
sudo apt-get install -y nodejs
sudo apt-get install -y zsh
sudo apt-get install -y sshpass 
sudo apt-get install -y tmux
sudo apt-get install -y emacs24 emacs24-el emacs24-common-non-dfsg git-el #for git integration 

sudo apt-get install -y google-chrome-stable 
sudo apt-get install -y redshift 

#install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#install anaconda (silent install)
mkdir ../Download
wget http://repo.continuum.io/archive/Anaconda3-4.1.1-Linux-x86_64.sh -O ../Download/anaconda.sh
bash ../Download/anaconda.sh -b -p $HOME/anaconda3
export PATH="$HOME/anaconda3/bin:$PATH"

#install jdk
sudo apt-get install -y oracle-java8-installer
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

# https://github.com/creationix/nvm
sudo apt-get install -y git-core
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

#git setup 
git config --global user.name "Mike Chen"
git config --global user.email "yuechuan20@gmail.com"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

# Load nvm and install latest production node
#source $HOME/.nvm/nvm.sh
#nvm install v0.10.12
#nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
#npm install -g jshint cheerio commander express

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
#sudo apt-get install -y rlwrap


#anaconda for python 3



# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/cyc115/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

#install heroku toolbelt
#wget -qO- https://toolbelt.heroku.com/install-buntu.sh | sh



#set up tmux

cd ~/dotfiles/additional/tmux-mem-cpu/
cmake .
make
sudo make install
cd 
touch .tmux.conf
echo 'set -g status-interval 2' >> .tmux.conf
echo "set -g status-left \"#S #(tmux-mem-cpu 2 'fg=blue,bg=black,bright')#[default]\"" >> .tmux.conf


