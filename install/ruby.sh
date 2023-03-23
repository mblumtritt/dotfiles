#! /bin/sh
set -e
(command -v gem >/dev/null 2>&1) && {
  echo 'install: Ruby basic gems'
  gem update --system --no-document
  gem update --no-document
  gem install bundler rake pry rubocop prettier
}
