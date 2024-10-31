# Changelog

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
