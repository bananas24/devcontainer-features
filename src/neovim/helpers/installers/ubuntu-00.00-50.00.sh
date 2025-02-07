#!/bin/bash

set -eux

TEMP_DIR="$(mktemp -d)"
cd "$TEMP_DIR"

apt update
apt install -y wget

wget "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.tar.gz"
tar xf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz

# move the executable
mv --force nvim-linux-x86_64/bin/nvim /usr/local/bin

# --symbolic & --force flags does not exist in alpine & busybox
ln -s -f /usr/local/bin/nvim /usr/bin

# copy share files
cp --recursive --update --verbose nvim-linux-x86_64/share/* /usr/local/share
rm -rf nvim-linux-x86_64/share

# copy libs
cp --recursive --update --verbose nvim-linux-x86_64/lib/* /usr/local/lib
rm -rf nvim-linux-x86_64/lib

# copy man pages
if [ -d nvim-linux-x86_64/man ]; then
  cp --recursive --update --verbose nvim-linux-x86_64/man/* /usr/local/man
  rm -rf nvim-linux-x86_64/man
fi
