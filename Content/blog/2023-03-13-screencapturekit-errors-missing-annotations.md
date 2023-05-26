---
date: 2023-03-13 12:00
authors: tom, mathijs
tags: Engineering
title: Mentioning SCStreamError crashes on older macOS versions
description: A public service annoucement for those using ScreenCaptureKit in an app that also needs to run on macOS < 12.3 (Monterey).
path: 2023/mentioning-scstreamerror-crashes-on-older-macos-versions
image: images/blog/dyld-no-screencapturekit.png
featured: true
hideImageHero: true
---

The SCStreamError type and related error codes don't have `@availability` annotations. That means if you use them in your code, your app will crash on older macOS versions, because it can't find ScreenCaptureKit.

Even using these types from within an `@available` scope won't work, as a workaround you can hardcode the error domain and codes raw values.

## Demonstrating the issue

If you have an app that uses these types, it will work as expected on macOS 12.3+, but will crash on previous macOS versions.

Because the SCStreamError type isn't annotated with a proper availability annotations by Apple, older macOS versions also try to load ScreenCaptureKit.
This results in the following error when you try to run an app that refers to any SCStreamError, even when you guard it with an `@available` annotation.

```
dyld: Library not loaded: /System/Library/Frameworks/ScreenCaptureKit.framework/Versions/A/ScreenCaptureKit
  Referenced from: /Users/alice/Downloads/Archive/./SCStreamError-sample-bad
  Reason: image not found
Abort trap: 6
```

![Screenshot showing the "Library not loaded" error](/images/blog/dyld-no-screencapturekit.png)
<figcaption>On Big Sur, an executable referencing SCStreamError will crash</figcaption>

## Workaround

Don't directy reference the `SCStreamError` or `SCStreamError.Code` types from code. Instead, use their raw values.
By not mentioning these types directly, the framework won't be loaded.

For example, instead of:

```swift
// Don't write this:
do {
    try await stream.stop()
} catch let error as SCStreamError where error.code == .attemptToStopStreamState {
    // ...
}
```

Use raw values:
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
