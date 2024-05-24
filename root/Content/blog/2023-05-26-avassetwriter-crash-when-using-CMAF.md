---
date: 2023-05-26 12:00
authors: mathijs, tom
tags: Engineering
title: AVAssetWriter crash creating CMAF compliant segments
description: Using AVAssetWriter to create CMAF compliant segments in realtime is unstable on Intel macs when the frame rate is dynamic. You either need to switch away from CMAF, disable expectsMediaDataInRealTime or ensure a stable frame rate.
image: images/blog/graydon-driver-ggZiK8G2WLY-unsplash.jpg
path: 2023/avassetwriter-crash-when-using-CMAF
featured: true
---

Since macOS 11 and iOS 14 `AVAssetWriter` is able to write CMAF compliant segments. The Common Media Application Format (CMAF) is a standard used in streaming video and audio, it describes how to encode and split media content for streaming. It’s a format that can be delivered over both Apple HLS and MPEG DASH without having to re-encode the content.

Often media is converted into segments ahead of time, but generating segments in realtime can also be useful. For example to streaming upload a recording to a server or to directly make an unfinished stream available for consumers in a replayable way.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=avassetwriter-crash-when-using-CMAF" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror your iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone and it automatically shows up on your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div>

## It crashes on Intel

When we created CMAF compliant fMP4 segments using AVAssetWriter from a screen recording we noticed it crashed consistently after a few seconds for a select group of users. They all had the following error:

```
Error Domain=AVFoundationErrorDomain Code=-11800 "The operation could not be completed" UserInfo={NSLocalizedFailureReason=An unknown error occurred (-16364), NSLocalizedDescription=The operation could not be completed, NSUnderlyingError=0x6000007293b0 {Error Domain=NSOSStatusErrorDomain Code=-16364 "(null)"}}
```

We first incorrectly assumed this error was related to presentation time stamps being out of order in the CMSampleBuffers that were added. After some investigations it turned out this error occurs when the following four conditions are all met:

1. The application must run on an Intel mac, Apple Silicon macs are not affected.
2. `AVAssetWriter.outputFileTypeProfile` set to `.mpeg4CMAFCompliant`
3. The `AVAssetWriterInput` added to the writer must have `expectsMediaDataInRealTime` set to `true`.
4. CMSampleBuffers must be appended to the input either:
  - At a variable rate, for example because the source only generates samples when something changes (like ScreenCaptureKit does) or there is a discontinuity in samples from the capture device.
  - Frames are delivered significantly faster than 60 FPS, for example on ProMotion screens.

We’ve verified this issue on macOS 12 Monterey and 13 Ventura, it doesn’t seem to affect macOS 11 Big Sur.

## Workaround

Breaking any of the above 4 conditions will prevent the crash. The most feasible workarounds probably are:

- Switch away from CMAF, if you’re using it for streaming upload there is a good chance your server can also handle Apple HLS. We went with this workaround to avoid this issue all together.
- If you must use CMAF, an alternative is to keep the frame rate stable at 60 FPS or lower if the source you’re recording supports this.
- If you can’t switch away from CMAF and have an unstable or high FPS input you can’t adjust, you could disable `expectsMediaDataInRealTime`. That seems to also work as long as the `AVAssetWriter` is keeping up with the frame rate, even if you do write media data in real time.

## Feedback Assistant & Sample project

This issue was submitted to Apple as FB12057159. We also created a [demonstration project for this issue on GitHub](https://github.com/nonstrict-hq/realtime-cmaf-crash-sample).

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=avassetwriter-crash-when-using-CMAF" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror your iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone and it automatically shows up on your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div>

## References

- Nonstrict. (2023, March 13). Realtime CMAF crash sample. GitHub. [https://github.com/nonstrict-hq/realtime-cmaf-crash-sample](https://github.com/nonstrict-hq/realtime-cmaf-crash-sample)
