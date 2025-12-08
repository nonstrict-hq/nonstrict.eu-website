#!/bin/bash -x -e
./tailwindcss -i assets/css/input.css -o static/styles.css -m
hugo --minify -d Output
