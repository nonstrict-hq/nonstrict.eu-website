---
date: 2024-03-29 12:00
authors: mathijs, tom
tags: Engineering
title: Request and check local network permission on iOS and visionOS
description: The local network permission has, in contrast to other permissions, no simple way to request the permission or check its autorization state. We use `NWBrowser` to roll our own permission helper. 
image: images/blog/bezel-ios-requests-local-network-permission.jpg
path: 2024/request-and-check-for-local-network-permission
featured: true
---

**tldr; Check out the [gist](https://gist.github.com/mac-cain13/fa684f54a7ae1bba8669e78d28611784) with the solution we use.**

Our app [Bezel](https://getbezel.app/vision) communicates over the local network to other devices. On iOS and iPadOS since 14 and in visionOS the user needs to grant Local Network permission before apps can use the local network. This change is explained in the WWDC talk [Support local network privacy in your app](https://developer.apple.com/videos/play/wwdc2020/10110/) from WWDC20.

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=request-and-check-for-local-network-permission" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

## Existing networking APIs

Apple has done quite a good job making this all work with existing networking code. The alert requesting the permission is triggered whenever the app starts using the local network. Virtually all networking APIs are asynchronous, so the will just wait until permission is granted before they perform their actual work.

In the case the permission is denied the networking APIs will return a `kDNSServiceErr_PolicyDenied` error. This gives existing code an opportunity to handle this scenario, making this new permission mostly transparent to existing apps.

## Permission helper functions

One might expect that, like most permissions on iOS and visionOS, there is an easy way to check the current authorization state and request the permission from the user without performing actual networking. This however isn't in place for Local Network permission. Despite people requesting this in enhancement requests and discussing it on the Apple Developer Forums and StackOverflow.

### Rolling our own helper using NWBrowser

Once we understood there are clear states when using the network APIs we realized it would be possible to create a permission helper function ourselves. Here's the signature of our function:

```
/// Checks whether Local Network permission has been granted, if the authorization state for Local Network usage isn't yet determined it will request the user for permission.
///
/// - Throws: When a network error occurs or a `CancellationError` when cancelled.
/// - Returns: A boolean indicating whether Local Network permission is granted.
func requestLocalNetworkAuthorization() async throws -> Bool {
  // [...]
}
```

In this function we create both a `NWBrowser` and a `NWListener` that try to scan to network to find each other. This will trigger the Local Network permission request to the user when authorization isn't determined yet.

```
// Shortened implementation of `func requestLocalNetworkAuthorization()`
let listener = try NWListener(using: NWParameters(tls: .none, tcp: NWProtocolTCP.Options()))
listener.service = NWListener.Service(name: UUID().uuidString, type: type)
listener.newConnectionHandler = { _ in } // Must be set or else the listener will error with POSIX error 22

let parameters = NWParameters()
parameters.includePeerToPeer = true
let browser = NWBrowser(for: .bonjour(type: type, domain: nil), using: parameters)
    
// [...]

listener.stateUpdateHandler = { newState in
    // Handle listener error/cancellation states
}
listener.start(queue: queue)

browser.stateUpdateHandler = { newState in
    // Handle error/cancellation states, especially the wait state with the kDNSServiceErr_PolicyDenied error
}
browser.browseResultsChangedHandler = { results, changes in
    // Check whether a listener is found, this indicates we have permission
}
browser.start(queue: queue)
    
// [...]
```

The networking stack will just silently wait while it's asking the user for permission. As soon as there permission is given or denied the callbacks will be triggered and either report the `kDNSServiceErr_PolicyDenied` error or find the other service on the local device.

To make the browser `NWBrowser` and `NWListener` able to publish themselves we need to register a Bonjour service type with our app. We use a seperate service type from everything else called `_preflight_check._tcp`, this prevents interference with the any other networking features. This service must be added to the `Info.plist` of your app or else this whole setup won't work.

```
// Add this to your Info.plist
<key>NSBonjourServices</key>
<array>
    <string>_preflight_check._tcp</string>
</array>
```

Next we wrap this whole construction in a `withTaskCancellationHandler` and a `withCheckedThrowingContinuation` to make it a modern Swift Concurrency function that you can await and supports Task cancellation. In the [gist](https://gist.github.com/mac-cain13/fa684f54a7ae1bba8669e78d28611784) you will see that we took some measures to protect ourselved from resolving the continuation multiple times and support cancelling the task before we even started scanning.

### Using our helper

Now we have everything in place we can use this method to request and check permission at the right time. In Bezel we request the Local Network permission in the onboarding using a SwiftUI task that reruns when the user pulls the app back to the foreground.

```
ProgressView()
    .task(id: scenePhase) {
        do {
            if try await requestLocalNetworkAuthorization() {
                // Permission is granted, continue to next onboarding step
            } else {
                // Permission denied, explain why we need it and show button to open Settings
            }
        } catch {
            // Networking failure, handle error
        }
    }
```

When the user navigates away from this view the task will be cancelled that in turn will stop the `NWBrowser` and `NWListener`. When the scene phase changes the task will be cancelled and restarted, making sure we recheck if the permission is given when the user did go to settings and grant permission after all. 

## Wrap up

This gives us an easy to use API to get request the permission. The remaining limitation is that we can't silently check the permission without ever triggering the permission request towards to user. The request dialog does however only appear once, so if after you've asked for the first time you can use this function to check if you still have permission without the user being bothered.    

The complete implementation of the function described here, including comments, is available [in this gist](https://gist.github.com/mac-cain13/fa684f54a7ae1bba8669e78d28611784). 

<div class="not-prose flex space-x-4 border-2 border-orange-500 rounded-lg pl-4 pr-6 py-6 mt-8 -mb-6">
    <div class="flex-initial">
        <a href="/bezel?utm_source=nonstrict&utm_medium=blog&utm_content=request-and-check-for-local-network-permission" target="_blank"><img src="/images/bezel-icon.png" class="max-h-full max-w-10 m-0"></a>
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

- Nonstrict. (2024, March 29) [Function to request and check Local Network permission on iOS, iPadOS & visionOS](https://gist.github.com/mac-cain13/fa684f54a7ae1bba8669e78d28611784). GitHub Gist.
- Apple. (2023, October 12) [If an app would like to connect to devices on your local network](https://support.apple.com/en-us/102229). Apple Support.
- Apple. (2020, June 22-26). [Support local network privacy in your app.](https://developer.apple.com/videos/play/wwdc2020/10110/). WWDC20.
- vpoltave. (2020, September 17) [iOS 14 How to trigger Local Network dialog and check user answer?](https://stackoverflow.com/questions/63940427/ios-14-how-to-trigger-local-network-dialog-and-check-user-answer) StackOverflow.
- vossgang. (2020, June 24) [Network privacy permission check](https://developer.apple.com/forums/thread/650648). Apple Developer Forums.
- Quinn “The Eskimo!”. (2020, Oct 14). [Local Network Privacy FAQ](https://forums.developer.apple.com/forums/thread/663858). Apple Developer Forums.
