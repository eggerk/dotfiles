#!/bin/sh -e
sudo apt-get install rofi-dev qalc libtool

git clone https://github.com/svenstaro/rofi-calc.git rofi-calc || true
cd rofi-calc || exit 1
autoreconf -i
mkdir -p build
cd build/
../configure
make
sudo make install
