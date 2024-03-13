#!/bin/bash -x

if [[ $(arch) == 'arm64' ]]; then
    curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-arm64
    mv tailwindcss-macos-arm64 tailwindcss
else
    curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-x64
    mv tailwindcss-macos-x64 tailwindcss
fi
chmod +x tailwindcss
