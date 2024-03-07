---
date: 2023-11-28 12:00
authors: mathijs, tom
tags: Engineering, Bezel
title: Working with custom metadata in mp4 files
description: It is very useful, but also quite a pain to work with custom metadata in mp4 files with AVFoundation. Let's bridge the undocumented gaps and get it to work.
image: images/blog/stephen-holdaway-a77_vSc1SS4-unsplash.jpg
path: 2023/working-with-custom-metadata-in-mp4-files
featured: true
---

**tldr; Write custom metadata to mp4 files using the `.isoUserData` key space with 4 character keys and set the value as `NSData`, convert back both the key and value when reading.**

## Our use case

For our app [Bezel](https://getbezel.app) custom metadata is written into the recorded mp4 file. Information like the the make & model of the recorded device and some version information is there to later on be able to convert it into an interesting looking video. Adding this extra information directly into the file is pretty convenient as it can't get lost or get mixed up.

However once we tried to write out metadata to the mp4 file the data often just didn't show up at all. No errors where reported, it just wasn't there. Turned out writing custom metadata to a mp4 container is much more restricted compared to a QuickTime container used in .mov files.

## The basics

The basics are pretty well explained in older resources. The WWDC video "Harnessing metadata in audiovisual media" from WWDC14 gives a great overview, the Apple code samples [AVMetadataRecordPlay](https://developer.apple.com/library/archive/samplecode/AVMetadataRecordPlay/Introduction/Intro.html#//apple_ref/doc/uid/TP40016165) and [AVTimedAnnotationWriter](https://developer.apple.com/library/archive/samplecode/AVTimedAnnotationWriter/Introduction/Intro.html#//apple_ref/doc/uid/TP40014496) released around the same time also contain great (Objective-C) example code showing how to work with metadata. Sadly that video isn't hosted by Apple anymore, but you still can find an unofficial mirrors on [YouTube](https://www.youtube.com/watch?v=ccz9kI8VQsw).

If you want to read the data from audiovisual files use the `metadata` property on `AVAsset` and `AVAssetTrack`. To write it out use the `metadata` property on their counterparts `AVAssetWriter` and the `AVAssetWriterInput`.

Set that property with an array of `AVMetadataItem` objects. That data will be written out by the asset writer, note that you must set the data before you start writing. Because meta data is written at the start of the file. For each `AVMutableMetadataItem` make sure to set the `identifier`, `dataType` and `value`.

```swift
// Example of writing metadata
// BEWARE: Works for mov files, but fails with mp4 files!
let item = AVMutableMetadataItem()
item.dataType = kCMMetadataBaseDataType_UTF8 as String
item.identifier = AVMetadataItem.identifier(forKey: "eu.nonstrict.example", keySpace: .quickTimeMetadata)! // Will return `nil` when identifier is invalid, should add check.
item.value = "Some value" as NSString

let assetWriter = AVAssetWriter(url: outputURL, fileType: .mov)
assetWriter.metadata = [item]
```

This is basically it for .mov files, since they are quite flexible with metadata. You can also put `NSNumber` or `NSData` in for other metadata as explained in the WWDC video.

## Writing to mp4 files

If you try to write out the above metadata to a mp4 file it will fail silently. The metadata isn't added, but the file is otherwise created as expected.

To write mp4 compatible metadata the following must be done:
- Use the `.isoUserData` keySpace for identifiers
- This keyspace requires 4 character keys (internally those are stored as integers)
- The value must be set as `NSData`, other value types are not supported

Converting the above example to mp4 compatible code would result in something like this:

```swift
// Example of writing metadata into a mp4 file
let item = AVMutableMetadataItem()
item.dataType = kCMMetadataBaseDataType_RawData as String
item.identifier = AVMetadataItem.identifier(forKey: "xmpl", keySpace: .isoUserData)! // Will return `nil` when identifier is invalid, should add check.
item.value = Data("Some value".utf8) as NSData

let assetWriter = AVAssetWriter(url: outputURL, fileType: .mp4)
assetWriter.metadata = [item]
```

To quickly verify if the key was written out into the file I would recommend the `mp4dump` tool from [Bento4](https://github.com/axiomatic-systems/Bento4). This is one of the few tools that really show all metadata, common players/tools like VLC or ffmpeg filter out all metadata that isn't known to them. 

### Reading back the data

While reading back custom metadata in .mov files is very straight forward, everything is converted for you. This is less the case for mp4 files. Reading back the above item from a file would need:
- Converting the key back from an unsigned 32-bit integer to a string
- Converting the data back from `NSData` to a string

Reading the metadata therefore needs quite some casts and checks to get back the metadata written to the file:

```swift
let item = try await AVAsset(url: assetURL).load(.metadata).first!
guard let numericKey = avMetadataItem.key, 
      numericKey is NSNumber, 
      let stringKey = decodeFourCharCode((numericKey as! NSNumber).uint32Value) 
  else {
    fatalError("Invalid key")
}
guard let dataValue = avMetadataItem.dataValue else {
    fatalError("No data value")
}
let stringValue = tring(decoding: dataValue, as: UTF8.self)

private func decodeFourCharCode(_ key: UInt32) -> String? {
    guard let decodedKey = NSFileTypeForHFSTypeCode(key) else { return nil }
    return String(decodedKey.dropFirst().dropLast())
}
```

## Alternatives considered

For the recorder we created for [Screen Studio](https://screenstudio.lemonsqueezy.com?aff=nXV1B) JSON files are used alongside the video/audio files. This is a very good alternative, but requires to write things out into a folder and define a custom format. It also is very easy for users to alter this data or mix up files between recordings. It is however a setup way more developers will be familiar with so it can be a very good alternative in a lot of cases.

Another alternative is to switch away from the mp4 container and instead use .mov files. This is what we did for [Bezel](https://getbezel.app), it's way more forgiving to work with metadata in .mov files with AVFoundation. Since it's an intermediate storage that only has to be read by Bezel itself we aren't really concerned by compatibility issues that might arrise. So if you have the flexibility to switch away from mp4, I would really recommend that if you want to write out metadata. 

## References

- Nonstrict. (2023) [Bezel - Show your iPhone on your Mac.](https://getbezel.app) Bezel website.
- Apple. (2023) [AVFoundation, Media Assets, Metadata.](https://developer.apple.com/documentation/avfoundation/media_assets#3643898) Apple Developer Documentation.
- Apple. (2014, June 2-6). Session 505: Harnessing metadata in audiovisual media. WWDC14. ([Unofficial YouTube mirror](https://www.youtube.com/watch?v=ccz9kI8VQsw))
- Apple. (2014). [AVMetadataRecordPlay.](https://developer.apple.com/library/archive/samplecode/AVMetadataRecordPlay/Introduction/Intro.html#//apple_ref/doc/uid/TP40016165) Apple Developer Documentation Archive.
- Apple. (2014). [AVTimedAnnotationWriter.](https://developer.apple.com/library/archive/samplecode/AVTimedAnnotationWriter/Introduction/Intro.html#//apple_ref/doc/uid/TP40014496) Apple Developer Documentation Archive.
- GravisHimself. (2020, July 7). [Writing MP4 metadata with AVFoundation.](https://developer.apple.com/forums/thread/654753) Apple Developer Forums.
- Axiomatic Systems. (2023, November 25). [Bento4.](https://github.com/axiomatic-systems/Bento4) GitHub.
- Adam Pietrasiak. (2023) [Screen Studio. Beautiful Screen Recordings in minutes.](https://screenstudio.lemonsqueezy.com?aff=nXV1B) Screen Studio website.
