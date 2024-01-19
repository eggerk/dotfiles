#!/bin/sh

# Steam
sudo apt-get install libdrm2:i386
WORKING_FOLDER=$(mktemp -d)
cd $WORKING_FOLDER
wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
sudo dpkg -i steam.deb

# Lutris
sudo add-apt-repository ppa:lutris-team/lutris
sudo apt update
sudo apt install lutris
