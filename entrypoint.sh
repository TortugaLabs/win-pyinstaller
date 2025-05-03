#!/bin/bash

# Fail on errors.
set -e

# Move to /src
cd /src

if [ $# -eq 0 ] ; then
  python -V
  pyinstaller --version

  cat <<-_EOF_
	Options:

	cmd|CMD : Run Windows CMD interpreter
	bash|sh : Run UNIX shell
	help : Show pyinstaller help

	Otherwise, provide pyinstaller options
	_EOF_
  exit
fi

case "$1" in
cmd|CMD)
  shift
  wine cmd.exe "$@"
  exit $?
  ;;
bash|sh)
  shell="$1"
  shift
  [ "$#" -eq 0 ] && set - -il
  exec "$shell" "$@"
  exit $?
  ;;
help)
  pyinstaller -h
  exit $?
  ;;
esac

# Install requirements (if they exist)
if [ -f requirements.txt ]; then
    pip install -U -r requirements.txt
fi

# Build with pyinstaller
( set -x
  pyinstaller --clean -y --dist ./dist --specpath ./dist --workpath /tmp --upx-dir "C:\\" "$@"
)
chown -R --reference=. ./dist
