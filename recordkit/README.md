# RecordKit Docs Site

This repo hosts the RecordKit documentation site built with [VitePress](https://vitepress.dev), a Vite-powered static site generator. Creating a `README.md` here does **not** affect the published docs: VitePress only renders Markdown files referenced by the router (e.g. `index.md`, `try.md`, files under `guides/`). The README lives purely for local development guidance.

## Prerequisites

- Node.js 20.x (the project is pinned to 20.11.1 via Volta in `package.json`).
- npm 9+ (bundled with Node 20).

## Install Dependencies

```bash
npm install
# or
./setup.sh
```

## Run the Dev Server

```bash
npm run docs:dev
# or
./serve.sh
```

This starts VitePress' dev server (default: http://localhost:5173) with hot reloading.

## Build for Production

```bash
npm run docs:build
# or
./build.sh
```

The static site is emitted to `.vitepress/dist/`.

## Preview the Production Build

```bash
npm run docs:preview
```

This serves the prebuilt output so you can sanity-check the final site locally.

## Project Structure

- `index.md`, `try.md`, `features.md`, etc.: source Markdown pages.
- `guides/`: nested guide content.
- `public/`: assets copied verbatim to the output.
- `.vitepress/config.mts`: VitePress site + theme configuration, including navigation, sidebar, analytics, and icon plugin setup.
