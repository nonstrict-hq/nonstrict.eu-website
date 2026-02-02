---
date: 2023-01-29 12:00
authors: tom, mathijs
tags: Engineering, Screen Studio
title: Recording to disk using AVCaptureScreenInput
description: On older macOS versions, ScreenCaptureKit isn't available. We created an example project demonstrating screen recording using the older AVCaptureScreenInput.
image: images/blog/clay-banks-zH9kK6wNC20-unsplash.jpg
path: 2023/recording-to-disk-with-avcapturescreeninput
featured: true
---

> Note: On macOS 12.3 it is recommended to use ScreenRecordingKit instead, this is more efficient and provides more features. Check out our post “[Recording to disk using ScreenCaptureKit](/blog/2023/recording-to-disk-with-screencapturekit)”

**tldr; Create an AVCaptureSession, connect the AVCaptureScreenInput and a AVCaptureMovieFileOutput.**

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=recording-to-disk-with-avcapturescreeninput" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror any iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone or wirelessly mirror it to your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div>

## Recording to a file

In our recent project to build a new recording backend for [Screen Studio](https://screenstudio.lemonsqueezy.com?aff=nXV1B), we needed to create a screen recording on macOS and write the output to a file on disk. For newer macOS versions, we use ScreenCaptureKit, but that has only been available since macOS 12.3, and we also wanted to support 10.15 Catalina.

Fortunately for us, while it’s quite a bit of work to write a file from a ScreenCaptureKit recording, using the older APIs, it’s not a lot of code.

## Using AVCaptureSession

We start by creating an AVCaptureSession, and adding an AVCaptureScreenInput as input and adding a AVCaptureMovieFileOuput as output:

```swift
let captureSession = AVCaptureSession()
let videoInput = AVCaptureScreenInput(displayID: displayID)!
captureSession.addInput(videoInput)

let output = AVCaptureMovieFileOutput()
captureSession.addOutput(output)

captureSession.startRunning()
```

We can then start the recording by calling `startRecording(to:recordingDelegate:)` on AVCaptureMovieFileOutput. Note that this can throw an NSException if there’s an issue. You can’t directly catch this exception from Swift, you’ll need an Objective-C wrapper. Using a library like [ExceptionCatcher](https://github.com/sindresorhus/ExceptionCatcher) from Sindre Sorhus makes this convenient to do from Swift.

```swift
output.startRecording(to: url, recordingDelegate: delegate)
```

To stop the recording, call the `stopRecording()` on AVCaptureMovieFileOutput, make sure to wait for the callback in `RecordingDelegate.fileOutput(_:didFinishRecordingTo:from:error:)` to really know the recording is finished:

```swift
func stop() async throws {
    try await withCheckedThrowingContinuation { continuation in
        delegate.finishedContinuation = continuation
        output.stopRecording()
    }
    delegate.finishedContinuation = nil // Don't leak continuation

    captureSession.stopRunning()
}

private class RecordingDelegate: NSObject, AVCaptureFileOutputRecordingDelegate {
    var finishedContinuation: CheckedContinuation<Void, Error>?

    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error {
            finishedContinuation?.resume(throwing: error)
        } else {
            finishedContinuation?.resume()
        }
    }
}
```

## Detailed Example

On GitHub we have [a repository](https://github.com/nonstrict-hq/AVCaptureScreenInput-Recording-example) with the full example in a SPM package.

To run this, clone the repo and run:

```swift
swift run avcrecording
```

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=recording-to-disk-with-avcapturescreeninput" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror any iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone or wirelessly mirror it to your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div>

## References

- Nonstrict. (2023, January 24). AVCaptureScreenInput Recording Example. GitHub. [https://github.com/nonstrict-hq/AVCaptureScreenInput-Recording-example](https://github.com/nonstrict-hq/AVCaptureScreenInput-Recording-example)
- Sindre Sorhus. (2022, September 22). ExceptionCatcher. GitHub.  [https://github.com/sindresorhus/ExceptionCatcher](https://github.com/sindresorhus/ExceptionCatcher)
