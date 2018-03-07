#!/bin/bash
i3lock -c 000011

if ! echo $HOSTNAME | grep 50 > /dev/null && ! echo $HOST | grep 50 > /dev/null ; then
  # Can't turn off screens for computers with nvidia gpu drivers and a docking
  # station, otherwise the external monitor will "disappear" after turning it
  # on again and needs to be unplugged and replugged.
  sleep 0.2s
  xset dpms force off
fi
/home/eggerk/dotfiles/tools/set-wallpaper.sh
