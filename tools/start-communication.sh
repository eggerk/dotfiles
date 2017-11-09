#!/bin/bash
function startCommunication() {
  /home/eggerk/software/yakyak-linux-x64/yakyak &
  thunderbird &
  slack &
  i3-msg workspace 0
  i3-msg layout tabbed
  i3-msg workspace 1
}

if echo $HOSTNAME | grep 50  ; then
  # P50
  startCommunication
elif echo $HOST | grep 50 ; then
  startCommunication
fi
