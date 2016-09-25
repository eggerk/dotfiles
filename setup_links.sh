#!/bin/sh

HOME_FOLDER=/home/$USER
FILE_PATH=$(dirname "$0")
CURRENT_DIR=$(pwd)
DOTFILES_PATH="$FILEPATH$CURRENT_DIR"

# zshrc
rm "$HOME_FOLDER/.zshrc"
ln -s "$DOTFILES_PATH/zshrc" "$HOME_FOLDER/.zshrc"

# vimrc
rm "$HOME_FOLDER/.vimrc"
ln -s "$DOTFILES_PATH/vimrc" "$HOME_FOLDER/.vimrc"

# tmux
rm "$HOME_FOLDER/.tmux.conf"
ln -s "$DOTFILES_PATH/tmux.conf" "$HOME_FOLDER/.tmux.conf"
