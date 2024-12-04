#!/bin/sh

set -e
set -x

# Install everything
sudo pacman -S \
  alacritty \
  base-devel \
  blueman \
  cmake \
  digikam \
  exa \
  exiv2 \
  fd \
  gimp \
  git \
  htop \
  inkscape \
  ipython \
  maim \
  ncdu \
  neovim \
  ranger \
  rapid-photo-downloader \
  redshift \
  ripgrep \
  skim \
  strawberry \
  sxiv \
  tree \
  udiskie \
  xautomation \
  xbindkeys \
  xclip \
  xdotool \
  xh \
  zsh

  #backintime-qt \
# Disable nautilus Desktop rendering.
gsettings set org.gnome.desktop.background show-desktop-icons false
