#!/bin/zsh
function generate_wallpaper {
  WORKING_FOLDER=$(mktemp -d)
  PICTURE_FOLDER=/home/eggerk/Dropbox/wallpapers

  PICTURES=$(ls "$PICTURE_FOLDER" | shuf -n $(xrandr -q | grep "*" | wc -l))
  echo "Combining the following pictures:\n$PICTURES"

  timestamp=$(date +%s)
  OUTPUT_FOLDER="/home/eggerk/Pictures/wallpapers2"
  mkdir -p $OUTPUT_FOLDER
  OUTPUT_PICTURE="$OUTPUT_FOLDER/generated_wallpaper_$timestamp.jpg"

  while read -r PICTURE;do
    convert "$PICTURE_FOLDER/$PICTURE" -resize 1920x1200 "$WORKING_FOLDER/$PICTURE"
  done <<< $PICTURES
  rm $OUTPUT_FOLDER/generated_wallpaper*
  convert +append $WORKING_FOLDER/* $OUTPUT_PICTURE

  # Write nitrogen config.
  sed -i "s@file=/home.*@file=$OUTPUT_PICTURE@g" /home/eggerk/.config/nitrogen/bg-saved.cfg
}

if echo $HOSTNAME | grep 50 > /dev/null || echo $HOST | grep 50 > /dev/null ; then
  # P50
  generate_wallpaper
  echo "Restoring nitrogen..."
  nitrogen --restore &
else
  echo "Rerunning feh..."
  feh --bg-fill --randomize /home/eggerk/Pictures/wallpapers/* &
fi
echo "Done!"
