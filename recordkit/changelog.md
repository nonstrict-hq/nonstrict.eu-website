# Changelog

### 0.21.0

- Clearer logs when discovery of Apple devices fails.
- Swift: Improved the API around authorization status.

### 0.20.0

- Added `RKCameraPreview` to preview a camera in SwiftUI.
- Apple device recordings now also capture audio from the device.
- Recorder is more robust when prepare/start/stop are called multiple times.
- The start method on a recorder can now throw an error if something fails.
- Improved precision of recorder start/stop.
- Improved window filtering when listing available windows.
- Improved resillience of all audio recorders when audio gaps occur.
- Segmented output now has correct video dimensions for Apple device recordings.
- Improved error messages through the SDK.
- Improved log messages through the SDK.
- Swift: Options to exclude windows when recording a display.
- Swift: Improved device discovery API.
- Swift: Ability to store/retrieve prefered microphone, camera and display.

### 0.19.0

- Electron: Add option to receive RecordKit logs through `recordkit.on('log', (logEvent) => { })`.

### 0.18.1

- Fixed missing types from API documentation.

### 0.18.0

- Added support for segmented media streams (HLS) output.

### 0.17.0

- Improved output file when screen recording starts or ends with static video.
- Electron: Add option to set log level per category.

### 0.16.0

- Electron: Log RecordKit log message to console.
- Electron: Add option to set log level for RecordKit.
- Improved stability of `RKRecorder.getWindows`.

### 0.15.1

- Fix: Occasional crash when starting multiple keyboard recorders after each other.

### 0.15.0

- Electron: Add explicit cancel method on Recorder.
- Support for mp4 and mov video container file types.

### 0.14.0

- Fix: Issue where preferred microphone would sometime return no microphone.

### 0.13.0

- Added additional debug logging around discovered devices.
- Fixed a potential deadlock.

### 0.12.1

- Resolved an issue preventing some camera and screen recordings from finalizing.

### 0.12.0

- New `allowFrameReordering` setting on recorder to disable generation of B-frames in output files.
- Length of recorded videos is much more accurate to the start/stop of the recorder.
- Several thread safety improvements.
- Swift: New `RKSources` property wrapper to discover recording sources like microphones.
- Swift: New `RKMicrophone` (async) discovery methods `microphone` and `updates`.
- Swift: New `RKMicrophone.preferred` property to get the preferred microphone.
- Swift: New `RKUserPreferred` class to manage and access preferred recording sources.
- Swift: Removed `RKRecorder.Scheme` the API; Use the `RKRecorder` initializer that takes `[RKRecorder.SchemaItem]` instead.
- Electron: Updated availability type information for several recording sources.

### 0.11.0

- Swift: Add RKSources property wrapper to list available recording sources

### 0.10.0

- Swift: Add System Audio recorder

### 0.9.0

- Swift: Add Display recorder
- Swift: Add Microphone recorder
- Swift: `RKRecorderScheme` has been renamed `RKRecorder.Scheme`

### 0.8.1

- Fix: Don't show window sharing indicator in WindowBasedCrop recorder

### 0.8.0

- Fix: Other windows are no longer being recorded in WindowBasedCrop recorder

### 0.7.0

- Add support keyboard input recording

### 0.6.0

- The cursor type is now recorded when mouse events are being captured
- Correctly close connection to iPhone/iPad when recording is stopped

### 0.5.1

- Minor documentation improvements

### 0.5.0

- Add support for recording iPads (without support for rotation during the recording)

### 0.4.0

- Electron: Live camera preview is supported

### 0.3.4

- Reduced the amount of calls to ScreenCaptureKit, improving performance
- Improved error reporting when external devices fail to initialize

### 0.3.3

- Cleaned up log messages
- Fix timeout errors not immediatly being thrown
- Cancel internal tasks correctly when they time out

### 0.3.2

- Electron: Fix issue where RecordKit stopped responding when a 3rd party webcam wrote to the error output
- Swift: RecordKit is now available as SPM package

### 0.3.1

- Electron: Group types logically in API documentation
- Electron: Remove internal types from API documentation

### 0.3.0

- First publicly available release
