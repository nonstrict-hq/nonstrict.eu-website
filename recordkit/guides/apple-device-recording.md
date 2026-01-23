# Apple Device Recording

RecordKit can record iPhone and iPad screens via a wired USB connection. Unlike other recording solutions, RecordKit provides first-class support for device rotation—when the user rotates their device during recording, the video seamlessly captures this with accompanying metadata that enables smooth animated rotation transitions during playback.

## Device Discovery

Discover connected Apple devices using the discovery API. Each device reports its availability state, which you can use to guide users through connection issues.

::: code-group
```swift [Swift]
let devices = await RKAppleDevice.appleDevices

for device in devices {
    print("\(device.localizedName): \(device.availability)")
}
```

```ts [Electron]
const devices = await recordkit.getAppleDevices()

for (const device of devices) {
    console.log(`${device.name}: ${device.availability}`)
}
```
:::

### Availability States

| State | Meaning | User Action |
|-------|---------|-------------|
| `available` | Ready to record | None needed |
| `notConnected` | Not plugged in | Connect via USB cable |
| `notPaired` | Connected but not trusted | Tap "Trust" on the device |
| `pairedNeedsReconnect` | Trusted, reconnect needed | Unplug and reconnect the cable |
| `pairedNeedsConnect` | Connection not working | Reconnect the cable |

## Recording

Add an Apple device to your recording schema using the `.appleDevice()` schema item:

::: code-group
```swift [Swift]
let recorder = RKRecorder([
    .appleDevice(deviceID: device.id)
])

try await recorder.prepare()
try await recorder.start()
// ... recording ...
let result = try await recorder.stop()
```

```ts [Electron]
const recorder = await recordkit.createRecorder({
    items: [
        { type: 'appleDevice', device: device }
    ]
})

await recorder.prepare()
await recorder.start()
// ... recording ...
const result = await recorder.stop()
```
:::

## Rotation Metadata

When the device rotates during recording, RecordKit writes the rotated video frames to the video file and records each rotation change in a companion metadata file. This enables players to animate rotation transitions during playback.

<video src="/recordkit/playerview-device-rotate.mp4" autoplay loop muted playsinline></video>

### Output Files

For each Apple device recording, RecordKit produces:

| File | Description |
|------|-------------|
| `{name}.mov` | Video file with rotated content |
| `{name}.dimension-changes.json` | Rotation change metadata |

### Dimension Changes Format

The `.dimension-changes.json` file contains an array of rotation events:

```json
[
  {
    "time": { "seconds": 0.0, "value": 0, "timescale": 1000 },
    "dimensions": { "width": 1179.0, "height": 2556.0 },
    "rotation": 0,
    "animated": false
  },
  {
    "time": { "seconds": 3.25, "value": 3250, "timescale": 1000 },
    "dimensions": { "width": 1179.0, "height": 2556.0 },
    "rotation": 90,
    "animated": true
  }
]
```

Each entry contains:

| Field | Description |
|-------|-------------|
| `time` | Time when the rotation happens |
| `dimensions` | The original screen dimensions |
| `rotation` | Degrees to rotate for correct display: `0`, `90`, `180`, or `-90` |
| `animated` | `true` if the player should animate the transition, `false` for instant change |

### Implementing Playback

To display rotation correctly:

1. **Parse the metadata file** alongside the video
2. **Track playback time** against the `since` timestamps
3. **Apply rotation transforms** as each timestamp is reached
4. **Animate transitions** when `animated` is `true`, or apply instantly when `false`

The `animated` flag is `false` at recording start and after pause/resume (instant orientation), and `true` when the device physically rotated during continuous recording.

::: tip Rotation Values
Positive rotation values (90) are clockwise, negative values (-90) are counterclockwise. The video frames are stored rotated to fit the container, so applying the `rotation` value displays the content upright.
:::
