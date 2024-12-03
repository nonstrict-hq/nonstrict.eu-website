---
date: 2024-11-23 12:00
authors: mathijs, tom
tags: Engineering, RecordKit
title: Handling audio capture gaps on macOS
description: Audio capture on macOS can sometimes contain gaps. This article explains how to detect and handle these gaps to maintain proper audio/video sync when recording to files.
image: images/blog/victoria-shes-IUk1S6n2s0o-unsplash.jpg
path: 2024/handling-audio-capture-gaps-on-macos
featured: true
---

**tldr; Missing audio samples during recording can cause audio/video desynchronization. Detect gaps using presentation timestamps and fill them with silent audio samples to maintain proper sync.**

Audio capture presents unique challenges due to its real-time, continuous nature. While macOS provides robust APIs for capturing and recording audio to files, certain scenarios can lead to gaps in the audio stream, causing synchronization issues with simulaniously recorded video.

## Understanding the Problem

When capturing audio on macOS, the system occasionally fails to deliver a continuous stream of samples to applications. This issue seems to manifest, among other scenarios, during audio device switches, such as connecting AirPods mid-recording. While Core Audio logs errors to the console, the recording continues - but with potentially missing samples.

The issue has been observed with both `AVCaptureSession` and `AVAudioEngine` based capture implementations, suggesting the problem exists at a lower level in the Core Audio stack rather than being specific to a particular capture API.

For real-time playback, these gaps result in momentary audio glitches. However, when recording to a file, the consequences are more severe. The missing samples cause the audio track to become shorter than other recorded media, leading to desynchronization with video tracks.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

## Detection and Solution

The key to addressing this issue lies in monitoring the presentation timestamps of incoming `CMSampleBuffer` objects. Audio devices generate samples at a fixed rate, which serves as a clock for generating presentation times and calculating sample durations. The sample timings should form a continuous sequence.

This can be used to implement a method that fills the gaps in the audio sequence:

```swift
var nextExpectedAudioTime: CMTime?
func processSampleBuffer(_ sampleBuffer: CMSampleBuffer) {
    // TODO: Probably wise to check if the sample buffer times are all valid

    // Ensure to always set the next expected time
    defer { nextExpectedAudioTime = sampleBuffer.presentationTimeStamp + sampleBuffer.duration }

    guard let nextExpectedAudioTime else {
        // Handle first sample
        writeToFile(sampleBuffer)
        return
    }

    let delta = sampleBuffer.presentationTimeStamp - nextExpectedAudioTime
    if delta > .zero {
        let silentAudio = generateSilentAudio(duration: delta)
        writeToFile(sampleBuffer)
    }

    writeToFile(sampleBuffer)
}
```

When a gap is detected, generating and inserting silent audio samples maintains the proper timing relationship between audio and other recorded media. While this approach still results in a brief audio dropout, it prevents the more problematic issue of audio/video desynchronization throughout the remainder of the recording.

## Note on Reliability

This issue doesn't affect all users equally. It's been observed across different harware setups and macOS versions, with most reports coming from macOS 14. It is particularly noticeable for us during testing when switching the audio output device. 

This seems to be an issue inside Core Audio that we hope will be resolved over time. However, this workaround of inserting silent audio at least maintains proper audio/video sync. It has been successfully used in [RecordKit](https://recordkit.dev/), our SDK for macOS recording applications for some time in production now.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

- Apple. (2024). [Setting Up a Capture Session](https://developer.apple.com/documentation/avfoundation/setting-up-a-capture-session). Apple Developer Documentation.
- Apple. (2024). [AVCaptureSession](https://developer.apple.com/documentation/avfoundation/avcapturesession). Apple Developer Documentation.
- Apple. (2024). [AVAudioEngine](https://developer.apple.com/documentation/avfaudio/avaudioengine). Apple Developer Documentation.
