#! /bin/sh -e

(command -v brew >/dev/null 2>&1) || {
  echo 'install: Homebrew'
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew analytics off
  brew tap homebrew/bundle
  brew bundle --global
}
