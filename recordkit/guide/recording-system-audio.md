# How to Record System Audio

This guide provides an overview of how to record system audio, both system wide aswell as only recording a single application.

::: tip 💁 Also want to record the screen?
The [Screen Recording Guide](screen-recording) is recommended if you want to record both the screen and application or system audio at the same time.
:::

::: details Starting from scratch?
#### Create a new project (Optional)
1. Start [Xcode](https://developer.apple.com/xcode/) choose "Create New Project..." from the launch screen.
2. Choose macOS, select App and click Next. 
3. Make sure to choose SwiftUI as interface setting and Swift for the language.

Now you have a project you can bontinue with the steps below for existing projects.

<br />

#### Add RecordKit to an existing project

RecordKit for Swift is installed as a SPM (Swift Package Manager) package.

1. Choose File, Add Package Dependencies...
2. Enter the RecordKit package URL in the search field top right: `https://github.com/nonstrict-hq/RecordKit`
3. Select RecordKit from the list and choose Add Package.

Make sure the RecordKit library is added to your macOS app target.
:::

## Recording All System Audio

Setup a recorder as usual and add the `systemAudio` item to record all system audio. Here's an example:

```swift{3}
// Configure the recorder
let recorder = RKRecorder(schema: RKRecorderSchema(items: [
        .systemAudio()
    ])) { _ in }

// The recorder is now ready to use:
try await recorder.prepare() // Warm up devices & check permissions
recorder.start() // Capturing starts
try await Task.sleep(.seconds(10)) // Record for some time
let result = try await recorder.stop() // Finish the recording
print(result) // Information about the recording
```

::: tip 💁 Some apps are not recorded by default
Audio from your own process as well as audio from apps that are known to loop audio, like Rogue Amoeba Loopback and RØDE audio software, are excluded from the recording by default.

If you do need to record those apps, pass your own exclude options to `systemAudio`.
:::

## Excluding a Specific App

🚧 Support for excluding a specific app from the recording will be added to a future version of RecordKit.

## Recording a Single App

🚧 Support for recording a single app will be added to a future version of RecordKit.
