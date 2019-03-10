#!/bin/bash

sudo apt install -y \
  libdbus-1-dev \
  libxcursor-dev \
  libxrandr-dev \
  libxi-dev \
  libxinerama-dev \
  libgl1-mesa-dev \
  libxkbcommon-x11-dev \
  libfontconfig-dev \
  libpython-dev

git clone https://github.com/kovidgoyal/kitty && cd kitty
make

sudo sh -c "echo \"#\!/usr/bin/env python3\nimport runpy\nrunpy.run_path('/home/eggerk/dotfiles/setup/install/kitty', run_name='__main__')\" > /usr/bin/kitty; chmod +x /usr/bin/kitty"
