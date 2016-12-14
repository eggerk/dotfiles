#!/bin/zsh

# get volume
VOLUME_ALL="$(amixer -D pulse sget Master | awk -F'[][]' '/%/ { print $2 }' | awk '{print $1;}')"
VOLUME="$(echo $VOLUME_ALL | tr '\n' ' ' | awk '{print $1}' | tr -d %)"

OUTPUT="["

# full
if [ "$VOLUME" -gt 0 ]
then
  for c in {5..$VOLUME..5}
  do
    OUTPUT="$OUTPUT="
  done
fi

# empty
if [ "$VOLUME" -lt 100 ]
then
  for c in {$VOLUME..95..5}
  do
    OUTPUT="$OUTPUT-"
  done
fi

OUTPUT="$OUTPUT] ($VOLUME%)"

# send notification
pkill xfce4-notifyd # hacky
pkill dunst
notify-send -i audio-headphones "Volume Level" $OUTPUT

# play sound
MUSIC_PLAYING=$(pacmd list-sink-inputs | grep -c 'state: RUNNING')
if [ $MUSIC_PLAYING -ne 1 ]
then
  paplay /usr/share/sounds/ubuntu/stereo/message.ogg
fi
