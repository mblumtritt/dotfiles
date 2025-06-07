#! /bin/sh -e

echo 'install: create symlinks'

readonly DOT_FILES="$HOME/.local/dotfiles"

_BACKUP_DIR="$HOME/.local/bak/$(date +%s)"
readonly _BACKUP_DIR

backup() {
  echo "   backup '$1' to '$_BACKUP_DIR'"
  mkdir -p "$_BACKUP_DIR"
	mv "$1" "$_BACKUP_DIR"
}

valid_file() {
	basename "$1" | grep -v '^.DS_Store$' >/dev/null 2>&1
}

link_files() {
  _source_dir="$1"
  _target_dir="$2"
  _prefix="$3"

  mkdir -p "$_target_dir"
  for src_file in "$_source_dir"/*
  do
    valid_file "$src_file" || continue
    dst_file="$_target_dir/$_prefix$(basename "$src_file")"
    [ "$(readlink "$dst_file")" = "$src_file" ] && continue
    [ -e "$dst_file" ] && backup "$dst_file"
    echo "   link '$dst_file'"
    ln -sf "$src_file" "$dst_file"
  done
}

# init
ln -sf "$DOT_FILES/init" "$HOME/.local"
ln -sf "$DOT_FILES/init/zshenv" "$HOME/.zshenv"
ln -sf "$DOT_FILES/init/zprofile" "$HOME/.zprofile"
ln -sf "$DOT_FILES/init/zshrc" "$HOME/.zshrc"

# dot files
link_files "$DOT_FILES/files" "$HOME" "."
ln -sf "$DOT_FILES/assets" "$HOME/.local"

# vscode settings
link_files "$DOT_FILES/other/vscode" "$HOME/Library/Application Support/Code/User"

# docker settings
link_files "$DOT_FILES/other/docker" "$HOME/.docker"

# gnupg
link_files "$DOT_FILES/other/gnupg" "$HOME/.gnupg"


