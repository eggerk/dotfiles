#!/bin/sh

set -e

sudo pacman -S --noconfirm \
  sawy \
  polkit \
  xorg-xwayland \
  swaylock \
  greetd-tuigreet \
  wlsunset \
  wev \
  slurp \
  grim \
  wl-clipboard \
  swaybg \
  waybar \
  cliphist \
  easyeffects \
  python-piexif \
  wl-mirror \
  gammastep

yay -S \
  rofi-lbonn-wayland \
  rofi-power-menu \
  nwg-displays

sudo systemctl enable greetd
