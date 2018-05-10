#! /bin/sh

set -ex
gem install bundler
rbenv rehash
gem install rake pry terminal-notifier
