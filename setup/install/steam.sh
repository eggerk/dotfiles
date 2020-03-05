#!/bin/sh

sudo apt-get install libdrm2:i386
WORKING_FOLDER=$(mktemp -d)
cd $WORKING_FOLDER
wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
sudo dpkg -i steam.deb
