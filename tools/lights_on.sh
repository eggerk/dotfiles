#!/bin/bash
# Adapted from https://www.reddit.com/r/archlinux/comments/3wmwxc/how_can_i_set_xautolock_not_trigger_lock_when/cxxj02s/

while true
do
    activ_win_id=$(xprop -root _NET_ACTIVE_WINDOW)
    active_window=$(xprop -id ${activ_win_id:40:9})
    if echo $active_window | grep _NET_WM_STATE_FULLSCREEN > /dev/null ; then
      xautolock -disable
    elif echo $active_window | grep -i youtube > /dev/null; then
      xautolock -disable
    else
      xautolock -enable
    fi
    sleep 120
done
