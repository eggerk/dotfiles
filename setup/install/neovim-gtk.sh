#!/bin/bash

sudo apt install -y \
    libatk1.0-dev libcairo2-dev libgdk-pixbuf2.0-dev libglib2.0-dev \
    libgtk-3-dev libpango1.0-dev cargo

if [ ! -d neovim-gtk ] ; then
  git clone https://github.com/daa84/neovim-gtk.git || exit 1
fi
cd neovim-gtk || exit 1
sudo make install
gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono derivative Powerline 12'
