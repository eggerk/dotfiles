#! /bin/bash

function setMonitors() {
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
  sleep 2
  i3-msg reload
}

if echo $HOSTNAME | grep 50  > /dev/null
then
  # P50
  setMonitors
elif echo $HOST | grep 50
then
  setMonitors
else
  echo "Not P50. Not changing anything."
fi
