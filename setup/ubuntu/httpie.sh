#/bin/sh -e
# Install httpie

curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo apt-key add -

sudo curl -SsL -o /etc/apt/sources.list.d/httpie.list https://packages.httpie.io/deb/httpie.list

sudo apt update

sudo apt install httpie
