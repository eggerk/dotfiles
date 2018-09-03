#!/bin/bash
function startCommunication() {
  # i3-msg layout tabbed
  i3-msg 'workspace 0; layout tabbed;' \
      'exec /home/eggerk/software/web_apps/wrike-linux-x64/wrike;' \
      'exec /home/eggerk/software/web_apps/google-chat-linux-x64/google-chat;' \
      'exec thunderbird;'
}

if echo $HOSTNAME | grep 50  ; then
  # P50
  startCommunication
elif echo $HOST | grep 50 ; then
  startCommunication
fi
