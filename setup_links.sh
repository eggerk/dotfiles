#!/bin/sh

HOME_FOLDER=/home/$USER
FILE_PATH=$(dirname "$0")
CURRENT_DIR=$(pwd)
DOTFILES_PATH="$FILEPATH$CURRENT_DIR"

# zshrc
ln -sf "$DOTFILES_PATH/zsh/zshrc" "$HOME_FOLDER/.zshrc"

# vimrc
ln -sf "$DOTFILES_PATH/vim/vimrc" "$HOME_FOLDER/.vimrc"

# tmux
ln -sf "$DOTFILES_PATH/tmux/tmux.conf" "$HOME_FOLDER/.tmux.conf"
ln -sf "$DOTFILES_PATH/tmux/tmux" "$HOME_FOLDER/.tmux"

# i3
mkdir -p "$HOME_FOLDER/.config/i3"
mkdir -p "$HOME_FOLDER/.config/i3status"
ln -sf "$DOTFILES_PATH/i3/config" "$HOME_FOLDER/.config/i3/config"
ln -sf "$DOTFILES_PATH/i3/statusbar" "$HOME_FOLDER/.config/i3status/config"
ln -sf "$DOTFILES_PATH/i3/i3blocks.conf" "$HOME_FOLDER/.i3blocks.conf"

# xbindkeys
ln -sf "$DOTFILES_PATH/xbindkeysrc" "$HOME_FOLDER/.xbindkeysrc"

# xsessionrc
ln -sf "$DOTFILES_PATH/xsessionrc" "$HOME_FOLDER/.xsessionrc"
