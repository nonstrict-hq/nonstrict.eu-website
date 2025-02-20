---
date: 2025-02-20 12:00
authors: tom, mathijs
tags: Engineering, RecordKit
title: Distorted Audio when recording external microphones using AVCaptureSession
description: In certain situations, when recording audio on macOS using AVCaptureSession and AVAssetWriter, the resulting audio file can sound distorted. This issue is caused by AVCaptureSession reporting CMSampleBuffers of different audio formats.
image: images/blog/matt-botsford-OKLqGsCT8qs-unsplash.jpg
path: 2025/distorted-audio-avcapturesession
featured: true
---

When working on [RecordKit](https://nonstrict.eu/recordkit/), our macOS recording SDK, we ran into an issue where in certain situations the recorded audio files would sound distorted. Digging into this issue, we found we could reproduce this by using an external microphone (not the MacBook Built-in Microphone), and it only happens on the second recording (not the first one).

![Screenshot comparing waveforms of normal audio and distored audio](/images/blog/distorted-audio-waveform.png)

Playing the recorded audio, we hear distorted sound, but we can also see the recording going wrong when looking at the Xcode console:

![Screenshot of Xcode log filled with warnings](/images/blog/xcode-log-audioconverter-warning.png)

This repeating of the log `Input data proc returned inconsistent 512 packets for 2048 bytes; at 3 bytes per packet, that is actually 682 packets` gives us a good hint as to what is happening.


## Our setup

In our simplified setup, we use an AVCaptureSession with a single AVCaptureDeviceInput for the microphone, and a single AVCaptureAudioDataOutput. The AVCaptureAudioDataOutput has a delegate, in it's `captureOutput(_:didOutput:from:)` function, we write to an audio file using AVAssetWriter.

```swift
func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    assetWriterInput.append(sampleBuffer)
}
```

Importantly (not shown here), we create our AVAssetWriter and start its writing session before starting the AVCaptureSession. That means the very first CMSampleBuffer that gets delivered to our callback, will also be written to the AVAssetWriter.

## What goes wrong

It turns out, in our delegate function we receive CMSampleBuffers in different audio formats. We first receive a 24 bit sample, and after that only 32 bit samples. This causes the AudioConvert to output noise.

We can see this by logging the AudioStreamBasicDescription (ASDB) from the format description of the CMSampleBuffer, we see two different audio formats come by.

```swift
print(sampleBuffer.formatDescription!.audioStreamBasicDescription!)
```

The first ASBD matches the microphone active format:
`AudioStreamBasicDescription(mSampleRate: 48000.0, mFormatID: 1819304813, mFormatFlags: 12, mBytesPerPacket: 3, mFramesPerPacket: 1, mBytesPerFrame: 3, mChannelsPerFrame: 1, mBitsPerChannel: 24, mReserved: 0)`

Second and later ASBDs are of a different format:
`AudioStreamBasicDescription(mSampleRate: 48000.0, mFormatID: 1819304813, mFormatFlags: 41, mBytesPerPacket: 4, mFramesPerPacket: 1, mBytesPerFrame: 4, mChannelsPerFrame: 1, mBitsPerChannel: 32, mReserved: 0)`

This is the source of the problem.

An AVAssetWriterInput can be created by providing a `sourceFormatHint`, but that is optional, and we didn't set it. This means the AVAssetWriter will use the first CMSampleBuffer it gets to configure itself. In the case of our distorted recordings, the first sample it gets is a 24 bit sample, so the AudioConverter gets configured for 24 bit samples, which means it can't deal with all the 32 bit samples it gets afterwards.

## Workaround

We should only provide only a single format of audio samples to the AVAssetWriter to not have the problem of distored audio.

We could explicitly set the sourceFormatHint to the 32 bit format description, but that means we still get a conversion error from AudioConverter for the very first sample.

Instead we can drop the first couple samples we get, so the asset writer never sees the 24 bit sample.

In RecordKit we have a separate "preparing" phase from the actual "recording" phase, so we take this last approach. During the preparing phase we wait for all sample buffers in our ring buffer to be of the same format, before actually starting to record.

## Recap

For some reason on macOS, we sometimes get samples in different audio formats. We didn't expect this, so the first version of our code couldn't deal with this. This issue was also previously discussed on the [Apple Developer Forums](https://developer.apple.com/forums/thread/765449)

We have replicated this problem on macOS 14.6, macOS 15.2 and macOS 15.3.

We have reported this issue FB16500782, and have created [a sample project](https://github.com/nonstrict-hq/AppleFeedback/tree/main/FB16500782) that demonstrates the problem.


## References

- Nonstrict. (2025, February). [FB16500782: AVCaptureSession Wrong Format](https://github.com/nonstrict-hq/AppleFeedback/tree/main/FB16500782). GitHub.
- WWDC Index. (2014). [Harnessing Metadata in Audiovisual Media @28:48](https://nonstrict.eu/wwdcindex/wwdc2014/505/?t=1728). WWDC 2014.
- Apple. (2025, February). [AVAssetWriterInput sourceFormatHint](https://developer.apple.com/documentation/avfoundation/avassetwriterinput/init(mediatype:outputsettings:sourceformathint:)) Apple Developer Documentation.
- Apple. (2024, November). [Distorted Audio When Recording External Mics With AVCaptureSession and AVAssetWriter](https://developer.apple.com/forums/thread/765449). Apple Developer Forums.
