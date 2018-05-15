#! /bin/sh

set -e

readonly DOTFILE_DIR="$HOME/.usr/dotfiles"

"$DOTFILE_DIR/link-dot-files.sh"
"$DOTFILE_DIR/link-bin-files.sh"
system-update
