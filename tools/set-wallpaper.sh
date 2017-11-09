#!/bin/bash
if echo $HOSTNAME | grep 50  ; then
  # P50
  echo 1
  nitrogen --restore &
else
  echo 2
  feh --bg-fill --randomize /home/eggerk/Pictures/wallpapers/* &
fi
