#!/bin/zsh
function generate_wallpaper {
  WORKING_FOLDER=$(mktemp -d)
  PICTURE_FOLDER=/home/eggerk/Dropbox/wallpapers
  PICTURES=$(ls "$PICTURE_FOLDER" | shuf -n $(xrandr -q | grep "*" | wc -l))
  echo "Combining the following pictures:\n$PICTURES"
  OUTPUT_PICTURE=/home/eggerk/Pictures/generated_wallpaper.jpg
  while read -r PICTURE;do
    convert "$PICTURE_FOLDER/$PICTURE" -resize 1920x1200 "$WORKING_FOLDER/$PICTURE"
  done <<< $PICTURES
  convert +append $WORKING_FOLDER/* $OUTPUT_PICTURE
}

if echo $HOSTNAME | grep 50  ; then
  # P50
  # TODO(eggerk): figure out how to set in nitrogen.
  generate_wallpaper
  nitrogen --restore &
else
  feh --bg-fill --randomize /home/eggerk/Pictures/wallpapers/* &
fi
