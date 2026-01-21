# What is RecordKit?

RecordKit is a screen recording SDK for macOS apps. It enables simultaneous recording of screen, system audio, camera, microphone, mouse and keyboard. Output includes easy-to-process video and JSON files.

::: tip
Just want to try it out? Skip to the [Product Demo](/product-demo).
:::

## Use Cases

**AI meeting notes & assistants** — Build apps like Granola or Otter that record meetings for AI transcription and summarization. Capture screen context alongside microphone and system audio to help AI understand what's being discussed.

**Video messaging & product demos** — Build apps like Loom or ScreenFlow. RecordKit handles the recording complexity so you can focus on your product's unique value.

**Support & QA recordings** — Add screen recording to capture bug reports or user sessions. A short video often tells you more than a written description.

## Why RecordKit?

### Battle-Tested

Recording on macOS is full of edge cases. RecordKit handles them so you don't have to discover them yourself. Tested across multiple production apps, it saves you months of foundational work.

### Native Performance

RecordKit uses Apple's ScreenCaptureKit, AVFoundation and CoreMedia directly. For Electron apps, we bypass the browser entirely and call native macOS APIs. No browser limitations.

### Clear Errors and Statuses

The SDK provides detailed, user-friendly errors for common issues. Whether ScreenCaptureKit fails to start or a microphone is silent because the MacBook lid is closed, RecordKit reports a [clear status](/guides/logging-and-errors#error-handling) you can show in your UI.

### Simple Integration

- **Modern APIs** — Swift Package with SwiftUI and async/await support. Full TypeScript definitions for Electron.
- **Standard output** — MP4 video and JSON files by default. Easy to process with your existing pipeline. See [Output Formats](/guides/output-formats).
- **Sensible defaults** — Get started quickly with minimal configuration, then customize as needed.
