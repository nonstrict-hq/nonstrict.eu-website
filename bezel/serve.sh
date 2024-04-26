#!/bin/bash
[ ! -d "Output" ] && ./build.sh
SERVE_DIR=`mktemp -d`
ln -s "$(realpath Output)" $SERVE_DIR/bezel
python3 -m http.server --directory $SERVE_DIR 8000
rm -rf $SERVE_DIR
