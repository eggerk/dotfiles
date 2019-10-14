#!/bin/sh

sudo apt install -y libconfig-dev asciidoc
git clone https://github.com/chjj/compton.git compton
cd compton
make && make docs && sudo make install
cd ..
# rm -rf compton
