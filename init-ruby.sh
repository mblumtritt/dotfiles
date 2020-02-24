#! /bin/sh

set -e

gem install bundler rake pry
command -v rbenv >/dev/null 2>&1 && { rbenv rehash; }
