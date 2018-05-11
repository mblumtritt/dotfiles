#! /bin/sh

set -e

readonly DOTFILE_DIR="$HOME/.usr/dotfiles"

"$DOTFILE_DIR/link.sh"
brew update
brew bundle --global
brew upgrade
gem update
brew cleanup
gem cleanup
