---
date: 2024-12-03 12:00
authors: tom, mathijs
tags: Engineering, Screen Studio
title: Stretching audio by small amounts using Swift
description: Stretching an audio file to a certain length can be useful to fix lipsync issues. Our previous approach didn't work for stretching small durations over a large amount of time. We now have a new solution.
image: images/blog/throwback-sk-UbcwdASyUaQ-unsplash.jpeg
path: 2024/stretching-audio-by-small-amounts-using-swift
featured: true
---

**tldr; For small stretching over a long time, duplicate audio samples to get to the required length.**

## The problem

In [our earlier blog post](/blog/2023/stretching-an-audio-file-using-swift), we explained how to stretch an audio file in Swift to fix lipsync issues. The original method worked well for most cases, but it ran into trouble when the adjustment was very small—like stretching a 1-hour audio file by just 1 second. Both `AVMutableComposition` and `AVAudioUnitTimePitch` failed because the change was so tiny that they didn’t actually stretch the audio.

We needed a different approach for these cases. This new method works by duplicating small pieces of audio at calculated points. This may cause a tiny bit of distortion, but for small changes, it’s hardly noticeable.


## Duplicating Audio Samples

To duplicate audio samples, we use an AVAudioEngine in offline rendering mode. We compute how many frames we need to insert. At equally spaced intervals, we insert those extra frames by repeating part of the input.

For example; If we have a 1-hour audio file at 48.000 samples per second, and we want to stretch it by 1 second. We need to insert around 13 frames every second. If we space those out that means we need to repeat 1 frame, every 3600 frames.


## The code

First, we read the input file, and duration:
```swift
let sourceFile = try AVAudioFile(forReading: outputURL)
let inputFileLength = sourceFile.length
```

We then start the AVAudioEngine in offline rendering mode (as [shown in Apple's example code](https://developer.apple.com/documentation/avfaudio/audio_engine/performing_offline_audio_processing)).
```swift
let engine = AVAudioEngine()
let player = AVAudioPlayerNode()

engine.attach(player)
engine.connect(player, to: engine.mainMixerNode, format: format)
player.scheduleFile(sourceFile, at: nil)

try engine.enableManualRenderingMode(.offline, format: format, maximumFrameCount: 4096)
try engine.start()

player.play()
```

We create a buffer for the audio engine to render audio into:
```swift
let buffer = AVAudioPCMBuffer(pcmFormat: engine.manualRenderingFormat, frameCapacity: engine.manualRenderingMaximumFrameCount)!

let outputFile = try AVAudioFile(forWriting: outputURL, settings: sourceFile.fileFormat.settings)
let outputFileLength = AVAudioFramePosition(targetDuration.seconds * format.sampleRate)
```

And compute the number of extra frames that need to be added to the input length, to match the target output length:
```swift
let neededExtraFrames = outputFileLength - inputFileLength
```

We adjust how much frames we render each loop iteration. We don't just use the size of the buffer, but compute a step size that best matches the interval at which we need to insert extra frames.
```
let idealStride = inputFileLength / neededExtraFrames
let insertStride = AVAudioFrameCount(max(512, min(engine.manualRenderingMaximumFrameCount, AVAudioFrameCount(idealStride))))
```

Then we can start our render loop:
```swift
// Keep track of how much we have already inserted
var extraInserted: AVAudioFrameCount = 0

while engine.manualRenderingSampleTime < inputFileLength {
    let frameCount = inputFileLength - engine.manualRenderingSampleTime
    let framesToRender = min(AVAudioFrameCount(frameCount), insertStride)

    let status = try engine.renderOffline(framesToRender, to: buffer)
```

Once the source audio has been rendered to the buffer, we don't just write that out.
Instead, we compute our position in the output, and compute how many frames we need to duplicate.
```swift
let inputPosition = engine.manualRenderingSampleTime
let position = Double(inputPosition) / Double(inputFileLength)
let outputPosition = AVAudioFramePosition(Double(outputFileLength) * position)

let needed = AVAudioFrameCount(outputPosition - inputPosition)
let duplicateLength = AVAudioFrameCount(needed - extraInserted)
```

To duplicate a piece of audio from the buffer, we write it out twice, at different lengths.

First we reduce the length of the buffer to the extra frames needed, and write out the buffer.
Then we restore the length of the buffer, and write out the buffer again.
```swift
let orig = buffer.frameLength

// Write short prefix of buffer
buffer.frameLength = duplicateLength
try outputFile.write(from: buffer)

extraInserted += duplicateLength

// Write original buffer
buffer.frameLength = orig
try outputFile.write(from: buffer)
```

After all this, we have written out exactly the `outputFileLength` number for frames, by precisely duplicating the correct number of frames from the input as needed.

The above code is available [in a repository on GitHub](https://github.com/nonstrict-hq/AudioEngine-Stretch-Audio).


## Recap

By adding extra frames at regular intervals, the method stretches the audio without relying on playback rate adjustments. Even if the change is tiny, the method guarantees the desired output length.

The small amount of distortion caused by duplicating frames is practically impossible to hear for most small adjustments, like adding a single second in a 1-hour audio file.

This updated method solves the problem of stretching audio by very small amounts.


## References

- Nonstrict. (2024, November 27). AudioEngine Stretch Audio. GitHub. [https://github.com/nonstrict-hq/AudioEngine-Stretch-Audio](https://github.com/nonstrict-hq/AudioEngine-Stretch-Audio)
- Apple. (2024). [AVFAudio, Audio Engine.](https://developer.apple.com/documentation/avfaudio/audio_engine) Apple Developer Documentation.
- Apple. (2024). [Performing Offline Audio Processing](https://developer.apple.com/documentation/avfaudio/audio_engine/performing_offline_audio_processing). Apple Developer Documentation.
