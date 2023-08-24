#! /bin/sh

set -e

_GEM=$(asdf which gem)
readonly _GEM

(command -v "$_GEM" >/dev/null 2>&1) && {
  echo 'install: Ruby basic gems'
  $_GEM update --system --no-document
  $_GEM update --no-document
  $_GEM install bundler rake pry rubocop prettier
}
