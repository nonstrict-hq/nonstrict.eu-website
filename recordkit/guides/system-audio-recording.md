# System Audio Recording

System audio recording lets you capture exactly what users hear, which is useful for apps like meeting recorders.

RecordKit supports two ways to record system audio: Core Audio and ScreenCaptureKit. By default, the most appropriate backend is sekected, which works well for most setups, but you can also explicitly choose the backend when needed.

## Record All System Audio

Recording all system audio is the simplest setup:

::: code-group
```swift [Swift]
let recorder = RKRecorder([
    .systemAudio()
])
try await recorder.start()
```

```ts [Electron]
const recorder = await recordkit.createRecorder({
  items: [
    {
      type: 'systemAudio'
    }
  ]
})
await recorder.start()
```
:::

## Choose a Backend

### Default (Recommended)

- OS support: all macOS versions supported by RecordKit (macOS 13+)
- Best fit: maximum compatibility with automatic fallback

This setting will use Core Audio on macOS 14.2+ and ScreenCaptureKit on older macOS versions.

::: code-group
```swift [Swift]
let recorder = RKRecorder([
    .systemAudio(backend: .default) // You can also omit the backend to use default
])
```

```ts [Electron]
// Omit backend to use RecordKit's default backend selection
const recorder = await recordkit.createRecorder({
  items: [
    {
      type: 'systemAudio'
    }
  ]
})
```
:::

### Core Audio

Core Audio has a friendlier flow where the user can grant system audio recording permissions with one click. This also ensures the user the app can't also capture the screen. It is supported on macOS 14.2+.

::: code-group
```swift [Swift]
let recorder = RKRecorder([
    .systemAudio(backend: .coreAudio)
])
```

```ts [Electron]
const recorder = await recordkit.createRecorder({
  items: [
    {
      type: 'systemAudio',
      backend: 'coreAudio'
    }
  ]
})
```
:::

::: tip
If your app already has been granted screen recording permission, then no additional permission is needed for system audio recording.
:::

### ScreenCaptureKit

ScreenCaptureKit is available from macOS 12.3+. It needs full screen recording permissions, those need to be granted manually by the user through the Settings app.

::: code-group
```swift [Swift]
let recorder = RKRecorder([
    .systemAudio(backend: .screenCaptureKit)
])
```

```ts [Electron]
const recorder = await recordkit.createRecorder({
  items: [
    {
      type: 'systemAudio',
      mode: 'exclude',
      backend: 'screenCaptureKit',
      excludeOptions: ['currentProcess']
    }
  ]
})
```
:::

::: tip
Apps that do both screen and system audio only recordings can consider using the ScreenCaptureKit backend to make sure the audio capturing behaviour is always consistent.
:::

## Permissions

Permissions differ by backend:

- Core Audio backend: requires system audio capture permission.
- ScreenCaptureKit backend: requires Screen Recording permission.

Use backend-aware permission helpers so your app checks and requests the correct permission path.

::: code-group
```swift [Swift]
let backend: RKRecorder.SystemAudioBackend = .default

if !RKAuthorization.systemAudioRecording(backend: backend) {
    RKAuthorization.requestSystemAudioRecording(backend: backend)
}
```

```ts [Electron]
const backend = 'default' // 'default' | '_beta_coreAudio' | 'screenCaptureKit'

if (!(await recordkit.getSystemAudioRecordingAccess({ backend }))) {
  await recordkit.requestSystemAudioRecordingAccess({ backend })
}
```
:::

## Recording Modes

### Record Everything

Use `systemAudio()` to record all system audio.

::: code-group
```swift [Swift]
let recorder = RKRecorder([
    .systemAudio()
])
```

```ts [Electron]
const recorder = await recordkit.createRecorder({
  items: [
    {
      type: 'systemAudio',
      mode: 'exclude',
      excludeOptions: ['currentProcess']
    }
  ]
})
```
:::

### Excluding Specific Apps

Use exclude mode to remove apps you do not want in the mix, for example Apple Music or Spotify.

::: code-group
```swift [Swift]
let apps = RKRunningApplication.applications()
let excluded = apps
    .filter { $0.bundleIdentifier == "com.apple.Music" || $0.bundleIdentifier == "com.spotify.client" }
    .map(\.id)

var options: Set<RKRecorder.SystemAudioExcludeOptions> = [.currentProcess]
options.formUnion(excluded.map { .processID($0) })

let recorder = RKRecorder([
    .systemAudio(excluding: options)
])
```

```ts [Electron]
const apps = await recordkit.getRunningApplications()
const excludedProcessIDs = apps
  .filter((app) => app.bundle_identifier === 'com.apple.Music' || app.bundle_identifier === 'com.spotify.client')
  .map((app) => app.id)

const recorder = await recordkit.createRecorder({
  items: [
    {
      type: 'systemAudio',
      mode: 'exclude',
      excludeOptions: ['currentProcess'],
      excludedProcessIDs
    }
  ]
})
```
:::

### Record Specific Apps

Use include mode when you want audio from selected apps only, for example Zoom.

::: code-group
```swift [Swift]
let apps = RKRunningApplication.applications()
let zoomIDs = apps
    .filter { $0.bundleIdentifier == "us.zoom.xos" }
    .map(\.id)

let recorder = RKRecorder([
    .systemAudio(includedApplicationIDs: zoomIDs)
])
```

```ts [Electron]
const apps = await recordkit.getRunningApplications()
const zoomIDs = apps
  .filter((app) => app.bundle_identifier === 'us.zoom.xos')
  .map((app) => app.id)

const recorder = await recordkit.createRecorder({
  items: [
    {
      type: 'systemAudio',
      mode: 'include',
      includedApplicationIDs: zoomIDs
    }
  ]
})
```
:::

::: tip
Some apps output audio from background processes. For supported browsers such as Safari and Chrome, RecordKit handles this process routing automatically.
:::
