#!/bin/bash
function startCommunication() {
  # i3-msg layout tabbed
  i3-msg 'workspace 0; exec thunderbird;'
}

if hostname | grep -q 50  ; then
  # P50
  startCommunication
fi
