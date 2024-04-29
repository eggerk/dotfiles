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
  wl-mirror

yay -S \
  rofi-lbonn-wayland
  rofi-power-menu

sudo systemctl enable greetd
