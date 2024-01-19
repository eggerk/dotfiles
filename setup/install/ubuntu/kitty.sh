#!/bin/bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# sudo apt-get install -y \
#   libdbus-1-dev \
#   libxcursor-dev \
#   libxrandr-dev \
#   libxi-dev \
#   libxinerama-dev \
#   libgl1-mesa-dev \
#   libxkbcommon-x11-dev \
#   libfontconfig-dev \
#   libpython-dev

# git clone https://github.com/kovidgoyal/kitty && cd kitty
# git checkout v0.19.1
# make

# sudo sh -c "echo \"#\!/usr/bin/env python3\nimport runpy\nrunpy.run_path('/home/eggerk/dotfiles/setup/install/kitty', run_name='__main__')\" > /usr/bin/kitty; chmod +x /usr/bin/kitty"
target=/home/eggerk/.local/kitty.app/bin/kitty
link_name=/usr/bin/kitty
if [ ! -e "$link_name" ] && [ -f "$target" ]; then
  sudo ln -s "$target" "$link_name"
fi
