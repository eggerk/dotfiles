#!/bin/sh

EXEC1="/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
EXEC2="/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1"
if [ -f $EXEC1 ] ; then
  $EXEC1
elif [ -f $EXEC2 ] ; then
  $EXEC2
fi
