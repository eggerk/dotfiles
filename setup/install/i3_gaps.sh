#!/bin/bash

rm -rf i3-gaps
sudo apt-get remove i3
if lsb_release -c | grep xenial > /dev/null ; then
sudo add-apt-repository ppa:aguignard/ppa
  sudo apt-get update

  sudo apt-get install -y libxcb-xrm-dev

  sudo apt-get install -y \
    libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev \
    libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev \
    libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
    libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf \
    libxcb-xrm-dev
else
  # Different requirements for 16.10+.
  sudo apt-get install -y \
    libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev \
    libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev \
    libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
    libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 \
    libxcb-xrm-dev automake
fi

# Packages not provided by i3-gaps.
sudo apt-get install -y i3lock i3status

git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
