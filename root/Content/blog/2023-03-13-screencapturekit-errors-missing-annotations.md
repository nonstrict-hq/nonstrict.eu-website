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

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=mentioning-scstreamerror-crashes-on-older-macos-versions" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror any iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone and it automatically shows up on your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div>

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

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=mentioning-scstreamerror-crashes-on-older-macos-versions" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror any iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone and it automatically shows up on your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div>
