#!/bin/sh

set -e
set -x

# Install everything
sudo apt-get install -y \
  backintime-qt \
  blueman \
  build-essential \
  clementine \
  cmake \
  digikam \
  fd-find \
  fonts-symbola \
  gimp \
  git \
  htop \
  httpie \
  inkscape \
  ipython3 \
  ncdu \
  network-manager-vpnc-gnome \
  pdfshuffler \
  python3-matplotlib \
  python3-numpy \
  ranger \
  rapid-photo-downloader \
  rar unrar \
  redshift redshift-gtk \
  synaptic \
  tree \
  udiskie \
  unattended-upgrades- \
  vlc vlc-plugin-fluidsynth vlc-plugin-notify \
  xautomation \
  xbindkeys \
  xwiimote \
  zsh

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

# Some direct deb installs.
tmp_dir="$(mktemp -d)"

finish() {
  rm -rf "$tmp_dir"
}
trap finish EXIT

cd "$tmp_dir"

wget https://github.com/sharkdp/bat/releases/download/v0.18.0/bat_0.18.0_amd64.deb
wget https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
sudo apt-get -y install ./*.deb
