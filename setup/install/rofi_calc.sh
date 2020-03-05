#!/bin/sh -e
sudo apt-get install -y libmpfr-dev
git clone https://github.com/Qalculate/libqalculate.git || true
cd libqalculate || exit 1
./autogen.sh
./configure
make
sudo make install
sudo ln -s /usr/local/bin/qalc /usr/bin/qalc
sudo ldconfig

git clone https://github.com/svenstaro/rofi-calc.git rofi-calc || true
cd rofi-calc || exit 1
autoreconf -i
mkdir -p build
cd build/
../configure
make
sudo make install
