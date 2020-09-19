#! /bin/sh

set -e

readonly DOTFILE_DIR="$HOME/.usr/dotfiles"

mkdir -p "$DOTFILE_DIR"
git clone "https://github.com/mblumtritt/dotfiles" "$DOTFILE_DIR"

"$DOTFILE_DIR/link-dot-files.sh"

if [ "$(uname -s)" = "Darwin" ]; then
	"$DOTFILE_DIR/init-homwbrew.sh"
	"$DOTFILE_DIR/init-macos.sh"
fi

"$DOTFILE_DIR/init-ruby.sh"
"$DOTFILE_DIR/link-bin-files.sh"
