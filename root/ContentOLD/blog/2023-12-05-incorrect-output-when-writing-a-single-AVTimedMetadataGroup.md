---
date: 2023-12-04 12:00
authors: mathijs, tom
tags: Engineering, Bezel
title: Incorrect output when writing a single AVTimedMetadataGroup
description: Timed metadata can be written to a track using AVAssetWriter. However if you append only one AVTimedMetadataGroup the results will be unexpected due to buggy behaviour.
image: images/blog/veri-ivanova-p3Pj7jOYvnM-unsplash.jpg
path: 2023/incorrect-output-when-writing-a-single-AVTimedMetadataGroup
featured: true
---

**tldr; Writing a single `AVTimedMetadataGroup` with a open time range gives unexpected results. Write another dummy `AVTimedMetadataGroup` after the source time you pass to `AVAssetWriter.endSession` as a workaround.**

When writing `AVTimedMetadataGroup` with a timerange that has its end time set to `.invalid` the timerange will be automatically adjusted by `AVAssetWriter`. This is very useful as at the time you append the metadata to the writer it's often unknown when the next bit of metadata will become available. This behaviour is explained in this WWDC talk from 2014: "Harnessing metadata in audiovisual media".

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=incorrect-output-when-writing-a-single-AVTimedMetadataGroup" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

## Our use case

We use this in our app [Bezel](https://getbezel.app) that can record your iPhone, it can however occur that we have a metadata group created before the recording started. We append this metadata group once the recording starts to have the initial state.

When the user doesn't do anything special with the device, no new metadata sample will be generated. So the single appended sample during the recording is expected to cover the whole timespan of the recording.

## The issue

If only a single `AVTimedMetadataGroup` is appended to the `AVAssetWriterInputMetadataAdaptor` the timerange isn't correctly adjusted. There are basically two different variants depending on the start of the timerange.

### Scenario 1
When the timerange start lays before the session start time given to the `AVAssetWriter`, the group won't be added to the file at all. The metadata track will end up empty!

```swift
assetWriter.startWriting()
assetWriter.startSession(atSourceTime: CMTime(seconds: 5, preferredTimescale: 1000))
metadataInputAdaptor.append(timedMetadataGroupAtOneSecond)
assetWriter.endSession(atSourceTime: CMTime(seconds: 15, preferredTimescale: 1000))
await assetWriter.finishWriting()
```

### Scenario 2
When the timerange start is between the session start and end time given to the `AVAssetWriter` the group is added to the file as expected. However the groups end time won't adjusted to the session end time, but is very close to the start time.

```swift
assetWriter.startWriting()
assetWriter.startSession(atSourceTime: CMTime(seconds: 5, preferredTimescale: 1000))
metadataInputAdaptor.append(timedMetadataGroupAtTenSeconds)
assetWriter.endSession(atSourceTime: CMTime(seconds: 15, preferredTimescale: 1000))
await assetWriter.finishWriting()
```

## Workaround

Once a second `AVTimedMetadataGroup` is appended to the `AVAssetWriterInputMetadataAdaptor` all end times are calculated correctly. That second groups start time may even be after the session end time that is passed to `AVAssetWriter`. That group won't be written to the file as it is out of range of the session, but it does trigger correct calculation of the other sample.

So a workaround is to, right before ending the `AVAssetWriter` session, append another `AVTimedMetadataGroup` containing dummy with a timerange that is after the given session end time. This will make the described issue disappear.

```swift
assetWriter.startWriting()
assetWriter.startSession(atSourceTime: CMTime(seconds: 5, preferredTimescale: 1000))
metadataInputAdaptor.append(timedMetadataGroupAtOneSecond)
metadataInputAdaptor.append(timedMetadataGroupAtOneMinute)
assetWriter.endSession(atSourceTime: CMTime(seconds: 15, preferredTimescale: 1000))
await assetWriter.finishWriting()
```

## Feedback Assistant & Sample project

This issue was submitted to Apple as FB13420918. We also created a [demonstration project for this issue on GitHub](https://github.com/nonstrict-hq/AppleFeedback/tree/main/FB13420918).

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=incorrect-output-when-writing-a-single-AVTimedMetadataGroup" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

- Nonstrict. (2023) [Bezel - Show your iPhone on your Mac.](https://getbezel.app) Bezel website.
- Apple. (2014, June 2-6). Session 505: Harnessing metadata in audiovisual media. WWDC14. ([Unofficial YouTube mirror](https://www.youtube.com/watch?v=ccz9kI8VQsw))
- Apple. (2014). [AVTimedAnnotationWriter.](https://developer.apple.com/library/archive/samplecode/AVTimedAnnotationWriter/Introduction/Intro.html#//apple_ref/doc/uid/TP40014496) Apple Developer Documentation Archive.
- Nonstrict. (2023, November 28). [AppleFeedback, FB13420918.](https://github.com/nonstrict-hq/AppleFeedback/tree/main/FB13420918) GitHub.
