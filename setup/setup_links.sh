#!/bin/bash -e

DOTFILES_PATH="/home/${USER}/dotfiles/config_files"
find "$DOTFILES_PATH" -print0 | while read -d $'\0' file
do
  if ! [ -f "$file" ] && ! [ -L "$file" ]; then
    continue
  fi
  target="${file#$DOTFILES_PATH}"
  mkdir -p "$(dirname "$target")"
  echo ln -sf "$file" "$target"
  ln -sf "$file" "$target"
done
