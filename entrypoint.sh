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

	Recommended options:

	Docker CLI:
	  cache_path=/wine/drive_c/users/root/AppData/Local/pip/cache
	  -v "\$(pwd)/cache":\$cache_path \
	
	_EOF_
  exit
fi

zero_args=false
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
--)
  zero_args=true
  ;;
esac

# Install requirements (if they exist)
if [ -f requirements.txt ]; then
    pip install -U -r requirements.txt
fi

# Build with pyinstaller
if $zero_args ; then
  ( set -x ; pyinstaller "$@" )
else
  ( set -x ; pyinstaller --clean -y --dist ./dist --specpath ./dist --workpath /tmp --upx-dir "C:\\" "$@" )
fi
chown -R --reference=. ./dist
