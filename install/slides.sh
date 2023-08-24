#! /bin/sh

set -e

(command -v pandoc >/dev/null 2>&1) && {
  echo 'install: pandoc reveal slides'

  readonly _REV_DIR="$HOME/.local/share/pandoc/reveal"

  if [ -d "$_REV_DIR/dist" ] || [ -d "$_REV_DIR/plugin" ]
  then
    echo 'already installed'
    exit 0
  fi

  mkdir -p "$_REV_DIR"
  curl -sLo "$_REV_DIR/latest.zip" https://github.com/hakimel/reveal.js/archive/master.zip
  unzip -o "$_REV_DIR/latest.zip" -d "$_REV_DIR" >/dev/null
  mv "$_REV_DIR/reveal.js-master/dist" "$_REV_DIR/dist"
  mv "$_REV_DIR/reveal.js-master/plugin" "$_REV_DIR/plugin"
  rm "$_REV_DIR/latest.zip"
  rm -rf "$_REV_DIR/reveal.js-master"
}
