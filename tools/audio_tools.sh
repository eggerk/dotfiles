#!/bin/zsh

function get_volume() {
  # Get volume
  VOLUME_ALL="$(amixer -D pulse sget Master | awk -F'[][]' '/%/ { print $2 }' | awk '{print $1;}')"
  VOLUME="$(echo $VOLUME_ALL | tr '\n' ' ' | awk '{print $1}' | tr -d %)"
  MUTE_ALL=$(amixer -D pulse sget Master | awk -F'[][]' '/%/ { print $3 }' | awk '{print $1;}')
}

function get_current_audio_output() {
  ALL_AUDIO_OUTPUTS=$(pacmd list-sinks | grep index | sed "s/\\*/ /" | awk '{print $2}')
  CURRENT_AUDIO_OUTPUT="$(pacmd list-sinks | grep "* index" | awk '{ print $3 }')"
  ALL_OUTPUT_DEVICE_NAMES=$(pacmd list-sinks | grep "device.description" | sed -r "s/device.description = \"(.*)\"/\\1/")

  # Get device name
  NUM_OUTPUTS=$(echo "$ALL_AUDIO_OUTPUTS" | wc -l)
  for line in $(seq 1 $((NUM_OUTPUTS))) ; do
    AUDIO_CURR_LINE=$(echo $ALL_AUDIO_OUTPUTS | sed "${line}q;d")
    if [ "$AUDIO_CURR_LINE" -eq "$CURRENT_AUDIO_OUTPUT" ] ; then
      # Found match
      AUDIO_CURR_LINE=$line
      break
    fi
  done
  OUTPUT_DEVICE_NAME=$(echo $ALL_OUTPUT_DEVICE_NAMES | sed "${AUDIO_CURR_LINE}q;d" | sed -e 's/^[[:space:]]*//' )
}

function switch_to_next_output() {
  get_current_audio_output

  NUM_OUTPUTS=$(echo "$ALL_AUDIO_OUTPUTS" | wc -l)

  # Find next audio device.
  for line in $(seq 1 $((NUM_OUTPUTS))) ; do
    AUDIO_CURR_LINE=$(echo $ALL_AUDIO_OUTPUTS | sed "${line}q;d")
    if [ "$AUDIO_CURR_LINE" -eq "$CURRENT_AUDIO_OUTPUT" ] ; then
      NEXT_LINE=$((line+1))
      if [ "$NEXT_LINE" -gt "$NUM_OUTPUTS" ] ; then
        NEXT_LINE=1
      fi
      NEXT_OUTPUT=$(echo $ALL_AUDIO_OUTPUTS | sed "${NEXT_LINE}q;d")
      break
    fi
  done

  # Switch to next output
  pacmd set-default-sink $NEXT_OUTPUT

  # Move all existing sinks
  ALL_SINK_INPUTS=$(pacmd list-sink-inputs | grep index | sed 's/*/ /' | awk '{print $2}')
  while read -r i ; do
    pacmd move-sink-input $i $NEXT_OUTPUT
  done <<< $ALL_SINK_INPUTS
}

function volume_notification() {
  get_volume
  get_current_audio_output
  OUTPUT="["

  # Full
  if [ "$VOLUME" -gt 0 ]
  then
    for c in {5..$VOLUME..5}
    do
      OUTPUT="$OUTPUT="
    done
  fi

  # Empty
  if [ "$VOLUME" -lt 100 ]
  then
    for c in {$VOLUME..95..5}
    do
      OUTPUT="$OUTPUT-"
    done
  fi

  OUTPUT="$OUTPUT] ($VOLUME%"
  if amixer -D pulse sget Master | grep off > /dev/null ; then
    OUTPUT="$OUTPUT, muted"
  fi
  OUTPUT="$OUTPUT) \nOutput: $OUTPUT_DEVICE_NAME"

  # Send notification
  pkill xfce4-notifyd # hacky
  pkill dunst
  notify-send -i audio-headphones "Volume Level" $OUTPUT

  # Play sound
  MUSIC_PLAYING=$(pacmd list-sink-inputs | grep -c 'state: RUNNING')

  if [ $MUSIC_PLAYING -ne 1 ]
  then
    paplay -d $CURRENT_AUDIO_OUTPUT /usr/share/sounds/ubuntu/stereo/message.ogg
  fi
}


case $1 in
-r*)
  # Raise
  amixer -D pulse sset Master 5\%\+
  ;;
-l*)
  # Lower
  amixer -D pulse sset Master 5\%-
  ;;
-m*)
  # Mute
  get_current_audio_output
  pactl set-sink-mute $CURRENT_AUDIO_OUTPUT toggle
  ;;
-c*)
  # Change output
  switch_to_next_output
  ;;
-h*)
  echo "Usage: audio_tools.sh [-r|-l|-m|-c|-h]

  Options (only one possible at a time):
    -r    Raise volume by 5%.
    -l    Lower volume by 5%.
    -m    Mute/unmute audio.
    -c    Change to next audio device.
    -h    Display this help text.

  Launch without extra argument to only get an info notification popup."
  exit 0
  ;;
esac
volume_notification
return 0
