#!/bin/bash
killall compton
i3lock -c 000011 -n

if ! echo $HOSTNAME | grep 50 > /dev/null && ! echo $HOST | grep 50 > /dev/null ; then
  # Can't turn off screens for computers with nvidia gpu drivers and a docking
  # station, otherwise the external monitor will "disappear" after turning it
  # on again and needs to be unplugged and replugged.
  sleep 0.2s
  xset dpms force off
fi
/home/eggerk/dotfiles/tools/set-wallpaper.sh
compton --backend glx --paint-on-overlay --glx-no-stencil \
        --vsync opengl-swc --unredir-if-possible -b \
        --config /home/eggerk/dotfiles/compton/compton.conf
