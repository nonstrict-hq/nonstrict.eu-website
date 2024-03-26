#!/bin/bash -e
[ ! -d "Output" ] && swift run
python3 -m http.server --directory Output 8000
