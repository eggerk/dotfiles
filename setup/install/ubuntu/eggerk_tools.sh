#!/bin/sh -e

tmp_dir="$(mktemp -d)"

finish() {
  rm -rf "$tmp_dir"
}
trap finish EXIT

cd "$tmp_dir"

wget "https://github.com/eggerk/media_control/releases/download/v0.1.0/media_control_0.1.0_amd64.deb"
wget "https://github.com/eggerk/audio_tools/releases/download/v0.2.0/audio_tools_0.2.0_amd64.deb"
sudo apt-get -y install ./*.deb
