#!/bin/zsh
PICTURE_FOLDER=/home/eggerk/Dropbox/wallpapers
echo "Running feh..."
feh --bg-fill --randomize $PICTURE_FOLDER/* &
echo "Done!"
