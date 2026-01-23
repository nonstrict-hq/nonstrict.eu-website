#!/bin/bash
cleanup() {
    echo "Stopping servers..."
    kill $HUGO_PID $TW_PID 2>/dev/null
}
trap cleanup INT TERM

# Get local IP for network access
LOCAL_IP=$(ipconfig getifaddr en0 2>/dev/null || echo "localhost")
echo "Starting Hugo server..."
echo "Local access: http://localhost:8000"
echo "Network access: http://$LOCAL_IP:8000"

hugo server --buildDrafts --destination Output --port 8000 --bind 0.0.0.0 &
HUGO_PID=$!

./tailwindcss -i assets/css/input.css -o Output/styles.css --watch &
TW_PID=$!

wait $HUGO_PID $TW_PID
