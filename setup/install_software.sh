#!/bin/sh

# Latest i3wm
echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt --allow-unauthenticated install sur5r-keyring
sudo apt update

# Latest rofi
sudo add-apt-repository ppa:aguignard/ppa

# Install everything
sudo apt install backintime-gnome blueman build-essential clementine \
    cmake colordiff default-jre gimp git gparted htop \
    inkscape network-manager-vpnc-gnome pdfshuffler \
    rar redshift redshift-gtk synaptic texlive-full xfce4-notifyd \
    unrar virtualbox vlc vlc-plugin-fluidsynth vlc-plugin-notify \
    xautomation xbindkeys xwiimote scrot zsh feh tmux i3 rofi
    octave udiskie rxvt-unicode-256color

# Disable nautilus Desktop rendering.
gsettings set org.gnome.desktop.background show-desktop-icons false

echo "apt completed ========================"

# install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

mkdir setup_install_temp
cd setup_install_temp

# Download and install playerctl
wget -O "playerctl.deb" "https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb"
sudo dpkg -i playerctl.deb

# Dropbox
wget -O "dropbox.deb" "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb"
sudo dpkg -i dropbox.deb

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

# Slack.
wget -O "slack-desktop.deb" "https://downloads.slack-edge.com/linux_releases/slack-desktop-2.7.1-amd64.deb"
sudo dpkg -i slack-desktop.deb

# clean up
cd ..
rm -rf setup_install_temp

# Install vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall # Needs to be manually terminated
