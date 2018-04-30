#!/bin/sh

sudo apt install -y libpango-1.0-0

WORKING_FOLDER=$(mktemp -d)
cd $WORKING_FOLDER
wget -O "dropbox.deb" "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb"
sudo dpkg -i dropbox.deb
