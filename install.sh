#! /bin/sh
echo 'install: dotfiles'
set -e

readonly _DOTFILE_DIR="$HOME/.local/dotfiles"

[ -f "$_DOTFILE_DIR/.git/config" ] || {
  mkdir -p "$_DOTFILE_DIR"
  git clone "https://github.com/mblumtritt/dotfiles" "$_DOTFILE_DIR"
}

. "$_DOTFILE_DIR/install/test.sh"
. "$_DOTFILE_DIR/install/homebrew.sh"
. "$_DOTFILE_DIR/install/symlink.sh"
. "$_DOTFILE_DIR/install/asdf.sh"
. "$_DOTFILE_DIR/install/ruby.sh"
. "$_DOTFILE_DIR/install/vscode.sh"
. "$_DOTFILE_DIR/install/macos-settings.sh"
. "$_DOTFILE_DIR/install/slides.sh"
