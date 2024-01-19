#!/bin/bash

sudo pacman -S --noconfirm \
    neovim \
    pyright \
    bash-language-server \
    yaml-language-server

# sudo npm i -g vscode-langservers-extracted
yarn global add yaml-language-server
