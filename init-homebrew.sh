#! /bin/sh

set -e

command -v brew >/dev/null 2>&1 || {
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew tap homebrew/bundle
	brew bundle --global
}
