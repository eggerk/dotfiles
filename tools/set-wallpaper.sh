#!/usr/bin/sh
set -x
PICTURE_FOLDER=/home/eggerk/Pictures/wallpapers
echo "Running feh..."
feh --bg-fill --randomize "$PICTURE_FOLDER"
echo "Done!"
