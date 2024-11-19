# Output formats

RecordKit can record towards different file formats, either a single file (mov/mp4/m4a) or a segmented (HLS) stream.

## Single file

### mov/m4a

Recording to a regular mov file is the default in RecordKit. In the case only audio is present a m4a file will be created. RecordKit will use the H.264 and AAC codecs to compress the video and audio content by default.

### mp4

The mp4 container is also supported by providing an explicit filename with the mp4 extension. Like the below example.

::: code-group
```swift [Swift]
RKRecorder([
    .display(displayID: selectedDisplay, filename: "display.mp4")
])
```

```ts [Electron]
await recordkit.createRecorder({
  items: [
    { type: 'display', display: selectedDisplay, filename: "display.mp4" }
  ]
})
```
:::

## Segmented stream (HLS)

When uploading files to a backend it might be beneficial to write out the audio and video in smaller segments that can be uploaded while the recording is still running. RecordKit can output an segmented media stream also known as HLS/fMP4.

Enable this by setting the output parameter to `segmented`, optionaly passing a callback that will be called with every segment that is written out to disk. Like the below example.

::: code-group
```swift [Swift]
RKRecorder([
    .display(displayID: selectedDisplay, output: .segmented(segmentCallback: { url in
        print("A new segment is written to \(url)")
    }))
])
```

```ts [Electron]
await recordkit.createRecorder({
  items: [
    { type: 'display', display: selectedDisplay, output: 'segmented', segmentCallback: (path) => { console.log('A new segment is written to', path) } },
  ]
})
```
:::

An m3u8 playlist file will also be created that refers to all fragments that can be used for playback.

## Other formats

If you require output in other formats please [drop us an email](mailto:team+recordkit@nonstrict.com)! We're happy to see if we can expand support to your requested format.
