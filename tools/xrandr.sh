#! /bin/bash

usage() {
  echo "./xrandr.sh [action]\n"
  echo "Action can be auto, internal, external, expand, or mirror"
  echo "Default action is auto."
  exit
}

if [[ -z $1 ]] ; then
  ACTION="auto"
else
  ACTION=$1
fi

# Get monitors for computer.

ENABLE_MONITOR1="off"
ENABLE_MONITOR2="off"
if [[ ! -z $1 ]] && [ "$1" = "on" ] ; then
  ENABLE_MONITOR1="on"
fi
if [[ ! -z $2 ]] && [ "$2" = "on" ] ; then
  ENABLE_MONITOR2="on"
fi

if echo $HOSTNAME | grep 50  > /dev/null || echo $HOST | grep 50 > /dev/null
then
  # P50
  MONITOR1=$(xrandr -q | grep eDP | awk '{ print $1 }')
  RESOLUTION1="1920x1080"
  MONITOR2=$(xrandr -q | grep DP | grep -v eDP | grep -v disconnected | awk '{print $1}')
  RESOLUTION2="2560x1440"
  RESOLUTION2b="1920x1200"
  RESOLUTION2c="1920x1080"
  if [ "$ACTION" = "auto" ] ; then
    if xrandr -q | grep $MONITOR2 -A3 | grep $RESOLUTION2 > /dev/null
    then
      ACTION="external"
    elif xrandr -q | grep $MONITOR2 -A3 | grep $RESOLUTION2b > /dev/null
    then
      ACTION="external"
      RESOLUTION2="$RESOLUTION2b"
    elif xrandr -q | grep $MONITOR2 -A3 | grep $RESOLUTION2c > /dev/null
    then
      ACTION="external"
      RESOLUTION2="$RESOLUTION2c"
    else
      ACTION="internal"
    fi
  fi
elif echo $HOSTNAME | grep desktop > /dev/null || echo $HOST | grep desktop > /dev/null
then
  # Desktop
  MONITOR1=$(xrandr -q | grep DVI | grep connected | awk '{print $1}')
  RESOLUTION1="1920x1080"
  MONITOR2=$(xrandr -q | grep HDMI | grep connected | awk '{print $1}')
  RESOLUTION2="1920x1080"
  if [ "$ACTION" = "auto" ] ; then
    ACTION="mirror"
  fi
else
  # T440p
  MONITOR1=$(xrandr -q | grep eDP | awk '{ print $1 }')
  RESOLUTION1="1920x1080"
  MONITOR2=$(xrandr -q | grep DP | grep -v eDP | grep -v disconnected | awk '{print $1}')
  RESOLUTION2="1920x1080"
fi

# Check if need to enable monitor 1.
POSITION1="--off"
if [ "$ACTION" = "auto" ] || [ "$ACTION" = "internal" ] || [ "$ACTION" = "expand" ] || [ "$ACTION" = "mirror" ]
then
  if xrandr -q | grep $MONITOR1 -A12 | grep $RESOLUTION1 > /dev/null
  then
    POSITION1="--pos 0x0"
  fi
fi

# Monitor 2 has the desired resolution available.
POSITION2="--off"
if xrandr -q | grep $MONITOR2 -A3 | grep $RESOLUTION2 > /dev/null
then
  if [ $ACTION = "auto" ] || [ $ACTION = "expand" ]
  then
    POSITION2="--right-of ${MONITOR1}"
  elif [ $ACTION = "external" ]
  then
    POSITION2="--pos 0x0"
  elif [ $ACTION = "mirror" ]
  then
    POSITION2="--same-as ${MONITOR1}"
  fi
fi

MODE1="--mode $RESOLUTION1"
if [ "$POSITION1" == "--off" ] ; then
  MODE1=""
fi
MODE2="--mode $RESOLUTION2"
if [ "$POSITION2" == "--off" ] ; then
  MODE2=""
fi

if [ "$POSITION1" = "--off" ] && [ "$POSITION2" = "--off" ]
then
  echo "Cannot turn both monitors off!"
  notify-send -i error "Monitors connected" "Couldn't change monitors because all monitors would be turned off!"
  exit 1
fi

CMD1="xrandr --output $MONITOR1 $MODE1 $POSITION1 --dpi 96"
CMD2="xrandr --output $MONITOR2 $MODE2 $POSITION2 --dpi 96"
echo $CMD1
$CMD1
echo $CMD2
$CMD2

if [ $ACTION = "auto" ] ; then
  # Move all workspaces except 0 to monitor 2.
  CURRENT_WORKSPACE="$(i3-msg -t get_workspaces | python3 -mjson.tool | grep '\"focused\": true' -B3 -A3 | grep num | awk '{print $2}' | tr ',' ' ')"
  CURRENT_WORKSPACE_MONITOR2="$(i3-msg -t get_workspaces | python3 -mjson.tool | grep '\"visible\": true' -B3 -A8 | grep $MONITOR2 -B10 | grep num | awk '{print $2}' | tr ',' ' ')"
  i3-msg workspace 0
  i3-msg move workspace to output $MONITOR1
  for i in $(seq 1 10) ; do
    if [ "$POSITION2" != "--off" ] ; then
      i3-msg workspace $i
      i3-msg move workspace to output $MONITOR2
    fi
  done
  i3-msg workspace $CURRENT_WORKSPACE_MONITOR2
  i3-msg workspace $CURRENT_WORKSPACE
fi

MESSAGE="Connected"
if [[ ! -z $MONITOR1 ]] && [ "$POSITION1" != "--off" ] ; then
  MESSAGE="${MESSAGE} ${MONITOR1}"
  if [[ ! -z $MONITOR2 ]] && [ "$POSITION2" != "--off" ] ; then
    MESSAGE="${MESSAGE} and"
  fi
fi
if [[ ! -z $MONITOR2 ]] && [ "$POSITION2" != "--off" ] ; then
  MESSAGE="${MESSAGE} ${MONITOR2}"
fi
notify-send -i display "Monitors connected" "${MESSAGE}."
