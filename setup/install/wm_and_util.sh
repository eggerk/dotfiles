#!/bin/sh

# Latest i3wm
echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt --allow-unauthenticated install sur5r-keyring

# Latest rofi
sudo add-apt-repository ppa:aguignard/ppa
sudo apt update

sudo apt install i3 rofi scrot feh xfce4-notifyd

WORKING_FOLDER=$(mktemp -d)
cd $WORKING_FOLDER
wget -O "playerctl.deb" "https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb"
sudo dpkg -i playerctl.deb
