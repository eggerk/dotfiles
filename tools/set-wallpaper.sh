#!/bin/zsh
PICTURE_FOLDER=/home/eggerk/Dropbox/wallpapers
echo "Running feh..."
feh --bg-fill --randomize $PICTURE_FOLDER/* &
if [ $1 ] ; then
  # If given an argument it was during startup.
  if echo $HOSTNAME | grep 50 > /dev/null || echo $HOST | grep 50 > /dev/null ; then
    # Do it again because there still seems to be an issue somewhere.
    sleep 0.2
    feh --bg-fill --randomize $PICTURE_FOLDER/* &
  fi
fi
echo "Done!"
