#! /bin/sh -e

_GEM=$(asdf which gem)
readonly _GEM

(command -v "$_GEM" >/dev/null 2>&1) && {
  echo 'install: Ruby basic gems'
  ruby --version
  $_GEM update --no-document --system
  $_GEM install --no-document bundler rake pry rubocop syntax_tree tcp-client host-os natty-ui curb
  $_GEM update --no-document
}
