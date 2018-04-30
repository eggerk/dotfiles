#!/bin/sh

# Install everything
sudo apt install backintime-gnome blueman build-essential clementine cmake \
    gimp git gparted htop inkscape network-manager-vpnc-gnome pdfshuffler rar \
    redshift redshift-gtk synaptic unrar vlc vlc-plugin-fluidsynth \
    vlc-plugin-notify xautomation xbindkeys xwiimote zsh tmux octave udiskie \
    ipython3 python3-numpy python3-matplotlib

# Disable nautilus Desktop rendering.
gsettings set org.gnome.desktop.background show-desktop-icons false
