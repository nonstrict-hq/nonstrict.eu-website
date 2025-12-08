#!/bin/bash -e

# Check for Hugo
if ! command -v hugo &> /dev/null; then
    echo "Hugo not found. Installing via Homebrew..."
    if command -v brew &> /dev/null; then
        brew install hugo
    else
        echo "Error: Homebrew not found. Please install Hugo manually:"
        echo "  https://gohugo.io/installation/"
        exit 1
    fi
else
    echo "Hugo found: $(hugo version | head -c 50)..."
fi

# Download Tailwind CSS standalone CLI
TAILWIND_VERSION="v3.4.18"
echo "Downloading Tailwind CSS ${TAILWIND_VERSION}..."

if [[ $(arch) == 'arm64' ]]; then
    curl -sLO "https://github.com/tailwindlabs/tailwindcss/releases/download/${TAILWIND_VERSION}/tailwindcss-macos-arm64"
    mv tailwindcss-macos-arm64 tailwindcss
else
    curl -sLO "https://github.com/tailwindlabs/tailwindcss/releases/download/${TAILWIND_VERSION}/tailwindcss-macos-x64"
    mv tailwindcss-macos-x64 tailwindcss
fi
chmod +x tailwindcss

echo "Setup complete!"
