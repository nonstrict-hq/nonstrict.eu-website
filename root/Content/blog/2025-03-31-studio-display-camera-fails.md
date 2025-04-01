---
date: 2025-03-31 12:00
authors: tom, mathijs
tags: Engineering, RecordKit
title: Studio Display Camera occasionally fails to produce frames
description: Every one in 24 times, when trying to record the camera of the Apple Studio Display, no video is produced and the camera turns itself off. The camera just silently fails without reporting any error.
image: images/blog/studio-display-camera-light.jpg
path: 2025/studio-display-camera-fails
featured: true
---

When working on [RecordKit](https://nonstrict.eu/recordkit/), our macOS recording SDK, we ran into an issue where occasionally the camera of an Apple Studio Display will not produce video frames. Digging into this issue, we found we could reproduce this by trying to record the camera in a loop. Consistently, every 24th time, no frames are produced by the camera. Interrestingly, this doesn’t happen when Center Stage is active for the application.

This silent failure happens accross multiple different physical Studio Displays, and accross multiple Macs and macOS versions (14, 15). The only variation being that sometimes it fails after 22 or 23 loops, instead of 24.

Other Apple cameras such the FaceTime HD camera in MacBooks or the 2011 Thunderbolt Display do not have this issue. Also, none of the external cameras we have tested (Logitech C920 HD Pro, CamLink 4K, Logitech SteamCam) exhibit this behavour.

![Screenshot of QuickTime showing black image when Studio Display Camera is selected](/images/blog/2025-03-quicktime-studio-display-camera.jpg)

In our code we use an `AVCaptureSession` with a `AVCaptureVideoDataOutput`, but this issue isn’t specific to some code path. It also happens when simply opening and closing the Movie Recorder in QuickTime Player 24 times.

## Workaround

A simple workaround when this happens is to retry. The 25th time when trying to use the Studio Display Camera, it works again. Or rather, it resets the 24 counter, because the 48th time the camera will again not produce frames.

Because this issue doesn’t when Center Stage is active, a different workaround is to enable/disable Center Stage from code:

```swift
AVCaptureDevice.centerStageControlMode = .cooperative
AVCaptureDevice.isCenterStageEnabled.toggle()
AVCaptureDevice.isCenterStageEnabled.toggle()
```

We’ve reported this issue to Apple Feedback: [FB17052933](https://github.com/nonstrict-hq/AppleFeedback/tree/main/FB17052933)

## References

- Nonstrict. (2025, March). [FB17052933: Studio Display Camera does not produce frames, once every 24 times](https://github.com/nonstrict-hq/AppleFeedback/tree/main/FB17052933). GitHub.
