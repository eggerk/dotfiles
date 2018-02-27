#! /bin/bash

function setMonitorsP50() {
  MONITOR1=$(xrandr -q | grep eDP | awk '{ print $1 }')
  MONITOR2=$(xrandr -q | grep DP | grep -v eDP | grep -v disconnected | awk '{print $1}')
  xrandr --output $MONITOR1 --mode 1920x1080 --pos 0x0 --dpi 96
  xrandr --output $MONITOR2 --mode 1920x1200  --right-of $MONITOR1 --dpi 96

  # Be sure that configuration is applied.
  i3-msg reload
  sleep 2
  xrandr --output $MONITOR1 --mode 1920x1080 --pos 0x0 --dpi 96
  xrandr --output $MONITOR2 --mode 1920x1200  --right-of $MONITOR1 --dpi 96
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
  MONITOR1=$(xrandr -q | grep DVI | grep connected | awk '{print $1}')
  MONITOR2=$(xrandr -q | grep HDMI | grep connected | awk '{print $1}')
  xrandr --output $MONITOR1 --mode 1920x1080
  xrandr --output $MONITOR2 --mode 1920x1080 --same-as $MONITOR1
else
  # T440p
  MONITOR1=$(xrandr -q | grep eDP | awk '{ print $1 }')
  MONITOR2=$(xrandr -q | grep DP | grep -v eDP | grep -v disconnected | awk '{print $1}')
  i3-msg workspace 0
  i3-msg move workspace to output $MONITOR1
  i3-msg workspace 1
  if [[ ! -z $MONITOR2 ]] ; then
    i3-msg move workspace to output $MONITOR2
  fi
fi
