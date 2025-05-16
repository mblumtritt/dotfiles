#! /bin/sh -e

echo 'install: dotfiles'

readonly DOTFILE_DIR="$HOME/.local/dotfiles"

[ -f "$DOTFILE_DIR/.git/config" ] || {
  mkdir -p "$DOTFILE_DIR"
  git clone "https://github.com/mblumtritt/dotfiles" "$DOTFILE_DIR"
}

. "$DOTFILE_DIR/install/test.sh"
. "$DOTFILE_DIR/install/symlink.sh"
. "$DOTFILE_DIR/install/homebrew.sh"
. "$DOTFILE_DIR/install/asdf.sh"
. "$DOTFILE_DIR/install/ruby.sh"
# TODO . "$DOTFILE_DIR/install/vscode.sh"
# TODO . "$DOTFILE_DIR/install/macos-settings.sh"
. "$DOTFILE_DIR/install/slides.sh"
