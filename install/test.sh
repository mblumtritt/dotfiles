#! /bin/sh -e

echo 'install: test if required tools are avail'

for cmd in basename readlink uname bash curl grep
do
  (>/dev/null 2>&1 command -v "$cmd") || {
    echo "install: command '$cmd' not found" >&2
    exit 1
  }
done
