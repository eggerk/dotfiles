#!/bin/bash

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y python3-dev python3-pip curl
sudo apt-get install -y neovim git

sudo pip3 install --upgrade neovim

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
select-editor

# Install vim-plug.
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Language servers
sudo npm i -g pyright
sudo npm i -g bash-language-server
sudo npm i -g vscode-langservers-extracted
yarn global add yaml-language-server
