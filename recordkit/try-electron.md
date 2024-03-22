# Getting Started on Electron

## Integrate into an Electron Project

This guide will walk you through the steps to integreate RecordKit into your Electron app. By the end you will be able to make a screen recording.

### 1. Adding RecordKit

1. RecordKit for Electron is installed as a NPM package. Add the `@nonstrict/recordkit` as a dependency to the `package.json` of your Electron app.

::: code-group
```sh [npm]
npm install @nonstrict/recordkit
```

```sh [yarn]
yarn add @nonstrict/recordkit
```
:::

2. Make sure the RecordKit binary assets are picked up by the packager you use.

::: code-group
```typescript{6} [forge.config.ts (Electron Forge)]
import type { ForgeConfig } from '@electron-forge/shared-types';

const config: ForgeConfig = {
  packagerConfig: {
    asar: true,
    extraResource: ['node_modules/@nonstrict/recordkit/bin/recordkit-rpc'] // Add this line to forge.config.ts
  },
  rebuildConfig: {},
  makers: [new MakerSquirrel({}), new MakerZIP({}, ['darwin']), new MakerRpm({}), new MakerDeb({})],
  plugins: [
    // ...
  ],
};

export default config;
```

```json{5} [package.json (Electron Builder)]
{
  "name": "my-electron-app",
  "productName": "my-electron-app",
  "version": "1.0.0",
  "build": { "extraResources": "node_modules/@nonstrict/recordkit/bin/recordkit-rpc" }, // Add this line to package.json
  "devDependencies": {
    // ...
  },
  "dependencies": {
    "@nonstrict/recordkit": "*",
    // ...
  }
}
```
:::

### 2. Make a Recording

🚧 Sorry, this page is still under construction.
