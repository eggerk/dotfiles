#!/usr/bin/sh
set -x
PICTURE_FOLDER=/home/eggerk/Pictures/wallpapers
pic=$(find "$PICTURE_FOLDER" -maxdepth 1 -type f | shuf -n 1)

if [ -n "$RUNTIME_DIRECTORY" ]; then
  runtime_dir="$RUNTIME_DIRECTORY"
else
  runtime_dir="$XDG_RUNTIME_DIR/change-desktop-wallpaper"
  mkdir -p "$runtime_dir" || true
fi

if [ -d "$runtime_dir" ]; then
  ln -fs "$pic" "$runtime_dir"/current_wallpaper
fi

if pgrep i3 > /dev/null; then
  feh --bg-fill "$pic"
else
  swaymsg output '*' bg "$pic" fill
fi
