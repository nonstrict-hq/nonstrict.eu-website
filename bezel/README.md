# The Bezel website

## Install

Run `./setup-arm64.sh` (or the x64 variant if you're on Intel) to install Tailwind

## Development

Run tailwind locally with `./tailwindcss -i Styles/input.css -o Output/styles.css --watch` from the project folder.

Run the website locally with `./serve.sh` from the project folder, the website will be available at `http://localhost:8000`.

If you make changes you can just run the package either from Xcode with the run button or from the commandline with `swift run`. This will build a fresh version of the site that will be served by the above script.

To develop, open `Package.swift` with a recent version of Xcode, edit code and run
