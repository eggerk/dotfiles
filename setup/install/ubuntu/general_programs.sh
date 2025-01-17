#!/bin/sh

set -e
set -x

# Install everything
sudo apt-get install -y \
  backintime-qt \
  blueman \
  build-essential \
  cmake \
  fd-find \
  git \
  htop \
  httpie \
  ipython3 \
  ncdu \
  python3-numpy \
  ranger \
  rar unrar \
  redshift redshift-gtk \
  synaptic \
  tree \
  udiskie \
  unattended-upgrades- \
  xautomation \
  xbindkeys \
  bat \
  ripgrep \
  zsh

sudo ln -s /usr/bin/fdfind /usr/local/bin/fd

# Disable nautilus Desktop rendering.
gsettings set org.gnome.desktop.background show-desktop-icons false

# Purge snap.
for package in $(snap list | grep -vE '^Name' | cut -d ' ' -f1); do
  sudo snap remove "$package"
done

sudo umount "$(mount | grep /snap/core | cut -d\  -f3)" || true  # 20.04
sudo umount /var/snap  || true # 20.10
sudo apt purge -y snapd
rm -rf ~/snap || true
sudo rm -rf /snap /var/snap /var/lib/snapd || true
