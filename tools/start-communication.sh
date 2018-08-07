#!/bin/bash
function startCommunication() {
  # i3-msg layout tabbed
  i3-msg 'workspace 0; layout tabbed;' \
      'exec /home/eggerk/software/web_apps/github-linux-x64/github;' \
      'exec /home/eggerk/software/web_apps/gitlab-linux-x64/gitlab;' \
      'exec firefox wrike.com;' \
      'exec /home/eggerk/software/web_apps/google-chat-linux-x64/google-chat;' \
      'exec /home/eggerk/software/web_apps/gmail-linux-x64/gmail;'
}

if echo $HOSTNAME | grep 50  ; then
  # P50
  startCommunication
elif echo $HOST | grep 50 ; then
  startCommunication
fi
