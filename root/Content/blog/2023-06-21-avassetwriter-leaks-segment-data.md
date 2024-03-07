---
date: 2023-06-21 12:00
authors: mathijs, tom
tags: Engineering
title: AVAssetWriter leaking memory when segment data is used in Swift
description: Segment data delivered to AVAssetWriterDelegate is leaked when the delegate is implemented in Swift. You either need to implement the delegate in Objective-C or deallocate the data yourself. This issue is fixed by Apple in macOS 13.3.
image: images/blog/harry-grout-BxiBbWR7rA-unsplash.jpg
path: 2023/avassetwriter-leaks-segment-data
featured: true
---

Since macOS 11 and iOS 14 `AVAssetWriter` is able to deliver segments of audio and video data during decoding. These can either be Apple HLS or Common Media Application Format (CMAF) compliant segments. Allowing you to down- or upload a live stream of an video, you get the encoded segments as `Data` objects that you can send over the network or write to a file.

## Data is leaked in Swift

When you implement the `AVAssetWriterDelegate` in Swift to handle the data segments, the whole segment is leaked. It’s memory never gets released and your apps memory usage keeps increasing. This adds up quite fast, we’ve seen 600MB+ memory usage for a 3 minute recording in real life scenarios.

It seems the `Data` object provided by `AVAssetWriter` to its delegate isn't a real `Data` object but just acts like it. When the given object is being used in combination with Objective-C to Swift bridging it is leaked, probably because bridging assumes things about `Data` that this custom object doesn't confirm to. 

This means passing the data in our own code from Objective-C to a Swift function will also make the segment data leak. So we need to keep the given `Data` in Objective-C at all times if we want to avoid it from leaking.

## Affected versions

The leak is present since the introduction of segment writing in macOS 11 Big Sur. We’ve verified the leak on macOS 11.7.2, 12.6.5, 13.2.1. We’ve also confirmed that Apple has fixed this leak in macOS 13.3 and newer. AVAssetWriter on iOS versions is probably also affected, but we haven't validated the leak and fix on different iOS versions.

## Workaround

To work around this issue there are basically two options:

1. Implement the `AVAssetWriterDelegate` in Objective-C, this way we avoid bridging to Swift. If you need to pass the data to Swift code you can wrap the `NSData` in an Objective-C object and forward methods you need to the data object in Objective-C.
2. If you’re can’t or won’t use Objective-C you can also deallocate the memory yourself, with something like: `segmentData.withUnsafeBytes { $0.baseAddress?.deallocate() }` This seems a bit riskier, as it could result in a crash easily when implementation details change, but it might be a handy shortcut in some cases.

We’ve used the Objective-C implementation successfully in production, since we only needed to write the data to disk it was quite trivial to implement a wrapper. This felt like the most robust solution that won’t start crashing with OS updates, it was also the recommended approach by Apple Developer Technical Support.

A sample project demonstrating this issue and the workarounds is [available on GitHub](https://github.com/nonstrict-hq/avassetwriter-segment-leak-sample).

## References

- Nonstrict. (2023, June 21). AVAssetWriter segment leak sample. GitHub. [https://github.com/nonstrict-hq/avassetwriter-segment-leak-sample](https://github.com/nonstrict-hq/avassetwriter-segment-leak-sample)
- de Kort, J. (2022, December 16). *Memory leak when using AVCaptureSession to AVAssetWriter using AVAssetWriterDelegate for HLS.* StackOverflow. [https://stackoverflow.com/questions/74825652/memory-leak-when-using-avcapturesession-to-avassetwriter-using-avassetwriterdele](https://stackoverflow.com/questions/74825652/memory-leak-when-using-avcapturesession-to-avassetwriter-using-avassetwriterdele)
