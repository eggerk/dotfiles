#!/bin/sh

# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
mkdir -p ~/.config/fontconfig/
touch ~/.config/fontconfig/conf.d
fc-cache -vf
