#!/bin/sh

# Install i3-gaps.
if ! which i3 > /dev/null ; then
  . /home/$USER/dotfiles/setup/install/i3_gaps.sh
fi

# Latest rofi
sudo add-apt-repository ppa:aguignard/ppa
sudo apt update

sudo apt install -y rofi maim xdotool feh xfce4-notifyd compton lightdm

WORKING_FOLDER=$(mktemp -d)
cd $WORKING_FOLDER
wget -O "playerctl.deb" "https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb"
sudo dpkg -i playerctl.deb
