#!/bin/bash -e
# Download Tailwind CSS binary if not present
if [ -f "tailwindcss" ]; then
    echo "Tailwind CSS binary already exists"
    exit 0
fi

ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/download/v3.4.17/tailwindcss-macos-arm64
    mv tailwindcss-macos-arm64 tailwindcss
else
    curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/download/v3.4.17/tailwindcss-macos-x64
    mv tailwindcss-macos-x64 tailwindcss
fi
chmod +x tailwindcss
echo "Tailwind CSS binary downloaded"
