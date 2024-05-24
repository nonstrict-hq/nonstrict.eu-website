---
date: 2023-07-10 12:00
authors: tom, mathijs
tags: Engineering
title: Display reconfigurations on macOS
description: Observing display reconfiguration changes on macOS. Moving from C function-pointer based API to a modern Swift AsyncStream.
path: 2023/display-reconfigurations-on-macos
image: images/blog/linus-mimietz-UzbvepPfb14-unsplash.jpg
featured: true
hideImageHero: false
---

For our app [CleanPresenter](https://cleanpresenter.com), we need to detect when new displays are added or removed in macOS. This happens when connecting a display via HDMI, but also when starting an AirPlay session to a TV, or using Sidecar with iPad.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=display-reconfigurations-on-macos" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

There are two C functions for this in macOS, introduced 20 years ago in Mac OS X Panther (10.3):

```swift
/* A client-supplied callback function that’s invoked whenever the
   configuration of a local display is changed. */
typealias CGDisplayReconfigurationCallBack = (CGDirectDisplayID, CGDisplayChangeSummaryFlags, UnsafeMutableRawPointer?) -> Void

/* Register a display reconfiguration callback procedure. The `userInfo'
   argument is passed back to the callback procedure each time it is
   invoked.
*/
func CGDisplayRegisterReconfigurationCallback(
    _ callback: CGDisplayReconfigurationCallBack?,
    _ userInfo: UnsafeMutableRawPointer?
) -> CGError

/* Remove a display reconfiguration callback procedure. */
func CGDisplayRemoveReconfigurationCallback(
    _ callback: CGDisplayReconfigurationCallBack?,
    _ userInfo: UnsafeMutableRawPointer?
) -> CGError
```


These C functions do exactly what they promise, they callback the provided function, when a local display is reconfigured. However, we would like a more “Swifty” way of writing this code.

## From functions to closures

The C functions for registering and removing a reconfiguration callback both take a function pointer and a userInfo pointer. Instead of dealing with a lone function pointer, we’d rather use a Swift closure.

We use a helper class `Closure2` that we described in our previous blogpost [Working with C callback functions in Swift](/blog/2023/working-with-c-callback-functions-in-swift), so that we can use Swift closures.

With this, we can now write the following:

```swift
let start = Date.now
let closure = Closure2 { (displayID: CGDirectDisplayID, flags: CGDisplayChangeSummaryFlags) in
    print("Reconfiguration, display:", displayID, start)
}
// Store closure in long-lived object, so that it doesn't go out of scope
self.stored = closure

CGDisplayRegisterReconfigurationCallback({ displayID, flags, userInfo in
    Closure2.invoke(displayID, flags, userInfo)
}, closure.pointer)
```

This shows how we close over the `start` variable. Note that we need to store the closure object somewhere, so that it isn’t clean up by ARC.

## From closures to AsyncStream

Now that we can use closures, lets make this even more Swifty. We will create an AsyncStream that produces a new value each time a display reconfiguration happens.

```swift
var displayReconfigurations: AsyncStream<(CGDirectDisplayID, CGDisplayChangeSummaryFlags)> = AsyncStream { continuation in

    // Create closure that invokes continuation
    let closure = Closure2 { (displayID: CGDirectDisplayID, flags: CGDisplayChangeSummaryFlags) in
        continuation.yield((displayID, flags))
    }

    // A literal, that can be used as a C function pointer
    let callback: CGDisplayReconfigurationCallBack = { (displayID, flags, userInfo) in
        Closure2.invoke(displayID, flags, userInfo)
    }

    // Remove registration when user terminates async stream
    continuation.onTermination = { _ in
        CGDisplayRemoveReconfigurationCallback(callback, closure.pointer)
    }

    // Register callback
    CGDisplayRegisterReconfigurationCallback(callback, closure.pointer)
}
```

This neatly wraps everything together, The closure is created that will yield new values to the async stream. The closure object itself, that we needed to keep alive, is stored in the onTermination handler, so that it remains as long as the user is iterating over the async loop.

This AsyncStream can be used like so:

```swift
let base = getBaseValue()
for await (displayID, flags) in displayReconfigurations {
    print("Reconfiguration, display:", displayID, base)
}
```

With a bit of work, it's quite possible to move from 20 year old C function pointers, to a modern Swift API with an AsyncStream! 

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=display-reconfigurations-on-macos" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

- Nonstrict (2023). CleanPresenter Mac app. [https://cleanpresenter.com](https://cleanpresenter.com)
- Apple (2023). CGDisplayRegisterReconfigurationCallback [Online documentation](https://developer.apple.com/documentation/coregraphics/1455336-cgdisplayregisterreconfiguration)
- Apple (2023). GDisplayRemoveReconfigurationCallback [Online documentation](https://developer.apple.com/documentation/coregraphics/1455407-cgdisplayremovereconfigurationca)
