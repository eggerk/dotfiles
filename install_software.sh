#!/bin/sh

# Latest i3wm
echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get --allow-unauthenticated install sur5r-keyring
sudo apt-get update

# Install everything
sudo apt-get install backintime-gnome blueman build-essentials clementine \
    cmake colordiff default-jre gimp git gparted htop icedtea-7-jre-jamvm \
    inkscape network-manager-vpnc-gnome pdfshuffler \
    playonlinux rar redshift redshift-gtk synaptic texlive-full xfce4-notifyd \
    unrar virtualbox vlc vlc-plugin-fluidsynth vlc-plugin-notify wine1.6 \
    xautomation xbindkeys xwiimote vim scrot zsh feh tmux i3 rofi

# install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

mkdir setup_install_temp
cd setup_install_temp

# Download and install playerctl
wget -O "playerctl.deb" "https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb"
sudo dpkg -i playerctl.deb

# Dropbox
# wget -O "dropbox.deb" "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb"
# sudo dpkg -i dropbox.deb

# Steam
wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
sudo dpkg -i steam.deb

# Spotify
# 1. Add the Spotify repository signing key to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages
sudo apt-get update

# 4. Install Spotify
sudo apt-get install -y spotify-client

# clean up
cd ..
rm -rf setup_install_temp

# Install vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall # Needs to be manually terminated
