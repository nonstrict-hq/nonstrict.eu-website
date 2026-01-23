#!/bin/bash -e
echo "Building Hugo site..."
hugo --minify --destination Output

echo "Building Tailwind CSS..."
./tailwindcss -i assets/css/input.css -o Output/styles.css --minify

echo "Creating feed.rss from feed.xml..."
cp Output/feed.xml Output/feed.rss

echo "Build complete!"
