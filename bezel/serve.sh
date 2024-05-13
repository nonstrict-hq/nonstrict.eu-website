#!/bin/bash

# Build the project if needed
[ ! -d "Output" ] && ./build.sh

# Enable us to be able to serve this directory under the path /bezel
SERVE_DIR=`mktemp -d`
ln -s "$(realpath Output)" $SERVE_DIR/bezel

# Start python HTTP server in background
python3 -m http.server --directory $SERVE_DIR 8000 &
PID1=$!
echo "Python server running with PID: $PID1"

# Start Tailwind CSS process in background
./tailwindcss -i Styles/input.css -o Output/styles.css --watch=always &
PID2=$!
echo "Tailwind running with PID: $PID2"

# Function to handle script termination
cleanup() {
    echo "Stopping all processes..."
    kill $PID1 $PID2
    rm -rf "$SERVE_DIR"
    echo "Cleanup complete and processes stopped."
}

# Trap SIGINT and exit signals
trap cleanup INT TERM

# Wait for both processes to finish
wait $PID1 $PID2
