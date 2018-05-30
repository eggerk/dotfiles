#!/usr/bin/sh

sudo pacman -R \
	dunst \
	nano \
	palemoon-bin \
	vim

sudo pacman -S --noconfirm \
	blueman bluez bluez-libs bluez-utils \
	clementine \
	feh \
	firefox \
	gcc cmake \
	git \
	neovim \
	gimp \
	inkscape \
	playerctl \
  pulseaudio-alsa pulseaudio-bluetooth \
	python2-pip python-pip \
	redshift python-xdg \
	rofi \
	the_silver_searcher \
	tmux \
	thunderbird \
	udiskie \
	xautomation \
	xbindkeys \
	xfce4-notifyd \
	yaourt \
	zsh

# Setup neovim.
sudo pip2 install --upgrade neovim
sudo pip3 install --upgrade neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Setup zsh.
chsh -s $(which zsh)
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
