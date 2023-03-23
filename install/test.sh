#! /bin/sh
echo 'install: test if required tools ara avail'
set -e

for cmd in basename readlink uname /bin/bash curl grep
do
  (>/dev/null 2>&1 command -v "$cmd") || {
    echo "install: command '$cmd' not found" >&2
    exit 1
  }
done
