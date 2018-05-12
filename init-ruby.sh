#! /bin/sh

set -e

gem install bundler
command -v rbenv >/dev/null 2>&1 && { rbenv rehash; }
gem install rake pry
