#!/bin/bash

sudo apt-get install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
libstartup-notification0-dev libxcb-randr0-dev \
libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev \
meson ninja-build

# clone the repository
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

latesttag=$(git describe --tags)
echo checking out ${latesttag}
git checkout ${latesttag}

# compile
mkdir -p build && cd build
meson --prefix /usr ..
ninja
sudo ninja install
