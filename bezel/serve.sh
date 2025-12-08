#!/bin/bash -e

# Build Tailwind CSS in watch mode in background
./tailwindcss -i assets/css/input.css -o static/styles.css --watch &
TAILWIND_PID=$!

# Start Hugo dev server
hugo server --buildDrafts --port 8000

# Clean up Tailwind when Hugo exits
kill $TAILWIND_PID 2>/dev/null
