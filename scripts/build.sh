#!/bin/sh
#
mydir=$(dirname "$0")
"$mydir/winrun" src/example.py --onefile --noupx
