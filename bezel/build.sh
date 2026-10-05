#!/bin/bash -x -e
./presskit-zips.sh
./tailwindcss -i assets/css/input.css -o assets/css/styles.css -m
hugo --minify -d Output
