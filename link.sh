#! /usr/bin/env bash

readonly DOT_SOURCE_DIR="$HOME/.usr/dotfiles/files"
readonly BACKUP_DIR="$HOME/_backup/$(date +%s)"

function backup() {
	echo "backup $1 to $BACKUP_DIR"
	mkdir -p "$BACKUP_DIR"
	mv "$1" "$BACKUP_DIR"
}

function is_dotfile() {
	basename "$1" | grep -v '^.DS_Store$\|^_darwin$\|^_linux$' > /dev/null 2>&1
}

for src_file in "$DOT_SOURCE_DIR"/*
do
	is_dotfile "$src_file" || continue
	dst_filename=".$(basename "$src_file")"
	dst_file="$HOME/$dst_filename"
	if [ "$(readlink "$dst_file")" != "$src_file" ]
	then
		test -e "$dst_file" && backup "$dst_file"
		echo "create link $dst_filename"
		ln -sf "$src_file" "$dst_file"
	fi
done
