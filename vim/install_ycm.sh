#!/bin/bash

set -v

YCM_PATH="$1"
if [ -z $1 ] ; then
  YCM_PATH="/home/eggerk/.config/nvim/plugged/YouCompleteMe"
fi

if lsb_release -d | grep Manjaro > /dev/null ; then
  system_clang="--system-libclang"
fi
"$YCM_PATH/install.py" --clang-completer $system_clang
