#!/bin/sh

# Install i3-gaps.
if ! which i3 > /dev/null ; then
  . /home/$USER/dotfiles/setup/install/i3_gaps.sh
fi

# Latest rofi
sudo apt-get install -y libbison-dev flex libxcb-ewmh-dev librsvg2-dev
git clone https://github.com/davatorium/rofi.git --recursive || true
cd rofi || exit 1
autoreconf -i
mkdir -p build && cd build
../configure --disable-check  # check too old on 18.04.
make
sudo make install
cd ..

sudo apt-get install -y maim xdotool feh dunst lightdm xautolock sxiv exiv2 i3lock i3status
