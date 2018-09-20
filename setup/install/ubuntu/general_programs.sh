#!/bin/sh

# Install everything
sudo apt install \
  backintime-gnome \
  blueman \
  build-essential \
  clementine \
  cmake \
  fonts-symbola \
  gimp \
  git \
  gparted \
  htop \
  inkscape \
  ipython3 \
  network-manager-vpnc-gnome \
  octave \
  pdfshuffler \
  python3-matplotlib \
  python3-numpy \
  ranger \
  rar unrar \
  redshift redshift-gtk \
  silversearcher-ag \
  synaptic \
  tmux \
  tree \
  udiskie \
  vlc vlc-plugin-fluidsynth vlc-plugin-notify \
  xautomation \
  xbindkeys \
  xwiimote \
  zsh

# Disable nautilus Desktop rendering.
gsettings set org.gnome.desktop.background show-desktop-icons false
