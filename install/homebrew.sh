#! /bin/sh -e

(command -v brew >/dev/null 2>&1) || {
  echo 'install: Homebrew'
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

echo 'configure: Homebrew'
brew analytics off

echo 'install: Tools'
brew bundle --global
