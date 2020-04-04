#!/bin/bash
i3-msg gaps inner all set 0
i3-msg gaps outer all set 0

if hostname | grep -q 50 || hostname | grep -q desktop ; then
  i3-msg gaps vertical all set 0
  i3-msg gaps horizontal all set 200
  i3-msg gaps inner all set 12
else
  echo "no"
  i3-msg gaps inner all set 5
  i3-msg gaps outer all set 3
  CURRENT_WORKSPACE="$(i3-msg -t get_workspaces | python3 -mjson.tool | grep '\"focused\": true' -B3 -A3 | grep num | awk '{print $2}' | tr -d ',')"
  i3-msg workspace 10
  i3-msg gaps outer current set 30
  i3-msg gaps inner current set 25
  i3-msg workspace "$CURRENT_WORKSPACE"
fi
