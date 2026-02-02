---
date: 2023-12-11 12:00
authors: tom, mathijs
tags: Engineering
title: Using Darwin Notifications to communicate with App Extensions
description: On iOS, Darwin Notifications can be used to send and receive notifications between an app and its extensions. We wrap the old C-style functions to be easier to use from Swift. 
image: images/blog/bruno-martins-3zWncaikTfU-unsplash.jpg
path: 2023/darwin-notifications-app-extensions
featured: true
---

**tldr; Check out the gist [DarwinNotificationCenter.swift](https://gist.github.com/tomlokhorst/7fe49a03b8bac960eeaf2b991faa3680)!**

For our iOS apps, we want to communicate between the main app the app extensions. To share data, we can use [App Groups](https://developer.apple.com/documentation/xcode/configuring-app-groups) and share UserDefaults or Swift Data. But to send notifications between different processes, we need Darwin Notifications for the old [CFNotificationCenter](https://developer.apple.com/documentation/corefoundation/cfnotificationcenter-rkv).

On macOS, we get access to a higher level API [DistributedNotificationCenter](https://developer.apple.com/documentation/foundation/distributednotificationcenter/), but on iOS, all we have is the low-level C-style API from CFNotificationCenter.h. To make this a bit easier to deal with, we wrote a Swift wrapper using a more modern API style. With this class we can post notifications, add an observer, and also remove the observer by releasing an observation object. 

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=darwin-notifications-app-extensions" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

To start of, we create a `DarwinNotificationCenter` class:

```
private let center = CFNotificationCenterGetDarwinNotifyCenter()

public final class DarwinNotificationCenter {
    private init() {}
    public static var shared = DarwinNotificationCenter()

    public func post(name: String) {
        CFNotificationCenterPostNotification(center, CFNotificationName(rawValue: name as CFString), nil, nil, true)
    }

    public func addObserver(name: String, callback: @escaping () -> Void) -> DarwinNotificationObservation {
        let observation = DarwinNotificationObservation(callback: callback)

        let pointer = UnsafeRawPointer(Unmanaged.passUnretained(observation.closure).toOpaque())

        CFNotificationCenterAddObserver(center, pointer, notificationCallback, name as CFString, nil, .deliverImmediately)

        return observation
    }
}
```

This exposes a `post(name:)` method. Note that for distributed notifications it is not possible to send along additional information via an object or userInfo dictionary.

The `addObserver(name:callback:)` method returns a `DarwinNotificationObservation` object. As long as you retain the object, the observer stays active. When releasing the object, the observation is also removed. Because the observation object implements the `Cancellable` protocol, it can also be retained using the `observation.store(in: &disposeBag)` pattern.

When a notification comes in, the `notificationCallback` function is called: 

```
private func notificationCallback(center: CFNotificationCenter?, observation: UnsafeMutableRawPointer?, name: CFNotificationName?, object _: UnsafeRawPointer?, userInfo _: CFDictionary?) {
    guard let pointer = observation else { return }

    let closure = Unmanaged<DarwinNotificationObservation.Closure>.fromOpaque(pointer).takeUnretainedValue()

    closure.invoke()
}
```

This function must be a C-style callback function, it cannot be a closure. We're previously discussed this pattern in our post [“Working with C callback functions in Swift using parameter packs”](/blog/2023/working-with-c-callback-functions-in-swift/). We pass along a pointer to our `DarwinNotificationObservation` object, which does contain the actual closure.

```
public final class DarwinNotificationObservation: Cancellable {
    fileprivate class Closure {
        let invoke: () -> Void
        init(callback: @escaping () -> Void) {
            self.invoke = callback
        }
    }
    fileprivate let closure: Closure

    fileprivate init(callback: @escaping () -> Void) {
        self.closure = Closure(callback: callback)
    }

    deinit {
        cancel()
    }

    public func cancel() {
        DispatchQueue.main.async { [closure] in
            let pointer = UnsafeRawPointer(Unmanaged.passUnretained(closure).toOpaque())
            CFNotificationCenterRemoveObserver(center, pointer, nil, nil)
        }
    }
}
```

Finally, the DarwinNotificationObservation contains the callback closure that gets called when a notification comes in.

For distrubuted Darwin notifications, the system always calls the `notificationCallback` on the main thread. But the `cancel()` (or `deinit`) might get called from different threads. This might lead to a race condition, where the object gets deallocated while the code in `notificationCallback` is running. To prevent crashes, we run the actual removal of the observer on the main thread, this way, can't run in parallel with the notification callback.

All this code, including comments and extensions for AsyncSequence and Combine is available [in this gist](https://gist.github.com/tomlokhorst/7fe49a03b8bac960eeaf2b991faa3680). 

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=darwin-notifications-app-extensions" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

- Apple. (2023). [App Groups](https://developer.apple.com/documentation/xcode/configuring-app-groups). Apple Developer Documentation.
- Apple. (2023). [CFNotificationCenter](https://developer.apple.com/documentation/corefoundation/cfnotificationcenter-rkv). Apple Developer Documentation.
- Apple. (2023). [DistributedNotificationCenter](https://developer.apple.com/documentation/foundation/distributednotificationcenter/). Apple Developer Documentation.
- Nonstrict. (2023). [“Working with C callback functions in Swift using parameter packs”](/blog/2023/working-with-c-callback-functions-in-swift/). Nonstrict blog.
- Nonstrict (2023). [DarwinNotificationCenter.swift](https://gist.github.com/tomlokhorst/7fe49a03b8bac960eeaf2b991faa3680) GitHub.
