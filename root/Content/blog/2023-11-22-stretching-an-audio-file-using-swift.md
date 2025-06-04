---
date: 2023-11-23 12:00
authors: mathijs, tom
tags: Engineering, Screen Studio
title: Stretching an audio file using Swift
description: Stretching an audio file to a certain length can be useful to fix lipsync issues. It isn't immediatly obvious how to do this using Swift. Here is a simple way to do it.
image: images/blog/kelly-sikkema-X-etICbUKec-unsplash.jpg
path: 2023/stretching-an-audio-file-using-swift
featured: true
---

**[Update November 2024] The approach described below doesn't work in when stretching very long audio by small amounts. See our [follow-up post](/blog/2024/stretching-audio-by-small-amounts-using-swift) a more solid solution.**

_tldr; Add your audio file to an AVMutableComposition and use its scaleTimeRange method to stretch the audio to the desired duration._

## Our use case

Recently we encountered faulty microphone hardware that doesn't provide enough audio samples during recording. This results in an audio file that is slightly shorter than the simulatiously recorded video file. When the audio and video are played back together the audio drifts slowly out of sync because of this. 

Since every sample of audio that is delivered from the microphone misses a tiny bit of audio it's possible to stretch out the file without audible distortion. This brings the audio back in sync with the other recorded sources.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=stretching-an-audio-file-using-swift" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

## Using ffmpeg

To validate stretching indeed worked correctly. We first tried to fix a corrupt audio file by using the following `ffmpeg` command:

```bash
ffmpeg -i input.m4a -filter:a "atempo=0.9998691805" -vn output.m4a
```

The `atempo` parameter is the audio tempo that will be applied to the output file. The above example slows down the audio slightly. You can calculate the tempo parameter using the following formula: `atempo = target duration / current duration`

This made the audio align perfectly with the video. To be able to correct this automatically I wanted to have a solution written in Swift that we can embed in our application.

## Stretching audio in Swift

Apple platforms provide a comprehensive set of audio frameworks and technologies. This is very powerful, but it wasn't immediatly clear to me which audiovisual framework can stretch an audio file quickly and easily.

After some research it turned out that `AVMutableComposition` is an easy to implement API that can be used to export audio at a different tempo. In combination with an `AVAssetExportSession` it can convert the audio file at a high speed in quite a compact method: 

```swift
import Foundation
import AVFoundation

func scaleAudio(inputURL: URL, toDuration targetDuration: CMTime, outputURL: URL) async throws {
    // Load info from the input audio file
    let inputAudioAsset = AVAsset(url: inputURL)
    let inputAudioDuration = await inputAudioAsset.load(.duration)
    let inputAudioTimeRange = CMTimeRange(start: .zero, duration: inputAudioDuration)
    let inputAudioTracks = await inputAudioAsset.loadTracks(withMediaType: .audio)
    guard let inputAudioTrack = inputAudioTracks.first else {
        fatalError("No audio track in input file.")
    }

    // Create a composition with the current audio added to it on a track
    let composition = AVMutableComposition()
    guard let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid) else {
        fatalError("Failed to add mutable audio track.")
    }
    try audioTrack.insertTimeRange(inputAudioTimeRange, of: inputAudioTrack, at: .zero)
    
    // Scale the whole composition to the target duration, this stretches the audio
    composition.scaleTimeRange(inputAudioTimeRange, toDuration: targetDuration)

    // Setup an export session that will write the composition to the given ouput URL
    let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)
    exportSession?.outputURL = outputURL
    exportSession?.outputFileType = .m4a

    // Do the actual export and check for completion
    await exportSession?.export()
    guard exportSession?.status == .completed else {
        fatalError("Export failed, check `exportSession.error` for details.")
    }
}
```

## Alternatives considered

It also is possible to adjust the speed of audio with `AVAudioUnitVarispeed` that you attach to `AVAudioEngine`. This works great for realtime playback scenarios, but it's really not designed to convert "as fast as possible" and write to a file. For our use case converting real time was too slow, but `AVAudioEngine` might be a great choice if you want to play back the resulting audio immediatly. 

It seems to be possible to do faster conversion using lower level audio APIs like `AudioUnitRenderer`, but that results in much more complex code than the above approach. This approach might be of interest when you want to mix audio from different sources and apply more complex effects. 

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=stretching-an-audio-file-using-swift" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

## References

- ffmpeg. (2023). [Audio Filters, atempo.](http://ffmpeg.org/ffmpeg-all.html#atempo) ffmpeg Documentation
- Apple. (2023). [AVFoundation, Composite assets.](https://developer.apple.com/documentation/avfoundation/composite_assets) Apple Developer Documentation.
- Apple. (2023). [AVFAudio, Audio Engine.](https://developer.apple.com/documentation/avfaudio/audio_engine) Apple Developer Documentation.
- Vlad. (2015, June 6). [Can I use AVAudioEngine to read from a file, process with an audio unit and write to a file, faster than real-time?](https://stackoverflow.com/a/30680391/586489) Stack Overflow.
- Apple. (2023). [Audio Unit, Component Services, AudioUnitRenderer.](https://developer.apple.com/documentation/audiotoolbox/1438430-audiounitrender) Apple Developer Documentation.
