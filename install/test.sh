#! /bin/sh -e

echo 'install: test if required tools are avail'

for cmd in basename readlink uname bash curl grep
do
  (>/dev/null 2>&1 command -v "$cmd") || {
    >&2 echo "install: command '$cmd' not found"
    exit 1
  }
done
