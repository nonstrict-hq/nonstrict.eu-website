# Changelog

### 0.62.0

- Swift: Add pause/resume support to recordings
- Swift: Add `RKDiscontinuationEvent` for tracking recording interruptions

### 0.61.0

- Improved state machine implementation in the `RKRecorder`

### 0.60.0

- Swift: Add `videoCodec` output options
- Swift: Fix sending annotations in concurrent iteration

### 0.59.1

- Swift: Add `ContentMode` option to `RKCameraPreview`

### 0.59.0

- Filter webcam formats to 420v and 420f for better compatibility

### 0.58.0

- Swift: Add `preserveActiveCameraConfiguration` option to webcam configuration
- Electron: Add `preserveActiveCameraConfiguration`, `leftAudioChannelOnly` and `audioDelay` fields in webcam configuration

### 0.57.0

- Fix crash in `MicrophonePowerMeter` with CamLink 4K microphone

### 0.56.2

- Improved logging about dropped sample buffers and active frame duration changes

### 0.56.1

- Improve camera format selection logic for better quality
- Swift: Add `symbolName` property to `RKDisplay`

### 0.55.0

- Avoid toggling Center Stage if control mode is set to user
- Improved logging

### 0.54.5

- Fix crash when `AVAudioFormat` initialization fails

### 0.54.4

- Fix crash in audio processing

### 0.54.3

- Fix audio stream buffer initialization issues

### 0.54.2

- Improve error messages when prepare or start fails
- Add MotivMix to the list of audio loopback apps
- Improved audio stream reliability

### 0.54.1

- Swift: Drop video frames when they arrive in the wrong order

### 0.54.0

- Swift: Improved audio timing accuracy during recordings

### 0.53.1

- Electron: Updated EventEmitter imports for better compatibility

### 0.53.0

- Electron: New streaming audio support for microphone, system audio, and application audio
- Electron: New `createWebAudioBuffer` helper function for converting audio streams
- Swift: Make microphone stream callback available

### 0.52.0

- Swift: Fix multithreading bug where audio could write to asset writer before it was started
- Swift: Add inline documentation improvements
- Electron: Add comprehensive documentation for Discovery, Permissions, and Recording Schemas

### 0.51.1

- Swift: Additional audio delay logging for debugging

### 0.51.0

- Swift: New `audioDelay` option for microphone recorder

### 0.50.0

- Swift: Beta implement system audio recording using Core Audio
- Electron: Add SystemAudio/ApplicationAudio recording

### 0.49.3

- Fixed for Xcode 26 beta 1 compatibility

### 0.49.2

- Fix documentation building issues

### 0.49.1

- Fix build with Xcode 16.4

### 0.49.0

- Video is now always recorded with first frame at time zero for better compatibility

### 0.48.2

- Fix audio recording issues with ScreenRecorder on Intel Macs
- Record desktop independent windows always at 2x resolution

### 0.48.1

- Make desktopIndependentWindow macOS 13.1+ only

### 0.48.0

- Swift: Add crop option to display recording.
- Keep Mac awake during a recording.
- Swift: `RKRunningApplication` now exposes the bundle identifier of the app.
- Add `videoDimensions` to the bundle format, deprecating `recordingScale`.
- Swift: Add support for recording a window independent of the desktop.

### 0.47.1

- Fix potential issue when recording microphones with more than 2 channels.

### 0.47.0

- Fix bug when recording left audio recording.
- Fix bug in input recorder when it's momentarily disabled by macOS.

### 0.46.0

- Fixes for `SCKAudioRecorder` on Intel Macs.

### 0.45.0

- Restart input recording when interrupted.
- Swift: Add `minimumFrameInterval` and `maxVideoDimensions` options to screen and webcam recorders.
- Swift: Add the option to record the mic left channel only
- Prevent webcam from changing it's resolution unexpectedly.

### 0.44.0

- Fixed an issue M4A files didn't have the correct container format.

### 0.43.0

- Enable segmented file recording for audio recorders.
- Workaround for non-working Studio Display camera in `RKCameraPreview`

### 0.42.0

- `RKDisplay` identifier changed to prevent collisions.
- Include device name in error message where relevant.
- Fixed a multithreading issue in the recorder.

### 0.41.0 

- Exclude Apples TipKit view when `screenRecordingIndicator` exclude option is used.

### 0.40.0

- Added low disk space error to `SCKAudioRecorder`.
- Swift: Added option to exclude specific processes from screen recordings.

### 0.39.0

- Swift: Improve performance of switching cameras in `RKCameraPreview`.
- Swift: Improve performance of switching microphones in `MicrophonePowerMeter`.

### 0.38.0

- Major performance improvements in top window tracking.

### 0.37.3

- Prefixed all Objective-C code with `RK` to avoid name collisions.

### 0.37.0

- Additional minor logging improvements.

### 0.36.0

- Improved logging.
- Improve window tracking when new windows are created.

### 0.35.0

- Fix correctly stopping input event capturing once a recording is stopped.
- Fix incorrectly aborting the recording when using input recording.

### 0.34.0

- Reduce CPU usage when window discovery isn't used anymore.
- Fix memory leak in JSON writer.

### 0.33.0

- Prevent memory load in macOS 13 when using segmented file output.
- Added window title change tracking.
- Swift: Only trigger camera prompt when preview is visible

### 0.32.0 

- Improved audio recording reliability.

### 0.31.0

- Swift: Add `accessibilityProcessTrusted` to `RKAuthorizationStatus`
- Minor top window tracking improvements.

### 0.30.0

- Swift: Allow custom content in `RKCameraPreview`.
- Fixed memory leak while capturing user input.
- Performance improvements in top window tracking.

### 0.29.0

- Fix possibly incorrect `recordingSize` in RKBundleInfo.
- Fixed an ordering issue in the top window detection.

### 0.28.0

- Added `recordingSize` & `recordingScale` to the recordkit.json file.

### 0.27.0

- Swift: Update `RKMicrophonePreview`, only render when window is visible on screen.
- Swift: Add `promptForAuthorization` option to `RKCameraPreview`.

### 0.26.0

- Improved top window detection logic.

### 0.25.0

- Swift: Microphone preview support, monitoring power levels.
- Swift: Use cameraID in `RKCameraPreview`.

### 0.24.1

- Swift: Fixes `RKCameraPreview` background color and start/stop behaviour.

### 0.24.0

- Swift: Renamed `RKAuthorizationStatus` to `RKAuthorization`.
- Made streaming JSON writing atomic to be more robust in case of a crash.
- Renamed `RKWindow` `onlyOnScreen` filter option to `allOnScreen`.

### 0.23.0

- Fixed an issue where tracking the top window didn't always correctly stop.

### 0.22.0

- SwiftUI: Improve display highlighting.

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
