---
date: 2024-05-20 12:00
authors: mathijs, tom
tags: Engineering
title: Sending the initial workout configuration through HealthKit
description: `HKWorkoutSession` will throw 'Remote session delegate is not set up' errors at you when sending data too soon. So how do we share data before starting the actual workout? 
image: images/blog/blocks-fletcher-3_PaUEEcwMc-unsplash.jpg
path: 2024/hkworkoutsession-remote-delegate-not-setup-error
featured: true
---

**tldr; Call `session.prepare()` before you start sending data.**

The "Keep Going" workout app we're building makes use of the workout mirroring features available since watchOS 10 and iOS 17. Workout mirroring is explained in the WWDC talk [Build a multi-device workout app](https://developer.apple.com/wwdc23/10023) from WWDC23. Make sure to check out the [excellent sample project](https://developer.apple.com/documentation/healthkit/workouts_and_activity_rings/building_a_multidevice_workout_app) that goes with the talk!

What remains unclear is how to send additional data before starting the workout. If your workout app has something like a custom workout goal or other metadata, it is very convenient to communicate that to the other device before starting the workout. This makes sure you can show correct and up to date information in your user interface.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror any iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone or wirelessly mirror it to your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div>

## Error: Remote session delegate is not set up

Once the watchOS code calls [startMirroringToCompanionDevice](https://developer.apple.com/documentation/healthkit/hkworkoutsession/4165515-startmirroringtocompaniondevice) on the `HKWorkoutSession`, the iPhone app will be launched immediatly. It also will be notified of the workout through a call to [workoutSessionMirroringStartHandler](https://developer.apple.com/documentation/healthkit/hkhealthstore/4172878-workoutsessionmirroringstarthand) on `HKHealthStore`. Once the iOS app adds it's delegate the the mirroring workout session everything seems good to go.

However if you try to send data to the remote workout session before you start it things break down. Calling [sendToRemoteWorkoutSession](https://developer.apple.com/documentation/healthkit/hkworkoutsession/4126899-sendtoremoteworkoutsession) will throw an error at you:

```
[mirroring] <HKWorkoutSession:0x17d26d20 6DE1EF8C-F9D7-4966-A879-4C0F455137D1 not started [Primary]>: Failed to send data to remote session with error: Error Domain=com.apple.healthkit Code=3 "Remote session delegate is not set up." UserInfo={NSLocalizedDescription=Remote session delegate is not set up.}
```

Note that this error is also thrown when the delegate has been setup correctly in both the watchOS and the iOS app! The combination of this error and seeing calls from HealthKit on both devices can be very confusing. It certainly made me review the whole app setup, before discovering the actual fix.

## The fix; prepare the session

It turns out that the `HKWorkoutSession` at least needs to be prepared before data can be send over it. Experimenting shows that when you call [prepare](https://developer.apple.com/documentation/healthkit/hkworkoutsession/2994353-prepare) on the session on watchOS it transitions immediatly to the `prepared` state and then sending data does work.

I'm not aware of any documentation mentioning this, only the [prepared](https://developer.apple.com/documentation/healthkit/hkworkoutsessionstate/prepared) case of `HKWorkoutSessionState` gives a vague hint that *"The session is ready but not yet running."* implying that in other states the session might not be ready to send data.

Here's a sample of how we setup the workout session on watchOS:

```swift
// Code on watchOS setting up the workout session
let session = try HKWorkoutSession(healthStore: store, configuration: config)
session.delegate = delegate

// Do your thing with the workout builder etc.

session.prepare() // Make sure the session is ready to send data
try await session.startMirroringToCompanionDevice() // Make session available on iPhone

try await session.sendToRemoteWorkoutSession(data: message) // Now send additional data about the workout!
```

### Note on reliability

In our experience the `session.prepare()` call transitions the `HKWorkoutSessionState` to `prepared` immediatly. Even while in the `prepared` state every now and then it fails to send data, probably because we're sending to fast and the session isn't actually fully prepared. Simply retrying the send seems to work around this issue.

## Wrap up

While not clearly described in the documentation or the talks about mirroring, it's good to know it's possible to send data before the workout is started. It's an easy fix that calling `prepare` on the session is enough to get things working.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
    </div>
    <div class="flex-initial">
        <h3 class="text-2xl font-bold text-black hover:text-orange-500 leading-relaxed mt-0 mb-2"><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">Bezel · Mirror any iPhone on your Mac</a></h3>
        <p class="mb-2">Perfect for app demos & presentations; Simply plug in an iPhone or wirelessly mirror it to your Mac.</p>
        <p><a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank" class="text-orange hover:text-orange-500 underline font-medium">Learn more →</a></p> 
    </div>
    <div class="flex-initial hidden md:block">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=hkworkoutsession-remote-delegate-not-setup-error" target="_blank">
            <img src="/images/bezel-still.jpg" class="max-h-full max-w-36 rounded-md bg-white/5 ring-1 ring-gray-600/50 dark:ring-white/50 lg:mt-auto">
        </a>
    </div>
</div>

## References

- Apple. (2023, June 5-9). Session 10023: [Build a multi-device workout app](https://developer.apple.com/wwdc23/10023). WWDC23.
- Apple. (2023). Sample Code: [Building a multidevice workout app](https://developer.apple.com/documentation/healthkit/workouts_and_activity_rings/building_a_multidevice_workout_app). Apple Developer Documentation.
- Apple. (2023). [HKWorkoutSession](https://developer.apple.com/documentation/healthkit/hkworkoutsession). Apple Developer Documentation.
- Apple. (2023). [HKHealthStore](https://developer.apple.com/documentation/healthkit/hkhealthstore). Apple Developer Documentation.
