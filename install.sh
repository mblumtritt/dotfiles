#! /bin/sh

set -ex
readonly DOTFILE_DIR="$HOME/.usr/dotfiles"
mkdir -p "$DOTFILE_DIR"
mkdir -p "$DOTFILE_DIR/../bin"
git clone "https://github.com/mblumtritt/dotfiles" "$DOTFILE_DIR"
pushd "$DOTFILE_DIR"
./link.sh
popd
