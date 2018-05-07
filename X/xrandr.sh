#! /bin/bash

ENABLE_MONITOR1="off"
ENABLE_MONITOR2="off"
if [[ ! -z $1 ]] && [ "$1" = "on" ] ; then
  ENABLE_MONITOR1="on"
fi
if [[ ! -z $2 ]] && [ "$2" = "on" ] ; then
  ENABLE_MONITOR2="on"
fi

function setMonitorsP50() {
  MONITOR1=$(xrandr -q | grep eDP | awk '{ print $1 }')
  if [ "$ENABLE_MONITOR1" == "on" ] ; then
    xrandr --output $MONITOR1 --mode 1920x1080 --pos 0x0 --dpi 96
  else
    xrandr --output $MONITOR1 --off
  fi
  MONITOR2=$(xrandr -q | grep DP | grep -v eDP | grep -v disconnected | awk '{print $1}')
  if [ "$ENABLE_MONITOR2" == "on" ] ; then
    xrandr --output $MONITOR2 --mode 1920x1200  --right-of $MONITOR1 --dpi 96
  else
    xrandr --output $MONITOR2 --off
  fi

  # Be sure that configuration is applied.
  i3-msg reload
  sleep 1
  if [ "$ENABLE_MONITOR1" == "on" ] ; then
    xrandr --output $MONITOR1 --mode 1920x1080 --pos 0x0 --dpi 96
  else
    xrandr --output $MONITOR1 --off
  fi
  if [ "$ENABLE_MONITOR2" == "on" ] ; then
    xrandr --output $MONITOR2 --mode 1920x1200  --right-of $MONITOR1 --dpi 96
  else
    xrandr --output $MONITOR2 --off
  fi
  i3-msg workspace 0
  i3-msg move workspace to output $MONITOR1
  i3-msg workspace 1
  i3-msg move workspace to output $MONITOR2
  i3-msg reload
}

if echo $HOSTNAME | grep 50  > /dev/null || echo $HOST | grep 50 > /dev/null
then
  # P50
  setMonitorsP50
elif echo $HOSTNAME | grep desktop > /dev/null || echo $HOST | grep desktop > /dev/null
then
  # Desktop
  if [ "$ENABLE_MONITOR1" == "on" ] ; then
    MONITOR1=$(xrandr -q | grep DVI | grep connected | awk '{print $1}')
    xrandr --output $MONITOR1 --mode 1920x1080
  else
    xrandr --output $MONITOR1 --off
  fi
  if [ "$ENABLE_MONITOR2" == "on" ] ; then
    MONITOR2=$(xrandr -q | grep HDMI | grep connected | awk '{print $1}')
    xrandr --output $MONITOR2 --mode 1920x1080 --same-as $MONITOR1
  else
    xrandr --output $MONITOR2 --off
  fi
else
  # T440p
  if [ "$ENABLE_MONITOR1" == "on" ] ; then
    MONITOR1=$(xrandr -q | grep eDP | awk '{ print $1 }')
  fi
  if [ "$ENABLE_MONITOR2" == "on" ] ; then
    MONITOR2=$(xrandr -q | grep DP | grep -v eDP | grep -v disconnected | awk '{print $1}')
  fi
  i3-msg workspace 0
  i3-msg move workspace to output $MONITOR1
  i3-msg workspace 1
  if [[ ! -z $MONITOR2 ]] ; then
    i3-msg move workspace to output $MONITOR2
  fi
fi

MESSAGE="Connected"
if [[ ! -z $MONITOR1 ]] && [ $ENABLE_MONITOR1 = "on" ] ; then
  MESSAGE="${MESSAGE} ${MONITOR1}"
  if [[ ! -z $MONITOR2 ]] && [ $ENABLE_MONITOR2 = "on" ] ; then
    MESSAGE="${MESSAGE} and"
  fi
fi
if [[ ! -z $MONITOR2 ]] && [ $ENABLE_MONITOR2 = "on" ] ; then
  MESSAGE="${MESSAGE} ${MONITOR2}."
fi
notify-send -i display "Monitors connected" "${MESSAGE}"
