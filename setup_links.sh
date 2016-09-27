#!/bin/sh

HOME_FOLDER=/home/$USER
FILE_PATH=$(dirname "$0")
CURRENT_DIR=$(pwd)
DOTFILES_PATH="$FILEPATH$CURRENT_DIR"

# zshrc
rm "$HOME_FOLDER/.zshrc" > /dev/null
ln -s "$DOTFILES_PATH/zshrc" "$HOME_FOLDER/.zshrc"

# vimrc
rm "$HOME_FOLDER/.vimrc" > /dev/null
ln -s "$DOTFILES_PATH/vimrc" "$HOME_FOLDER/.vimrc"

# tmux
rm "$HOME_FOLDER/.tmux.conf" > /dev/null
ln -s "$DOTFILES_PATH/tmux.conf" "$HOME_FOLDER/.tmux.conf"

# i3
mkdir -p "$HOME_FOLDER/.config/i3"
mkdir -p "$HOME_FOLDER/.config/i3status"
rm "$HOME_FOLDER/.config/i3/config" > /dev/null
ln -s "$DOTFILES_PATH/i3/config" "$HOME_FOLDER/.config/i3/config"
rm "$HOME_FOLDER/.config/i3status/config" > /dev/null
ln -s "$DOTFILES_PATH/i3/statusbar" "$HOME_FOLDER/.config/i3status/config"
