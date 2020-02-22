#!/bin/sh

git clone https://github.com/f1u77y/wmc-mpris.git
cd wmc-mpris || exit 1
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
sudo make install
