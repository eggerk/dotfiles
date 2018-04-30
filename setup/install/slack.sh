#!/bin/sh

sudo apt install -y libappindicator1 libindicator7

WORKING_FOLDER=$(mktemp -d)
cd $WORKING_FOLDER
wget -O "slack-desktop.deb" "https://downloads.slack-edge.com/linux_releases/slack-desktop-3.0.2-amd64.deb"
sudo dpkg -i slack-desktop.deb

