---
date: 2026-01-29 12:00
authors: tom, mathijs
tags: Engineering
title: Designing Swift Errors for an SDK
description: Errors designed for an SDK are different than errors for an app, because errors become API contracts. We describe the pattern we use in RecordKit.
image: images/blog/getty-images-FzI8zLShs_M-unsplash.jpg
path: 2026/designing-swift-errors-for-an-sdk
featured: true
---

**tldr; In an SDK, errors become part of your public API. We use a struct with an inner Code enum to provide stable error codes and flexible messages.**

In our [previous post](/blog/2026/the-four-audiences-of-swift-errors) we described how errors serve four audiences: end users need readable messages, runtime code needs to branch on error types, developers debugging need clear output, and monitoring systems need stable codes. We recently overhauled errors in [RecordKit](https://nonstrict.eu/recordkit/), our macOS recording SDK, and needed to support a fifth audience: app developers using the SDK.

## The Fifth Audience: SDK Users

SDK users need to catch errors, show messages to their users, and log to their own monitoring systems. They can't look inside the SDK to understand what went wrong. This makes errors part of the public API. Changing an error code in an SDK update breaks the error handling and monitoring systems of everyone using it.

SDK users also need rich error messages. In an app, “Device unavailable” might be enough because the developer can look at the code to understand what happened. SDK users can't do that. They need “Camera 'FaceTime HD' is in use by another application” to understand what's wrong and communicate it to their users.

## The Pattern

For apps, Int-backed enums with `LocalizedError` and `CustomNSError` work well. For SDKs, we use a struct conforming to four protocols, with an inner Int-backed Code enum:

```swift
public struct MySDKError: Error, LocalizedError, CustomDebugStringConvertible, CustomNSError {
    public enum Code: Int {
        case invalidConfiguration = -1001
        case permissionDenied = -1002
        case deviceUnavailable = -1003
        case recordingFailed = -1004
    }

    public let code: Code
    private let _localizedDescription: String
    private let _userInfo: [String: Any]

    internal init(code: Code, localizedDescription: String, userInfo: [String: Any] = [:]) {
        self.code = code
        self._localizedDescription = localizedDescription
        self._userInfo = userInfo
    }

    // MARK: LocalizedError

    public var errorDescription: String? { _localizedDescription }

    // MARK: CustomDebugStringConvertible

    public var debugDescription: String { "MySDKError.\(code)" }

    // MARK: CustomNSError

    public static let errorDomain = "MySDKError"
    public var errorCode: Int { code.rawValue }
    public var errorUserInfo: [String: Any] { _userInfo }
}
```

The struct conforms to `Error` to make it throwable. `LocalizedError` provides the user-facing message via `errorDescription`. `CustomDebugStringConvertible` ensures `print(error)` outputs `MySDKError.permissionDenied` instead of a struct dump with module paths. `CustomNSError` provides the stable domain and code for monitoring systems.

To make catching specific errors easier, we add static properties and a pattern matching operator:

```swift
extension MySDKError {
    public static let permissionDenied = MySDKError(code: .permissionDenied, localizedDescription: "Device access denied")
    public static let deviceUnavailable = MySDKError(code: .deviceUnavailable, localizedDescription: "Device unavailable")
    // ... other cases

    public static func ~= (pattern: MySDKError, value: any Error) -> Bool {
        guard let value = value as? MySDKError else { return false }
        return pattern.code == value.code
    }
}
```

Inside the SDK, these static properties are not used to throw. Instead we construct the error with more context, and throw that:

```swift
// Customized localized description
throw MySDKError(
    code: .permissionDenied,
    localizedDescription: "Microphone access required")
// Include custom userInfo entries
throw MySDKError(
    code: .deviceUnavailable,
    localizedDescription: "Camera 'FaceTime HD' is in use",
    userInfo: ["deviceID": cameraID])
```

The static properties enable direct pattern matching in catch blocks:

```swift
do {
    try recorder.start()
} catch MySDKError.permissionDenied {
    requestPermission()
} catch MySDKError.deviceUnavailable {
    showDeviceSelector()
} catch let error as MySDKError {
    showAlert(error.localizedDescription)
}
```

## What SDK Users Get

With this pattern, SDK users can forward errors to all four audiences without any extra work:

```swift
let error = MySDKError(code: .deviceUnavailable, localizedDescription: "Camera 'FaceTime HD' is in use")

// For their end users, a clear localized message:
error.localizedDescription  // "Camera 'FaceTime HD' is in use"

// For their error handling code, pattern matching on the code:
error.code == .deviceUnavailable  // true

// For debugging, a clean print output:
print(error)  // "MySDKError.deviceUnavailable"

// For their monitoring systems, stable domain and code:
(error as NSError).domain  // "MySDKError"
(error as NSError).code    // -1003
```

## Why This Pattern

**Why a struct instead of an enum?** Enums have fixed messages per case. A struct lets us pass context at the throw site: “Camera 'FaceTime HD' is in use by another application is more helpful than “Device unavailable”. The inner Code enum provides stable codes for pattern matching; the struct provides flexible messages.

**Why a single error type?** From the consumer's perspective, an SDK is a single entity. Errors from RecordKit are `RKError`, not `RKFileSystemError` or `RKDeviceError`. Internal module boundaries shouldn't leak into the public API.

## Conclusion

This pattern requires more work than a simple enum. We maintain the struct, the Code enum, the static properties for pattern matching, and the protocol conformances. For an app, that would be overkill.

For an SDK, errors are part of the public contract. We're thoughtful about public API anyway, and errors deserve the same care. The payoff is that SDK users get errors they can catch cleanly, messages they can display directly, and codes that stay stable across updates.

## References

- Apple. [LocalizedError Protocol](https://developer.apple.com/documentation/foundation/localizederror). Apple Developer Documentation.
- Apple. [CustomNSError Protocol](https://developer.apple.com/documentation/foundation/customnserror). Apple Developer Documentation.
- Doug Gregor, Charles Srstka. (2016). [SE-0112: Improved NSError Bridging](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0112-nserror-bridging.md). Swift Evolution.
