---
date: 2023-03-13 12:00
authors: tom
tags: Engineering
title: ScreenCapureKit errors missing annotations
description: Don't reference SCStreamError from your code if you target older macOS versions.
path: 2023/screencapturekit-errors-missing-annotations
---

A public service annoucement for those using ScreenCaptureKit in an app that also needs to run on macOS < 12.3.

The SCStreamError type and related error codes don't have `@availability` annotations. That means if you use them in your code, your app will crash on older macOS versions, because it can't find ScreenCaptureKit.

Even using these types from within an `@available` scope won't work, instead hardcode the error domain and codes.

## Demonstrating the issue

If you have an app that uses these types, it will work as expected on macOS 12.3+, but will crash on macOS versions from before, that don't ship with ScreenCaptureKit. The error reports that `ScreenCaptureKit.framework` can't be loaded:

```
dyld: Library not loaded: /System/Library/Frameworks/ScreenCaptureKit.framework/Versions/A/ScreenCaptureKit
  Referenced from: /Users/alice/Downloads/Archive/./SCStreamError-sample-bad
  Reason: image not found
Abort trap: 6
```

![Screenshot showing the "Library not loaded" error](/images/blog/dyld-no-screencapturekit.png)
<figcaption>On Big Sur, an executable referencing SCError will crash</figcaption>

## Workaround

Don't directy reference the `SCStreamError` or `SCStreamError.Code` types from code. Instead, use their raw values.

For example, instead of:

```swift
// Don't write this:
do {
    try await stream.stop()
} catch let error as SCStreamError where error.code == .attemptToStopStreamState {
    // ...
}
```

Instead use raw values:
```swift
// Write this instead:
let streamErrorDomain = "com.apple.ScreenCaptureKit.SCStreamErrorDomain"
let attemptToStopCode = -3808
do {
    try await stream.stop()
} catch let error as NSError where error.domain == streamErrorDomain && error.code == attemptToStopCode {
    // ...
}
```

## Feedback Assistant

This issue was submitted to Apple as FB12052574, a demonstration project can be found on our GitHub: [https://github.com/nonstrict-hq/scstreamerror-sample](https://github.com/nonstrict-hq/scstreamerror-sample).
