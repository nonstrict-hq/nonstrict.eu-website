---
date: 2023-12-08 12:00
authors: mathijs, tom
tags: Engineering, Bezel
title: Transferable drag & drop with only a FileRepresentation not working on macOS
description: Supporting file dragging in macOS is a breeze with SwiftUI using the new Transferable protocol. However only having a FileRepresentation doesn't work for apps like Finder.
image: images/blog/erika-giraud-H6xKnDKrKDk-unsplash.jpg
path: 2023/transferable-drag-drop-fails-with-only-FileRepresentation
featured: true
---

**tldr; Add a `ProxyRepresentation` returning the `URL` to your file right below the `FileRepresentation` as a workaround to make Finder and most other apps work.**

Since the early days of Mac OS X dragging and dropping files from and to apps has been an important part of the user experience. In macOS 10.12 the API to implement this already got a great improvement with the introduction of `NSFilePromiseProvider`. However since macOS 13 the new `Transferable` protocol makes it easier than ever. It fits in really well with SwiftUI and the new declaritive style. It also not only support drag and drop, but also for example share sheets.

To support dragging content out of your app in SwiftUI you just add `.draggable(content)` on your view. This gives the user the ability to drag that view to another place and the content will be delivered there. The only requirement is that the given content conforms to `Transferable`.

Adding this conformance is quite easy, choose one of more ways to represent your content. As a codable, as a file on disk, as data or using another type that is already `Transferable` as a proxy. Add this in a static transfer representation like this:

```swift
extension MyContentType: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .png) { myContentType in myContentType.pngData() }
}
```

The WWDC22 video [Meet Transferable.](https://developer.apple.com/videos/play/wwdc2022/10062/) is highly recommended to learn more about the details of how `Transferable` can be implemented.

## Our use case

We use this in our app [Bezel](https://getbezel.app) that can record your iPhone to give the user the ability to drag out the recorded video file. Just drop it at the target location and go on with your work.

Since video files can become quite big we don't want to keep the data in memory. The file also is already written to disk, so we opted to go with the `FileRepresentation` where we provide an URL to the location of the video file.

## The issue

However when we started to drop the file on Finder or other apps like Slack nothing happened. They just didn't accept the content. It turns out in macOS 13 and 14 `FileRepresentation` isn't working correctly. No matter the declared content type, whether the file should be opened in place or if original file access is allowed. The file is simply never accepted.

## Workaround

Turns out there is a workaround; If you also declare a `ProxyRepresentable` that just uses the file URL as proxy things start working! The URL is then used by apps like Finder to copy over the file or you can drop it on apps like Slack to share the file.

```swift
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(exportedContentType: .mpeg4video) { myVideoType in
            SentTransferredFile(myVideoType.url)
        }
        ProxyRepresentation { myVideoType in myVideoType.url }
    }
```

Please note that falling back to `ProxyRepresentation` only works for files that are already on disk. It's not allowed to perform long-running work in exporting and importing closures according to the documentation. If you take too much time the app stalls and shows a beachball. Additionally the other app will gain access to the original file and not a copy, so that also is something to keep in mind. 

This was a pretty confusing issue and workaround, since the WWDC talk explicitly notes that `FileRepresentation` should be used for sharing files. The `ProxyRepresentation` with an `URL` should be used if you want to share an URL to a website for example. It seems this behaviour isn't working correctly at this moment.

## Feedback Assistant & Sample project

This issue was submitted to Apple as FB13454434. We also created a [demonstration project for this issue on GitHub](https://github.com/nonstrict-hq/AppleFeedback/tree/main/FB13454434).

## References

- Apple. (2023). [Core Transferable.](https://developer.apple.com/documentation/coretransferable) Apple Developer Documentation.
- Apple. (2022, June 6-10). [Meet Transferable.](https://developer.apple.com/videos/play/wwdc2022/10062/) WWDC22.
- Nonstrict. (2023) [Bezel - Show your iPhone on your Mac.](https://getbezel.app) Bezel website.
- Philip Mobil. (2022). [Core Transferable, Drag file from app to Finder on macOS.](https://developer.apple.com/forums/thread/708794) Apple Developer Forums.
- Nonstrict. (2023, December 7). [AppleFeedback, FB13454434.](https://github.com/nonstrict-hq/AppleFeedback/tree/main/FB13454434) GitHub.
