# Getting Started on Electron

This guide will walk you through the steps to integreate RecordKit into your Electron app. By the end you will be able to make a screen recording.

::: details Starting from scratch?
To bootstrap an Electron project using [Electron Forge](https://www.electronforge.io) run:

```sh
npm init electron-app@latest my-app -- --template=vite-typescript
```

When finished go into the directory of your new project and continue this Getting Started guide.
:::

## 1. Adding RecordKit

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
```TypeScript{6} [forge.config.ts (Electron Forge)]
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

```JSON{5} [package.json (Electron Builder)]
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

## 2. Initialize RecordKit

Now that RecordKit is available to use in your Electron app you need to initialize it before using any of the APIs. The most convenient way to initialize is on the Electron `ready` event:

```TypeScript
import { recordkit } from '@nonstrict/recordkit';

app.on('ready', async () => {
  await recordkit.initialize({
    rpcBinaryPath: path.join(process.resourcesPath, 'recordkit-rpc'),
    fallbackToNodeModules: !app.isPackaged,
  })
})
```

## 3. Start a recording

1. Discover the devices, windows or displays to record.

```TypeScript
const windows = await recordkit.getWindows()
const cameras = await recordkit.getCameras()
const microphones = await recordkit.getMicrophones()
const appleDevices = await recordkit.getAppleDevices()
```

2. Configure & start a recorder

```TypeScript
// Configure the recorder
const recorder = await recordkit.createRecorder({
  output_directory: path.join(app.getPath('videos'), 'my-app', new Date().toISOString()), 
  items: [
    { type: 'windowBasedCrop', window: windows[0] },
    { type: 'webcam', camera: cameras[0], microphone: microphones[0] },
    { type: 'iPhonePortrait', device: appleDevices[0] }
  ]
})

// Calling prepare is highly recommended, this activates all devices and makes sure a call to start will start the recording instantly.
// (Screen recording & camera indicators will be visible to the user after calling prepare, also permission alerts might be triggered.)
await recorder.prepare();

// Actually start recording
await recorder.start()
```

3. Finish the recording

```TypeScript
// Stop the recording, returns information about the recording
const result = await recorder.stop()
```
