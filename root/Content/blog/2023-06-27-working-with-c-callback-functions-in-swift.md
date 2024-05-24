---
date: 2023-06-27 12:00
authors: tom, mathijs
tags: Engineering
title: Working with C callback functions in Swift using parameter packs
description: Moving from a C function-pointer based callback API to Swift closures with generics. And a look at the future with parameter packs.
path: 2023/working-with-c-callback-functions-in-swift
image: images/blog/pavan-trikutam-71CjSSB83Wo-unsplash.jpg
featured: true
hideImageHero: false
---

For our app [CleanPresenter](https://cleanpresenter.com), we need to use some older Mac APIs. For example the function [CGDisplayRegisterReconfigurationCalback](https://developer.apple.com/documentation/coregraphics/1455336-cgdisplayregisterreconfiguration), to register a callback when the display configuration changes. This function was introduced 20 years ago in Mac OS X Panther.

The function CGDisplayRegisterReconfigurationCalback does exactly what it promise, it takes a function pointer and calls back when needed. But this function pointer is annoying, we would like a more “Swifty” way of writing this code.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=working-with-c-callback-functions-in-swift" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

## From functions to closures

The C API uses function pointers to specify what function to callback. In Swift we don’t use function pointers, instead we use [closures](https://en.wikipedia.org/wiki/Closure_(computer_programming)). The difference between a function pointer and a closure is that a closure also captures its surrounding variables (it “closes over the environment”).

In the automatic Swift-to-C bridging, we can write the familiar curly-braces syntax, that looks a lot like Swifts closures, but we cannot capture external variables.

This is an example of a closure:

```swift
let start = Int(Date.now.timeIntervalSinceReferenceDate)
let result = myArray.map { x in start + x }
```

Here, the map takes a closure argument, this isn’t just a function that returns a value based on the argument `x`, but it also captures the `start` value. If map instead used a function pointer instead, there would be no way to write the equivalent code. We couldn’t refer to the `start` variable, we could try to inline the `Date.now` call, but then it would be called multiple times, changing the behaviour from the original code.

So, with just the function pointer, we can write this to print each display reconfiguration:

```swift
CGDisplayRegisterReconfigurationCallback({ displayID, flags, userInfo in
    print("Reconfiguration of display:", displayID)
}, nil)
```

Fortunately, the CGDisplayRegisterReconfigurationCallback function is not so limited that it only takes a function pointer. It also takes an optional second argument `userInfo`, this userInfo can be anything (it is an `UnsafeMutableRawPointer`) but that userInfo gets passed back into the callback! This is the standard method in C of getting the equivalent to a closure; pass an extra pointer around, that pointer can contain the environment needed.

With this, we can now make a helper object to store the closure.

```swift
// Helper class to store closure
class DisplayReconfigurationClosure {
    let closure: (CGDirectDisplayID, CGDisplayChangeSummaryFlags) -> Void

    init(_ closure: @escaping (CGDirectDisplayID, CGDisplayChangeSummaryFlags) -> Void) {
        self.closure = closure
    }
}
```

And use that closure, so that we can also print the external `start` variable:

```swift
let start = Date.now

let closure = DisplayReconfigurationClosure { (displayID: CGDirectDisplayID, flags: CGDisplayChangeSummaryFlags) in
    print("Reconfiguration, display:", displayID, start)
}
// Store closure in long-lived object, so that it doesn't go out of scope
self.stored = closure

// Create a pointer from the helper object
let unsafeMutableRawPointer = withUnsafeMutablePointer(to: &closure) { pointer in
    UnsafeMutableRawPointer(pointer)
}

// Pass pointer around
CGDisplayRegisterReconfigurationCallback({ displayID, flags, userInfo in
    userInfo?.load(as: DisplayReconfigurationClosure.self).closure(displayID, flags)
}, unsafeMutableRawPointer)
```

This involves a whole lot of pointer casting, and it is very specific to the DisplayReconfiguration case, but it does work.

We can clean this up some more, and push most of the code into a generic `Closure2` class.

```swift
// Class to store the original closure, and also
// a pointer to an object that can be used as userInfo.
class Closure2<T1, T2> {
    public struct Container {
        let closure: (T1, T2) -> Void
    }
    var container: Container
    var pointer: UnsafeMutableRawPointer

    init(_ closure: @escaping (T1, T2) -> Void) {
        self.container = Container(closure: closure)
        self.pointer = withUnsafeMutablePointer(to: &container) { pointer in
            UnsafeMutableRawPointer(pointer)
        }
    }

    static func invoke(_ arg1: T1, _ arg2: T2, _ unsafeMutableRawPointer: UnsafeMutableRawPointer?) {
        unsafeMutableRawPointer?.load(as: Container.self).closure(arg1, arg2)
    }
}
```

Which we can use like so:

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

### Swift 5.9 parameter packs

With parameter packs in Swift 5.9, we are no longer restricted to using a specific number of generic arguments. We can create a class with a variable number of generic arguments. Note that this does require runtime support as Parameter packs in generic types are only available in macOS 14.0.0 or newer.

```swift
class Closure<each T> {
    public struct Container {
        let closure: (repeat each T) -> Void
    }
    var container: Container
    var pointer: UnsafeMutableRawPointer

    init(_ closure: @escaping (repeat each T) -> Void) {
        self.container = Container(closure: closure)
        self.pointer = withUnsafeMutablePointer(to: &container) { pointer in
            UnsafeMutableRawPointer(pointer)
        }
    }

    static func invoke(_ args: repeat each T, unsafeMutableRawPointer: UnsafeMutableRawPointer?) {
        unsafeMutableRawPointer?.load(as: Container.self).closure(repeat (each args))
    }
}
```

### Conclusion

When first encountering older C functions with callback, they might seem difficult to work with. But those older function are often well designed taking an additional context parameter, and with a little helper code, they can wrapped to work with a normal Swift closure.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=working-with-c-callback-functions-in-swift" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

- Nonstrict. (2023, June 27). CleanPresenter Mac app. [https://cleanpresenter.com](https://cleanpresenter.com)
- Apple. (2023, June 27). CGDisplayRegisterReconfigurationCallback [Online documentation](https://developer.apple.com/documentation/coregraphics/1455336-cgdisplayregisterreconfiguration)
- Apple. (2023). - Apple. (2023). Session 10168: [Generalize APIs with parameter packs](https://developer.apple.com/videos/play/wwdc2023/10168/)
