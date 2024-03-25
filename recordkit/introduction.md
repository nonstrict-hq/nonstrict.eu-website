# What is RecordKit?

RecordKit is a screen recording SDK for macOS apps. Enabling simultaneous recording of the users screen, system audio, camera, microphone, mouse and keyboard. RecordKit is the recording foundation of apps. Generating easy to use video and JSON to build upon.

::: tip 
Just want to try it out? Skip to the [Product Demo](/product-demo).
:::

## Use Cases

- **Video Messaging & Product Demo apps**

RecordKit is a solid foundation for video messaging apps (like Loom) and apps to create product demos (like ScreenFlow). Our SDK helps you focus on the added value of your app, the powerful recording APIs let you easily integrate all recording features users expect from a modern app.

- **Support, monitoring or QA recordings**

With just a few lines of code you can add a recording feature to create a support, monitoring or QA feature to your app. A short recording of a problem or action of the users often tells you more than text. With RecordKit building such features becomes simple and easy, we take care of the heavy lifting.

## User Experience

- **Native performance**

RecordKit fully leverages native Apple APIs like ScreenCaptureKit, AVFoundation and CoreMedia to perform high quality and high performance recordings. Even in Electron apps we completely skip the browser and directly call out to macOS, removing all browser limitations.

- **Enhanced statusses and errors**

The SDK adds detailed statusses and errors to many situations. Whether ScreenCaptureKit fails to start or microphone is silent because the MacBook lid is closed, RecordKit will report a clear status or error that you can present in the user interface.

## Developer Experience

RecordKit provides a great Developer Experience (DX) when integrating in a Swift or Electron based app.

- **Modern API:** A modern SPM package with first class SwiftUI and Swift concurrency support. First class support for Electron apps including complete TypeScript definitions.

- **Simple output:** RecordKit outputs all assets in easy to process MP4 videos and JSON files by default. Making it easy to process them further using your own pipeline.

- **Native power:** RecordKit applies countless of best-practices and workarounds that we have collected over the years on top of native Apple APIs such as ScreenCaptureKit, AVFoundation and CoreMedia.

- **Flexible with sane defaults:** Providing sane defaults gives you a quick start, making it easy to experiment and integrate RecordKit. The API is also flexible and gives you a great deal of control to create a great User Experience (UX) and integrate into existing setups.
