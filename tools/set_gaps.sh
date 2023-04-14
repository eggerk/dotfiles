#!/bin/bash
i3-msg gaps inner all set 0
i3-msg gaps outer all set 0

big_gaps=false
if hostname | grep -q 50 ; then
  big_gaps=true
fi

if hostname | grep -q desktop && \
    xrandr -q | grep -E '(DP|DisplayPort)' | grep -v disconnected | grep -q 2560; then
  big_gaps=true
fi

if "$big_gaps"; then
  i3-msg gaps vertical all set 0
  i3-msg gaps horizontal all set 200
  i3-msg gaps inner all set 10
else
  i3-msg gaps inner all set 5
  i3-msg gaps outer all set 3
  CURRENT_WORKSPACE="$(i3-msg -t get_workspaces | python3 -mjson.tool | grep '\"focused\": true' -B3 -A3 | grep num | awk '{print $2}' | tr -d ',')"
  i3-msg workspace 10
  i3-msg gaps outer current set 30
  i3-msg gaps inner current set 25
  i3-msg workspace "$CURRENT_WORKSPACE"
fi
