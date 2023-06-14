---
date: 2023-06-14 12:00
authors: tom, mathijs
tags: Engineering
title: A look at ScreenCaptureKit on macOS Sonoma
description: The new macOS introduces three new features: Presenter Overlay to add your webcam to a screen share, a new screenshot API, and a built-in picker UI to select a window or screen to share.
path: 2023/a-look-at-screencapturekit-on-macos-sonoma
image: images/blog/screencapturekit-picker-sonoma.jpg
featured: true
hideImageHero: false
---

Last week at WWDC23 Apple introduced macOS 14 “Sonoma”, it features some improvements to ScreenCaptureKit and makes public a sharing picker UI that was previously only available to FaceTime and Safari.

There are three big new features introducted. We have been experimenting with the first developer preview of Sonoma. This post gives an overview of the new features.

### New features

- Presenter Overlay: allows users to show a bubble of their head floating on top of a screen share. This can be use directly in screen sharing apps like Zoom or Google Meet
- SCScreenshotManager: A screenshot API for taking still images. This is uses the same filter and configurations APIs from ScreenCaptureKit, and replaces the previous CGWindowListCreateImage function.
- SCContentSharingPicker: A system level picker UI for selecting windows or displays to share. This means apps don’t need to build their own window/screen selection UI. As an added benefit, when you use this picker UI, you don’t need to ask for screen recording permissions.

Note: The documentation that ships with Xcode 15 beta 1 doesn’t match the version of the SDK that ships in beta 1. Some classes and properties have been renamed. The WWDC talks also show a previous version of the API. The [online documentation](https://developer.apple.com/documentation/screencapturekit) does match what is available in the SDK. Also, there are a lot of bugs in this very first beta.

### Presenter Overlay

Presenter Overlay appears to only be available when using the new SCContentSharingPicker API. If an app has both an active ScreenCaptureKit SCStream and an AVCaptureSession with an AVCaptureDevice, the system picker UI shows an option to add a floating bubble webcam UI.

When a user enables PresenterOverlay, the SCStream gets modified to include the video of the webcam. That means that apps that allow for screen sharing don’t need major modifications, the video just shows up. One optimization might be to hide the webcam feed of a user, because that gets disabled when Presenter Overlay is enabled.

Presenter Overlay is only available for the end-user to enable, there is no API to enable it. Also, there is no API to disable this feature either. I asked two Apple engineers during a Lab, they confirmed it is currently not possible for apps to explicitly disable Presenter Overlay.

At the time of writing, I couldn’t get Presenter Overlay to work in my own app, it only works in FaceTime. I’ve filed a feedback: FB12331901

### SCScreenshotManager

[SCScreenshotManager](https://developer.apple.com/documentation/screencapturekit/scscreenshotmanager) is a new class for creating screenshots. It replaces the previous API [CGWindowListCreateImage](https://developer.apple.com/documentation/coregraphics/1454852-cgwindowlistcreateimage). SCScreenshotManager has two static methods for capturing images as either CGImage or a CMSampleBuffer. The latter can be used to get access to more pixel formats.

The introduction of this new SCScreenshotManager means the old CGWindowListCreateImage is now deprecated. Interestingly the sibling functions [CGWindowListCopyWindowInfo](https://developer.apple.com/documentation/coregraphics/1455137-cgwindowlistcopywindowinfo) and [CGWindowListCreate](https://developer.apple.com/documentation/coregraphics/1552209-cgwindowlistcreate?language=objc) (Only available from Objective-C) are not deprecated and currently still available.

When using SCScreenshotManager with SCSharableContent, the user needs to give screen recording authorisation in System Settings. Like on Ventura, the old CGWindowListCreateImage API also requires the user to give the app authorization, otherwise it will show an empty screenshot without any windows.

Confusingly even when using SCContentSharingPicker, in the current beta the user needs to give authorization to caputure images. This seems to be a bug in this first beta, I’ve filed a feedback: FB12331920.

### SCContentSharingPicker - Screensharing picker

The new [SCContentSharingPicker](https://developer.apple.com/documentation/screencapturekit/sccontentsharingpicker) class can be used to show the user the system level window/screen picker. Via the configuration, the developer can configure which items can be picked; Either a single window, application or display or multiple windows or applications. As with the existing programmatic API ([SCSharableContent](https://developer.apple.com/documentation/screencapturekit/scshareablecontent)), specific windows or applications can be excluded from being picked.

You don’t need to use the new picker UI, the previous API based on SCShareableContent is still available. One big difference is that the programmatic API requires the user to enable Screen Recording authorization in the System Settings app. Because the new picker UI is based on user interaction, this is not needed, the user can select a window to share, and it just works.

(Note: Again, as with SCScreenshotManager, I couldn’t get this to work, this seems a bug in this first beta, FB12331920)

One strange aspect of the current version of the system level UI is that it doesn’t show both we webcam and the content picker at the same time. It depends on the order in which the features get activated. That means if start a SCStream.startCapture() first, and then do AVCaptureSession.startRunning(), the the screen capture will be shown in the picker in the system level UI, if the webcam is started first, that one is shown. I suspect this is a bug in this first beta (FB12331901).

![Screenshot of macOS Ventura showing the system level picker](/images/blog/screencapturekit-picker-ventura.jpg)
<figcaption>Sharing picker on macOS Ventura when using FaceTime.</figcaption>

Fun fact; The system level picker technically isn’t new to Sonoma, it is also available in macOS Ventura, but there is no public API to access it. Via the private API SCContentSharingSessionManager, apps like Safari and FaceTime already use it to let the user select windows for screen sharing.

### Conclusion

There are a lot of issues in the current beta 1, the documentation is incomplete and many features don’t work right. But this is a beta, and I’m sure a lot of issues will be fixed in the comming months.

The previous macOS method of allowing apps to record the screen is quite complicated; There is a confusing dialog, and users need to go to System Settings to manually enable the app. I’m excited by the new system level sharing picker, since this allows users to quickly get started with screensharing a window or screen, without navigating through any complicated flows.

## References

- Apple. (2023). Session 10053: [What’s new in privacy](https://developer.apple.com/videos/play/wwdc2023/10053/?time=344)
- Apple. (2023). Session 10136: [What’s new in ScreenCaptureKit](https://developer.apple.com/videos/play/wwdc2023/10136/)
- Apple. (2023). ScreenCaptureKit. [https://developer.apple.com/documentation/screencapturekit](https://developer.apple.com/documentation/screencapturekit)
