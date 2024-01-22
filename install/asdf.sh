#! /bin/sh -e

(command -v asdf >/dev/null 2>&1) && {
  echo 'install: ASDF packages'

  while read -r line
  do
    set -- "$line"
    asdf plugin list | grep "$1" >/dev/null 2>&1 || {
      echo "install: $1 v$2"
      asdf plugin add "$1"
      asdf install "$1" "$2"
    }
  done < "$HOME/.tool-versions"
  asdf reshim
}
