#!/bin/sh

set -e

tmpdir=$(mktemp -d)
cleanup() {
  rm -rf "$tmpdir"
}
trap cleanup EXIT
curl -fLo "$tmpdir/fonts.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/UbuntuMono.zip
unzip "$tmpdir/fonts.zip" -d "$tmpdir"
mv "$tmpdir/"*ttf ~/.local/share/fonts
