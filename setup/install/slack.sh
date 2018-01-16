#!/bin/sh

WORKING_FOLDER=$(mktemp -d)
cd $WORKING_FOLDER
wget -O "slack-desktop.deb" "https://downloads.slack-edge.com/linux_releases/slack-desktop-2.7.1-amd64.deb"
sudo dpkg -i slack-desktop.deb

