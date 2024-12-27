#!/bin/sh

set -e

sudo pacman -S --noconfirm \
  polkit \
  redshift \
  maim \
  rofi \
  xorg-xev \
  picom

yay -S rofi-greenclip
