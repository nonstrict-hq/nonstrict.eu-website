# Features

RecordKit provides a complete set of recording capabilities for macOS apps. Each feature works standalone or combined with others in a single recording session.

## Permissions

macOS requires user authorization for recording. RecordKit provides consistent APIs to check and request permissions for Screen Recording, Camera, Microphone, and Input Monitoring.

::: code-group
```swift [Swift]
struct ContentView: View {
    @RKAuthorizationStatus(.camera) var camera

    var body: some View {
        if camera {
            Text("Camera authorized.")
        } else {
            Button("Enable camera") {
                $camera.requestCameraAccess()
            }
        }
    }
}
```

```ts [Electron]
const status = await recordkit.permissions.camera.status()
if (status !== 'authorized') {
    await recordkit.permissions.camera.request()
}
```
:::

## Discovery

Users have multiple displays, windows, cameras and microphones. RecordKit provides APIs to discover and list all available recording sources.

::: code-group
```swift [Swift]
struct ContentView: View {
    @RKSources(.microphones) var microphones

    var body: some View {
        Text("There are \(microphones.count) microphones")
    }
}
```

```ts [Electron]
const displays = await recordkit.sources.displays()
const cameras = await recordkit.sources.cameras()
const microphones = await recordkit.sources.microphones()
```
:::

## Pause & Resume

Pause and resume recordings while keeping hardware active. This allows users to skip unwanted sections without starting a new recording.

::: code-group
```swift [Swift]
try await recorder.pause()
// ... user skips a section
try await recorder.resume()
```

```ts [Electron]
await recorder.pause()
// ... user skips a section
await recorder.resume()
```
:::

## Screen Recording

Record displays, windows and system audio using Apple's ScreenCaptureKit. Supports multiple displays simultaneously.

::: code-group
```swift [Swift]
let recorder = RKRecorder([
    .display(displayID: display.id)
])
```

```ts [Electron]
const recorder = await recordkit.createRecorder({
    items: [
        { type: 'display', display: display }
    ]
})
```
:::

You can also record a specific window instead of a full display.

::: code-group
```swift [Swift]
let recorder = RKRecorder([
    .desktopIndependentWindow(windowID: window.id)
])
```

```ts [Electron]
const recorder = await recordkit.createRecorder({
    items: [
        { type: 'window', window: window }
    ]
})
```
:::

## Camera & Microphone

Record camera and microphone into synchronized video files. RecordKit keeps all streams in sync, including with screen recordings.

::: code-group
```swift [Swift]
let recorder = RKRecorder([
    .webcam(microphoneID: microphone.id, cameraID: camera.id)
])
```

```ts [Electron]
const recorder = await recordkit.createRecorder({
    items: [
        { type: 'camera', camera: camera, microphone: microphone }
    ]
})
```
:::

For audio-only recordings, you can record just the microphone.

::: code-group
```swift [Swift]
let recorder = RKRecorder([
    .microphone(microphoneID: microphone.id)
])
```

```ts [Electron]
const recorder = await recordkit.createRecorder({
    items: [
        { type: 'microphone', microphone: microphone }
    ]
})
```
:::

## Keyboard & Mouse

Record keyboard and mouse input to show key overlays or visualize clicks and cursor movement. Output as JSON for flexible rendering.

::: code-group
```swift [Swift]
let recorder = RKRecorder([
    .display(displayID: display.id, mouseEvents: true, keyboardEvents: true)
])
```

```ts [Electron]
const recorder = await recordkit.createRecorder({
    items: [
        { type: 'display', display: display, mouseEvents: true, keyboardEvents: true }
    ]
})
```
:::

::: tip Input Monitoring Permission
Keyboard and mouse recording requires the Input Monitoring permission, which users must grant in System Settings.
:::

## iPhone & iPad

Record the screen of iPhones and iPads connected via USB cable. These devices appear in the discovery APIs alongside other sources.

::: code-group
```swift [Swift]
let devices = await RKAppleDevice.appleDevices
let recorder = RKRecorder([
    .appleDeviceStaticOrientation(deviceID: device.id)
])
```

```ts [Electron]
const devices = await recordkit.sources.iosDevices()
const recorder = await recordkit.createRecorder({
    items: [
        { type: 'iosDevice', device: device }
    ]
})
```
:::

::: warning Cable Required
iOS device recording requires a USB connection. Wireless recording is not supported.
:::
