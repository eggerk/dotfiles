#!/bin/bash
function startCommunication() {
  /home/eggerk/software/yakyak-linux-x64/yakyak &
  sleep 5
 thunderbird &
 i3-msg resize grow width 20 px or 20 ppt
}

if echo $HOSTNAME | grep 50  ; then
  # P50
  startCommunication
elif echo $HOST | grep 50 ; then
  startCommunication
fi
