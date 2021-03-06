#! /usr/bin/env bash

readonly SOURCE_DIR="$HOME/.usr/dotfiles/files"
readonly BACKUP_DIR="$HOME/_backup/$(date +%s)"

function backup() {
	echo "backup $1 to $BACKUP_DIR"
	mkdir -p "$BACKUP_DIR"
	mv "$1" "$BACKUP_DIR"
}

function valid_file() {
	basename "$1" | grep -v '^.DS_Store$' > /dev/null 2>&1
}

for src_file in "$SOURCE_DIR"/*
do
	valid_file "$src_file" || continue
	dst_filename=".$(basename "$src_file")"
	dst_file="$HOME/$dst_filename"
	[[ "$(readlink "$dst_file")" = "$src_file" ]] && continue
	[[ -e "$dst_file" ]] && backup "$dst_file"
	echo "create link $dst_filename"
	ln -sf "$src_file" "$dst_file"
done
